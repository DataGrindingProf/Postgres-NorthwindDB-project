/*
1) Show products whose quantity in stock is less than the smallest average quantity of products in the order details.
Criteria:
- Output: product_name and units_in_stock.
- Sort by units_in_stock in descending order.
*/

SELECT product_name, units_in_stock
FROM products AS p
WHERE p.units_in_stock < (SELECT AVG(quantity)
							FROM order_details
							GROUP BY product_id 
							ORDER BY AVG(quantity)
							LIMIT 1
						 )
ORDER BY units_in_stock DESC

/*
2) Write a query that, for each customer, displays the total freight.
Criteria:
- The order dispatch date is within the range from 1996-07-16 to 1996-07-31 inclusive.
- freight for each such order exceeds the average freight for all orders of that customer (without a date limit).
*/

SELECT customer_id, SUM(freight) AS freight_sum
FROM orders o1
WHERE shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
	AND o1.freight > (SELECT AVG(freight)
						FROM orders o2
						WHERE o2.customer_id = o1.customer_id
						GROUP BY customer_id
					 )
GROUP BY customer_id
ORDER BY freight_sum ASC
