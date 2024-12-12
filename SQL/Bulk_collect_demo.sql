DECLARE
    TYPE t_product IS TABLE OF t_products%ROWTYPE;
    v_products t_product;
BEGIN
    SELECT * BULK COLLECT INTO v_products FROM t_products WHERE Book_Quantity > 0;
    
-- Increasing all the book price by 10%
    FORALL i IN v_products.FIRST .. v_products.LAST
        UPDATE t_products
        SET book_price = book_price * 1.1
        WHERE prod_id = v_products(i).prod_id;

    COMMIT;
END;
/