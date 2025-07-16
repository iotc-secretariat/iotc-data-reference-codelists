-- An audit history is important on most tables. Provide an audit trigger that logs to
-- a dedicated audit table for the major relations.
--
-- This file should be generic and not depend on application roles or structures,
-- as it's being listed here:
--
--    https://wiki.postgresql.org/wiki/Audit_trigger_91plus
--
-- This trigger was originally based on
--   http://wiki.postgresql.org/wiki/Audit_trigger
-- but has been completely rewritten.
--
-- Audited data. Lots of information is available, it's just a matter of how much
-- you really want to record. See:
--
--   http://www.postgresql.org/docs/9.1/static/functions-info.html
--
-- Remember, every column you add takes up more audit table space and slows audit
-- inserts.
--
-- Every index you add has a big impact too, so avoid adding indexes to the
-- audit table unless you REALLY need them. The json GIN/GIST indexes are
-- particularly expensive.
--
-- It is sometimes worth copying the audit table, or a coarse subset of it that
-- you're interested in, into a temporary table where you CREATE any useful
-- indexes and do your analysis.
--
DROP TABLE IF EXISTS refs_admin.history;
CREATE TABLE refs_admin.history (
event_id bigserial primary key,
schema_name text not null,
table_name text not null,
relid oid not null,
session_user_name text,
action_tstamp_tx TIMESTAMP WITH TIME ZONE NOT NULL,
action_tstamp_stm TIMESTAMP WITH TIME ZONE NOT NULL,
action_tstamp_clk TIMESTAMP WITH TIME ZONE NOT NULL,
transaction_id bigint,
application_name text,
client_addr inet,
client_port integer,
client_query text,
action TEXT NOT NULL CHECK (action IN ('I', 'D', 'U', 'T')),
row_data jsonb,
changed_fields jsonb,
statement_only boolean not null,
row_id VARCHAR(50),
doi VARCHAR(512) DEFAULT '10.5281/zenodo.15743875',
doi_version VARCHAR(512)
);
REVOKE ALL ON refs_admin.history FROM public;
COMMENT ON TABLE refs_admin.history IS 'History of auditable actions on audited tables, from refs_admin.if_modified_func()';
COMMENT ON COLUMN refs_admin.history.event_id IS 'Unique identifier for each auditable event';
COMMENT ON COLUMN refs_admin.history.schema_name IS 'Database schema audited table for this event is in';
COMMENT ON COLUMN refs_admin.history.table_name IS 'Non-schema-qualified table name of table event occured in';
COMMENT ON COLUMN refs_admin.history.relid IS 'Table OID. Changes with drop/create. Get with ''tablename''::regclass';
COMMENT ON COLUMN refs_admin.history.session_user_name IS 'Login / session user whose statement caused the audited event';
COMMENT ON COLUMN refs_admin.history.action_tstamp_tx IS 'Transaction start timestamp for tx in which audited event occurred';
COMMENT ON COLUMN refs_admin.history.action_tstamp_stm IS 'Statement start timestamp for tx in which audited event occurred';
COMMENT ON COLUMN refs_admin.history.action_tstamp_clk IS 'Wall clock time at which audited event''s trigger call occurred';
COMMENT ON COLUMN refs_admin.history.transaction_id IS 'Identifier of transaction that made the change. May wrap, but unique paired with action_tstamp_tx.';
COMMENT ON COLUMN refs_admin.history.client_addr IS 'IP address of client that issued query. Null for unix domain socket.';
COMMENT ON COLUMN refs_admin.history.client_port IS 'Remote peer IP port address of client that issued query. Undefined for unix socket.';
COMMENT ON COLUMN refs_admin.history.client_query IS 'Top-level query that caused this auditable event. May be more than one statement.';
COMMENT ON COLUMN refs_admin.history.application_name IS 'Application name set when this audit event occurred. Can be changed in-session by client.';
COMMENT ON COLUMN refs_admin.history.action IS 'Action type; I = insert, D = delete, U = update, T = truncate';
COMMENT ON COLUMN refs_admin.history.row_data IS 'Record value. Null for statement-level trigger. For INSERT this is the new tuple. For DELETE and UPDATE it is the old tuple.';
COMMENT ON COLUMN refs_admin.history.changed_fields IS 'New values of fields changed by UPDATE. Null except for row-level UPDATE events.';
COMMENT ON COLUMN refs_admin.history.statement_only IS '''t'' if audit event is from an FOR EACH STATEMENT trigger, ''f'' for FOR EACH ROW';
COMMENT ON COLUMN refs_admin.history.doi IS 'The ''DOI'' linked to this modification';
COMMENT ON COLUMN refs_admin.history.doi_version IS 'The version of the ''DOI'' linked to this modification';
COMMENT ON COLUMN refs_admin.history.statement_only IS '''t'' if audit event is from an FOR EACH STATEMENT trigger, ''f'' for FOR EACH ROW';
CREATE INDEX history_relid_idx ON refs_admin.history(relid);
CREATE INDEX history_action_tstamp_tx_stm_idx ON refs_admin.history(action_tstamp_stm);
CREATE INDEX history_action_idx ON refs_admin.history(action);
CREATE OR REPLACE FUNCTION refs_admin.if_modified_func() RETURNS TRIGGER AS $body$
DECLARE
    audit_row refs_admin.history;
    include_values boolean;
    log_diffs boolean;
    h_old jsonb;
    h_new jsonb;
    excluded_cols text [] = ARRAY []::text [];
    pk_columns text [] = ARRAY []::text [];
    pk_values text ;
    _col_value text ;
    a text ;
    BEGIN IF TG_WHEN <> 'AFTER' THEN RAISE EXCEPTION 'refs_admin.if_modified_func() may only run as an AFTER trigger';
END IF;
pk_values ='';
IF TG_ARGV [1] IS NOT NULL THEN pk_columns = TG_ARGV [1]::text []; ELSE pk_columns = ARRAY ['code']::text [];
END IF;
    RAISE NOTICE 'pk_columns: %', pk_columns;
    FOREACH a IN ARRAY pk_columns LOOP
        EXECUTE format('SELECT ($1).%s::text', a) USING OLD INTO _col_value;
        pk_values = pk_values || ',' || COALESCE(_col_value, NULL) ;
        end loop;
pk_values = substring(pk_values, 2);
    RAISE NOTICE 'pk_values: %', pk_values;
audit_row = ROW(
    nextval('refs_admin.history_event_id_seq'),
    -- event_id
    TG_TABLE_SCHEMA::text,
    -- schema_name
    TG_TABLE_NAME::text,
    -- table_name
    TG_RELID,
    -- relation OID for much quicker searches
    session_user::text,
    -- session_user_name
    current_timestamp,
    -- action_tstamp_tx
    statement_timestamp(),
    -- action_tstamp_stm
    clock_timestamp(),
    -- action_tstamp_clk
    txid_current(),
    -- transaction ID
    current_setting('application_name'),
    -- client application
    inet_client_addr(),
    -- client_addr
    inet_client_port(),
    -- client_port
    current_query(),
    -- top-level query or queries (if multistatement) from client
    substring(TG_OP, 1, 1),
    -- action
    NULL,
    NULL,
    -- row_data, changed_fields
    'f', -- statement_only,
    pk_values -- pk ID of the row
);
IF NOT TG_ARGV [0]::boolean IS DISTINCT
FROM 'f'::boolean THEN audit_row.client_query = NULL;
END IF;
IF TG_ARGV [2] IS NOT NULL THEN excluded_cols = TG_ARGV [2]::text [];
END IF;

IF (
    TG_OP = 'UPDATE'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(OLD)::JSONB - excluded_cols;
--Computing differences
SELECT jsonb_object_agg(tmp_new_row.key, tmp_new_row.value) AS new_data INTO audit_row.changed_fields
FROM jsonb_each_text(row_to_json(NEW)::JSONB) AS tmp_new_row
    JOIN jsonb_each_text(audit_row.row_data) AS tmp_old_row ON (
        tmp_new_row.key = tmp_old_row.key
        AND tmp_new_row.value IS DISTINCT
        FROM tmp_old_row.value
    );
IF audit_row.changed_fields = '{}'::JSONB THEN -- All changed fields are ignored. Skip this update.
RETURN NULL;
END IF;
ELSIF (
    TG_OP = 'DELETE'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(OLD)::JSONB - excluded_cols;
ELSIF (
    TG_OP = 'INSERT'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(NEW)::JSONB - excluded_cols;
ELSIF (
    TG_LEVEL = 'STATEMENT'
    AND TG_OP IN ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE')
) THEN audit_row.statement_only = 't';
ELSE RAISE EXCEPTION '[refs_admin.if_modified_func] - Trigger func added as trigger for unhandled case: %, %',
TG_OP,
TG_LEVEL;
RETURN NULL;
END IF;
INSERT INTO refs_admin.history(event_id, schema_name, table_name, relid, session_user_name, action_tstamp_tx, action_tstamp_stm, action_tstamp_clk, transaction_id, application_name, client_addr, client_port, client_query, action, row_data, changed_fields, statement_only, row_id)
VALUES (audit_row.event_id, audit_row.schema_name, audit_row.table_name, audit_row.relid, audit_row.session_user_name, audit_row.action_tstamp_tx, audit_row.action_tstamp_stm, audit_row.action_tstamp_clk, audit_row.transaction_id, audit_row.application_name, audit_row.client_addr, audit_row.client_port, audit_row.client_query, audit_row.action, audit_row.row_data, audit_row.changed_fields, audit_row.statement_only, audit_row.row_id);
RETURN NULL;
END;
$body$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = pg_catalog,
    public;
COMMENT ON FUNCTION refs_admin.if_modified_func() IS $body$ Track changes to a table at the statement
and /
or row level.Optional parameters to trigger in CREATE TRIGGER call: param 0: boolean,
whether to log the query text.Default 't'.param 1: text [],
columns to ignore in updates.Default [].Updates to ignored cols are omitted
from changed_fields.Updates with only ignored cols changed are not inserted into the audit log.Almost all the processing work is still done for updates that ignored.If you need to save the load,
    you need to use
    WHEN clause on the trigger instead.No warning
    or error is issued if ignored_cols contains columns that do not exist in the target table.This lets you specify a standard
set of ignored columns.There is no parameter to disable logging of
values.
Add this trigger as a 'FOR EACH STATEMENT' rather than 'FOR EACH ROW' trigger if you do not want to log row
values.Note that the user name logged is the login role for the session.The audit trigger cannot obtain the active role because it is reset by the SECURITY DEFINER invocation of the audit trigger its self.$body$;
DROP FUNCTION IF EXISTS refs_admin.audit_table(regclass, boolean, boolean, boolean, text []);
DROP FUNCTION IF EXISTS refs_admin.audit_table(regclass, boolean, boolean, boolean);
DROP FUNCTION IF EXISTS refs_admin.audit_table(regclass, boolean);
DROP FUNCTION IF EXISTS refs_admin.audit_table(regclass);
DROP FUNCTION IF EXISTS refs_admin.audit_table(regclass, boolean, boolean, boolean, text [], text[]);
CREATE OR REPLACE FUNCTION refs_admin.audit_table(
        target_table regclass,
        audit_rows boolean,
        audit_query_text boolean,
        audit_inserts boolean,
        pk_cols text [],
        ignored_cols text []
    ) RETURNS void AS $body$
DECLARE stm_targets text = 'INSERT OR UPDATE OR DELETE OR TRUNCATE';
_q_txt text;
_ignored_cols_snip text = '';
_pk_cols text = '';
BEGIN PERFORM refs_admin.deaudit_table(target_table);
IF array_length(pk_cols, 1) > 0 THEN _pk_cols = quote_literal(pk_cols); ELSE _pk_cols= quote_literal('{code}'); END IF;

IF audit_rows THEN IF array_length(ignored_cols, 1) > 0 THEN _ignored_cols_snip = ', ' || quote_literal(ignored_cols); ELSE _ignored_cols_snip = ',' || quote_literal('{}');
END IF;
_q_txt = 'CREATE TRIGGER audit_trigger_row AFTER ' || CASE
    WHEN audit_inserts THEN 'INSERT OR '
    ELSE ''
END || 'UPDATE OR DELETE ON ' || target_table || ' FOR EACH ROW EXECUTE PROCEDURE refs_admin.if_modified_func(' || quote_literal(audit_query_text) || ',' || _pk_cols || _ignored_cols_snip  || ');';
RAISE NOTICE '%',
_q_txt;
EXECUTE _q_txt;
stm_targets = 'TRUNCATE';
ELSE
END IF;
_q_txt = 'CREATE TRIGGER audit_trigger_stm AFTER ' || stm_targets || ' ON ' || target_table || ' FOR EACH STATEMENT EXECUTE PROCEDURE refs_admin.if_modified_func(' || quote_literal(audit_query_text) || ',' || _pk_cols || ');';
RAISE NOTICE '%',
_q_txt;
EXECUTE _q_txt;
END;
$body$ language 'plpgsql';
COMMENT ON FUNCTION refs_admin.audit_table(regclass, boolean, boolean, boolean, text [], text[]) IS $body$
Add auditing support to a table.Arguments: target_table: Table name,
    schema qualified if not on search_path audit_rows: Record each row change,
    or only audit at a statement level audit_query_text: Record the text of the client query that triggered the audit event ? audit_inserts: Audit
insert statements
    or only updates / deletes / truncates ? ignored_cols: Columns to exclude
from
update diffs,
    ignore updates that change only ignored cols.$body$;
CREATE OR REPLACE FUNCTION refs_admin.deaudit_table(target_table regclass) RETURNS void AS $body$ BEGIN EXECUTE 'DROP TRIGGER IF EXISTS audit_trigger_row ON ' || target_table;
EXECUTE 'DROP TRIGGER IF EXISTS audit_trigger_stm ON ' || target_table;
END;
$body$ language 'plpgsql';
COMMENT ON FUNCTION refs_admin.deaudit_table(regclass) IS $body$ Remove auditing support to the given table.$body$;
CREATE OR REPLACE VIEW refs_admin.tableslist AS
SELECT DISTINCT triggers.trigger_schema AS schema,
    triggers.event_object_table AS auditedtable
FROM information_schema.triggers
WHERE triggers.trigger_name::text IN (
        'audit_trigger_row'::text,
        'audit_trigger_stm'::text
    )
ORDER BY schema,
    auditedtable;
COMMENT ON VIEW refs_admin.tableslist IS $body$ View showing all tables with auditing
set up.Ordered by schema,
    then table.$body$;