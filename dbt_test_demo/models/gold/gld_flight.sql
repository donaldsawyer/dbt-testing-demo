{{ config(materialized='view', alias='flight')}}

WITH flightsWithDataLimitCTE AS (
    SELECT year,
        month,
        dayOfMonth,
        CASE 
            WHEN month IN (1, 3, 5, 7, 8, 10, 12) THEN 31
            WHEN month IN (4, 6, 9, 11) THEN 30
            WHEN month = 2 THEN 29
            ELSE NULL
        END AS maxDaysInMonth,
        flightDate,
        carrier AS carrierCode,
        flightNumber,
        origin AS originAirportCode,
        destination AS destinationAirportCode,
        departureDelayMinutes AS departureDelay
    FROM {{ ref('slv_flight')}}
)

SELECT
    year AS year,
    month AS month,
    dayOfMonth AS dayOfMonth,
    flightDate,
    carrierCode,
    flightNumber,
    originAirportCode,
    destinationAirportCode,
    departureDelay
FROM flightsWithDataLimitCTE
WHERE
    year >= 1900
    AND month BETWEEN 1 AND 12
    AND (dayOfMonth > 0 AND dayOfMonth <= maxDaysInMonth)