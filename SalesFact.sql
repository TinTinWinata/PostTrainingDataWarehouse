-- Testing Query
SELECT * FROM SalesFact
SELECT * FROM FilterTimeStamp

IF EXISTS(
	SELECT * 
	FROM FilterTimeStamp
	WHERE TableName = 'SalesFact'
)
BEGIN
SELECT 
	MedicineCode,
	StaffCode,
	CustomerCode,
	TimeCode,
    [Total Sales Earning] = SUM(Quantity * MedicineSellingPrice),
    [Total Medicine Sold] = SUM(Quantity)
FROM
	VanMart..TrSalesHeader sh
	JOIN VanMart..TrSalesDetail sd ON sh.SalesID = sd.SalesID
	JOIN GoodsDimension gdim ON gdim.GoodsID = sd. GoodsID
	JOIN StaffDimension sdim ON sdim.StaffID = sh.StaffID
	JOIN CustomerDimension cdim ON cdim.CustomerID = sh.CustomerID
	JOIN BranchDimension bdim ON bdim.BranchID = sh.BranchID
	JOIN TimeDimension tdim on tdim.Date = sh.SalesDate
	WHERE 
		sh.SalesDate > (
			SELECT LastETL FROM FilterTimeStamp
			WHERE TableName = 'SalesFact'
		)
	GROUP BY GoodsCode, StaffCode, CustomerCode, TimeCode, BranchCode

SELECT * FROM  TimeDimension

SELECT * FROM
	VanMart..TrSalesHeader sh
	JOIN VanMart..TrSalesDetail sd ON sh.SalesID = sd.SalesID

END


ELSE
BEGIN 

SELECT 
	GoodsCode,
	StaffCode,
	CustomerCode,
	TimeCode,
	BranchCode,
	[Total Earning] = SUM (Quantity * GoodsSellingPrice),
	[Total Goods Sold] = SUM (Quantity)
FROM
	VanMart..TrSalesHeader sh
	JOIN VanMart..TrSalesDetail sd ON sh.SalesID = sd.SalesID
	JOIN GoodsDimension gdim ON gdim.GoodsID = sd. GoodsID
	JOIN StaffDimension sdim ON sdim.StaffID = sh.StaffID
	JOIN CustomerDimension cdim ON cdim.CustomerID = sh.CustomerID
	JOIN BranchDimension bdim ON bdim.BranchID = sh.BranchID
	JOIN TimeDimension tdim on tdim.Date = sh.SalesDate
	GROUP BY GoodsCode, StaffCode, CustomerCode, TimeCode, BranchCode

END

-- Sales Fact

 IF EXISTS(
	SELECT * 
	FROM FilterTimeStamp WHERE TableName = 'SalesFact'
 )
 BEGIN 
	UPDATE FilterTimeStamp
	SET LastETL = GETDATE()
	WHERE TableName ='SalesFact'
 END
 ELSE
 BEGIN
	INSERT INTO FilterTimeStamp VALUES ('SalesFact', GETDATE())
 END
