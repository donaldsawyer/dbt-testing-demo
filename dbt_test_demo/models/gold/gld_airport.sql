{{ config(materialized='view', alias='airport')}}

-- VERSION 1
-- SELECT
--     code,
--     name,
--     city,
--     state_country AS state
-- FROM {{ ref('slv_airport')}}

-- VERSION 2
-- SELECT
--     code,
--     name,
--     city,
--     state_country AS state
-- FROM {{ ref('slv_airport')}}
-- WHERE LENGTH(state_country) = 2

SELECT
    code,
    name,
    CAST(city AS CHARACTER VARYING(128)),
    CAST(state_country AS CHARACTER VARYING (32)) AS state
FROM {{ ref('slv_airport')}}
WHERE 
    LENGTH(state_country) = 2
    AND city IS NOT NULL
    AND name IS NOT NULL