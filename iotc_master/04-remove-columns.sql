-- END TRANSACTION;
-- BEGIN TRANSACTION;
drop view refs_socio_economics.v_countries_currencies CASCADE ;
create view refs_socio_economics.v_countries_currencies(country_code, country_name, currency_code, currency_name) as
    SELECT currencies.country_code,
           countries.name_en AS country_name,
           currencies.currency_code,
           currencies.currency_name
    FROM refs_socio_economics.currencies
             JOIN refs_admin.countries ON currencies.country_code = countries.code_iso3;
ALTER TABLE refs_admin.countries DROP COLUMN list_name_en;
ALTER TABLE refs_admin.countries DROP COLUMN list_name_fr;
ALTER TABLE refs_admin.ports DROP COLUMN creation_date;
ALTER TABLE refs_admin.ports DROP COLUMN update_date;
ALTER TABLE refs_admin.ports DROP COLUMN remarkable;
ALTER TABLE refs_admin.ports DROP COLUMN remarks;
ALTER TABLE refs_admin.ports DROP COLUMN comment;
-- ALTER TABLE refs_admin.ports DROP COLUMN id;
ALTER TABLE refs_admin.entities DROP COLUMN list_name_en;
ALTER TABLE refs_admin.entities DROP COLUMN list_name_fr;
ALTER TABLE refs_biological.incidental_captures_conditions DROP COLUMN creation_date;
ALTER TABLE refs_biological.incidental_captures_conditions DROP COLUMN id;
ALTER TABLE refs_biological.scars DROP COLUMN creation_date;
ALTER TABLE refs_biological.scars DROP COLUMN id;
ALTER TABLE refs_fishery.activities DROP COLUMN creation_date;
ALTER TABLE refs_fishery.activities DROP COLUMN id;
-- COMMIT TRANSACTION;