

-- 1
SELECT employee_id, SUM(amount) AS 'commission'
FROM Commissions 
GROUP BY employee_id 
ORDER BY SUM(amount) DESC 
LIMIT 1;

-- 2
SELECT name, salary FROM Employees ORDER BY salary DESC LIMIT 3,1;

-- #3

-- Highest Commission amount given to one person.
SELECT e.name, e.department_id FROM Employees AS e LEFT JOIN Commissions AS c ON e.id=c.employee_id ORDER BY c.amount DESC LIMIT 1;

-- Highest commission given by department in total
SELECT e.department_id 
FROM Employees AS e 
LEFT JOIN Commissions AS c 
ON e.id=c.employee_id 
GROUP BY e.department_id 
ORDER BY SUM(c.amount) DESC 
LIMIT 1;

-- #4

SELECT e.name, c.amount  
FROM Employees AS e 
JOIN Commissions AS c 
ON e.id=c.employee_id 
WHERE c.amount > 3000;
