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
-- Name: lime_answers; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_answers (
    qid integer DEFAULT 0 NOT NULL,
    code character varying(5) DEFAULT ''::character varying NOT NULL,
    answer text NOT NULL,
    sortorder integer NOT NULL,
    language character varying(20) DEFAULT 'en'::character varying NOT NULL,
    assessment_value integer DEFAULT 0 NOT NULL,
    scale_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.lime_answers OWNER TO limesurvey;

--
-- Name: lime_assessments; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_assessments (
    id integer NOT NULL,
    sid integer DEFAULT 0 NOT NULL,
    scope character varying(5) DEFAULT ''::character varying NOT NULL,
    gid integer DEFAULT 0 NOT NULL,
    name text NOT NULL,
    minimum character varying(50) DEFAULT ''::character varying NOT NULL,
    maximum character varying(50) DEFAULT ''::character varying NOT NULL,
    message text NOT NULL,
    language character varying(20) DEFAULT 'en'::character varying NOT NULL
);


ALTER TABLE public.lime_assessments OWNER TO limesurvey;

--
-- Name: lime_assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_assessments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_assessments_id_seq OWNER TO limesurvey;

--
-- Name: lime_assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_assessments_id_seq OWNED BY lime_assessments.id;


--
-- Name: lime_conditions; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_conditions (
    cid integer NOT NULL,
    qid integer DEFAULT 0 NOT NULL,
    cqid integer DEFAULT 0 NOT NULL,
    cfieldname character varying(50) DEFAULT ''::character varying NOT NULL,
    method character varying(5) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    scenario integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.lime_conditions OWNER TO limesurvey;

--
-- Name: lime_conditions_cid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_conditions_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_conditions_cid_seq OWNER TO limesurvey;

--
-- Name: lime_conditions_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_conditions_cid_seq OWNED BY lime_conditions.cid;


--
-- Name: lime_defaultvalues; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_defaultvalues (
    qid integer DEFAULT 0 NOT NULL,
    scale_id integer DEFAULT 0 NOT NULL,
    sqid integer DEFAULT 0 NOT NULL,
    language character varying(20) NOT NULL,
    specialtype character varying(20) DEFAULT ''::character varying NOT NULL,
    defaultvalue text
);


ALTER TABLE public.lime_defaultvalues OWNER TO limesurvey;

--
-- Name: lime_expression_errors; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_expression_errors (
    id integer NOT NULL,
    errortime character varying(50),
    sid integer,
    gid integer,
    qid integer,
    gseq integer,
    qseq integer,
    type character varying(50),
    eqn text,
    prettyprint text
);


ALTER TABLE public.lime_expression_errors OWNER TO limesurvey;

--
-- Name: lime_expression_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_expression_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_expression_errors_id_seq OWNER TO limesurvey;

--
-- Name: lime_expression_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_expression_errors_id_seq OWNED BY lime_expression_errors.id;


--
-- Name: lime_failed_login_attempts; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_failed_login_attempts (
    id integer NOT NULL,
    ip character varying(40) NOT NULL,
    last_attempt character varying(20) NOT NULL,
    number_attempts integer NOT NULL
);


ALTER TABLE public.lime_failed_login_attempts OWNER TO limesurvey;

--
-- Name: lime_failed_login_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_failed_login_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_failed_login_attempts_id_seq OWNER TO limesurvey;

--
-- Name: lime_failed_login_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_failed_login_attempts_id_seq OWNED BY lime_failed_login_attempts.id;


--
-- Name: lime_groups; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_groups (
    gid integer NOT NULL,
    sid integer DEFAULT 0 NOT NULL,
    group_name character varying(100) DEFAULT ''::character varying NOT NULL,
    group_order integer DEFAULT 0 NOT NULL,
    description text,
    language character varying(20) DEFAULT 'en'::character varying NOT NULL,
    randomization_group character varying(20) DEFAULT ''::character varying NOT NULL,
    grelevance text
);


ALTER TABLE public.lime_groups OWNER TO limesurvey;

--
-- Name: lime_groups_gid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_groups_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_groups_gid_seq OWNER TO limesurvey;

--
-- Name: lime_groups_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_groups_gid_seq OWNED BY lime_groups.gid;


--
-- Name: lime_labels; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_labels (
    lid integer DEFAULT 0 NOT NULL,
    code character varying(5) DEFAULT ''::character varying NOT NULL,
    title text,
    sortorder integer NOT NULL,
    assessment_value integer DEFAULT 0 NOT NULL,
    language character varying(20) DEFAULT 'en'::character varying NOT NULL
);


ALTER TABLE public.lime_labels OWNER TO limesurvey;

--
-- Name: lime_labelsets; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_labelsets (
    lid integer NOT NULL,
    label_name character varying(100) DEFAULT ''::character varying NOT NULL,
    languages character varying(200) DEFAULT 'en'::character varying
);


ALTER TABLE public.lime_labelsets OWNER TO limesurvey;

--
-- Name: lime_labelsets_lid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_labelsets_lid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_labelsets_lid_seq OWNER TO limesurvey;

--
-- Name: lime_labelsets_lid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_labelsets_lid_seq OWNED BY lime_labelsets.lid;


--
-- Name: lime_participant_attribute; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participant_attribute (
    participant_id character varying(50) NOT NULL,
    attribute_id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.lime_participant_attribute OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_names; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participant_attribute_names (
    attribute_id integer NOT NULL,
    attribute_type character varying(4) NOT NULL,
    defaultname character varying(50) NOT NULL,
    visible character varying(5) NOT NULL
);


ALTER TABLE public.lime_participant_attribute_names OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_names_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_participant_attribute_names_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_participant_attribute_names_attribute_id_seq OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_names_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_participant_attribute_names_attribute_id_seq OWNED BY lime_participant_attribute_names.attribute_id;


--
-- Name: lime_participant_attribute_names_lang; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participant_attribute_names_lang (
    attribute_id integer NOT NULL,
    attribute_name character varying(30) NOT NULL,
    lang character varying(255) NOT NULL
);


ALTER TABLE public.lime_participant_attribute_names_lang OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_values; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participant_attribute_values (
    value_id integer NOT NULL,
    attribute_id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.lime_participant_attribute_values OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_values_value_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_participant_attribute_values_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_participant_attribute_values_value_id_seq OWNER TO limesurvey;

--
-- Name: lime_participant_attribute_values_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_participant_attribute_values_value_id_seq OWNED BY lime_participant_attribute_values.value_id;


--
-- Name: lime_participant_shares; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participant_shares (
    participant_id character varying(50) NOT NULL,
    share_uid integer NOT NULL,
    date_added timestamp without time zone NOT NULL,
    can_edit character varying(5) NOT NULL
);


ALTER TABLE public.lime_participant_shares OWNER TO limesurvey;

--
-- Name: lime_participants; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_participants (
    participant_id character varying(50) NOT NULL,
    firstname character varying(40),
    lastname character varying(40),
    email character varying(254),
    language character varying(40),
    blacklisted character varying(1) NOT NULL,
    owner_uid integer NOT NULL,
    created_by integer NOT NULL,
    created timestamp without time zone,
    modified timestamp without time zone
);


ALTER TABLE public.lime_participants OWNER TO limesurvey;

--
-- Name: lime_permissions; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_permissions (
    id integer NOT NULL,
    entity character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    uid integer NOT NULL,
    permission character varying(100) NOT NULL,
    create_p integer DEFAULT 0 NOT NULL,
    read_p integer DEFAULT 0 NOT NULL,
    update_p integer DEFAULT 0 NOT NULL,
    delete_p integer DEFAULT 0 NOT NULL,
    import_p integer DEFAULT 0 NOT NULL,
    export_p integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.lime_permissions OWNER TO limesurvey;

--
-- Name: lime_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_permissions_id_seq OWNER TO limesurvey;

--
-- Name: lime_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_permissions_id_seq OWNED BY lime_permissions.id;


--
-- Name: lime_plugin_settings; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_plugin_settings (
    id integer NOT NULL,
    plugin_id integer NOT NULL,
    model character varying(50),
    model_id integer,
    key character varying(50) NOT NULL,
    value text
);


ALTER TABLE public.lime_plugin_settings OWNER TO limesurvey;

--
-- Name: lime_plugin_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_plugin_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_plugin_settings_id_seq OWNER TO limesurvey;

--
-- Name: lime_plugin_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_plugin_settings_id_seq OWNED BY lime_plugin_settings.id;


--
-- Name: lime_plugins; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_plugins (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    active integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.lime_plugins OWNER TO limesurvey;

--
-- Name: lime_plugins_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_plugins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_plugins_id_seq OWNER TO limesurvey;

--
-- Name: lime_plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_plugins_id_seq OWNED BY lime_plugins.id;


--
-- Name: lime_question_attributes; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_question_attributes (
    qaid integer NOT NULL,
    qid integer DEFAULT 0 NOT NULL,
    attribute character varying(50),
    value text,
    language character varying(20)
);


ALTER TABLE public.lime_question_attributes OWNER TO limesurvey;

--
-- Name: lime_question_attributes_qaid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_question_attributes_qaid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_question_attributes_qaid_seq OWNER TO limesurvey;

--
-- Name: lime_question_attributes_qaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_question_attributes_qaid_seq OWNED BY lime_question_attributes.qaid;


--
-- Name: lime_questions; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_questions (
    qid integer NOT NULL,
    parent_qid integer DEFAULT 0 NOT NULL,
    sid integer DEFAULT 0 NOT NULL,
    gid integer DEFAULT 0 NOT NULL,
    type character varying(1) DEFAULT 'T'::character varying NOT NULL,
    title character varying(20) DEFAULT ''::character varying NOT NULL,
    question text NOT NULL,
    preg text,
    help text,
    other character varying(1) DEFAULT 'N'::character varying NOT NULL,
    mandatory character varying(1),
    question_order integer NOT NULL,
    language character varying(20) DEFAULT 'en'::character varying NOT NULL,
    scale_id integer DEFAULT 0 NOT NULL,
    same_default integer DEFAULT 0 NOT NULL,
    relevance text
);


ALTER TABLE public.lime_questions OWNER TO limesurvey;

--
-- Name: lime_questions_qid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_questions_qid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_questions_qid_seq OWNER TO limesurvey;

--
-- Name: lime_questions_qid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_questions_qid_seq OWNED BY lime_questions.qid;


--
-- Name: lime_quota; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_quota (
    id integer NOT NULL,
    sid integer,
    name character varying(255),
    qlimit integer,
    action integer,
    active integer DEFAULT 1 NOT NULL,
    autoload_url integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.lime_quota OWNER TO limesurvey;

--
-- Name: lime_quota_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_quota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_quota_id_seq OWNER TO limesurvey;

--
-- Name: lime_quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_quota_id_seq OWNED BY lime_quota.id;


--
-- Name: lime_quota_languagesettings; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_quota_languagesettings (
    quotals_id integer NOT NULL,
    quotals_quota_id integer DEFAULT 0 NOT NULL,
    quotals_language character varying(45) DEFAULT 'en'::character varying NOT NULL,
    quotals_name character varying(255),
    quotals_message text NOT NULL,
    quotals_url character varying(255),
    quotals_urldescrip character varying(255)
);


ALTER TABLE public.lime_quota_languagesettings OWNER TO limesurvey;

--
-- Name: lime_quota_languagesettings_quotals_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_quota_languagesettings_quotals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_quota_languagesettings_quotals_id_seq OWNER TO limesurvey;

--
-- Name: lime_quota_languagesettings_quotals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_quota_languagesettings_quotals_id_seq OWNED BY lime_quota_languagesettings.quotals_id;


--
-- Name: lime_quota_members; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_quota_members (
    id integer NOT NULL,
    sid integer,
    qid integer,
    quota_id integer,
    code character varying(11)
);


ALTER TABLE public.lime_quota_members OWNER TO limesurvey;

--
-- Name: lime_quota_members_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_quota_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_quota_members_id_seq OWNER TO limesurvey;

--
-- Name: lime_quota_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_quota_members_id_seq OWNED BY lime_quota_members.id;


--
-- Name: lime_saved_control; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_saved_control (
    scid integer NOT NULL,
    sid integer DEFAULT 0 NOT NULL,
    srid integer DEFAULT 0 NOT NULL,
    identifier text NOT NULL,
    access_code text NOT NULL,
    email character varying(254),
    ip text NOT NULL,
    saved_thisstep text NOT NULL,
    status character varying(1) DEFAULT ''::character varying NOT NULL,
    saved_date timestamp without time zone NOT NULL,
    refurl text
);


ALTER TABLE public.lime_saved_control OWNER TO limesurvey;

--
-- Name: lime_saved_control_scid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_saved_control_scid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_saved_control_scid_seq OWNER TO limesurvey;

--
-- Name: lime_saved_control_scid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_saved_control_scid_seq OWNED BY lime_saved_control.scid;


--
-- Name: lime_sessions; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_sessions (
    id character varying(32) NOT NULL,
    expire integer,
    data bytea
);


ALTER TABLE public.lime_sessions OWNER TO limesurvey;

--
-- Name: lime_settings_global; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_settings_global (
    stg_name character varying(50) DEFAULT ''::character varying NOT NULL,
    stg_value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.lime_settings_global OWNER TO limesurvey;

--
-- Name: lime_survey_links; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_survey_links (
    participant_id character varying(50) NOT NULL,
    token_id integer NOT NULL,
    survey_id integer NOT NULL,
    date_created timestamp without time zone,
    date_invited timestamp without time zone,
    date_completed timestamp without time zone
);


ALTER TABLE public.lime_survey_links OWNER TO limesurvey;

--
-- Name: lime_survey_url_parameters; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_survey_url_parameters (
    id integer NOT NULL,
    sid integer NOT NULL,
    parameter character varying(50) NOT NULL,
    targetqid integer,
    targetsqid integer
);


ALTER TABLE public.lime_survey_url_parameters OWNER TO limesurvey;

--
-- Name: lime_survey_url_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_survey_url_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_survey_url_parameters_id_seq OWNER TO limesurvey;

--
-- Name: lime_survey_url_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_survey_url_parameters_id_seq OWNED BY lime_survey_url_parameters.id;


--
-- Name: lime_surveys; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_surveys (
    sid integer NOT NULL,
    owner_id integer NOT NULL,
    admin character varying(50),
    active character varying(1) DEFAULT 'N'::character varying NOT NULL,
    expires timestamp without time zone,
    startdate timestamp without time zone,
    adminemail character varying(254),
    anonymized character varying(1) DEFAULT 'N'::character varying NOT NULL,
    faxto character varying(20),
    format character varying(1),
    savetimings character varying(1) DEFAULT 'N'::character varying NOT NULL,
    template character varying(100) DEFAULT 'default'::character varying,
    language character varying(50),
    additional_languages character varying(255),
    datestamp character varying(1) DEFAULT 'N'::character varying NOT NULL,
    usecookie character varying(1) DEFAULT 'N'::character varying NOT NULL,
    allowregister character varying(1) DEFAULT 'N'::character varying NOT NULL,
    allowsave character varying(1) DEFAULT 'Y'::character varying NOT NULL,
    autonumber_start integer DEFAULT 0 NOT NULL,
    autoredirect character varying(1) DEFAULT 'N'::character varying NOT NULL,
    allowprev character varying(1) DEFAULT 'N'::character varying NOT NULL,
    printanswers character varying(1) DEFAULT 'N'::character varying NOT NULL,
    ipaddr character varying(1) DEFAULT 'N'::character varying NOT NULL,
    refurl character varying(1) DEFAULT 'N'::character varying NOT NULL,
    datecreated date,
    publicstatistics character varying(1) DEFAULT 'N'::character varying NOT NULL,
    publicgraphs character varying(1) DEFAULT 'N'::character varying NOT NULL,
    listpublic character varying(1) DEFAULT 'N'::character varying NOT NULL,
    htmlemail character varying(1) DEFAULT 'N'::character varying NOT NULL,
    sendconfirmation character varying(1) DEFAULT 'Y'::character varying NOT NULL,
    tokenanswerspersistence character varying(1) DEFAULT 'N'::character varying NOT NULL,
    assessments character varying(1) DEFAULT 'N'::character varying NOT NULL,
    usecaptcha character varying(1) DEFAULT 'N'::character varying NOT NULL,
    usetokens character varying(1) DEFAULT 'N'::character varying NOT NULL,
    bounce_email character varying(254),
    attributedescriptions text,
    emailresponseto text,
    emailnotificationto text,
    tokenlength integer DEFAULT 15 NOT NULL,
    showxquestions character varying(1) DEFAULT 'Y'::character varying,
    showgroupinfo character varying(1) DEFAULT 'B'::character varying,
    shownoanswer character varying(1) DEFAULT 'Y'::character varying,
    showqnumcode character varying(1) DEFAULT 'X'::character varying,
    bouncetime integer,
    bounceprocessing character varying(1) DEFAULT 'N'::character varying,
    bounceaccounttype character varying(4),
    bounceaccounthost character varying(200),
    bounceaccountpass character varying(100),
    bounceaccountencryption character varying(3),
    bounceaccountuser character varying(200),
    showwelcome character varying(1) DEFAULT 'Y'::character varying,
    showprogress character varying(1) DEFAULT 'Y'::character varying,
    questionindex integer DEFAULT 0 NOT NULL,
    navigationdelay integer DEFAULT 0 NOT NULL,
    nokeyboard character varying(1) DEFAULT 'N'::character varying,
    alloweditaftercompletion character varying(1) DEFAULT 'N'::character varying,
    googleanalyticsstyle character varying(1),
    googleanalyticsapikey character varying(25)
);


ALTER TABLE public.lime_surveys OWNER TO limesurvey;

--
-- Name: lime_surveys_languagesettings; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_surveys_languagesettings (
    surveyls_survey_id integer NOT NULL,
    surveyls_language character varying(45) DEFAULT 'en'::character varying NOT NULL,
    surveyls_title character varying(200) NOT NULL,
    surveyls_description text,
    surveyls_welcometext text,
    surveyls_endtext text,
    surveyls_url text,
    surveyls_urldescription character varying(255),
    surveyls_email_invite_subj character varying(255),
    surveyls_email_invite text,
    surveyls_email_remind_subj character varying(255),
    surveyls_email_remind text,
    surveyls_email_register_subj character varying(255),
    surveyls_email_register text,
    surveyls_email_confirm_subj character varying(255),
    surveyls_email_confirm text,
    surveyls_dateformat integer DEFAULT 1 NOT NULL,
    surveyls_attributecaptions text,
    email_admin_notification_subj character varying(255),
    email_admin_notification text,
    email_admin_responses_subj character varying(255),
    email_admin_responses text,
    surveyls_numberformat integer DEFAULT 0 NOT NULL,
    attachments text
);


ALTER TABLE public.lime_surveys_languagesettings OWNER TO limesurvey;

--
-- Name: lime_templates; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_templates (
    folder character varying(255) NOT NULL,
    creator integer NOT NULL
);


ALTER TABLE public.lime_templates OWNER TO limesurvey;

--
-- Name: lime_user_groups; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_user_groups (
    ugid integer NOT NULL,
    name character varying(20) NOT NULL,
    description text NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE public.lime_user_groups OWNER TO limesurvey;

--
-- Name: lime_user_groups_ugid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_user_groups_ugid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_user_groups_ugid_seq OWNER TO limesurvey;

--
-- Name: lime_user_groups_ugid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_user_groups_ugid_seq OWNED BY lime_user_groups.ugid;


--
-- Name: lime_user_in_groups; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_user_in_groups (
    ugid integer NOT NULL,
    uid integer NOT NULL
);


ALTER TABLE public.lime_user_in_groups OWNER TO limesurvey;

--
-- Name: lime_users; Type: TABLE; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE TABLE lime_users (
    uid integer NOT NULL,
    users_name character varying(64) DEFAULT ''::character varying NOT NULL,
    password bytea NOT NULL,
    full_name character varying(50) NOT NULL,
    parent_id integer NOT NULL,
    lang character varying(20),
    email character varying(254),
    htmleditormode character varying(7) DEFAULT 'default'::character varying,
    templateeditormode character varying(7) DEFAULT 'default'::character varying NOT NULL,
    questionselectormode character varying(7) DEFAULT 'default'::character varying NOT NULL,
    one_time_pw bytea,
    dateformat integer DEFAULT 1 NOT NULL,
    created timestamp without time zone,
    modified timestamp without time zone
);


ALTER TABLE public.lime_users OWNER TO limesurvey;

--
-- Name: lime_users_uid_seq; Type: SEQUENCE; Schema: public; Owner: limesurvey
--

CREATE SEQUENCE lime_users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lime_users_uid_seq OWNER TO limesurvey;

--
-- Name: lime_users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: limesurvey
--

ALTER SEQUENCE lime_users_uid_seq OWNED BY lime_users.uid;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_assessments ALTER COLUMN id SET DEFAULT nextval('lime_assessments_id_seq'::regclass);


--
-- Name: cid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_conditions ALTER COLUMN cid SET DEFAULT nextval('lime_conditions_cid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_expression_errors ALTER COLUMN id SET DEFAULT nextval('lime_expression_errors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_failed_login_attempts ALTER COLUMN id SET DEFAULT nextval('lime_failed_login_attempts_id_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_groups ALTER COLUMN gid SET DEFAULT nextval('lime_groups_gid_seq'::regclass);


--
-- Name: lid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_labelsets ALTER COLUMN lid SET DEFAULT nextval('lime_labelsets_lid_seq'::regclass);


--
-- Name: attribute_id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_participant_attribute_names ALTER COLUMN attribute_id SET DEFAULT nextval('lime_participant_attribute_names_attribute_id_seq'::regclass);


--
-- Name: value_id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_participant_attribute_values ALTER COLUMN value_id SET DEFAULT nextval('lime_participant_attribute_values_value_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_permissions ALTER COLUMN id SET DEFAULT nextval('lime_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_plugin_settings ALTER COLUMN id SET DEFAULT nextval('lime_plugin_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_plugins ALTER COLUMN id SET DEFAULT nextval('lime_plugins_id_seq'::regclass);


--
-- Name: qaid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_question_attributes ALTER COLUMN qaid SET DEFAULT nextval('lime_question_attributes_qaid_seq'::regclass);


--
-- Name: qid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_questions ALTER COLUMN qid SET DEFAULT nextval('lime_questions_qid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_quota ALTER COLUMN id SET DEFAULT nextval('lime_quota_id_seq'::regclass);


--
-- Name: quotals_id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_quota_languagesettings ALTER COLUMN quotals_id SET DEFAULT nextval('lime_quota_languagesettings_quotals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_quota_members ALTER COLUMN id SET DEFAULT nextval('lime_quota_members_id_seq'::regclass);


--
-- Name: scid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_saved_control ALTER COLUMN scid SET DEFAULT nextval('lime_saved_control_scid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_survey_url_parameters ALTER COLUMN id SET DEFAULT nextval('lime_survey_url_parameters_id_seq'::regclass);


--
-- Name: ugid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_user_groups ALTER COLUMN ugid SET DEFAULT nextval('lime_user_groups_ugid_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: limesurvey
--

ALTER TABLE ONLY lime_users ALTER COLUMN uid SET DEFAULT nextval('lime_users_uid_seq'::regclass);


--
-- Data for Name: lime_answers; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_answers (qid, code, answer, sortorder, language, assessment_value, scale_id) FROM stdin;
\.


--
-- Data for Name: lime_assessments; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_assessments (id, sid, scope, gid, name, minimum, maximum, message, language) FROM stdin;
\.


--
-- Name: lime_assessments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_assessments_id_seq', 1, false);


--
-- Data for Name: lime_conditions; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_conditions (cid, qid, cqid, cfieldname, method, value, scenario) FROM stdin;
\.


--
-- Name: lime_conditions_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_conditions_cid_seq', 1, false);


--
-- Data for Name: lime_defaultvalues; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_defaultvalues (qid, scale_id, sqid, language, specialtype, defaultvalue) FROM stdin;
\.


--
-- Data for Name: lime_expression_errors; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_expression_errors (id, errortime, sid, gid, qid, gseq, qseq, type, eqn, prettyprint) FROM stdin;
\.


--
-- Name: lime_expression_errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_expression_errors_id_seq', 1, false);


--
-- Data for Name: lime_failed_login_attempts; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_failed_login_attempts (id, ip, last_attempt, number_attempts) FROM stdin;
\.


--
-- Name: lime_failed_login_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_failed_login_attempts_id_seq', 1, false);


--
-- Data for Name: lime_groups; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_groups (gid, sid, group_name, group_order, description, language, randomization_group, grelevance) FROM stdin;
\.


--
-- Name: lime_groups_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_groups_gid_seq', 1, false);


--
-- Data for Name: lime_labels; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_labels (lid, code, title, sortorder, assessment_value, language) FROM stdin;
\.


--
-- Data for Name: lime_labelsets; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_labelsets (lid, label_name, languages) FROM stdin;
\.


--
-- Name: lime_labelsets_lid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_labelsets_lid_seq', 1, false);


--
-- Data for Name: lime_participant_attribute; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participant_attribute (participant_id, attribute_id, value) FROM stdin;
\.


--
-- Data for Name: lime_participant_attribute_names; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participant_attribute_names (attribute_id, attribute_type, defaultname, visible) FROM stdin;
\.


--
-- Name: lime_participant_attribute_names_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_participant_attribute_names_attribute_id_seq', 1, false);


--
-- Data for Name: lime_participant_attribute_names_lang; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participant_attribute_names_lang (attribute_id, attribute_name, lang) FROM stdin;
\.


--
-- Data for Name: lime_participant_attribute_values; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participant_attribute_values (value_id, attribute_id, value) FROM stdin;
\.


--
-- Name: lime_participant_attribute_values_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_participant_attribute_values_value_id_seq', 1, false);


--
-- Data for Name: lime_participant_shares; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participant_shares (participant_id, share_uid, date_added, can_edit) FROM stdin;
\.


--
-- Data for Name: lime_participants; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_participants (participant_id, firstname, lastname, email, language, blacklisted, owner_uid, created_by, created, modified) FROM stdin;
\.


--
-- Data for Name: lime_permissions; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_permissions (id, entity, entity_id, uid, permission, create_p, read_p, update_p, delete_p, import_p, export_p) FROM stdin;
1	global	0	1	superadmin	0	1	0	0	0	0
\.


--
-- Name: lime_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_permissions_id_seq', 1, true);


--
-- Data for Name: lime_plugin_settings; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_plugin_settings (id, plugin_id, model, model_id, key, value) FROM stdin;
\.


--
-- Name: lime_plugin_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_plugin_settings_id_seq', 1, false);


--
-- Data for Name: lime_plugins; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_plugins (id, name, active) FROM stdin;
1	Authdb	1
\.


--
-- Name: lime_plugins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_plugins_id_seq', 1, true);


--
-- Data for Name: lime_question_attributes; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_question_attributes (qaid, qid, attribute, value, language) FROM stdin;
\.


--
-- Name: lime_question_attributes_qaid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_question_attributes_qaid_seq', 1, false);


--
-- Data for Name: lime_questions; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_questions (qid, parent_qid, sid, gid, type, title, question, preg, help, other, mandatory, question_order, language, scale_id, same_default, relevance) FROM stdin;
\.


--
-- Name: lime_questions_qid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_questions_qid_seq', 1, false);


--
-- Data for Name: lime_quota; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_quota (id, sid, name, qlimit, action, active, autoload_url) FROM stdin;
\.


--
-- Name: lime_quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_quota_id_seq', 1, false);


--
-- Data for Name: lime_quota_languagesettings; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_quota_languagesettings (quotals_id, quotals_quota_id, quotals_language, quotals_name, quotals_message, quotals_url, quotals_urldescrip) FROM stdin;
\.


--
-- Name: lime_quota_languagesettings_quotals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_quota_languagesettings_quotals_id_seq', 1, false);


--
-- Data for Name: lime_quota_members; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_quota_members (id, sid, qid, quota_id, code) FROM stdin;
\.


--
-- Name: lime_quota_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_quota_members_id_seq', 1, false);


--
-- Data for Name: lime_saved_control; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_saved_control (scid, sid, srid, identifier, access_code, email, ip, saved_thisstep, status, saved_date, refurl) FROM stdin;
\.


--
-- Name: lime_saved_control_scid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_saved_control_scid_seq', 1, false);


--
-- Data for Name: lime_sessions; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_sessions (id, expire, data) FROM stdin;
\.


--
-- Data for Name: lime_settings_global; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_settings_global (stg_name, stg_value) FROM stdin;
DBVersion	177
sitename	Survey Simian
siteadminname	Administrator
defaultlang	en
updateversions	[]
updateavailable	0
updatelastcheck	2014-10-28 11:45:17
\.


--
-- Data for Name: lime_survey_links; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_survey_links (participant_id, token_id, survey_id, date_created, date_invited, date_completed) FROM stdin;
\.


--
-- Data for Name: lime_survey_url_parameters; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_survey_url_parameters (id, sid, parameter, targetqid, targetsqid) FROM stdin;
\.


--
-- Name: lime_survey_url_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_survey_url_parameters_id_seq', 1, false);


--
-- Data for Name: lime_surveys; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_surveys (sid, owner_id, admin, active, expires, startdate, adminemail, anonymized, faxto, format, savetimings, template, language, additional_languages, datestamp, usecookie, allowregister, allowsave, autonumber_start, autoredirect, allowprev, printanswers, ipaddr, refurl, datecreated, publicstatistics, publicgraphs, listpublic, htmlemail, sendconfirmation, tokenanswerspersistence, assessments, usecaptcha, usetokens, bounce_email, attributedescriptions, emailresponseto, emailnotificationto, tokenlength, showxquestions, showgroupinfo, shownoanswer, showqnumcode, bouncetime, bounceprocessing, bounceaccounttype, bounceaccounthost, bounceaccountpass, bounceaccountencryption, bounceaccountuser, showwelcome, showprogress, questionindex, navigationdelay, nokeyboard, alloweditaftercompletion, googleanalyticsstyle, googleanalyticsapikey) FROM stdin;
\.


--
-- Data for Name: lime_surveys_languagesettings; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_surveys_languagesettings (surveyls_survey_id, surveyls_language, surveyls_title, surveyls_description, surveyls_welcometext, surveyls_endtext, surveyls_url, surveyls_urldescription, surveyls_email_invite_subj, surveyls_email_invite, surveyls_email_remind_subj, surveyls_email_remind, surveyls_email_register_subj, surveyls_email_register, surveyls_email_confirm_subj, surveyls_email_confirm, surveyls_dateformat, surveyls_attributecaptions, email_admin_notification_subj, email_admin_notification, email_admin_responses_subj, email_admin_responses, surveyls_numberformat, attachments) FROM stdin;
\.


--
-- Data for Name: lime_templates; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_templates (folder, creator) FROM stdin;
\.


--
-- Data for Name: lime_user_groups; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_user_groups (ugid, name, description, owner_id) FROM stdin;
\.


--
-- Name: lime_user_groups_ugid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_user_groups_ugid_seq', 1, false);


--
-- Data for Name: lime_user_in_groups; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_user_in_groups (ugid, uid) FROM stdin;
\.


--
-- Data for Name: lime_users; Type: TABLE DATA; Schema: public; Owner: limesurvey
--

COPY lime_users (uid, users_name, password, full_name, parent_id, lang, email, htmleditormode, templateeditormode, questionselectormode, one_time_pw, dateformat, created, modified) FROM stdin;
1	admin	713bfda78870bf9d1b261f565286f85e97ee614efe5f0faf7c34e7ca4f65baca	Administrator	0	en	limesurvey@beta8.cloudstead.io	default	default	default	\N	1	2014-10-28 11:45:12.670355	\N
\.


--
-- Name: lime_users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: limesurvey
--

SELECT pg_catalog.setval('lime_users_uid_seq', 1, true);


--
-- Name: lime_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_answers
    ADD CONSTRAINT lime_answers_pkey PRIMARY KEY (qid, code, language, scale_id);


--
-- Name: lime_assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_assessments
    ADD CONSTRAINT lime_assessments_pkey PRIMARY KEY (id, language);


--
-- Name: lime_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_conditions
    ADD CONSTRAINT lime_conditions_pkey PRIMARY KEY (cid);


--
-- Name: lime_defaultvalues_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_defaultvalues
    ADD CONSTRAINT lime_defaultvalues_pkey PRIMARY KEY (qid, specialtype, language, scale_id, sqid);


--
-- Name: lime_expression_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_expression_errors
    ADD CONSTRAINT lime_expression_errors_pkey PRIMARY KEY (id);


--
-- Name: lime_failed_login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_failed_login_attempts
    ADD CONSTRAINT lime_failed_login_attempts_pkey PRIMARY KEY (id);


--
-- Name: lime_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_groups
    ADD CONSTRAINT lime_groups_pkey PRIMARY KEY (gid, language);


--
-- Name: lime_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_labels
    ADD CONSTRAINT lime_labels_pkey PRIMARY KEY (lid, sortorder, language);


--
-- Name: lime_labelsets_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_labelsets
    ADD CONSTRAINT lime_labelsets_pkey PRIMARY KEY (lid);


--
-- Name: lime_participant_attribut_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participant_attribute
    ADD CONSTRAINT lime_participant_attribut_pkey PRIMARY KEY (participant_id, attribute_id);


--
-- Name: lime_participant_attribute_names_lang_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participant_attribute_names_lang
    ADD CONSTRAINT lime_participant_attribute_names_lang_pkey PRIMARY KEY (attribute_id, lang);


--
-- Name: lime_participant_attribute_names_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participant_attribute_names
    ADD CONSTRAINT lime_participant_attribute_names_pkey PRIMARY KEY (attribute_id, attribute_type);


--
-- Name: lime_participant_attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participant_attribute_values
    ADD CONSTRAINT lime_participant_attribute_values_pkey PRIMARY KEY (value_id);


--
-- Name: lime_participant_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participant_shares
    ADD CONSTRAINT lime_participant_shares_pkey PRIMARY KEY (participant_id, share_uid);


--
-- Name: lime_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_participants
    ADD CONSTRAINT lime_participants_pkey PRIMARY KEY (participant_id);


--
-- Name: lime_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_permissions
    ADD CONSTRAINT lime_permissions_pkey PRIMARY KEY (id);


--
-- Name: lime_plugin_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_plugin_settings
    ADD CONSTRAINT lime_plugin_settings_pkey PRIMARY KEY (id);


--
-- Name: lime_plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_plugins
    ADD CONSTRAINT lime_plugins_pkey PRIMARY KEY (id);


--
-- Name: lime_question_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_question_attributes
    ADD CONSTRAINT lime_question_attributes_pkey PRIMARY KEY (qaid);


--
-- Name: lime_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_questions
    ADD CONSTRAINT lime_questions_pkey PRIMARY KEY (qid, language);


--
-- Name: lime_quota_languagesettings_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_quota_languagesettings
    ADD CONSTRAINT lime_quota_languagesettings_pkey PRIMARY KEY (quotals_id);


--
-- Name: lime_quota_members_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_quota_members
    ADD CONSTRAINT lime_quota_members_pkey PRIMARY KEY (id);


--
-- Name: lime_quota_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_quota
    ADD CONSTRAINT lime_quota_pkey PRIMARY KEY (id);


--
-- Name: lime_saved_control_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_saved_control
    ADD CONSTRAINT lime_saved_control_pkey PRIMARY KEY (scid);


--
-- Name: lime_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_sessions
    ADD CONSTRAINT lime_sessions_pkey PRIMARY KEY (id);


--
-- Name: lime_settings_global_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_settings_global
    ADD CONSTRAINT lime_settings_global_pkey PRIMARY KEY (stg_name);


--
-- Name: lime_survey_links_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_survey_links
    ADD CONSTRAINT lime_survey_links_pkey PRIMARY KEY (participant_id, token_id, survey_id);


--
-- Name: lime_survey_url_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_survey_url_parameters
    ADD CONSTRAINT lime_survey_url_parameters_pkey PRIMARY KEY (id);


--
-- Name: lime_surveys_languagesettings_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_surveys_languagesettings
    ADD CONSTRAINT lime_surveys_languagesettings_pkey PRIMARY KEY (surveyls_survey_id, surveyls_language);


--
-- Name: lime_surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_surveys
    ADD CONSTRAINT lime_surveys_pkey PRIMARY KEY (sid);


--
-- Name: lime_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_templates
    ADD CONSTRAINT lime_templates_pkey PRIMARY KEY (folder);


--
-- Name: lime_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_user_groups
    ADD CONSTRAINT lime_user_groups_pkey PRIMARY KEY (ugid);


--
-- Name: lime_user_in_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_user_in_groups
    ADD CONSTRAINT lime_user_in_groups_pkey PRIMARY KEY (ugid, uid);


--
-- Name: lime_users_pkey; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_users
    ADD CONSTRAINT lime_users_pkey PRIMARY KEY (uid);


--
-- Name: lime_users_users_name_key; Type: CONSTRAINT; Schema: public; Owner: limesurvey; Tablespace: 
--

ALTER TABLE ONLY lime_users
    ADD CONSTRAINT lime_users_users_name_key UNIQUE (users_name);


--
-- Name: answers_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX answers_idx2 ON lime_answers USING btree (sortorder);


--
-- Name: assessments_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX assessments_idx2 ON lime_assessments USING btree (sid);


--
-- Name: assessments_idx3; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX assessments_idx3 ON lime_assessments USING btree (gid);


--
-- Name: conditions_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX conditions_idx2 ON lime_conditions USING btree (qid);


--
-- Name: conditions_idx3; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX conditions_idx3 ON lime_conditions USING btree (cqid);


--
-- Name: groups_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX groups_idx2 ON lime_groups USING btree (sid);


--
-- Name: labels_code_idx; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX labels_code_idx ON lime_labels USING btree (code);


--
-- Name: lime_quota_members_ixcode_idx; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX lime_quota_members_ixcode_idx ON lime_quota_members USING btree (sid, qid, quota_id, code);


--
-- Name: parent_qid_idx; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX parent_qid_idx ON lime_questions USING btree (parent_qid);


--
-- Name: permissions_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE UNIQUE INDEX permissions_idx2 ON lime_permissions USING btree (entity_id, entity, uid, permission);


--
-- Name: question_attributes_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX question_attributes_idx2 ON lime_question_attributes USING btree (qid);


--
-- Name: question_attributes_idx3; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX question_attributes_idx3 ON lime_question_attributes USING btree (attribute);


--
-- Name: questions_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX questions_idx2 ON lime_questions USING btree (sid);


--
-- Name: questions_idx3; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX questions_idx3 ON lime_questions USING btree (gid);


--
-- Name: questions_idx4; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX questions_idx4 ON lime_questions USING btree (type);


--
-- Name: quota_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX quota_idx2 ON lime_quota USING btree (sid);


--
-- Name: saved_control_idx2; Type: INDEX; Schema: public; Owner: limesurvey; Tablespace: 
--

CREATE INDEX saved_control_idx2 ON lime_saved_control USING btree (sid);


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

