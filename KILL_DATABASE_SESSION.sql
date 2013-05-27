set serveroutput on
DECLARE
  cursor c1 is select SID, SERIAL# from v$session where username = '<schema_name';
BEGIN
FOR rec IN c1 loop
EXECUTE IMMEDIATE 'alter system kill session '''||rec.SID||','||rec.SERIAL#||'''';
end loop;
DROP USER <SCHEMA_NAME> CASCADE;
END;
