
-- Testing

SELECT * FROM TimeDimension
SELECT * FROM FilterTimeStamp

-- Time Dimension SELECT 
IF EXISTS(
	SELECT * 
	FROM VanMartOLAP..FilterTimeStamp
	WHERE TableName = 'TimeDimension'
)
 BEGIN 
	SELECT
	[Date] = x.Date,
	[Day] = DAY(x.Date),
	[Month] = MONTH(x.Date),
	[Quarter] = DATEPART(QUARTER, x.Date),
	[Year] = YEAR(x.Date)
	FROM (
		SELECT
		PurchaseDate AS [Date]
		FROM
		VanMart..TrPurchaseHeader
		UNION
		SELECT
		SalesDate AS [Date]
		FROM
		VanMart..TrSalesHeader
		UNION
		SELECT
		ReturnDate AS [Date]
		FROM
		VanMart..TrReturnHeader
		UNION
		SELECT
		SubscriptionStartDate AS [Date]
		FROM
		VanMart..TrSubscriptionHeader
	) AS x
	WHERE [Date] > (
					SELECT 
					LastETL
					FROM VanMartOLAP..FilterTimeStamp
					WHERE TableName = 'TimeDimension')

 END
 ELSE
 BEGIN
	SELECT
	[Date] = x.Date,
	[Day] = DAY(x.Date),
	[Month] = MONTH(x.Date),
	[Quarter] = DATEPART(QUARTER, x.Date),
	[Year] = YEAR(x.Date)
	FROM (
		SELECT
		PurchaseDate AS [Date]
		FROM
		VanMart..TrPurchaseHeader
		UNION
		SELECT
		SalesDate AS [Date]
		FROM
		VanMart..TrSalesHeader
		UNION
		SELECT
		ReturnDate AS [Date]
		FROM
		VanMart..TrReturnHeader
		UNION
		SELECT
		SubscriptionStartDate AS [Date]
		FROM
		VanMart..TrSubscriptionHeader
	) AS x
 END


 -- Inserting and Updating QUERY

 IF EXISTS(
	SELECT * 
	FROM FilterTimeStamp WHERE TableName = 'TimeDimension'
 )
 BEGIN 
	UPDATE FilterTimeStamp
	SET LastETL = GETDATE()
	WHERE TableName ='TimeDimension'
 END
 ELSE
 BEGIN
	INSERT INTO FilterTimeStamp VALUES ('TimeDimension', GETDATE())
 END

 
