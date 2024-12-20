CREATE TABLE t_cust_prod(
    sales_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cust_id NUMBER REFERENCES t_customers(cust_id) ON DELETE CASCADE,
    prod_id NUMBER REFERENCES t_products(prod_id) ON DELETE CASCADE,
    sold_on DATE DEFAULT SYSDATE
);