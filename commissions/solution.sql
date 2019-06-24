CREATE TABLE `Commissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `Commissions_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`id`)
);

INSERT INTO `Commissions` 
VALUES 
(1,1,5000),
(2,2,3000),
(3,3,4000),
(4,1,4000),
(5,2,3000),
(6,4,2000),
(7,5,1000),
(8,6,5000),
(9,2,5000);


CREATE TABLE `Departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `Departments` VALUES (1,'Banking'),(2,'Insurance'),(3,'Services');

CREATE TABLE `Employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `Employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `Departments` (`id`)
);


INSERT INTO `Employees` 
VALUES 
(1,'Chris Gayle',1000000,1),
(2,'Michael Clarke',800000,2),
(3,'Rahul Dravid',700000,1),
(4,'Ricky Pointing',600000,2),
(5,'Albie Morkel',650000,2),
(6,'Wasim Akram',750000,3);

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
