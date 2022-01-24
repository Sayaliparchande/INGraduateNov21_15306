  ############Section 15: ##############

--------Creating and modifying table.---------

    CREATE TABLE---

CREATE TABLE subscribers (
	firstname varchar(200),
	 lastname varchar(200),
	email varchar(250),
	signup timestamp,
	frequency integer,
	iscustomer boolean
);

CREATE TABLE returns (
	returnrid serial,
	customerid char(5),
	returndate timestamp,
	productid integer,
	quantity smallint,
	orderid integer
);


 ALTER TABLE - Part One----

ALTER TABLE subscribers
RENAME firstname TO first_name;

ALTER TABLE returns
RENAME returndate TO return_date;

ALTER TABLE subscribers
RENAME TO email_subscribers;

ALTER TABLE returns
RENAME TO bad_orders;

ALTER TABLE - Part Two---

ALTER TABLE email_subscribers
ADD COLUMN last_visit_date timestamp;

ALTER TABLE bad_orders
ADD COLUMN reason text;


ALTER TABLE email_subscribers
DROP COLUMN last_visit_date;

ALTER TABLE bad_orders
DROP COLUMN reason;

ALTER TABLE - Part Three---

ALTER TABLE email_subscribers
ALTER COLUMN email SET DATA TYPE varchar(225);

ALTER TABLE bad_orders
ALTER COLUMN quantity SET DATA TYPE int;


--DROP TABLE----

DROP TABLE email_subscribers;

DROP TABLE bad_orders;

###########Section 16:#############

--------Table Constraints:----------

Types of Constraints:--

1. Check Constraints - check that all values must meet condition.
2. Not-Null Constraints - feild must have a value.
3. Unique Constraints - value must not already be in table.
4. Primary Keys - must have value and be unique,used to identify record.
5. Foreign Keys - all values must exist in another table.
6. Default Constraints - if no value provide,value is set to the default.

--NOT NULL Constraints--

CREATE TABLE IF NOT EXISTS practices (
	practiceid integer NOT NULL
);

INSERT INTO practices (practiceid)
VALUES (null);

DROP TABLE IF EXISTS practices;

CREATE TABLE IF NOT EXISTS practices (
practiceid integer NOT NULL,
practice_field varchar(50) NOT NULL
);

ALTER TABLE products
ALTER COLUMN unitprice SET NOT NULL;

ALTER TABLE employees
ALTER COLUMN lastname SET NOT NULL;


--UNIQUE Constraint--

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer UNIQUE,
  fieldname varchar(50) NOT NULL
);

INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field1');
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field2');


DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer UNIQUE,
    name varchar(25) NOT NULL
)

ALTER TABLE region
ADD CONSTRAINT region_description UNIQUE(regiondescription);

ALTER TABLE shippers
ADD CONSTRAINT shippers_companyname UNIQUE(companyname);

--PRIMARY KEY Constraint--

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
fieldname varchar(50) NOT NULL
);

INSERT INTO practices (practiceid,fieldname)
VALUES (1, null);
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field1');
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field2');

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
name varchar(25) NOT NULL
);

ALTER TABLE practices
DROP CONSTRAINT practices_pkey;

ALTER TABLE practices
ADD PRIMARY KEY (practiceid);

ALTER TABLE pets
DROP CONSTRAINT pets_pkey;

ALTER TABLE pets
ADD PRIMARY KEY (petid);

--FOREIGN KEY Constraint--

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
)


DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
)

ALTER TABLE practices
DROP CONSTRAINT practices_employeeid_fkey;

ALTER TABLE practices
ADD CONSTRAINT practices_employee_fkey
FOREIGN KEY (employeeid) REFERENCES employees(employeeid);

ALTER TABLE pets
DROP CONSTRAINT pets_customerid_fkey;

ALTER TABLE pets
ADD CONSTRAINT pets_customerid_fkey
FOREIGN KEY (customerid) REFERENCES customers(customerid);

--CHECK Constraint--

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

ALTER TABLE orders
ADD CONSTRAINT orders_freight CHECK (freight > 0);

ALTER TABLE products
ADD CONSTRAINT products_unitprice CHECK (unitprice > 0);


---DEFAULT Values----

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer DEFAULT 50 CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer DEFAULT 5 CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

ALTER TABLE orders
ALTER COLUMN shipvia SET DEFAULT 1;

ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5;

--Changing a Column's Default Value---

ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5

ALTER TABLE products
ALTER COLUMN reorderlevel DROP DEFAULT

ALTER TABLE suppliers
ALTER COLUMN homepage SET DEFAULT 'N/A'

ALTER TABLE suppliers
ALTER COLUMN homepage DROP DEFAULT

---Adding and Removing a Column's Constraint---

ALTER TABLE products
ADD CHECK ( reorderlevel > 0);

-- All rows must meet the condition
UPDATE products
SET reorderlevel = 0
WHERE reorderlevel is null or reorderlevel < 0;

ALTER TABLE products
ALTER COLUMN discontinued SET NOT NULL;

ALTER TABLE products
DROP CONSTRAINT products_reorderlevel_check;

ALTER TABLE products
ALTER COLUMN discontinued DROP NOT NULL;

ALTER TABLE order_details
ADD CHECK (unitprice > 0);

ALTER TABLE order_details
ALTER COLUMN discount SET NOT NULL;

ALTER TABLE order_details
DROP CONSTRAINT order_details_unitprice_check;

ALTER TABLE order_details
ALTER COLUMN discount DROP NOT NULL;



