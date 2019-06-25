CREATE TABLE employees
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name CHAR(50) NOT NULL
);


CREATE TABLE assets
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	type ENUM('individual', 'public') NOT NULL,	
	model VARCHAR(100) NOT NULL,
	maker VARCHAR(100) NOT NULL,
	year YEAR NOT NULL,
	price DECIMAL UNSIGNED NOT NULL, 
	warrenty DATE,
	status ENUM('available', 'assigned', 'in_repair') NOT NULL
);

CREATE TABLE repairs
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	asset_id INT NOT NULL, 
	cost DECIMAL UNSIGNED NOT NULL,
	description VARCHAR(300) NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES assets(id)
);


CREATE TABLE management_logs
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	asset_id INT NOT NULL,
	employee_id INT NOT NULL, 
	assigned_on DATETIME NOT NULL,
	released_on DATETIME NOT NULL,
	FOREIGN KEY (asset_id) REFERENCES assets(id),
	FOREIGN KEY (employee_id) REFERENCES employees(id)	
);


INSERT INTO employees (name)
VALUES ('Alice'), ('Bob'), ('Chris'), ('Duke'), ('Emily');

INSERT INTO assets 
(name, type, model, maker,year, price, warrenty, status) 
VALUES 
('iPhone', 'individual', '7', 'Apple Inc.',2010 ,45000,'2011-01-01', 'available'),
('iPhone', 'individual', '8', 'Apple Inc.',2012 ,55000,'2014-01-01', 'available'),
('iPad', 'individual', 'mini', 'Apple Inc.',2013 ,40000,'2014-01-01', 'available'),
('projector', 'individual', '10DX', 'Cannon Inc.',2008 ,30000,'2011-01-01', 'available'),
('printer', 'public', 'asdf12', 'Hawaei', 2010 ,41000,'2013-01-01', 'available'),
('router', 'public', 'asdf12', 'Hawaei', 2010 ,41000,'2013-01-01', 'available'),
('modem', 'public', 'asdf12', 'Hawaei', 2010 ,41000,'2013-01-01', 'available');


INSERT INTO repairs
(asset_id, cost, description)
VALUES
(4, 5000, 'Lens was damaged'),
(7, 2000, 'Hardware issue');

INSERT INTO assets  
(name, type, model, maker,year, price, warrenty, status)  
VALUES  
('Laptop A', 'individual', 'xps', 'Dell', 2011, 50000, '2011-01-01', 'available');


INSERT INTO management_logs
(asset_id, employee_id, assigned_on, released_on)
VALUES
(8, 1, '2011-01-01', '2011-12-31'),
(8, 2, '2012-01-01', NULL);


INSERT INTO assets  
(name, type, model, maker,year, price, warrenty, status)  
VALUES  
('Laptop B', 'individual', 'xps', 'Dell', 2011, 50000, '2011-01-01', 'available');


INSERT INTO management_logs
(asset_id, employee_id, assigned_on, released_on)
VALUES
(9, 2, '2011-01-01', '2011-12-31');


INSERT INTO assets
(name, type, model, maker,year, price, warrenty, status)  
VALUES  
('Laptop N1', 'individual', 'xps', 'Dell', 2011, 50000, '2011-01-01', 'available'),
('Laptop N2', 'individual', 'xps', 'Dell', 2011, 50000, '2011-01-01', 'available');



INSERT INTO assets
(name, type, model, maker, year, price, warrenty, status)
VALUES
('iPhone A', 'individual', '6s', 'Apple', 2010, 40000, '2010-04-01', 'assigned');


INSERT INTO management_logs
(asset_id, employee_id, assigned_on, released_on)
VALUES (10, 1, '2011-04-01', NULL);


INSERT INTO assets 
(name, type, model, maker, year, price, warrenty, status) 
VALUES 
('iPhone B', 'individual', '6s', 'Apple', 2010, 40000, '2010-08-01', 'assigned');


INSERT INTO management_logs 
(asset_id, employee_id, assigned_on, released_on) 
VALUES (11, 2, '2011-08-01', NULL);


-- Solutions

-- #1
SELECT name FROM 
employees WHERE 
id = 
(
	SELECT employee_id 
	FROM management_logs 
	GROUP BY employee_id 
	ORDER BY COUNT(employee_id) DESC 
	LIMIT 1
);



-- #2
SELECT name FROM 
employees WHERE 
id = 
(
	SELECT employee_id 
	FROM management_logs 
	GROUP BY employee_id, released_on 
	HAVING released_on IS NULL 
	ORDER BY COUNT(employee_id) DESC 
	LIMIT 1
);

-- #3
SELECT m.assigned_on, 
m.released_on, 
e.name AS 'user name', 
a.name AS 'asset name' 
FROM 
management_logs AS m 
LEFT JOIN 
employees AS e 
ON m.employee_id=e.id 
LEFT JOIN 
assets AS a 
ON m.asset_id=a.id 
WHERE a.name='Laptop A';


-- #4
SELECT * FROM assets WHERE status='available';

-- #5
SELECT m.assigned_on,
e.name AS 'user name', 
a.name AS 'asset name' 
FROM 
management_logs AS m 
LEFT JOIN 
employees AS e 
ON m.employee_id=e.id 
LEFT JOIN 
assets AS a 
ON m.asset_id=a.id 
WHERE e.name='Bob' 
AND m.released_on IS NULL;

-- #6
SELECT id, name, year, warrenty 
FROM assets 
WHERE warrenty < CURDATE();

-- #7
SELECT * FROM employees
WHERE id NOT IN 
(
	SELECT employee_id 
	FROM management_logs 
	WHERE released_on IS NULL
);
