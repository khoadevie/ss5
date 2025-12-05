-- 1
SELECT 
    c.customer_name AS ten_khach,
    o.order_date   AS ngay_dat_hang,
    o.total_amount AS tong_tien
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;


-- 2
SELECT 
    SUM(total_amount) AS tong_doanh_thu,
    AVG(total_amount) AS trung_binh_gia_tri_don,
    MAX(total_amount) AS don_hang_lon_nhat,
    MIN(total_amount) AS don_hang_nho_nhat,
    COUNT(order_id)   AS so_luong_don_hang
FROM orders;


-- 3
SELECT 
    c.city,
    SUM(o.total_amount) AS doanh_thu
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;


-- b
    c.city,
    SUM(o.total_amount) AS doanh_thu
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;


-- 4
SELECT 
    c.customer_name AS ten_khach,
    o.order_date    AS ngay_mua,
    oi.product_name AS san_pham,
    oi.quantity     AS so_luong,
    oi.price        AS gia_ban,
    (oi.quantity * oi.price) AS thanh_tien
FROM customers c
JOIN orders o        ON c.customer_id = o.customer_id
JOIN order_items oi  ON o.order_id = oi.order_id;


-- 5

SELECT 
    c.customer_id,
    c.customer_name,
    t.total_spent
FROM customers c
JOIN (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
    ORDER BY total_spent DESC
    LIMIT 1
) t ON c.customer_id = t.customer_id;

-- 6
-- a
SELECT city FROM customers
UNION
SELECT c.city 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


-- b
SELECT city FROM customers
INTERSECT
SELECT c.city 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
