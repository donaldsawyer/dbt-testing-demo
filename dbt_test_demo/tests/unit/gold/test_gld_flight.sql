{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('gld_flight', 'validates transformation logic for gold.flight') %}

    {% call dbt_unit_testing.mock_ref('slv_flight') %}
        YEAR    | MONTH | dayOfMonth    | flightDate    | flightNumber  | carrier   | origin    | destination   | departureDelayMinutes | arrivalDelayMinutes
        2000    | 1     | 1             | '2000-01-01'  | 100001        | 'C01'     | 'A01'     | 'A10'         | NULL                  | NULL
        1900    | 12    | 31            | '1900-12-31'  | 100002        | 'C02'     | 'A02'     | 'A20'         | 10                    | 10
        2000    | 1     | 31            | '2000-01-01'  | 100003        | 'C03'     | 'A03'     | 'A30'         | -10                   | -10

        2000    | 0     | NULL          | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
        2000    | 13    | NULL          | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
        1899    | NULL  | NULL          | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
        0       | NULL  | NULL          | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
        2000    | 1     | 32            | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
        2000    | 1     | 0             | NULL          | 000000        | 'C1X'     | 'X01'     | 'X10'         | NULL                  | NULL
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        YEAR    | MONTH | dayOfMonth    | flightDate    | flightNumber  | carrierCode   | originAirportCode | destinationAirportCode    | departureDelay    | arrivalDelay
        2000    | 1     | 1             | '2000-01-01'  | 100001        | 'C01'         | 'A01'             | 'A10'                     | NULL              | NULL
        1900    | 12    | 31            | '1900-12-31'  | 100002        | 'C02'         | 'A02'             | 'A20'                     | 10                | 10
        2000    | 1     | 31            | '2000-01-01'  | 100003        | 'C03'         | 'A03'             | 'A30'                     | -10               | -10
    {% endcall %}
{% endcall %}