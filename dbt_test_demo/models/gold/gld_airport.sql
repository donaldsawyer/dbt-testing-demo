{{ config(materialized='view', alias='airport')}}

-- VERSION 1
-- SELECT
--     code,
--     name,
--     city,
--     state_country as state
-- FROM {{ ref('slv_airport')}}


SELECT
    code,
    name,
    city,
    state_country as state
FROM {{ ref('slv_airport')}}
WHERE length(state_country) = 2