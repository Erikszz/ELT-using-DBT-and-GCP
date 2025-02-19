{{ 
     config(materialized='ephemeral')
}}  

SELECT
    *,
    {{ total_price('Quantity', 'UnitPrice') }} AS TotalPrice
FROM 
    {{ ref('create_date') }}


