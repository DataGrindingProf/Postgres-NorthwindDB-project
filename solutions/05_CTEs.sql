/*
1)  Find customers whose total amount of all orders exceeds 10,000 monetary units and output the required data.
The value of an individual order is defined as the sum of all its line items from the `order_details` table, 
calculated using the following formula:

sum = unit_price * quantity * (1 - discount)

Criteria:
1. Use a CTE (Common Table Expression) to calculate the total value for each order.
2. In the main query, using this CTE:
  - Calculate the following for each customer:
    -- total_amount — the sum of the values ​​of all their orders;
    -- avg_order_amount — the average value per order.
  - Filter the results to include only those customers whose total_amount is greater than 10,000.
  - Display the columns in the following exact order:
    -- customer_id, company_name, total_amount, avg_order_amount
3. Sort the results:
  - By total_amount in descending order;
  - If equal, by customer_id in ascending order.

*/

WITH total_price AS (
	SELECT order_id, SUM(unit_price * quantity * (1- discount)) AS order_sum 
	FROM order_details
	GROUP BY order_id
)
SELECT o.customer_id, c.company_name, SUM(tp.order_sum) AS total_amount, AVG(tp.order_sum) AS avg_order_amount
FROM orders o
JOIN customers c USING(customer_id)
JOIN total_price tp USING(order_id)
GROUP BY o.customer_id, c.company_name
HAVING SUM(tp.order_sum) > 10000
ORDER BY total_amount DESC, o.customer_id

/*
2) Write a single SQL query that:
1. Finds the top 5 customers based on their total purchase value over the entire period (accounting for prices, quantities, and discounts).
2. For each of these 5 customers, determines the product category in which they have purchased the highest total number of items (based on the `quantity` field).
3. Returns the final table.
*/

WITH top_five AS (
SELECT customer_id, SUM(unit_price * quantity * (1 - discount)) AS total_purchase
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_details od ON o.order_id = od.order_id
GROUP BY customer_id
ORDER BY total_purchase DESC
LIMIT 5
),

top_category AS (
SELECT customer_id, category_name, SUM(quantity) AS total_quantity
FROM categories cat
JOIN products p USING (category_id)
JOIN order_details od USING (product_id)
JOIN orders o USING (order_id)
JOIN customers c USING (customer_id)
WHERE customer_id IN (SELECT customer_id FROM top_five )
GROUP BY customer_id, category_name

),

max_quantity AS(
SELECT customer_id, MAX(total_quantity) as max_qty
FROM top_category
GROUP BY customer_id
)

SELECT customer_id, category_name, total_quantity
FROM top_category
WHERE total_quantity IN (SELECT max_qty FROM max_quantity)
ORDER BY total_quantity DESC
