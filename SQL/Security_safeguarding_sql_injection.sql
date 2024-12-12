--- SQL injection made in string concatenated dynamic sql

declare
v_var varchar2(100);
v_sql varchar2(200);
v_val number(5);
begin
v_var := ''' OR ''1''=''1';
EXECUTE IMMEDIATE 'select count(*) into :val from t_customers where first_name = '''|| v_var ||'''' into v_val;
dbms_output.put_line(v_val);
end;


--- Using bind variable to avoid SQL injection

declare
v_var varchar2(100);
v_sql varchar2(200);
v_val number(5);
begin
v_var := ''' OR ''1''=''1';
EXECUTE IMMEDIATE 'select count(*) into :val from t_customers where first_name = :v_var' into v_val using v_var;
dbms_output.put_line(v_val);
end;


--- Using DBMS_ASSERT.ENQUOTE_LITERAL variable to avoid SQL injection

declare
v_var varchar2(100);
v_sql varchar2(200);
v_val number(5);
begin
v_var := 'Sivakumar';
v_var := DBMS_ASSERT.ENQUOTE_LITERAL(v_var);
EXECUTE IMMEDIATE 'select count(*) into :val from t_customers where first_name = '|| v_var  into v_val;
dbms_output.put_line(v_val);
end;
