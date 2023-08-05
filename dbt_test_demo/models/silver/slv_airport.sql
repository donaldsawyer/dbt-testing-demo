{{ config(materialized='view', alias='airport')}}

-- BAD DATA????
-- select a.code, a.state_country, length(a.state_country) - length(replace(a.state_country, ',', '')) as comma_count
-- from silver.airport a
-- -- join silver.flight fd on a.code = fd.origin or a.code = fd.destination
-- where length(a.state_country) - length(replace(a.state_country, ',', '')) > 0

with locNameCTE as (
    SELECT 
        code,
        TRIM(SPLIT_PART(description, ':', 1)) as location,
        POSITION(',' IN TRIM(SPLIT_PART(description, ':', 1))) as firstCommaIndex,
        TRIM(SPLIT_PART(description, ':', 2)) as name
    FROM {{ source('demo_source', 'airport_code') }}
)

SELECT 
    code,
    CASE 
        WHEN firstCommaIndex = 0 
        THEN TRIM(location) 
        ELSE 
            CASE 
                WHEN TRIM(SUBSTRING(location for firstCommaIndex - 1)) = '' 
                THEN NULL 
                ELSE TRIM(SUBSTRING(location for firstCommaIndex - 1))
                END
        END AS city,
    CASE 
        WHEN firstCommaIndex = 0
        THEN NULL
        ELSE
        CASE
            WHEN TRIM(SUBSTRING(location from firstCommaIndex + 1)) = ''
            THEN NULL
            ELSE TRIM(SUBSTRING(location from firstCommaIndex + 1))
            END
        END AS state_country,
    CAST(
        CASE WHEN name = '' THEN NULL ELSE name END
        AS character varying(128)) AS name
FROM locNameCTE
    WHERE code != 'ZZZ'