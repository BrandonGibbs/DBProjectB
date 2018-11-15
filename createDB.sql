-- Entites
CREATE DATABASE pharma;
USE pharma;

CREATE TABLE pharmacy (
	pharm_id INTEGER(4), 
	email VARCHAR(32), 
	phone_num INTEGER(10) CHECK(phone_num > 1000000000), 
	address VARCHAR(32), 
	PRIMARY KEY(pharm_id));

CREATE TABLE employee (
	emp_id INTEGER(4), 
	pharm_id INTEGER(4), 
	name VARCHAR(32), 
	email VARCHAR(32), 
	phone_num INTEGER(10) CHECK(phone_num > 1000000000), 
	address VARCHAR(32), 
	position VARCHAR(16) CHECK(position IN ('manager', 'cashier', 'salesperson')), 
	salary NUMERIC(11, 2) CHECK(salary > 7.25),
	PRIMARY KEY(emp_id),
	FOREIGN KEY(pharm_id) REFERENCES pharmacy(pharm_id));

CREATE TABLE manufacturer (
	manuf_id INTEGER(6), 
	name VARCHAR(32),
	PRIMARY KEY(manuf_id));

CREATE TABLE distributor (
	distrib_id INTEGER(4), 
	manuf_id INTEGER(6), 
	name VARCHAR(32), 
	email VARCHAR(32), 
	phone_num INTEGER(10) CHECK(phone_num > 1000000000), 
	address VARCHAR(32), 
	PRIMARY KEY(distrib_id),
	FOREIGN KEY (manuf_id) REFERENCES manufacturer(manuf_id));

-- Make sure the order is made by a manager,
-- not just any employee
CREATE TABLE orders (
	order_id INTEGER(4),
	emp_id INTEGER(4),
	distrib_id INTEGER(4), 
	date_time_sent DATETIME,
	PRIMARY KEY(order_id),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id),
	FOREIGN KEY(distrib_id) REFERENCES distributor(distrib_id));

-- According to the UPC-A standard, the first 5 digits
-- of the UPC is the manufacturer ID when the format
-- (1st) digit is 0 or 1
CREATE TABLE product (
	upc INTEGER(12), 
	manuf_id INTEGER(6), 
	unit_price NUMERIC(6, 2) CHECK(unit_price > 0), 
	name VARCHAR(32), 
	description VARCHAR(64), 
	over_the_counter BOOLEAN, 
	PRIMARY KEY(upc),
	FOREIGN KEY(manuf_id) REFERENCES manufacturer(manuf_id));


-- Relationships
CREATE TABLE inventory (
	upc INTEGER(12), 
	pharm_id INTEGER(4), 
	num_units INTEGER(6),
	sell_price NUMERIC(6, 2) CHECK(sell_price > 0),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(pharm_id) REFERENCES pharmacy(pharm_id));

CREATE TABLE sale (
	upc INTEGER(12), 
	emp_id INTEGER(4), 
	num_units INTEGER(6),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id));

CREATE TABLE order_prod (
	upc INTEGER(12), 
	order_id INTEGER(4),
	num_units INTEGER(6),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(order_id) REFERENCES orders(order_id));

CREATE TABLE created_by (
	upc INTEGER(12), 
	manuf_id INTEGER(6), 
	retail_price NUMERIC(6, 2),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(manuf_id) REFERENCES manufacturer(manuf_id));

CREATE TABLE catalog (
	upc INTEGER(12), 
	distrib_id INTEGER(4),
	num_units INTEGER(4),
	date_posted DATE,
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(distrib_id) REFERENCES distributor(distrib_id));


-- Roles
--CREATE ROLE admin;
--CREATE ROLE manager;
--CREATE ROLE employee;

-- Authorization
--GRANT manager TO admin;
--GRANT employee TO manager;

--INSERT INTO 
