--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE account (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    name character varying(100) NOT NULL,
    admin boolean NOT NULL,
    auth_id character varying(30),
    email character varying(255) NOT NULL,
    email_verification_code character varying(100),
    email_verification_code_created_at bigint,
    email_verified boolean NOT NULL,
    first_name character varying(25) NOT NULL,
    last_login bigint,
    last_name character varying(25) NOT NULL,
    mobile_phone character varying(30),
    mobile_phone_country_code integer,
    mobile_phone_verification_code character varying(100),
    mobile_phone_verification_code_created_at bigint,
    mobile_phone_verified boolean NOT NULL,
    suspended boolean NOT NULL,
    two_factor boolean NOT NULL,
    primary_group character varying(100),
    storage_quota character varying(10)
);


ALTER TABLE public.account OWNER TO cloudos;

--
-- Name: account_device; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE account_device (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    account character varying(255),
    auth_time bigint,
    device_id character varying(255),
    device_name character varying(255)
);


ALTER TABLE public.account_device OWNER TO cloudos;

--
-- Name: account_group; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE account_group (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200),
    storage_quota character varying(10)
);


ALTER TABLE public.account_group OWNER TO cloudos;

--
-- Name: account_group_member; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE account_group_member (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    group_name character varying(100) NOT NULL,
    group_uuid character varying(100) NOT NULL,
    member_name character varying(100) NOT NULL,
    member_uuid character varying(100) NOT NULL,
    type character varying(255)
);


ALTER TABLE public.account_group_member OWNER TO cloudos;

--
-- Name: email_domain; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE email_domain (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.email_domain OWNER TO cloudos;

--
-- Name: installed_app; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE installed_app (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    account character varying(255),
    active boolean NOT NULL,
    hostname character varying(255),
    manifest_json character varying(4096),
    name character varying(255) NOT NULL,
    path character varying(255),
    port integer NOT NULL
);


ALTER TABLE public.installed_app OWNER TO cloudos;

--
-- Name: ssl_certificate; Type: TABLE; Schema: public; Owner: cloudos; Tablespace: 
--

CREATE TABLE ssl_certificate (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    name character varying(100) NOT NULL,
    common_name character varying(255),
    description character varying(255),
    key_md5 character varying(255),
    key_sha character varying(255),
    pem_md5 character varying(255),
    pem_sha character varying(255)
);


ALTER TABLE public.ssl_certificate OWNER TO cloudos;

--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY account (uuid, ctime, name, admin, auth_id, email, email_verification_code, email_verification_code_created_at, email_verified, first_name, last_login, last_name, mobile_phone, mobile_phone_country_code, mobile_phone_verification_code, mobile_phone_verification_code_created_at, mobile_phone_verified, suspended, two_factor, primary_group, storage_quota) FROM stdin;
\.


--
-- Data for Name: account_device; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY account_device (uuid, ctime, account, auth_time, device_id, device_name) FROM stdin;
\.


--
-- Data for Name: account_group; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY account_group (uuid, ctime, name, description, storage_quota) FROM stdin;
\.


--
-- Data for Name: account_group_member; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY account_group_member (uuid, ctime, group_name, group_uuid, member_name, member_uuid, type) FROM stdin;
\.


--
-- Data for Name: email_domain; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY email_domain (uuid, ctime, name) FROM stdin;
\.


--
-- Data for Name: installed_app; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY installed_app (uuid, ctime, account, active, hostname, manifest_json, name, path, port) FROM stdin;
\.


--
-- Data for Name: ssl_certificate; Type: TABLE DATA; Schema: public; Owner: cloudos
--

COPY ssl_certificate (uuid, ctime, name, common_name, description, key_md5, key_sha, pem_md5, pem_sha) FROM stdin;
53905e9b-7ecc-4176-aeb9-ff4d6f5cee37	1412404090695	ssl-https	*.cloudstead.io	cloudstead.io wildcard certificate	23a5bcd716f54cc819a7367e64fe70e9	1844d332ccb478a82eb038e947988b1b1e5b7882ddda85456efbc89bca327e97	e367ebcdec3792a33c0005e8b8098040	761f5e4128089695d51600c36e6b96438828e0ee7c76d7a15da2c13516832417
\.


--
-- Name: account_device_account_device_id_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_device
    ADD CONSTRAINT account_device_account_device_id_key UNIQUE (account, device_id);


--
-- Name: account_device_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_device
    ADD CONSTRAINT account_device_pkey PRIMARY KEY (uuid);


--
-- Name: account_email_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account_group_member_group_uuid_member_uuid_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_group_member
    ADD CONSTRAINT account_group_member_group_uuid_member_uuid_key UNIQUE (group_uuid, member_uuid);


--
-- Name: account_group_member_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_group_member
    ADD CONSTRAINT account_group_member_pkey PRIMARY KEY (uuid);


--
-- Name: account_group_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_group
    ADD CONSTRAINT account_group_name_key UNIQUE (name);


--
-- Name: account_group_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account_group
    ADD CONSTRAINT account_group_pkey PRIMARY KEY (uuid);


--
-- Name: account_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_name_key UNIQUE (name);


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (uuid);


--
-- Name: email_domain_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY email_domain
    ADD CONSTRAINT email_domain_name_key UNIQUE (name);


--
-- Name: email_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY email_domain
    ADD CONSTRAINT email_domain_pkey PRIMARY KEY (uuid);


--
-- Name: installed_app_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY installed_app
    ADD CONSTRAINT installed_app_name_key UNIQUE (name);


--
-- Name: installed_app_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY installed_app
    ADD CONSTRAINT installed_app_pkey PRIMARY KEY (uuid);


--
-- Name: ssl_certificate_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY ssl_certificate
    ADD CONSTRAINT ssl_certificate_name_key UNIQUE (name);


--
-- Name: ssl_certificate_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos; Tablespace: 
--

ALTER TABLE ONLY ssl_certificate
    ADD CONSTRAINT ssl_certificate_pkey PRIMARY KEY (uuid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

