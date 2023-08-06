{{ config(materialized='view', alias='flight')}}

SELECT
    year AS year,
    month AS month
FROM {{ ref('slv_flight')}}
WHERE
    year >= 1900
    AND month BETWEEN 1 AND 12