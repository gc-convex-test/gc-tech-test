-- Create final view

USE ROLE transformer;
USE DATABASE analytics_db;
USE SCHEMA presentation;
USE WAREHOUSE transforming_wh;

CREATE OR REPLACE VIEW analytics_db.presentation.purchase_count_v
  AS
    SELECT
        customers.customer_id,
        products.product_id,
        customers.loyalty_score,
        products.product_category,
        COUNT(transactions.product_id) AS purchase_count
    FROM
        transactions_fact as transactions
        LEFT JOIN customers_dimension as customers
        ON transactions.customer_id = customers.customer_id
        LEFT JOIN products_dimension as products
        ON transactions.product_id = products.product_id
    GROUP BY
        customers.customer_id,
        customers.loyalty_score,
        products.product_id,
        products.product_category
    ORDER BY
        products.product_category,
        products.product_id;
