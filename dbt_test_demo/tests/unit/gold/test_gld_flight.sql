{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('gld_flight', 'validates transformation logic for gold.flight') %}

    {% call dbt_unit_testing.mock_ref('slv_flight') %}
        YEAR    | MONTH | dayOfMonth    | flightDate    | carrier
        2000    | 1     | 1             | '2000-01-01'  | 'C01'
        1900    | 12    | 31            | '1900-12-31'  | 'C02'
        2000    | 1     | 31            | '2000-01-01'  | 'C03'

        2000    | 0     | NULL          | NULL          | 'C1X'
        2000    | 13    | NULL          | NULL          | 'C1X'
        1899    | NULL  | NULL          | NULL          | 'C1X'
        0       | NULL  | NULL          | NULL          | 'C1X'
        2000    | 1     | 32            | NULL          | 'C1X'
        2000    | 1     | 0             | NULL          | 'C1X'
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        YEAR    | MONTH | dayOfMonth    | flightDate    | carrierCode
        2000    | 1     | 1             | '2000-01-01'  | 'C01'
        1900    | 12    | 31            | '1900-12-31'  | 'C02'
        2000    | 1     | 31            | '2000-01-01'  | 'C03'
    {% endcall %}
{% endcall %}