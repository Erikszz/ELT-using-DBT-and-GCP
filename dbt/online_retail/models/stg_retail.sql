{{ 
     config(materialized='view')
}}

WITH Source AS (
     SELECT   
          *
     FROM 
          {{ source('retail', 'raw') }}
),
FilteredData AS (
	SELECT
        InvoiceNo,
        StockCode,
        LOWER(Description) AS ProductName,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country
     FROM 
          Source
     WHERE 
          CustomerID IS NOT NULL
     AND
          InvoiceNo NOT LIKE 'C%'
)

SELECT
     *
FROM
     FilteredData
     

