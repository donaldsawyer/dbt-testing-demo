{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

-- 05c: is this an error, or is this valid?  That's the question!

{% call dbt_unit_testing.test('slv_carrier', 'validates parsing logic for carrier code data') %}

    {% call dbt_unit_testing.mock_source ('demo_source','carrier_code') %}
        CODE    | DESCRIPTION
        '01a'   | 'carrier 01a (2016 - 2020)'
        '01b '  | 'carrier 01b (other) (2016 - 2020)'
        ' 02a'  | 'carrier 02a ( - 2020)'
        '03a'   | 'carrier 03a (2016 - )'
        '04a'   | 'carrier 04a ( - )'
        '05a'   | 'carrier 05a 2016 - 2020)'
        '05b'   | 'carrier 05b (2016 - 2020'
        '05c'   | 'carrier 05c ()'
        '05d'   | 'carrier 05d'
        ''      | 'value does not matter'
        '   '   | 'value does not matter'

    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        CODE    | NAME                      
        '01a'   | 'carrier 01a'             
        '01b'   | 'carrier 01b (other)'     
        '02a'   | 'carrier 02a'             
        '03a'   | 'carrier 03a'             
        '04a'   | 'carrier 04a'             
        '05a'   | 'carrier 05a 2016 - 2020)'
        '05b'   | 'carrier 05b (2016 - 2020'
        '05c'   | 'carrier 05c ()'          
        '05d'   | 'carrier 05d'                
 
    {% endcall %}
{% endcall %}