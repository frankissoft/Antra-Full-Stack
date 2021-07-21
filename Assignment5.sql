--Antra Full Stack
--July 2021
--Answers to assignment 5
--Runge Yan

-----------------------
-- Concept Questions --
-----------------------

-- 1
-- An object in SQL is an SQL resource: schemas, tables, aliases, views,
-- indexes, constraints, triggers, sequences, stored procedures, user-defined functions,
-- user-defined data types, global variables, etc. are all objects in SQL

-- 2
-- 3
-- 4
-- 5
-- 6
-- 7

-- 8
-- Normalization  is a process of organizing data in accordance with a series of normal forms
-- in order to minimize redundancy. To achieve normalization, following normal forms are acheived:
-- First normal form
-- Second normal form
-- Third normal form
-- Boyce-Codd normal form

-- 9
-- Denormalization is a strategy used on a normalized database to increase read performance.
-- It generates redundant data or groups data and is preferable when a large numbers of 
-- read operations is needed in database software

-- 10
-- Data integrity can be achieved by constraints and triggers
-- Constraints are divided into 3 catagories:
-- Domain integrity
-- Entity integrity
-- Referential integrity

-- 11
-- primary key, foreign key, not null, unique, check, default, create index, etc.

-- 12
-- Primary key is the column or a combination of columns that uniquely identify each row in the table. 
-- No null value is allowed in primary key. It enforces entity integrity.
-- Unique key also helps identify each row in the table while
-- at most one null value is allowed in unique key.

-- 13
-- A foreign key is a column or combination of columns that is used to establish
-- and enforce a link between the data in two tables

-- 14
-- Yes. Multiple foreign keys in one table and each foreign key referencing different parent table.

-- 15
-- Foreign keys have to be unique. Foreign keys can be null.

-- 16

-- 17
-- A transaction is a single unit of work. It's either successful or unsuccessful, with the result of commiting and rolling back.
-- There are five isolation levels in transaction:
-- read uncommitted, read committed, repeatable read, snapshot and serializable

---------------------
-- Query questions --
---------------------

use JulyBatch
go

-- 1
create table Customer(Cust_ID int, Cust_Name varchar(50))
create table Orders(Order_ID int, Cust_ID int, Amount money, Order_Date smalldatetime)

select c.Cust_Name, sum(o.Amount)
from Customer c inner join Orders o on c.Cust_ID = o.Cust_ID
group by c.Cust_Name
go
-- 2
create table Person(ID int, FirstName varchar(100), LastName varchar(100))

select FirstName + ' ' + LastName as 'Personnel Name'
from Person where LastName like 'A%'
go
-- 3
create table Personnel(Person_ID int primary key, Manager_ID int null, Person_Name varchar(100) not null)

select Manager_ID, count(Person_ID) as 'Personnel Supervised'
from Personnel
where Manager_ID in (

	select p1.Person_ID
	from Personnel p1, Personnel p2
	where p1.Person_ID = p2.Manager_ID and p1.Manager_ID is null

)
group by Manager_ID
go
-- 4
-- Trigger can be fired by DDL, DML and LOGON events

-- 5
create schema destination
	
	create table Company (CompanyID int primary key,
		CompanyName varchar(30))
	create table Division (DivisionID int primary key, CompanyID int, 
		DivisionName varchar(20), DivisionAddress varchar(50))
	create table Contact (ContactID int primary key, DivisionID int, 
		Suite int, Email varchar(20))

go