--Antra Full Stack
--July 2021
--Answers to assignment 3
--Runge Yan

-----------------------
-- Concept questions --
-----------------------

-- 1
-- Join and subquery are both used to retrieve complex records form multiple tables
-- In T-SQL, many subqueries can be rewritten with joins. 
-- While there's no performance difference between a subquery and join,
-- join performs better when existence must be checked,
-- and join returns better results when 
-- nested query must be processed for each result of the outer query to eliminate duplicates
-- For me, I prefer joins as they are more readable

-- 2
-- 'with' keyword specifies a common table expression (CTE)
-- CTE can be used in the execution scope of a single 
-- select, insert, update, delete, merge or create view statement

-- 3
-- Table variable is a like local variable with well-defined scope that store data temporarily
-- It can be used in function, stored procedure or batch
-- It can be declared with declare keyword and a '@' should be added to the front of the varibale name

-- 4
-- Delete deletes one or more rows from a table or a view
-- Truncate deletes all the rows in a table without logging individual row deletion
-- On deleteing the table, truncate performs better

-- 5
-- Identity column provides a unique, incremental value and only one can be created for each table
-- Delete retains the identity column while truncate resets identity column to seed value

-- 6
-- delete deletes multiple rows that match the condition clause and logs each row deleted
-- truncate deletes the whole table with no log deletion of each row 

-------------------
-- T-SQL queries --
-------------------

use Northwind
go

-- 1
-- subquery
select distinct City from Customers
where City in 
	(select distinct City
	from Employees)

-- join
select distinct c.City 
from Customers c inner join Employees e
on c.City = e.City

-- 2
-- subquery
select distinct City from Customers
where City not in
	(select distinct City
	from Employees)

-- join
select distinct c.City 
from Customers c left join Employees e
on c.City = e.City
where e.City is null

-- 3
-- subquery xx
select (
	select p.ProductName
	from Products p
	where p.ProductID = od.ProductID
	) as "Product Name", sum(od.Quantity) as "ProductQuantity"
from [Order Details] od
group by od.ProductID
order by [Product Name]

-- join
select p.ProductName, sum(d.Quantity) as "ProductQuantity"
from Products p inner join [Order Details] d
on p.ProductID = d.ProductID
group by p.ProductName

-- 4
-- by total I mean product type
select c.City, count(p.ProductID) as "Product Type Number"
from Customers c inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] d on o.OrderID = d.OrderID
inner join Products p on p.ProductID = d.ProductID
group by c.City

-- by total I mean product quantity
select c.City, sum(d.Quantity) as "Product Quantity Number"
from Customers c inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] d on o.OrderID = d.OrderID
group by c.City

-- 5
-- simple
select City, count(CustomerID) as "Customer Number"
from Customers
group by City
having count(CustomerID) >= 2

-- subquery 
select distinct c2.City
from Customers c2
where c2.City in (
	select City
	from Customers
	group by City
	having count(CustomerID) >= 2
)
---- union xx

-- 6
-- join
select City, count(p.ProductID) as "Product Type Number"
from Customers c inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] d on o.OrderID = d.OrderID
inner join Products p on p.ProductID = d.ProductID
group by City
having count(p.ProductID) >= 2

-- subquery
select distinct c2.City
from Customers c2
where c2.City in (
	select c.City
	from Products p inner join [Order Details] od on p.ProductID = od.ProductID
	inner join Orders o on od.OrderID = o.OrderID
	inner join Customers c on c.CustomerID = o.CustomerID
	group by c.City
	having count(p.ProductID) >= 2
)

-- 7
-- join
select distinct c.ContactName
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
where o.ShipCity <> c.City

-- 8
select top 5 p.ProductID, count(p.ProductID) as "Product Order Number",
	avg(od.UnitPrice) as "Average Price", count(c.City) as "Most Popular Customer City"
from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
inner join Orders o on od.OrderID = o.OrderID
inner join Customers c on o.CustomerID = c.CustomerID
group by p.ProductID
order by count(p.ProductID) desc

-- 9
-- join
select e.city as "Cities w/ Employees"
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
right join Employees e
on c.City = e.City
where c.City is null

-- subquery
select e.City
from Employees e
where e.City not in (
	select city
	from Customers c inner join Orders o
	on c.CustomerID = o.CustomerID
)

-- 10
select c.City, count(o.OrderID), sum(od.Quantity)
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID
inner join Customers c on c.CustomerID = o.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Products p on p.ProductID = od.ProductID
group by c.City
order by count(o.OrderID) desc, sum(od.Quantity) desc

-- 11 
--select columns, count(*)
--from table1
--group by columns
--having count(*) > 1

---- 12
--select e3.empid
--from Employee e3
--where e3.empid not in (
--	select e.empid
--	from Employee e1, Employee e2
--	where e1.mgrid = e2.empid
--)

---- 13
--select d.deptname, count(empid) as "Count of Employees"
--from Employee e inner join Dept d
--on e.deptid = d.deptid
--where count(empid) = dt.count(empid)
--(
--	select top 1 count(empid) as "Count of Employees"
--	from Employee e inner join Dept d
--	on e.deptid = d.deptid
--	group by deptid
--	order by count(empid) desc
--) dt
--group by deptid
--order by count(empid)

---- 14
--select *
--from (
--	select d.deptname, e.empid, 
--	rank() over(order by d.eptid desc) rankSalary
--	from Dept d inner join Employee e
--	on d.deptid = e.deptid
--) dt
--where dt.rankSalary < 4