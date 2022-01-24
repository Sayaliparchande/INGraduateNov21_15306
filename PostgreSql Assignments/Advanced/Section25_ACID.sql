####################Section 25:Transactions and concurrency control ###################

------------------ACID Transactions---------------------
--Db Transactions: a group of db stmts that are performed together.
--4 properties:
--ACID:-
1.A-Atomicity: 
-all the opertaions in transaction work or none of them work.
-Everything is done as a single unit.
2.C-Consistency:
-All transactions change the database state properly.
3.I-Isolation:
-Trasaction won't interface with each other.
4.D-Durability:
-the changes or result won't be lost if there is a system failure.if db crashes after commit,
-you are guaranteed the effects will still be there.

--------------------Simple Transaction Control------------

BEGIN TRANSACTION;
	UPDATE products
	SET reorderlevel = reorderlevel - 5;

	SELECT COUNT(*)
	FROM products
	WHERE unitsinstock + unitsonorder < reorderlevel;

END TRANSACTION;


BEGIN TRANSACTION;
	UPDATE orders
	SET requireddate = requireddate + INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-12-01' AND '1997-12-31';

	UPDATE orders
	SET requireddate = requireddate - INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-11-01' AND '1997-11-30';

END TRANSACTION;

-------------------------Rollbacks & Savepoints--------------

START TRANSACTION;

UPDATE orders
SET orderdate = orderdate + INTERVAL '1 YEAR';

ROLLBACK;


START TRANSACTION;

INSERT INTO employees (employeeid,lastname,firstname,title,birthdate,hiredate)
VALUES (501,'Sue','Jones','Operations Assistant','1999-05-23','2017-06-13');

SAVEPOINT inserted_employee;

UPDATE employees
SET birthdate='2025-07-11';

ROLLBACK TO inserted_employee;

UPDATE employees
SET birthdate='1998-05-23'
WHERE employeeid=501;

COMMIT;

SELECT *
FROM employees
WHERE employeeid=501;

-----------------------SQL Transaction Isolation------------

SQL Standard Definitions:

-there are 3 phenomena which are prohibated at diff isolation levels:
1.Dirty Reads:A transaction read data written by aother unfinished transaction runningat the same time.
2.Nonrepeatable reads:When during the course of a transaction,a row is retrived twice and the values within the row differ between reads.
3.Phantom reads:Occurs when in the course of a transaction, new rows are added or removed by another transaction to the record being read.

SQL Isolation Levels:

1.Read Uncommitted: Lowest isolation level-allow dirty reads,non-repeatable reads,and phantom reads.can see uncommitted changes made by other transactions.
2.Read Commited: Allows non-repeatable reads and phantom reads.Guarantees that any data read is committed at the moment it is read.but the next read in transaction might find different data.
3.Repeatable Reads:Allows phantom reads.new rows could be added or rows removed your transaction between reads.
4.Serializable:Highest isolation level.All types of read errorrs are avoided during your transaction.

---------------------PostgreSQL Transaction Isolation--------------
PostgreSql Uses MVCC:

Multiversion Concurrency Control
Data is not Overwritten, but changes are timstamped.
each stmt sees a snapshot based on how the data lookd at a give timstamp.
this prevents conflict based on locking records during transaction.




