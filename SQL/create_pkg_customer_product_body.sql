CREATE OR REPLACE PACKAGE BODY pkg_customer_product AS

    -- Procedure to insert a customer
    PROCEDURE p_insert_customer (
        p_first_name       IN VARCHAR2,
        p_last_name        IN VARCHAR2,
        p_email_office     IN VARCHAR2,
        p_email_personal   IN VARCHAR2 DEFAULT NULL,
        p_family_members   IN NUMBER DEFAULT 0,
        o_customer_id      OUT NUMBER
    ) AS
    BEGIN
        -- Validate customer data
        IF p_family_members < 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Family Members cannot be negative.');
        END IF;

        -- Insert into t_customers table
        INSERT INTO t_customers (first_name, last_name, email_off, email_personal, family_mem)
        VALUES (p_first_name, p_last_name, p_email_office, p_email_personal, p_family_members)
        RETURNING cust_id INTO o_customer_id;

        DBMS_OUTPUT.PUT_LINE('Customer Inserted with ID: ' || o_customer_id);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Duplicate Email Address.');
            RAISE;
    END;

    -- Procedure to insert a product
    PROCEDURE p_insert_product (
        p_book_title       IN VARCHAR2,
        p_book_price       IN NUMBER,
        p_book_quantity    IN NUMBER,
        o_product_id       OUT NUMBER
    ) AS
    BEGIN
        -- Validate product data
        IF p_book_price <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Book Price must be greater than zero.');
        END IF;

        IF p_book_quantity < 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Book Quantity cannot be negative.');
        END IF;

        -- Insert into t_products table
        INSERT INTO t_products (book_title, book_price, book_quantity)
        VALUES (p_book_title, p_book_price, p_book_quantity)
        RETURNING prod_id INTO o_product_id;

        DBMS_OUTPUT.PUT_LINE('Product Inserted with ID: ' || o_product_id);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting product: ' || SQLERRM);
            RAISE;
    END;

    -- Procedure to link a customer and a product
    PROCEDURE p_insert_customer_product (
        p_customer_id      IN NUMBER,
        p_product_id       IN NUMBER,
		o_sales_id       OUT NUMBER
    ) AS
    BEGIN
        -- Insert into t_cust_prod table
        INSERT INTO t_cust_prod (cust_id, prod_id)
        VALUES (p_customer_id, p_product_id)
        RETURNING sales_id INTO o_sales_id;

        DBMS_OUTPUT.PUT_LINE('Customer sales id for the product: ' || o_sales_id);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating sales record: ' || SQLERRM);
            RAISE;
    END;

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
    ) AS
        v_customer_id NUMBER;
        v_product_id  NUMBER;
        v_sales_id  NUMBER;
    BEGIN
        -- Start transaction
        SAVEPOINT bef_trans;

        -- Insert customer
        p_insert_customer(
            p_first_name       => p_first_name,
            p_last_name        => p_last_name,
            p_email_office     => p_email_office,
            p_email_personal   => p_email_personal,
            p_family_members   => p_family_members,
            o_customer_id      => v_customer_id
        );

        -- Insert product
        p_insert_product(
            p_book_title       => p_book_title,
            p_book_price       => p_book_price,
            p_book_quantity    => p_book_quantity,
            o_product_id       => v_product_id
        );

        -- Link customer and product
        p_insert_customer_product(
            p_customer_id      => v_customer_id,
            p_product_id       => v_product_id,
			o_sales_id         => v_sales_id
			
        );

        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO bef_trans;
            DBMS_OUTPUT.PUT_LINE('Transaction rolled back due to: ' || SQLERRM);
            RAISE;
    END;

END pkg_customer_product;
/