#! /bin/bash

DB_VERSION=$1
PG_USER=$2
DB_NAME=$DB_VERSION

SCRIPTS=$(find -name "*.sql" -printf "\\\i %h/%f\\n" | sort)
SCRIPT=create.psql
rm -rf "$SCRIPT"

cat << EOF > "$SCRIPT"
$SCRIPTS
EOF
cat "$SCRIPT"
echo -e "Update db $DB_VERSION ($(wc -l $SCRIPT | cut -d' ' -f1) scripts)"
echo -e "Update started at $(date)"
PGOPTIONS='--client-min-messages=warning' psql --single-transaction --quiet --echo-errors --username="$PG_USER" --dbname="$DB_NAME" --set=ON_ERROR_STOP=on --file="$SCRIPT"
echo -e "Update ended at $(date)"
rm -rf "$SCRIPT"