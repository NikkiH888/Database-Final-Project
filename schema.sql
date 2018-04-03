DROP TABLE IF EXISTS user_logs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_types;

CREATE TABLE user_types (
	user_type_id SERIAL,
	user_type_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (user_type_id)
);

CREATE TABLE users (
	user_id INT,
	password_hash TEXT NOT NULL,
	username VARCHAR(60) NOT NULL,
	user_type_id INT NOT NULL,
	PRIMARY KEY (user_id),
	FOREIGN KEY (user_type_id) REFERENCES user_types (user_type_id)
);

CREATE TABLE user_logs (
	user_id INT NOT NULL,
	action_taken_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	action_taken TEXT NOT NULL,
	PRIMARY KEY (user_id, action_taken_time),
	FOREIGN KEY (user_id) REFERENCES users (user_id)
);

/* ######################################################################*/

CREATE TABLE issue_priorities (
	id INT,
	priority VARCHAR(40) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE issue_statuses (
	id INT,
	status VARCHAR(40) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE issue_types (
	id INT,
	type VARCHAR(40) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE branches (
	id INT,
	name VARCHAR(60) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE employees (
	id INT,
	name VARCHAR(60) NOT NULL,
	branch_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (branch_id) REFERENCES branches (id)
);

CREATE TABLE properties (
	id INT,
	name VARCHAR(60) NOT NULL,
	branch_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (branch_id) REFERENCES branches (id)
);

CREATE TABLE issues (
	id INT,
	priority_id INT NOT NULL,
	status_id INT NOT NULL,
	type_id INT NOT NULL,
	assigned_employee_id INT,
	property_id INT NOT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	resolved_on TIMESTAMP,
	due_on TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (priority_id) REFERENCES issue_priorities (id),
	FOREIGN KEY (status_id) REFERENCES issue_statuses (id),
	FOREIGN KEY (type_id) REFERENCES issue_types (id),
	FOREIGN KEY (assigned_employee_id) REFERENCES employees (id),
	FOREIGN KEY (property_id) REFERENCES properties (id)
);

CREATE TABLE purchase_statuses (
	id INT,
	status VARCHAR(40) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE vendors (
	id INT,
	name VARCHAR(40) NOT NULL,
	financials TEXT,
	PRIMARY KEY (id)
);

CREATE TABLE purchase_orders (
	id INT,
	vendor_id INT NOT NULL,
	purchase_status_id NOT NULL,
	created_by_user_code CHAR(4) NOT NULL,
	submitted_on TIMESTAMP NOT NULL,
	estimated_delivery_date TIMESTAMP,
	approved_on TIMESTAMP,
	branch_id INT NOT NULL,
	is_fully_allocated BOOLEAN NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (vendor_id) REFERENCES vendors (id),
	FOREIGN KEY (purchase_status_id) REFERENCES purchase_statuses (id),
	FOREIGN KEY (branch_id) REFERENCES branches (id)
);
