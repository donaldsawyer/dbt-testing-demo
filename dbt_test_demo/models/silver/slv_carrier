{{ config(materialized='view', alias='carrier')}}

WITH 
parsedDescriptionCTE AS (
    SELECT 
        TRIM(code) AS code,
        description AS originalDescription,
        CASE
		WHEN
			POSITION('(' IN REVERSE(description)) < POSITION(')' IN REVERSE(description))
			OR
			POSITION(')' IN REVERSE(description)) = 0
            OR
            POSITION('(' IN REVERSE(description)) = 0  
		THEN NULL
		ELSE
			TRIM(
				SUBSTRING(description FROM 
					LENGTH(description) - POSITION('(' IN REVERSE(description)) + 2
					FOR
					  POSITION('(' IN REVERSE(description))
					  - POSITION(')' IN REVERSE(description)) - 1))
        END AS yearRange,
        TRIM(SUBSTRING(description FOR LENGTH(description) - POSITION('(' IN REVERSE(description)) - 1))
            AS name
    FROM {{ source('demo_source', 'carrier_code')}} 
)

SELECT 
    CASE WHEN code = '' THEN NULL ELSE code END AS code,
    CASE WHEN name = '' THEN NULL 
        ELSE 
            CASE WHEN yearRange IS NULL OR TRIM(SPLIT_PART(yearRange, '-', 1)) = yearRange THEN originalDescription ELSE name END
        END AS name,
    CAST(
        CASE
            WHEN yearRange IS NULL or TRIM(SPLIT_PART(yearRange, '-', 1)) = yearRange THEN -1
            WHEN TRIM(SPLIT_PART(yearRange, '-', 1)) = ''
            THEN NULL
            ELSE CAST(TRIM(SPLIT_PART(yearRange, '-', 1)) AS INTEGER)
            END
        AS INTEGER) AS effectiveFromYear,
    CAST(
        CASE
            WHEN yearRange IS NULL or TRIM(SPLIT_PART(yearRange, '-', 2)) = yearRange THEN -1
            WHEN TRIM(SPLIT_PART(yearRange, '-', 2)) = ''
            THEN NULL
            ELSE CAST(TRIM(SPLIT_PART(yearRange, '-', 2)) AS INTEGER)
            END
        AS INTEGER) AS effectiveToYear,
    originalDescription
FROM parsedDescriptionCTE