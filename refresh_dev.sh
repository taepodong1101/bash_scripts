#!/bin/bash


#generate latest backup
/home/ai/scripts/backup_exp.sh



BACKUP_DEST=/home/ai/schemabackup
export BACKUP_DEST

cd $BACKUP_DEST

DMP_FILE=$(ls -t *.dmp | head -1)
export DMP_FILE


sqlplus / as sysdba <<EOF
DROP USER MY_SCHEMA CASCADE;
CREATE USER MY_SCHEMA IDENTIFIED BY abc123 DEFAULT TABLESPACE TBSPACE;
ALTER USER MY_SCHEMA QUOTA UNLIMITED ON TBSPACE;

GRANT RESOURCE, CREATE SESSION, CREATE VIEW TO MY_SCHEMA;
Grant execute on UTL_HTTP to MY_SCHEMA;
GRANT execute on DBMS_CRYPTO TO MY_SCHEMA;
GRANT IMP_FULL_DATABASE TO MY_SCHEMA;
EXIT;
EOF

imp system/$DB_PASS fromuser=SOURCE_SCHEMA touser=MY_SCHEMA file=$DMP_FILE log=refresh_`date +'%Y%m%d-%H%M'`.log

sqlplus / as sysdba <<EOF
exec dbms_utility.compile_schema('MY_SCHEMA');
exit;
EOF

# Give grants from SOURCE_SCHEMA to MY_SCHEMA'S objects
sqlplus / as sysdba <<EOF
@/home/ai/scripts/grant_readonly_access.sql
exit;
EOF

#added 11-3-2013 remove export file after refresh is complete.
cd $BACKUP_DEST && rm $DMP_FILE
