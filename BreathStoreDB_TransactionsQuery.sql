------Normalizing a DB for better structuring to better understand our data
-- Drop View if Exists Product
-- CREATE VIEW Product AS
-- SELECT DISTINCT [Product ID], [Product Name], Category, [Sub-Category]
-- FROM Orders



-- Drop View if Exists Customer
-- CREATE VIEW Customer AS
-- SELECT DISTINCT [Customer ID], [Customer Name], [Segment]
-- FROM Orders


-- Drop View if Exists LocationAddress
-- CREATE VIEW LocationAddress AS
-- SELECT DISTINCT CONCAT([Postal Code], '-', City) as LocationPK, [City] [State], [Country], [Region], [Market]
-- FROM Orders



-- SELECT * INTO TempTran
-- FROM Orders
-- ALTER TABLE TempTran
-- DROP COLUMN [Product Name], [Category], [Sub-Category], [Customer ID], [Customer Name], [Segment],  [State], [Country], [Region], [Market]
-- DROP VIEW if EXISTS TransactionsLOog
-- CREATE VIEW TransactionsLOog AS
-- SELECT * FROM TempTran
-- SELECT * FROM TransactionsLOog
-- DROP TABLE if EXISTS TempTran

-- Drop View if Exists Transactions
-- CREATE VIEW Transactions AS
-- SELECT [Order ID], [Order Date], [Ship Date], [Ship Mode], [Sales], [Quantity], [Discount], [Profit], [Shipping Cost], [Order Priority], [Product ID], [Customer ID], CONCAT([Postal Code], '-', City) as LocationFK
-- FROM Orders


----Denormalizing back the tables from multiple views

-- Drop TABLE if exists detailedTransactions
-- SELECT Transactions.*, [Customer Name], [Segment], [Product Name], [Category], [Sub-Category],
--      [State], [Country], [Region], [Market]
-- INTO detailedTransactions
-- FROM Transactions
-- LEFT JOIN Customer ON Transactions.[Customer ID] = Customer.[Customer ID]
-- LEFT JOIN Product ON Transactions.[Product ID] = Product.[Product ID]
-- LEFT JOIN LocationAddress ON Transactions.[LocationFK] = LocationAddress.[LocationPK]




-- +++++++++++++++INTO OUR PORJECT PROPER +++++++++++++++--
----For us to get the complete Breath Store Data for complete transaction analysis. We have three
----different table inside the database we must JOIN to be able to query easily on Tableau or Power BI 
----without having to perform JOINS on the BI tools. Best practises require that TRANSFORMATIONS are performed
----closest to the data source for performance optimization.

-- SELECT  R.*, SP.[Sales Person]
-- FROM Returns as R
-- LEFT JOIN SalesPerson as sp ON R.[Region] = SP.Region

-- SELECT *
-- FROM Orders



CREATE VIEW BSTransactions AS
SELECT od.[Order ID], od.[Order Date], od.[Ship Date], od.[Ship Mode], od.[Customer Name], od.Segment, od.[Postal Code], od.City, 
        od.[State], od.Country, od.Region, od.Market, od.Category, od.[Sub-Category], od.[Product Name], od.Sales, od.Quantity,
        od.Discount, od.Profit, od.[Shipping Cost], od.[Order Priority], re.Returned, sp.[Sales Person]
FROM Orders as od
LEFT JOIN [Returns] re ON od.[Order ID] = Re.[Order ID]
LEFT JOIN SalesPerson as sp ON od.[Region] = SP.Region



