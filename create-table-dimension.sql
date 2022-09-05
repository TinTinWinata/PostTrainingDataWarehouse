CREATE DATABASE VanMartOLAP

GO 
USE VanMartOLAP
GO

CREATE TABLE CustomerDimension(
	CustomerCode INT PRIMARY KEY IDENTITY,
	CustomerID CHAR(7),
	CustomerDOB DATE,
	CustomerGender VARCHAR(10),
	CustomerAddress VARCHAR(50),
	CustomerPhone VARCHAR(50),
	CustomerName VARCHAR(50)
)

CREATE TABLE GoodsDimension(
		GoodsSellingPrice INT,
		GoodsBuyingPrice INT,
		GoodsName VARCHAR(50), 
		GoodsID CHAR(7),
		GoodsCode INT PRIMARY KEY IDENTITY,
		ValidFrom DATE,
		ValidTo DATE
)


CREATE TABLE StaffDimension(
		StaffDOB DATE,
		StaffSalary INT,
		StaffGender VARCHAR(10),
		StaffName VARCHAR(50), 
		StaffCode INT PRIMARY KEY IDENTITY,
		StaffID CHAR(7),
		ValidFrom DATE,
		ValidTo DATE
)



CREATE TABLE SupplierDimension(
		SupplierCode INT PRIMARY KEY IDENTITY,
		SupplierID CHAR(7),
		SupplierName VARCHAR(50),
		SupplierAddress VARCHAR(50),
		CityName VARCHAR(50)
)

CREATE TABLE BranchDimension(
		BranchAddress VARCHAR(50),
		CityName  VARCHAR(50),
		BranchCode INT PRIMARY KEY IDENTITY,
		BranchID CHAR(7),
)

SELECT * FROM GoodsDimension
SELECT * FROM BranchDimension
SELECT * FROM BenefitDimension


CREATE TABLE BenefitDimension(
		BenefitCode INT PRIMARY KEY IDENTITY,
		BenefitID CHAR(7),
		BenefitName VARCHAR(50),
		BenefitPrice INT,
		ValidFrom DATE,
		ValidTo DATE,
)

SELECT 
BenefitID,
BenefitName,
BenefitPrice
FROM VanMart.dbo.MsBenefit

SELECT * FROM BenefitDimension

FROM VanMart.dbo.MsBenefit

CREATE TABLE TimeDimension(
		TimeCode INT PRIMARY KEY IDENTITY,
		[Month] INT, 
		[Quarter] INT,
		[Year] INT,
		[Day] INT,
		[Date] DATE,
)

CREATE TABLE SalesFact(
	GoodsCode INT,
	StaffCode INT,
	CustomerCode INT,
	TimeCode INT,
	BranchCode INT,
	[Total Earning] BIGINT,
	[Total Goods Sold] BIGINT
)

  CREATE TABLE ReturnFact(
	GoodsCode  INT,
	StaffCode INT,
	BranchCode INT,
	TimeCode INT,
	SupplierCode INT,
	[Total Goods Return] BIGINT,
	[Number of Staff] BIGINT,
  )

  CREATE TABLE PurchaseFact(
	GoodsCode INT,
	StaffCode INT,
	BranchCode INT,
	TimeCode INT,
	SupplierCode INT,
	[Total Purchase Sold]  BIGINT,
	[Total Goods Purchase]  BIGINT,
  )

  CREATE TABLE SubscriptionFact(
	CustomerCode INT,
	TimeCode INT,
	StaffCode INT,
	BenefitCode  INT,
	[Total Subscription] BIGINT,
	[Number of Subscriber] BIGINT,
  )


CREATE TABLE FilterTimeStamp(
	TableName VARCHAR(255) PRIMARY KEY,
	LastETL DATETIME,
)
