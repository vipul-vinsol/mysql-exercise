CREATE TABLE categories
(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100)
);


CREATE TABLE users
(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	type ENUM('admin', 'normal') NOT NULL
);


CREATE TABLE posts
(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	user_id BIGINT NOT NULL,
	content TEXT NOT NULL,	
	FOREIGN KEY fk_post(user_id)
	REFERENCES users(id)
);

CREATE TABLE comments
(
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	on_post BIGINT NOT NULL,
	posted_by BIGINT NOT NULL,
	content TEXT NOT NULL,	
);

ALTER TABLE comments
ADD CONSTRAINT fk_comment_on_post
FOREIGN KEY (on_post) REFERENCES posts(id); 

ALTER TABLE comments
ADD CONSTRAINT fk_comment_posted_by
FOREIGN KEY (posted_by) REFERENCES users(id);

-- CRUD categories

INSERT INTO categories(name) VALUES('IOT'), ('ML'), ('Web'),('Javascript');
SELECT * FROM categories;
UPDATE categories SET name='Data Science' WHERE name='ML';
DELETE FROM categories WHERE name='Web';


-- CRUD users
INSERT INTO users (name, email, type) VALUES ( 'A', 'admin@root.com', 'admin');
INSERT INTO users (name, email, type) VALUES ( 'B', 'bc@m.com', 'normal');
SELECT * from users;
UPDATE users SET email='c@m.com' WHERE name='C';
DELETE FROM users WHERE name='M' and email='m@m.com';

-- CRUD posts
INSERT INTO posts(user_id, content) VALUES (2, 'Test Post 2');
INSERT INTO posts(user_id, content) VALUES (2, 'Test Post 3');
INSERT INTO posts(user_id, content) VALUES (4, 'Test Post 4');
INSERT INTO posts(user_id, content) VALUES (3, 'Test Post 5');
INSERT INTO posts(user_id, content) VALUES (3, 'Test Post 6');

SELECT * from posts;

UPDATE posts SET content='Updated post content' WHERE user_id=4;

DELETE FROM posts WHERE id=3;


-- CRUD comments
INSERT INTO comments(on_post, posted_by, content) VALUES (4, 3, 'Good post'),(4, 4, 'HATE THAT');
INSERT INTO comments(on_post, posted_by, content) VALUES (1, 3, 'Good post'), (1, 4, 'Amazing');
INSERT INTO comments(on_post, posted_by, content) VALUES (4, 3, 'Good post');
SELECT * from comments;

UPDATE comments SET content='Bad Post' WHERE id=3;

DELETE FROM comments WHERE content='Amazing';



-- Solutions

SELECT * from posts WHERE user_id = (SELECT id FROM users WHERE name='B');
+----+---------+-------------+
| id | user_id | content     |
+----+---------+-------------+
|  1 |       3 | Test Post 1 |
|  6 |       3 | Test Post 5 |
|  7 |       3 | Test Post 6 |
+----+---------+-------------+

-- #3 

SELECT posts.id AS 'POST ID',
posts.content AS 'Content',
comments.content AS 'Comment',
FROM posts
LEFT JOIN comments
ON posts.id = comments.on_post
JOIN users
ON posts.user_id = users.id
WHERE users.name='B';

+---------+-------------+-----------+
| POST ID | Content     | Comment   |
+---------+-------------+-----------+
|       1 | Test Post 1 | Good post |
|       6 | Test Post 5 | NULL      |
|       7 | Test Post 6 | NULL      |
+---------+-------------+-----------+
3 rows in set (0.00 sec)

-- #4
SELECT * FROM posts WHERE id NOT IN (SELECT on_post FROM comments);
+----+---------+-------------+
| id | user_id | content     |
+----+---------+-------------+
|  2 |       2 | Test Post 2 |
|  6 |       3 | Test Post 5 |
|  7 |       3 | Test Post 6 |
+----+---------+-------------+
3 rows in set (0.00 sec)


-- #5
SELECT on_post 
FROM comments 
GROUP BY on_post 
HAVING count(on_post)=(SELECT COUNT(on_post) AS max FROM comments GROUP BY on_post ORDER BY max DESC LIMIT 1);
+---------+
| on_post |
+---------+
|       4 |
+---------+
1 row in set (0.00 sec)


-- #6

SELECT * FROM posts AS p where p.id IN (
SELECT on_post
FROM (
	SELECT on_post, count(*) AS 'count' 
	FROM comments 
	group by on_post, posted_by
) AS a group by a.on_post having COUNT(a.on_post)=SUM(a.count));
