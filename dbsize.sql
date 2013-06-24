spool dbsize_output.txt
set serveroutput on
Declare

  ddf Number:= 0;
  dtf Number:= 0;
  log_bytes Number:= 0;
  total Number:= 0;

BEGIN
  select sum(bytes)/power(1024,3) into ddf from dba_data_files;
  select sum(bytes)/power(1024,3) into dtf from dba_temp_files;
  select sum(bytes)/power(1024,3) into log_bytes from v$log;

  total:= round(ddf+dtf+log_bytes, 3);
  dbms_output.put_line('TOTAL DB Size is: '||total||'GB ');
END;
/
spool off;
exit;

 spool dbsize_output.txt
set serveroutput on
Declare

  ddf Number:= 0;
  dtf Number:= 0;
  log_bytes Number:= 0;
  total Number:= 0;

BEGIN
  select sum(bytes)/power(1024,3) into ddf from dba_data_files;
  select sum(bytes)/power(1024,3) into dtf from dba_temp_files;
  select sum(bytes)/power(1024,3) into log_bytes from v$log;

  total:= round(ddf+dtf+log_bytes, 3);
  dbms_output.put_line('TOTAL DB Size is: '||total||'GB ');
END;
/
spool off;
