{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('gld_flight', 'validates transformation logic for gold.flight') %}

    {% call dbt_unit_testing.mock_ref('slv_flight') %}
        YEAR 
        2000
        1900
        1899
        0
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        YEAR
        2000
        1900
    {% endcall %}
{% endcall %}