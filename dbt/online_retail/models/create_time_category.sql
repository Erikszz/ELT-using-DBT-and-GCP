{{ 
     config(materialized='ephemeral')
}} 

SELECT
	*,
	{{ time_category('InvoiceDate') }} AS TimeCategory
FROM 
    {{ ref('create_total_price') }}
