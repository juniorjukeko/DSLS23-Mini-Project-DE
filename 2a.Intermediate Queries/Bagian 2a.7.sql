WITH SalesByMonth as (
	SELECT 
		MONTH(OrderDate) as MonthID,
		ProductName,
		SUM(OrdDetails.UnitPrice*Quantity) as Sales
	FROM dbo.Orders as Orders
	LEFT JOIN dbo.[Order Details] as OrdDetails
		ON Orders.OrderID = OrdDetails.OrderID
	LEFT JOIN dbo.Products as Products
		ON OrdDetails.ProductID = Products.ProductID
	WHERE YEAR(OrderDate) = 1997
	GROUP BY MONTH(OrderDate), ProductName
)
SELECT
	*
FROM(
	SELECT
		*,
		RANK() OVER(PARTITION BY MonthID ORDER BY Sales DESC) as MonthlyRank
	FROM SalesByMonth
) as Subq1
WHERE MonthlyRank <= 5