{{ 
     config(materialized='ephemeral')
}} 

SELECT
    *,
    {{ date_only('InvoiceDate') }} AS DateOnly
FROM 
    {{ ref('stg_retail') }}
