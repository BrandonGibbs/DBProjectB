INSERT INTO pharmacy (email, phone_num, address) 
	VALUES ('location1@zombiepharmacy.com', "9565555277", "666 Zombie Dr.");
INSERT INTO pharmacy (email, phone_num, address) 
	VALUES ('location2@zombiepharmacy.com', "2135552267", "512 Hell St.");
INSERT INTO pharmacy (email, phone_num, address) 
	VALUES ('location3@zombiepharmacy.com', "8825556509", "1313 Blood Ave.");

INSERT INTO employee (pharm_id, name, phone_num, address, position, salary) 
	VALUES (1, "Xavier Zamora", "6995554564", "4208 Jefferson St.", "salesperson", 12.25);
INSERT INTO employee (pharm_id, name, phone_num, address, position, salary)
	VALUES (1, "Cindy Flesh", "9955550917", "973 Hamilton St. Apt. 16", "cashier", 7.25);
INSERT INTO employee  (pharm_id, name, phone_num, address, position, salary)
	VALUES (1, "Zane Zmith", "9255553112", "6842 Washington Dr.", "manager", 15.75);
INSERT INTO employee  (pharm_id, name, phone_num, address, position, salary)
	VALUES (2, "Suzy Brains", "3825554751", "3733 Adams Ave.", "manager", 15.25);
INSERT INTO employee  (pharm_id, name, phone_num, address, position, salary)
	VALUES (2, "Zamuel Zim", "4435558715", "8525 Clinton Dr.", "cashier", 7.25);

INSERT INTO manufacturer (manuf_id, name)
	VALUES (824098, "Braaaains!");
INSERT INTO manufacturer 
	VALUES (785272, "Super Evil Supplements");

INSERT INTO product (upc, manuf_id, unit_price, name, description, over_the_counter)
	VALUES (677685436504, 824098, 2499.99, "Einstein Brain", 
		"Increase intelligence by 20 IQ points and reduce hunger", 0);
INSERT INTO product 
	VALUES (941054684936, 824098, 1024.99, "Rando Brain", 
		"Reduce hunger", 0);
INSERT INTO product 
	VALUES (575170010538, 785272, 99.99, "28 Days Later Speed Supplement", 
		"Sprint as fast as humans for 4 hours", 1);
INSERT INTO product 
	VALUES (986274818248, 785272, 149.99, "Sneak Supplement", 
		"Increase stealth for 8 hours", 1);

-- pharmacy 1's inventory
INSERT INTO inventory (upc, pharm_id, num_units_avail, num_units_await, sell_price, min_stock)
	VALUES (677685436504, 1, 3, 0, 2800.00, 5);
INSERT INTO inventory 
	VALUES (941054684936, 1, 120, 0, 1300.00, 26);
INSERT INTO inventory 
	VALUES (575170010538, 1, 15, 0,  127.99, 80);
INSERT INTO inventory 
	VALUES (986274818248, 1, 11, 0, 180.00, 100);
-- pharmacy 2's inventory
INSERT INTO inventory
	VALUES (677685436504, 2, 3, 0, 2800.00, 5);
INSERT INTO inventory 
	VALUES (941054684936, 2, 108, 0, 1300.00, 26);
INSERT INTO inventory 
	VALUES (575170010538, 2, 11, 0,  127.99, 80);
INSERT INTO inventory 
	VALUES (986274818248, 2, 23, 0, 180.00, 100);

--SELECT * FROM inventory;

INSERT INTO distributor 
	VALUES (2189, "Rick Grimes", "r.grimes20@walkerdistrib.com", "1709703549", "794 Hoover St.");
INSERT INTO catalog (upc, distrib_id)
	VALUES (677685436504, 2189);
INSERT INTO catalog (upc, distrib_id)
	VALUES (941054684936, 2189);
INSERT INTO catalog (upc, distrib_id)
	VALUES (575170010538, 2189);
INSERT INTO catalog (upc, distrib_id)
	VALUES (986274818248, 2189);

-- 1st order
INSERT INTO orders (emp_id, distrib_id)
	VALUES (3, 2189);
INSERT INTO order_prod 
	VALUES (677685436504, 1, 12);
-- 2nd order
INSERT INTO orders (emp_id, distrib_id)
	VALUES (4, 2189);
INSERT INTO order_prod (upc, order_id, num_units)
	VALUES (941054684936, 2, 20);
INSERT INTO order_prod (upc, order_id, num_units)
	VALUES (575170010538, 2, 2);

-- update pharmacy inventory accordingly (if only there
-- were a way to TRIGGER this automatically)
UPDATE inventory 
	SET num_units_await = num_units_await + 12 
	WHERE upc = 677685436504 AND pharm_id = 1;
UPDATE inventory 
	SET num_units_await = num_units_await + 20
	WHERE upc = 941054684936 AND pharm_id = 2;
UPDATE inventory 
	SET num_units_await = num_units_await + 2
	WHERE upc = 575170010538 AND pharm_id = 2;

--SELECT * FROM inventory;

INSERT INTO sale (upc, emp_id, num_units)
	VALUES (677685436504, 1, 2);
INSERT INTO sale (upc, emp_id, num_units)
	VALUES (986274818248, 2, 2);
INSERT INTO sale (upc, emp_id, num_units)
	VALUES (941054684936, 5, 1);

-- update pharmacy inventory accordingly (if only there
-- were a way to TRIGGER this automatically)
UPDATE inventory 
	SET num_units_avail = num_units_avail - 2
	WHERE upc = 677685436504 AND pharm_id = 1;
UPDATE inventory 
	SET num_units_avail = num_units_avail - 2
	WHERE upc = 986274818248 AND pharm_id = 1;
UPDATE inventory 
	SET num_units_avail = num_units_avail - 1
	WHERE upc = 941054684936 AND pharm_id = 2;

--SELECT * FROM inventory;

-- this'll be the general user's account
INSERT INTO useraccount (email, username, password) 
	VALUES ("iwalkallday@zombook.com", "iwalkallday", "hungryforbrains?");
-- 2 emplyees' accounts
INSERT INTO useraccount (email, username, password) 
	VALUES ("idkwtf@zombook.com", "blllains!", "hungryforbrains!");
INSERT INTO useraccount (email, username, password) 
	VALUES ("whocares@zombook.com", "bwwwains!", "HUNGRYFORBRAINS!");

INSERT INTO emp_acct (acct_id, emp_id)
	VALUES (2, 1);
INSERT INTO emp_acct
	VALUES (3, 2);

