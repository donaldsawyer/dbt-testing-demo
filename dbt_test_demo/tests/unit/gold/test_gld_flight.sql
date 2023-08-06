{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('gld_flight', 'validates transformation logic for gold.flight') %}

    {% call dbt_unit_testing.mock_ref('slv_flight') %}
        YEAR    | MONTH 
        2000    | 1
        2000    | 0
        2000    | 13
        1900    | 12
        1899    | NULL
        0       | NULL
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        YEAR    | MONTH
        2000    | 1
        1900    | 12
    {% endcall %}
{% endcall %}