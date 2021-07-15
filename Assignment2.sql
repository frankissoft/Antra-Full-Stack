-----------------------
-- Concept Questions --
-----------------------

-- 1
-- A result set is returned from the execution of a select query statement

-- 2
-- Union all includes duplicate records while Union does not

-- 3
-- Intercept - retrieve common records in both result sets
-- Except - retrieve records exist only in the first result set and not in the second one

-- 4
-- Join combines columns based on matching keys while union combine rows 

-- 5
-- Inner join fetch matching non null records from both table
-- Full join fetch matching records from both table, non-matching record from both tables return as null

-- 6
-- Left join returns all the records from the left table and returns non-matching from the right table as null
-- Full join returns non-matching record from both tables return as null

-- 7
-- Cross join returns the Cartesian product of the sets of records from the two joined tables

-- 8
-- Having clause is for conditions with aggregate functions while where clause is for other conditions
-- Having clause is executed after the group by action and where clause is executed before

-- 9
-- No, but group by can be applied to multiple columns

-----------------
-- SQL Queries --
-----------------

use AdventureWorks2019
go

-- 1
-- There are 504 products in the Production.Product table
select count(1)
from Production.Product

-- 2
-- 295 products are part of a subcategory
select count(1)
from Production.Product
where ProductSubcategoryID is not null

-- 3
select count(1), ProductSubcategoryID
from Production.Product
group by ProductSubcategoryID

-- 4
-- 209 products don't have a product subcategory
select count(1)
from Production.Product
where ProductSubcategoryID is null

-- 5
-- 335974
select sum(Quantity)
from Production.ProductInventory

-- 6
select ProductID, Quantity as "TheSum"
from Production.ProductInventory
where LocationID = 40 and Quantity < 100

-- 7
select Shelf, ProductID, Quantity as "TheSum"
from Production.ProductInventory
where LocationID = 40 and Quantity < 100

-- 8
select avg(Quantity) as "AverageQuantity"
from Production.ProductInventory
where LocationID = 10

-- 9
-- I'm not quite sure about this
-- It doesn't make sense to select ProductID if we are grouping by Shelf
select Shelf, avg(Quantity) as "TheAvg"
from Production.ProductInventory
group by Shelf

-- 10
select Shelf, avg(Quantity) as "TheAvg"
from Production.ProductInventory
where Shelf is not null
group by Shelf

-- 11
select Color, Class, count(ProductID) as "TheCount", avg(ListPrice) as "AvgPrice"
from Production.Product
where Color is not null and Class is not null
group by Color, Class

-- 12
select cr.Name as "Country", sp.Name as "Province"
from Person.CountryRegion cr inner join Person.StateProvince sp
on cr.CountryRegionCode = sp.CountryRegionCode

-- 13
select cr.Name as "Country", sp.Name as "Province"
from Person.CountryRegion cr inner join Person.StateProvince sp
on cr.CountryRegionCode = sp.CountryRegionCode
where cr.Name in ('Germany', 'Canada')

use Northwind
go

-- 14
select distinct p.ProductID, p.ProductName
from Orders o inner join [Order Details] d
on o.OrderID = d.OrderID
inner join Products p
on d.ProductID = p.ProductID
where o.OrderDate > DATEADD(year, -25, GETDATE())

-- 15
select distinct top 5 o.ShipPostalCode, sum(d.Quantity) as ProductSold
from Orders o inner join [Order Details] d
on o.OrderID = d.OrderID
-- fourth record returns products sold with missing zip code info, filter it with "not null"
where o.ShipPostalCode is not null
group by o.ShipPostalCode
order by sum(d.Quantity) desc

-- 16 
-- Returns an empty result set, because the newest order date is more than 20 years ago - "1998-05-06 00:00:00.000"
select distinct top 5 o.ShipPostalCode, sum(d.Quantity) as ProductSold
from Orders o inner join [Order Details] d
on o.OrderID = d.OrderID
where o.OrderDate > DATEADD(year, -20, GETDATE())
group by o.ShipPostalCode
order by sum(d.Quantity) desc

-- 17
select City, count(CustomerID) as "TotalCustomer"
from Customers
group by City

-- 18
-- Empty result set - max number of customer is 6
select City, count(CustomerID) as "TotalCustomer"
from Customers 
group by City
having count(CustomerID) > 10

-- 19
select c.ContactName, o.OrderDate
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
where o.OrderDate > '1998-01-01 00:00:00.000'

-- 20
select c.ContactName, max(o.OrderDate) as "MostRecentOrderDate"
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
group by c.ContactName

-- 21
select c.ContactName, count(p.ProductID) as "ProductKindBought"
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
inner join [Order Details] d
on o.OrderID = d.OrderID
inner join Products p
on d.ProductID = p.ProductID
group by c.ContactName

-- 22
select c.ContactName, count(p.ProductID)
from Customers c inner join Orders o
on c.CustomerID = o.CustomerID
inner join [Order Details] d
on o.OrderID = d.OrderID
inner join Products p
on d.ProductID = p.ProductID
group by c.ContactName
having count(p.ProductID) > 100

-- 23
select distinct s.CompanyName as "Supplier Company Name", sh.CompanyName as "Shipping Company Name"
from Suppliers s inner join Products p on s.SupplierID = p.SupplierID
inner join [Order Details] d on p.ProductID = d.ProductID
inner join Orders o on o.OrderID = d.OrderID
inner join Shippers sh on sh.ShipperID = o.ShipVia

-- 24 
select o.OrderDate, p.ProductName
from Products p inner join [Order Details] d on p.ProductID = d.ProductID
inner join Orders o on o.OrderID = d.OrderID

-- 25
select e1.FirstName + ' ' + e1.LastName as "FirstEmployee", e2.FirstName + ' ' + e2.LastName as "SecondEmployee", e1.Title
from Employees e1 left join Employees e2
on e1.Title = e2.Title 
where e1.FirstName <> e2.FirstName and e1.LastName <> e2.LastName

-- 26
select e2.FirstName + ' ' + e2.LastName as "MngrWith>2Emp"
from Employees e1 left join Employees e2
on e1.ReportsTo = e2.EmployeeID
group by e2.FirstName, e2.LastName
having count(e2.EmployeeID) > 2

-- 27
SELECT City, s.CompanyName, 'Supplier' as "Type"
FROM Suppliers s
UNION  
SELECT City, c.CompanyName, 'Customer' as "Type"
FROM Customers c

-- 28
--select T1, T2
--from F1 inner join F2
--on F1.T1 = F2.T2

--		-----------------
--		|T1		|T2		|
--		|2		|2		|
--		|3		|3		|
--		-----------------

-- 29
--select T1, T2
--from F1 left join F2
--on F1.T1 = F2.T2

--		-----------------
--		|T1		|T2		|
--		|1		|null	|
--		|2		|2		|
--		|3		|3		|
--		-----------------