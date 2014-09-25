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
-- Name: oc_activity; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_activity (
    activity_id integer NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    type character varying(255) NOT NULL,
    "user" character varying(64) NOT NULL,
    affecteduser character varying(64) NOT NULL,
    app character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    subjectparams character varying(255) NOT NULL,
    message character varying(255) DEFAULT NULL::character varying,
    messageparams character varying(255) DEFAULT NULL::character varying,
    file character varying(255) DEFAULT NULL::character varying,
    link character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_activity OWNER TO owncloud;

--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_activity_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_activity_activity_id_seq OWNER TO owncloud;

--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_activity_activity_id_seq OWNED BY oc_activity.activity_id;


--
-- Name: oc_activity_mq; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_activity_mq (
    mail_id integer NOT NULL,
    amq_timestamp integer DEFAULT 0 NOT NULL,
    amq_latest_send integer DEFAULT 0 NOT NULL,
    amq_type character varying(255) NOT NULL,
    amq_affecteduser character varying(64) NOT NULL,
    amq_appid character varying(255) NOT NULL,
    amq_subject character varying(255) NOT NULL,
    amq_subjectparams character varying(255) NOT NULL
);


ALTER TABLE public.oc_activity_mq OWNER TO owncloud;

--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_activity_mq_mail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_activity_mq_mail_id_seq OWNER TO owncloud;

--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_activity_mq_mail_id_seq OWNED BY oc_activity_mq.mail_id;


--
-- Name: oc_appconfig; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_appconfig (
    appid character varying(32) DEFAULT ''::character varying NOT NULL,
    configkey character varying(64) DEFAULT ''::character varying NOT NULL,
    configvalue text
);


ALTER TABLE public.oc_appconfig OWNER TO owncloud;

--
-- Name: oc_clndr_calendars; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_clndr_calendars (
    id integer NOT NULL,
    userid character varying(255) DEFAULT NULL::character varying,
    displayname character varying(100) DEFAULT NULL::character varying,
    uri character varying(255) DEFAULT NULL::character varying,
    active integer DEFAULT 1 NOT NULL,
    ctag integer DEFAULT 0 NOT NULL,
    calendarorder integer DEFAULT 0 NOT NULL,
    calendarcolor character varying(10) DEFAULT NULL::character varying,
    timezone text,
    components character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_clndr_calendars OWNER TO owncloud;

--
-- Name: oc_clndr_calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_clndr_calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_clndr_calendars_id_seq OWNER TO owncloud;

--
-- Name: oc_clndr_calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_clndr_calendars_id_seq OWNED BY oc_clndr_calendars.id;


--
-- Name: oc_clndr_objects; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_clndr_objects (
    id integer NOT NULL,
    calendarid integer DEFAULT 0 NOT NULL,
    objecttype character varying(40) DEFAULT ''::character varying NOT NULL,
    startdate timestamp(0) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    enddate timestamp(0) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    repeating integer DEFAULT 0,
    summary character varying(255) DEFAULT NULL::character varying,
    calendardata text,
    uri character varying(255) DEFAULT NULL::character varying,
    lastmodified integer DEFAULT 0
);


ALTER TABLE public.oc_clndr_objects OWNER TO owncloud;

--
-- Name: oc_clndr_objects_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_clndr_objects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_clndr_objects_id_seq OWNER TO owncloud;

--
-- Name: oc_clndr_objects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_clndr_objects_id_seq OWNED BY oc_clndr_objects.id;


--
-- Name: oc_clndr_repeat; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_clndr_repeat (
    id integer NOT NULL,
    eventid integer DEFAULT 0 NOT NULL,
    calid integer DEFAULT 0 NOT NULL,
    startdate timestamp(0) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    enddate timestamp(0) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.oc_clndr_repeat OWNER TO owncloud;

--
-- Name: oc_clndr_repeat_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_clndr_repeat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_clndr_repeat_id_seq OWNER TO owncloud;

--
-- Name: oc_clndr_repeat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_clndr_repeat_id_seq OWNED BY oc_clndr_repeat.id;


--
-- Name: oc_clndr_share_calendar; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_clndr_share_calendar (
    owner character varying(255) NOT NULL,
    share character varying(255) NOT NULL,
    sharetype character varying(6) NOT NULL,
    calendarid bigint DEFAULT (0)::bigint NOT NULL,
    permissions smallint NOT NULL,
    active integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_clndr_share_calendar OWNER TO owncloud;

--
-- Name: oc_clndr_share_event; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_clndr_share_event (
    owner character varying(255) NOT NULL,
    share character varying(255) NOT NULL,
    sharetype character varying(6) NOT NULL,
    eventid bigint DEFAULT (0)::bigint NOT NULL,
    permissions smallint NOT NULL
);


ALTER TABLE public.oc_clndr_share_event OWNER TO owncloud;

--
-- Name: oc_contacts_addressbooks; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_contacts_addressbooks (
    id integer NOT NULL,
    userid character varying(255) DEFAULT ''::character varying NOT NULL,
    displayname character varying(255) DEFAULT NULL::character varying,
    uri character varying(200) DEFAULT NULL::character varying,
    description character varying(255) DEFAULT NULL::character varying,
    ctag integer DEFAULT 1 NOT NULL,
    active integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_contacts_addressbooks OWNER TO owncloud;

--
-- Name: oc_contacts_addressbooks_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_contacts_addressbooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_contacts_addressbooks_id_seq OWNER TO owncloud;

--
-- Name: oc_contacts_addressbooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_contacts_addressbooks_id_seq OWNED BY oc_contacts_addressbooks.id;


--
-- Name: oc_contacts_cards; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_contacts_cards (
    id integer NOT NULL,
    addressbookid integer DEFAULT 0 NOT NULL,
    fullname character varying(255) DEFAULT NULL::character varying,
    carddata text,
    uri character varying(200) DEFAULT NULL::character varying,
    lastmodified integer DEFAULT 0
);


ALTER TABLE public.oc_contacts_cards OWNER TO owncloud;

--
-- Name: oc_contacts_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_contacts_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_contacts_cards_id_seq OWNER TO owncloud;

--
-- Name: oc_contacts_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_contacts_cards_id_seq OWNED BY oc_contacts_cards.id;


--
-- Name: oc_contacts_cards_properties; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_contacts_cards_properties (
    id integer NOT NULL,
    userid character varying(255) DEFAULT ''::character varying NOT NULL,
    contactid integer DEFAULT 0 NOT NULL,
    name character varying(64) DEFAULT NULL::character varying,
    value character varying(255) DEFAULT NULL::character varying,
    preferred integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_contacts_cards_properties OWNER TO owncloud;

--
-- Name: oc_contacts_cards_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_contacts_cards_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_contacts_cards_properties_id_seq OWNER TO owncloud;

--
-- Name: oc_contacts_cards_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_contacts_cards_properties_id_seq OWNED BY oc_contacts_cards_properties.id;


--
-- Name: oc_documents_invite; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_documents_invite (
    es_id character varying(64) NOT NULL,
    uid character varying(64),
    status smallint DEFAULT (0)::smallint,
    sent_on integer DEFAULT 0
);


ALTER TABLE public.oc_documents_invite OWNER TO owncloud;

--
-- Name: COLUMN oc_documents_invite.es_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_invite.es_id IS 'Related editing session id';


--
-- Name: oc_documents_member; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_documents_member (
    member_id integer NOT NULL,
    es_id character varying(64) NOT NULL,
    uid character varying(64),
    color character varying(32),
    last_activity integer,
    status smallint DEFAULT 1::smallint NOT NULL,
    is_guest smallint DEFAULT 0::smallint NOT NULL,
    token character varying(32) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_documents_member OWNER TO owncloud;

--
-- Name: COLUMN oc_documents_member.member_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_member.member_id IS 'Unique per user and session';


--
-- Name: COLUMN oc_documents_member.es_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_member.es_id IS 'Related editing session id';


--
-- Name: oc_documents_member_member_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_documents_member_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_documents_member_member_id_seq OWNER TO owncloud;

--
-- Name: oc_documents_member_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_documents_member_member_id_seq OWNED BY oc_documents_member.member_id;


--
-- Name: oc_documents_op; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_documents_op (
    seq integer NOT NULL,
    es_id character varying(64) NOT NULL,
    member integer DEFAULT 1 NOT NULL,
    opspec text
);


ALTER TABLE public.oc_documents_op OWNER TO owncloud;

--
-- Name: COLUMN oc_documents_op.seq; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_op.seq IS 'Sequence number';


--
-- Name: COLUMN oc_documents_op.es_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_op.es_id IS 'Editing session id';


--
-- Name: COLUMN oc_documents_op.member; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_op.member IS 'User and time specific';


--
-- Name: COLUMN oc_documents_op.opspec; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_op.opspec IS 'json-string';


--
-- Name: oc_documents_op_seq_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_documents_op_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_documents_op_seq_seq OWNER TO owncloud;

--
-- Name: oc_documents_op_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_documents_op_seq_seq OWNED BY oc_documents_op.seq;


--
-- Name: oc_documents_revisions; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_documents_revisions (
    es_id character varying(64) NOT NULL,
    seq_head integer NOT NULL,
    member_id integer NOT NULL,
    file_id character varying(512),
    save_hash character varying(128) NOT NULL
);


ALTER TABLE public.oc_documents_revisions OWNER TO owncloud;

--
-- Name: COLUMN oc_documents_revisions.es_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_revisions.es_id IS 'Related editing session id';


--
-- Name: COLUMN oc_documents_revisions.seq_head; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_revisions.seq_head IS 'Sequence head number';


--
-- Name: COLUMN oc_documents_revisions.member_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_revisions.member_id IS 'the member that saved the revision';


--
-- Name: COLUMN oc_documents_revisions.file_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_revisions.file_id IS 'Relative to storage e.g. /welcome.odt';


--
-- Name: COLUMN oc_documents_revisions.save_hash; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_revisions.save_hash IS 'used to lookup revision in documents folder of member, eg hash.odt';


--
-- Name: oc_documents_session; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_documents_session (
    es_id character varying(64) NOT NULL,
    genesis_url character varying(512),
    genesis_hash character varying(128) NOT NULL,
    file_id character varying(512),
    owner character varying(64) NOT NULL
);


ALTER TABLE public.oc_documents_session OWNER TO owncloud;

--
-- Name: COLUMN oc_documents_session.es_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_session.es_id IS 'Editing session id';


--
-- Name: COLUMN oc_documents_session.genesis_url; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_session.genesis_url IS 'Relative to owner documents storage /welcome.odt';


--
-- Name: COLUMN oc_documents_session.genesis_hash; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_session.genesis_hash IS 'To be sure the genesis did not change';


--
-- Name: COLUMN oc_documents_session.file_id; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_session.file_id IS 'Relative to storage e.g. /welcome.odt';


--
-- Name: COLUMN oc_documents_session.owner; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_documents_session.owner IS 'oC user who created the session';


--
-- Name: oc_file_map; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_file_map (
    logic_path character varying(512) DEFAULT ''::character varying NOT NULL,
    logic_path_hash character varying(32) DEFAULT ''::character varying NOT NULL,
    physic_path character varying(512) DEFAULT ''::character varying NOT NULL,
    physic_path_hash character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_file_map OWNER TO owncloud;

--
-- Name: oc_filecache; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_filecache (
    fileid integer NOT NULL,
    storage integer DEFAULT 0 NOT NULL,
    path character varying(4000) DEFAULT NULL::character varying,
    path_hash character varying(32) DEFAULT ''::character varying NOT NULL,
    parent integer DEFAULT 0 NOT NULL,
    name character varying(250) DEFAULT NULL::character varying,
    mimetype integer DEFAULT 0 NOT NULL,
    mimepart integer DEFAULT 0 NOT NULL,
    size bigint DEFAULT (0)::bigint NOT NULL,
    mtime integer DEFAULT 0 NOT NULL,
    storage_mtime integer DEFAULT 0 NOT NULL,
    encrypted integer DEFAULT 0 NOT NULL,
    unencrypted_size bigint DEFAULT (0)::bigint NOT NULL,
    etag character varying(40) DEFAULT NULL::character varying,
    permissions integer DEFAULT 0
);


ALTER TABLE public.oc_filecache OWNER TO owncloud;

--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_filecache_fileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_filecache_fileid_seq OWNER TO owncloud;

--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_filecache_fileid_seq OWNED BY oc_filecache.fileid;


--
-- Name: oc_files_trash; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_files_trash (
    id character varying(250) DEFAULT ''::character varying NOT NULL,
    "user" character varying(64) DEFAULT ''::character varying NOT NULL,
    "timestamp" character varying(12) DEFAULT ''::character varying NOT NULL,
    location character varying(512) DEFAULT ''::character varying NOT NULL,
    type character varying(4) DEFAULT ''::character varying,
    mime character varying(255) DEFAULT ''::character varying,
    auto_id integer NOT NULL
);


ALTER TABLE public.oc_files_trash OWNER TO owncloud;

--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_files_trash_auto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_files_trash_auto_id_seq OWNER TO owncloud;

--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_files_trash_auto_id_seq OWNED BY oc_files_trash.auto_id;


--
-- Name: oc_gallery_sharing; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_gallery_sharing (
    token character varying(64) NOT NULL,
    gallery_id integer DEFAULT 0 NOT NULL,
    recursive smallint NOT NULL
);


ALTER TABLE public.oc_gallery_sharing OWNER TO owncloud;

--
-- Name: oc_group_admin; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_group_admin (
    gid character varying(64) DEFAULT ''::character varying NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_group_admin OWNER TO owncloud;

--
-- Name: oc_group_user; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_group_user (
    gid character varying(64) DEFAULT ''::character varying NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_group_user OWNER TO owncloud;

--
-- Name: oc_groups; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_groups (
    gid character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_groups OWNER TO owncloud;

--
-- Name: oc_jobs; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_jobs (
    id integer NOT NULL,
    class character varying(255) DEFAULT ''::character varying NOT NULL,
    argument character varying(256) DEFAULT ''::character varying NOT NULL,
    last_run integer DEFAULT 0
);


ALTER TABLE public.oc_jobs OWNER TO owncloud;

--
-- Name: oc_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_jobs_id_seq OWNER TO owncloud;

--
-- Name: oc_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_jobs_id_seq OWNED BY oc_jobs.id;


--
-- Name: oc_locks; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_locks (
    id integer NOT NULL,
    userid character varying(64) DEFAULT NULL::character varying,
    owner character varying(100) DEFAULT NULL::character varying,
    timeout integer,
    created bigint,
    token character varying(100) DEFAULT NULL::character varying,
    scope smallint,
    depth smallint,
    uri text
);


ALTER TABLE public.oc_locks OWNER TO owncloud;

--
-- Name: oc_locks_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_locks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_locks_id_seq OWNER TO owncloud;

--
-- Name: oc_locks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_locks_id_seq OWNED BY oc_locks.id;


--
-- Name: oc_lucene_status; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_lucene_status (
    fileid integer DEFAULT 0 NOT NULL,
    status character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_lucene_status OWNER TO owncloud;

--
-- Name: oc_mimetypes; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_mimetypes (
    id integer NOT NULL,
    mimetype character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_mimetypes OWNER TO owncloud;

--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_mimetypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_mimetypes_id_seq OWNER TO owncloud;

--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_mimetypes_id_seq OWNED BY oc_mimetypes.id;


--
-- Name: oc_oc_activity_9024bd838c7bf_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_activity_9024bd838c7bf_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_activity_9024bd838c7bf_activity_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_clndr_calendars_0c051e141fd08_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_clndr_calendars_0c051e141fd08_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_clndr_calendars_0c051e141fd08_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_clndr_objects_a9b13b1f1ab2a_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_clndr_objects_a9b13b1f1ab2a_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_clndr_objects_a9b13b1f1ab2a_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_clndr_repeat_af90414337a13_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_clndr_repeat_af90414337a13_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_clndr_repeat_af90414337a13_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_contacts_addressbooks_da52ed8fbe49b_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_contacts_addressbooks_da52ed8fbe49b_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_contacts_addressbooks_da52ed8fbe49b_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_contacts_cards_a4b3b4e0bdb7f_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_contacts_cards_a4b3b4e0bdb7f_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_contacts_cards_a4b3b4e0bdb7f_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_contacts_cards_properties_de6a120b6ba4e_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_contacts_cards_properties_de6a120b6ba4e_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_contacts_cards_properties_de6a120b6ba4e_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_documents_member_176d304bf7495_member_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_documents_member_176d304bf7495_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_documents_member_176d304bf7495_member_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_documents_op_68ed6bd5434b6_seq_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_documents_op_68ed6bd5434b6_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_documents_op_68ed6bd5434b6_seq_seq OWNER TO owncloud;

--
-- Name: oc_oc_filecache_45146385b5d7a_fileid_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_filecache_45146385b5d7a_fileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_filecache_45146385b5d7a_fileid_seq OWNER TO owncloud;

--
-- Name: oc_oc_jobs_5d22eb64398a8_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_jobs_5d22eb64398a8_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_jobs_5d22eb64398a8_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_locks_e0b65c1c74038_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_locks_e0b65c1c74038_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_locks_e0b65c1c74038_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_mimetypes_d579189614976_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_mimetypes_d579189614976_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_mimetypes_d579189614976_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_privatedata_332050593c94b_keyid_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_privatedata_332050593c94b_keyid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_privatedata_332050593c94b_keyid_seq OWNER TO owncloud;

--
-- Name: oc_oc_properties_764d57a5b0bfd_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_properties_764d57a5b0bfd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_properties_764d57a5b0bfd_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_share_dc01eb825df1f_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_share_dc01eb825df1f_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_share_dc01eb825df1f_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_storages_5ac5d234e0d9e_numeric_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_storages_5ac5d234e0d9e_numeric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_storages_5ac5d234e0d9e_numeric_id_seq OWNER TO owncloud;

--
-- Name: oc_oc_vcategory_5b3852c8c7449_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_oc_vcategory_5b3852c8c7449_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_oc_vcategory_5b3852c8c7449_id_seq OWNER TO owncloud;

--
-- Name: oc_permissions; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_permissions (
    fileid integer DEFAULT 0 NOT NULL,
    "user" character varying(64) DEFAULT NULL::character varying,
    permissions integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_permissions OWNER TO owncloud;

--
-- Name: oc_pictures_images_cache; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_pictures_images_cache (
    uid_owner character varying(64) NOT NULL,
    path character varying(256) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL
);


ALTER TABLE public.oc_pictures_images_cache OWNER TO owncloud;

--
-- Name: oc_preferences; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_preferences (
    userid character varying(64) DEFAULT ''::character varying NOT NULL,
    appid character varying(32) DEFAULT ''::character varying NOT NULL,
    configkey character varying(64) DEFAULT ''::character varying NOT NULL,
    configvalue text
);


ALTER TABLE public.oc_preferences OWNER TO owncloud;

--
-- Name: oc_privatedata; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_privatedata (
    keyid integer NOT NULL,
    "user" character varying(64) DEFAULT ''::character varying NOT NULL,
    app character varying(255) DEFAULT ''::character varying NOT NULL,
    key character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_privatedata OWNER TO owncloud;

--
-- Name: oc_privatedata_keyid_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_privatedata_keyid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_privatedata_keyid_seq OWNER TO owncloud;

--
-- Name: oc_privatedata_keyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_privatedata_keyid_seq OWNED BY oc_privatedata.keyid;


--
-- Name: oc_properties; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_properties (
    id integer NOT NULL,
    userid character varying(64) DEFAULT ''::character varying NOT NULL,
    propertypath character varying(255) DEFAULT ''::character varying NOT NULL,
    propertyname character varying(255) DEFAULT ''::character varying NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


ALTER TABLE public.oc_properties OWNER TO owncloud;

--
-- Name: oc_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_properties_id_seq OWNER TO owncloud;

--
-- Name: oc_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_properties_id_seq OWNED BY oc_properties.id;


--
-- Name: oc_share; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_share (
    id integer NOT NULL,
    share_type smallint DEFAULT (0)::smallint NOT NULL,
    share_with character varying(255) DEFAULT NULL::character varying,
    uid_owner character varying(64) DEFAULT ''::character varying NOT NULL,
    parent integer,
    item_type character varying(64) DEFAULT ''::character varying NOT NULL,
    item_source character varying(255) DEFAULT NULL::character varying,
    item_target character varying(255) DEFAULT NULL::character varying,
    file_source integer,
    file_target character varying(512) DEFAULT NULL::character varying,
    permissions smallint DEFAULT (0)::smallint NOT NULL,
    stime bigint DEFAULT (0)::bigint NOT NULL,
    accepted smallint DEFAULT (0)::smallint NOT NULL,
    expiration timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    token character varying(32) DEFAULT NULL::character varying,
    mail_send smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE public.oc_share OWNER TO owncloud;

--
-- Name: oc_share_external; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_share_external (
    id integer NOT NULL,
    remote character varying(512) NOT NULL,
    share_token character varying(64) NOT NULL,
    password character varying(64) NOT NULL,
    name character varying(64) NOT NULL,
    owner character varying(64) NOT NULL,
    "user" character varying(64) NOT NULL,
    mountpoint character varying(4000) NOT NULL,
    mountpoint_hash character varying(32) NOT NULL
);


ALTER TABLE public.oc_share_external OWNER TO owncloud;

--
-- Name: COLUMN oc_share_external.remote; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.remote IS 'Url of the remove owncloud instance';


--
-- Name: COLUMN oc_share_external.share_token; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.share_token IS 'Public share token';


--
-- Name: COLUMN oc_share_external.password; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.password IS 'Optional password for the public share';


--
-- Name: COLUMN oc_share_external.name; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.name IS 'Original name on the remote server';


--
-- Name: COLUMN oc_share_external.owner; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.owner IS 'User that owns the public share on the remote server';


--
-- Name: COLUMN oc_share_external."user"; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external."user" IS 'Local user which added the external share';


--
-- Name: COLUMN oc_share_external.mountpoint; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.mountpoint IS 'Full path where the share is mounted';


--
-- Name: COLUMN oc_share_external.mountpoint_hash; Type: COMMENT; Schema: public; Owner: owncloud
--

COMMENT ON COLUMN oc_share_external.mountpoint_hash IS 'md5 hash of the mountpoint';


--
-- Name: oc_share_external_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_share_external_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_share_external_id_seq OWNER TO owncloud;

--
-- Name: oc_share_external_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_share_external_id_seq OWNED BY oc_share_external.id;


--
-- Name: oc_share_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_share_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_share_id_seq OWNER TO owncloud;

--
-- Name: oc_share_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_share_id_seq OWNED BY oc_share.id;


--
-- Name: oc_storages; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_storages (
    id character varying(64) DEFAULT NULL::character varying,
    numeric_id integer NOT NULL
);


ALTER TABLE public.oc_storages OWNER TO owncloud;

--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_storages_numeric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_storages_numeric_id_seq OWNER TO owncloud;

--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_storages_numeric_id_seq OWNED BY oc_storages.numeric_id;


--
-- Name: oc_users; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_users (
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    displayname character varying(64) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_users OWNER TO owncloud;

--
-- Name: oc_users_external; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_users_external (
    backend character varying(128) DEFAULT ''::character varying NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    displayname character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_users_external OWNER TO owncloud;

--
-- Name: oc_vcategory; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_vcategory (
    id integer NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    category character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_vcategory OWNER TO owncloud;

--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: owncloud
--

CREATE SEQUENCE oc_vcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oc_vcategory_id_seq OWNER TO owncloud;

--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owncloud
--

ALTER SEQUENCE oc_vcategory_id_seq OWNED BY oc_vcategory.id;


--
-- Name: oc_vcategory_to_object; Type: TABLE; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE TABLE oc_vcategory_to_object (
    objid integer DEFAULT 0 NOT NULL,
    categoryid integer DEFAULT 0 NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_vcategory_to_object OWNER TO owncloud;

--
-- Name: activity_id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_activity ALTER COLUMN activity_id SET DEFAULT nextval('oc_activity_activity_id_seq'::regclass);


--
-- Name: mail_id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_activity_mq ALTER COLUMN mail_id SET DEFAULT nextval('oc_activity_mq_mail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_clndr_calendars ALTER COLUMN id SET DEFAULT nextval('oc_clndr_calendars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_clndr_objects ALTER COLUMN id SET DEFAULT nextval('oc_clndr_objects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_clndr_repeat ALTER COLUMN id SET DEFAULT nextval('oc_clndr_repeat_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_contacts_addressbooks ALTER COLUMN id SET DEFAULT nextval('oc_contacts_addressbooks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_contacts_cards ALTER COLUMN id SET DEFAULT nextval('oc_contacts_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_contacts_cards_properties ALTER COLUMN id SET DEFAULT nextval('oc_contacts_cards_properties_id_seq'::regclass);


--
-- Name: member_id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_documents_member ALTER COLUMN member_id SET DEFAULT nextval('oc_documents_member_member_id_seq'::regclass);


--
-- Name: seq; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_documents_op ALTER COLUMN seq SET DEFAULT nextval('oc_documents_op_seq_seq'::regclass);


--
-- Name: fileid; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_filecache ALTER COLUMN fileid SET DEFAULT nextval('oc_filecache_fileid_seq'::regclass);


--
-- Name: auto_id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_files_trash ALTER COLUMN auto_id SET DEFAULT nextval('oc_files_trash_auto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_jobs ALTER COLUMN id SET DEFAULT nextval('oc_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_locks ALTER COLUMN id SET DEFAULT nextval('oc_locks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_mimetypes ALTER COLUMN id SET DEFAULT nextval('oc_mimetypes_id_seq'::regclass);


--
-- Name: keyid; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_privatedata ALTER COLUMN keyid SET DEFAULT nextval('oc_privatedata_keyid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_properties ALTER COLUMN id SET DEFAULT nextval('oc_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_share ALTER COLUMN id SET DEFAULT nextval('oc_share_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_share_external ALTER COLUMN id SET DEFAULT nextval('oc_share_external_id_seq'::regclass);


--
-- Name: numeric_id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_storages ALTER COLUMN numeric_id SET DEFAULT nextval('oc_storages_numeric_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: owncloud
--

ALTER TABLE ONLY oc_vcategory ALTER COLUMN id SET DEFAULT nextval('oc_vcategory_id_seq'::regclass);


--
-- Data for Name: oc_activity; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_activity (activity_id, "timestamp", priority, type, "user", affecteduser, app, subject, subjectparams, message, messageparams, file, link) FROM stdin;
\.


--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_activity_activity_id_seq', 1, false);


--
-- Data for Name: oc_activity_mq; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_activity_mq (mail_id, amq_timestamp, amq_latest_send, amq_type, amq_affecteduser, amq_appid, amq_subject, amq_subjectparams) FROM stdin;
\.


--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_activity_mq_mail_id_seq', 1, false);


--
-- Data for Name: oc_appconfig; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_appconfig (appid, configkey, configvalue) FROM stdin;
core	installedat	1396478460.0623
core	remote_core.css	/core/minimizer.php
core	remote_core.js	/core/minimizer.php
core	remote_calendar	calendar/appinfo/remote.php
core	remote_caldav	calendar/appinfo/remote.php
core	public_calendar	calendar/share.php
core	public_caldav	calendar/share.php
calendar	types	
calendar	enabled	yes
search_lucene	types	filesystem
search_lucene	enabled	yes
core	remote_contacts	contacts/appinfo/remote.php
core	remote_carddav	contacts/appinfo/remote.php
contacts	types	
contacts	enabled	yes
files_videoviewer	types	
files_videoviewer	enabled	yes
core	public_files	files_sharing/public.php
files_sharing	types	filesystem
files_sharing	enabled	yes
files_texteditor	types	
files_texteditor	enabled	yes
core	public_documents	documents/public.php
documents	types	
documents	enabled	yes
files_pdfviewer	types	
files_pdfviewer	enabled	yes
files_versions	types	filesystem
files_versions	enabled	yes
core	remote_files	files/appinfo/remote.php
core	remote_webdav	files/appinfo/remote.php
core	remote_filesync	files/appinfo/filesync.php
files	types	filesystem
files	enabled	yes
activity	types	filesystem
activity	enabled	yes
core	public_gallery	gallery/public.php
gallery	types	filesystem
gallery	enabled	yes
files_trashbin	types	filesystem
files_trashbin	enabled	yes
firstrunwizard	types	
firstrunwizard	enabled	yes
updater	types	
updater	enabled	yes
user_external	types	authentication,prelogin
user_external	enabled	yes
core	global_cache_gc_lastrun	1396478465
user_external	ocsid	166060
user_external	installed_version	0.4
files	installed_version	1.1.9
activity	ocsid	166038
activity	installed_version	1.1.23
calendar	ocsid	166043
calendar	installed_version	0.6.4
contacts	ocsid	166044
contacts	installed_version	0.3.0.17
documents	ocsid	166045
documents	installed_version	0.8.2
files_pdfviewer	ocsid	166049
files_pdfviewer	installed_version	0.5
files_sharing	ocsid	166050
core	public_webdav	files_sharing/publicwebdav.php
files_sharing	installed_version	0.5.3
files_texteditor	ocsid	166051
files_texteditor	installed_version	0.4
files_trashbin	ocsid	166052
files_trashbin	installed_version	0.6.2
files_versions	ocsid	166053
files_versions	installed_version	1.0.5
files_videoviewer	ocsid	166054
files_videoviewer	installed_version	0.1.3
firstrunwizard	ocsid	166055
firstrunwizard	installed_version	1.1
gallery	ocsid	166056
gallery	installed_version	0.5.4
search_lucene	ocsid	166057
search_lucene	installed_version	0.5.3
updater	ocsid	166059
updater	installed_version	0.4
core	lastupdatedat	0
backgroundjob	lastjob	2
core	lastcron	1407823463
\.


--
-- Data for Name: oc_clndr_calendars; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_clndr_calendars (id, userid, displayname, uri, active, ctag, calendarorder, calendarcolor, timezone, components) FROM stdin;
\.


--
-- Name: oc_clndr_calendars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_clndr_calendars_id_seq', 1, false);


--
-- Data for Name: oc_clndr_objects; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_clndr_objects (id, calendarid, objecttype, startdate, enddate, repeating, summary, calendardata, uri, lastmodified) FROM stdin;
\.


--
-- Name: oc_clndr_objects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_clndr_objects_id_seq', 1, false);


--
-- Data for Name: oc_clndr_repeat; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_clndr_repeat (id, eventid, calid, startdate, enddate) FROM stdin;
\.


--
-- Name: oc_clndr_repeat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_clndr_repeat_id_seq', 1, false);


--
-- Data for Name: oc_clndr_share_calendar; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_clndr_share_calendar (owner, share, sharetype, calendarid, permissions, active) FROM stdin;
\.


--
-- Data for Name: oc_clndr_share_event; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_clndr_share_event (owner, share, sharetype, eventid, permissions) FROM stdin;
\.


--
-- Data for Name: oc_contacts_addressbooks; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_contacts_addressbooks (id, userid, displayname, uri, description, ctag, active) FROM stdin;
1	admin	Contacts	contacts		1396478460	1
\.


--
-- Name: oc_contacts_addressbooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_contacts_addressbooks_id_seq', 1, true);


--
-- Data for Name: oc_contacts_cards; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_contacts_cards (id, addressbookid, fullname, carddata, uri, lastmodified) FROM stdin;
\.


--
-- Name: oc_contacts_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_contacts_cards_id_seq', 1, false);


--
-- Data for Name: oc_contacts_cards_properties; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_contacts_cards_properties (id, userid, contactid, name, value, preferred) FROM stdin;
\.


--
-- Name: oc_contacts_cards_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_contacts_cards_properties_id_seq', 1, false);


--
-- Data for Name: oc_documents_invite; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_documents_invite (es_id, uid, status, sent_on) FROM stdin;
\.


--
-- Data for Name: oc_documents_member; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_documents_member (member_id, es_id, uid, color, last_activity, status, is_guest, token) FROM stdin;
\.


--
-- Name: oc_documents_member_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_documents_member_member_id_seq', 1, false);


--
-- Data for Name: oc_documents_op; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_documents_op (seq, es_id, member, opspec) FROM stdin;
\.


--
-- Name: oc_documents_op_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_documents_op_seq_seq', 1, false);


--
-- Data for Name: oc_documents_revisions; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_documents_revisions (es_id, seq_head, member_id, file_id, save_hash) FROM stdin;
\.


--
-- Data for Name: oc_documents_session; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_documents_session (es_id, genesis_url, genesis_hash, file_id, owner) FROM stdin;
\.


--
-- Data for Name: oc_file_map; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_file_map (logic_path, logic_path_hash, physic_path, physic_path_hash) FROM stdin;
\.


--
-- Data for Name: oc_filecache; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_filecache (fileid, storage, path, path_hash, parent, name, mimetype, mimepart, size, mtime, storage_mtime, encrypted, unencrypted_size, etag, permissions) FROM stdin;
4	1	files/ownCloudUserManual.pdf	c8edba2d1b8eb651c107b43532c34445	2	ownCloudUserManual.pdf	4	3	1571970	1396478460	1396478460	0	0	533c91fd66fda	0
2	1	files	45b963397aa40d4a0063e0d85e4fe7a1	1	files	2	1	6038713	1396478460	1396478460	0	0	533c91fd60ed3	0
1	1		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	6039571	1396478466	1396478466	0	0	533c9203c0190	0
\.


--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_filecache_fileid_seq', 14, true);


--
-- Data for Name: oc_files_trash; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_files_trash (id, "user", "timestamp", location, type, mime, auto_id) FROM stdin;
\.


--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_files_trash_auto_id_seq', 1, false);


--
-- Data for Name: oc_gallery_sharing; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_gallery_sharing (token, gallery_id, recursive) FROM stdin;
\.


--
-- Data for Name: oc_group_admin; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_group_admin (gid, uid) FROM stdin;
\.


--
-- Data for Name: oc_group_user; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_group_user (gid, uid) FROM stdin;
admin	admin
\.


--
-- Data for Name: oc_groups; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_groups (gid) FROM stdin;
admin
\.


--
-- Data for Name: oc_jobs; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_jobs (id, class, argument, last_run) FROM stdin;
1	OC\\Cache\\FileGlobalGC	null	1396478465
3	OCA\\Activity\\BackgroundJob\\EmailNotification	null	0
2	OC\\BackgroundJob\\Legacy\\RegularJob	["\\\\OC\\\\Files\\\\Cache\\\\BackgroundWatcher","checkNext"]	1407823463
\.


--
-- Name: oc_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_jobs_id_seq', 3, true);


--
-- Data for Name: oc_locks; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_locks (id, userid, owner, timeout, created, token, scope, depth, uri) FROM stdin;
\.


--
-- Name: oc_locks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_locks_id_seq', 1, false);


--
-- Data for Name: oc_lucene_status; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_lucene_status (fileid, status) FROM stdin;
\.


--
-- Data for Name: oc_mimetypes; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_mimetypes (id, mimetype) FROM stdin;
1	httpd
2	httpd/unix-directory
3	application
4	application/pdf
5	audio
6	audio/mpeg
7	image
8	image/jpeg
9	application/vnd.oasis.opendocument.text
10	image/png
11	application/vnd.openxmlformats-officedocument.wordprocessingml.document
12	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
13	application/vnd.openxmlformats-officedocument.presentationml.presentation
\.


--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_mimetypes_id_seq', 13, true);


--
-- Name: oc_oc_activity_9024bd838c7bf_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_activity_9024bd838c7bf_activity_id_seq', 1, false);


--
-- Name: oc_oc_clndr_calendars_0c051e141fd08_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_clndr_calendars_0c051e141fd08_id_seq', 1, false);


--
-- Name: oc_oc_clndr_objects_a9b13b1f1ab2a_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_clndr_objects_a9b13b1f1ab2a_id_seq', 1, false);


--
-- Name: oc_oc_clndr_repeat_af90414337a13_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_clndr_repeat_af90414337a13_id_seq', 1, false);


--
-- Name: oc_oc_contacts_addressbooks_da52ed8fbe49b_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_contacts_addressbooks_da52ed8fbe49b_id_seq', 1, true);


--
-- Name: oc_oc_contacts_cards_a4b3b4e0bdb7f_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_contacts_cards_a4b3b4e0bdb7f_id_seq', 1, false);


--
-- Name: oc_oc_contacts_cards_properties_de6a120b6ba4e_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_contacts_cards_properties_de6a120b6ba4e_id_seq', 1, false);


--
-- Name: oc_oc_documents_member_176d304bf7495_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_documents_member_176d304bf7495_member_id_seq', 1, false);


--
-- Name: oc_oc_documents_op_68ed6bd5434b6_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_documents_op_68ed6bd5434b6_seq_seq', 1, false);


--
-- Name: oc_oc_filecache_45146385b5d7a_fileid_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_filecache_45146385b5d7a_fileid_seq', 4, true);


--
-- Name: oc_oc_jobs_5d22eb64398a8_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_jobs_5d22eb64398a8_id_seq', 2, true);


--
-- Name: oc_oc_locks_e0b65c1c74038_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_locks_e0b65c1c74038_id_seq', 1, false);


--
-- Name: oc_oc_mimetypes_d579189614976_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_mimetypes_d579189614976_id_seq', 10, true);


--
-- Name: oc_oc_privatedata_332050593c94b_keyid_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_privatedata_332050593c94b_keyid_seq', 1, false);


--
-- Name: oc_oc_properties_764d57a5b0bfd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_properties_764d57a5b0bfd_id_seq', 1, false);


--
-- Name: oc_oc_share_dc01eb825df1f_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_share_dc01eb825df1f_id_seq', 1, false);


--
-- Name: oc_oc_storages_5ac5d234e0d9e_numeric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_storages_5ac5d234e0d9e_numeric_id_seq', 1, true);


--
-- Name: oc_oc_vcategory_5b3852c8c7449_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_oc_vcategory_5b3852c8c7449_id_seq', 1, false);


--
-- Data for Name: oc_permissions; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_permissions (fileid, "user", permissions) FROM stdin;
2	admin	31
\.


--
-- Data for Name: oc_pictures_images_cache; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_pictures_images_cache (uid_owner, path, width, height) FROM stdin;
\.


--
-- Data for Name: oc_preferences; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_preferences (userid, appid, configkey, configvalue) FROM stdin;
admin	files	cache_version	5
admin	firstrunwizard	show	0
\.


--
-- Data for Name: oc_privatedata; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_privatedata (keyid, "user", app, key, value) FROM stdin;
\.


--
-- Name: oc_privatedata_keyid_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_privatedata_keyid_seq', 1, false);


--
-- Data for Name: oc_properties; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_properties (id, userid, propertypath, propertyname, propertyvalue) FROM stdin;
\.


--
-- Name: oc_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_properties_id_seq', 1, false);


--
-- Data for Name: oc_share; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_share (id, share_type, share_with, uid_owner, parent, item_type, item_source, item_target, file_source, file_target, permissions, stime, accepted, expiration, token, mail_send) FROM stdin;
\.


--
-- Data for Name: oc_share_external; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_share_external (id, remote, share_token, password, name, owner, "user", mountpoint, mountpoint_hash) FROM stdin;
\.


--
-- Name: oc_share_external_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_share_external_id_seq', 1, false);


--
-- Name: oc_share_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_share_id_seq', 1, false);


--
-- Data for Name: oc_storages; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_storages (id, numeric_id) FROM stdin;
home::admin	1
\.


--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_storages_numeric_id_seq', 1, true);


--
-- Data for Name: oc_users; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_users (uid, displayname, password) FROM stdin;
admin	\N	$2a$08$F0WnuDByXK9BSG2j4HpKQug9IwxPekJ.3QpL8clos38gHLhNvH2lS
\.


--
-- Data for Name: oc_users_external; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_users_external (backend, uid, displayname) FROM stdin;
\.


--
-- Data for Name: oc_vcategory; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_vcategory (id, uid, type, category) FROM stdin;
\.


--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: owncloud
--

SELECT pg_catalog.setval('oc_vcategory_id_seq', 1, false);


--
-- Data for Name: oc_vcategory_to_object; Type: TABLE DATA; Schema: public; Owner: owncloud
--

COPY oc_vcategory_to_object (objid, categoryid, type) FROM stdin;
\.


--
-- Name: oc_activity_mq_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_activity_mq
    ADD CONSTRAINT oc_activity_mq_pkey PRIMARY KEY (mail_id);


--
-- Name: oc_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_activity
    ADD CONSTRAINT oc_activity_pkey PRIMARY KEY (activity_id);


--
-- Name: oc_appconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_appconfig
    ADD CONSTRAINT oc_appconfig_pkey PRIMARY KEY (appid, configkey);


--
-- Name: oc_clndr_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_clndr_calendars
    ADD CONSTRAINT oc_clndr_calendars_pkey PRIMARY KEY (id);


--
-- Name: oc_clndr_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_clndr_objects
    ADD CONSTRAINT oc_clndr_objects_pkey PRIMARY KEY (id);


--
-- Name: oc_clndr_repeat_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_clndr_repeat
    ADD CONSTRAINT oc_clndr_repeat_pkey PRIMARY KEY (id);


--
-- Name: oc_contacts_addressbooks_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_contacts_addressbooks
    ADD CONSTRAINT oc_contacts_addressbooks_pkey PRIMARY KEY (id);


--
-- Name: oc_contacts_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_contacts_cards
    ADD CONSTRAINT oc_contacts_cards_pkey PRIMARY KEY (id);


--
-- Name: oc_contacts_cards_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_contacts_cards_properties
    ADD CONSTRAINT oc_contacts_cards_properties_pkey PRIMARY KEY (id);


--
-- Name: oc_documents_member_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_documents_member
    ADD CONSTRAINT oc_documents_member_pkey PRIMARY KEY (member_id);


--
-- Name: oc_documents_op_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_documents_op
    ADD CONSTRAINT oc_documents_op_pkey PRIMARY KEY (seq);


--
-- Name: oc_documents_session_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_documents_session
    ADD CONSTRAINT oc_documents_session_pkey PRIMARY KEY (es_id);


--
-- Name: oc_file_map_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_file_map
    ADD CONSTRAINT oc_file_map_pkey PRIMARY KEY (logic_path_hash);


--
-- Name: oc_filecache_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_filecache
    ADD CONSTRAINT oc_filecache_pkey PRIMARY KEY (fileid);


--
-- Name: oc_files_trash_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_files_trash
    ADD CONSTRAINT oc_files_trash_pkey PRIMARY KEY (auto_id);


--
-- Name: oc_group_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_group_admin
    ADD CONSTRAINT oc_group_admin_pkey PRIMARY KEY (gid, uid);


--
-- Name: oc_group_user_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_group_user
    ADD CONSTRAINT oc_group_user_pkey PRIMARY KEY (gid, uid);


--
-- Name: oc_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_groups
    ADD CONSTRAINT oc_groups_pkey PRIMARY KEY (gid);


--
-- Name: oc_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_jobs
    ADD CONSTRAINT oc_jobs_pkey PRIMARY KEY (id);


--
-- Name: oc_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_locks
    ADD CONSTRAINT oc_locks_pkey PRIMARY KEY (id);


--
-- Name: oc_lucene_status_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_lucene_status
    ADD CONSTRAINT oc_lucene_status_pkey PRIMARY KEY (fileid);


--
-- Name: oc_mimetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_mimetypes
    ADD CONSTRAINT oc_mimetypes_pkey PRIMARY KEY (id);


--
-- Name: oc_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_preferences
    ADD CONSTRAINT oc_preferences_pkey PRIMARY KEY (userid, appid, configkey);


--
-- Name: oc_privatedata_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_privatedata
    ADD CONSTRAINT oc_privatedata_pkey PRIMARY KEY (keyid);


--
-- Name: oc_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_properties
    ADD CONSTRAINT oc_properties_pkey PRIMARY KEY (id);


--
-- Name: oc_share_external_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_share_external
    ADD CONSTRAINT oc_share_external_pkey PRIMARY KEY (id);


--
-- Name: oc_share_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_share
    ADD CONSTRAINT oc_share_pkey PRIMARY KEY (id);


--
-- Name: oc_storages_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_storages
    ADD CONSTRAINT oc_storages_pkey PRIMARY KEY (numeric_id);


--
-- Name: oc_users_external_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_users_external
    ADD CONSTRAINT oc_users_external_pkey PRIMARY KEY (uid, backend);


--
-- Name: oc_users_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_users
    ADD CONSTRAINT oc_users_pkey PRIMARY KEY (uid);


--
-- Name: oc_vcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_vcategory
    ADD CONSTRAINT oc_vcategory_pkey PRIMARY KEY (id);


--
-- Name: oc_vcategory_to_object_pkey; Type: CONSTRAINT; Schema: public; Owner: owncloud; Tablespace: 
--

ALTER TABLE ONLY oc_vcategory_to_object
    ADD CONSTRAINT oc_vcategory_to_object_pkey PRIMARY KEY (categoryid, objid, type);


--
-- Name: activity_filter_app; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX activity_filter_app ON oc_activity USING btree (affecteduser, app, "timestamp");


--
-- Name: activity_filter_by; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX activity_filter_by ON oc_activity USING btree (affecteduser, "user", "timestamp");


--
-- Name: activity_user_time; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX activity_user_time ON oc_activity USING btree (affecteduser, "timestamp");


--
-- Name: amp_latest_send_time; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX amp_latest_send_time ON oc_activity_mq USING btree (amq_latest_send);


--
-- Name: amp_timestamp_time; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX amp_timestamp_time ON oc_activity_mq USING btree (amq_timestamp);


--
-- Name: amp_user; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX amp_user ON oc_activity_mq USING btree (amq_affecteduser);


--
-- Name: appconfig_appid_key; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX appconfig_appid_key ON oc_appconfig USING btree (appid);


--
-- Name: appconfig_config_key_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX appconfig_config_key_index ON oc_appconfig USING btree (configkey);


--
-- Name: c_addressbook_userid_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX c_addressbook_userid_index ON oc_contacts_addressbooks USING btree (userid);


--
-- Name: c_addressbookid_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX c_addressbookid_index ON oc_contacts_cards USING btree (addressbookid);


--
-- Name: category_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX category_index ON oc_vcategory USING btree (category);


--
-- Name: cp_contactid_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX cp_contactid_index ON oc_contacts_cards_properties USING btree (contactid);


--
-- Name: cp_name_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX cp_name_index ON oc_contacts_cards_properties USING btree (name);


--
-- Name: cp_value_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX cp_value_index ON oc_contacts_cards_properties USING btree (value);


--
-- Name: documents_op_eis_idx; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX documents_op_eis_idx ON oc_documents_op USING btree (es_id, seq);


--
-- Name: documents_rev_eis_idx; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX documents_rev_eis_idx ON oc_documents_revisions USING btree (es_id, seq_head);


--
-- Name: file_map_pp_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX file_map_pp_index ON oc_file_map USING btree (physic_path_hash);


--
-- Name: file_source_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX file_source_index ON oc_share USING btree (file_source);


--
-- Name: fs_parent_name_hash; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX fs_parent_name_hash ON oc_filecache USING btree (parent, name);


--
-- Name: fs_storage_mimepart; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX fs_storage_mimepart ON oc_filecache USING btree (storage, mimepart);


--
-- Name: fs_storage_mimetype; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX fs_storage_mimetype ON oc_filecache USING btree (storage, mimetype);


--
-- Name: fs_storage_path_hash; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX fs_storage_path_hash ON oc_filecache USING btree (storage, path_hash);


--
-- Name: fs_storage_size; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX fs_storage_size ON oc_filecache USING btree (storage, size, fileid);


--
-- Name: group_admin_uid; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX group_admin_uid ON oc_group_admin USING btree (uid);


--
-- Name: id_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX id_index ON oc_files_trash USING btree (id);


--
-- Name: id_user_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX id_user_index ON oc_permissions USING btree (fileid, "user");


--
-- Name: item_share_type_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX item_share_type_index ON oc_share USING btree (item_type, share_type);


--
-- Name: job_class_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX job_class_index ON oc_jobs USING btree (class);


--
-- Name: mimetype_id_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX mimetype_id_index ON oc_mimetypes USING btree (mimetype);


--
-- Name: property_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX property_index ON oc_properties USING btree (userid);


--
-- Name: sh_external_mp; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX sh_external_mp ON oc_share_external USING btree ("user", mountpoint_hash);


--
-- Name: sh_external_user; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX sh_external_user ON oc_share_external USING btree ("user");


--
-- Name: status_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX status_index ON oc_lucene_status USING btree (status);


--
-- Name: storages_id_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE UNIQUE INDEX storages_id_index ON oc_storages USING btree (id);


--
-- Name: timestamp_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX timestamp_index ON oc_files_trash USING btree ("timestamp");


--
-- Name: token_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX token_index ON oc_share USING btree (token);


--
-- Name: type_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX type_index ON oc_vcategory USING btree (type);


--
-- Name: uid_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX uid_index ON oc_vcategory USING btree (uid);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX user_index ON oc_files_trash USING btree ("user");


--
-- Name: vcategory_objectd_index; Type: INDEX; Schema: public; Owner: owncloud; Tablespace: 
--

CREATE INDEX vcategory_objectd_index ON oc_vcategory_to_object USING btree (objid, type);


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

