{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

-- 05c: is this an error, or is this valid?  That's the question!

{% call dbt_unit_testing.test('slv_carrier', 'validates parsing logic for carrier code data') %}

    {% call dbt_unit_testing.mock_source ('demo_source','carrier_code') %}
        

    {% endcall %}

    {% call dbt_unit_testing.expect() %}

    {% endcall %}
{% endcall %}