CREATE PROCEDURE Invoice(
	@customer_id AS VARCHAR(max))
AS
BEGIN
    SELECT
        Orders.CustomerID,
		CompanyName,
		ContactName as CustomerName,
		OrderID,
		OrderDate,
		RequiredDate,
		ShippedDate
    FROM dbo.Orders as Orders
	LEFT JOIN dbo.Customers as Customers
		ON Orders.CustomerID = Customers.CustomerID
	WHERE Orders.CustomerID = @customer_id
END;

-- Test Run
EXECUTE dbo.Invoice 'LAMAI'