WITH CTE AS (
    SELECT customer_id, 
           YEAR(order_date) AS order_year, 
           SUM(price) AS total
    FROM Orders
    GROUP BY customer_id, YEAR(order_date)
),
Ranked AS (
    SELECT customer_id,
           order_year,
           ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_year) AS rank_year,
           DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY total) AS rank_total
    FROM CTE
)
SELECT customer_id
FROM Ranked
GROUP BY customer_id
HAVING COUNT(CASE WHEN rank_year = rank_total THEN 1 END) = MAX(order_year) - MIN(order_year) + 1;
