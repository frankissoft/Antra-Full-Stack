--Antra Full Stack
--July 2021
--Answers to assignment 4
--Runge Yan

-----------------------
-- Concept Questions --
-----------------------

-- 1 
-- View is a virtual table whose contents are defined by a query.
-- View is not a stored set of records unless indexed.

-- 2
-- Yes. Table data can be modified through a view with keywords:
-- update, insert, delete, etc.

-- 3
-- A stored procedure is a group of T-SQL statements or 
-- a reference to a .NET Framework common runtime language (CLR) method
-- Benefits of using stored procedure
-- (1) Reduced server/client network traffic
-- (2) Stronger security
-- (3) Reuse of code
-- (4) Easier maintenance
-- (5) Improved performance

-- 4
-- The view is used to provide a safe retrieval - focus the results
-- the stored procedure runs a set of frequently used statements - focus on the process
-- Stored procedure can be used to create view

-- 5
-- A function is a T-SQL or CLR routine that accepts parameters,
-- performs an action, and returns the result of that action as a value.
-- Function can be used to replace a stored procedure
-- A parameter that has a default value must be specified with default keyword while
-- in stored procedure, the keyword is implied
-- Stored procedure is easier to create while function has a more rigid structure


-- 6
-- Yes. Multiple result sets will be retrieved when there are multiple
-- select statements in the stored procedure

-- 7
-- No. A stored procedure can be executed with explictly the execute keyword 
-- or by calling its name at the beginning of a new batch. It can also be executed
-- automatically when an instance of SQL Server starts.

-- 8
-- Triggers are actions fired by certain events
-- There are 3 kinds of triggers in T-SQL: logon, DDL and DML

-- 9
-- Logon triggers fire stored procedures in response to a LOGON event
-- DDL triggers fire statements in response to DDL events
-- DML triggers fire statements in response to DML events
-- The caller of the trigger is the user that executes the statments that causes the trigger to run

-- 10
-- A stored procedure is like a method that can be called by the user
-- while a trigger is like a event handler that will be fired automatically
-- Therefore, stored procedures can receive parameters and return a value

-------------
-- Queries --
-------------

use Northwind
go



-- 1
insert into Region (RegionID, RegionDescription) values (5, 'Middle Earth')
go

insert into Territories (TerritoryID, TerritoryDescription, RegionID) 
values (01023, 'Gondor', 5)
go

update Territories
set TerritoryID = '01023'
where TerritoryDescription = 'Gondor'
go

insert into Employees (LastName, FirstName) 
values ('Aragorn', 'King')
go

insert into EmployeeTerritories(EmployeeID, TerritoryID) 
values (10, '01023')
go

--select EmployeeID, LastName, FirstName
--from Employees


-- 2
update Territories
set TerritoryDescription = 'Arnor'
where TerritoryDescription = 'Gondor'

-- 3
delete from EmployeeTerritories
where TerritoryID = '01023'

delete from Territories
where TerritoryID = '01023'

delete from Region
where RegionDescription = 'Middle Earth'
go

--select * from EmployeeTerritories
--select * from Region
--select * from Territories
--select * from Employees where EmployeeID = 10

-- 4
create view view_product_order_yan
as
select p.ProductName, sum(od.Quantity) as 'Product Quantity'
from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductName
go

-- 5
-- drop proc sp_product_order_quantity_yan
create proc sp_product_order_quantity_yan
	@PID int,
	@Quantity int out
as
begin
	select @Quantity=count(od.OrderID)
	from Products p inner join [Order Details] od
	on p.ProductID = od.ProductID
	where @PID = p.ProductID
	group by p.ProductID
end

begin
declare @q int
exec sp_product_order_quantity_yan 2, @q out
print @q
end

go

-- 6
create proc sp_product_order_city_yan
	@PName varchar(40)
as
	select top 5 c.City
	from Products p inner join [Order Details] od on p.ProductID = od.ProductID
	inner join Orders o on od.OrderID = o.OrderID
	inner join Customers c on o.CustomerID = c.CustomerID
	where p.ProductName = @PName
	group by p.ProductID, c.City
	order by p.ProductID, sum(od.Quantity)
return
go

sp_product_order_city_yan 'Chang'
go

-- 7
--select * from Region
--select * from Territories
--where TerritoryDescription like 'T%'

--create proc sp_move_employees_yan
--as	
--	with sp_CTE
--	as 
--	(select e.EmployeeID, t.TerritoryID, r.RegionID
--	from EmployeeTerritories et inner join Territories t on et.TerritoryID = t.TerritoryID
--	inner join Region r on t.RegionID = r.RegionDescription
--	inner join Employees e on e.EmployeeID = et.EmployeeID
--	where t.TerritoryDescription = 'Tory')
--	select * from sp_CTE
--	if not exists(select * from sp_CTE)
--		return
--	else
--		insert into Territories(TerritoryID, TerritoryDescription, RegionID) 
--		values ('00321', 'Stevens Point', 3)
--		update EmployeeTerritories
--		set TerritoryID = '00321'
--		where Terri = 'Gondor'
--		return
--return

--select * 
--from Territories
--where TerritoryDescription = 'Tory'

-- 8
--create trigger t_move_emp_yan
--on EmployeeTerritories
--instead of insert, update
--as 
--	declare @row_count int
--	select @row_count = count(t.TerritoryDescription) from EmployeeTerritories et
--	inner join Territories t on et.TerritoryID = t.TerritoryDescription
--	where t.TerritoryDescription = 'Troy'

--	if @row_count > 100
		
-- 9
--create table People_Yan(ID int primary key, PeopleName varchar(30), City varchar(20))
--create table City_Yan(ID int primary key, City varchar(20))

--insert into City_Yan values (1, 'Seattle'), (2, 'Green Bay')
--insert into People_Yan values (1, 'Aaron Rodgers', 2), (2, 'Russell Wilson', 1), (3, 'Jody Nilson', 2)

update City_Yan
set City = 'Madison'
where City = 'Seattle'

update People_Yan
set City = 'Madison'
where City = 'Seattle'
go

create view Packers_Yan
as select p.PeopleName from People_Yan p inner join City_Yan c on p.City = c.ID
where c.City = 'Green Bay'
go
-- 10

create proc sp_birthday_employees_Yan
as
begin
	select * into birthday_employees_Yan
	from Employees
	where month(Birthdate) = 2
end
go

sp_birthday_employees_Yan
go

--select * from birthday_employees_Yan

-- 11
-- join
create proc sp_yan_1
as
begin
	select c.City
	from Products p inner join [Order Details] od on p.ProductID = od.ProductID
	inner join Orders o on od.OrderID = o.OrderID
	inner join Customers c on o.CustomerID = c.CustomerID
	group by c.City, c.CustomerID
	having count(p.ProductID) <= 1 and count(c.CustomerID) >= 2
end
go

sp_yan_1
go

-- subquery
create proc sp_yan_2
as
begin
	select c2.City
	from 
	(
		select c.CustomerID, count(p.ProductID) as 'ProductCount'
		from Products p inner join [Order Details] od on p.ProductID = od.ProductID
		inner join Orders o on od.OrderID = o.OrderID
		inner join Customers c on o.CustomerID = c.CustomerID
		group by c.CustomerID
		having count(p.ProductID) < 2
	) as dt inner join Customers c2 on dt.CustomerID = c2.CustomerID
	group by c2.City
	having count(c2.CustomerID) >= 2
end
go

sp_yan_2
go

-- 12
-- with intercept keyword tells us about common records in two tables
-- except keywork tells us about different records in two tables
-- with table a and table b, 
-- if both the following statments return empty result set, then they have the same data
-- select * from a except select * from b
-- select * from b except select * from a

-- 14
create table Names(FirstName varchar(15), LastName varchar(15), MiddleName varchar(15))

insert into Names values ('John', 'Green', '')
insert into Names values ('Mike', 'White', 'M')

select FirstName + ' ' + LastName + ' ' + substring(MiddleName, 1, 1) + '.' as 'Full Name'
from Names

create table Marks(Student varchar(15), Marks int, Sex varchar(1))
insert into Marks values ('Ci', 70, 'F'), ('Bob', 80, 'M'), ('Li', 90, 'F'), ('Mi', 95, 'F') 

update Marks
set Sex = 'M'
where Student = 'Mi'

-- 15
select * from Marks 
where Sex = 'F'
order by Marks desc

-- 16
select * from Marks 
order by Sex, Marks desc