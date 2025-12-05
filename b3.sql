-- 1
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;


-- 2
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(total_revenue_per_customer)
    FROM (
        SELECT 
            SUM(total_price) AS total_revenue_per_customer
        FROM orders
        GROUP BY customer_id
    ) t
);


-- 3
SELECT 
    c.city,
    SUM(o.total_price) AS city_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_total)
    FROM (
        SELECT 
            SUM(o.total_price) AS city_total
        FROM customers c
        JOIN orders o 
            ON c.customer_id = o.customer_id
        GROUP BY c.city
    ) t
);


-- 4
SELECT 
    c.customer_name,
    c.city,
    p.product_name,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS line_total
FROM customers c
INNER JOIN orders o 
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi 
    ON o.order_id = oi.order_id
INNER JOIN products p 
    ON oi.product_id = p.product_id;
