							#########Section 17 : Sequences ############

---------Create A Sequence-------------

Genrating unique Numeric Identifiers - i.e id feilds

CREATE SEQUENCE test_sequence;

SELECT nextval('test_sequence');
SELECT nextval('test_sequence');

SELECT currval('test_sequence');

SELECT lastval();

-- set value but next value will increment
SELECT setval('test_sequence',14);
SELECT nextval('test_sequence');

-- set value and next value will be what you set
SELECT setval('test_sequence',25,false);
SELECT nextval('test_sequence');

CREATE SEQUENCE IF NOT EXISTS test_sequence2 INCREMENT 5;

CREATE SEQUENCE IF NOT EXISTS test_sequence_3
INCREMENT 50 MINVALUE 350 MAXVALUE 5000 START WITH 550;

CREATE SEQUENCE IF NOT EXISTS test_sequence_4 INCREMENT 7 START WITH 33;

SELECT MAX(employeeid) FROM employees;

CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
START WITH 10 OWNED BY employees.employeeid;

--This insert will fail
INSERT INTO employees
(lastname,firstname,title,reportsto)
VALUES ('Smith','Bob', 'Assistant', 2);

--must alter the default value
ALTER TABLE employees
ALTER COLUMN employeeid SET DEFAULT nextval('employees_employeeid_seq');

--Now Insert will work
INSERT INTO employees
(lastname,firstname,title,reportsto)
VALUES ('Smith','Bob', 'Assistant', 2);

INSERT INTO users (name,age) VALUES (‘Liszt’,10) RETURNING id;

SELECT MAX(orderid) FROM orders;

CREATE SEQUENCE IF NOT EXISTS orders_orderid_seq START WITH 11077;

ALTER TABLE orders
ALTER COLUMN orderid SET DEFAULT nextval('orders_orderid_seq');

INSERT INTO orders (customerid,employeeid,requireddate,shippeddate)
VALUES ('VINET',5,'1996-08-01','1996-08-10') RETURNING orderid;


---------Alter and Delete Sequences-------

ALTER SEQUENCE employees_employee_seq RESTART WITH 1000
SELECT nextval('employees_employee_seq')

ALTER SEQUENCE orders_orderid_seq RESTART WITH 200000
SELECT nextval('orders_orderid_seq')

ALTER SEQUENCE test_sequence RENAME TO test_sequence_1

ALTER SEQUENCE test_sequence_4  RENAME TO test_sequence_four

DROP SEQUENCE test_sequence_1

DROP SEQUENCE test_sequence_four

----------Using Serial Datatypes--------

-Used to Increament Id Field Automatically-

DROP TABLE IF EXISTS exes;

CREATE TABLE exes (
exid SERIAL,
name varchar(255)
);
INSERT INTO exes (name) VALUES ('Carrie') RETURNING exid

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
petid SERIAL,
name varchar(255)
);

INSERT INTO pets (name) VALUES ('Fluffy') RETURNING petid;

						###############Section 19: Views ###############

  What is Views:

  It actes like a stored query that you give a name
  once created you can use SELECT to pill information from like a regular table.

  Why use Views:

  Used to keep from having to type in complex queries.
  also allows you to change underlying tables without rewriting all the queries that access.
  Grant permissions.so you can limit a person/group to certain feilds from base tables.

-------Views - How To Create--------

CREATE VIEW customer_order_details AS
SELECT companyname, Orders.customerid, employeeid, orderdate, requireddate, shippeddate
Shipvia, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry,
order_details.*
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;

SELECT *
FROM customer_order_details
WHERE customerid='TOMSP';

CREATE VIEW supplier_order_details AS
SELECT companyname, suppliers.supplierid, Products.productid, productname,
Order_details.unitprice, quantity, discount, orders.*
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;

SELECT *  FROM supplier_order_details WHERE supplierid=5;


--------Views - How To Modify-------

*Note:-- can't remove an existing column in the view.
	 Must have same coulmns with same name,same datatypes,in the same order.
	 You can add coulmn names.

CREATE OR REPLACE VIEW customer_order_details AS
SELECT companyname, Orders.customerid,employeeid,requireddate,shippeddate,
Shipvia,freight,shipname,shipcity,shipregion,shippostalcode,shipcountry,
order_details.*,contactname
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;

CREATE OR REPLACE VIEW supplier_order_details AS
SELECT companyname,suppliers.supplierid,
Products.productid,productname,
Order_details.unitprice,quantity,discount,
orders.*,phone
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;

ALTER VIEW customer_order_details RENAME TO customer_order_detailed;

ALTER VIEW supplier_order_details RENAME TO supplier_orders;


---------Creating Updatable Views---------

*Note:-- You can update ,delete or insert into a view if:
	 Only ine table is referenced in FROM(could be another updatable view)
	 can't have GROUP BY,HAVING,LIMIT,DISTINCT,UNION,INTERSECT and EXCEPT in defining query.
	 can't any window functions,set returning function,or any aggregate functions like SUM,COUNT,AVG,MIN and MAX

  CREATE VIEW north_america_customers AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico');

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','USA','555-555-5555',null);

UPDATE north_america_customers SET fax='555-333-4141' WHERE customerid='CFDCM';

DELETE FROM north_america_customers WHERE customerid='CFDCM';

CREATE VIEW protein_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8);

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Kobe Beef',12,8,0);

UPDATE protein_products SET unitprice=55 WHERE productid=78;

DELETE FROM protein_products WHERE productid=78;
		
-----With Check Option--------

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);

SELECT FROM north_america_customers
WHERE customerid=’CFDCM’;

CREATE OR REPLACE VIEW north_america_customers  AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico')
WITH LOCAL CHECK OPTION;

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);

CREATE OR REPLACE VIEW protein_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8)
WITH LOCAL CHECK OPTION;

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Tasty Tea',12,1,0);

------------Deleting Views---------------

DROP VIEW IF EXISTS customer_order_detailed;

DROP VIEW IF EXISTS supplier_orders;


	################Section 20: Conditional Expressions#########

----------CASE WHEN---------

SELECT companyname,country,
CASE WHEN country IN ('Austria','Germany','Poland','France','Sweden','Italy','Spain',
             'UK','Ireland','Belgium','Finland','Norway','Portugal','Switzerland') THEN 'Europe'
             WHEN country IN ('Canada','Mexico','USA') THEN 'North America'
             WHEN country IN ('Argentina','Brazil','Venezuela') THEN 'South America'
             ELSE country
END AS continent
FROM customers;

SELECT productname,unitprice,
CASE WHEN unitprice<10 THEN 'inexpensive'
     WHEN unitprice>=10 AND unitprice<=50 THEN 'mid-range'
	 WHEN unitprice > 50 THEN 'premium'
END AS quality
FROM products;

-for nickname-

SELECT companyname,city,
CASE city WHEN 'New Orleans' THEN 'Big Easy'
                   WHEN 'Paris' THEN 'City of Lights' // paris replace with big easy
	         ELSE 'Needs nickname'
END as nickname
FROM suppliers;

SELECT orderid,customerid,
CASE date_part('year', orderdate)
	WHEN 1996 THEN 'year1'
	WHEN 1997 THEN 'year2'
	WHEN 1998 THEN 'year3'
END
FROM orders;

----------------COALESCE----------------

 ...The COALESCE function returns the first of its arguments that is not null. Null is returned only if all arguments are null. It is often used to substitute a default value for null values when data is retrieved for display

SELECT customerid,COALESCE(shipregion,'N/A') FROM orders;

SELECT companyname,COALESCE(homepage,'Call to find') from suppliers;


---------------NULLIF---------------------

.....used to return a null if two values are equal.used to trigger a null in COALESCE so next value is used.
     NULLIF(field1,field2)

UPDATE suppliers
SET homepage = ''
WHERE homepage IS NULL;

UPDATE customers
SET fax = ''
WHERE fax IS NULL;

SELECT companyname,phone,
COALESCE(NULLIF(homepage,''),'Need to call')
FROM suppliers;

SELECT companyname,
COALESCE(NULLIF(fax,''),phone) AS confirmation
FROM customers;

				#####################SEction 21: Using Date/Time IN PostgreSQL##############

     -----------Date, Time, and Timestamp Data Types-------------

Input String  	Valid Types			Description
epoch		date, timestamp		1970-01-01 00:00:00+00 (Unix system time zero)
infinity	date, timestamp		later than all other time stamps
-infinity	date, timestamp		earlier than all other time stamps
now		date, time,timestamp	current transaction's start time
today		date, timestamp		midnight (00:00) today
tomorrow	date, timestamp		midnight (00:00) tomorrow
yesterday	date, timestamp		midnight (00:00) yesterday
allballs	time			00:00:00.00 UTC



SHOW DateStyle;

SET DateStyle = 'ISO,DMY';

SET DateStyle = 'ISO,MDY'


CREATE TABLE test_time (
	startdate DATE,
	startstamp TIMESTAMP,
	starttime TIME
);

Insert INTO test_time (startdate, startstamp,starttime)
VALUES ('epoch'::abstime,'infinity'::abstime,'allballs');


SELECT * FROM test_time;

Insert INTO test_time (startdate, startstamp)
VALUES ('NOW'::abstime,'today'::abstime);


SELECT * FROM test_time;


--------------Time Zones-----------------

SELECT * FROM pg_timezone_names;

SELECT * FROM  pg_timezone_abbrevs;

ALTER TABLE test_time
ADD COLUMN endstamp TIMESTAMP WITH TIME ZONE;

ALTER TABLE test_time
ADD COLUMN endtime TIME WITH TIME ZONE;


INSERT INTO test_time
(endstamp,endtime)
VALUES ('01/20/2018 10:30:00 US/Pacific', '10:30:00+5');
INSERT INTO test_time (endstamp,endtime)
VALUES ('06/20/2018 10:30:00 US/Pacific', '10:30:00+5');

//Notice the difference in offset due to daylight savings time
SELECT * FROM test_time;


SHOW TIME ZONE;
//notice the offset of time
SELECT * FROM test_time;

SET TIME ZONE 'US/Pacific'

//notice offset changed
SELECT * FROM test_time;

----------------Interval Data Type---------------------

ALTER TABLE test_time
ADD COLUMN span interval;

DELETE  FROM test_time;

--Postgres Format
INSERT INTO test_time (span)
VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS');
INSERT INTO test_time (span)
VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS ago');

SELECT * FROM test_time;

--SQL Standard
INSERT INTO test_time (span)
VALUES ('4 32:12:10');

INSERT INTO test_time (span)
VALUES ('1-2');


--ISO 8061 Format
INSERT INTO test_time (span)
VALUES (‘P5Y3MT7H3M’)

INSERT INTO test_time (span)
VALUES ('P25-2-30T17:33:10');

SHOW intervalstyle;
SELECT * FROM test_time;

SET intervalstyle='postgres_verbose';
SELECT * FROM test_time;

SET intervalstyle='sql_standard';
SELECT * FROM test_time;

SET intervalstyle='iso_8601';
SELECT * FROM test_time;

SET intervalstyle='postgres';


-----------------Date Arithmetic---------------

SELECT DATE '2018-09-28' + INTERVAL '5 days 1 hour';

SELECT TIME '5:30:10' + INTERVAL '70 minutes 80 seconds';

SELECT TIMESTAMP '1917-06-20 12:30:10.222' +
  INTERVAL '30 years 6 months 7 days 3 hours 17 minutes 3 seconds';

SELECT INTERVAL '5 hours 30 minutes 2 seconds' +
      INTERVAL '5 days 3 hours 13 minutes';

SELECT DATE '2017-04-05' +  INTEGER '7';

-- subtracting intervals from date,time, timestamp
SELECT DATE '2018-10-20' - INTERVAL '2 months 5 days';

SELECT TIME '23:39:17' - INTERVAL '12 hours 7 minutes 3 seconds'

SELECT TIMESTAMP '2016-12-30' - INTERVAL '27 years 3 months 17 days 3 hours 37 minutes';

-- subtracting integer from date
SELECT DATE '2016-12-30' - INTEGER '300';

--subtracting 2 dates
SELECT DATE '2016-12-30' - DATE '2009-04-7';

-- subtracting 2 times and 2 timestamps
SELECT TIME '17:54:01' - TIME '03:23:45';

SELECT TIMESTAMP '2001-02-15 12:00:00' - TIMESTAMP '1655-08-30 21:33:05';

--Multiply and divide intervals
SELECT 5 * INTERVAL '7 hours 5 minutes';

SELECT INTERVAL '30 days 20 minutes' / 2;

SELECT age(TIMESTAMP '2025-10-03', TIMESTAMP '1999-10-03');
SELECT age (TIMESTAMP '1969-04-20');


------------------Pulling Out Parts of Dates and Times---------------

..Two Functions: 1: EXTRACT 2: date_part

 calculate the age of emp:-

SELECT EXTRACT(YEAR FROM age(birthdate)),firstname, lastname
FROM employees;

SELECT date_part('day', shippeddate)
FROM orders;

SELECT EXTRACT(DECADE FROM age(birthdate)),firstname, lastname
FROM employees;

SELECT date_part('DECADE',age(birthdate)),firstname, lastname
FROM employees;



---------------- Converting One Data Type Into Another------------

 Two ways to do type conversion: 1: CAST(value AS type) 2: value::type

SELECT hiredate::TIMESTAMP
FROM employees;

SELECT CAST(hiredate AS TIMESTAMP)
FROM employees;

can be used for other datatype also, like numbers to string, string to numbers.

SELECT (ceil(unitprice*quantity))::TEXT || ' dollars spent'    //cancatinate with dollars spent.
FROM order_details;

SELECT CAST('2015-10-03' AS DATE),  375::TEXT;


				###########################Section 22: Window Functions ########################

-------------Basic Window Function Example---------

SELECT categoryname,productname,unitprice,
AVG(unitprice) OVER (PARTITION BY categoryname)
FROM products
JOIN categories ON categories.categoryid=products.categoryid

SELECT productname,quantity,
AVG(quantity) OVER (PARTITION BY order_details.productid)
FROM products
JOIN order_details on order_details.productid = products.productid
WHERE productname='Alice Mutton'

SELECT productname,orderid,quantity,
AVG(quantity) OVER (PARTITION BY order_details.productid) AS average
FROM products
JOIN order_details on products.productid=order_details.productid


SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname


-------------Using Window Functions With Subqueries----------

...Nesting Queries gives yoy greate power...

someone ask you about fraud detection.

We want to know when an order comes in that is five times greater than a particular customer's average

order.How to do that...

SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname

SELECT companyname,month,year,total_orders,average_monthly
FROM (
SELECT companyname,total_orders,month,year,
AVG(total_orders) OVER (PARTITION BY companyname) as average_monthly
FROM (
SELECT companyname,SUM(quantity) as total_orders,date_part('month',orderdate) as month,date_part('year',orderdate) as year
FROM order_details
JOIN products ON order_details.productid = products.productid
JOIN suppliers ON suppliers.supplierid=products.supplierid
JOIN orders ON orders.orderid=order_details.orderid
GROUP BY companyname,month,year)  as order_by_month) as average_monthly
WHERE total_orders > 3 * average_monthly


---------------- Using Rank() To Find The First N Records In Join---------------

SELECT * FROM
(SELECT orders.orderid, productid, unitprice, quantity,
 	rank() OVER (PARTITION BY order_details.orderid ORDER BY (quantity*unitprice) DESC) AS rank_amount
FROM orders
NATURAL JOIN order_details) as ranked
WHERE rank_amount <=2;

SELECT companyname,productname,unitprice FROM
(SELECT companyname,productname,unitprice,
rank() OVER (PARTITION BY products.supplierid ORDER BY unitprice ASC) AS price_rank
FROM suppliers
NATURAL JOIN products) as ranked_products
WHERE price_rank <=3;








	





	


