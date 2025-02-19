{% macro time_category(col) %}

    CASE
        WHEN FORMAT_TIMESTAMP('%H:%M', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', {{ col }})) BETWEEN '00:00' AND '05:59' THEN 'Midnight - Dawn'
        WHEN FORMAT_TIMESTAMP('%H:%M', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', {{ col }})) BETWEEN '06:00' AND '11:59' THEN 'Morning'
        WHEN FORMAT_TIMESTAMP('%H:%M', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', {{ col }})) BETWEEN '12:00' AND '17:59' THEN 'Noon - Evening'
        WHEN FORMAT_TIMESTAMP('%H:%M', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', {{ col }})) BETWEEN '18:00' AND '23:59' THEN 'Evening - Late Night'
    END

{% endmacro %}

