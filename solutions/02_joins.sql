/*
1) Find customers and the employees who handle their orders.

Criteria:
- Customers and employees from the city of London
- Delivery is handled by Speedy Express
- Enter the customer’s company as the custoner and the employee’s full name as the employee
*/

SELECT c.company_name AS customer, e.first_name || ' ' || e.last_name AS employee
FROM orders AS o
JOIN employees AS e USING(employee_id)
JOIN customers AS c USING(customer_id)
JOIN shippers AS s ON o.ship_via = s.shipper_id
WHERE e.city = 'London' and c.city = 'London' and o.ship_via = 1

/*
2) Find active (see the discontinued column) products from the Beverages and Seafood categories that have fewer than 20 units in stock.

Criteria:
- Output the product names, the number of units in stock, the supplier’s contact name, and their phone number
- Sort by units_in_stock
*/

SELECT product_name, units_in_stock, contact_name, phone
FROM products AS p
JOIN suppliers AS s USING(supplier_id)
JOIN categories AS c USING(category_id)
WHERE discontinued != 1 AND units_in_stock < 20 AND category_name IN ('Beverages', 'Seafood')
ORDER BY units_in_stock

/*
3) For each category, calculate the total number of ordered units; display only categories with a sum > 500.

Criteria:
-  Output: category_name, total_qty (rename the field for the total number of ordered units)
- Sort by total_qty in descending order.
*/

SELECT category_name, SUM(od.quantity) AS total_qty
FROM categories
JOIN products USING(category_id)
JOIN order_details AS od USING(product_id)
GROUP BY category_name
HAVING SUM(od.quantity) > 500
ORDER BY total_qty DESC
