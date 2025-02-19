{{ 
     config(materialized='ephemeral')
}} 

SELECT
	InvoiceNo as InvoiceID,
    	CAST(CustomerID AS STRING) AS CustomerID,
	StockCode as ProductCode,
	ProductName,
	DateOnly,
	Quantity,
	UnitPrice,
	TotalPrice,
	Country,
	TimeCategory,
    {{ country_code('Country') }} AS CountryCode
FROM 
    {{ ref('create_time_category') }}
