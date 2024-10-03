select [SID]
		  ,CustomerPurchaseOr,SalesDocType,ShiptoPartyName,SoldtoParty,Material
         , year(cast(PostingDate as date))    as YearPostingDate
         , DATEPART(QUARTER, CAST([PostingDate] AS DATE)) AS [Quarter]
		 ,c.FiscalYear,FiscalQuarter
         , PostingDate
         , CASE
               WHEN MONTH([PostingDate]) <= 6 THEN
                   1
               ELSE
                   2
           END                                   AS [Half_Year]
         , Dense_rank() OVER (
            PARTITION BY ShiptoPartyName,Material,CustomerPurchaseOr  --,c.FiscalYear,FiscalQuarter
            ORDER BY [PostingDate] DESC
        ) AS [Quarterly_Rank], /*Should confirm the logic as it might not required*/
        
        Dense_rank() OVER (
            PARTITION BY ShiptoPartyName,Material, CustomerPurchaseOr

            ORDER BY [PostingDate] DESC
        ) AS [Half_Yearly_Rank]
		,Quantity
       
    FROM [Sales] ss
	join [AzureCurationRep].[GEN].[MasterCalendar] c on ss.PostingDate = cast(c.Date as Date)
	Where CustomerPurchaseOr not like '%Stock%Rot%'
	and  SalesDocTypeCode in ('ZRE')
	and IsRevenue = 0
	and FiscalYear in (2022,2023)
