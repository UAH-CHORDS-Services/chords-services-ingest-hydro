--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.18
-- Dumped by pg_dump version 9.2.18
-- Started on 2016-12-21 18:37:16 UTC

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE IF EXISTS ONLY public.readings DROP CONSTRAINT IF EXISTS readings_variable_id_fkey;
ALTER TABLE IF EXISTS ONLY public.readings DROP CONSTRAINT IF EXISTS readings_device_serial_fkey;
ALTER TABLE IF EXISTS ONLY public.latest_readings DROP CONSTRAINT IF EXISTS latest_readings_variable_id_fkey;
ALTER TABLE IF EXISTS ONLY public.latest_readings DROP CONSTRAINT IF EXISTS latest_readings_device_serial_fkey;
DROP RULE IF EXISTS ignore_duplicate_readings ON public.readings;
ALTER TABLE IF EXISTS ONLY public.variables DROP CONSTRAINT IF EXISTS variables_pkey;
ALTER TABLE IF EXISTS ONLY public.readings DROP CONSTRAINT IF EXISTS readings_pkey;
ALTER TABLE IF EXISTS ONLY public.latest_readings DROP CONSTRAINT IF EXISTS latest_readings_pkey;
ALTER TABLE IF EXISTS ONLY public.devices DROP CONSTRAINT IF EXISTS devices_pkey;
DROP TABLE IF EXISTS public.variables;
DROP TABLE IF EXISTS public.readings;
DROP TABLE IF EXISTS public.latest_readings;
DROP TABLE IF EXISTS public.devices;
DROP EXTENSION IF EXISTS postgis;
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 12595)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 17505)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

-- COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 18791)
-- Name: devices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE devices (
    device_serial character varying(200) NOT NULL,
    product_id character varying(200),
    feed_id integer,
    title character varying(200),
    private boolean,
    feed_url character varying(200),
    status character varying(200),
    updated timestamp without time zone,
    created timestamp without time zone,
    creator character varying(200),
    version character varying(200),
    location geometry(Point,4326)
);


--
-- TOC entry 186 (class 1259 OID 18833)
-- Name: latest_readings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE latest_readings (
    device_serial character varying(200) NOT NULL,
    variable_id character varying(200) NOT NULL,
    current_value real,
    taken_at timestamp without time zone NOT NULL,
    max_value real,
    min_value real
);


--
-- TOC entry 185 (class 1259 OID 18807)
-- Name: readings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE readings (
    device_serial character varying(200) NOT NULL,
    variable_id character varying(200) NOT NULL,
    current_value real,
    taken_at timestamp without time zone NOT NULL,
    max_value real,
    min_value real
);


--
-- TOC entry 184 (class 1259 OID 18799)
-- Name: variables; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE variables (
    variable_id character varying(200) NOT NULL,
    unit_symbol character varying(200),
    unit_label character varying(200)
);


--
-- TOC entry 4046 (class 0 OID 18791)
-- Dependencies: 183
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY devices (device_serial, product_id, feed_id, title, private, feed_url, status, updated, created, creator, version, location) FROM stdin;
T5	10	10	FW6	\N	http://storm.chordsrt.com/instruments/10.json?last	active	2016-07-07 10:39:27.169	2016-07-07 10:39:39.693	Manil	1.0.0	0101000020E6100000A8C64B3789694040C898BB96905358C0
T6	11	11	FW1	\N	http://storm.chordsrt.com/instruments/11.json?last	active	2016-07-07 11:08:13.664	2016-07-07 11:08:17.726	Manil	1.0.0	0101000020E61000002E90A0F8315E4040ADFA5C6DC55258C0
T8	13	13	FW4	\N	http://storm.chordsrt.com/instruments/13.json?last	active	2016-07-07 20:51:42.512	2016-07-07 20:51:46.458	Manil	1.0.0	0101000020E6100000894160E5D05A40405E4BC8073D4F58C0
T9	14	14	FW7	\N	http://storm.chordsrt.com/instruments/14.json?last	active	2016-07-07 20:55:17.582	2016-07-07 20:55:18.988	Manil	1.0.0	0101000020E61000001DC9E53FA46F4040D93D7958A85158C0
\.


--
-- TOC entry 4049 (class 0 OID 18833)
-- Dependencies: 186
-- Data for Name: latest_readings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY latest_readings (device_serial, variable_id, current_value, taken_at, max_value, min_value) FROM stdin;
T6	depth_sonic	6757	2016-08-05 00:15:51	\N	\N
T5	depth_sonic	7057	2016-10-31 11:49:52	\N	\N
T8	depth_sonic	3166	2016-10-31 11:53:52	\N	\N
T9	depth_sonic	6181	2016-10-30 15:36:18	\N	\N
\.


--
-- TOC entry 4048 (class 0 OID 18807)
-- Dependencies: 185
-- Data for Name: readings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY readings (device_serial, variable_id, current_value, taken_at, max_value, min_value) FROM stdin;
\.


--
-- TOC entry 3919 (class 0 OID 17773)
-- Dependencies: 171
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

-- COPY spatial_ref_sys  FROM stdin;
-- \.


--
-- TOC entry 4047 (class 0 OID 18799)
-- Dependencies: 184
-- Data for Name: variables; Type: TABLE DATA; Schema: public; Owner: -
--

COPY variables (variable_id, unit_symbol, unit_label) FROM stdin;
bottle	null	null
chloride	null	null
delta_depth_max	mm/5 mins	mm/5 mins
delta_depth_sonic	mm/5 mins	mm/5 mins
depth_base	mm	mm
depth_peak	mm	mm
depth_press	null	null
ecoli_mpn	null	null
enable_sampler	null	null
hydrograph_state	null	null
nitrate	null	null
nitrite	null	null
phos_total	null	null
p_rain	%	Percent
p_rain001	%	Percent
sulfate	null	null
temp_cond	null	C
temp_press	null	C
trigger_sampler	null	null
t_sample	null	null
tss	null	null
us_cond	null	uS
v_batt	null	Volts
battery	null	null
shtrh	null	null
shttemp	null	null
soilconductivity	null	null
soilmoisture	null	null
soiltemp	null	null
sonicdepth	null	null
depth_sonic	mm	mm
\.


--
-- TOC entry 3921 (class 2606 OID 18798)
-- Name: devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (device_serial);


--
-- TOC entry 3927 (class 2606 OID 18837)
-- Name: latest_readings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY latest_readings
    ADD CONSTRAINT latest_readings_pkey PRIMARY KEY (device_serial, variable_id, taken_at);


--
-- TOC entry 3925 (class 2606 OID 18811)
-- Name: readings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_pkey PRIMARY KEY (device_serial, variable_id, taken_at);


--
-- TOC entry 3923 (class 2606 OID 18806)
-- Name: variables_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (variable_id);


--
-- TOC entry 4045 (class 2618 OID 18832)
-- Name: ignore_duplicate_readings; Type: RULE; Schema: public; Owner: -
--

CREATE RULE ignore_duplicate_readings AS ON INSERT TO readings WHERE (EXISTS (SELECT 1 FROM readings WHERE (((readings.device_serial)::text = (new.device_serial)::text) AND ((readings.variable_id)::text = (new.variable_id)::text) AND (readings.taken_at = new.taken_at)))) DO INSTEAD NOTHING;


--
-- TOC entry 3930 (class 2606 OID 18838)
-- Name: latest_readings_device_serial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY latest_readings
    ADD CONSTRAINT latest_readings_device_serial_fkey FOREIGN KEY (device_serial) REFERENCES devices(device_serial) ON DELETE CASCADE;


--
-- TOC entry 3931 (class 2606 OID 18843)
-- Name: latest_readings_variable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY latest_readings
    ADD CONSTRAINT latest_readings_variable_id_fkey FOREIGN KEY (variable_id) REFERENCES variables(variable_id) ON DELETE CASCADE;


--
-- TOC entry 3928 (class 2606 OID 18812)
-- Name: readings_device_serial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_device_serial_fkey FOREIGN KEY (device_serial) REFERENCES devices(device_serial) ON DELETE CASCADE;


--
-- TOC entry 3929 (class 2606 OID 18817)
-- Name: readings_variable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_variable_id_fkey FOREIGN KEY (variable_id) REFERENCES variables(variable_id) ON DELETE CASCADE;


-- Completed on 2016-12-21 18:37:17 UTC

--
-- PostgreSQL database dump complete
--

