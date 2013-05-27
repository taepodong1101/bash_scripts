ORACLE_BASE=/u01/app/oracle
export ORACLE_BASE
ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_HOME
ORACLE_SID=XE
export ORACLE_SID
PATH=$ORACLE_HOME/bin:$PATH
export PATH

BKUP_DEST=/home/rode/cbackups
find $BKUP_DEST -name 'backup*.dmp' -mtime +10 -exec rm {} \;



cd /home/rode/cbackups && /u01/app/oracle/product/11.2.0/xe/bin/exp schema/password FILE=backup_`date +'%Y%m%d-%H%M'`.dmp
