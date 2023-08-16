{{ config(materialized='view', alias='carrier')}}

SELECT
    TRIM(COALESCE(code, '')) AS code,
    TRIM(COALESCE(name, '')) AS name,
    COALESCE(effectiveFromYear, 1900) AS effectiveFromYear,
    COALESCE(effectiveToYear, 9999) AS effectiveToYear
FROM {{ ref('slv_carrier')}}
WHERE
    COALESCE(effectiveFromYear, 1900) > 0
    AND COALESCE(effectiveToYear, 9999) > 0
    AND TRIM(COALESCE(name, '')) != ''
    AND TRIM(COALESCE(code, '')) != ''