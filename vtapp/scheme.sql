CREATE TABLE users
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	company_id INT NOT NULL
);

CREATE TABLE roles
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL
);

CREATE TABLE tracks
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL
);

CREATE TABLE exercises
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL,
	content TEXT NOT NULL,
	track_id INT NOT NULL,
	assigned_to INT NOT NULL,
	FOREIGN KEY (track_id) REFERENCES tracks(id),
	FOREIGN KEY (assigned_to) REFERENCES users(id)
);


CREATE TABLE tasks
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL,
	content TEXT NOT NULL,
	track_id INT NOT NULL,
	FOREIGN KEY (track_id) REFERENCES tracks(id)
);

CREATE TABLE user_roles
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	user_id INT NOT NULL, 
	role INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (role) REFERENCES roles(id)
);


CREATE TABLE track_user_roles
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	user_role_id INT NOT NULL, 
	track_id INT NOT NULL,
	FOREIGN KEY (track_id) REFERENCES tracks(id),
	FOREIGN KEY (user_role_id) REFERENCES user_roles(id)
);

CREATE TABLE assigned_exercises
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	user_id INT NOT NULL, 
	exercise_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

CREATE TABLE solutions
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	assigned_exercise_id INT NOT NULL,
	FOREIGN KEY (assigned_exercise_id) REFERENCES assigned_exercises(id)
);

	




























