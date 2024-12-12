BEGIN
    pkg_customer_product.p_manage_customer_product_trans(
        p_first_name     => 'Sivakumar',
        p_last_name      => 'Arumugam',
        p_email_office   => 'sivakumar.arumugam@office.com',
        p_email_personal => 'sivakumar.arumugam@gmail.com',
        p_family_members => 2,
        p_book_title     => 'PLSQL Advanced Concepts',
        p_book_price     => 100,
        p_book_quantity  => 1
    );
END;

BEGIN
    pkg_customer_product.p_manage_customer_product_trans(
        p_first_name     => 'Guruprasad',
        p_last_name      => 'Shanmugasundaram',
        p_email_office   => 'Guruprasad.s@office.com',
        p_email_personal => 'Guruprasad.s@gmail.com',
        p_family_members => 3,
        p_book_title     => 'SQL Security',
        p_book_price     => 40,
        p_book_quantity  => 2
    );
END;

/