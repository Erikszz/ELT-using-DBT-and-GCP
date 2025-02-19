{% macro country_code(col) %}

    CASE 
        WHEN {{ col }} = 'EIRE' THEN 'IE'
        WHEN {{ col }} = 'Sweden' THEN 'SE'
        WHEN {{ col }} = 'Japan' THEN 'JP'
        WHEN {{ col }} = 'Brazil' THEN 'BR'
        WHEN {{ col }} = 'Lithuania' THEN 'LT'
        WHEN {{ col }} = 'United Kingdom' THEN 'GB'
        WHEN {{ col }} = 'Belgium' THEN 'BE'
        WHEN {{ col }} = 'Netherlands' THEN 'NL'
        WHEN {{ col }} = 'Malta' THEN 'MT'
        WHEN {{ col }} = 'Portugal' THEN 'PT'
        WHEN {{ col }} = 'Spain' THEN 'ES'
        WHEN {{ col }} = 'Poland' THEN 'PL'
        WHEN {{ col }} = 'United Arab Emirates' THEN 'AE'
        WHEN {{ col }} = 'Austria' THEN 'AT'
        WHEN {{ col }} = 'Cyprus' THEN 'CY'
        WHEN {{ col }} = 'Czech Republic' THEN 'CZ'
        WHEN {{ col }} = 'Singapore' THEN 'SG'
        WHEN {{ col }} = 'USA' THEN 'US'
        WHEN {{ col }} = 'Bahrain' THEN 'BH'
        WHEN {{ col }} = 'European Community' THEN 'EU'
        WHEN {{ col }} = 'Australia' THEN 'AU'
        WHEN {{ col }} = 'Norway' THEN 'NO'
        WHEN {{ col }} = 'Italy' THEN 'IT'
        WHEN {{ col }} = 'RSA' THEN 'ZA'  -- Republic of South Africa
        WHEN {{ col }} = 'Canada' THEN 'CA'
        WHEN {{ col }} = 'Greece' THEN 'GR'
        WHEN {{ col }} = 'France' THEN 'FR'
        WHEN {{ col }} = 'Finland' THEN 'FI'
        WHEN {{ col }} = 'Denmark' THEN 'DK'
        WHEN {{ col }} = 'Israel' THEN 'IL'
        WHEN {{ col }} = 'Switzerland' THEN 'CH'
        WHEN {{ col }} = 'Channel Islands' THEN 'JE'  -- Jersey (CI)
        WHEN {{ col }} = 'Saudi Arabia' THEN 'SA'
        WHEN {{ col }} = 'Lebanon' THEN 'LB'
        WHEN {{ col }} = 'Germany' THEN 'DE'
        WHEN {{ col }} = 'Iceland' THEN 'IS'
        WHEN {{ col }} = 'Unspecified' THEN 'Unspecified' 
        ELSE NULL  
    END

{% endmacro %}
