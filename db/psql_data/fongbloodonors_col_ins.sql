--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

-- Started on 2017-04-10 18:20:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 16505)
-- Name: blood_donors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blood_donors (
    id integer NOT NULL,
    name character varying(255),
    age integer,
    phone_num character varying(255),
    address character varying(255),
    gender_id integer,
    blood_group_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    date_donated date,
    used boolean DEFAULT false,
    recipient_id integer
);


--
-- TOC entry 186 (class 1259 OID 16512)
-- Name: blood_donors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blood_donors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 186
-- Name: blood_donors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blood_donors_id_seq OWNED BY blood_donors.id;


--
-- TOC entry 187 (class 1259 OID 16514)
-- Name: blood_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blood_groups (
    id integer NOT NULL,
    blood_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 188 (class 1259 OID 16517)
-- Name: blood_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blood_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 188
-- Name: blood_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blood_groups_id_seq OWNED BY blood_groups.id;


--
-- TOC entry 189 (class 1259 OID 16519)
-- Name: blood_receivers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blood_receivers (
    id integer NOT NULL,
    name character varying(255),
    age integer,
    phone_num character varying(255),
    address character varying(255),
    gender_id integer,
    blood_group_id integer,
    date_received date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    blood_donor_id character varying(255)
);


--
-- TOC entry 190 (class 1259 OID 16525)
-- Name: blood_receivers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blood_receivers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 190
-- Name: blood_receivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blood_receivers_id_seq OWNED BY blood_receivers.id;


--
-- TOC entry 191 (class 1259 OID 16527)
-- Name: genders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE genders (
    id integer NOT NULL,
    sexval character varying(255),
    sexlabel character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 192 (class 1259 OID 16533)
-- Name: genders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE genders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 192
-- Name: genders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE genders_id_seq OWNED BY genders.id;


--
-- TOC entry 193 (class 1259 OID 16535)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 16538)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_roles (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 195 (class 1259 OID 16541)
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 195
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_roles_id_seq OWNED BY user_roles.id;


--
-- TOC entry 196 (class 1259 OID 16543)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    password_digest character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remember_token character varying(255),
    user_role_id integer
);


--
-- TOC entry 197 (class 1259 OID 16549)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 197
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 2040 (class 2604 OID 16551)
-- Name: blood_donors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_donors ALTER COLUMN id SET DEFAULT nextval('blood_donors_id_seq'::regclass);


--
-- TOC entry 2041 (class 2604 OID 16552)
-- Name: blood_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_groups ALTER COLUMN id SET DEFAULT nextval('blood_groups_id_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 16553)
-- Name: blood_receivers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_receivers ALTER COLUMN id SET DEFAULT nextval('blood_receivers_id_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 16554)
-- Name: genders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY genders ALTER COLUMN id SET DEFAULT nextval('genders_id_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 16555)
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_roles ALTER COLUMN id SET DEFAULT nextval('user_roles_id_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 16556)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2185 (class 0 OID 16505)
-- Dependencies: 185
-- Data for Name: blood_donors; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (9, 'Mass I Sallah', 29, '7777777', 'Abuko', 1, 1, '2016-02-07 21:41:57.246178', '2016-02-07 21:42:30.44679', '2016-02-09', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (1, 'test', 22, '7153333', 'Fajikunda', 1, 1, '2014-04-15 09:19:11.121575', '2014-04-15 09:19:11.121575', '2014-03-02', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (4, 'Abubacarr Jallow', 28, '7256668', 'Serrekunda', 1, 2, '2014-04-16 21:04:46.573685', '2014-04-16 21:04:46.573685', '2014-04-02', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (5, 'Yagou Trinn', 30, '7589996', 'Kanifing Estate', 2, 5, '2014-04-16 21:05:33.608989', '2014-04-16 21:05:33.608989', '2014-04-04', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (6, 'Mam Mbye Cham', 28, '7555555', 'Banjul', 1, 4, '2014-04-16 21:06:17.718381', '2014-04-16 21:06:17.718381', '2014-04-10', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (7, 'Peter Jarju', 30, '7999999', 'Fajikunda', 1, 3, '2014-04-16 21:06:51.207748', '2014-04-16 21:06:51.207748', '2014-04-12', false, NULL);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (2, 'Ronald senghore', 98, '7622808', 'Pipeline', 1, 1, '2014-04-15 09:38:39.120885', '2014-04-16 21:16:31.029418', '2014-03-05', true, 1);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (8, 'Mendy', 56, '7542890', 'Lamin', 1, 2, '2014-04-17 01:23:49.718978', '2014-04-17 01:29:23.833694', '2014-04-02', true, 2);
INSERT INTO blood_donors (id, name, age, phone_num, address, gender_id, blood_group_id, created_at, updated_at, date_donated, used, recipient_id) VALUES (3, 'Edu Secka', 28, '7777777', 'Sanchaba', 1, 1, '2014-04-16 21:03:53.897785', '2014-04-17 10:05:44.458197', '2014-03-31', true, 3);


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 186
-- Name: blood_donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blood_donors_id_seq', 9, true);


--
-- TOC entry 2187 (class 0 OID 16514)
-- Dependencies: 187
-- Data for Name: blood_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (1, 'A POS', '2014-04-11 17:13:40.067404', '2014-04-11 17:13:40.067404');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (2, 'A NEG', '2014-04-11 17:14:04.327792', '2014-04-11 17:14:40.123839');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (3, 'B POS', '2014-04-11 17:14:12.377252', '2014-04-11 17:14:33.657469');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (4, 'B NEG', '2014-04-11 17:14:17.75256', '2014-04-11 17:14:29.326221');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (5, 'O POS', '2014-04-11 17:14:29.326221', '2014-04-11 17:14:29.326221');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (6, 'O NEG', '2014-04-11 17:14:33.657469', '2014-04-11 17:14:33.657469');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (7, 'AB POS', '2014-04-11 17:14:40.123839', '2014-04-11 17:14:40.123839');
INSERT INTO blood_groups (id, blood_type, created_at, updated_at) VALUES (8, 'AB NEG', '2014-04-11 17:14:45.051121', '2014-04-11 17:14:45.051121');


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 188
-- Name: blood_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blood_groups_id_seq', 1, false);


--
-- TOC entry 2189 (class 0 OID 16519)
-- Dependencies: 189
-- Data for Name: blood_receivers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO blood_receivers (id, name, age, phone_num, address, gender_id, blood_group_id, date_received, created_at, updated_at, blood_donor_id) VALUES (1, 'Recipient Test', 25, '6855555', 'Fajikunda', 1, 1, '2014-04-16', '2014-04-16 21:16:31.020648', '2014-04-16 21:16:31.020648', '2');
INSERT INTO blood_receivers (id, name, age, phone_num, address, gender_id, blood_group_id, date_received, created_at, updated_at, blood_donor_id) VALUES (2, 'Lamin njie', 22, '7843689', 'Fajara', 1, 2, '2014-04-16', '2014-04-17 01:29:23.824962', '2014-04-17 01:29:23.824962', '8');
INSERT INTO blood_receivers (id, name, age, phone_num, address, gender_id, blood_group_id, date_received, created_at, updated_at, blood_donor_id) VALUES (3, 'lll', 55, '7777777', 'llololl', 1, 1, '2014-04-16', '2014-04-17 10:05:44.43599', '2014-04-17 10:05:44.43599', '3');


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 190
-- Name: blood_receivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blood_receivers_id_seq', 3, true);


--
-- TOC entry 2191 (class 0 OID 16527)
-- Dependencies: 191
-- Data for Name: genders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO genders (id, sexval, sexlabel, created_at, updated_at) VALUES (2, 'F', 'Female', '2014-04-11 17:43:50.787971', '2014-04-11 17:43:50.787971');
INSERT INTO genders (id, sexval, sexlabel, created_at, updated_at) VALUES (1, 'M', 'Male', '2014-04-11 17:43:40.154363', '2014-04-11 17:43:40.154363');


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 192
-- Name: genders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('genders_id_seq', 1, false);


--
-- TOC entry 2193 (class 0 OID 16535)
-- Dependencies: 193
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO schema_migrations (version) VALUES ('20140411161014');
INSERT INTO schema_migrations (version) VALUES ('20140411165900');
INSERT INTO schema_migrations (version) VALUES ('20140411174130');
INSERT INTO schema_migrations (version) VALUES ('20140411181757');
INSERT INTO schema_migrations (version) VALUES ('20140412222011');
INSERT INTO schema_migrations (version) VALUES ('20140412230654');
INSERT INTO schema_migrations (version) VALUES ('20140413210819');
INSERT INTO schema_migrations (version) VALUES ('20140413211026');
INSERT INTO schema_migrations (version) VALUES ('20140415133640');
INSERT INTO schema_migrations (version) VALUES ('20140415134444');
INSERT INTO schema_migrations (version) VALUES ('20140415160137');
INSERT INTO schema_migrations (version) VALUES ('20140415160447');
INSERT INTO schema_migrations (version) VALUES ('20140415171749');
INSERT INTO schema_migrations (version) VALUES ('20140416124021');


--
-- TOC entry 2194 (class 0 OID 16538)
-- Dependencies: 194
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO user_roles (id, name, created_at, updated_at) VALUES (1, 'Admin', '2014-04-13 21:21:34.804409', '2014-04-13 21:21:34.804409');
INSERT INTO user_roles (id, name, created_at, updated_at) VALUES (2, 'User', '2014-04-13 21:22:10.269438', '2014-04-13 21:22:10.269438');
INSERT INTO user_roles (id, name, created_at, updated_at) VALUES (3, 'Guest', '2014-04-13 21:22:25.856329', '2014-04-13 21:22:25.856329');


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 195
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_roles_id_seq', 1, false);


--
-- TOC entry 2196 (class 0 OID 16543)
-- Dependencies: 196
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (2, 'Ronald Senghore', 'rsenghore@test.com', '$2a$10$XRY6BH23wdUO2VL3lN4D5.pvYvDhTUKzOmY186PTKHOyHKgEBSup.', '2014-04-15 09:19:48.358688', '2015-06-30 15:09:17.974718', '99adb5eb48d63b0e6df5b8cdf53922c083cd0a14', 1);
INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (6, 'Mass Sallah', 'masssallah7@hotmail.com', '$2a$10$fzeGqRsqDoV5IBAUXHlnVegbM1Ha7IH2gPWDougKT1BIzplLu610S', '2016-02-08 23:33:01.399632', '2016-02-08 23:33:01.399632', NULL, 1);
INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (3, 'Guest User', 'guestuser@test.com', '$2a$10$OKUgOp53yN9q.wBHATg7weK6/DIUeZhues9mkcgC9Yj0FdbFj1NGW', '2014-04-15 09:20:29.482036', '2014-04-15 09:20:29.482036', NULL, 3);
INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (4, 'Normal User', 'normaluser@test.com', '$2a$10$0bF1rIkOllZqseg6tOj8WOyOgiiJvdJYVVNhTXMBlBnSheQYh2YEm', '2014-04-15 09:20:57.632406', '2014-04-15 09:20:57.632406', NULL, 2);
INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (5, 'Fatou L Njie', 'cherry.njie@gmail.com', '$2a$10$yKcsbfxAZ.8clm4RScX6IOyO.gCZi5AXCfmlZRbqOPQEGowxICtaK', '2014-08-12 17:19:08.982659', '2014-08-25 17:05:44.273264', '8da3de97990acd7f0b686011fd9c1c5cc7a77b81', 1);
INSERT INTO users (id, name, email, password_digest, created_at, updated_at, remember_token, user_role_id) VALUES (1, 'Charles Jarju', 'cjarju@africell.gm', '$2a$10$BzzmSjtqvxC5/LcDWaqxf.tWgML2xDaVOaVSUbK1Ro7/ZA5UjL2jG', '2014-04-12 23:33:10.966327', '2017-03-27 20:17:21.456101', '2e2693eef9b55ffb77cc96b0ddbc60a3b69dda60', 1);


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 197
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 6, true);


--
-- TOC entry 2047 (class 2606 OID 16558)
-- Name: blood_donors blood_donors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_donors
    ADD CONSTRAINT blood_donors_pkey PRIMARY KEY (id);


--
-- TOC entry 2052 (class 2606 OID 16560)
-- Name: blood_groups blood_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_groups
    ADD CONSTRAINT blood_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 2606 OID 16562)
-- Name: blood_receivers blood_receivers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blood_receivers
    ADD CONSTRAINT blood_receivers_pkey PRIMARY KEY (id);


--
-- TOC entry 2059 (class 2606 OID 16564)
-- Name: genders genders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);


--
-- TOC entry 2062 (class 2606 OID 16566)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2067 (class 2606 OID 16568)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2048 (class 1259 OID 16569)
-- Name: index_blood_donors_on_blood_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_donors_on_blood_group_id ON blood_donors USING btree (blood_group_id);


--
-- TOC entry 2049 (class 1259 OID 16570)
-- Name: index_blood_donors_on_gender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_donors_on_gender_id ON blood_donors USING btree (gender_id);


--
-- TOC entry 2050 (class 1259 OID 16571)
-- Name: index_blood_donors_on_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_donors_on_recipient_id ON blood_donors USING btree (recipient_id);


--
-- TOC entry 2055 (class 1259 OID 16572)
-- Name: index_blood_receivers_on_blood_donor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_receivers_on_blood_donor_id ON blood_receivers USING btree (blood_donor_id);


--
-- TOC entry 2056 (class 1259 OID 16573)
-- Name: index_blood_receivers_on_blood_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_receivers_on_blood_group_id ON blood_receivers USING btree (blood_group_id);


--
-- TOC entry 2057 (class 1259 OID 16574)
-- Name: index_blood_receivers_on_gender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blood_receivers_on_gender_id ON blood_receivers USING btree (gender_id);


--
-- TOC entry 2063 (class 1259 OID 16575)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- TOC entry 2064 (class 1259 OID 16576)
-- Name: index_users_on_remember_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_remember_token ON users USING btree (remember_token);


--
-- TOC entry 2065 (class 1259 OID 16577)
-- Name: index_users_on_user_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_user_role_id ON users USING btree (user_role_id);


--
-- TOC entry 2060 (class 1259 OID 16578)
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


-- Completed on 2017-04-10 18:20:50

--
-- PostgreSQL database dump complete
--

