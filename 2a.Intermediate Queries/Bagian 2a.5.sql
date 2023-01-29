WITH OrdDetAgg as (
	SELECT
		OrderID,
		SUM(Quantity) as TotalQty,
		ROUND(SUM(Quantity*UnitPrice), 2) as TotalSales
	FROM dbo.[Order Details]
	GROUP BY OrderID
)
SELECT
	PurchaseCategory,
	COUNT(OrderID) as OrderCount
FROM(
	SELECT 
		OrderID,
		CASE 
			WHEN TotalSales <= 100 THEN '1. <=100'
			WHEN TotalSales <= 250 THEN '2. 100<X<=250'
			WHEN TotalSales <= 500 THEN '3. 250<X<=500'
			WHEN TotalSales >  500 THEN '4. >500'
		END as PurchaseCategory
	FROM OrdDetAgg
) as Subq1
GROUP BY PurchaseCategory
ORDER BY PurchaseCategory