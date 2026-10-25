/*
Select order records that must be shipped to countries whose names start with ‘N’.

Criteria:
- Include the order identifier column — order_id, customer identifier column — customer_id, weight column — freight, and shipping country column — ship_country
- Sort by weight
- Display only the first 5 records.
*\

SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 5
