/*
Find customers and the employees who handle their orders.
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
