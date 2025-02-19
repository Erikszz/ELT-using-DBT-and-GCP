{% macro date_only(col) %}

    DATE(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', {{ col }}))

{% endmacro %}
