{{ config(materialized='view', alias='carrier')}}

SELECT
    code,
    name,
    COALESCE(effectiveFromYear, 1900) AS effectiveFromYear,
    COALESCE(effectiveToYear, 9999) AS effectiveToYear
FROM {{ ref('slv_carrier')}}
WHERE
    COALESCE(effectiveFromYear, 1900) > 0
    AND COALESCE(effectiveToYear, 9999) > 0