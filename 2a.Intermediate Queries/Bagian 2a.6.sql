WITH OrdDetAgg as (
	SELECT
		OrderID,
		SUM(Quantity) as TotalQty,
		ROUND(SUM(Quantity*UnitPrice), 2) as TotalSales
	FROM dbo.[Order Details]
	GROUP BY OrderID
)
SELECT 
	DISTINCT Customers.CompanyName
FROM dbo.Orders as Orders
LEFT JOIN OrdDetAgg 
	ON Orders.OrderID = OrdDetAgg.OrderID
LEFT JOIN dbo.Customers as Customers
	ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 1997
	AND TotalSales > 500
ORDER BY CompanyName