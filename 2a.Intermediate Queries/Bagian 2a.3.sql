SELECT 
	TOP 5
	Products.ProductName,
	SUM(OrdDetails.Quantity) as TotalQty
FROM dbo.Orders as Orders
LEFT JOIN dbo.[Order Details] as OrdDetails
	ON Orders.OrderID = OrdDetails.OrderID
LEFT JOIN dbo.Products as Products
	ON OrdDetails.ProductID = Products.ProductID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
GROUP BY ProductName
ORDER BY TotalQty DESC