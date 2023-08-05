{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

{% call dbt_unit_testing.test('slv_airport', 'validates parsing logic') %}

    {% call dbt_unit_testing.mock_source ('demo_source','airport_code') %}
        CODE    | Description
        '01a'   | 'city1a, AL: 01A Airport'
        '02a'   | ', AL: 02a airport'
        '03a'   | 'city03a,: 03a airport'
        '04a'   | 'city04a: 04a airport'
        '05a'   | 'city05a, COUNTRY: 05a airport'
        '06a'   | 'city06a, AL:'
        '07a'   | 'city07a, Province, Country, Continent: 07a airport'
        'ZZZ'   | 'this value should not matter'
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        CODE    | CITY      | STATE_COUNTRY                   | NAME
        '01a'   | 'city1a'  | 'AL'                            | '01A Airport'
        '02a'   | NULL      | 'AL'                            | '02a airport'
        '03a'   | 'city03a' | NULL                            | '03a airport'
        '04a'   | 'city04a' | NULL                            | '04a airport'
        '05a'   | 'city05a' | 'COUNTRY'                       | '05a airport'
        '06a'   | 'city06a' | 'AL'                            | NULL
        '07a'   | 'city07a' | 'Province, Country, Continent'  | '07a airport'
    {% endcall %}
{% endcall %}
--   {% call dbt_unit_testing.expect() %}
--     CODE    | CITY      | STATE | COUNTRY       | DESCRIPTION
--     '01a'   | 'city1a'  | 'AL'  | 'U.S.'        | '01A Airport'
--     '02a'   | NULL      | 'AL'  | 'U.S.'        | '02a airport'
--     '02b'   | NULL      | NULL  | 'Canada'      | '02b airport'
--     '03a'   | 'city03a' | NULL  | NULL          | '03a airport'
--     '04a'   | 'city04a' | NULL  | NULL          | '04a airport'
--     '05a'   | 'city05a' | NULL  | 'Indonesia'   | '05a airport'
--     '06a'   | 'city06a' | 'AL'  | 'U.S.'        | NULL
--     '07a'   | 'city07a' | 'AL'  | 'U.S.'        | NULL
--     '09a'   | 'city09a' | 'AK'  | 'U.S.'        | '09a airport'
--     '09b'   | 'city09b' | NULL  | 'Alberta'     | '09b airport'
-- {% endcall %}