-- Run as DBA
GRANT CREATE JOB, CREATE EXTERNAL JOB TO hr ;

-- Run in HR user
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'daily_customer_product_sales_report',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN DBMS_OUTPUT.PUT_LINE(''Testing job scheduling''); END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=9; BYMINUTE=0',
        enabled         => TRUE
    );
END;
/

SELECT job_name FROM USER_SCHEDULER_JOBS;

BEGIN
    DBMS_SCHEDULER.DROP_JOB(
        job_name => 'daily_customer_product_sales_report',
        force    => TRUE
    );
END;
/