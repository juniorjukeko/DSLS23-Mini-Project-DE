WITH OrdDetAgg as (
	SELECT
		OrderID,
		SUM(Quantity) as TotalQty,
		SUM(ROUND(Quantity*UnitPrice*(1-Discount), 2)) as TotalSales
	FROM dbo.[Order Details]
	GROUP BY OrderID
)
SELECT
	-- Fields from Orders
	Ord.OrderID,
	OrderDate,
	DATEDIFF(day, OrderDate, '1998-05-07') as Recency,
	Freight,
	IIF(ShippedDate IS NULL, 0, 1) as ShippedStatus,
	IIF(ShippedDate > RequiredDate, 1, 0) as LateStatus,
	ShipCity,
	ShipCountry,
	-- Fields from Shippers
	Ship.CompanyName as ShipCompanyName,
	-- Fields from Customers
	Cust.CompanyName as CustCompanyName,
	--Fields from Order Details (Aggregated)
	TotalQty,
	TotalSales,
	-- Calculated Fields
	TotalSales - Freight as GrossProfit,
	ROUND((TotalSales - Freight)/Freight, 2) as FreightMarkup
FROM dbo.Orders as Ord
LEFT JOIN dbo.Shippers as Ship
	ON Ord.ShipVia = Ship.ShipperID
LEFT JOIN dbo.Customers as Cust
	ON Ord.CustomerID = Cust.CustomerID
LEFT JOIN OrdDetAgg
	ON Ord.OrderID = OrdDetAgg.OrderID