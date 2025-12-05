-- 1
SELECT 
    p.product_name,
    t.total_revenue
FROM products p
JOIN (
    SELECT 
        product_id,
        SUM(total_price) AS total_revenue
    FROM orders
    GROUP BY product_id
    ORDER BY total_revenue DESC
    LIMIT 1
) t 
ON p.product_id = t.product_id;


-- 2
SELECT 
    p.category,
    SUM(o.total_price) AS total_sales
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;


-- 3
(
    SELECT p.category
    FROM products p
    JOIN (
        SELECT product_id
        FROM orders
        GROUP BY product_id
        ORDER BY SUM(total_price) DESC
        LIMIT 1
    ) t ON p.product_id = t.product_id
)
INTERSECT
(
    SELECT p.category
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    GROUP BY p.category
    HAVING SUM(o.total_price) > 3000
);

