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
-- Name: dns_account; Type: TABLE; Schema: public; Owner: cloudos_dns; Tablespace: 
--

CREATE TABLE dns_account (
    uuid character varying(100) NOT NULL,
    ctime bigint NOT NULL,
    name character varying(100) NOT NULL,
    admin boolean NOT NULL,
    hashed_password character varying(200) NOT NULL,
    reset_token character varying(30),
    reset_token_ctime bigint,
    zone character varying(1024)
);


ALTER TABLE public.dns_account OWNER TO cloudos_dns;

--
-- Data for Name: dns_account; Type: TABLE DATA; Schema: public; Owner: cloudos_dns
--

COPY dns_account (uuid, ctime, name, admin, hashed_password, reset_token, reset_token_ctime, zone) FROM stdin;
\.


--
-- Name: dns_account_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudos_dns; Tablespace: 
--

ALTER TABLE ONLY dns_account
    ADD CONSTRAINT dns_account_name_key UNIQUE (name);


--
-- Name: dns_account_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudos_dns; Tablespace: 
--

ALTER TABLE ONLY dns_account
    ADD CONSTRAINT dns_account_pkey PRIMARY KEY (uuid);


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

