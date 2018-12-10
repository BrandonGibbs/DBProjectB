DROP DATABASE IF EXISTS ZombiePharmacy;
CREATE DATABASE ZombiePharmacy;
USE ZombiePharmacy;

-- CREATE USER
-- Admin, manager, non-manager employee, general user

-- Entites
-- Use surrogate keys for internals like pharmacy,
-- employee, orders, and useraccount, and natural keys 
-- for everything else
CREATE TABLE pharmacy (
	pharm_id INTEGER(4) AUTO_INCREMENT, 
	email VARCHAR(32), 
	phone_num VARCHAR(12) CHECK(CHAR_LENGTH(phone_num) >= 7), 
	address VARCHAR(32), 
	PRIMARY KEY(pharm_id));

CREATE TABLE employee (
	emp_id INTEGER(4) AUTO_INCREMENT, 
	pharm_id INTEGER(4), 
	name VARCHAR(32), 
	phone_num VARCHAR(12) CHECK(CHAR_LENGTH(phone_num) >= 7), 
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
	name VARCHAR(32), 
	email VARCHAR(32), 
	phone_num VARCHAR(12) CHECK(CHAR_LENGTH(phone_num) >= 7), 
	address VARCHAR(32), 
	PRIMARY KEY(distrib_id));

-- Make sure the order is made by a manager,
-- not just any employee
CREATE TABLE orders (
	order_id INTEGER(4) AUTO_INCREMENT,
	emp_id INTEGER(4),
	distrib_id INTEGER(4), 
	date_time_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(order_id),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id),
	FOREIGN KEY(distrib_id) REFERENCES distributor(distrib_id));

-- According to the UPC-A standard, the first 5 digits
-- of the UPC is the manufacturer ID when the format
-- digit is 0 or 1
CREATE TABLE product (
	upc BIGINT(12),
	manuf_id INTEGER(6), 
	unit_price NUMERIC(6, 2) CHECK(unit_price > 0), 
	name VARCHAR(32), 
	description VARCHAR(64), 
	over_the_counter BOOLEAN, 
	PRIMARY KEY(upc),
	FOREIGN KEY(manuf_id) REFERENCES manufacturer(manuf_id));

CREATE TABLE useraccount (
	acct_id INTEGER(8) AUTO_INCREMENT,
	email VARCHAR(32),
	username VARCHAR(16),
	password VARCHAR(16),
	PRIMARY KEY(acct_id));

CREATE TABLE permission (
	relation_name VARCHAR(12),
	PRIMARY KEY(relation_name));


-- Relationships
CREATE TABLE inventory (
	upc BIGINT(12), 
	pharm_id INTEGER(4), 
	num_units_avail INTEGER(4), -- units available for sale
	num_units_await INTEGER(4), -- units ordered, awaiting arrival
	sell_price NUMERIC(6, 2) CHECK(sell_price > 0),
	min_stock INTEGER(4),
	PRIMARY KEY(upc, pharm_id),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(pharm_id) REFERENCES pharmacy(pharm_id));

CREATE TABLE sale (
	upc BIGINT(12), 
	emp_id INTEGER(4), 
	date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	num_units INTEGER(4),
	PRIMARY KEY(upc, emp_id, date_time),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id));

CREATE TABLE order_prod (
	upc BIGINT(12), 
	order_id INTEGER(4),
	num_units INTEGER(4),
	PRIMARY KEY(upc, order_id),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(order_id) REFERENCES orders(order_id));

CREATE TABLE catalog (
	upc BIGINT(12), 
	distrib_id INTEGER(4),
	date_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(upc, distrib_id),
	FOREIGN KEY(upc) REFERENCES product(upc),
	FOREIGN KEY(distrib_id) REFERENCES distributor(distrib_id));

CREATE TABLE emp_acct (
	acct_id INTEGER(8),
	emp_id INTEGER(4),
	PRIMARY KEY(acct_id, emp_id),
	FOREIGN KEY(acct_id) REFERENCES useraccount(acct_id),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id));

-- Triggers
-- When sale is made =>
-- if num_units_avail >= amount sold, allow transaction
--CREATE TRIGGER on_sale_dec_inventory

-- When an order is made =>
-- increase num_units_await
--CREATE TRIGGER on_order_inc_units_await

-- When order arrives =>
-- dec num_units_await, inc num_units_avail
--CREATE TRIGGER on_arrive_inc_units_avail

-- When user creates an account =>
-- 

-- Pay employee monthly
-- 

