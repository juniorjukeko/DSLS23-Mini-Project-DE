SELECT 
	MONTH(OrderDate) as MonthID,
	COUNT(DISTINCT CustomerID) as DistinctCustomer
FROM dbo.Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(OrderDate)
