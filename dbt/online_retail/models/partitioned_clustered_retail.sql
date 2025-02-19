{{ 
    config(
        materialized = 'table',
        partition_by = {
            'field': 'DateOnly',
            'data_type': 'DATE'
        },
        cluster_by = [
		'CustomerID',
		'CountryCode'
	]
    )
}}
SELECT 
	*
FROM 
	{{ ref('create_country_code') }}
