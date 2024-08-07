

   SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN [Design Win Date-Dimension] IS NULL THEN 1 ELSE 0 END) AS NullCount,
    (SUM(CASE WHEN [Design Win Date-Dimension] IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS NullPercentage

FROM 
    Opportunity