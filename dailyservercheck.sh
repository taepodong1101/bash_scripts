DATESTAMP=`date +'%Y%m%d-%H%M'`
export DATESTAMP

touch /scripts/healthcheck.txt

cat /dev/null > /scripts/healthcheck.txt

# disk space
echo File system utilization: >> /scripts/healthcheck.txt
df -h > /scripts/healthcheck.txt

# Backup directory sizes
echo " "  >> /scripts/healthcheck.txt
echo Backup Directory Sizes: >> /scripts/healthcheck.txt
du -sh /backup/* >> /scripts/healthcheck.txt

echo " "  >> /scripts/healthcheck.txt

# Free memory
echo Free memory level: >> /scripts/healthcheck.txt
free -m >> /scripts/healthcheck.txt



# Added 20130624 - to monitor dbize

sqlplus / as sysdba <<EOF
@/scripts/dbsize.sql
exit;
EOF

echo " " >> /scripts/healthcheck.txt
echo " " >> /scripts/healthcheck.txt
cat /scripts/dbsize_output.txt >> /scripts/healthcheck.txt

rm /scripts/dbsize_output.txt

mailx -s "Server Check- $DATESTAMP" receipient@email.com < /scripts/healthcheck.txt
