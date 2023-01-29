SELECT 
	DISTINCT CompanyName
FROM dbo.Orders as Orders
LEFT JOIN dbo.[Order Details] as OrdDetails
	ON Orders.OrderID = OrdDetails.OrderID
LEFT JOIN dbo.Products as Products
	ON OrdDetails.ProductID = Products.ProductID
LEFT JOIN dbo.Customers as Customers
	ON Orders.CustomerID = Customers.CustomerID
WHERE ProductName = 'Chai' AND
	YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 6
