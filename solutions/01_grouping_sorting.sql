/*
1) Select order records that must be shipped to countries whose names start with ‘N’.

Criteria:
- Include the order identifier column — order_id, customer identifier column — customer_id, weight column — freight, and shipping country column — ship_country
- Sort by weight
- Display only the first 5 records.
*/

SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 5

/* 
2) Select all unique countries of customers and suppliers and sort the countries in ascending order.
*/

SELECT DISTINCT country
FROM customers
UNION
SELECT DISTINCT country
FROM suppliers
ORDER BY country

/* 
3) Select countries where both customers and suppliers are “registered,” but employees are not “registered” there.
*/

SELECT country FROM customers
INTERSECT
SELECT country FROM suppliers
EXCEPT
SELECT country FROM employees
