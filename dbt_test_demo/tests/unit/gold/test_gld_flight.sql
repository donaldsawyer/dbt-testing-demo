{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('gld_flight', 'validates transformation logic for gold.flight') %}

    {% call dbt_unit_testing.mock_ref('slv_flight') %}
        YEAR    | MONTH | dayOfMonth    | flightDate
        2000    | 1     | 1             | '2000-01-01'
        1900    | 12    | 31            | '1900-12-31'
        2000    | 1     | 31            | '2000-01-01'

        2000    | 0     | NULL          | NULL
        2000    | 13    | NULL          | NULL
        1899    | NULL  | NULL          | NULL
        0       | NULL  | NULL          | NULL
        2000    | 1     | 32            | NULL
        2000    | 1     | 0             | NULL
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        YEAR    | MONTH | dayOfMonth    | flightDate
        2000    | 1     | 1             | '2000-01-01'
        1900    | 12    | 31            | '1900-12-31'
        2000    | 1     | 31            | '2000-01-01'
    {% endcall %}
{% endcall %}