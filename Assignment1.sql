--Antra Full Stack
--July 2021
--Answers to assignment 1
--Runge Yan

use AdventureWorks2019
go

--1
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p

--2
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p where p.ListPrice = 0

--3
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p where p.Color is null

--4
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p where p.Color is not null

--5
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p 
where p.Color is not null and p.ListPrice > 0

--6
select Name + ': ' + Color
from Production.Product where Color is not null

--7
select 'NAME: ' + Name + ' -- COLOR: ' + Color as "Name and Color"
from Production.Product 
where Name like '%C_a%' and Color in ('Black', 'Silver')

--8
select ProductID, Name
from Production.Product
where ProductID between 400 and 500

--9
select ProductID, Name, Color
from Production.Product
where Color in ('Black', 'Blue')

--10
select ProductID, Name
from Production.Product
where Name like 's%'

--11
select Name, ListPrice
from Production.Product
where Name like 's%'
order by Name

--12
select Name, ListPrice
from Production.Product
where Name like '[a,s]%'
order by Name

--13
select ProductID, Name
from Production.Product
where Name like 'spo[^k]%'

--14
select distinct Color 
from Production.Product
order by Color desc

--15
select distinct ProductSubcategoryID, Color
from Production.Product
where ProductSubcategoryID is not null and Color is not null

--16
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color not IN ('Red','Black') 
      OR ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1
ORDER BY ProductID

--17
--With the following query I'm able to retrieve a result set that contains everything in the question 
--but I found it hard to narrow it down any further. I couldn't derive any relationship between the four columns.

select distinct ProductSubCategoryID, Name, Color, ListPrice
from Production.Product
where ListPrice >= 539.99
	and ProductSubcategoryID < 15
	--with the following clause I can retrieve the exact result set but I guess it's too specific
	-- Name like 'HL%k, 58' or Name like 'HL Road Frame - Red%' or Name like '%350-W%' or Name like 'Mountain-500 B%' or Name like '%Frame - Silver%'
order by ProductSubcategoryID desc, ListPrice desc

