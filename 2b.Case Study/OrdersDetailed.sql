WITH OrdCustomers as (
	SELECT
		OrderID,
		CompanyName
	FROM dbo.Orders as Ord
	LEFT JOIN dbo.Customers as Cust
		ON Ord.CustomerID = Cust.CustomerID
)
SELECT
	-- Fields from Order Details
	OrdDet.OrderID,
	OrdDet.UnitPrice,
	Quantity,
	Discount,
	-- Fields from Products
	ProductName,
	Discontinued,
	CategoryName,
	-- Fields from Customers
	CompanyName,
	-- Calculated Fields
	IIF(Discount > 0, 1, 0) as Discounted,
	OrdDet.UnitPrice*Quantity*(1-Discount) as Sales
FROM dbo.[Order Details] as OrdDet
LEFT JOIN dbo.Products as Prod
	ON OrdDet.ProductID = Prod.ProductID
LEFT JOIN dbo.Categories as ProdCat
	ON Prod.CategoryID = ProdCat. CategoryID
LEFT JOIN OrdCustomers
	ON OrdDet.OrderID = OrdCustomers.OrderID

