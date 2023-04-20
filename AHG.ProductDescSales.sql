/*SALES and COST ANLYSIS*/

SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty] OrderVolume,
SOH.[OrderDate],
DATENAME(DAY, SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR, SOH.OrderDate) AS [Year of Transaction],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[UnitPriceDiscount],
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country
 
 ,Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID

----------------------------------------------------------------------------
/* Cost and Price Comparison for Bikes (Why the loss in Store channel)*/

SELECT
 
Distinct PPM.[Name] ProductModelName,
PC.Name ProductCategory,
SOD.[UnitPrice],
PP.[StandardCost],
ST.[Name] Region,
ST.[CountryRegionCode] Country
 
 ,Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID

where PC.Name  = 'Bikes'
----------------------------------------------------------------------------
/*SALES REASONS*/

SELECT 
SOH.CustomerID,
SOD.[SalesOrderID],
ST.[Name] Region,
ST.[CountryRegionCode] Country
,Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels
,CASE 
WHEN SR.[SalesReasonID] = 1 THEN 'Price'  
WHEN SR.[SalesReasonID] = 2 THEN 'On Promotion'  
WHEN SR.[SalesReasonID] = 3 THEN 'Magazine Advertisement'  
WHEN SR.[SalesReasonID] = 4 THEN 'Television  Advertisement'  
WHEN SR.[SalesReasonID] = 5 THEN 'Manufacturer'  
WHEN SR.[SalesReasonID] = 6 THEN 'Review'  
WHEN SR.[SalesReasonID] = 7 THEN 'Demo Event' 
WHEN SR.[SalesReasonID] = 8 THEN 'Sponsorship'
WHEN SR.[SalesReasonID] = 9 THEN 'Quality'
WHEN SR.[SalesReasonID] = 10 THEN 'Other'

 END AS SalesReasons

FROM [Sales].[SalesOrderHeaderSalesReason] AS SOHR
LEFT JOIN [Sales].[SalesReason] AS SR
ON SOHR.SalesReasonID = SR.SalesReasonID
LEFT JOIN [Sales].[SalesOrderDetail] SOD
ON SOHR.SalesOrderID = SOD.SalesOrderID
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID

----------------------------------------------------------------------------
 /*COST ANALYSIS*/

SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(DAY, SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR, SOH.OrderDate) AS [Year of Transaction],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country

 ,Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS Channels

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID 
 
--------------------------------------------------------------------------

/* Product Orders  AND sCARP and Production Location(Manufacturing)*/

SELECT *

FROM[Production].[WorkOrder]
------------------------------------------------------------------------
/*WORK/OPERATION SEQUENCE AND LOCATION/DEPT*/

SELECT 
DISTINCT WOR.[OperationSequence],
PL.[LocationID],
PL.[Name]

FROM [Production].[WorkOrderRouting] WOR
LEFT JOIN [Production].[Location] PL
ON PL.LocationID=WOR.LocationID
LEFT JOIN[Production].[WorkOrder] PW
ON WOR.WorkOrderID=PW.WorkOrderID
LEFT JOIN [Production].[ScrapReason] PS
ON PW.ScrapReasonID = PS.ScrapReasonID
Left JOIN [Production].[Product] PP
ON PW.ProductID =PP.ProductID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
ORDER BY WOR.[OperationSequence] ASC

------------------------------------------------------------------------

/*WORK ORDER, AND LOCATION/CATEGORY*/

SELECT
PW.[ProductID],
PW.[OrderQty] WorkOrderQty,
PW.[StartDate] WorkOrderStartDate,
PW.[DueDate]WorkOrderDueDate,
PW.[EndDate]WorkOrderEndDate,
DATEDIFF (day, PW.[StartDate] , PW.[EndDate] )  deliveryDate,
DATEDIFF (day, PW.[StartDate] , PW.[DueDate] )  DueDelDate,
PW.[ScrappedQty] QtyProductScrap,
PS.[Name] Product_ScapReason,
WOR.[OperationSequence],
PL.[Name] ProductLocation,
PC.[Name] ProductCategory,
PPM.Name ProductmodelName



,CASE
             WHEN DATEDIFF (day, PW.[StartDate] , PW.[EndDate] ) <= 11 THEN 'Meet Delivery'
            WHEN DATEDIFF (day, PW.[StartDate] , PW.[EndDate] ) >11 THEN 'Delayed Delivery'

			End As [WorkOrder Delivery Status]

FROM [Production].[WorkOrderRouting] WOR
LEFT JOIN [Production].[Location] PL
ON PL.LocationID=WOR.LocationID
LEFT JOIN[Production].[WorkOrder] PW
ON WOR.WorkOrderID=PW.WorkOrderID
LEFT JOIN [Production].[ScrapReason] PS
ON PW.ScrapReasonID = PS.ScrapReasonID
Left JOIN [Production].[Product] PP
ON PW.ProductID =PP.ProductID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID



SELECT
DISTINCT PW.ScrapReasonID,
PS.Name

FROM [Production].[WorkOrder] PW
LEFT JOIN [Production].[ScrapReason] PS
ON PW.ScrapReasonID = PS.ScrapReasonID
WHERE PS.Name IS NOT NULL

 
 SELECT 
pp.[ProductID],
PW.[OrderQty] WorkOrderQty,
wor.[ScheduledStartDate],
wor.[ActualStartDate],
wor.ScheduledEndDate,
wor.[ActualEndDate],
DATEDIFF (day, wor.[ActualStartDate] , wor.[ActualEndDate] )  WorkDays,
DATEDIFF (day, wor.[ScheduledStartDate] , wor.[ActualStartDate] )  WorkStartDelays,
pl.[Name],
wor.PlannedCost,
wor.ActualCost,
wor.[ActualCost] - wor.[PlannedCost] costOver_Less
--case
--when (wor.[ActualCost] - wor.[PlannedCost]) >0 then costoverPlanned
--when (wor.[ActualCost] - wor.[PlannedCost]) <1 then costbelowPlanned

--end as PlannedCostStatus
FROM [Production].[WorkOrderRouting] WOR
LEFT JOIN [Production].[Location] PL
ON PL.LocationID=WOR.LocationID
LEFT JOIN[Production].[WorkOrder] PW
ON WOR.WorkOrderID=PW.WorkOrderID
Left JOIN [Production].[Product] PP
ON PW.ProductID =PP.ProductID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID


SELECT 
pp.[ProductID],
wor.[ScheduledStartDate],
wor.[ActualStartDate],
wor.ScheduledEndDate,
wor.[ActualEndDate],
pl.[Name],
DATEDIFF (day, wor.[ScheduledStartDate] , wor.[ScheduledEndDate] ) OfficialManufDays,
DATEDIFF (day, wor.[ActualStartDate] , wor.[ActualEndDate] ) ActualManufDays,
DATEDIFF (day, wor.[ScheduledStartDate] , wor.[ActualStartDate] ) DiffSartDate,
DATEDIFF (day, wor.ScheduledEndDate , wor.[ActualEndDate] )  DiffEndDate
FROM [Production].[WorkOrderRouting] WOR
LEFT JOIN [Production].[Location] PL
ON PL.LocationID=WOR.LocationID
LEFT JOIN[Production].[WorkOrder] PW
ON WOR.WorkOrderID=PW.WorkOrderID
LEFT JOIN [Production].[ScrapReason] PS
ON PW.ScrapReasonID = PS.ScrapReasonID
Left JOIN [Production].[Product] PP
ON PW.ProductID =PP.ProductID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID

--------------------------------------------------------------------------
/* No of online Customers*/

Select
distinct SC.CustomerID,
DATEDIFF (year,B.[BirthDate],B.DateFirstPurchase) Age


FROM[Sales].[Customer] SC
left JOIN [Sales].[SalesOrderHeader] SOH
ON SC.CustomerID=SOH.CustomerID
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
 where SOH.OnlineOrderFlag =1 
 --Group by SOH.CustomerID,B.[BirthDate],SOH.[OrderDate]
 ORDER BY B.[BirthDate] DESC
 
--------------------------------------------------------------------
/*Change in Online Customer Demography*/

SELECT
Distinct SOH.CustomerID,
DATENAME(YEAR,B.[DateFirstPurchase]) AS [Year of 1stTransaction],
DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) Age,
B.[EnglishEducation],
B.[EnglishOccupation],
B.[YearlyIncome],
B.[HouseOwnerFlag],
B.[TotalChildren],
B.[NumberCarsOwned],
B.[CommuteDistance],
B.[DateFirstPurchase],
ST.[Name] Region,
ST.[CountryRegionCode] Country

,CASE 
     when B.[Gender] = 'M' then 'Male' 
     when B.[Gender] = 'F' then 'Female'
  end  as Gender

 ,CASE 
       WHEN B.[MaritalStatus] ='M' then 'Married' 
       WHEN B.[MaritalStatus] ='S' then 'Single'

 end as Marital_Status
 ,CASE
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) < 13 THEN 'Kid 13 & Below'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 13 AND 19 THEN 'Teenage 13-19'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 20 AND 35 THEN 'YoungAdult 20-35'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 36 AND 55 THEN 'Adult 36-55'
			 WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 56 AND 70 THEN 'Elderly 56-75'
			 WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) > 70 THEN 'Seniors 76 & Above'
             
         END AS [Age Groups]

		 ,CASE
             WHEN B.[YearlyIncome] < 40000 THEN 'Low Earner'
             WHEN B.[YearlyIncome] BETWEEN 40000 AND 89000 THEN 'Mid Earner'
             WHEN B.[YearlyIncome] > 89000 THEN 'High Earner'
             
         END AS [Income Status]

FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
where SOH.OnlineOrderFlag =1 and B.[Gender] is not NULL


--------------------------------------------------------------------------
select*

from  --[dbo].[DimCustomer]

--[dbo].[FactResellerSales]

[dbo].[DimReseller]

----------------------------------------------------------------------
/*Change in Reseller Customer Demography*/

SELECT
--Distinct SOH.CustomerID
SC.[CustomerID],
SC.[StoreID],
ST.TerritoryID,
SOD.[ProductID],
SOD.SalesOrderID,
 SOD.[OrderQty],
 SOD.[LineTotal],
 SOD.[UnitPrice],
 SOD.[UnitPriceDiscount],
 PP.SafetyStockLevel,
 PP.[ReorderPoint],
 PP.[DaysToManufacture],
 ST.SalesLastYear,
 ST.SalesYTD,
 ST.CostLastYear,
 ST.CostYTD,
 ST.Name,
 ST.CountryRegionCode
FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
--LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
--ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
LEFT JOIN [Sales].[Customer] SC
ON SC.TerritoryID=SOH.TerritoryID
where SOH.OnlineOrderFlag =0 


select*
--count(distinct([BusinessEntityID]))
from
[Sales].[Store]

----------------------------------------------------------------------
/* Customer Service Delivery and Processing*/
select
Format(SOH.[Freight]),
Avg(DATEDIFF(Day,SOH.[OrderDate], SOH.[ShipDate]) ) [AVG to Ship Day],
sum (SOH.[Freight]) sum_FreightCost
from

(SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
SOH.[DueDate],
SOH.[ShipDate],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty] AS Profit,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country,
DATEDIFF(Day,SOH.[OrderDate], SOH.[ShipDate])  [Order to Ship Day],
DATEDIFF(Day,SOH.[OrderDate], SOH.[DueDate])  [Order to DeliveryDay]


 ,Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

 

,CASE 

WHEN SOH.[Status]  = 1 then 'In process'
WHEN SOH.[Status]  = 2 THEN 'Approved'
WHEN SOH.[Status]  = 3 THEN 'Backordered'
WHEN SOH.[Status]  = 4 THEN 'Rejected'
WHEN SOH.[Status]  = 5 THEN 'Shipped'
WHEN SOH.[Status]  = 6 THEN 'Cancelled'

END AS SalesStatus
, Case
WHEN [ShipMethodID]  = 1 then 'XRQ - TRUCK GROUND'
WHEN [ShipMethodID]  = 2 THEN 'ZY - EXPRESS'
WHEN [ShipMethodID]  = 3 THEN 'OVERSEAS - DELUXE'
WHEN [ShipMethodID]  = 4 THEN 'OVERNIGHT J-FAST'
WHEN [ShipMethodID]  = 5 THEN 'CARGO TRANSPORT 5'

End AS DeliveryMethod



FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
group by  SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
SOH.[DueDate],
SOH.[ShipDate],
SOH.[Status],
PPM.[Name]  ,
PC.Name,
PP.[StandardCost],
SOD.[UnitPrice],
SOD.[LineTotal],
[ShipMethodID] ,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue],
ST.[Name],
ST.[CountryRegionCode],
SOH.[OnlineOrderFlag] )
group by sum_FreightCost
-------------------------------------------------------------------------
/* Market Basket Analysis - Transaction ID*/

SELECT
SOH.[SalesOrderID] [Transaction ID],
PPM.[Name] Item
 
FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
--where SOH.[OnlineOrderFlag]  = 1
where SOH.[OnlineOrderFlag]  = 0
--order by SOH.[OrderDate]
--SOH.[SalesOrderID] 
 

-------------------------------------------------------------------
/* Market Basket Analysis - Aggregationa*/

Select
Item,
Avg(Monthly_Vol) AvgMonthly_Volume,
Avg (AvgPrice) AvgPrice
FROM

(Select
PPM.[Name] Item,
Format (SOH.[OrderDate], 'yyyy-MM') Year_month,
Avg (SOD.[UnitPrice]) AvgPrice,
sum (SOD.[OrderQty]) Monthly_Vol


FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
where SOH.OnlineOrderFlag =1
Group by PPM.[Name],
FORMAT (SOH.[OrderDate], 'yyyy-MM')) AS A
group by Item
Order by Item



-----------------------------------------------------------------------
/*ProductModel Names and Categories*/

Select
distinct ppm.Name,
PC.Name

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
order by PC.Name
where PC.Name = 'bikes'

--------------------------------------------------------------
SELECT
[OnlineOrderFlag]
,SUM ([TotalDue]) totalsales
,count ([SalesOrderID])  as [No of Transaction]
,SUM ([SubTotal]) linetotal
FROM [Sales].[SalesOrderHeader]
GROUP BY [OnlineOrderFlag] 


--------------------------------------------------------------------------
SELECT ST.[TerritoryID],
ST.[Name],
count(SOD.[SalesOrderID]) No_of_order_City,
--YEAR(SOH.[OrderDate]) OrderYear,
ST.CountryRegionCode
--Count (*) AS Total
-------------------------------------------------------------------
/* Total quantity ordered per customer by Region*/

SELECT 
distinct SOH.[CustomerID] as CustomerID,
ST.[TerritoryID],
ST.[Name],
--SOH.[TerritoryID],
--SOD.[SalesOrderDetailID],
--SOH.[ShipMethodID],
sum(SOD.[OrderQty]) TotalQty,
--SOH.[OrderDate],
ST.CountryRegionCode
--Count (*) AS Total

FROM
[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN [Sales].[Customer] SC
ON ST.[TerritoryID]=SC.[TerritoryID]

GROUP BY ST.[TerritoryID],ST.[Name], ST.CountryRegionCode,SOH.[CustomerID]





-----------------------------------------------------------------

/* No of Orders made in City or Region by dates*/

SELECT ST.[TerritoryID],
ST.[Name],
count(SOD.[SalesOrderID]) No_of_order_City,
--YEAR(SOH.[OrderDate]) OrderYear,
ST.CountryRegionCode
--Count (*) AS Total


FROM

[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN [Sales].[Customer] SC
ON ST.[TerritoryID]=SC.[TerritoryID]

GROUP BY ST.[TerritoryID],ST.[Name], ST.CountryRegionCode,SOH.[OrderDate]



---------------------------------------------------------------------
/* No of Customers in City or Region*/
  
SELECT ST.[TerritoryID],
ST.[Name],
count(distinct SC.[CustomerID]) No_of_Customers,
--count(distinct SOD.[SalesOrderID]) No_of_Users,
ST.CountryRegionCode
--Count (*) AS Total


FROM
[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN [Sales].[Customer] SC
ON ST.[TerritoryID]=SC.[TerritoryID]

GROUP BY ST.[TerritoryID],ST.[Name], ST.CountryRegionCode

ORDER BY Total DESC



---------------------------------------------------------------------
select
ST.[TerritoryID],
Count(distinct ST.[Name]) AS No_of_Regions
 
 
--Sum  (sod.salesorderID) as [volume of Transaction]
--count  (sod.SalesorderID) as [No of Transactions],
,sum(count(Distinct (soh.[CustomerID]))) OVER () as [No of Customers]

FROM


[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]


----------------------------------------------------------------------- 

SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
--SOH.[TerritoryID],
--SOD.[SalesOrderDetailID],
--SOH.[ShipMethodID],
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
--,DAY(SOH.[OrderDate]) Daypart,
--SOH.[OnlineOrderFlag] SalesChannelID,
SOH.[DueDate],
SOH.[ShipDate],
--SOH.[Status] SalesStatus,
PP.[ProductID],
PP.[ProductModelID],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty] AS Profit,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country,

 Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

,CASE 

WHEN SOH.[Status]  = 1 then 'In process'
WHEN SOH.[Status]  = 2 THEN 'Approved'
WHEN SOH.[Status]  = 3 THEN 'Backordered'
WHEN SOH.[Status]  = 4 THEN 'Rejected'
WHEN SOH.[Status]  = 5 THEN 'Shipped'
WHEN SOH.[Status]  = 6 THEN 'Cancelled'

END AS SalesStatus
, Case
WHEN [ShipMethodID]  = 1 then 'XRQ - TRUCK GROUND'
WHEN [ShipMethodID]  = 2 THEN 'ZY - EXPRESS'
WHEN [ShipMethodID]  = 3 THEN 'OVERSEAS - DELUXE'
WHEN [ShipMethodID]  = 4 THEN 'OVERNIGHT J-FAST'
WHEN [ShipMethodID]  = 5 THEN 'CARGO TRANSPORT 5'

End AS DeliveryMethod

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID




 ---------------------------------------------------------------------------
 /*Production Cost and Sales Revenue*/
SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(DAY,SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction]
 
  ,CASE
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) < 13 THEN 'Kid 13 & Below'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 13 AND 19 THEN 'Teenage 13-19'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 20 AND 35 THEN 'YoungAdult 20-35'
             WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 36 AND 55 THEN 'Adult 36-55'
			 WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) BETWEEN 56 AND 70 THEN 'Elderly 56-75'
			 WHEN DATEDIFF (year,B.[BirthDate],B.[DateFirstPurchase]) > 70 THEN 'Seniors 76 & Above'
             
         END AS [Age Groups]

,CASE 
     when B.[Gender] = 'M' then 'Male' 
     when B.[Gender] = 'F' then 'Female'
  end  as Gender

,SOH.[DueDate],
SOH.[ShipDate],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty] AS Profit,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country,

 Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID



SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(DAY,SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty] AS Profit,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country,

 Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
--LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
--ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
ORDER BY SOD.[UnitPrice] DESC
----------------------------------------------------------------------------

SELECT
SOH.[SalesOrderID],
SOH.CustomerID,
SOD.[OrderQty],
SOH.[OrderDate],
DATENAME(DAY,SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction],
SOH.[DueDate],
SOH.[ShipDate],
PPM.[Name] ProductModelName,
PC.Name ProductCategory,
PP.[StandardCost],
PP.[StandardCost]*SOD.[OrderQty] AS ProductCost,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue,
SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty] AS Profit,
SOD.[UnitPriceDiscount],
SOH.[TaxAmt],
SOH.[Freight],
SOH.[TotalDue] CustomerCost,
ST.[Name] Region,
ST.[CountryRegionCode] Country,

 Case
WHEN SOH.[OnlineOrderFlag]  = 0 then 'Store Orders'
WHEN SOH.[OnlineOrderFlag]  = 1 THEN 'Online Orders'

END AS SalesChannels

,CASE 

WHEN SOH.[Status]  = 1 then 'In process'
WHEN SOH.[Status]  = 2 THEN 'Approved'
WHEN SOH.[Status]  = 3 THEN 'Backordered'
WHEN SOH.[Status]  = 4 THEN 'Rejected'
WHEN SOH.[Status]  = 5 THEN 'Shipped'
WHEN SOH.[Status]  = 6 THEN 'Cancelled'

END AS SalesStatus
, Case
WHEN [ShipMethodID]  = 1 then 'XRQ - TRUCK GROUND'
WHEN [ShipMethodID]  = 2 THEN 'ZY - EXPRESS'
WHEN [ShipMethodID]  = 3 THEN 'OVERSEAS - DELUXE'
WHEN [ShipMethodID]  = 4 THEN 'OVERNIGHT J-FAST'
WHEN [ShipMethodID]  = 5 THEN 'CARGO TRANSPORT 5'

End AS DeliveryMethod
 

  
FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID





----------------------------------------------------------------------------
/*Product CAtegorisation*/

SELECT
--[ProductID],
pc.[ProductCategoryID],
--PS.[ProductSubcategoryID],
--count (Distinct PPM. [Name]) ProductNameCnt,
--PPM. [Name] ProductName,
--count (Distinct PS.[Name]) AS SubcategoryCnt,
--PS.[Name] AS SubcategoryName,
count (distinct PC.[Name]) AS CategoryCnt,
PC.[Name] AS CategoryName

FROM[Production].[Product] PP
left join  [Production].[ProductModel] PPM
on pp.ProductModelID=ppm.ProductModelID
left join [Production].[ProductSubcategory] PS
ON PP.ProductSubcategoryID = PS.ProductSubcategoryID
Left JOIN [Production].[ProductCategory] PC
on PC.ProductCategoryID = PS.ProductCategoryID
where PP.StandardCost >0
Group by pc.[ProductCategoryID], PC.[Name]


PC.[ProductCategoryID]
PP.ProductSubcategoryID
PP.ProductModelID

------------------------------------------------------------------------
/*Product and Production LIne*/

SELECT
PC.[Name],
count (distinct(PM.[Name])) ModelCount,
count (PC.[Name]) CateCount,
sum(count(distinct(PM.[Name]))) OVER () AS ProdcutCount,
sum (count(PC.[Name])) OVER () AS TotalCount,
sum(count(SUB.[Name])) OVER () AS tOTALsUBCOUNT
FROM  [Production].[ProductCategory] PC
INNER JOIN[Production].[ProductSubcategory] SUB
ON PC.[ProductCategoryID]=SUB.[ProductCategoryID]
INNER JOIN [Production].[Product] PP
ON PP.[ProductSubcategoryID] = SUB.ProductSubcategoryID
INNER JOIN[Production].[ProductModel] PM
ON PM.[ProductModelID] = PP.[ProductModelID]
 
GROUP BY PC.[Name]

SELECT
 
count(distinct(PM.[Name]))Model,
count(distinct(PC.[Name])) Category,
count(distinct(SUB.[Name])) subcategory
FROM  [Production].[ProductCategory] PC
INNER JOIN[Production].[ProductSubcategory] SUB
ON PC.[ProductCategoryID]=SUB.[ProductCategoryID]
INNER JOIN [Production].[Product] PP
ON PP.[ProductSubcategoryID] = SUB.ProductSubcategoryID
INNER JOIN[Production].[ProductModel] PM
ON PM.[ProductModelID] = PP.[ProductModelID]

--where PC.[Name]= 'components'

--where PC.[Name]= 'Bikes'
where PC.[Name]='Accessories' 
where PC.[Name]='Clothing'


SELECT 
PM.[Name] Model,
PC.[Name] Category,
SUB.[Name] subcategory
FROM  [Production].[ProductCategory] PC
INNER JOIN[Production].[ProductSubcategory] SUB
ON PC.[ProductCategoryID]=SUB.[ProductCategoryID]
INNER JOIN [Production].[Product] PP
ON PP.[ProductSubcategoryID] = SUB.ProductSubcategoryID
INNER JOIN[Production].[ProductModel] PM
ON PM.[ProductModelID] = PP.[ProductModelID]
where PC.[Name]= 'Bikes'

where PC.[Name]='Clothing'
  
  
  SELECT
PP.[ProductID],
PC.[ProductCategoryID],
SUB.ProductSubcategoryID,
PM.ProductModelID,
SOD.SalesOrderDetailID,
PM.[Name] Model,
PC.[Name] Category,
SUB.[Name] subcategory,
PP.SafetyStockLevel,
PP.[ReorderPoint],
 PP.[DaysToManufacture],
 PP.[MakeFlag],
 pp.[SellStartDate],
 PP.[SellEndDate],
 PP.[DiscontinuedDate],

 case when  PP.[MakeFlag] =1 then 'in-house'
		when PP.[MakeFlag] =0 then 'Purchased'

		end As Maker
FROM  [Production].[ProductCategory] PC
LEFT JOIN[Production].[ProductSubcategory] SUB
ON PC.[ProductCategoryID]=SUB.[ProductCategoryID]
LEFT JOIN [Production].[Product] PP
ON PP.[ProductSubcategoryID] = SUB.ProductSubcategoryID
left join [Sales].[SalesOrderDetail] SOD
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN[Production].[ProductModel] PM
ON PM.[ProductModelID] = PP.[ProductModelID]

 
--------------------------------------------------------------------------
/*Average cost and revenue*/

SELECT
SOH.[SalesOrderID],
AVG(PP.[StandardCost]*SOD.[OrderQty]) AS AVGProductionCost,
AVG(SOD.[UnitPrice]*SOD.[OrderQty]) AS AVGRevenue, 
AVG(SOD.[LineTotal] -PP.[StandardCost]*SOD.[OrderQty]) AS AVGProfit
 

FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]

GROUP BY SOH.[SalesOrderID]


-----------------------------------------------------------------------
/*Age Band  
Kid	below 13
teenage	13 - 19
Young Adult	20 -35
Adult	36 - 55
Elderly	56 - 75
Seniors	76 an Above
*/

SELECT 
         CustomersID,
		 CASE
             WHEN Age < 13 THEN 'Kid 13 & Below'
             WHEN Age BETWEEN 13 AND 19 THEN 'Teenage 13-19'
             WHEN Age BETWEEN 20 AND 35 THEN 'YoungAdult 20-35'
             WHEN Age BETWEEN 36 AND 55 THEN 'Adult 36-55'
			 WHEN Age BETWEEN 56 AND 70 THEN 'Elderly 56-75'
			 WHEN Age > 70 THEN 'Seniors 76 & Above'
             
         END AS [Age Groups]
from [dbo].[AgeRange]


--
CREATE VIEW AgeRange AS

SELECT 
distinct (SOH.[CustomerID]) CustomersID,
B.[BirthDate] as Birthday
 --,SOH.OnlineOrderFlag
,SOH.[OrderDate] as Order_Date,
--,SOD.OrderQty
DATEDIFF (year,B.[BirthDate],SOH.[OrderDate]) Age
FROM [Sales].[SalesOrderHeader] AS SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
where SOH.OnlineOrderFlag =1

------------------------------------------------------------------------

/*Market Basket Analysis* - Online Sales
Where SOH.[OnlineOrderFlag]  = 1 
SalesOrderID
ProductModelID
QuantityOrder*/

SELECT
SOH.[SalesOrderID] [Transaction ID],
PPM.[Name] Item,
SOD.[OrderQty] Quantity,
SOD.[UnitPrice],
SOD.[LineTotal] AS Revenue

FROM[Sales].[SalesOrderDetail] SOD
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
Where SOH.[OnlineOrderFlag]  = 1 
Order by SOH.[SalesOrderID]



/*Market Basket Analysis ProductTable
ProductSubCat ID
ProductCost
ListPrice*/

SELECT
PSUB.ProductSubcategoryID [Product ID],
PP.[StandardCost] Cost,
PP.ListPrice Price
 
FROM[Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Left join[Production].[ProductModel] PPM
ON PP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID


----------------------------------------------------------------------
/* sum of qty and sales by quarter and year
Forecasting - Online Sales*/

SELECT   
SOD.[OrderQty] Sales,
SOD.[LineTotal] AS Revenue,
DATENAME(DAY, SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction]

FROM [Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Where SOH.[OnlineOrderFlag]  = 1 


/*Forecasting - In-Store Sales*/

SELECT   
SOD.[OrderQty] Sales,
 
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction]

FROM [Sales].[SalesOrderDetail] SOD
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOD.[SalesOrderID]=SOH.[SalesOrderID]
Left JOIN [Production].[Product] PP
ON SOD.[ProductID]=PP.[ProductID]
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B
ON SOH.CustomerID = B.[CustomerKey]
Left join [Sales].[SalesTerritory] ST
ON ST.TerritoryID = SOH.TerritoryID
Where SOH.[OnlineOrderFlag]  = 0 



/*SALES PERSON*\

SELECT 
PP.FirstName,
PP.LastName,
PP.Title,
SP.TerritoryID,
ST.Name,
ST.CountryRegionCode,
SP.BusinessEntityID,
HE.[JobTitle],
SP.SalesQuota,
SOD.[LineTotal] AS Revenue,
PC.Name ProductCategory,
SOH.[OrderDate],
DATENAME(DAY,SOH.OrderDate) AS [Day of Transaction],
DATENAME(MONTH, SOH.OrderDate) AS [Month of Transaction],
DATENAME(QUARTER,SOH.OrderDate) AS [Quarter of Transaction],
DATENAME(YEAR,SOH.OrderDate) AS [Year of Transaction]

FROM [Sales].[SalesPerson] SP
LEFT JOIN [Sales].[SalesTerritory] ST
ON SP.[TerritoryID]=ST.[TerritoryID]
LEFT JOIN [Person].[Person] PP
ON PP.[BusinessEntityID] = SP.[BusinessEntityID]
LEFT JOIN [HumanResources].[Employee] HE
ON HE.[BusinessEntityID]= PP.BusinessEntityID
LEFT JOIN [Sales].[SalesOrderHeader] SOH
ON SOH.[TerritoryID]=ST.TerritoryID
LEFT JOIN [Sales].[SalesOrderDetail] SOD
ON SOD.SalesOrderID=SOH.SalesOrderID
Left JOIN [Production].[Product] PRP
ON SOD.[ProductID]= PRP.[ProductID]
Left join[Production].[ProductModel] PPM
ON PRP.[ProductModelID]= PPM.[ProductModelID]
LEFT JOIN  [Production].[ProductSubcategory] PSUB
ON PRP.ProductSubcategoryID = PSUB.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] PC
ON PSUB.ProductCategoryID= PC.ProductCategoryID
