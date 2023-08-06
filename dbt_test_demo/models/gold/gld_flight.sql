{{ config(materialized='view', alias='flight')}}

SELECT
    year AS year
FROM {{ ref('slv_flight')}}
WHERE
    year >= 1900