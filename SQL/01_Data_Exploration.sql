USE pizza_db;

-- ============================================
-- PIZZA SALES ANALYSIS
-- SQL ANALYSIS QUERIES
-- ============================================


-- ============================================
-- 1. VIEW DATA
-- ============================================

SELECT *
FROM pizza_sales;


-- ============================================
-- 2. TOTAL REVENUE
-- ============================================

SELECT 
    SUM(total_price) AS total_revenue
FROM pizza_sales;


-- ============================================
-- 3. DAILY TREND OF TOTAL ORDERS
-- ============================================

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- ============================================
-- 4. MONTHLY TREND OF TOTAL ORDERS
-- ============================================

SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY total_orders DESC;


-- ============================================
-- 5. PERCENTAGE OF SALES BY PIZZA CATEGORY
-- ============================================

SELECT 
    pizza_category,
    SUM(total_price) AS total_sales,
    SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales) 
        AS percentage_category
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_category
ORDER BY percentage_category DESC;


-- ============================================
-- 6. PERCENTAGE OF SALES BY PIZZA SIZE
-- ============================================

SELECT 
    pizza_size,
    SUM(total_price) AS total_sales,
    SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales) 
        AS percentage_size
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_size
ORDER BY percentage_size DESC;


-- ============================================
-- 7. TOP 5 PIZZAS BY REVENUE
-- ============================================

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;


-- ============================================
-- 8. TOP 5 PIZZAS BY QUANTITY SOLD
-- ============================================

SELECT 
    pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;
