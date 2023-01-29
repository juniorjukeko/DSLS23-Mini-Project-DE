CREATE OR ALTER VIEW dbo.FinalPrice AS
SELECT 
	dbo.[Order Details].OrderID, 
	dbo.[Order Details].ProductID, 
	dbo.Products.ProductName, 
	dbo.[Order Details].UnitPrice, 
	dbo.[Order Details].Quantity, 
	dbo.[Order Details].Discount,
	dbo.[Order Details].UnitPrice*dbo.[Order Details].Quantity*(1-dbo.[Order Details].Discount) as FinalPrice
FROM dbo.[Order Details] 
INNER JOIN dbo.Products 
	ON dbo.[Order Details].ProductID = dbo.Products.ProductID

