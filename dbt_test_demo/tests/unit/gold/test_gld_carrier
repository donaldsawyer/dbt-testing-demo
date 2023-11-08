{{
    config(
        tags=['unit-test', 'no-db-dependency']
    )
}}

-- 05c: is this an error, or is this valid?  That's the question!

{% call dbt_unit_testing.test('gld_carrier', 'validates parsing logic for carrier code data') %}

    {% call dbt_unit_testing.mock_ref("slv_carrier") %}
        CODE    | NAME                          | EFFECTIVEFROMYEAR     | EFFECTIVETOYEAR   | ORIGINALDESCRIPTION
        '01a'   | 'carrier 01a'                 | 2016                  | 2020              | 'carrier 01a (2016 - 2020)'
        '01b'   | 'carrier 01b (other)'         | 2016                  | 2020              | 'carrier 01b (other) (2016 - 2020)'
        '02a'   | 'carrier 02a'                 | NULL                  | 2020              | 'carrier 02a ( - 2020)'
        '03a'   | 'carrier 03a'                 | 2016                  | NULL              | 'carrier 03a (2016 - )'
        '04a'   | 'carrier 04a'                 | NULL                  | NULL              | 'carrier 04a ( - )'
        '05a'   | 'carrier 05a 2016 - 2020)'    | -1                    | -1                | 'carrier 05a 2016 - 2020)'
        '05b'   | 'carrier 05b (2016 - 2020'    | -1                    | -1                | 'carrier 05b (2016 - 2020'
        '05c'   | 'carrier 05c ()'              | -1                    | -1                | 'carrier 05c ()'
        '05d'   | 'carrier 05d'                 | -1                    | -1                | 'carrier 05d'
        ''      | 'carrier 06a'                 | 2016                  | 2020              | NULL
        NULL    | 'carrier 06a'                 | 2016                  | 2020              | NULL
        '06c'   | ''                            | 2016                  | 2020              | NULL                
        '06d'   | NULL                          | 2016                  | 2020              | NULL                
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        CODE    | NAME                          | EFFECTIVEFROMYEAR     | EFFECTIVETOYEAR
        '01a'   | 'carrier 01a'                 | 2016                  | 2020           
        '01b'   | 'carrier 01b (other)'         | 2016                  | 2020           
        '02a'   | 'carrier 02a'                 | 1900                  | 2020           
        '03a'   | 'carrier 03a'                 | 2016                  | 9999           
        '04a'   | 'carrier 04a'                 | 1900                  | 9999           
    {% endcall %}
{% endcall %}