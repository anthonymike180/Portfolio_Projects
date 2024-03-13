--Create sales table
CREATE TABLE sales_data (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2)
);
select *
from sales_data

--Input data
INSERT INTO sales_data (order_id, customer_id, product_id, order_date, quantity, unit_price, total_price)
VALUES
(1, 101, 1, '2022-01-05', 2, 25.50, 51.00),
(2, 102, 3, '2022-01-10', 1, 35.75, 35.75),
(3, 103, 2, '2022-01-15', 3, 15.25, 45.75),
(4, 104, 1, '2022-02-01', 2, 25.50, 51.00),
(5, 105, 4, '2022-02-05', 1, 42.00, 42.00),
(6, 106, 1, '2022-02-10', 4, 25.50, 102.00),
(7, 107, 3, '2022-02-15', 2, 35.75, 71.50),
(8, 108, 2, '2022-03-01', 3, 15.25, 45.75),
(9, 109, 4, '2022-03-05', 1, 42.00, 42.00),
(10, 110, 1, '2022-03-10', 2, 25.50, 51.00),
(11, 111, 3, '2022-03-15', 1, 35.75, 35.75),
(12, 112, 2, '2022-04-01', 3, 15.25, 45.75),
(13, 113, 1, '2022-04-05', 4, 25.50, 102.00),
(14, 114, 4, '2022-04-10', 2, 42.00, 84.00),
(15, 115, 1, '2022-04-15', 1, 25.50, 25.50),
(16, 116, 3, '2022-05-01', 3, 35.75, 107.25),
(17, 117, 2, '2022-05-05', 2, 15.25, 30.50),
(18, 118, 4, '2022-05-10', 1, 42.00, 42.00),
(19, 119, 1, '2022-05-15', 4, 25.50, 102.00),
(20, 120, 3, '2022-06-01', 2, 35.75, 71.50),
(21, 121, 2, '2022-06-05', 3, 15.25, 45.75),
(22, 122, 1, '2022-06-10', 1, 25.50, 25.50),
(23, 123, 4, '2022-07-01', 3, 42.00, 126.00),
(24, 124, 1, '2022-07-05', 2, 25.50, 51.00),
(25, 125, 3, '2022-07-10', 1, 35.75, 35.75),
(26, 126, 2, '2022-07-15', 4, 15.25, 61.00),
(27, 127, 1, '2022-08-01', 2, 25.50, 51.00),
(28, 128, 4, '2022-08-05', 1, 42.00, 42.00),
(29, 129, 3, '2022-08-10', 3, 35.75, 107.25),
(30, 130, 2, '2022-08-15', 1, 15.25, 15.25);

--Retrieve the total sales amount for each customer
SELECT customer_id, SUM(total_price) AS total_sales_amount
FROM sales_data
GROUP BY customer_id;

--The month with the highest sales revenue
SELECT top 1 MONTH(order_date) AS month,
       SUM(total_price) AS total_sales_revenue
FROM sales_data
GROUP BY MONTH(order_date)
ORDER BY total_sales_revenue DESC

--Top 10 customers with the highest total sales amount
SELECT top 10 customer_id, SUM(total_price) AS total_sales_amount
FROM sales_data
GROUP BY customer_id
ORDER BY total_sales_amount DESC

--Products with the highest average unit price
SELECT product_id, AVG(unit_price) AS average_unit_price
FROM sales_data
GROUP BY product_id
ORDER BY average_unit_price DESC;

--Day of the week with the highest sales
SELECT top 1 DATEPART(WEEKDAY, order_date) AS day_of_week,
       SUM(total_price) AS total_sales_amount
FROM sales_data
GROUP BY DATEPART(WEEKDAY, order_date)
ORDER BY total_sales_amount DESC

--Month with the lowest sales revenue
SELECT top 1 MONTH(order_date) AS month,
       SUM(total_price) AS total_sales_revenue
FROM sales_data
GROUP BY MONTH(order_date)
ORDER BY total_sales_revenue ASC

--Month-over-month growth rate in sales revenue
WITH monthly_sales AS (
    SELECT YEAR(order_date) AS year,
           MONTH(order_date) AS month,
           SUM(total_price) AS total_sales_revenue
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
),
lagged_sales AS (
    SELECT year,
           month,
           total_sales_revenue,
           LAG(total_sales_revenue) OVER (ORDER BY year, month) AS previous_month_sales
    FROM monthly_sales
)
SELECT year,
       month,
       total_sales_revenue,
       (total_sales_revenue - previous_month_sales) / previous_month_sales AS growth_rate
FROM lagged_sales
WHERE previous_month_sales IS NOT NULL;

--Percentage contribution of each product to total sales revenue
SELECT product_id,
       SUM(total_price) AS product_sales_amount,
       SUM(total_price) / (SELECT SUM(total_price) FROM sales_data) * 100 AS contribution_percentage
FROM sales_data
GROUP BY product_id;
 
 --Anthony Michael 2022












