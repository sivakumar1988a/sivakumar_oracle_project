CREATE OR REPLACE PACKAGE pkg_customer_product AS
    -- Procedure to insert a customer
    PROCEDURE p_insert_customer (
        p_first_name       IN VARCHAR2,
        p_last_name        IN VARCHAR2,
        p_email_office     IN VARCHAR2,
        p_email_personal   IN VARCHAR2 DEFAULT NULL,
        p_family_members   IN NUMBER DEFAULT 0,
        o_customer_id      OUT NUMBER
    );

    -- Procedure to insert a product
    PROCEDURE p_insert_product (
        p_book_title       IN VARCHAR2,
        p_book_price       IN NUMBER,
        p_book_quantity    IN NUMBER,
        o_product_id       OUT NUMBER
    );

    -- Procedure to link a customer and product
    PROCEDURE p_insert_customer_product (
        p_customer_id      IN NUMBER,
        p_product_id       IN NUMBER,
		o_sales_id       OUT NUMBER
    );

    -- Main procedure to manage customer, product, and their relationship
    PROCEDURE p_manage_customer_product_trans (
        p_first_name       IN VARCHAR2,
        p_last_name        IN VARCHAR2,
        p_email_office     IN VARCHAR2,
        p_email_personal   IN VARCHAR2 DEFAULT NULL,
        p_family_members   IN NUMBER DEFAULT 0,
        p_book_title       IN VARCHAR2,
        p_book_price       IN NUMBER,
        p_book_quantity    IN NUMBER
    );
END pkg_customer_product;
/