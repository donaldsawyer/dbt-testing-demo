CREATE SCHEMA bronze;
SET SCHEMA 'bronze';

create table carrier_code (code character varying(8), description character varying(127));

copy carrier_code FROM '/data/carrier_codes.csv' DELIMITER ',' CSV HEADER;

create table airport_code (code character varying(8), description character varying(127));

copy airport_code FROM '/data/airport_codes.csv' DELIMITER ',' CSV HEADER;

create table flight_data (
    year integer,
    month smallint,
    day_of_month smallint,
    fl_date character varying(10),
    unique_carrier character varying(3),
    airline_id integer,
    carrier character varying(3),
    tail_num character varying(10),
    fl_num integer,
    origin_airport_id integer,
    origin_airport_sequence_id integer,
    origin character varying(3),
    dest_airport_id integer,
    dest_airport_seq_id integer,
    dest character varying(3),
    dep_delay double precision,
    arr_delay double precision,
    cancelled double precision,
    diverted double precision,
    distance double precision,
    dummy character varying(127)
);

copy flight_data FROM '/data/airport_data/01.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/02.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/03.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/04.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/05.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/06.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/07.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/08.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/09.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/10.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/11.csv' DELIMITER ',' CSV HEADER;
copy flight_data FROM '/data/airport_data/12.csv' DELIMITER ',' CSV HEADER;