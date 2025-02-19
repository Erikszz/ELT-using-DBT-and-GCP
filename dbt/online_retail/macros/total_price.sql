{% macro total_price(Quantity, UnitPrice) %}

    ROUND({{ Quantity }} * {{ UnitPrice }}, 2)

{% endmacro %}

