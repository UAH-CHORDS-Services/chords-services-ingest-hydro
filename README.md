Ingest latest readings from http://storm.chordsrt.com/ into a Postgresql database.

Assumes python 2.7

To install:

    pip install -r requirements.txt

Minimal database schema (see also `chords-services.full.sql`):

```sql
CREATE TABLE latest_readings (
    device_serial character varying(200) NOT NULL,
    variable_id character varying(200) NOT NULL,
    current_value real,
    taken_at timestamp without time zone NOT NULL,
    max_value real,
    min_value real
);

COPY latest_readings (device_serial, variable_id, current_value, taken_at, max_value, min_value) FROM stdin;
T6	depth_sonic	\N	2016-01-01 00:00:00	\N	\N
T5	depth_sonic	\N	2016-01-01 00:00:00	\N	\N
T8	depth_sonic	\N	2016-01-01 00:00:00	\N	\N
T9	depth_sonic	\N	2016-01-01 00:00:00	\N	\N
\.

ALTER TABLE ONLY latest_readings
    ADD CONSTRAINT latest_readings_pkey PRIMARY KEY (device_serial, variable_id, taken_at);
```

To run:

    PGSERVICE=db python2 hydro.py
