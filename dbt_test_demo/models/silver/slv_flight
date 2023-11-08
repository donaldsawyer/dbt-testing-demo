{{ config(materialized='view', alias='flight')}}

SELECT 
    CAST(year AS SMALLINT) AS year,
    CAST(month AS SMALLINT) AS month,
    CAST(day_of_month AS SMALLINT) AS dayOfMonth,
    CAST(fl_date AS CHARACTER VARYING (10)) AS flightDate,
    CAST(unique_carrier AS CHARACTER VARYING (3)) AS uniqueCarrier,
    CAST(airline_id AS INTEGER) AS airlineId,
    CAST(carrier AS CHARACTER VARYING (3)) AS carrier,
    CAST(tail_num AS CHARACTER VARYING (10)) AS tailNumber,
    CAST(fl_num AS INTEGER) AS flightNumber,
    CAST(origin_airport_id AS INTEGER) AS originAirportId,
    CAST(origin_airport_sequence_id AS INTEGER) AS originAirportSequenceId,
    CAST(origin AS CHARACTER VARYING (3)) AS origin,
    CAST(dest_airport_id AS INTEGER) AS destinationAirportId,
    CAST(dest_airport_seq_id AS INTEGER) AS destinationAirportSequenceId,
    CAST(dest AS CHARACTER VARYING (3)) AS destination,
    CAST(dep_delay AS INTEGER) AS departureDelayMinutes,
    CAST(arr_delay AS INTEGER) AS arrivalDelayMinutes,
    CAST(CAST(cancelled AS INTEGER) AS BOOLEAN) AS cancelledFlag,
    CAST(CAST(diverted AS INTEGER) AS BOOLEAN) AS divertedFlag,
    CAST(distance AS INTEGER) AS distanceMiles
FROM {{ source('demo_source', 'flight_data') }}