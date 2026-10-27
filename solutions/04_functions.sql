/*
1) Create an SQL function called backup_customers() that performs a backup of the customers table 
(copies all data to another table named backedup_customers), first deleting the backup table if it already exists.
*/
CREATE FUNCTION backup_customers()
RETURNS VOID 
AS $$
BEGIN
	DROP TABLE IF EXISTS backedup_customers;
	
	CREATE TABLE backedup_customers AS
		SELECT * FROM customers;
END;
$$ LANGUAGE plpgsql

/*
2) Write a function random_between that takes two integer parameters used as the lower and upper bounds 
   for generating a random number within that range.

Criteria:

- You need to calculate the difference between the bounds and add one.

- Multiply the result of the random() function by the resulting number and add the value of the lower bound to the result..

- Apply the floor() function to the final result to prevent going beyond the bounds and to get an integer.
*/

CREATE FUNCTION random_between(a int, b int)
RETURNS real
AS $$
DECLARE
	diff int;
	res real;
BEGIN
	IF a >= b THEN
		diff := a - b + 1;
		res := FLOOR(diff * random() + b);
		RETURN res;
	ELSE
		diff := b - a + 1;
		res := FLOOR(diff * random() + a);
		RETURN res;
	END IF;
END;
$$ LANGUAGE plpgsql

/*
3) Create a function correct_salary that adjusts the salary by a specified percentage, 
   but does not adjust the salary if its level exceeds the specified level. 
   The upper salary level (function argument) defaults to 70, the adjustment percentage (function argument) defaults to 15%.
*/

CREATE OR REPLACE FUNCTION correct_salary(lev numeric DEFAULT 70.0, coef numeric DEFAULT 0.15)
RETURNS void 
AS $$
BEGIN
    UPDATE employees
    SET salary = salary * (1 + coef)
    WHERE salary <= lev; 
END;
$$ LANGUAGE plpgsql;
