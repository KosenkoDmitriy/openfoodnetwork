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
-- Name: account_invoices; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE account_invoices (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer,
    year integer NOT NULL,
    month integer NOT NULL,
    issued_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE account_invoices OWNER TO ofn;

--
-- Name: account_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE account_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_invoices_id_seq OWNER TO ofn;

--
-- Name: account_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE account_invoices_id_seq OWNED BY account_invoices.id;


--
-- Name: adjustment_metadata; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE adjustment_metadata (
    id integer NOT NULL,
    adjustment_id integer,
    enterprise_id integer,
    fee_name character varying(255),
    fee_type character varying(255),
    enterprise_role character varying(255)
);


ALTER TABLE adjustment_metadata OWNER TO ofn;

--
-- Name: adjustment_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE adjustment_metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adjustment_metadata_id_seq OWNER TO ofn;

--
-- Name: adjustment_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE adjustment_metadata_id_seq OWNED BY adjustment_metadata.id;


--
-- Name: billable_periods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE billable_periods (
    id integer NOT NULL,
    enterprise_id integer,
    owner_id integer,
    begins_at timestamp without time zone,
    ends_at timestamp without time zone,
    sells character varying(255),
    trial boolean DEFAULT false,
    turnover numeric DEFAULT 0.0,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    account_invoice_id integer NOT NULL
);


ALTER TABLE billable_periods OWNER TO ofn;

--
-- Name: billable_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE billable_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billable_periods_id_seq OWNER TO ofn;

--
-- Name: billable_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE billable_periods_id_seq OWNED BY billable_periods.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE carts (
    id integer NOT NULL,
    user_id integer
);


ALTER TABLE carts OWNER TO ofn;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE carts_id_seq OWNER TO ofn;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


--
-- Name: cms_blocks; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_blocks (
    id integer NOT NULL,
    page_id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE cms_blocks OWNER TO ofn;

--
-- Name: cms_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_blocks_id_seq OWNER TO ofn;

--
-- Name: cms_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_blocks_id_seq OWNED BY cms_blocks.id;


--
-- Name: cms_categories; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_categories (
    id integer NOT NULL,
    site_id integer NOT NULL,
    label character varying(255) NOT NULL,
    categorized_type character varying(255) NOT NULL
);


ALTER TABLE cms_categories OWNER TO ofn;

--
-- Name: cms_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_categories_id_seq OWNER TO ofn;

--
-- Name: cms_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_categories_id_seq OWNED BY cms_categories.id;


--
-- Name: cms_categorizations; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_categorizations (
    id integer NOT NULL,
    category_id integer NOT NULL,
    categorized_type character varying(255) NOT NULL,
    categorized_id integer NOT NULL
);


ALTER TABLE cms_categorizations OWNER TO ofn;

--
-- Name: cms_categorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_categorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_categorizations_id_seq OWNER TO ofn;

--
-- Name: cms_categorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_categorizations_id_seq OWNED BY cms_categorizations.id;


--
-- Name: cms_files; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_files (
    id integer NOT NULL,
    site_id integer NOT NULL,
    block_id integer,
    label character varying(255) NOT NULL,
    file_file_name character varying(255) NOT NULL,
    file_content_type character varying(255) NOT NULL,
    file_file_size integer NOT NULL,
    description character varying(2048),
    "position" integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE cms_files OWNER TO ofn;

--
-- Name: cms_files_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_files_id_seq OWNER TO ofn;

--
-- Name: cms_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_files_id_seq OWNED BY cms_files.id;


--
-- Name: cms_layouts; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_layouts (
    id integer NOT NULL,
    site_id integer NOT NULL,
    parent_id integer,
    app_layout character varying(255),
    label character varying(255) NOT NULL,
    identifier character varying(255) NOT NULL,
    content text,
    css text,
    js text,
    "position" integer DEFAULT 0 NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE cms_layouts OWNER TO ofn;

--
-- Name: cms_layouts_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_layouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_layouts_id_seq OWNER TO ofn;

--
-- Name: cms_layouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_layouts_id_seq OWNED BY cms_layouts.id;


--
-- Name: cms_pages; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_pages (
    id integer NOT NULL,
    site_id integer NOT NULL,
    layout_id integer,
    parent_id integer,
    target_page_id integer,
    label character varying(255) NOT NULL,
    slug character varying(255),
    full_path character varying(255) NOT NULL,
    content text,
    "position" integer DEFAULT 0 NOT NULL,
    children_count integer DEFAULT 0 NOT NULL,
    is_published boolean DEFAULT true NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE cms_pages OWNER TO ofn;

--
-- Name: cms_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_pages_id_seq OWNER TO ofn;

--
-- Name: cms_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_pages_id_seq OWNED BY cms_pages.id;


--
-- Name: cms_revisions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_revisions (
    id integer NOT NULL,
    record_type character varying(255) NOT NULL,
    record_id integer NOT NULL,
    data text,
    created_at timestamp without time zone
);


ALTER TABLE cms_revisions OWNER TO ofn;

--
-- Name: cms_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_revisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_revisions_id_seq OWNER TO ofn;

--
-- Name: cms_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_revisions_id_seq OWNED BY cms_revisions.id;


--
-- Name: cms_sites; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_sites (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    identifier character varying(255) NOT NULL,
    hostname character varying(255) NOT NULL,
    path character varying(255),
    locale character varying(255) DEFAULT 'en'::character varying NOT NULL,
    is_mirrored boolean DEFAULT false NOT NULL
);


ALTER TABLE cms_sites OWNER TO ofn;

--
-- Name: cms_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_sites_id_seq OWNER TO ofn;

--
-- Name: cms_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_sites_id_seq OWNED BY cms_sites.id;


--
-- Name: cms_snippets; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE cms_snippets (
    id integer NOT NULL,
    site_id integer NOT NULL,
    label character varying(255) NOT NULL,
    identifier character varying(255) NOT NULL,
    content text,
    "position" integer DEFAULT 0 NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE cms_snippets OWNER TO ofn;

--
-- Name: cms_snippets_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE cms_snippets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms_snippets_id_seq OWNER TO ofn;

--
-- Name: cms_snippets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE cms_snippets_id_seq OWNED BY cms_snippets.id;


--
-- Name: coordinator_fees; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE coordinator_fees (
    order_cycle_id integer,
    enterprise_fee_id integer
);


ALTER TABLE coordinator_fees OWNER TO ofn;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE customers (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    enterprise_id integer NOT NULL,
    code character varying(255),
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE customers OWNER TO ofn;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers_id_seq OWNER TO ofn;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE delayed_jobs OWNER TO ofn;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE delayed_jobs_id_seq OWNER TO ofn;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: distributors_payment_methods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE distributors_payment_methods (
    distributor_id integer,
    payment_method_id integer
);


ALTER TABLE distributors_payment_methods OWNER TO ofn;

--
-- Name: distributors_shipping_methods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE distributors_shipping_methods (
    id integer NOT NULL,
    distributor_id integer,
    shipping_method_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE distributors_shipping_methods OWNER TO ofn;

--
-- Name: distributors_shipping_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE distributors_shipping_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE distributors_shipping_methods_id_seq OWNER TO ofn;

--
-- Name: distributors_shipping_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE distributors_shipping_methods_id_seq OWNED BY distributors_shipping_methods.id;


--
-- Name: enterprise_fees; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_fees (
    id integer NOT NULL,
    enterprise_id integer,
    fee_type character varying(255),
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tax_category_id integer
);


ALTER TABLE enterprise_fees OWNER TO ofn;

--
-- Name: enterprise_fees_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprise_fees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprise_fees_id_seq OWNER TO ofn;

--
-- Name: enterprise_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprise_fees_id_seq OWNED BY enterprise_fees.id;


--
-- Name: enterprise_groups; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_groups (
    id integer NOT NULL,
    name character varying(255),
    on_front_page boolean,
    "position" integer,
    promo_image_file_name character varying(255),
    promo_image_content_type character varying(255),
    promo_image_file_size integer,
    promo_image_updated_at timestamp without time zone,
    description text,
    long_description text,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    address_id integer,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    website character varying(255) DEFAULT ''::character varying NOT NULL,
    facebook character varying(255) DEFAULT ''::character varying NOT NULL,
    instagram character varying(255) DEFAULT ''::character varying NOT NULL,
    linkedin character varying(255) DEFAULT ''::character varying NOT NULL,
    twitter character varying(255) DEFAULT ''::character varying NOT NULL,
    owner_id integer,
    permalink character varying(255) NOT NULL
);


ALTER TABLE enterprise_groups OWNER TO ofn;

--
-- Name: enterprise_groups_enterprises; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_groups_enterprises (
    enterprise_group_id integer,
    enterprise_id integer
);


ALTER TABLE enterprise_groups_enterprises OWNER TO ofn;

--
-- Name: enterprise_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprise_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprise_groups_id_seq OWNER TO ofn;

--
-- Name: enterprise_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprise_groups_id_seq OWNED BY enterprise_groups.id;


--
-- Name: enterprise_relationship_permissions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_relationship_permissions (
    id integer NOT NULL,
    enterprise_relationship_id integer,
    name character varying(255) NOT NULL
);


ALTER TABLE enterprise_relationship_permissions OWNER TO ofn;

--
-- Name: enterprise_relationship_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprise_relationship_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprise_relationship_permissions_id_seq OWNER TO ofn;

--
-- Name: enterprise_relationship_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprise_relationship_permissions_id_seq OWNED BY enterprise_relationship_permissions.id;


--
-- Name: enterprise_relationships; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_relationships (
    id integer NOT NULL,
    parent_id integer,
    child_id integer
);


ALTER TABLE enterprise_relationships OWNER TO ofn;

--
-- Name: enterprise_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprise_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprise_relationships_id_seq OWNER TO ofn;

--
-- Name: enterprise_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprise_relationships_id_seq OWNED BY enterprise_relationships.id;


--
-- Name: enterprise_roles; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprise_roles (
    id integer NOT NULL,
    user_id integer,
    enterprise_id integer
);


ALTER TABLE enterprise_roles OWNER TO ofn;

--
-- Name: enterprise_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprise_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprise_roles_id_seq OWNER TO ofn;

--
-- Name: enterprise_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprise_roles_id_seq OWNED BY enterprise_roles.id;


--
-- Name: enterprises; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE enterprises (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    long_description text,
    is_primary_producer boolean,
    contact character varying(255),
    phone character varying(255),
    email character varying(255),
    website character varying(255),
    twitter character varying(255),
    abn character varying(255),
    acn character varying(255),
    address_id integer,
    pickup_times character varying(255),
    next_collection_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    distributor_info text,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    promo_image_file_name character varying(255),
    promo_image_content_type character varying(255),
    promo_image_file_size integer,
    promo_image_updated_at timestamp without time zone,
    visible boolean DEFAULT true,
    facebook character varying(255),
    instagram character varying(255),
    linkedin character varying(255),
    owner_id integer NOT NULL,
    sells character varying(255) DEFAULT 'none'::character varying NOT NULL,
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    shop_trial_start_date timestamp without time zone,
    producer_profile_only boolean DEFAULT false,
    permalink character varying(255) NOT NULL,
    charges_sales_tax boolean DEFAULT false NOT NULL,
    origin_code character varying(255)
);


ALTER TABLE enterprises OWNER TO ofn;

--
-- Name: enterprises_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE enterprises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enterprises_id_seq OWNER TO ofn;

--
-- Name: enterprises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE enterprises_id_seq OWNED BY enterprises.id;


--
-- Name: exchange_fees; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE exchange_fees (
    id integer NOT NULL,
    exchange_id integer,
    enterprise_fee_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE exchange_fees OWNER TO ofn;

--
-- Name: exchange_fees_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE exchange_fees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exchange_fees_id_seq OWNER TO ofn;

--
-- Name: exchange_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE exchange_fees_id_seq OWNED BY exchange_fees.id;


--
-- Name: exchange_variants; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE exchange_variants (
    id integer NOT NULL,
    exchange_id integer,
    variant_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE exchange_variants OWNER TO ofn;

--
-- Name: exchange_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE exchange_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exchange_variants_id_seq OWNER TO ofn;

--
-- Name: exchange_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE exchange_variants_id_seq OWNED BY exchange_variants.id;


--
-- Name: exchanges; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE exchanges (
    id integer NOT NULL,
    order_cycle_id integer,
    sender_id integer,
    receiver_id integer,
    payment_enterprise_id integer,
    pickup_time character varying(255),
    pickup_instructions character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    incoming boolean DEFAULT false NOT NULL
);


ALTER TABLE exchanges OWNER TO ofn;

--
-- Name: exchanges_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE exchanges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exchanges_id_seq OWNER TO ofn;

--
-- Name: exchanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE exchanges_id_seq OWNED BY exchanges.id;


--
-- Name: order_cycles; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE order_cycles (
    id integer NOT NULL,
    name character varying(255),
    orders_open_at timestamp without time zone,
    orders_close_at timestamp without time zone,
    coordinator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE order_cycles OWNER TO ofn;

--
-- Name: order_cycles_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE order_cycles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_cycles_id_seq OWNER TO ofn;

--
-- Name: order_cycles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE order_cycles_id_seq OWNED BY order_cycles.id;


--
-- Name: producer_properties; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE producer_properties (
    id integer NOT NULL,
    value character varying(255),
    producer_id integer,
    property_id integer,
    "position" integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE producer_properties OWNER TO ofn;

--
-- Name: producer_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE producer_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE producer_properties_id_seq OWNER TO ofn;

--
-- Name: producer_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE producer_properties_id_seq OWNED BY producer_properties.id;


--
-- Name: product_distributions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE product_distributions (
    id integer NOT NULL,
    product_id integer,
    distributor_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    enterprise_fee_id integer
);


ALTER TABLE product_distributions OWNER TO ofn;

--
-- Name: product_distributions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE product_distributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_distributions_id_seq OWNER TO ofn;

--
-- Name: product_distributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE product_distributions_id_seq OWNED BY product_distributions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE schema_migrations OWNER TO ofn;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE sessions OWNER TO ofn;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sessions_id_seq OWNER TO ofn;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: spree_activators; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_activators (
    id integer NOT NULL,
    description character varying(255),
    expires_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    starts_at timestamp without time zone,
    name character varying(255),
    event_name character varying(255),
    type character varying(255),
    usage_limit integer,
    match_policy character varying(255) DEFAULT 'all'::character varying,
    code character varying(255),
    advertise boolean DEFAULT false,
    path character varying(255)
);


ALTER TABLE spree_activators OWNER TO ofn;

--
-- Name: spree_activators_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_activators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_activators_id_seq OWNER TO ofn;

--
-- Name: spree_activators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_activators_id_seq OWNED BY spree_activators.id;


--
-- Name: spree_addresses; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_addresses (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    zipcode character varying(255),
    phone character varying(255),
    state_name character varying(255),
    alternative_phone character varying(255),
    state_id integer,
    country_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    company character varying(255),
    latitude double precision,
    longitude double precision
);


ALTER TABLE spree_addresses OWNER TO ofn;

--
-- Name: spree_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_addresses_id_seq OWNER TO ofn;

--
-- Name: spree_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_addresses_id_seq OWNED BY spree_addresses.id;


--
-- Name: spree_adjustments; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_adjustments (
    id integer NOT NULL,
    source_id integer,
    amount numeric(10,2),
    label character varying(255),
    source_type character varying(255),
    adjustable_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mandatory boolean,
    locked boolean,
    originator_id integer,
    originator_type character varying(255),
    eligible boolean DEFAULT true,
    adjustable_type character varying(255),
    included_tax numeric(10,2) DEFAULT 0.0 NOT NULL
);


ALTER TABLE spree_adjustments OWNER TO ofn;

--
-- Name: spree_adjustments_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_adjustments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_adjustments_id_seq OWNER TO ofn;

--
-- Name: spree_adjustments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_adjustments_id_seq OWNED BY spree_adjustments.id;


--
-- Name: spree_assets; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_assets (
    id integer NOT NULL,
    viewable_id integer,
    attachment_width integer,
    attachment_height integer,
    attachment_file_size integer,
    "position" integer,
    viewable_type character varying(50),
    attachment_content_type character varying(255),
    attachment_file_name character varying(255),
    type character varying(75),
    attachment_updated_at timestamp without time zone,
    alt text
);


ALTER TABLE spree_assets OWNER TO ofn;

--
-- Name: spree_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_assets_id_seq OWNER TO ofn;

--
-- Name: spree_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_assets_id_seq OWNED BY spree_assets.id;


--
-- Name: spree_calculators; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_calculators (
    id integer NOT NULL,
    type character varying(255),
    calculable_id integer NOT NULL,
    calculable_type character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_calculators OWNER TO ofn;

--
-- Name: spree_calculators_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_calculators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_calculators_id_seq OWNER TO ofn;

--
-- Name: spree_calculators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_calculators_id_seq OWNED BY spree_calculators.id;


--
-- Name: spree_configurations; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_configurations (
    id integer NOT NULL,
    name character varying(255),
    type character varying(50),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_configurations OWNER TO ofn;

--
-- Name: spree_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_configurations_id_seq OWNER TO ofn;

--
-- Name: spree_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_configurations_id_seq OWNED BY spree_configurations.id;


--
-- Name: spree_countries; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_countries (
    id integer NOT NULL,
    iso_name character varying(255),
    iso character varying(255),
    iso3 character varying(255),
    name character varying(255),
    numcode integer,
    states_required boolean DEFAULT true
);


ALTER TABLE spree_countries OWNER TO ofn;

--
-- Name: spree_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_countries_id_seq OWNER TO ofn;

--
-- Name: spree_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_countries_id_seq OWNED BY spree_countries.id;


--
-- Name: spree_credit_cards; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_credit_cards (
    id integer NOT NULL,
    month character varying(255),
    year character varying(255),
    cc_type character varying(255),
    last_digits character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    start_month character varying(255),
    start_year character varying(255),
    issue_number character varying(255),
    address_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    gateway_customer_profile_id character varying(255),
    gateway_payment_profile_id character varying(255)
);


ALTER TABLE spree_credit_cards OWNER TO ofn;

--
-- Name: spree_credit_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_credit_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_credit_cards_id_seq OWNER TO ofn;

--
-- Name: spree_credit_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_credit_cards_id_seq OWNED BY spree_credit_cards.id;


--
-- Name: spree_gateways; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_gateways (
    id integer NOT NULL,
    type character varying(255),
    name character varying(255),
    description text,
    active boolean DEFAULT true,
    environment character varying(255) DEFAULT 'development'::character varying,
    server character varying(255) DEFAULT 'test'::character varying,
    test_mode boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_gateways OWNER TO ofn;

--
-- Name: spree_gateways_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_gateways_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_gateways_id_seq OWNER TO ofn;

--
-- Name: spree_gateways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_gateways_id_seq OWNED BY spree_gateways.id;


--
-- Name: spree_inventory_units; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_inventory_units (
    id integer NOT NULL,
    lock_version integer DEFAULT 0,
    state character varying(255),
    variant_id integer,
    order_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    shipment_id integer,
    return_authorization_id integer
);


ALTER TABLE spree_inventory_units OWNER TO ofn;

--
-- Name: spree_inventory_units_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_inventory_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_inventory_units_id_seq OWNER TO ofn;

--
-- Name: spree_inventory_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_inventory_units_id_seq OWNED BY spree_inventory_units.id;


--
-- Name: spree_line_items; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_line_items (
    id integer NOT NULL,
    order_id integer,
    variant_id integer,
    quantity integer NOT NULL,
    price numeric(8,2) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    max_quantity integer,
    currency character varying(255),
    distribution_fee numeric(10,2),
    shipping_method_name character varying(255),
    final_weight_volume numeric(10,2)
);


ALTER TABLE spree_line_items OWNER TO ofn;

--
-- Name: spree_line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_line_items_id_seq OWNER TO ofn;

--
-- Name: spree_line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_line_items_id_seq OWNED BY spree_line_items.id;


--
-- Name: spree_log_entries; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_log_entries (
    id integer NOT NULL,
    source_id integer,
    source_type character varying(255),
    details text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_log_entries OWNER TO ofn;

--
-- Name: spree_log_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_log_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_log_entries_id_seq OWNER TO ofn;

--
-- Name: spree_log_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_log_entries_id_seq OWNED BY spree_log_entries.id;


--
-- Name: spree_mail_methods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_mail_methods (
    id integer NOT NULL,
    environment character varying(255),
    active boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_mail_methods OWNER TO ofn;

--
-- Name: spree_mail_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_mail_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_mail_methods_id_seq OWNER TO ofn;

--
-- Name: spree_mail_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_mail_methods_id_seq OWNED BY spree_mail_methods.id;


--
-- Name: spree_option_types; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_option_types (
    id integer NOT NULL,
    name character varying(100),
    presentation character varying(100),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0 NOT NULL
);


ALTER TABLE spree_option_types OWNER TO ofn;

--
-- Name: spree_option_types_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_option_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_option_types_id_seq OWNER TO ofn;

--
-- Name: spree_option_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_option_types_id_seq OWNED BY spree_option_types.id;


--
-- Name: spree_option_types_prototypes; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_option_types_prototypes (
    prototype_id integer,
    option_type_id integer
);


ALTER TABLE spree_option_types_prototypes OWNER TO ofn;

--
-- Name: spree_option_values; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_option_values (
    id integer NOT NULL,
    "position" integer,
    name character varying(255),
    presentation character varying(255),
    option_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_option_values OWNER TO ofn;

--
-- Name: spree_option_values_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_option_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_option_values_id_seq OWNER TO ofn;

--
-- Name: spree_option_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_option_values_id_seq OWNED BY spree_option_values.id;


--
-- Name: spree_option_values_variants; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_option_values_variants (
    variant_id integer,
    option_value_id integer
);


ALTER TABLE spree_option_values_variants OWNER TO ofn;

--
-- Name: spree_orders; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_orders (
    id integer NOT NULL,
    number character varying(15),
    item_total numeric(10,2) DEFAULT 0.0 NOT NULL,
    total numeric(10,2) DEFAULT 0.0 NOT NULL,
    state character varying(255),
    adjustment_total numeric(10,2) DEFAULT 0.0 NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    completed_at timestamp without time zone,
    bill_address_id integer,
    ship_address_id integer,
    payment_total numeric(10,2) DEFAULT 0.0,
    shipping_method_id integer,
    shipment_state character varying(255),
    payment_state character varying(255),
    email character varying(255),
    special_instructions text,
    distributor_id integer,
    order_cycle_id integer,
    currency character varying(255),
    last_ip_address character varying(255),
    cart_id integer,
    customer_id integer
);


ALTER TABLE spree_orders OWNER TO ofn;

--
-- Name: spree_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_orders_id_seq OWNER TO ofn;

--
-- Name: spree_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_orders_id_seq OWNED BY spree_orders.id;


--
-- Name: spree_payment_methods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_payment_methods (
    id integer NOT NULL,
    type character varying(255),
    name character varying(255),
    description text,
    active boolean DEFAULT true,
    environment character varying(255) DEFAULT 'development'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    display_on character varying(255)
);


ALTER TABLE spree_payment_methods OWNER TO ofn;

--
-- Name: spree_payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_payment_methods_id_seq OWNER TO ofn;

--
-- Name: spree_payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_payment_methods_id_seq OWNED BY spree_payment_methods.id;


--
-- Name: spree_payments; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_payments (
    id integer NOT NULL,
    amount numeric(10,2) DEFAULT 0.0 NOT NULL,
    order_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source_id integer,
    source_type character varying(255),
    payment_method_id integer,
    state character varying(255),
    response_code character varying(255),
    avs_response character varying(255),
    identifier character varying(255),
    cvv_response_code character varying(255),
    cvv_response_message character varying(255)
);


ALTER TABLE spree_payments OWNER TO ofn;

--
-- Name: spree_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_payments_id_seq OWNER TO ofn;

--
-- Name: spree_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_payments_id_seq OWNED BY spree_payments.id;


--
-- Name: spree_paypal_accounts; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_paypal_accounts (
    id integer NOT NULL,
    email character varying(255),
    payer_id character varying(255),
    payer_country character varying(255),
    payer_status character varying(255)
);


ALTER TABLE spree_paypal_accounts OWNER TO ofn;

--
-- Name: spree_paypal_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_paypal_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_paypal_accounts_id_seq OWNER TO ofn;

--
-- Name: spree_paypal_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_paypal_accounts_id_seq OWNED BY spree_paypal_accounts.id;


--
-- Name: spree_paypal_express_checkouts; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_paypal_express_checkouts (
    id integer NOT NULL,
    token character varying(255),
    payer_id character varying(255),
    transaction_id character varying(255),
    state character varying(255) DEFAULT 'complete'::character varying,
    refund_transaction_id character varying(255),
    refunded_at timestamp without time zone,
    refund_type character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE spree_paypal_express_checkouts OWNER TO ofn;

--
-- Name: spree_paypal_express_checkouts_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_paypal_express_checkouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_paypal_express_checkouts_id_seq OWNER TO ofn;

--
-- Name: spree_paypal_express_checkouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_paypal_express_checkouts_id_seq OWNED BY spree_paypal_express_checkouts.id;


--
-- Name: spree_pending_promotions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_pending_promotions (
    id integer NOT NULL,
    user_id integer,
    promotion_id integer
);


ALTER TABLE spree_pending_promotions OWNER TO ofn;

--
-- Name: spree_pending_promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_pending_promotions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_pending_promotions_id_seq OWNER TO ofn;

--
-- Name: spree_pending_promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_pending_promotions_id_seq OWNED BY spree_pending_promotions.id;


--
-- Name: spree_preferences; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_preferences (
    id integer NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    key character varying(255),
    value_type character varying(255)
);


ALTER TABLE spree_preferences OWNER TO ofn;

--
-- Name: spree_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_preferences_id_seq OWNER TO ofn;

--
-- Name: spree_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_preferences_id_seq OWNED BY spree_preferences.id;


--
-- Name: spree_prices; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_prices (
    id integer NOT NULL,
    variant_id integer NOT NULL,
    amount numeric(8,2),
    currency character varying(255)
);


ALTER TABLE spree_prices OWNER TO ofn;

--
-- Name: spree_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_prices_id_seq OWNER TO ofn;

--
-- Name: spree_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_prices_id_seq OWNED BY spree_prices.id;


--
-- Name: spree_product_groups; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_product_groups (
    id integer NOT NULL,
    name character varying(255),
    permalink character varying(255),
    "order" character varying(255)
);


ALTER TABLE spree_product_groups OWNER TO ofn;

--
-- Name: spree_product_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_product_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_product_groups_id_seq OWNER TO ofn;

--
-- Name: spree_product_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_product_groups_id_seq OWNED BY spree_product_groups.id;


--
-- Name: spree_product_groups_products; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_product_groups_products (
    product_id integer,
    product_group_id integer
);


ALTER TABLE spree_product_groups_products OWNER TO ofn;

--
-- Name: spree_product_option_types; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_product_option_types (
    id integer NOT NULL,
    "position" integer,
    product_id integer,
    option_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_product_option_types OWNER TO ofn;

--
-- Name: spree_product_option_types_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_product_option_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_product_option_types_id_seq OWNER TO ofn;

--
-- Name: spree_product_option_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_product_option_types_id_seq OWNED BY spree_product_option_types.id;


--
-- Name: spree_product_properties; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_product_properties (
    id integer NOT NULL,
    value character varying(255),
    product_id integer,
    property_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0
);


ALTER TABLE spree_product_properties OWNER TO ofn;

--
-- Name: spree_product_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_product_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_product_properties_id_seq OWNER TO ofn;

--
-- Name: spree_product_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_product_properties_id_seq OWNED BY spree_product_properties.id;


--
-- Name: spree_product_scopes; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_product_scopes (
    id integer NOT NULL,
    name character varying(255),
    arguments text,
    product_group_id integer
);


ALTER TABLE spree_product_scopes OWNER TO ofn;

--
-- Name: spree_product_scopes_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_product_scopes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_product_scopes_id_seq OWNER TO ofn;

--
-- Name: spree_product_scopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_product_scopes_id_seq OWNED BY spree_product_scopes.id;


--
-- Name: spree_products; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_products (
    id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text,
    available_on timestamp without time zone,
    deleted_at timestamp without time zone,
    permalink character varying(255),
    meta_description text,
    meta_keywords character varying(255),
    tax_category_id integer,
    shipping_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    count_on_hand integer DEFAULT 0,
    supplier_id integer,
    group_buy boolean,
    group_buy_unit_size double precision,
    on_demand boolean DEFAULT false,
    variant_unit character varying(255),
    variant_unit_scale double precision,
    variant_unit_name character varying(255),
    notes text,
    primary_taxon_id integer NOT NULL,
    inherits_properties boolean DEFAULT true NOT NULL
);


ALTER TABLE spree_products OWNER TO ofn;

--
-- Name: spree_products_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_products_id_seq OWNER TO ofn;

--
-- Name: spree_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_products_id_seq OWNED BY spree_products.id;


--
-- Name: spree_products_promotion_rules; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_products_promotion_rules (
    product_id integer,
    promotion_rule_id integer
);


ALTER TABLE spree_products_promotion_rules OWNER TO ofn;

--
-- Name: spree_products_taxons; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_products_taxons (
    id integer NOT NULL,
    product_id integer,
    taxon_id integer
);


ALTER TABLE spree_products_taxons OWNER TO ofn;

--
-- Name: spree_products_taxons_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_products_taxons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_products_taxons_id_seq OWNER TO ofn;

--
-- Name: spree_products_taxons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_products_taxons_id_seq OWNED BY spree_products_taxons.id;


--
-- Name: spree_promotion_action_line_items; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_promotion_action_line_items (
    id integer NOT NULL,
    promotion_action_id integer,
    variant_id integer,
    quantity integer DEFAULT 1
);


ALTER TABLE spree_promotion_action_line_items OWNER TO ofn;

--
-- Name: spree_promotion_action_line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_promotion_action_line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_promotion_action_line_items_id_seq OWNER TO ofn;

--
-- Name: spree_promotion_action_line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_promotion_action_line_items_id_seq OWNED BY spree_promotion_action_line_items.id;


--
-- Name: spree_promotion_actions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_promotion_actions (
    id integer NOT NULL,
    activator_id integer,
    "position" integer,
    type character varying(255)
);


ALTER TABLE spree_promotion_actions OWNER TO ofn;

--
-- Name: spree_promotion_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_promotion_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_promotion_actions_id_seq OWNER TO ofn;

--
-- Name: spree_promotion_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_promotion_actions_id_seq OWNED BY spree_promotion_actions.id;


--
-- Name: spree_promotion_rules; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_promotion_rules (
    id integer NOT NULL,
    activator_id integer,
    user_id integer,
    product_group_id integer,
    type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_promotion_rules OWNER TO ofn;

--
-- Name: spree_promotion_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_promotion_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_promotion_rules_id_seq OWNER TO ofn;

--
-- Name: spree_promotion_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_promotion_rules_id_seq OWNED BY spree_promotion_rules.id;


--
-- Name: spree_promotion_rules_users; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_promotion_rules_users (
    user_id integer,
    promotion_rule_id integer
);


ALTER TABLE spree_promotion_rules_users OWNER TO ofn;

--
-- Name: spree_properties; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_properties (
    id integer NOT NULL,
    name character varying(255),
    presentation character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_properties OWNER TO ofn;

--
-- Name: spree_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_properties_id_seq OWNER TO ofn;

--
-- Name: spree_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_properties_id_seq OWNED BY spree_properties.id;


--
-- Name: spree_properties_prototypes; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_properties_prototypes (
    prototype_id integer,
    property_id integer
);


ALTER TABLE spree_properties_prototypes OWNER TO ofn;

--
-- Name: spree_prototypes; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_prototypes (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_prototypes OWNER TO ofn;

--
-- Name: spree_prototypes_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_prototypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_prototypes_id_seq OWNER TO ofn;

--
-- Name: spree_prototypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_prototypes_id_seq OWNED BY spree_prototypes.id;


--
-- Name: spree_return_authorizations; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_return_authorizations (
    id integer NOT NULL,
    number character varying(255),
    state character varying(255),
    amount numeric(10,2) DEFAULT 0.0 NOT NULL,
    order_id integer,
    reason text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_return_authorizations OWNER TO ofn;

--
-- Name: spree_return_authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_return_authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_return_authorizations_id_seq OWNER TO ofn;

--
-- Name: spree_return_authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_return_authorizations_id_seq OWNED BY spree_return_authorizations.id;


--
-- Name: spree_roles; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_roles (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE spree_roles OWNER TO ofn;

--
-- Name: spree_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_roles_id_seq OWNER TO ofn;

--
-- Name: spree_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_roles_id_seq OWNED BY spree_roles.id;


--
-- Name: spree_roles_users; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_roles_users (
    role_id integer,
    user_id integer
);


ALTER TABLE spree_roles_users OWNER TO ofn;

--
-- Name: spree_shipments; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_shipments (
    id integer NOT NULL,
    tracking character varying(255),
    number character varying(255),
    cost numeric(8,2),
    shipped_at timestamp without time zone,
    order_id integer,
    shipping_method_id integer,
    address_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE spree_shipments OWNER TO ofn;

--
-- Name: spree_shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_shipments_id_seq OWNER TO ofn;

--
-- Name: spree_shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_shipments_id_seq OWNED BY spree_shipments.id;


--
-- Name: spree_shipping_categories; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_shipping_categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    temperature_controlled boolean DEFAULT false NOT NULL
);


ALTER TABLE spree_shipping_categories OWNER TO ofn;

--
-- Name: spree_shipping_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_shipping_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_shipping_categories_id_seq OWNER TO ofn;

--
-- Name: spree_shipping_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_shipping_categories_id_seq OWNED BY spree_shipping_categories.id;


--
-- Name: spree_shipping_methods; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_shipping_methods (
    id integer NOT NULL,
    name character varying(255),
    zone_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_on character varying(255),
    shipping_category_id integer,
    match_none boolean,
    match_all boolean,
    match_one boolean,
    deleted_at timestamp without time zone,
    require_ship_address boolean DEFAULT true,
    description text
);


ALTER TABLE spree_shipping_methods OWNER TO ofn;

--
-- Name: spree_shipping_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_shipping_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_shipping_methods_id_seq OWNER TO ofn;

--
-- Name: spree_shipping_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_shipping_methods_id_seq OWNED BY spree_shipping_methods.id;


--
-- Name: spree_skrill_transactions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_skrill_transactions (
    id integer NOT NULL,
    email character varying(255),
    amount double precision,
    currency character varying(255),
    transaction_id integer,
    customer_id integer,
    payment_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_skrill_transactions OWNER TO ofn;

--
-- Name: spree_skrill_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_skrill_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_skrill_transactions_id_seq OWNER TO ofn;

--
-- Name: spree_skrill_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_skrill_transactions_id_seq OWNED BY spree_skrill_transactions.id;


--
-- Name: spree_state_changes; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_state_changes (
    id integer NOT NULL,
    name character varying(255),
    previous_state character varying(255),
    stateful_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    stateful_type character varying(255),
    next_state character varying(255)
);


ALTER TABLE spree_state_changes OWNER TO ofn;

--
-- Name: spree_state_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_state_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_state_changes_id_seq OWNER TO ofn;

--
-- Name: spree_state_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_state_changes_id_seq OWNED BY spree_state_changes.id;


--
-- Name: spree_states; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_states (
    id integer NOT NULL,
    name character varying(255),
    abbr character varying(255),
    country_id integer
);


ALTER TABLE spree_states OWNER TO ofn;

--
-- Name: spree_states_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_states_id_seq OWNER TO ofn;

--
-- Name: spree_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_states_id_seq OWNED BY spree_states.id;


--
-- Name: spree_tax_categories; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_tax_categories (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_default boolean DEFAULT false,
    deleted_at timestamp without time zone
);


ALTER TABLE spree_tax_categories OWNER TO ofn;

--
-- Name: spree_tax_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_tax_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_tax_categories_id_seq OWNER TO ofn;

--
-- Name: spree_tax_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_tax_categories_id_seq OWNED BY spree_tax_categories.id;


--
-- Name: spree_tax_rates; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_tax_rates (
    id integer NOT NULL,
    amount numeric(8,5),
    zone_id integer,
    tax_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    included_in_price boolean DEFAULT false,
    name character varying(255),
    show_rate_in_label boolean DEFAULT true
);


ALTER TABLE spree_tax_rates OWNER TO ofn;

--
-- Name: spree_tax_rates_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_tax_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_tax_rates_id_seq OWNER TO ofn;

--
-- Name: spree_tax_rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_tax_rates_id_seq OWNED BY spree_tax_rates.id;


--
-- Name: spree_taxonomies; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_taxonomies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0
);


ALTER TABLE spree_taxonomies OWNER TO ofn;

--
-- Name: spree_taxonomies_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_taxonomies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_taxonomies_id_seq OWNER TO ofn;

--
-- Name: spree_taxonomies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_taxonomies_id_seq OWNED BY spree_taxonomies.id;


--
-- Name: spree_taxons; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_taxons (
    id integer NOT NULL,
    parent_id integer,
    "position" integer DEFAULT 0,
    name character varying(255) NOT NULL,
    permalink character varying(255),
    taxonomy_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lft integer,
    rgt integer,
    icon_file_name character varying(255),
    icon_content_type character varying(255),
    icon_file_size integer,
    icon_updated_at timestamp without time zone,
    description text,
    meta_title character varying(255),
    meta_description character varying(255),
    meta_keywords character varying(255)
);


ALTER TABLE spree_taxons OWNER TO ofn;

--
-- Name: spree_taxons_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_taxons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_taxons_id_seq OWNER TO ofn;

--
-- Name: spree_taxons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_taxons_id_seq OWNED BY spree_taxons.id;


--
-- Name: spree_tokenized_permissions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_tokenized_permissions (
    id integer NOT NULL,
    permissable_id integer,
    permissable_type character varying(255),
    token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_tokenized_permissions OWNER TO ofn;

--
-- Name: spree_tokenized_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_tokenized_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_tokenized_permissions_id_seq OWNER TO ofn;

--
-- Name: spree_tokenized_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_tokenized_permissions_id_seq OWNED BY spree_tokenized_permissions.id;


--
-- Name: spree_trackers; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_trackers (
    id integer NOT NULL,
    environment character varying(255),
    analytics_id character varying(255),
    active boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_trackers OWNER TO ofn;

--
-- Name: spree_trackers_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_trackers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_trackers_id_seq OWNER TO ofn;

--
-- Name: spree_trackers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_trackers_id_seq OWNED BY spree_trackers.id;


--
-- Name: spree_users; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_users (
    id integer NOT NULL,
    encrypted_password character varying(255),
    password_salt character varying(255),
    email character varying(255),
    remember_token character varying(255),
    persistence_token character varying(255),
    reset_password_token character varying(255),
    perishable_token character varying(255),
    sign_in_count integer DEFAULT 0 NOT NULL,
    failed_attempts integer DEFAULT 0 NOT NULL,
    last_request_at timestamp without time zone,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    login character varying(255),
    ship_address_id integer,
    bill_address_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255),
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    spree_api_key character varying(48),
    reset_password_sent_at timestamp without time zone,
    api_key character varying(40),
    enterprise_limit integer DEFAULT 1 NOT NULL
);


ALTER TABLE spree_users OWNER TO ofn;

--
-- Name: spree_users_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_users_id_seq OWNER TO ofn;

--
-- Name: spree_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_users_id_seq OWNED BY spree_users.id;


--
-- Name: spree_variants; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_variants (
    id integer NOT NULL,
    sku character varying(255) DEFAULT ''::character varying NOT NULL,
    weight numeric(8,2),
    height numeric(8,2),
    width numeric(8,2),
    depth numeric(8,2),
    deleted_at timestamp without time zone,
    is_master boolean DEFAULT false,
    product_id integer,
    count_on_hand integer DEFAULT 0,
    cost_price numeric(8,2),
    "position" integer,
    lock_version integer DEFAULT 0,
    on_demand boolean DEFAULT false,
    cost_currency character varying(255),
    unit_value double precision,
    unit_description character varying(255) DEFAULT ''::character varying,
    display_name character varying(255),
    display_as character varying(255)
);


ALTER TABLE spree_variants OWNER TO ofn;

--
-- Name: spree_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_variants_id_seq OWNER TO ofn;

--
-- Name: spree_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_variants_id_seq OWNED BY spree_variants.id;


--
-- Name: spree_zone_members; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_zone_members (
    id integer NOT NULL,
    zoneable_id integer,
    zoneable_type character varying(255),
    zone_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE spree_zone_members OWNER TO ofn;

--
-- Name: spree_zone_members_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_zone_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_zone_members_id_seq OWNER TO ofn;

--
-- Name: spree_zone_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_zone_members_id_seq OWNED BY spree_zone_members.id;


--
-- Name: spree_zones; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE spree_zones (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    default_tax boolean DEFAULT false,
    zone_members_count integer DEFAULT 0
);


ALTER TABLE spree_zones OWNER TO ofn;

--
-- Name: spree_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE spree_zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spree_zones_id_seq OWNER TO ofn;

--
-- Name: spree_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE spree_zones_id_seq OWNED BY spree_zones.id;


--
-- Name: suburbs; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE suburbs (
    id integer NOT NULL,
    name character varying(255),
    postcode character varying(255),
    latitude double precision,
    longitude double precision,
    state_id integer
);


ALTER TABLE suburbs OWNER TO ofn;

--
-- Name: suburbs_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE suburbs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE suburbs_id_seq OWNER TO ofn;

--
-- Name: suburbs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE suburbs_id_seq OWNED BY suburbs.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


ALTER TABLE taggings OWNER TO ofn;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taggings_id_seq OWNER TO ofn;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255),
    taggings_count integer DEFAULT 0
);


ALTER TABLE tags OWNER TO ofn;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO ofn;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: variant_overrides; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE variant_overrides (
    id integer NOT NULL,
    variant_id integer NOT NULL,
    hub_id integer NOT NULL,
    price numeric(8,2),
    count_on_hand integer
);


ALTER TABLE variant_overrides OWNER TO ofn;

--
-- Name: variant_overrides_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE variant_overrides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE variant_overrides_id_seq OWNER TO ofn;

--
-- Name: variant_overrides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE variant_overrides_id_seq OWNED BY variant_overrides.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: ofn; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


ALTER TABLE versions OWNER TO ofn;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: ofn
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE versions_id_seq OWNER TO ofn;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ofn
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY account_invoices ALTER COLUMN id SET DEFAULT nextval('account_invoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY adjustment_metadata ALTER COLUMN id SET DEFAULT nextval('adjustment_metadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY billable_periods ALTER COLUMN id SET DEFAULT nextval('billable_periods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_blocks ALTER COLUMN id SET DEFAULT nextval('cms_blocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_categories ALTER COLUMN id SET DEFAULT nextval('cms_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_categorizations ALTER COLUMN id SET DEFAULT nextval('cms_categorizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_files ALTER COLUMN id SET DEFAULT nextval('cms_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_layouts ALTER COLUMN id SET DEFAULT nextval('cms_layouts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_pages ALTER COLUMN id SET DEFAULT nextval('cms_pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_revisions ALTER COLUMN id SET DEFAULT nextval('cms_revisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_sites ALTER COLUMN id SET DEFAULT nextval('cms_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_snippets ALTER COLUMN id SET DEFAULT nextval('cms_snippets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY distributors_shipping_methods ALTER COLUMN id SET DEFAULT nextval('distributors_shipping_methods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_fees ALTER COLUMN id SET DEFAULT nextval('enterprise_fees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_groups ALTER COLUMN id SET DEFAULT nextval('enterprise_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_relationship_permissions ALTER COLUMN id SET DEFAULT nextval('enterprise_relationship_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_relationships ALTER COLUMN id SET DEFAULT nextval('enterprise_relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_roles ALTER COLUMN id SET DEFAULT nextval('enterprise_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprises ALTER COLUMN id SET DEFAULT nextval('enterprises_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_fees ALTER COLUMN id SET DEFAULT nextval('exchange_fees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_variants ALTER COLUMN id SET DEFAULT nextval('exchange_variants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchanges ALTER COLUMN id SET DEFAULT nextval('exchanges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY order_cycles ALTER COLUMN id SET DEFAULT nextval('order_cycles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY producer_properties ALTER COLUMN id SET DEFAULT nextval('producer_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY product_distributions ALTER COLUMN id SET DEFAULT nextval('product_distributions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_activators ALTER COLUMN id SET DEFAULT nextval('spree_activators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_addresses ALTER COLUMN id SET DEFAULT nextval('spree_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_adjustments ALTER COLUMN id SET DEFAULT nextval('spree_adjustments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_assets ALTER COLUMN id SET DEFAULT nextval('spree_assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_calculators ALTER COLUMN id SET DEFAULT nextval('spree_calculators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_configurations ALTER COLUMN id SET DEFAULT nextval('spree_configurations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_countries ALTER COLUMN id SET DEFAULT nextval('spree_countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_credit_cards ALTER COLUMN id SET DEFAULT nextval('spree_credit_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_gateways ALTER COLUMN id SET DEFAULT nextval('spree_gateways_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_inventory_units ALTER COLUMN id SET DEFAULT nextval('spree_inventory_units_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_line_items ALTER COLUMN id SET DEFAULT nextval('spree_line_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_log_entries ALTER COLUMN id SET DEFAULT nextval('spree_log_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_mail_methods ALTER COLUMN id SET DEFAULT nextval('spree_mail_methods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_types ALTER COLUMN id SET DEFAULT nextval('spree_option_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_values ALTER COLUMN id SET DEFAULT nextval('spree_option_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders ALTER COLUMN id SET DEFAULT nextval('spree_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_payment_methods ALTER COLUMN id SET DEFAULT nextval('spree_payment_methods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_payments ALTER COLUMN id SET DEFAULT nextval('spree_payments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_paypal_accounts ALTER COLUMN id SET DEFAULT nextval('spree_paypal_accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_paypal_express_checkouts ALTER COLUMN id SET DEFAULT nextval('spree_paypal_express_checkouts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_pending_promotions ALTER COLUMN id SET DEFAULT nextval('spree_pending_promotions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_preferences ALTER COLUMN id SET DEFAULT nextval('spree_preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_prices ALTER COLUMN id SET DEFAULT nextval('spree_prices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_groups ALTER COLUMN id SET DEFAULT nextval('spree_product_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_option_types ALTER COLUMN id SET DEFAULT nextval('spree_product_option_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_properties ALTER COLUMN id SET DEFAULT nextval('spree_product_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_scopes ALTER COLUMN id SET DEFAULT nextval('spree_product_scopes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products ALTER COLUMN id SET DEFAULT nextval('spree_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products_taxons ALTER COLUMN id SET DEFAULT nextval('spree_products_taxons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_action_line_items ALTER COLUMN id SET DEFAULT nextval('spree_promotion_action_line_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_actions ALTER COLUMN id SET DEFAULT nextval('spree_promotion_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_rules ALTER COLUMN id SET DEFAULT nextval('spree_promotion_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_properties ALTER COLUMN id SET DEFAULT nextval('spree_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_prototypes ALTER COLUMN id SET DEFAULT nextval('spree_prototypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_return_authorizations ALTER COLUMN id SET DEFAULT nextval('spree_return_authorizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_roles ALTER COLUMN id SET DEFAULT nextval('spree_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipments ALTER COLUMN id SET DEFAULT nextval('spree_shipments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipping_categories ALTER COLUMN id SET DEFAULT nextval('spree_shipping_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipping_methods ALTER COLUMN id SET DEFAULT nextval('spree_shipping_methods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_skrill_transactions ALTER COLUMN id SET DEFAULT nextval('spree_skrill_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_state_changes ALTER COLUMN id SET DEFAULT nextval('spree_state_changes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_states ALTER COLUMN id SET DEFAULT nextval('spree_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_tax_categories ALTER COLUMN id SET DEFAULT nextval('spree_tax_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_tax_rates ALTER COLUMN id SET DEFAULT nextval('spree_tax_rates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_taxonomies ALTER COLUMN id SET DEFAULT nextval('spree_taxonomies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_taxons ALTER COLUMN id SET DEFAULT nextval('spree_taxons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_tokenized_permissions ALTER COLUMN id SET DEFAULT nextval('spree_tokenized_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_trackers ALTER COLUMN id SET DEFAULT nextval('spree_trackers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_users ALTER COLUMN id SET DEFAULT nextval('spree_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_variants ALTER COLUMN id SET DEFAULT nextval('spree_variants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_zone_members ALTER COLUMN id SET DEFAULT nextval('spree_zone_members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_zones ALTER COLUMN id SET DEFAULT nextval('spree_zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY suburbs ALTER COLUMN id SET DEFAULT nextval('suburbs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY variant_overrides ALTER COLUMN id SET DEFAULT nextval('variant_overrides_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Data for Name: account_invoices; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY account_invoices (id, user_id, order_id, year, month, issued_at, created_at, updated_at) FROM stdin;
\.


--
-- Name: account_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('account_invoices_id_seq', 1, false);


--
-- Data for Name: adjustment_metadata; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY adjustment_metadata (id, adjustment_id, enterprise_id, fee_name, fee_type, enterprise_role) FROM stdin;
\.


--
-- Name: adjustment_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('adjustment_metadata_id_seq', 1, false);


--
-- Data for Name: billable_periods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY billable_periods (id, enterprise_id, owner_id, begins_at, ends_at, sells, trial, turnover, deleted_at, created_at, updated_at, account_invoice_id) FROM stdin;
\.


--
-- Name: billable_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('billable_periods_id_seq', 1, false);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY carts (id, user_id) FROM stdin;
\.


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('carts_id_seq', 1, false);


--
-- Data for Name: cms_blocks; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_blocks (id, page_id, identifier, content, created_at, updated_at) FROM stdin;
\.


--
-- Name: cms_blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_blocks_id_seq', 1, false);


--
-- Data for Name: cms_categories; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_categories (id, site_id, label, categorized_type) FROM stdin;
\.


--
-- Name: cms_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_categories_id_seq', 1, false);


--
-- Data for Name: cms_categorizations; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_categorizations (id, category_id, categorized_type, categorized_id) FROM stdin;
\.


--
-- Name: cms_categorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_categorizations_id_seq', 1, false);


--
-- Data for Name: cms_files; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_files (id, site_id, block_id, label, file_file_name, file_content_type, file_file_size, description, "position", created_at, updated_at) FROM stdin;
\.


--
-- Name: cms_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_files_id_seq', 1, false);


--
-- Data for Name: cms_layouts; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_layouts (id, site_id, parent_id, app_layout, label, identifier, content, css, js, "position", is_shared, created_at, updated_at) FROM stdin;
\.


--
-- Name: cms_layouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_layouts_id_seq', 1, false);


--
-- Data for Name: cms_pages; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_pages (id, site_id, layout_id, parent_id, target_page_id, label, slug, full_path, content, "position", children_count, is_published, is_shared, created_at, updated_at) FROM stdin;
\.


--
-- Name: cms_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_pages_id_seq', 1, false);


--
-- Data for Name: cms_revisions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_revisions (id, record_type, record_id, data, created_at) FROM stdin;
\.


--
-- Name: cms_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_revisions_id_seq', 1, false);


--
-- Data for Name: cms_sites; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_sites (id, label, identifier, hostname, path, locale, is_mirrored) FROM stdin;
\.


--
-- Name: cms_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_sites_id_seq', 1, false);


--
-- Data for Name: cms_snippets; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY cms_snippets (id, site_id, label, identifier, content, "position", is_shared, created_at, updated_at) FROM stdin;
\.


--
-- Name: cms_snippets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('cms_snippets_id_seq', 1, false);


--
-- Data for Name: coordinator_fees; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY coordinator_fees (order_cycle_id, enterprise_fee_id) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY customers (id, email, enterprise_id, code, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('customers_id_seq', 1, false);


--
-- Data for Name: delayed_jobs; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY delayed_jobs (id, priority, attempts, handler, last_error, run_at, locked_at, failed_at, locked_by, queue, created_at, updated_at) FROM stdin;
4	0	24	--- !ruby/struct:ConfirmSignupJob\nuser_id: 4\n	Couldn't find Spree::User with id=4\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:344:in `find_one'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:315:in `find_with_ids'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:107:in `find'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/querying.rb:5:in `find'\n/home/sm/prj/rails/spree/ofn_prod/app/jobs/confirm_signup_job.rb:3:in `perform'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:94:in `block in invoke_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:91:in `invoke_job'\n(eval):3:in `block in invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/newrelic_rpm-3.12.0.288/lib/new_relic/agent/instrumentation/controller_instrumentation.rb:352:in `perform_action_with_newrelic_trace'\n(eval):2:in `invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block (2 levels) in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/timeout.rb:69:in `timeout'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:198:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `block in reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:182:in `block in work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:146:in `block (4 levels) in start'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:145:in `block (3 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:144:in `block (2 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `loop'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `block in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `block (2 levels) in <class:ClearLocks>'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block (2 levels) in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:142:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:124:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:112:in `block in run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `block in start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call_as_daemon'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:269:in `start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:295:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/controller.rb:56:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:193:in `block in run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `catch_exceptions'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:192:in `run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:110:in `run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:91:in `block in daemonize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `daemonize'\nscript/delayed_job:5:in `<main>'	2015-11-05 13:25:18.27918	\N	\N	\N	\N	2015-10-16 02:58:35.490504	2015-11-01 17:15:37.281958
1	0	24	--- !ruby/struct:ConfirmSignupJob\nuser_id: 1\n	Couldn't find Spree::User with id=1\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:344:in `find_one'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:315:in `find_with_ids'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:107:in `find'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/querying.rb:5:in `find'\n/home/sm/prj/rails/spree/ofn_prod/app/jobs/confirm_signup_job.rb:3:in `perform'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:94:in `block in invoke_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:91:in `invoke_job'\n(eval):3:in `block in invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/newrelic_rpm-3.12.0.288/lib/new_relic/agent/instrumentation/controller_instrumentation.rb:352:in `perform_action_with_newrelic_trace'\n(eval):2:in `invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block (2 levels) in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/timeout.rb:69:in `timeout'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:198:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `block in reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:182:in `block in work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:146:in `block (4 levels) in start'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:145:in `block (3 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:144:in `block (2 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `loop'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `block in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `block (2 levels) in <class:ClearLocks>'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block (2 levels) in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:142:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:124:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:112:in `block in run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `block in start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call_as_daemon'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:269:in `start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:295:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/controller.rb:56:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:193:in `block in run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `catch_exceptions'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:192:in `run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:110:in `run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:91:in `block in daemonize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `daemonize'\nscript/delayed_job:5:in `<main>'	2015-11-05 13:25:18.070741	\N	\N	\N	\N	2015-10-16 01:42:02.7544	2015-11-01 17:15:37.073846
2	0	24	--- !ruby/struct:ConfirmSignupJob\nuser_id: 2\n	Couldn't find Spree::User with id=2\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:344:in `find_one'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:315:in `find_with_ids'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:107:in `find'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/querying.rb:5:in `find'\n/home/sm/prj/rails/spree/ofn_prod/app/jobs/confirm_signup_job.rb:3:in `perform'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:94:in `block in invoke_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:91:in `invoke_job'\n(eval):3:in `block in invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/newrelic_rpm-3.12.0.288/lib/new_relic/agent/instrumentation/controller_instrumentation.rb:352:in `perform_action_with_newrelic_trace'\n(eval):2:in `invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block (2 levels) in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/timeout.rb:69:in `timeout'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:198:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `block in reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:182:in `block in work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:146:in `block (4 levels) in start'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:145:in `block (3 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:144:in `block (2 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `loop'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `block in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `block (2 levels) in <class:ClearLocks>'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block (2 levels) in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:142:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:124:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:112:in `block in run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `block in start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call_as_daemon'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:269:in `start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:295:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/controller.rb:56:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:193:in `block in run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `catch_exceptions'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:192:in `run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:110:in `run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:91:in `block in daemonize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `daemonize'\nscript/delayed_job:5:in `<main>'	2015-11-05 13:25:18.143585	\N	\N	\N	\N	2015-10-16 01:42:21.947149	2015-11-01 17:15:37.146381
3	0	24	--- !ruby/struct:ConfirmSignupJob\nuser_id: 3\n	Couldn't find Spree::User with id=3\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:344:in `find_one'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:315:in `find_with_ids'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/relation/finder_methods.rb:107:in `find'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/activerecord-3.2.21/lib/active_record/querying.rb:5:in `find'\n/home/sm/prj/rails/spree/ofn_prod/app/jobs/confirm_signup_job.rb:3:in `perform'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:94:in `block in invoke_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/backend/base.rb:91:in `invoke_job'\n(eval):3:in `block in invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/newrelic_rpm-3.12.0.288/lib/new_relic/agent/instrumentation/controller_instrumentation.rb:352:in `perform_action_with_newrelic_trace'\n(eval):2:in `invoke_job_with_newrelic_transaction_trace'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block (2 levels) in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/timeout.rb:69:in `timeout'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:199:in `block in run'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:198:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `block in reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:275:in `reserve_and_run_one_job'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:182:in `block in work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:181:in `work_off'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:146:in `block (4 levels) in start'\n/home/sm/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/benchmark.rb:295:in `realtime'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:145:in `block (3 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:144:in `block (2 levels) in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `loop'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:143:in `block in start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/plugins/clear_locks.rb:7:in `block (2 levels) in <class:ClearLocks>'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block (2 levels) in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:61:in `block in initialize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:79:in `block in add'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:66:in `execute'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/lifecycle.rb:40:in `run_callbacks'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/worker.rb:142:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:124:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:112:in `block in run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:265:in `block in start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/daemonize.rb:84:in `call_as_daemon'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:269:in `start_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/application.rb:295:in `start'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/controller.rb:56:in `run'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:193:in `block in run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `call'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons/cmdline.rb:88:in `catch_exceptions'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/daemons-1.2.2/lib/daemons.rb:192:in `run_proc'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:110:in `run_process'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:91:in `block in daemonize'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `times'\n/home/sm/.rvm/gems/ruby-1.9.3-p551@ofn/gems/delayed_job-4.0.4/lib/delayed/command.rb:89:in `daemonize'\nscript/delayed_job:5:in `<main>'	2015-11-05 13:25:18.209441	\N	\N	\N	\N	2015-10-16 02:07:38.368614	2015-11-01 17:15:37.212178
\.


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('delayed_jobs_id_seq', 32, true);


--
-- Data for Name: distributors_payment_methods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY distributors_payment_methods (distributor_id, payment_method_id) FROM stdin;
4	1
4	2
\.


--
-- Data for Name: distributors_shipping_methods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY distributors_shipping_methods (id, distributor_id, shipping_method_id, created_at, updated_at) FROM stdin;
1	4	1	2015-10-23 13:01:53.739197	2015-10-23 13:01:53.739197
2	4	2	2015-10-23 13:03:53.421454	2015-10-23 13:03:53.421454
\.


--
-- Name: distributors_shipping_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('distributors_shipping_methods_id_seq', 2, true);


--
-- Data for Name: enterprise_fees; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_fees (id, enterprise_id, fee_type, name, created_at, updated_at, tax_category_id) FROM stdin;
1	4	admin	Admin Fee	2015-10-23 13:05:56.97358	2015-10-23 13:05:56.97358	1
\.


--
-- Name: enterprise_fees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprise_fees_id_seq', 1, true);


--
-- Data for Name: enterprise_groups; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_groups (id, name, on_front_page, "position", promo_image_file_name, promo_image_content_type, promo_image_file_size, promo_image_updated_at, description, long_description, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, address_id, email, website, facebook, instagram, linkedin, twitter, owner_id, permalink) FROM stdin;
\.


--
-- Data for Name: enterprise_groups_enterprises; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_groups_enterprises (enterprise_group_id, enterprise_id) FROM stdin;
\.


--
-- Name: enterprise_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprise_groups_id_seq', 1, false);


--
-- Data for Name: enterprise_relationship_permissions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_relationship_permissions (id, enterprise_relationship_id, name) FROM stdin;
1	1	add_to_order_cycle
2	1	manage_products
3	1	edit_profile
4	1	create_variant_overrides
5	2	add_to_order_cycle
6	2	manage_products
7	2	edit_profile
8	2	create_variant_overrides
\.


--
-- Name: enterprise_relationship_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprise_relationship_permissions_id_seq', 8, true);


--
-- Data for Name: enterprise_relationships; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_relationships (id, parent_id, child_id) FROM stdin;
1	3	3
2	4	4
\.


--
-- Name: enterprise_relationships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprise_relationships_id_seq', 2, true);


--
-- Data for Name: enterprise_roles; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprise_roles (id, user_id, enterprise_id) FROM stdin;
1	8	1
2	9	2
3	11	3
4	13	4
5	14	5
\.


--
-- Name: enterprise_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprise_roles_id_seq', 5, true);


--
-- Data for Name: enterprises; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY enterprises (id, name, description, long_description, is_primary_producer, contact, phone, email, website, twitter, abn, acn, address_id, pickup_times, next_collection_at, created_at, updated_at, distributor_info, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, promo_image_file_name, promo_image_content_type, promo_image_file_size, promo_image_updated_at, visible, facebook, instagram, linkedin, owner_id, sells, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, shop_trial_start_date, producer_profile_only, permalink, charges_sales_tax, origin_code) FROM stdin;
3	Joburg Best Produce Hub	A hub for the best produce and natural health products from Jozi		t	Jane Mackenzie	0834596208	info@janemackenzie.co.za			\N	\N	9	\N	\N	2015-10-16 06:24:49.32928	2015-10-23 13:28:32.364783	\N	OFN_ringlogo_black.png	image/png	14446	2015-10-16 06:26:49.177381	kale.jpg	image/jpeg	499262	2015-10-16 06:27:28.542974	t				11	any	\N	2015-10-16 12:58:08.189198	2015-10-16 06:24:49.328642	\N	2015-10-16 06:28:30.400647	f	joburg-best-produce-hub	f	\N
4	Dove House Organics	KZN Midlands premiere supplier of organic produce	"Our dream was to develop a small scale organic farm using permaculture design principles that would not only provide a healthy lifestyle and income for our family, but also become an inspirational education center where people could come and learn about permaculture and organic gardening / farming techniques. We also dreamed that our community would have easy access to organic health foods and products " -  Paul Duncan	t	Paul Duncan	084 292 4354	info@dovehouse.co.za	http://dovehouse.co.za/	\N	\N	\N	12	\N	\N	2015-10-23 12:37:29.333293	2015-10-23 13:11:48.754921	\N	logo.png	image/png	15787	2015-10-23 12:43:00.428738	01_n.jpg	image/jpeg	86862	2015-10-23 12:48:36.133427	t	https://www.facebook.com/dovehouse.organics	\N	\N	13	any	\N	2015-10-23 12:51:58.948288	2015-10-23 12:37:29.332699	\N	2015-10-23 12:53:56.077544	f	dove-house-organics	f	\N
5	Dargle Real Foods	A hub for produce from the Dargle Valley and surrounds	The Dargle valley in the KwaZulu-Natal Midlands is known for fine produce, magnificent scenery and friendly people. We supply only the finest naturally grown produce from ethical producers in the valley and surrounds.	t	Lawrence	0824983084	qholloi@gmail.com	\N	\N	\N	\N	15	\N	\N	2015-10-30 06:06:59.635423	2015-11-02 09:11:55.345464	\N	truffle_logo_180.png	image/png	40701	2015-10-30 06:09:26.496584	valley.jpg	image/jpeg	97672	2015-10-30 06:15:57.943379	t	\N	\N	\N	14	any	\N	2015-10-30 06:16:26.216042	2015-10-30 06:06:59.634827	\N	2015-11-02 09:11:55.263394	f	dargle-real-foods	f	\N
2	ofn2@ofn.ru			t	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru			\N	\N	6	\N	\N	2015-10-16 04:14:45.624136	2015-11-02 09:13:00.167795	\N	rescue_mode_or_reinstall_server.png	image/png	145276	2015-10-16 04:15:02.664471	\N	\N	\N	\N	f				9	none	\N	2015-10-16 04:15:32.8708	2015-10-16 04:14:45.623564	\N	\N	f	ofn2-ofn-ru	t	ofn2@ofn
1	ofn@ofn.ru	\N	\N	t	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	\N	\N	\N	\N	3	\N	\N	2015-10-16 03:29:12.649799	2015-11-02 09:13:15.848622	\N	rescue_mode_or_reinstall_server.png	image/png	145276	2015-10-16 03:29:28.501683	rescue_step1.png	image/png	124699	2015-10-16 03:29:39.795128	f	\N	\N	\N	8	none	\N	2015-10-16 04:08:33.82088	2015-10-16 03:29:12.649204	\N	\N	f	ofn-ofn-ru	t	ofn@ofn.ru
\.


--
-- Name: enterprises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('enterprises_id_seq', 5, true);


--
-- Data for Name: exchange_fees; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY exchange_fees (id, exchange_id, enterprise_fee_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: exchange_fees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('exchange_fees_id_seq', 1, false);


--
-- Data for Name: exchange_variants; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY exchange_variants (id, exchange_id, variant_id, created_at, updated_at) FROM stdin;
1	1	4	2015-10-23 13:15:01.005045	2015-10-23 13:15:01.005045
7	7	4	2015-10-23 13:22:44.143495	2015-10-23 13:22:44.143495
\.


--
-- Name: exchange_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('exchange_variants_id_seq', 7, true);


--
-- Data for Name: exchanges; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY exchanges (id, order_cycle_id, sender_id, receiver_id, payment_enterprise_id, pickup_time, pickup_instructions, created_at, updated_at, incoming) FROM stdin;
1	1	4	4	\N	\N	\N	2015-10-23 13:15:00.79697	2015-10-23 13:15:00.79697	t
7	1	4	4	\N	\N	\N	2015-10-23 13:22:44.138177	2015-10-23 13:22:44.138177	f
\.


--
-- Name: exchanges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('exchanges_id_seq', 7, true);


--
-- Data for Name: order_cycles; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY order_cycles (id, name, orders_open_at, orders_close_at, coordinator_id, created_at, updated_at) FROM stdin;
1	Wholesale	2015-10-21 22:00:00	2015-10-26 22:00:00	4	2015-10-23 13:15:00.660607	2015-10-23 13:23:46.630945
\.


--
-- Name: order_cycles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('order_cycles_id_seq', 6, true);


--
-- Data for Name: producer_properties; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY producer_properties (id, value, producer_id, property_id, "position", created_at, updated_at) FROM stdin;
\.


--
-- Name: producer_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('producer_properties_id_seq', 1, false);


--
-- Data for Name: product_distributions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY product_distributions (id, product_id, distributor_id, created_at, updated_at, enterprise_fee_id) FROM stdin;
\.


--
-- Name: product_distributions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('product_distributions_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY schema_migrations (version) FROM stdin;
20150929114254
20150122145607
20120629043043
20120327000561
20120802031147
20130207043039
20120327000613
20120327000625
20150730160010
20140723021733
20120327000558
20150410043302
20131128034556
20120327000622
20120327000655
20150619100137
20140613004344
20130809045637
20120327000607
20150424025907
20120913054660
20150508030522
20120408081918
20140324025840
20120409004831
20130629120645
20130207043554
20120327000582
20150527004427
20120327000562
20150605052516
20120327000585
20130207043036
20130806055125
20130629120643
20130629120640
20120327000654
20150508030521
20150719153732
20140604051248
20120327000593
20120327000639
20120919013335
20120327000609
20130729021924
20120520062060
20120327000617
20120520062059
20120327000564
20120327000587
20130207043546
20120327000627
20120913054657
20130809075103
20120327000615
20120702020402
20120327000620
20120327000583
20121009232513
20130814010857
20150202000203
20120327000640
20120327000667
20120629043647
20140516045323
20120327000632
20120327000621
20120407065132
20120913054658
20120327000612
20120327000656
20120327000574
20120327000571
20140522044009
20120327000581
20140723021731
20150916012814
20120425065453
20130629120637
20130207043542
20120327000653
20140110040238
20130807002915
20120327000552
20150719153136
20130207043040
20121125232613
20131024005253
20130207043047
20120327000605
20140723021732
20130207043549
20120327000597
20120327000579
20140723021730
20120327000584
20130207043552
20140828023619
20130801005801
20130130204355
20121031222403
20120327000629
20120327000663
20140723023713
20150115050935
20120327000662
20120327000603
20130629120633
20120327000554
20140425055718
20121018002907
20130629120635
20120327000570
20150701034055
20120327000602
20120327000626
20131030031125
20120327000567
20150407234739
20120327000651
20141022050659
20120327000661
20120327000591
20141003060622
20121005015852
20121028070200
20120327000595
20130801012854
20140402033428
20140927005043
20130118031610
20120327000599
20130207043555
20130912021938
20120626013846
20130805050109
20120327000601
20120327000588
20150424151117
20150305004846
20140904003026
20140430020639
20150121030627
20150508072454
20130919010513
20141113053004
20120327000611
20120327000628
20120327000666
20120327000645
20120618061537
20140204011203
20120327000556
20130207043042
20120327000630
20150225111538
20120913054659
20121010004400
20120327000589
20120327000633
20120327000636
20130207043046
20140116030500
20150219021742
20150604045725
20141210233407
20120327000647
20141010043405
20120327000553
20150220035501
20130629120636
20120327000580
20130812233634
20150612045544
20121031203807
20120327000631
20130207043553
20120327000657
20150508072938
20121025012233
20120327000624
20130629120639
20141023050324
20120327000635
20120327000652
20130207043544
20140815053659
20120327000560
20120327000608
20120327000594
20140927005000
20120327000578
20150916061809
20130805232516
20130912021553
20150225232938
20120629043042
20140716051214
20120520062061
20120327000638
20130629120638
20120327000634
20131016230055
20130207043043
20120327000575
20120629043648
20120327000559
20120327000619
20140514044959
20150115050936
20130629120644
20120629043045
20120327000618
20150626090338
20141219034321
20120327000573
20120327000555
20140825023227
20120327000569
20120327000572
20120327000641
20120327000637
20120327000557
20120327000604
20120327000566
20130207043550
20120327000598
20120327000665
20150422014819
20120327000592
20120327000616
20120327000660
20130426023034
20150603001843
20120621064227
20120327000664
20150216075336
20120422042134
20140621230121
20120626233350
20140815065014
20130830012138
20130207043044
20120327000642
20130207043038
20120327000565
20130807230834
20140702053145
20140402032034
20130207043041
20130207043541
20120327000649
20150508030524
20120327000576
20120327000586
20140612020206
20140516044750
20120327000623
20130207043547
20130629120634
20120327000563
20130207043545
20120327000658
20120327000577
20130729030515
20140121050239
20130207043548
20150619020711
20120429071654
20130629120641
20150508030520
20120327000606
20130629120642
20140516042552
20140826043521
20120327000596
20121115010717
20120327000659
20140213003443
20120327000644
20120327000614
20130207043037
20130807062657
20120327000600
20120327000643
20140522015012
20120327000568
20130207043543
20120327000590
20120327000648
20130207043551
20150508030523
20120331051742
20120327000650
20120327000610
20120327000646
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY sessions (id, session_id, data, created_at, updated_at) FROM stdin;
15	22cbcb5b04cb61f938ebe40e23619eb3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0VVBSblFzUDJraXR1c0lyQmNS\nZXE4eXEwaStwTVpHVEQzaFh6RWxHdW1nPQY7AEY=\n	2015-10-16 04:33:07.724016	2015-10-16 04:33:07.724016
14	46c02f1eda501bbadd8ca9656b427453	BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGYTQ2MUo1U2gyK1ZNdThGMnNX\nSGxnV0tFc2QyNUlMVEVaNnArTTBnYitRPQY7AEZJIhlzcHJlZV91c2VyX3Jl\ndHVybl90bwY7AEZJIgYvBjsARkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIu\na2V5BjsAVFsHWwZpDkkiGUpRejhtRzU0eUd0eVVZcGJZdFpWBjsARkkiDW9y\nZGVyX2lkBjsARmkI\n	2015-10-16 04:13:40.583502	2015-10-16 04:45:32.938008
16	0b9ea3877efd5afbc6236678b8fdb713	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjQUV2bENiV2pTaE9XNHh0cjVV\nZzJVd2ZDcVZKSE50OFpoY3pUQmJadkp3PQY7AEY=\n	2015-10-16 04:57:57.671799	2015-10-16 04:57:57.671799
17	328593922b122629814e2ec901080c5f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXK1hxMTlqeUM4dmsxNitIUERy\nMFBRQWptRlowWVdtM1JUdmFNbk1QUFFFPQY7AEY=\n	2015-10-16 05:13:22.332366	2015-10-16 05:13:22.332366
18	04fe762b9f1f4f29e5578d30de46e1a3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2THlhaGtMbUZ6MEx5cUxvdUY3\nQXV2M1I1Z0dSbHBrTzlSTXJSbEh2UWhNPQY7AEY=\n	2015-10-16 06:11:12.953151	2015-10-16 06:11:12.953151
19	b9facab7f3f494de345d8f524f1bd903	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoakNNSGsvUHdXbWVvclVsVTdS\nSW1WaS9WSTB6ZDhweTN0Y2EzODRJenhBPQY7AEY=\n	2015-10-16 06:11:13.656101	2015-10-16 06:11:13.656101
20	ef3b04d84abe7699ced27d909a8ad158	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3cGdGQjlMakVCVU9hZUtXbGVM\nRjVnbGZycnhOOUxTZldTaVZQRWpISDcwPQY7AEY=\n	2015-10-16 06:11:28.814267	2015-10-16 06:11:28.814267
27	10fc09116471f892589ab069016b8285	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjTE9YeHIwUWlESDE5L2h5Y3hl\nS2FuODhRZXo1d0I5dGdPUUVRZ3RqaGdZPQY7AEY=\n	2015-10-16 06:51:57.73678	2015-10-16 06:51:57.73678
28	51f5b50aa05213e579151759be46e0a7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQRHZzKzFIYUNTcEY0TGl2ai9v\nRzRONTNSKytWMkMzYVFySnljV3U2dUh3PQY7AEY=\n	2015-10-16 07:38:31.716831	2015-10-16 07:38:31.716831
29	e09d61f94c59ae79faec79509623a0ce	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkQVZBcWREWnF5Q3Z0UFNaZGhJ\nR1ZZaGVIOFh2NnlYUTdXRzdIWlVTUGhRPQY7AEY=\n	2015-10-16 08:24:37.12597	2015-10-16 08:24:37.12597
30	8371a06ad53d28a127dc3bc2b303e66d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTbDFTUHBsdlZuVWk4Nm1FN0hZ\nU0tlU0lKaGtJVHdkQ2pyOUt5dGJkQmlNPQY7AEY=\n	2015-10-16 09:20:33.09119	2015-10-16 09:20:33.09119
31	529ef2c34aec1fdd1e3b61b0186c4a63	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtMXBtS1pla0pRbWhvQ05MeVc2\nQ1FwSXVsQnk0MHJSdUdkVHZROUVDN1d3PQY7AEY=\n	2015-10-16 09:20:38.800763	2015-10-16 09:20:38.800763
32	41b7dd0a8db3d766534bb59d6083cd18	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtcTI4T0JUOTVzZDFtMFJJLzlK\nM0lYWkQzaERocXNPN0FwcVZTaUExdjNrPQY7AEY=\n	2015-10-16 09:41:04.484951	2015-10-16 09:41:04.484951
33	d69fd3c98656160c45a4a0277b0ab2c4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5YS80djYrTDlYSk12REZtZEpR\nOFA5akJXdVc0ajkxMHAwT3RkeTQwUVJVPQY7AEY=\n	2015-10-16 10:25:03.916141	2015-10-16 10:25:03.916141
35	890be6061455b2b8783a59f0081b157b	BAh7B0kiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUYiCy9hZG1pbkkiEF9j\nc3JmX3Rva2VuBjsARkkiMVlRRnZEL2wvZGZYek9OU1lidXdZZTNqTUxoaG92\nSkNaOGhkZlJTRmtRcnc9BjsARg==\n	2015-10-16 13:00:03.698405	2015-10-16 13:00:05.71566
8	8a10f6a41dbeb1e09b062d5766ad2afa	BAh7CEkiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUZJIgYvBjsARkkiH3dh\ncmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjsAVFsHWwZpDEkiGXlrcEREajFY\naEh0enBlekF3bTlXBjsARkkiEF9jc3JmX3Rva2VuBjsARkkiMVZuSzAwZWdY\nRk9SMGpnS1pKSHhVRklLUy9nM2NRaldheDg3ZlVORUxudFk9BjsARg==\n	2015-10-16 03:28:04.643711	2015-10-16 03:54:16.041575
37	af9d1a8013c3e79adbdf0c9aac9536ca	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFldEQvMlpERTVlRnpTS0JteFZh\nbC9vQldlalJjZTFJSjdCazhjdEFScE5NPQY7AEZJIh93YXJkZW4udXNlci5z\ncHJlZV91c2VyLmtleQY7AFRbB1sGaRBJIhl2ZWdTRWF5Skg5UWl6bVEycFhQ\nVwY7AEZJIg1vcmRlcl9pZAY7AEZpCg==\n	2015-10-16 13:04:10.368492	2015-10-16 13:04:22.302629
38	3ea92bf092e5494eb6efe021445f06e4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQdG9Td2NnRThzU3FWZ09iQ2Jh\nVlpJREN4OHcyV1hrVEo2VmdxK1FRTHhBPQY7AEY=\n	2015-10-16 13:26:34.77437	2015-10-16 13:26:34.77437
12	2cd76c44b6e81f160d1c246aee8f24e2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFISkRIT0RSSWpkUWxHaTNvcG5n\nYTlpY1A0UWNFOFRDVXhRc29zZjJidUE0PQY7AEY=\n	2015-10-16 03:56:43.97811	2015-10-16 03:56:43.97811
39	3f8c9031618f0f65ff853e0d1863b4ee	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrSERWVUZUai9jNXNYa0N0RDAx\nbjh3MnltT0dKODhlTzZ1Z2liM3Nka3dvPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVODMxY2NlMWUzYWY5NTg1ZQY7AFRJIg1vcmRlcl9pZAY7AEZpCw==\n	2015-10-16 16:06:24.001472	2015-10-16 16:13:39.030041
40	bcdb173814b40110e00bd8eea8ed4bdb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0dzM4di9seVl4Y0JubWNLNTlO\nczYyK3k4YmQ1VDJ1M2dBWVlmU09nR0FRPQY7AEY=\n	2015-10-16 18:35:44.233778	2015-10-16 18:35:44.233778
41	fbb35722f92fe249a2be1128cef369ce	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkaDJaUUVFc2NwVlAwV05ySGMz\nVG9jcUpEZGJQUkFOMFllRnlIMXV4dGg4PQY7AEY=\n	2015-10-16 18:36:07.358244	2015-10-16 18:36:07.358244
42	ec4e5ff72a515161273abbb51a598732	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuQ2NBTm9nN1NNVEhQdTRPaXl4\nYlZGcnZZckRtTklHbDZxMTlHOG8wVlh3PQY7AEY=\n	2015-10-16 18:36:12.812595	2015-10-16 18:36:12.812595
43	08c57e1c41a76818bce243ad8fe10003	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjT1AwNEtVMWFRcDR6WGNUUkow\nRjVsbVpGeHZKYjNmZWJVcVhZMWFXUy9ZPQY7AEY=\n	2015-10-16 18:36:15.577822	2015-10-16 18:36:15.577822
11	bbe097640057e3d0401676cbac24c9a9	BAh7CEkiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUZJIgYvBjsARkkiH3dh\ncmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjsAVFsHWwZpDEkiGXlrcEREajFY\naEh0enBlekF3bTlXBjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMXBhUUJrMVNY\nQ2FBTEdWZVRLQy9oWi96dm5PZmpCYVV2R2ROYnJFVW5yeGs9BjsARg==\n	2015-10-16 03:55:57.940365	2015-10-16 04:03:07.730419
44	68605f715d67f1a6f5ef65c85286a512	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2ckRpdytvYkpmYjZYZnJWcStJ\neEp3bmZmRlMySGJOK0M2UkhoSFNpbHhRPQY7AEY=\n	2015-10-16 18:36:19.013722	2015-10-16 18:36:19.013722
45	d94a992684f3399f4407b15cae77db8f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFteS82RFdIdW11WnFqZEpzNlY1\nMkZsbWEvZFVqSE1IRlovaWZrRzBjd1ZjPQY7AEY=\n	2015-10-16 20:28:14.387831	2015-10-16 20:28:14.387831
46	5cf34c59f8dc3dd1343698b72459b8d8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaRU1wOUtleEQ5NzNKZ2xVTnA4\nWnFac01KeUs3NElNbmRPVWZQcFRSRUhnPQY7AEY=\n	2015-10-16 20:36:46.189913	2015-10-16 20:36:46.189913
47	dada3646a6514977cedaa59e2c873477	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2SnRXUFZFQXpJdHdjZ1hJaG0w\nRk9GNG1DQndOUzNPS0l3WW1QTHJQYzFZPQY7AEY=\n	2015-10-16 21:02:27.703419	2015-10-16 21:02:28.761055
48	1f5932d1e41ea82a1359fd84d1d1db5f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjZkdZQ0pVVEluMmVQUHVhN3lV\nNi9lVHMvS0k2TFFiRWYxN01rcFROeFdZPQY7AEY=\n	2015-10-16 22:41:56.536735	2015-10-16 22:41:56.536735
49	819a0e4db0970f078e04ef0dd21b3003	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTUzhWc1c1TTc3YmVLOHE0b2Vo\nakpjaE5lNnR0RFUzOFVYaHJRbEJDbC9VPQY7AEY=\n	2015-10-17 00:05:09.546282	2015-10-17 00:05:09.546282
50	3d4b58a663f24b024cdefa7586eef207	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZRGRwbzJ3ZUpWUmFTb1VzWGNF\nNXhOamFvOWxBTFNMbW1ON1lES3QxQUxBPQY7AEY=\n	2015-10-17 00:25:53.290134	2015-10-17 00:25:53.290134
51	98ddd2a86038e42ccbfd73f66a507a6f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkck9WUFFsbG51RXBraktLN3J2\nVWZCcWF0MG9DWHF3b0tVOWNneVY1RTJJPQY7AEY=\n	2015-10-17 00:25:54.9712	2015-10-17 00:25:54.9712
52	0685a2818b400bd5227b2e5d6ca051dd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0Ky9WU3pYbWtrRDlGdEREdWRB\nMm5WR3I5TTh2VHByZWd5TzdadDVTRi9jPQY7AEY=\n	2015-10-17 00:26:01.301749	2015-10-17 00:26:01.301749
53	be798ee6390124556d4dca9c779a4631	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5cUczMkF2ZE9pQkVOY2FjOWtP\na1k3RDNtTEs1K0ljVmxSakZEN1lVTWxRPQY7AEY=\n	2015-10-17 03:26:06.839505	2015-10-17 03:26:06.839505
54	4189abaca959750b4a47fc858770ae26	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIbi9JdmdtNjQ0SEFuUnJjenRP\nVlB2OXZPSEZlN2JhdWROenlzVTU1dDNBPQY7AEY=\n	2015-10-17 04:52:49.563699	2015-10-17 04:52:49.563699
26	e95fa32f81aaf0e74bf75c442af87f89	BAh7CEkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQxJ\nIhl5a3BERGoxWGhIdHpwZXpBd205VwY7AFRJIhlzcHJlZV91c2VyX3JldHVy\nbl90bwY7AEZJIgYvBjsARkkiEF9jc3JmX3Rva2VuBjsARkkiMXZpYUVNODBR\nalF1a1ZyWlBSejhIaFFVa1BWdkJtd0dwempqM1c1OFk0Sjg9BjsARg==\n	2015-10-16 06:32:51.905734	2015-10-16 06:40:59.853401
55	0cc8c5bc51b68123a5311e6aa0450d2f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzSXZZT0luNm9xZ3NKWUh5Tjd0\nMFhhSm5CSGlpV3MvVC9FbW1WNWVjVEV3PQY7AEY=\n	2015-10-17 05:28:47.371327	2015-10-17 05:28:47.371327
56	e0a16671cb2be1113634507b9215cfe8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZUDRwa0JOangwU3I1RXNQMUdk\nZTJqZktVQmVqZVh0RzlpT0xwSHlKT1ZjPQY7AEY=\n	2015-10-17 06:38:08.494885	2015-10-17 06:38:08.494885
57	2e4fd08bd984c9a33cd346edb43eaec3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0SHc1dGUybDFmdGlFT3hpRHZq\nN0c1K0wwOWlBKzZ5cG8rQUwrNnd3WVJnPQY7AEY=\n	2015-10-17 08:08:29.509604	2015-10-17 08:08:29.509604
58	b063641a3542b6b23991e5f2baf4e849	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGZmk2WGhwODBteFRvWEh3ZUp0\nd1g1OGgrTXA4RkZWb3hweGx6ZkRxOVRFPQY7AEY=\n	2015-10-17 10:24:30.549104	2015-10-17 10:24:30.549104
59	3942321287fc4c2dec8b5d4cccc1d2b0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzS292YXZvV0pJUjhPaHo0Y2tX\nRVpNWFFlYWFzTTg5YTZSSTJ6Z3FSSjd3PQY7AEY=\n	2015-10-17 11:07:28.845774	2015-10-17 11:07:28.845774
60	aaeb4f24d0ad24c51feb93769f41dbb0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwK0FpK3NlOWtXUitSYVl1TXJ0\nWis2RDlVeG8zQzF5T3l2WGlOcjhzOHZNPQY7AEY=\n	2015-10-17 11:26:34.128092	2015-10-17 11:26:34.128092
61	d76360e9967add2f1f499f3002480d5d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCc2NCNHNhaFJLVWwxUjdNdlNN\nZTJsL053Tk5HUzhMSHFQVDh4NW52cGs0PQY7AEY=\n	2015-10-17 11:26:35.680608	2015-10-17 11:26:35.680608
62	3d84b71c8499af9c59e70ac2de7938d0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5WFRGaTRlc2NCQ01mNzdTZEE1\nbGVYKzMzZnA3ajVRTndoV0NoNHY0UExrPQY7AEY=\n	2015-10-17 12:22:49.144708	2015-10-17 12:22:49.144708
63	360929f0fbe9ab26327862d916f7e6a2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIQ2wvMXUzWXVsbW1PK01KNG1v\naXFxRWY0aFlEU0xDTk5FdWM4a1pQcUU0PQY7AEY=\n	2015-10-17 13:04:49.249965	2015-10-17 13:04:49.249965
64	90157b3c79fc6d8e2fcce49ec65ef199	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlUmJGVjBqbGQrZGYxWE8wYXRp\nUjBiV2ovQThPUUlsakp4d3BJb2IzQk00PQY7AEY=\n	2015-10-17 13:30:27.279036	2015-10-17 13:30:27.279036
65	aac153ad2b2174d2e0af109a2e69cb3d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkbCtLVkIwYWFWYnZ6QWxYdzI5\namxVc1dCYkc3eWYxdTlZRGJ5S2dOcG1jPQY7AEY=\n	2015-10-17 13:30:30.439081	2015-10-17 13:30:30.439081
66	a50152f5cb8a20620e8068449fccbb62	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3OUk2anhJUngzZlZkaFR4VEln\nSDFvcGFJa2tGOGdnNWM0VUZvZzA4cnNvPQY7AEY=\n	2015-10-17 14:52:19.682858	2015-10-17 14:52:19.682858
67	4bb13fac6ce7c205b440c598f202547b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExR3N4cTNFRGhLL0RDVDJ3U2JZ\nSjdFa3VWT2MveEZydGhTOTdOcTRKTmV3PQY7AEY=\n	2015-10-17 17:39:08.748061	2015-10-17 17:39:08.748061
68	104a9e05fa693b1559a47ef05b6a3763	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWS1Z2SDFUWjRxV1JqK3RXQm5W\nRVg0amJOV2NSWjAvQ0ZjRkhxbVZZaDJBPQY7AEY=\n	2015-10-17 23:29:28.482246	2015-10-17 23:29:28.482246
69	4f472136eb30efd59ccee93c34ff684a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4VVUyUzR6WmxDajc5WlVUZ0RI\nOVRyWUlFeTNXQThrbE5PcTZDaWRuS0xJPQY7AEY=\n	2015-10-18 02:34:37.422212	2015-10-18 02:34:37.422212
70	23a738acefca5f3c5dda3cbe093fadd7	BAh7B0kiEF9jc3JmX3Rva2VuBjoGRUZJIjFNYVRic3BIMGNVRW1IV0s3UHpZ\nYlA1YnZSdVh1cXdyeXNFZUJPWnBIT2owPQY7AEZJIhlzcHJlZV91c2VyX3Jl\ndHVybl90bwY7AEZJIgYvBjsARg==\n	2015-10-18 04:20:58.522615	2015-10-18 04:26:20.15777
71	52ecc01819279ff8b700151245e3a99f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIZlA4SmlqV1Vuemd6N1B4VE1a\nRjQycTNrSVF0VVF4UmMwWEVqOVo2aFVjPQY7AEY=\n	2015-10-18 04:30:15.403533	2015-10-18 04:30:15.403533
73	9ba910ea381b9e7ace60fb5a0f980cd4	BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaR2hnS3pia2U5WnpXd2RtWEs0\nUG5Senl3SEFOZ3RiREJ2MzJpWWdEcnpZPQY7AEZJIhlzcHJlZV91c2VyX3Jl\ndHVybl90bwY7AEZJIgYvBjsARkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIu\na2V5BjsAVFsHWwZpEUkiGUhZeEV1TUp6Vk5wc3Z5bktTRGdLBjsARkkiDW9y\nZGVyX2lkBjsARmkM\n	2015-10-18 04:30:33.906005	2015-10-18 04:30:41.787475
74	7a52b52624aa436e60175c8798831ecd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjNWM2SWFqNlhJVUdKNkpHV2ZW\nVkk5Nm4yK3I5UDMreUY2cy81RU81ZFp3PQY7AEY=\n	2015-10-18 07:05:08.218383	2015-10-18 07:05:08.218383
75	1ffcc0932bf77c505bd766e7cb9e20b7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQOGlUYXc4Yk53SEFDcjN6R2ts\ncUtwa0ZYU2tVRjJKaGZ5djNHZXRLaVpJPQY7AEY=\n	2015-10-18 07:15:50.40183	2015-10-18 07:15:50.40183
76	6fc7c1c39f2c2ec552efff4ef94b865e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFUzA4VmVCQ2VXSXJDUmJmZmFm\nUWJWRmEyckhQTDBacHNrWmlOOUR0M0dzPQY7AEY=\n	2015-10-18 07:15:52.347431	2015-10-18 07:15:52.347431
77	73ea273f023ed5272c38788901836c9b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvNC9jYjNicS9sUUdiTUYwVm5V\ndGtVdVd3NWF3WkMzZnVDWE1UQXhZNFZ3PQY7AEY=\n	2015-10-18 07:46:28.89334	2015-10-18 07:46:28.89334
78	2a0f9485fbdf0f2175c508b23792d279	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxS1ZySm9BTWlkbWRMa3FjcFhJ\nV2RzdFg2YVBXamdLNm9Hb3JqZml2WWRBPQY7AEY=\n	2015-10-18 07:55:45.636947	2015-10-18 07:55:45.636947
79	ff1e78177d42b1bcf14383deac532f81	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLaVFlbGlHZHVuT3pRclJod3h4\nZ0UyMUZESGlXRmFTTUJZd1p0WXhnQnZBPQY7AEY=\n	2015-10-18 09:26:37.910108	2015-10-18 09:26:37.910108
80	587ca781768d82b37524849d357e1d3f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUZVRRdk56RnNNWEUxbFZuWlpH\nWGR1MWlhbzk5MmhaeU9GbnlrdDBRa1dZPQY7AEY=\n	2015-10-18 09:29:22.082765	2015-10-18 09:29:22.082765
81	ec8bffddce53d95c34feff614bab2fdc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFaDYzNUhIK3QxdERYaUdTWjhu\nK1Vud2RwUnVNaFFJbHZyUHErZDVVZyt3PQY7AEY=\n	2015-10-18 09:29:24.971883	2015-10-18 09:29:24.971883
82	bf9cc0c8f76646aa60054c00b605eaf4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsWW5DTUgwdHpTQmpzK3h6Vy9Z\nRzlyNXBDRG1qQWVqSXRxaGU4SmlTL1M4PQY7AEY=\n	2015-10-18 10:49:58.741958	2015-10-18 10:49:58.741958
83	44b86665a7b9d4369a6876b58ffb70d4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3MGxSclJXOVo5SDlyTTlWNzVN\ndk51YUFLMTYyY1Bxa3lqd3FJLzlOYmhJPQY7AEY=\n	2015-10-18 12:31:05.076866	2015-10-18 12:31:05.076866
84	e9d7036af92c51ef253552d6b33cd5ba	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwN1cwMnVlTUE3RlVkYlFPSW82\nWGlUTHlFZmJxLy9WT3hqOTJEVTV6SThBPQY7AEY=\n	2015-10-18 12:39:08.09326	2015-10-18 12:39:08.09326
85	52079d8fb433d10b79d5ec86bd09ff87	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzV3AxSEdaZllXMlRzVmlnVU9t\nRXZ6TnQwbitaOHUwbnozQm1FRkFCd2NnPQY7AEY=\n	2015-10-18 13:20:39.842774	2015-10-18 13:20:39.842774
87	234641af105588f400dcffeb10d35e4b	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiWG1JQlY4NGtONng0c21pUVVG\nT3M5YXltdDBsQ0NrcXFrLzVSeUVlNzM0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVYjJmZjYyOGNiMzY2ZTI0YQY7AFRJIg1vcmRlcl9pZAY7AEZpDQ==\n	2015-10-18 14:00:56.845802	2015-10-18 14:02:15.536144
88	7cd34f667ffd7b294210e062eb00dc4a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkSnJ1TEszOTRPYnY1ZGIrREhE\nK2R6SldOa0JoTXJucEVxRVl3SGNWZlowPQY7AEY=\n	2015-10-18 14:03:28.706419	2015-10-18 14:03:28.706419
89	9e3178d174c5c7d50d4f7d684be9c3cc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHaS9CbDdkOVZydS9Fd3AxWDhY\nVHAxaEdRRTBKbFowdDZ6V1BHSkVaTUtnPQY7AEY=\n	2015-10-18 14:07:20.477148	2015-10-18 14:07:20.477148
90	038ac1c94c73d07cd5e1a4349b8405df	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnby9rbWx3a1cyNkwwQXlRVEJ2\nb0VDeEhucldGYTJmSEt1V0lNZXM5VnZnPQY7AEY=\n	2015-10-18 14:08:23.380963	2015-10-18 14:08:23.380963
86	8411565cd2ffd3a6936399d5eff842cb	BAh7CEkiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUZJIgYvBjsARkkiH3dh\ncmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjsAVFsHWwZpDEkiGXlrcEREajFY\naEh0enBlekF3bTlXBjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMWdDQm9XeG9E\ndWJXUW1nWlcvN0tPcmRXNzlhZEloZFZIbUpVSjVYZHBKNTA9BjsARg==\n	2015-10-18 13:48:38.738725	2015-10-18 14:10:41.47318
91	526b9f17b62e2e2bf6a7d96b68989098	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDTGZWYkd5ZDV4WHoyT3Z3MWth\nTjVCbWd0R3Jvc3VxRWxPNFQ2SUpTNmtRPQY7AEY=\n	2015-10-18 14:19:46.363214	2015-10-18 14:19:46.363214
92	642dce8d0f261d00deafede66ebeb86f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4cFdBSW4vd1F3d0llYTBuQkNs\neUluRnVXbUxqTFY2MWhyLy81NURKVTJjPQY7AEY=\n	2015-10-18 15:07:27.787997	2015-10-18 15:07:27.787997
93	91cff86b9f17b018ba4967318737f0d4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrd2V4NCtGRHU5amhRdmhBWVUx\nV0h4QkEwZzFuelFsbG1XbnByUHA1MEEwPQY7AEY=\n	2015-10-18 15:17:40.435347	2015-10-18 15:17:40.435347
94	eef50ef29efc2336c89609849a3eaf9b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3d0dKZDhDMDB2VGthQmhmZGpS\ncHNhREgydGpTZG8vUGljd21BNDM2VXUwPQY7AEY=\n	2015-10-18 15:21:37.186846	2015-10-18 15:21:37.186846
95	07ebda40c5da5843186447f95016b2d7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhaC94L2tlSWFDbHRwVnVrY1c5\nT2pkRDRicU1abWtLVnUreXhxQTlPV3BrPQY7AEY=\n	2015-10-18 15:22:19.925679	2015-10-18 15:22:19.925679
96	e2b4d88063e9711b8bee572fa479d84c	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRZS9tS3d6eTVkN2JlamY5NWw0\nUjNWd3lCYVJhdXV2K2R2cmpqMTR6UGNFPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNDdmMjAwN2NhMzA0MjE4MgY7AFRJIg1vcmRlcl9pZAY7AEZpDg==\n	2015-10-18 15:24:41.804486	2015-10-18 15:27:37.294143
97	ee5c74e77914711711af6aa80b56086f	BAh7CEkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaRFJ\nIhlIWXhFdU1KelZOcHN2eW5LU0RnSwY7AFRJIg1vcmRlcl9pZAY7AEZpDEki\nEF9jc3JmX3Rva2VuBjsARkkiMTVIYnFEektHN1l6T1p2bE44V0pDNUpCUUxl\nV3VhZGdIdmNLaXRmS0lLZUU9BjsARg==\n	2015-10-18 15:36:10.37339	2015-10-18 15:36:10.37339
98	b1f742bbf07d7fc71878982335519681	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5TGpIOTJyMy9xcE8rME5oYlhG\nd0h5V1MzOFhXK1dQdFN2UEtVRkhwdXBvPQY7AEY=\n	2015-10-18 15:43:27.193441	2015-10-18 15:43:27.193441
99	76de315364a00d88be60979d14781159	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1cHJtZUNCUFhjY0ZlQ1JzcnE5\nYUFPYktKR0pCWVNQRXVkUlZjdHpackY0PQY7AEY=\n	2015-10-18 15:44:25.575948	2015-10-18 15:44:25.575948
100	b4b451bbc6dc08c6b7de60a8faf70c79	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVNWE3Y2Q2ODJjNjIxZjdhYQY7\nAFRJIg1vcmRlcl9pZAY7AEZpD0kiEF9jc3JmX3Rva2VuBjsARkkiMXRqL2hr\nL0J1QnMrTUxpcXkyM09ReUJKakRtcmY4dHRaVlg4bkRkcnlmNWs9BjsARg==\n	2015-10-18 15:53:42.133534	2015-10-18 15:53:42.133534
101	aa0daf4c34d64bee2f6ee2c43b347828	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0WGQ5V3VjQzVPUUdNMVhWUzdP\nUG9jNDJmTXRRcDhiREZBY1VRN3ZlYkRZPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVYTk2NzMyNDM4NWIyZTc1ZgY7AFRJIg1vcmRlcl9pZAY7AEZpEA==\n	2015-10-18 16:01:51.351696	2015-10-18 16:03:45.629817
102	4aad61c1ee528c2602da7c2a7db5c7f4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqNWN5ais1aXdMd3dhSmFrelZC\nNGhPRi81dys3ZnpxdlpHTUI3RVpSRWxRPQY7AEY=\n	2015-10-18 16:11:29.156503	2015-10-18 16:11:29.156503
103	ebd57d839cf58d6c6f2f7ecbac2c4098	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhRHdzcG8yV3psejE2dmoyOU5r\nQ3JRZDhubVA0REx4MTFuZXRUUnB6VWpRPQY7AEY=\n	2015-10-18 16:23:49.294611	2015-10-18 16:23:49.294611
104	b1320764127b91ad4f9003638f38791a	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2OVBuaDNhSWg0V09NbXltcSt0\nZEcreEQrWGQwUFl3bnZraW16cnAxTTBJPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVOGEzOTAwMWY5MmFhZTU0MwY7AFRJIg1vcmRlcl9pZAY7AEZpEQ==\n	2015-10-18 16:35:37.351565	2015-10-18 16:37:10.512757
105	bbf0911980284b06240e1fb440d59d8c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzcjJHZUlOVnVNcUdVY0xtUzRk\nRXBYUU5nMWJaSWVLSlpBMndVdGs3TzNBPQY7AEY=\n	2015-10-18 16:48:34.255651	2015-10-18 16:48:34.255651
106	ebebc7423eb5a8d80e0f0736e3e03708	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFibTlzbmtGTEFXVkc3UUltVFhu\nQ0QrcURweTZxSWwzVWRvcTNybTV1azVBPQY7AEY=\n	2015-10-18 16:58:01.972677	2015-10-18 16:58:01.972677
107	ef3244b76d4d5734f29f3c7c17257fd9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGTHlhY1I2ZWI0VDd4bnMyRzBk\nNkJFbUZ4ampPL3BMV2tkMVNGU2MzYUpjPQY7AEY=\n	2015-10-18 17:30:08.487908	2015-10-18 17:30:08.487908
108	82e2fced86e9e0f67bd9fb5061c9d43f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvVVNjcklyUVc3OXhsdkRmYkVV\nVGgrNVl1ZGJmc1Q2N1FnTEVac1NLQUN3PQY7AEY=\n	2015-10-18 17:37:45.463328	2015-10-18 17:37:45.463328
109	435f8db5b019e01b55910e59c1c786e5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxUmlpcGZBVWJEWjZTRlRldUJQ\nUXhLN3hWUnRIOUF3KzlleG9hRXlhN01jPQY7AEY=\n	2015-10-18 18:45:24.659754	2015-10-18 18:45:24.659754
111	585415e1425bffa1ac0f08d924452798	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF1S2ROWnRieURTVlZ5UFU4NTNm\nRGQxNS8xNmxpcUNxY0V3djJPVk9tbno4PQY7AEY=\n	2015-10-18 19:03:38.214438	2015-10-18 19:03:38.214438
110	df48b45b92ba2bb48c0604f7491221c1	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvVTdoNERSUVorRlhmNTAxOG5O\neVF2aTNvYTRDT0RuNnd1TktOaVJzVVo0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVYmZhMTk4ZDU5YWJiZWNkYQY7AFRJIg1vcmRlcl9pZAY7AEZpEg==\n	2015-10-18 18:48:46.866556	2015-10-18 19:07:30.915866
112	4c4a036522222d044a51051db6b71515	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQQ0tNQVFReE1Xc2JoNTkyNkhl\nWG1SaXRTR200OVh4QTB3dW1ETmtGMndZPQY7AEY=\n	2015-10-18 20:12:26.186281	2015-10-18 20:12:26.186281
113	16bc6cc10e72ecfbc333eb161e065edb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5dWwzN3dYVWI0WllYdGNvaGhi\nbnI5SjJaK3B3emR6TTRURzFkMkpVRXVvPQY7AEY=\n	2015-10-18 20:12:31.863513	2015-10-18 20:12:31.863513
114	e84f557d2084c7115fe23a0e059c33a8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXd3BXMnJLMzRPTEpMVlFCZFJH\nYTJzK3kvR3hqTk1NR1Z0WEY4WUJpSVIwPQY7AEY=\n	2015-10-18 20:12:37.716169	2015-10-18 20:12:37.716169
115	2b2d4b6b802c5fe3efb772f31a2ebd0b	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVNmExMjMwYTMwNjkzYzcwNwY7\nAFRJIg1vcmRlcl9pZAY7AEZpE0kiEF9jc3JmX3Rva2VuBjsARkkiMWlrZlR3\nWTRkUkZZVVpQcGNsa0lLQ0RJRk1zMHl3bXRrMUhmbS85eUJqWTA9BjsARg==\n	2015-10-18 20:21:02.530346	2015-10-18 20:21:02.530346
116	20cfbb2080dcb9f91215e786aa18e4db	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3akpNd3FwUFUzQWRDeWhjN2l6\nZVg2NTVZaUtFUG1TemttY0VPeHpBdnpzPQY7AEY=\n	2015-10-19 00:09:52.605097	2015-10-19 00:09:52.605097
117	a8c18408583f50f6310d84b99ad46d01	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6aXdrNkFXMFVOZlFLNnpJS1gv\nY0F0cnFXMG5ZL1JNdzFjZjd5c3N4TlBrPQY7AEY=\n	2015-10-19 00:43:15.812149	2015-10-19 00:43:15.812149
118	e7b1d9526834edb6a3a2c461ffe945c3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6UHdXSUx5UVJJMFRrOUdtZm1v\ncEI0bHlHR3pTOXNUNWNnMUVPVVVHRkFzPQY7AEY=\n	2015-10-19 02:07:32.648124	2015-10-19 02:07:32.648124
119	7e0f9cd7367b4692529d36a969bf42e1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsLzg5V0dtOTBTR0MxY2JoNWlM\nMkMzdmxjd0dJVmxiR2hrUXl4WmpaanNJPQY7AEY=\n	2015-10-19 03:40:17.125898	2015-10-19 03:40:17.125898
120	e3440d7d61a5f2b489c0b6c9f7dcaba3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4bDdLVWY2NDh3OGoyTU5ZYjA5\naVpkV3ZKVDJFL3FuOW9VeVIycVovUFhVPQY7AEY=\n	2015-10-19 04:09:56.528726	2015-10-19 04:09:56.528726
121	50ecbd3265d65627634430547df949bb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlQk5hbk04UzVKYmJrcTBUeG92\nZXBVVkZYb3MwUVFUQkdoMm9vRjBIak5vPQY7AEY=\n	2015-10-19 04:58:13.967722	2015-10-19 04:58:13.967722
122	3433ea223dee04b2bdcafe0b33747f5d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyeDE1SW9mNHJWSFk2bkl3ZFdU\nSnZROWdsQ3VVOUVVQjVmQ3BvdnE3YmRjPQY7AEY=\n	2015-10-19 05:44:10.96691	2015-10-19 05:44:10.96691
123	330d8a09b1fd24e2e727a7eb178feaff	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQTTVQVEVsVU9MVUdsYWJNOEZ6\nOFE2VERkeEEwclRlUUFOaTEwR250ZVN3PQY7AEY=\n	2015-10-19 06:26:21.698546	2015-10-19 06:26:21.698546
124	bcc9dc1c1515e86c11b94b7c3d86593f	BAh7B0kiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQxJ\nIhl5a3BERGoxWGhIdHpwZXpBd205VwY7AFRJIhBfY3NyZl90b2tlbgY7AEZJ\nIjF3OFgvMDdZa0d1N3NWWElQK1lxOXVrYVJWUzdrdzZBZFZNV1JIWndzeGJj\nPQY7AEY=\n	2015-10-19 06:35:59.913209	2015-10-19 06:44:18.227118
125	67ed8c8c9e6084637341e7ed1459d8ef	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzdU9jbDRIT3FJSyt4MXZNcE5U\nSnpxRW1xK2RQWHY3UUpJdWp1UEN2d1FvPQY7AEY=\n	2015-10-19 08:13:23.709629	2015-10-19 08:13:23.709629
126	bf39ef380dd8882d34df3049f4f532c5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsY1JHSUtZUXFOWlJIZ1cxVEM5\nQ1BaQmRpWG1YWldWcjE2YW5aaFBQV0lJPQY7AEY=\n	2015-10-19 09:05:30.415933	2015-10-19 09:05:30.415933
127	913abe3778fb2260fdca86c8644c4efc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0a2xnTVhUakNEQTNHZ3VIVWYx\nTHo5OXVFUkw2dTVCZitHNEgwS0w0cHpjPQY7AEY=\n	2015-10-19 09:43:37.203508	2015-10-19 09:43:37.203508
128	fec609020f19cd4fffcf65b50d3a3534	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjErR0p0SFhrc0dKMDZKNlM0WHNU\neVZob2hrdGgyaDJGQWE4US9wSWZBTzkwPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNDc3OTE4NDliZjU3Y2I3NAY7AFRJIg1vcmRlcl9pZAY7AEZpFA==\n	2015-10-19 09:50:20.27695	2015-10-19 09:54:37.283434
129	10549f40ca39833770756c9420b3015f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsTG9zUlZBb05aWE1ndU42cEUr\nZWgzbWZNckJYUTl6ZTBjck10b0sxcU1BPQY7AEY=\n	2015-10-19 10:09:13.41307	2015-10-19 10:09:13.41307
130	864dcb8c2c7e6f5754fce9380c35311a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlL0ptczVYRzNIcDYzWHB0RDFr\naHJwVVFmWEpUaE9IMzYzV1M2eDQ4TFpJPQY7AEY=\n	2015-10-19 11:41:16.713518	2015-10-19 11:41:16.713518
131	47752279af3c123556817e493a2d0e12	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTdkt1alJ3NjZnY3VsOE90eXJr\nWTdPcDBwK1dFMGxRenZTTSsxTzlIRUJ3PQY7AEY=\n	2015-10-19 13:14:49.313515	2015-10-19 13:14:49.313515
132	4b0443d522972a7d54eb6fba61f5bd8b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmYTg4MnBpYnhjQlBMK0FwSkNt\nb1dIcHNhYU1sOXlDZEIvWTBKZmtXTUowPQY7AEY=\n	2015-10-19 13:46:06.848015	2015-10-19 13:46:06.848015
133	e502c9bb263fe75c048fda76443a7638	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1M3Y0OGtPVmhvd2poUVhhNCta\nN2J5WjN1b21vN1ZFTFpnTjFpWE5sWDY0PQY7AEY=\n	2015-10-19 13:55:04.017234	2015-10-19 13:55:04.017234
134	742312e9b9544ee956e087387142bb04	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRQXQvY1ZiYm5GM1U1RzIxbGRS\ncVRLbWxQamQxTWk2dUhLakJXQmg5WTJVPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVN2I4OTA2YWZkNDIwODQ1MgY7AFRJIg1vcmRlcl9pZAY7AEZpFQ==\n	2015-10-19 14:23:06.211021	2015-10-19 14:32:17.348143
135	6be7f1f6472ad4082621018cc68efa6e	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVMWExODRmNTRjYWUyMmM4NwY7\nAFRJIg1vcmRlcl9pZAY7AEZpFkkiEF9jc3JmX3Rva2VuBjsARkkiMW13QlBO\nVVY3NWZ6ekthS1kyUnU1aXJvUzBkMmhzeGVjMmFlS3NvSDliQlU9BjsARg==\n	2015-10-19 16:38:36.023828	2015-10-19 16:38:36.023828
136	dae0efd9612bd41ef50fcbd39ad57082	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhODM2MnA1ZmV3QlFKWlY3aXlR\neXFHVkVDck9zTHUxc2Vub2dmK0YzVUEwPQY7AEY=\n	2015-10-19 17:26:09.492852	2015-10-19 17:26:09.492852
137	52d2407ad5063e9437e5ebc2ab4bba31	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQUEtqV1NaelZHVUk1d0wwblN2\nMW1RYlhWZis4OFkzYUpHQlZLZXBLdWxrPQY7AEY=\n	2015-10-19 17:49:36.89799	2015-10-19 17:49:36.89799
138	6cefd0e42ac20efe4bb4d6ce4683d005	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSY3NkLzJVTzhpNzFzNGtPeC9y\nKzFXUUY4VlVyTkh3ejBySjVKYWpmSHlZPQY7AEY=\n	2015-10-19 19:19:56.275268	2015-10-19 19:19:56.275268
139	7a4bc571e163ccc906c77af927531ca8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTN0xWWGdSNjN5TCs1bFRqNG5k\nT3ZpbmtqaEtyd1ZxNXpGSEMxWElEaCs0PQY7AEY=\n	2015-10-19 19:32:55.681145	2015-10-19 19:32:55.681145
140	9592066310437faf6d8deba6d049035c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUWW9kZm1wcUs0ZkJqWXdpK1Qr\ncnFhencrd3FJSGdxMU5EaU55dWFYOFc4PQY7AEY=\n	2015-10-19 21:09:19.931022	2015-10-19 21:09:19.931022
141	a3af27a236ab6b94e8cbcc547585c219	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyaHI1Q0dMYVdraUF3QzZRdmNE\namg5SEgwdGRzRDdqMUxQY0xJSXB6YWU0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNzhjYzk3ZWE4YTZjM2FlOQY7AFRJIg1vcmRlcl9pZAY7AEZpFw==\n	2015-10-19 21:26:07.585735	2015-10-19 21:26:46.498631
142	d3c579801ee5ac390f7cbea406853077	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFcEhGUHJJWkovZ1hrbzBJSEpO\nRmd5ZmE2MzhjclRPcWprZ0JXQVdHTnJjPQY7AEY=\n	2015-10-19 21:49:04.884897	2015-10-19 21:49:04.884897
143	5159a2b222c9c79a06b6dee775e37e81	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZeHRoMmI2U1I1L1piajQ5aUtM\nTVlxaUdVN0h3NDNoVUZLM1dEOXhTcWVZPQY7AEY=\n	2015-10-20 01:57:42.948073	2015-10-20 01:57:42.948073
144	54a2f6ff83c592d012eb199fce22d02d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExL3hlRklPQldTa3JyRXR0NFo2\nZnZMTExLKzFZT0tzako4ZmNKem1ob2lZPQY7AEY=\n	2015-10-20 04:33:54.767106	2015-10-20 04:33:54.767106
145	c3f7a67cf7eef19ff614cd03c822fe7f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzU1JMN2dJSUFNUjFXU1poQ3Bo\nenUvS2FDMzREY1o5UFExWDUyQUtDQUdBPQY7AEY=\n	2015-10-20 04:34:18.248648	2015-10-20 04:34:18.248648
146	b4dd336ed8993a775f4ca5003507e48c	BAh7B0kiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQxJ\nIhl5a3BERGoxWGhIdHpwZXpBd205VwY7AFRJIhBfY3NyZl90b2tlbgY7AEZJ\nIjEyZFF2cUxGUTRmMmNjQ1JaNUd1WEh0cENRclB5NFNmVEw0ZGdlZmJIOWFZ\nPQY7AEY=\n	2015-10-20 06:10:48.205613	2015-10-20 06:10:48.205613
147	2be02b0a865a115fb5352083c2e87fe7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpV1VSQ0pBWDY0WDMwR1NaUXBx\nYVlpMVBuSmMyQ1FKNGJNeEl6K1RrL2prPQY7AEY=\n	2015-10-20 06:16:38.989013	2015-10-20 06:16:38.989013
148	1ec60c07787404b64be1a2d55985fa17	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsRk5JMGhKc25WQTl6LzVNWm1U\nL244VE9sbmgwS3pndndEUUNsUTRtbkYwPQY7AEY=\n	2015-10-20 07:13:14.763514	2015-10-20 07:13:14.763514
149	55e670b50aef9c61c820ed4cec5f9dcc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhdkpjeUFoRStLL3o4OGNpUzE0\nNkw5OWJ1WHN3M2ZhZE5JYU0wWmhxUnNRPQY7AEY=\n	2015-10-20 07:13:15.739036	2015-10-20 07:13:15.739036
150	e7e3f429dce88e466d7896d41bac4e4c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2NFhpcmJNSy9rRXpwL09ER0FP\nSUFYT2U1UGNsUWMrb3NLaWV1TGw3VGUwPQY7AEY=\n	2015-10-20 07:13:16.936267	2015-10-20 07:13:16.936267
151	5c5bd712f08d4bfd324a876abca035c4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwdFJaNnJ4RmxVMUFuVy9Camtl\nT1U3emlqSVhVVzQ0YXFGZmRWQ2lIRjdjPQY7AEY=\n	2015-10-20 07:13:20.989005	2015-10-20 07:13:20.989005
152	dcf5dd7d201a23fd739c5222fd2c352b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvTCt6Uk9iTDVkV3lhV2R5RGtC\naDFOS1VNWXFiNU5GT2RkeFdZT3ROcjY4PQY7AEY=\n	2015-10-20 07:13:24.322076	2015-10-20 07:13:24.322076
153	64280319c3b5d771e1caf8c5a80b16a4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5bGJ4ZzF4RWh1RDVIM1p2a042\nOVV4Uk5kdmpjZ1VkbEo1TjFLQkN1UVVvPQY7AEY=\n	2015-10-20 07:13:26.649639	2015-10-20 07:13:26.649639
154	9f062501057de34e9c765ef2d2a2afa5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEydDlkYzIrYjFKRXFrS1BUZnZD\ndkhlUzUxd1JyRXJJV3YzWWZ5c1ErYlEwPQY7AEY=\n	2015-10-20 07:13:29.114153	2015-10-20 07:13:29.114153
155	55a4ea48410d0df3f20155c9b9939d9c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqS25NL3BadEpCd2J2NmVmYk9i\nOFFWQ1hlcW9xZTFPY25ReGhFb2FFQ3BVPQY7AEY=\n	2015-10-20 07:24:16.153516	2015-10-20 07:24:16.153516
156	61e8ae7696d8ed7d3badd5d59896746e	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUT2drdUh4OC9peXNKajcwTzZa\nMklabCtsYXBaREZVSG4rYTVPWkV1SXo4PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNDcxNzA5YWEwYzIyMDBkMAY7AFRJIg1vcmRlcl9pZAY7AEZpGA==\n	2015-10-20 07:43:42.09513	2015-10-20 07:44:55.265974
157	03c3d013db7e0f4062be2bc8f1ed37fd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCbE1VM2g5d1NISWVGK0g1aE5J\nNTZNaHFhN1dwb2VjZGxZSWgvRWtmMjZrPQY7AEY=\n	2015-10-20 08:15:50.420719	2015-10-20 08:15:50.420719
158	fdc67fb811ef625becb88a753de0801c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmSmpXaHJnYVdlV0lBT1phTmlj\nUWpMN2lueDRSNHllTHhscmpHM2d1WG5ZPQY7AEY=\n	2015-10-20 09:30:42.227725	2015-10-20 09:30:42.227725
159	f3bb13474004221f38649986dd1ab59d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiNTRGaEdPQVYvQXpBYVdtOGJX\nM29CS2ZOeG0xSWp3bU8yNll0SkFPa09nPQY7AEY=\n	2015-10-20 10:32:13.215091	2015-10-20 10:32:13.215091
160	6f7896f6eaf70eb7313bba9005f587b6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnZ0MvVVlCYWFZYzdyYVF3TEdt\nclp3UTBjb0ZzdldWb3ZqcjRHczlqcE9RPQY7AEY=\n	2015-10-20 11:27:08.398687	2015-10-20 11:27:08.398687
161	035142a1088a321f0a76649eb5ca1107	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEydm5IMWVzR1hXNEpLa3dmMjlL\nM1dPM3VPem1rbk0vWGVIUldWeFVVa3FvPQY7AEY=\n	2015-10-20 11:27:10.065201	2015-10-20 11:27:10.065201
162	fd256b5da721d065071c9bcd4438cc50	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4eStHNmJYdWhNRzk0R0sySysx\nTVdCSlhZbTU4MFJXVVc4V054aDhIWm5FPQY7AEY=\n	2015-10-20 11:57:38.640982	2015-10-20 11:57:38.640982
163	bd07e8cba1c92253014d4269accd36e7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyMlE4ZXRlNWJhVmRneEZ3Y0NF\nVmtPRFBkaWNGZDd6WXBTVFpscTZQL01jPQY7AEY=\n	2015-10-20 13:04:23.14331	2015-10-20 13:04:23.14331
164	a36eca2072894992eb508f41495bda46	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQNUZYbmlnVFpZYVpsMG5MSFEy\nM1l3UFJjRWx2bmt4dE1LL2d3WXltYzdnPQY7AEY=\n	2015-10-20 13:10:48.468286	2015-10-20 13:10:48.468286
165	b8deba33a749a656eda8367d7aaafa85	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2QjJua1lrb3YvT0JMaTFNT2lI\nVy9GaEEzSXRkMG40cVhqZEg4L3dEYU9nPQY7AEY=\n	2015-10-20 14:33:30.504558	2015-10-20 14:33:30.504558
166	503d6b47e29376899ffb44717e36c237	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvRHliU04vUkZ5R0VlVzM5VE1I\nVVhKYnBPQVRPU1ZRZ3dieFVyQk5EZmpFPQY7AEY=\n	2015-10-20 14:58:52.079197	2015-10-20 14:58:52.079197
167	9054e9e1471a5bfaca0d35e3f22116ed	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzUVd0RFMrdmxkdC9mNmtIK2dn\nYVpOcXdsNEdtMnp4WElxV0xRRStpZk1rPQY7AEY=\n	2015-10-20 15:27:52.402937	2015-10-20 15:27:52.402937
168	fda9db61749fec0103f8677fb74a8b5a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6Mm1hS29taFVJK0RFVzdJaVRu\nNFdkRSs5aCs5eWhHU3AzQ2lGdkUydUFVPQY7AEY=\n	2015-10-20 15:27:57.932187	2015-10-20 15:27:57.932187
169	d1771a06d43b37ed739773c5128cb899	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyTFJUU3A3QkUzaXpWZWI5Qkdn\ndzB6TDd3WU9yQ2ZSZzJrVFcraUxQUVRZPQY7AEY=\n	2015-10-20 15:41:10.420932	2015-10-20 15:41:10.420932
170	0797a7216c2993637648bba974b79de8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMWG9sS283dFpTWGJWWTBud0VI\nbnY1NmpRcWdyUWllUHJpcWd1MXNpTldBPQY7AEY=\n	2015-10-20 16:09:41.070394	2015-10-20 16:09:41.070394
171	ed8cca6d259941856ae83896871fb75a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFma3AvWkRGOUhZelF1TERpRVhQ\nOWJvSmNlaHhRQWFYM25lSW1VVlVlZjcwPQY7AEY=\n	2015-10-20 16:38:51.778081	2015-10-20 16:38:51.778081
172	f17c4c11dd8f90552dd5beac6a7770ec	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEycUJOK29HcjRiVnFyVDJOMkRK\nZkxOTzZtWnRIemp1K0UxODhmVTlBUGJNPQY7AEY=\n	2015-10-20 17:42:12.113924	2015-10-20 17:42:12.113924
173	ffbe61085d7332a7949db1316c06ca0f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSUERQdUlieWR5N2tPTE53K09Z\nMjVxbE9CSlFGYTZ0Zk1pNllzejRRVU9RPQY7AEY=\n	2015-10-20 17:44:57.431339	2015-10-20 17:44:57.431339
174	63761818a9af4d1e42681819d65de1a0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErVW1rVEk1cEx1eS8yTEplcitQ\nMFpCSEZ0NTJDWEZBdVBEWnFZcWpPVXFvPQY7AEY=\n	2015-10-20 17:59:58.623958	2015-10-20 17:59:58.623958
175	f8471ca35f4eeacb08649c9bde24c1fd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxV1Z4eHB6MjY0QnFWNmNyWFVO\nVEFuYWlsclpsQkViK3Z0OUFWcGNnS1NFPQY7AEY=\n	2015-10-20 19:38:18.545668	2015-10-20 19:38:18.545668
176	7ad7fc24131783b2be8f13ec1fd3d62d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtclJ2WVVXR0RUN0xKNWlZMTdP\nc3lYdzhTblJsTTdSdks4YlA4NHZJSS9vPQY7AEY=\n	2015-10-20 20:01:30.469841	2015-10-20 20:01:30.469841
177	c51b7fdad71941bb129e26b0a6a64f45	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzYkJlY2VSV0kyZ3dabDJCQXhG\nMHJ5bExoZHp1YnFqZzhySngrR3Y1NnNBPQY7AEY=\n	2015-10-20 21:50:00.854851	2015-10-20 21:50:00.854851
178	f6ccc6829dd4fb2c1db360e292f56c42	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhdG1CZ3BWYTZpdVpCTVRkbkFP\naTArTTFjeGMzdGFObDVpS0Z6cGNMMG13PQY7AEY=\n	2015-10-20 23:06:25.680959	2015-10-20 23:06:25.680959
179	59f8c53c7d06aa0d3198fa9b1cee063a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6QTVGTkp2T3MrNko2NjlRdVhT\nSVBHZktWNVEvdG5GNGhKUDdRVlJsbnRrPQY7AEY=\n	2015-10-20 23:42:04.531184	2015-10-20 23:42:04.531184
180	6c804cdd173d0085ae16c0264c4f394f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3UVRDcXF0YmRMN0EzU21Ta1Rs\neFp5V2RST3E4cEk3MVNyamdqb0pOajBnPQY7AEY=\n	2015-10-21 00:52:24.732363	2015-10-21 00:52:24.732363
181	989d98cb946888bb0b81e11583a499bd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwZkQyNkZKWXdWWm9LZC9NTnlG\nSWVSYkhNcXZhY2NyWnZaN2N4MXliSUZnPQY7AEY=\n	2015-10-21 01:57:24.261289	2015-10-21 01:57:24.261289
182	7992b3c5734b1b8c62771f0451368d11	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLMHlPdE5STFZOVDd3YjlyUm1p\nWE5WaUdRVFZ5eTN3Y2t3ZU9JUWFsS2prPQY7AEY=\n	2015-10-21 04:06:54.464071	2015-10-21 04:06:54.464071
183	e0963c368736e938e01d5addb4b082e6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyM01OdU5lVS9vVm1mQVZqdEhB\nQ3ZKbCtEZG5idVFpY3haV3lXNXM1bDNBPQY7AEY=\n	2015-10-21 04:28:14.535889	2015-10-21 04:28:14.535889
184	3638d6ef3b25d992e9e18ec3379e24ef	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZUVkzUktMd29HdU1XbnFpb09l\nVVlsZ2c2UjB5RG5TUkZJK0xSZVJWYmRnPQY7AEY=\n	2015-10-21 04:29:51.332865	2015-10-21 04:29:51.332865
185	e7d9506b3dc22ebaad4e506e8ffc10d5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0RzlxWkhqRlk5SzBuNFF3ck1O\nRTM4aFFBeXhUSEx2TXpmMVVlRGh6cEY0PQY7AEY=\n	2015-10-21 05:56:32.055505	2015-10-21 05:56:32.055505
186	6c3ce8f186691f18bad7089d0c76cb2d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErWkFZdUpkUmpvNjVUVFdCN0lQ\nVW0vcERxdTFOMVJCdU9BeXN6alVreHFBPQY7AEY=\n	2015-10-21 05:56:37.54398	2015-10-21 05:56:37.54398
187	35e31d1d42d85072b311d9d7c3f54e47	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzSTVlMHg3cmpWb1ZRVk5qNDRl\nbnhwdEplOFB3TWtWWU10UmdKYWpNNGtRPQY7AEY=\n	2015-10-21 06:09:59.140484	2015-10-21 06:09:59.140484
188	51350b8dfce8b59d555faf1a13393cd5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlanhEWnI5eHRFN0YxY1pZeW54\nSkFPZ3RPTDdHaC94THFwRmNNbUxrOUtZPQY7AEY=\n	2015-10-21 07:18:15.318802	2015-10-21 07:18:15.318802
189	9ac428ef16223ac69b1ba0b6edb46053	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCQXN0cnl6NXRjR1A5Mm9NbFVx\nWEhCRVo1UGlvd3BiMmhEbmZPeXFZOEtJPQY7AEY=\n	2015-10-21 08:48:59.053547	2015-10-21 08:48:59.053547
190	8f4eb468c734d044fed5e5617caed78d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2OVdRdk53cVZmWnNUaVUxdWF4\nbzNOQk5idXMxd3RaZFhReTJESzVwcThFPQY7AEY=\n	2015-10-21 09:42:47.777514	2015-10-21 09:42:47.777514
191	11e8b14382cb81b48ce4aa2c0d220548	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2K0FLUitUenJtcUdXZTNlb3Bk\nb0NQN0YrblgwS0IwQ3UrODBzTVR3WUdVPQY7AEY=\n	2015-10-21 10:21:44.985173	2015-10-21 10:21:44.985173
192	b35565a18fb6453fec6c93dabb0b9841	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsLzRIQUpiSmt6eHVqWEJBOFo1\nSlU4bUd6WEdMWDFZaktiaUxlVVdmbkVnPQY7AEY=\n	2015-10-21 10:40:56.720053	2015-10-21 10:40:56.720053
193	a9653c86e2e73407aa33622ab6ff464d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKbmN5TVU3VGUyL002NGRMVERk\nTUFHMEdZNTQxTUNJbW4vM3pqQUc0Y3pVPQY7AEY=\n	2015-10-21 10:44:32.074986	2015-10-21 10:44:32.074986
194	9731847f659d38f0368bb57385ccf08c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtQ1grZUdldHdlQWJaQVhWMlo3\nUW11MkhEVHNNNGpSVkFHMERZOWo1SjlJPQY7AEY=\n	2015-10-21 11:33:52.454599	2015-10-21 11:33:52.454599
195	c69624a8ab6c5f39e43b4200154efebf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNTXM5M2M3U3lxSzkwTERzOWsz\nVlVpMlg0Y3ZreFhEeVRMTkg3YjN1UWZnPQY7AEY=\n	2015-10-21 15:42:56.548273	2015-10-21 15:42:56.548273
196	aac5918c14a714011e9d8f8ce3962aba	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExenVSbU1ObDJUK2wyOHNmdnZi\nQUZzUXZXN3FjcE9BMWU2dEFWWTRkUExnPQY7AEY=\n	2015-10-21 15:51:48.722396	2015-10-21 15:51:48.722396
197	8c831118d95161f893e690156624e38a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkSWRTOU51cDBkdU1wS1lxQnJX\nNEczYi9tS3VKZ0pnRmtxRStSYTkvRzhnPQY7AEY=\n	2015-10-21 16:59:50.892819	2015-10-21 16:59:50.892819
198	613be15b059df9ed21234025a3ee9617	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGK1ZJYklFTmJOb0ZnRzlnbERu\nTjFGakJJMGMwa0ZWaFVJZlZ4eVZrWnIwPQY7AEY=\n	2015-10-21 17:19:22.617303	2015-10-21 17:19:22.617303
199	1888b880f7f7d3f4f15a3b410d99c77c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPOTlTSDZXOVlMUEdWL2drNDU4\nNzF0aWFIUmxYWE1NSk4zVWxTQWQ2MlpNPQY7AEY=\n	2015-10-21 17:19:23.629665	2015-10-21 17:19:23.629665
200	ce54369f6d01c532121e768d0ad66991	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoSzcyWERDZWZHeGd6dGZPdXZH\nTVpIOWIzK253RkU2VkI4cmVOdnRCV3hvPQY7AEY=\n	2015-10-21 17:19:25.87892	2015-10-21 17:19:25.87892
201	c383b5c67104d371fe476b0fbe1a2c98	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzT0RZSklsSEJ6TzVNSlFZSTNu\nUDNxZ1JZL0c4OFZRMGtqU1BoZGY3cnNrPQY7AEY=\n	2015-10-21 17:19:32.766734	2015-10-21 17:19:32.766734
202	31f09f1110863353d5d99f34cb92f9d6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYY0xXaE5HMkFxa0lIWFY1Uk5G\nK2ZRdTJnVjhORjdoSHVLK3FpWGU3ZXE4PQY7AEY=\n	2015-10-21 17:19:33.781155	2015-10-21 17:19:33.781155
203	92be7ac0c38d27ea294ed0bae720496f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF1ZkR0Sk1CQ1F5VWtwcnFUVG5j\nWXYwajJKaDFTQU5oaHR4NXJTWWtZU3owPQY7AEY=\n	2015-10-21 17:19:35.397451	2015-10-21 17:19:35.397451
204	97a3d2730808b12667462a001d89a168	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLcGZDbFZsellBNHorSWdsZGMz\nUXNpVWkxTWZXVVRNKzBQRGxYRnhMRlVNPQY7AEY=\n	2015-10-21 17:19:43.209306	2015-10-21 17:19:43.209306
205	7b56b4e5e9c272d43c55d6f312a3863e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNREZQb2IyVUNuTFVwSTdHQlNR\nS3VLSGgxb2ZYdlk3THdSV1ZKMEpIbWgwPQY7AEY=\n	2015-10-21 18:54:16.136936	2015-10-21 18:54:16.136936
206	982ff866c742e494278b691cc9be05b0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3UnEwNnFKZTZoZDVaQWIxVXQ3\nRVRId2EzSG50N2JLczJyOVp2cEVpUitZPQY7AEY=\n	2015-10-21 18:54:20.815577	2015-10-21 18:54:20.815577
207	5aded17e273a7548479b959d01539588	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHajhZTnpPeXF1TE1vSm9UK1Fu\nd1pGWkdXcEhuRTEvRUFSbE5JdWVVdHYwPQY7AEY=\n	2015-10-21 18:54:28.514559	2015-10-21 18:54:28.514559
208	fa0ded47548de4851c8c71dfa6b2def1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVZ2RwemZBVnlqYzJTcDJHM1Mz\nMEt0Y3I0WnBuZDA5Y3N5cTdaSmhWdk9VPQY7AEY=\n	2015-10-21 19:26:31.356994	2015-10-21 19:26:31.356994
209	5f0bb86ada03abb58c27beaa03fbd047	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErOGlPRmhXdk9HNnhhWU9STktL\nc1dUNEdTMnNCQ00wYVc3MnYweHpUQ3ZvPQY7AEY=\n	2015-10-21 21:39:51.725451	2015-10-21 21:39:51.725451
210	303ee00509a959fbfa30c82a929926be	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUT3FzS2ExUW43M0wrZlJFMnZP\nOWJWbEM2NXBHZlFoQlV5UmVwWkhwT253PQY7AEY=\n	2015-10-21 23:17:19.307783	2015-10-21 23:17:19.307783
211	63ab5e6a2c863649b2bfdd5bd21f58f9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2RDBVN1FIdjR1SnpycThDZVlo\nOGJ3UVlnS0pWZnpXRDI3OTFBWVZmUnJZPQY7AEY=\n	2015-10-21 23:28:27.60179	2015-10-21 23:28:27.60179
212	ed0d477c88b220c76e10a8684f359520	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFidmQyTUV6L2NwYlFIZTYzcDZu\ndENnNTY0T25OaWhOa1BuV3hqS0VMalFBPQY7AEY=\n	2015-10-22 01:26:31.286391	2015-10-22 01:26:31.286391
213	0d01d3a55f647f1066cdff7b9e045ee2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiWFUrS25IUG5VNUdxbXFTZGFC\nK3NqQ1I5QlV6M0h2aEptNmx4OFBDeCs0PQY7AEY=\n	2015-10-22 03:26:34.334156	2015-10-22 03:26:34.334156
214	b5f3be6889c55250d53dccc2e1e8a1c3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErSmR6SENTU3NGelhpRDFDc3Q4\nOTVVVTAxZ0dWNjVTY3NCdkg0YzhVZFZRPQY7AEY=\n	2015-10-22 05:58:30.558541	2015-10-22 05:58:30.558541
215	c7ee806ca2f608b813998841cd429b6c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwOE5Pelk5V0grWjlTeU1EaXVK\nVEVqczFRVXJPbUlja1dJZVQ0ZXpVY1lJPQY7AEY=\n	2015-10-22 06:16:35.569471	2015-10-22 06:16:35.569471
216	cd88833dca51b20381a2204501354252	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRTWRrejFpRW04U21lMUt1eG5r\nZk9CZ3BkVUZNVjRUeUFQUFhNUzhMbHFnPQY7AEY=\n	2015-10-22 06:26:37.132495	2015-10-22 06:26:37.132495
217	3343dfb3bbbae5093db18ea17c7f78e9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwaFBGN1RxQ24yTGZWMDFyUFZt\nZWZXdi9jeVJDWkl4QVlCSnFRcTdzbjhzPQY7AEY=\n	2015-10-22 06:51:25.151932	2015-10-22 06:51:25.151932
218	4bae854903b32afc5135dcb1ce4c649e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEraEpFL0VmcndsSkdWMkFKTnpB\nTFNqbS8wUXRha2pHUWVweGVpYkRNTUtZPQY7AEY=\n	2015-10-22 06:54:13.062129	2015-10-22 06:54:13.062129
219	6c86778e2b380f7a58b4cf4e4dc514c5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoaE44Ui9KdkZ0SnpkNDN2Y3Js\nZU5EdWFJVHh2WnFIZmszYythckdsQmFzPQY7AEY=\n	2015-10-22 07:07:22.421515	2015-10-22 07:07:22.421515
220	f51fecd94def0a74a00ce9ab9bd6f148	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTcktXWFl6VVhjTENVYUxBV2Fy\nVDFGT05TSjVqS3NmYlplNnNBUzZ3SXZJPQY7AEY=\n	2015-10-22 07:07:25.77468	2015-10-22 07:07:25.77468
221	23576e15e2f50e252d753a8831030529	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBWm9qSjhvOXZCbzU2OGRESnJv\neGkwTnZzUlJlS2NTY05XcmY0em43WHNJPQY7AEY=\n	2015-10-22 07:23:32.079456	2015-10-22 07:23:32.079456
222	328d0867a797f8626f113869945080df	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvZityZWRacGlVL3g0YkwxSzNY\nUDFkMHovelNHQkZiaThFRjRuTkhZeno4PQY7AEY=\n	2015-10-22 07:23:32.712944	2015-10-22 07:23:32.712944
223	4599b8a8329dc80cf6464589dd61f8f6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZV0Zoak50RkZTMXhsQi8wUTYz\nQmhORHhaYUFNWXVFTUhXVk5kUWNRK1RzPQY7AEY=\n	2015-10-22 08:39:34.952977	2015-10-22 08:39:34.952977
227	8f74dff48405d786dc78cb7ed85a0bc2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxb3Nnd2p6a2hoZkZSTFpVRkpE\nOFBqNmZTaEVYUUo2d1ZOZTNhMytybDY0PQY7AEY=\n	2015-10-22 08:43:41.399026	2015-10-22 08:43:41.399026
224	52d72d263b12a77fee3b3058c57c71fe	BAh7B0kiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUYiGC9hZG1pbi9jb250\nZW50L2VkaXRJIhBfY3NyZl90b2tlbgY7AEZJIjEzR3dKYytjU3k1TmFVTlkx\nM0VpeVowWitLSnhoclVUSmE2dXd2S3ZkbzdZPQY7AEY=\n	2015-10-22 08:43:40.260796	2015-10-22 08:43:41.902057
225	19d0de59dd62b81e7e496fff66aca3d3	BAh7B0kiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUYiCy9hZG1pbkkiEF9j\nc3JmX3Rva2VuBjsARkkiMTZsNUJ4SjN5bzFjM3FpS3hReGtVanp4Z3RiMWZ4\nVW9hRm5nTWdmbUZpRVE9BjsARg==\n	2015-10-22 08:43:40.704968	2015-10-22 08:43:42.320275
226	223ff0d46873fd8e5ccaefaceb13fa1c	BAh7B0kiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUYiIS9hZG1pbi9nZW5l\ncmFsX3NldHRpbmdzL2VkaXRJIhBfY3NyZl90b2tlbgY7AEZJIjE5azBDL2Fw\naUtkSjVuMjY3Y3ppME9XZXZlU3RLVTZsMFJ4N3BsTXdlVG5FPQY7AEY=\n	2015-10-22 08:43:40.990879	2015-10-22 08:43:42.905463
228	a7a88cfedaa08c8e30835e72f42a1bdd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTcEtCdDlhZWxMaWZ3c3NNSUdp\ndE8rcEpRMmgyZG9IQ0ZMMnc0ZWRQVWprPQY7AEY=\n	2015-10-22 09:26:45.948702	2015-10-22 09:26:45.948702
229	c1921023f606aad38a5145e9b9a70d28	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkbzBQMEpNNEN1R3dFWGtJSXhY\nK3E2RlRZZkdwQ1VEc2ZlZ3lhK3pxT1F3PQY7AEY=\n	2015-10-22 09:39:32.83567	2015-10-22 09:39:32.83567
230	8fb18d0ec09fa6734a17636902860aea	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsMHlVSlFYVG4xbVBZWWw2WHF6\nMTlYeVMzK2dISDJzNHRtaU4vd2tyTE1BPQY7AEY=\n	2015-10-22 10:16:05.725153	2015-10-22 10:16:05.725153
231	3f6cc605480cb754e5870f21c022d1a3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyOUZ6RHZXVnBrWXFwQ3ViUm5I\nZG0xRDRRQ3dYYk10Z0M1aDVJczNPZjhBPQY7AEY=\n	2015-10-22 10:28:55.609414	2015-10-22 10:28:55.609414
232	c6d9cd8b9c0ea3221691cf963233f218	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmVHdqQ0dOelprYVFGbGpMclhV\ncDdrNFFtZXhOOCt5bDU0cWFDUzFyZXJnPQY7AEY=\n	2015-10-22 10:41:25.072947	2015-10-22 10:41:25.072947
233	4b6eb17431c0a75f56295f07ceca23f6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKeEE0c3JZMTNXZ3RvS1orL0xU\nZDIvU0NGQlRVV05JK2Z4RmpHZ0pTS0E4PQY7AEY=\n	2015-10-22 10:43:16.318064	2015-10-22 10:43:16.318064
234	cfd378391504fe982cf1275179a048b4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyVXBTMHVRUEh1NjlMY3YyVmxa\nUE9OMUNjcHNWK1FxVUFJZVREdXBxZTVJPQY7AEY=\n	2015-10-22 10:56:00.599204	2015-10-22 10:56:00.599204
235	fbe4eb9dc2a515646ab628a52eaa99d1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFJN1MzdTdjR1djN2tFcVdpNHRQ\ncVJtanp1T0RvcGF4c3JEellFQTlHc2k4PQY7AEY=\n	2015-10-22 11:08:18.317493	2015-10-22 11:08:18.317493
236	70666d48bdb54deda6dea7f7783a15de	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErMHlLMlU1VmhXTmkvQlNRRWNF\nN3J0blJHVURTVFI5V3dMdmdwVmMrN2Y4PQY7AEY=\n	2015-10-22 12:33:33.652101	2015-10-22 12:33:33.652101
237	3052f0fc0c5c3fa12c99791c6634f74c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNSkJIR1RTaXkvRThkRHo4Rkxl\nSWRvRXd1ekRJSXJHUWY5MzJCdldSWXI4PQY7AEY=\n	2015-10-22 14:21:04.465725	2015-10-22 14:21:04.465725
238	790eb7dd1056cc173a69e4d08d3e79e8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmT3p6cFFvdE9QMVBBdVUwQldY\nb1BIeW9zaUdObnprVnQybXFyY0NTZGRJPQY7AEY=\n	2015-10-22 16:01:33.134067	2015-10-22 16:01:33.134067
239	af5e723b425730c92cbd143221816e4e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYY0JFNW94Um9Zay8vdzRSalQ2\ndkhGRjZzV3JyNHB4UzFNM2c2UjkydkFNPQY7AEY=\n	2015-10-22 16:32:36.532868	2015-10-22 16:32:36.532868
240	5dfd40ee33421016b25cb97f23c05334	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRRERYY0ZIZXlEcVBmOXNibE11\nSlhJbXQwR2ZHeXduU3ljLzFXMVNSQUJRPQY7AEY=\n	2015-10-22 16:46:26.11858	2015-10-22 16:46:26.11858
241	5288d5443b6ec2e31dc8c054058171b9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLaTlkbk1hYTRtT2VQRm1kSE9Y\naTl6cGNUY2pnc2Y4N29taWF3UGVHaXcwPQY7AEY=\n	2015-10-22 17:50:34.077311	2015-10-22 17:50:34.077311
242	818817f6ffb179d6ceff01046071ef50	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVMlpZQlJsUnBLR3pCN3N2ckF3\nRisvWDJsd1BxRVEwRDNad0FWcEhwL1I0PQY7AEY=\n	2015-10-22 18:03:02.551258	2015-10-22 18:03:02.551258
243	2090d8bd1de3215195d9a591ff37be45	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2eG5MdkJXK3dmMENCZG0vTlov\nQ2tOZS9OZ1BQOUZIUFh2d0pSTDF5T244PQY7AEY=\n	2015-10-22 18:31:23.400196	2015-10-22 18:31:23.400196
244	966fcb98dc6957aaba69655c6e83b1f4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQcEJ2N0pMNitIL2J5U01tMEdi\ncko0UkJWRk1NRWJJRHYvYTl0SnhrSS9FPQY7AEY=\n	2015-10-22 19:20:30.402963	2015-10-22 19:20:30.402963
245	58f833c985af3fdc180bd528431c78d1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjNkozWm13TmVDc1BGV0tSOGp2\nMnRhMmU1bUtIUXNQTFlCUHpRa2tqR0FvPQY7AEY=\n	2015-10-22 20:24:59.840383	2015-10-22 20:24:59.840383
246	d9174128a1f3c9b6bd3f80e44c52b11e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvWDl1TVZkRjUzVmlGYmJ3ZVpj\nOUIrOENBWHJ6eVdPR2lhdm5Xb0FEaHlrPQY7AEY=\n	2015-10-22 20:42:10.174301	2015-10-22 20:42:10.174301
247	99dbbfefc44e9100dded7bc49b6cf3ca	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXeFhIMkVRKzJOZkJiUGgxRzVs\nY3h5MlhzZittZlV3dzd6Y0piQ3lsWWVzPQY7AEY=\n	2015-10-22 21:34:14.062138	2015-10-22 21:34:14.062138
248	49675fd6d83bc33b7193052fa8c54e95	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFudHJaU3UrOWw5cDYrL3JJbElG\ncmtnd0VrcGsyRzJHaXIrNW95bVNZVDBFPQY7AEY=\n	2015-10-22 23:12:01.870474	2015-10-22 23:12:01.870474
249	1848958720d380312c63caaf3d05d24c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqUWdsOWQySjN5NzludkNjU2g0\nUUlkR1g4MW1BM2piYjBtM0RlZTB3dnVnPQY7AEY=\n	2015-10-23 02:48:35.953171	2015-10-23 02:48:35.953171
250	523c2c2f1a70a3eb815858d9bd6540ef	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHVzIwMWdqeHlKeG5ha0hLRGRm\nWVZuenllYklSNlRVSWN6RnRUSFpHY2dFPQY7AEY=\n	2015-10-23 02:48:46.709193	2015-10-23 02:48:46.709193
251	e2aaed0e4e0f4db1a7e31ac49ee379e2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhWjJmTVU5bHcyanp5RExnRDQ0\nSGR2WERDRERzdlRwV2MvUk5NMnh3cTVvPQY7AEY=\n	2015-10-23 02:48:51.851732	2015-10-23 02:48:51.851732
252	645b6f5a2eea904f91c9ca7f6cd8094b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExdHhTRytaOStEVjZMQStvZ2U4\nUllJT1FyR2o0MVNYWXNML0xmSThETnJvPQY7AEY=\n	2015-10-23 02:49:13.176904	2015-10-23 02:49:13.176904
253	09010b44b3ed05fe9f3bc54d0ac31a66	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5NnpSUWxQWTJXMXhMNTZQM1NV\nVitHM3BmSncxeXdnVjNyZVJyV1hFYVNnPQY7AEY=\n	2015-10-23 02:49:23.637572	2015-10-23 02:49:23.637572
254	f51d6c69dd06c03db9c388efe204a4c7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2SDVkMFMzTUpiZ3VGS3RpWGJV\nSXNoN2JmL3RXQTdwMmI2T3RUOHloYU1nPQY7AEY=\n	2015-10-23 02:49:29.220228	2015-10-23 02:49:29.220228
255	7b8ee9125730e17b871561a9c86548d1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHUFk3ZFIxaE1ubWVwOU1OdTJo\naW9JU2hRVllvOWVrdTJaNDZJS2loSmljPQY7AEY=\n	2015-10-23 02:49:34.259548	2015-10-23 02:49:34.259548
256	0e4c14139c4fd3709798f9bc010d7b45	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoNmkzWHdFU0VrQVFGalg2dTNE\nVUJwK2RUM1FFQS9BNGl4TXlxTnhEQlVRPQY7AEY=\n	2015-10-23 02:49:44.596365	2015-10-23 02:49:44.596365
290	98f8a90a9ccc78babcbfd0f8dec5e4e2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGNDNXVllkUElDTnlYVnpoZGRw\nRnNMTXV3bjN2WkJXRFFkTk1pdjVBVkdjPQY7AEY=\n	2015-10-23 19:06:20.130315	2015-10-23 19:06:20.130315
291	1a520994ac84621ba4717447325bb98f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvUXVFZ0xSMnpNY0VrZ2ZHRGdy\nV3pVQkxWdDc0QjBPYUw0UlVCbGNtVEpjPQY7AEY=\n	2015-10-23 19:09:13.402976	2015-10-23 19:09:13.402976
292	c375ff5f24b76b669ce03040e73ed33b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6a1BGY2pRdlZKODBCZXNkTDZE\nZGw4a3hUc1gzR3NUTW1NQlVBM3ZHcElNPQY7AEY=\n	2015-10-23 19:09:21.616006	2015-10-23 19:09:21.616006
257	3651a6809c64c6b6bc3f3d7302997515	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxWTlsKy9neERjWVh2M2FhYjNH\nUUxhWjFPSkF2c0pDeFcxdmNuQ0lRM2dRPQY7AEY=\n	2015-10-23 02:49:49.93263	2015-10-23 02:49:49.93263
258	2cb35ba50a599e8b3ad4350856b0d5dc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtUjdwT1dKdDZZNjJwMXFySm43\nMmFadXNMOXBiNU9zR2NrVlQrdjQ5Wk40PQY7AEY=\n	2015-10-23 02:49:55.268567	2015-10-23 02:49:55.268567
259	9770a428c66bbf475f0871f692944c61	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLV3gveDlWVk11UkI4d0ZUMVlX\nZ2NaNkc3WEc0MDhlYi94NVk5bGhoWTZnPQY7AEY=\n	2015-10-23 02:50:00.501978	2015-10-23 02:50:00.501978
260	8b9667a6fa6ae52208ab78be8694a1f5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwdXNKWjFlNlVSWVNqekRtQkN0\nRHBlMlJrN2wrZFRmd0dNbVhvS3U4eVE4PQY7AEY=\n	2015-10-23 02:50:05.694957	2015-10-23 02:50:05.694957
261	3638a005989378685dfee7d836f62528	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3cHpxbWQ3L2R1ZmRWWmRxRUZm\nLzQ1UXF4a3RlSkpQL0sxS2QxWFlLRWpZPQY7AEY=\n	2015-10-23 02:50:10.783029	2015-10-23 02:50:10.783029
262	016d5fa5c7220d538401455dba747e57	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1dFNhMEdHLzVjdUpXQnJvNmw0\ncDVaMWVQZG9aM0xGYXpCZ0QzSVhtMVdzPQY7AEY=\n	2015-10-23 02:50:16.362044	2015-10-23 02:50:16.362044
263	dae6514c1317babdf5cedb133529aa4e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyYmp2TGJoZjNGejBmc24xbDJL\naU9XQ1FJT3hRaEtmaHdydExmNUZITDVVPQY7AEY=\n	2015-10-23 02:50:21.161906	2015-10-23 02:50:21.161906
264	40bcd336e7f8c24169c4c689aa45e0f6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKVWpqdXBYVzROU2Z5S3h6b2x0\nWXUvd3JuSmFkdUNXN2hZZmk5YXpFUTlnPQY7AEY=\n	2015-10-23 02:50:26.609115	2015-10-23 02:50:26.609115
265	e6958bcc5735c242c24331e4e9e7ce1f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZZWFWR2Q3UVZLT0JsTjFINERF\nWU1zOWZtdU4yRTNIRzV3ck5USk9rallFPQY7AEY=\n	2015-10-23 05:01:29.693284	2015-10-23 05:01:29.693284
266	ce18c1303e53bca482860243ad89adf4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWckdWUzhENUJ3V1F1cTFJQU5C\ncEhGYnl2OGdiQ2JZU05tOHpmd291Q0FFPQY7AEY=\n	2015-10-23 07:01:09.318958	2015-10-23 07:01:09.318958
267	602adccbe833bdfddf4cf135c695b28d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoeFg5R2x3TFpPcDBxUmhDOVN6\nNTA4U1JjK3g3ZXU4eFNDbWtyZW9rb0dvPQY7AEY=\n	2015-10-23 08:23:30.935165	2015-10-23 08:23:30.935165
268	bbfaa15167db2a89ecab72973b492f82	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYbEkzTmJYandpSHRUekFLTkk1\nTlI2VnB6Wm1HVk5yR25oSEphcXRJS240PQY7AEY=\n	2015-10-23 09:25:53.85044	2015-10-23 09:25:53.85044
269	5051811099f85e9b0fc3f38f9bd916ab	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlZmdoMkNNVDVEbmdXdjRLK1Uz\nT0RnV0pPQTBac29XclpqQkQ0WTJaKzY0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNGU3Y2I1NWQyNzU3YjA3OAY7AFRJIg1vcmRlcl9pZAY7AEZpGQ==\n	2015-10-23 09:25:55.498236	2015-10-23 09:27:10.510396
270	102da7e0a139e5c7aa7d60b2e3777111	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF1VVIwcDE2a1hRZzI0VVE4MUls\nZWtYQkZYTG9WRXNVNDBKelpSTUNIR25nPQY7AEY=\n	2015-10-23 09:28:52.078504	2015-10-23 09:28:52.078504
271	246be52e1c5a693b9152a8c9b7bae58b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwR09wZVFkMkpzbU5VWDU5cHl2\nRzZRRVl1ZzVSNGtuUlYxZGlJZ3FsamJJPQY7AEY=\n	2015-10-23 09:29:10.789999	2015-10-23 09:29:10.789999
272	ae05c2eee7ceef950a96fd413e5e1c82	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3K2RmVmdxcVFpWC9McVYwZE9m\nRXIzV0ZTTWE3em45Qmc1VHFWMlNmS0hZPQY7AEY=\n	2015-10-23 09:54:23.916996	2015-10-23 09:54:23.916996
273	2651750688ec178a7d302e6b66d51ba8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvbVRMOVpHVXI2RUs0UGN3dyt4\nVitBSitKbFVtd0FVZXU2VFJGcU9DdDhRPQY7AEY=\n	2015-10-23 09:55:32.308685	2015-10-23 09:55:32.308685
274	c6ef39f7fc10ff54465b9c64b91c7f99	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkZEVtYjJCYjd3cUw0YjlzakdP\nUmNVWkg3amp1ejRMZmZWYS93VGlmZWtrPQY7AEY=\n	2015-10-23 10:33:48.974429	2015-10-23 10:33:48.974429
275	c86c1edecb2f32bdba761490ee21c40e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwaU40YjJNNlZjYzloYU1aSXBo\nZHdQY0ErSEh3RDNvdi9Ia29XT3BnYVhnPQY7AEY=\n	2015-10-23 11:28:01.625402	2015-10-23 11:28:01.625402
276	cc846b013877d6908e421a01c1f0c59c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGeEovTWJoQVRCZFh4SzJXVWp4\nc3U0ajNkRC9jWE5rM0MrNDk1OXhrQWlBPQY7AEY=\n	2015-10-23 11:44:17.332732	2015-10-23 11:44:17.332732
277	12e8a3b8cae1c731d65cc78872420dee	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyU0VpN3JZUGJaWkhJMm00djcy\nOU1Ia095UjM4WXhheTROT01QV2F1cFdjPQY7AEY=\n	2015-10-23 11:52:15.076003	2015-10-23 11:52:15.076003
278	885aacb3674ee13bddd258d4957ed25e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoblJvdlRjT3N5VUxKR2ZDeEYx\naU5NVGhLWm9JNDVLY244L0pqaG5rYmtBPQY7AEY=\n	2015-10-23 12:23:35.054733	2015-10-23 12:23:35.054733
283	9ab7d3a40a012d370bf97b3c8d8144e4	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmTkRycXlYZmNOLzRBYUdZbVhz\nWlhqRlhwUkV1S3pOazFWTGNFYlEwbkZrPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVN2EwNjE3ODc4ZjZmZTUwNQY7AFRJIg1vcmRlcl9pZAY7AEZpHA==\n	2015-10-23 13:34:25.985552	2015-10-23 13:34:48.121681
284	f9581af041fa76ed81ee81c0a5d891b0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2YU0vYkgvU0x1a3Nyc0tVc2c3\nRzBzYVE3NjdiK2hHTWErenkzc2swNEJzPQY7AEY=\n	2015-10-23 13:39:15.374738	2015-10-23 13:39:15.374738
285	f2ac55ce6cdf33c8e3938427ead52462	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzZUFjM3ViK0U1a0JZbWp5UmdK\nQktybmNSQVQ2RjNkektCOC94VGM5WWl3PQY7AEY=\n	2015-10-23 16:54:51.804614	2015-10-23 16:54:51.804614
286	3bc2a53d141d80e53d747e0e4dcf1277	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxTmZsVlJ1eGJsNXNhWWg0MG1z\nQ1N0OVZJM3UrY0hoc3JTWjZiWVZxMlRjPQY7AEY=\n	2015-10-23 18:15:11.23316	2015-10-23 18:15:11.23316
287	7638a188c7d6817b44f17ca15187f684	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOR0ZTZTY5K3FzWnJnZjRzTUM1\nRnhXeFg3ZXdLb2dRNTk0d2lUbFpuVitVPQY7AEY=\n	2015-10-23 18:37:47.131921	2015-10-23 18:37:47.131921
288	81aba823d1fc8860c754fbbff91393ca	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5WFFJeWxGNFlDUmNHczc3c1k3\nb0JCRXhEVkVQeDEvbHowd3ZkckRmSWVNPQY7AEY=\n	2015-10-23 18:37:52.620567	2015-10-23 18:37:52.620567
289	a95650166eab9dea0afb667bcefdbf9b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlOEdhc21HOTFyNVBWWXFJMU91\nNGpCM0NWeWtPVHU2THA5UUtUTmZ5Q3cwPQY7AEY=\n	2015-10-23 18:52:20.966255	2015-10-23 18:52:20.966255
293	1b490f379e2c3ad03a07a8780db9f92f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyWFlqamxXK3JEbUZqY1BaTnZs\nejR2Q2NTWHRiWFQrYWxJMHN0Q0JaR2YwPQY7AEY=\n	2015-10-23 19:09:47.310926	2015-10-23 19:09:47.310926
294	aefd12632236df433fc8cc24e360b2c6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpQkFUaHUwaGVCazlmOEJoZkVa\nUWtjUzZjeGw1b2RVZ0tLQjU0MEhGWFlrPQY7AEY=\n	2015-10-23 19:38:50.819907	2015-10-23 19:38:50.819907
295	ff727aabb544c67d23b345ed7f61b18d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBNmNLaWNRaTlEYmRnbDNWUUlE\ncjRocGh6MXpPZXVZRUs2VXVOTWdMSmwwPQY7AEY=\n	2015-10-23 20:13:22.792759	2015-10-23 20:13:22.792759
296	2e0021672d4db03935cbf6617708eff3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2ZGJETVh3d29lOWNqZGh3NlpO\ndk90S2E2MEhiczhJMUtrQ0UvYXgvTFFvPQY7AEY=\n	2015-10-23 20:58:12.296193	2015-10-23 20:58:12.296193
297	81e509229d4489ec27b4fb84dbeb3202	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFaHFIRWI5Y0RWUTJ1eVhBK1Ix\nTVpEZmR5NGc0RGJzU0NrMjc0SXZGU2R3PQY7AEY=\n	2015-10-23 22:27:51.409262	2015-10-23 22:27:51.409262
298	991a4fb74cf351fa129fdf7843d6a612	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvSXFiM25aMmhmTGpRSW0yU0ZP\nT1NuYTB0OUJ2UkVXdHhmcjloYUpTdzBNPQY7AEY=\n	2015-10-23 22:56:46.609739	2015-10-23 22:56:46.609739
299	4dd5285ee477b7a8e1b4f13056ad71b7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHbC9WcnR5S2JNb3YvdkdLbmtV\nMVphV3ozUDN1Szk0ZVk4anBhSVZJZGowPQY7AEY=\n	2015-10-23 23:11:26.697225	2015-10-23 23:11:26.697225
300	57f4cbd058d0e2560b749693920e4ca4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4RW5oN3NyMDNGdGZKVUtPYWp2\nV3JPSDZaUWIzcks2b2tYRlFKVm1HTkVjPQY7AEY=\n	2015-10-24 01:05:07.598264	2015-10-24 01:05:07.598264
301	0280df3734521b18e52871d444613b10	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExcXZGVjJFVzJoblpqaHFuU2F4\nMUdNQ2tRS2JiWnRmeGRwQmNQSzNuNlJVPQY7AEY=\n	2015-10-24 01:06:08.03082	2015-10-24 01:06:08.03082
302	b23cd87e3ccb2586b5dfb39b79f26e51	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjcU4yMTI4VWFnYjRGSVk4WGxp\nKytSZkRwMGpiTjc1WnB2bmR4SFJ2aWQ4PQY7AEY=\n	2015-10-24 01:16:43.01957	2015-10-24 01:16:43.01957
303	97cec0cc2bc205af23d8476209ea6c53	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6eU5KejJUUXlJc002SjA3MzUz\nRVVuNUdlajkxUEdXOWVBWUZ4UVhobFJzPQY7AEY=\n	2015-10-24 01:48:44.926295	2015-10-24 01:48:44.926295
304	5c5c7d9d88b42b5d66a8b25e4c51cc48	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTMFh2Rit4SWtlc1FqWGJzOG9v\nTHRMSUF6Y0lCMUQ1Y2RIOHQ2UXVycDNVPQY7AEY=\n	2015-10-24 02:00:57.507184	2015-10-24 02:00:57.507184
305	04a881d14acb2f362f6c6d30edd7daca	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRZFAxeWhGMjJDNnd3VG9SRkRa\nNVl0NExWSDJNVFo5V3BaYWhWY3lEZXZVPQY7AEY=\n	2015-10-24 02:01:20.720284	2015-10-24 02:01:20.720284
306	1abade02be38ff4a7b38791e7865553b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFZTc2eUJjVFJ6YWxCNng1aDNZ\nMTdzSzhVK3BhbmdiVGRrRzEwR1JLZVB3PQY7AEY=\n	2015-10-24 02:25:21.439955	2015-10-24 02:25:21.439955
307	4c511f50a410ae34b2d4f929e59bcfdb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlSmtmWEJvTFFnN092YW5DMExS\nZ2ZmZ3FjTG4venl0d1lzMHpBZFczU0kwPQY7AEY=\n	2015-10-24 02:51:20.927614	2015-10-24 02:51:20.927614
308	7c673b9fb3523bfd1a545a00c32885bb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpYU91OUpYOHJreXdudUswYk1l\nYXp2aWVqSjB3YlY0eXhCUytkR2RSeHlVPQY7AEY=\n	2015-10-24 03:01:23.538695	2015-10-24 03:01:23.538695
309	c3163c3765f57e6d931a3c035a9dca1e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMT1JpbWFteFFQRkZyanBuUnVi\nSTVCQUtCKy82ZUZiTndxWXNGVUl0ZDM4PQY7AEY=\n	2015-10-24 03:29:16.75009	2015-10-24 03:29:16.75009
310	96ba4292acce13e7d667452d8925410a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaT0U5VXFlM1E4T2c5d0R5eWNI\nUDRsTURiaXBsYnBuUDhpY2Z1ajRidjBJPQY7AEY=\n	2015-10-24 04:37:24.041895	2015-10-24 04:37:24.041895
311	bf8a2818a959b7c83d29c6d1e3cf041d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFON1hDUHFIanFFTXRzbFFTRnlP\nNVdwMG1KNGJzV1R0NmdjK3lrM2FUSlpVPQY7AEY=\n	2015-10-24 07:12:24.725961	2015-10-24 07:12:24.725961
312	a8eb9434fbcd1f9e6433be146b1a0d81	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6aVlRRUo0c3VwTEU3QnZ6Tjlk\naGs5MzR6UGVTMS9ORVYxZldTeVRhZmtVPQY7AEY=\n	2015-10-24 08:20:24.588336	2015-10-24 08:20:24.588336
313	f9bb036c948bf4ec153efb9eea6facb6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzVkxQS05tQUduUlp1MStkZk5O\nVGE5QnZvNzBGb0daRVJwa3RMbHZYaUxVPQY7AEY=\n	2015-10-24 08:22:51.062526	2015-10-24 08:22:51.062526
314	719f4703b0c37285f3fd2cb076a0c399	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGbHBLdkRKV2dOdG5CdEQvRGp5\nbitOSXZxSDZLSGNwQlNlWGtKRXE5THRJPQY7AEY=\n	2015-10-24 08:37:12.035096	2015-10-24 08:37:12.035096
315	ca93da2897571c5a89fca2bf168012e5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKYUptSkJCa1lRWTBWQXZDOFcv\nUi95SmNRdndSRTRuUVFMT1ZCUVJjOG9RPQY7AEY=\n	2015-10-24 08:51:42.153617	2015-10-24 08:51:42.153617
316	1da9590d130bbf979a288821ebe26293	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzaS8zNzBTN1JCWTNQV28rWHNG\nSlZqalFFRjlkWXVzR091WUd4SXZYRE84PQY7AEY=\n	2015-10-24 09:02:53.458255	2015-10-24 09:02:53.458255
317	92f0ba48e404b9bd5f3f5d780c211998	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1WjBYajBvTlhvd1drWVJybTVV\nRm94dG9rVmdoRVEyaVl5QzBqaHJ5UzZFPQY7AEY=\n	2015-10-24 09:36:06.70604	2015-10-24 09:36:06.70604
318	d4f872890c01879b32ed86d1676b3b12	BAh7B0kiGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjoGRUYiCy9hZG1pbkkiEF9j\nc3JmX3Rva2VuBjsARkkiMW1jT0J3bWJRTXNJY2Z3ZFZYZk53ckZnaWZ1c1Vv\nUS9zSzNqT3RGUlhubXM9BjsARg==\n	2015-10-24 10:18:02.240297	2015-10-24 10:18:02.819035
319	0ca92651d3dcf17f590a3bc050267133	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGamRjQVBPQXlDU2h0cWhwR05C\nSjIyLzdES0pEcVZlVm0wd1E0aUF4VzZjPQY7AEY=\n	2015-10-24 10:54:01.040909	2015-10-24 10:54:01.040909
320	8669503d61c43b18887d36be93c323c8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyMFBKT3RBZzFkeDNobndDdGZB\ndUM5VmVrRHdhZXZ0N0xiSmxPblRlY21RPQY7AEY=\n	2015-10-24 11:16:17.830488	2015-10-24 11:16:17.830488
321	5439715e550c5e58e5517e5649bffa16	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0WkVOQWVOd29xVVBMODBwWkpJ\neXkrWC9vTzV4ZlpHRlVLSkc4UjQwNnJRPQY7AEY=\n	2015-10-24 11:26:03.833635	2015-10-24 11:26:03.833635
322	2b84b911bc50fa13e801883936fdcc77	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0dzk2UGdGdWVnQ2U1NjlnUm82\nYlZuenhNTk84eG1HdXdidnRMWnFQL29jPQY7AEY=\n	2015-10-24 12:07:33.502823	2015-10-24 12:07:33.502823
323	b68141767ed29b6ca84fa5dafb1bf8fe	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKR2pnWVU1WmxCbjJUb1cwd3JP\nOHJOTW1RdHllSjZjNXlGL3lOU05SUEhBPQY7AEY=\n	2015-10-24 18:06:49.598327	2015-10-24 18:06:49.598327
324	323bf934f80a27b24f4f2bd651046b62	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLTDZaR1NFTXY0U0Yxalp0dHdq\nL1JuSlhTUWtMVWo3YmNacmdkZUY5TDl3PQY7AEY=\n	2015-10-24 19:47:22.520709	2015-10-24 19:47:22.520709
325	a23b61ba3b8c3e58ecdda4cf8f63915e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoSzducFdNKzFJaUNtUHc1R0xE\nSVkrT01pdVVYb01tRS9ieW82RDYvVFRzPQY7AEY=\n	2015-10-24 19:47:27.764762	2015-10-24 19:47:27.764762
326	7ac1e8d17d19d1c82af5b330000109da	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1YUdEMzNINVRBTlRTQU9saHh5\ndndhQ3M5YVFFbjhKUnZLbFBMZC8zVjdrPQY7AEY=\n	2015-10-24 20:13:56.746142	2015-10-24 20:13:56.746142
327	69e2e5b6d40977a69ce7e8f27734ecdc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyamdhd2FZa0dIY3ZwTW9zQmtI\nSmFNb2ZxMzFDRnQxd3JRRzhBQmEraGJnPQY7AEY=\n	2015-10-24 21:14:34.979376	2015-10-24 21:14:34.979376
328	14654958990166a813235795873b414d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3VnRUMnJoSFF0clVVOWRmd00v\nL2Y0Y0ExYUpVRFo4bjJuTkkxa0lwMmQ0PQY7AEY=\n	2015-10-24 22:04:09.33394	2015-10-24 22:04:09.33394
329	a0a2368f2b6e93bd67873d9d1408500f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaUHM2RVRwYVE0ZWwyM05mU3lD\nVEhkZytic3R0R2REaXhJV28xcS9HT0hNPQY7AEY=\n	2015-10-24 22:20:50.727839	2015-10-24 22:20:50.727839
330	fc57a9eea224d5beb66713fc3c597ae0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuNHZsSFZWNFV5ajlieEFBWVpC\nY3JEWGM1MjhIU1c2SkhTK3lJekJyOU93PQY7AEY=\n	2015-10-24 22:54:15.657815	2015-10-24 22:54:15.657815
331	47306fe798bd63e81a457c07677b61ab	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxZHpIaHliNktJai9QMDJVYlhx\nMUJMaU1DWkNnQkZyNHpNbVBvSllHcnRzPQY7AEY=\n	2015-10-24 23:02:38.080896	2015-10-24 23:02:38.080896
332	d3a05e31c87b28f651a38c9bc7ce8b75	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxT0FuVFlMUUVGTHV5STFTL0c5\nSU1MLzYwV2pMU2J6QW5QdGpyOFN2VkN3PQY7AEY=\n	2015-10-25 03:39:42.896491	2015-10-25 03:39:42.896491
333	01489463be71d681371d14a31b2511e3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzUjZYYUZScThqZ29ib00yWDN5\nMmtqZU83SjVJUWRZTUhhRkdTV0Jtd2pvPQY7AEY=\n	2015-10-25 03:51:43.08419	2015-10-25 03:51:43.08419
334	718d10c609c3211cd6ae06aee5828aa6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2N0hTYUU5aVZQRmlUR2xRQ2ty\nNWJUdlF3RkFKQmVPc0t0VzE5SlJCanJNPQY7AEY=\n	2015-10-25 04:48:51.369339	2015-10-25 04:48:51.369339
335	f4f60b08b20c5724ffaa6dfcdda37bdb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRVEpkVDdyUk1FS0hvdElXL1lp\nb1lsdzBCc3d3Ujh5dEYwUzlwNXI3dzhnPQY7AEY=\n	2015-10-25 05:27:48.864574	2015-10-25 05:27:48.864574
336	fac92966bfef5850e736abcf2ebea797	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0ODVYRFRsZnVIeTJycm4rRTlM\ndTFzZDltWFFBT2FZdkJvNjhvMExHMlRjPQY7AEY=\n	2015-10-25 07:24:59.550911	2015-10-25 07:24:59.550911
337	adfb67742eb3b640fe0e78c8affabe7c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBZUwyRm5Vb0VCN1hmQ3E2T0VE\nTnIzemJJSGE3S3J2dmprVFNpYnUvdEZRPQY7AEY=\n	2015-10-25 07:59:20.813437	2015-10-25 07:59:20.813437
338	3c11cb1b8b874ada9b5b109c4f42b270	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTWXlBVGd5UkFuYy9GQ3NkYnJ1\nTjVjU2l2d2t0cjMwMjg0TklWS2pZOVdRPQY7AEY=\n	2015-10-25 08:49:47.953964	2015-10-25 08:49:47.953964
339	9db9adc6574ccffb6c1605219d3b935b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFUUdsLzNPK21HZXhad2VZb2tC\nWUc0emg3RFY5UmJubWNOSVROazNoeDY0PQY7AEY=\n	2015-10-25 10:39:19.49363	2015-10-25 10:39:19.49363
340	4697dc79fd1d4abb9d70fa8a3c67d19d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxdHlnNUh0VDJrektvelo3WW1w\nUEpsZVY2RU9KbmtjSWZ2S3RueitPKzU0PQY7AEY=\n	2015-10-25 10:44:43.26835	2015-10-25 10:44:43.26835
341	7f4aa4f405026a2e97ded08039d82e18	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmQU9YcUF2eEg3MG4vbFViTFpi\nTkExNEgxQ0NiTnBmeURrUWNoK1c0VDM0PQY7AEY=\n	2015-10-25 11:06:49.389489	2015-10-25 11:06:49.389489
342	c2ce788d672297d9a4c3bd0940ba1369	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1U1BaRzBac3RpWHVsNERHZXZI\nS2NYTnBsOWJpZ1NGcXg1NVU2Nk9PeW5RPQY7AEY=\n	2015-10-25 12:06:07.074283	2015-10-25 12:06:07.074283
343	d652c1de15db3939ceeba5464f171c3f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwVUJNaWsyTWIvY0JhVzJKQjhT\nTUdMVlNBUDZzT2d0d0dacUg4RE5CeEIwPQY7AEY=\n	2015-10-25 12:36:02.442333	2015-10-25 12:36:02.442333
344	de9a552fa02063791fa466a68ec874f3	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFURFJocjNaSHhLWUJXeHJXY25m\ndVZ6UUdnK1VFd1hyVnhkRWpXMzVqMjZnPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNzYzMzYxOGIyMjJhZWRjZAY7AFRJIg1vcmRlcl9pZAY7AEZpHQ==\n	2015-10-25 13:22:50.011054	2015-10-25 13:28:56.730854
345	6d17bfcd80ec515a87e06d5a9127204a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvM21oNWR5bFhHRFYzbVI1cXM0\nZU9IT0lIdGlvVDIxSjdwODhSMTI0Q05RPQY7AEY=\n	2015-10-25 13:35:02.720343	2015-10-25 13:35:02.720343
346	253dfee4813da7f5f9ddd68ae58857b1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOalRmZGVTU0JYcWRWU3B2R2lj\nWFNWcHZlWHppZFh2bi9uZGJZWmZPQnhzPQY7AEY=\n	2015-10-25 14:02:54.632444	2015-10-25 14:02:54.632444
347	fcc0a4f4a4d2a807a793ed279765a7f4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPc2R6SkFkU1ZkTDdzUU03VHlk\nVDA4dmorZk44dVZlYkpKcFI2SXhsazlVPQY7AEY=\n	2015-10-25 16:44:58.295351	2015-10-25 16:44:58.295351
348	56db59f0059f9778255ec1688ec204f2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCaFpuNWIyUlFlWkdJUW5HMTNC\nS2RnMXdheCt3eHFGQkpBaldSR3NnS05zPQY7AEY=\n	2015-10-25 17:04:29.661611	2015-10-25 17:04:29.661611
349	cdf27a0d24053629c811c86ab00bc599	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFVmJrc1hBQ1dqMzVadlBLNXcw\nZlBCb1IvQVprVEFwMWcrdEF6R3l6RGJNPQY7AEY=\n	2015-10-25 17:24:16.775478	2015-10-25 17:24:16.775478
350	c7d3ff074ed1540302a7f60377a54b9c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrWEN5Z1ExM2h1cFhBNlhiMTlB\nc0pUcGJZNlF6N25nTGxSMXNaTmV0SXowPQY7AEY=\n	2015-10-25 17:24:20.026221	2015-10-25 17:24:20.026221
351	c72014fa797fa13f56a54fad0bb5e07e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF1dHhpMFhyS3A3bkpzeERTMDhF\nZHRRZ0g3T2M3MlRwNzJyaTA0emhkWHRJPQY7AEY=\n	2015-10-25 17:24:26.093729	2015-10-25 17:24:26.093729
352	737d1ac41e28e5eb6180ceb21c801e02	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKTGhZZ01VZTlZaE1SenpoK0JL\nSDJYSWxidHNhY3dHSHdDMzFqKzlXWnhnPQY7AEY=\n	2015-10-25 17:24:28.873264	2015-10-25 17:24:28.873264
353	b6ceed7dd7ed91d8ae4a486343906047	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSS2dyV1M0WkYrNCtndGhYWnZU\nUzBPaVp6eEt4VDVGQVRSak5WQm4vWmhFPQY7AEY=\n	2015-10-25 17:24:32.662772	2015-10-25 17:24:32.662772
354	8fe8d2a69a485411dc35edb56ec3421e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4cjhuUDA5WjlaWnZVbHVxczJ6\nQ1VYWWp5aFJoRHZMYnlLVGhjQ1d1dktNPQY7AEY=\n	2015-10-25 17:24:37.769398	2015-10-25 17:24:37.769398
355	ae161f4cd9f0856a3c8bb4a9bc11a7f5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBaTYxdjNYYzgxeWJkc2x4dUlp\nK0NoV3VPNVZOUUk5Mzh2ODk2Y1hQTXYwPQY7AEY=\n	2015-10-25 17:24:41.16462	2015-10-25 17:24:41.16462
356	99f648acd1306c840675bc5e68315166	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErR0V6Nk14VW9DVVhBN1dqSnFj\nbDdlSFcwNDF2c1FQS0E3R2pxTjliOW04PQY7AEY=\n	2015-10-25 17:30:18.583986	2015-10-25 17:30:18.583986
357	a946b722b2d6afc41eb523a677a1a441	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVQVVtVGNGWWV3RDk4YWQzajhJ\nbHU5UjdoL0VGV1QvaWpuM0MrRlJxL2pnPQY7AEY=\n	2015-10-25 17:32:23.281594	2015-10-25 17:32:23.281594
358	55dbbe325e7abefebc5f07e10c32c9d5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwY3g2S2dvaHpvYmFOTTdlTDI0\nM05QZWJtNVhMTGlVSnA4cWtDd2Y2RGRBPQY7AEY=\n	2015-10-25 18:08:32.710623	2015-10-25 18:08:32.710623
359	50d478405042376c258cb013e04b5a5d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5V1IyVHVvN2xEZ0dTMjl6Q01P\nczJjS0hDczBJcFF5RjJPb0FQOExaWTRvPQY7AEY=\n	2015-10-25 18:35:52.541176	2015-10-25 18:35:52.541176
360	8aa1a45ede40686e5826c758488594d5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0USt3SGZOTFNwN3VKd0RHTUEz\nY01hZ0gyNTAwNDdEVXhBMkxNdmI2cWxBPQY7AEY=\n	2015-10-25 21:17:47.563881	2015-10-25 21:17:47.563881
361	9f8e3b9a6508188d1fc8be6feb4899c4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2cWxjQjkyVmhaUmJMK3I3aU1n\nQUpoTWVESVZQY3ZMdzBkQTNyRnorKy9FPQY7AEY=\n	2015-10-25 21:29:48.461846	2015-10-25 21:29:48.461846
362	666e10c1ff7104e777e12e6d3b765246	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDQ0NmSXNaR1o3VlRoOHY5WDQw\ndnFuQ2VaY2l0RE9UdmM4OVdrOUhFY1VvPQY7AEY=\n	2015-10-25 21:54:37.354003	2015-10-25 21:54:37.354003
363	d36e24149adf9fc35005514def65c304	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsK25SYk1QMFdEVW1hMXpmMGJY\nU0M1WjhzQUdPaCtMeFUzc0VrcTZYUXhjPQY7AEY=\n	2015-10-25 23:43:11.839521	2015-10-25 23:43:11.839521
364	4e7c9e7977a88a3f09e2acc87277522e	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVZjIyNjRkNGM0Mzc3YmQ3MwY7\nAFRJIg1vcmRlcl9pZAY7AEZpHkkiEF9jc3JmX3Rva2VuBjsARkkiMXMySDQ3\nZDMyWi9xSUFQaXpQcy81VWlUTGNsU0Raa3lwKzdUVG5BYVNDZGM9BjsARg==\n	2015-10-25 23:45:06.50569	2015-10-25 23:45:06.50569
365	acc547b9e48ee508882601055a84bf23	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqQVNkQXhkNzdJb0hHS2E4bG9u\nQU1JM3p1aEgvWTVQOU56WVQyeHROSk9BPQY7AEY=\n	2015-10-25 23:50:38.833042	2015-10-25 23:50:38.833042
366	05bc8570b9e524f9c27601bd4df37178	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHSGZaLzhTRVFuNjV6c1lqS1dP\nZ3Z6cmFsVnZnZG9FcG43SldhZWZWcUNZPQY7AEY=\n	2015-10-25 23:53:39.786318	2015-10-25 23:53:39.786318
367	b9d7d753ac89060262a87b3898c6cee1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhTzZkZ3FFV1RINXZ3Q2ZOOFpK\nSFBxdlowVmY3RG9tWnhrazdrWm5QUkljPQY7AEY=\n	2015-10-25 23:54:16.917247	2015-10-25 23:54:16.917247
368	120d490b8d85407518da6ff30641ceaa	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKWm5nV2xOd1U4cHRXM3hyaFdz\nMEVnY2t1ZXluM240ekdMVnFTb00ySXZRPQY7AEY=\n	2015-10-25 23:54:42.095894	2015-10-25 23:54:42.095894
369	3ee114dd4be5783151bd940763eb76e7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyVVk5QVB0d081TmxucGpQeHdJ\nVFBiTzFzQlQvL0NsOTQrN0ZGTXhETXRzPQY7AEY=\n	2015-10-26 00:01:26.255907	2015-10-26 00:01:26.255907
370	5159ae69c9bf29744cb846788320fd8d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4ZFlKRFh1N2o5K0JzUkVZNVpr\nYjVNV1VJWUw1NGtMYzFsY0l5QlRTSkZFPQY7AEY=\n	2015-10-26 00:39:20.469798	2015-10-26 00:39:20.469798
371	c8db55af86967253eb3fee780e5d2d9b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwM0Iza1NWQU1GTys5djFBQjJ5\naW9PbnFHcmRRU04rRGhlTTIwdUJWVng4PQY7AEY=\n	2015-10-26 01:08:27.953076	2015-10-26 01:08:27.953076
372	c31a3c5adbad481412685b502ff28d79	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwQmRBK0wyTFMrKzZsaC92ZG03\namR0WDFVRVVGdzF4MHV0Tm5KY2RnZkpNPQY7AEY=\n	2015-10-26 01:36:02.407954	2015-10-26 01:36:02.407954
373	c0bec4be947665ed47926358a03ca3bd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4bVJ3YlZXb2pIWmJDZVpxeHNs\nTWdTa3ZJaGlOMGcwbFJMQTFWdHVBeHlZPQY7AEY=\n	2015-10-26 01:37:07.24333	2015-10-26 01:37:07.24333
374	8bf044bb920f150a7559d1b695ce0979	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjZk92cVNHdis3cWhUUzVjZGJD\nUFRPRmF1MEZMVm5TVFNqNXlCc2lBWE44PQY7AEY=\n	2015-10-26 02:23:46.090315	2015-10-26 02:23:46.090315
375	b889c01ba72d7a056ea09457ffd6399b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOK1pSemgzeFZOaENBZzdackxa\naG1QTFBwaTZsZm9DWnN3STVhRnhheEljPQY7AEY=\n	2015-10-26 03:04:09.354017	2015-10-26 03:04:09.354017
376	b1241dd2e5b849c77a05ea4f3bc1f053	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvTjYxVndGOHBNQ0t1T09BNlcx\naEZVWjlncXJWTDEvOXVwWUtEUmMwa0k0PQY7AEY=\n	2015-10-26 03:04:16.575995	2015-10-26 03:04:16.575995
377	979ad07bb7deb690b2e1ca55036eba79	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoSU05MThhQkJiMEorL08wYllI\nQi9GcE90L2g5Vy9GWFVLVU1FWmxNNTdvPQY7AEY=\n	2015-10-26 03:54:26.048879	2015-10-26 03:54:26.048879
378	5a46d0d557af6c1efd5131e418ff1c02	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2Y01SVlpHZENzdXg4ZVE4cEtr\nQWh3RTgzS2xFSThRSlhyN1BqekRJTzZvPQY7AEY=\n	2015-10-26 03:54:27.396262	2015-10-26 03:54:27.396262
379	68cbc26d109f8a656e90ae632561585c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3RkpMYnd0VUxESHE2SkdzQ3Ar\ncThjNVpVaTNUdUlNVXpQc2g0SG5FOG04PQY7AEY=\n	2015-10-26 03:54:29.371457	2015-10-26 03:54:29.371457
380	766b5677f36bd29a902fb9b78955c5aa	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOeFVxR3ZyUzdraFMwdFI1UnBQ\nMHYveWtnbE52K1VnN0V1REovaDViUnZBPQY7AEY=\n	2015-10-26 03:54:30.172361	2015-10-26 03:54:30.172361
381	49cb3ad60b7da36296ec36486e9eae06	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDZUh5dUpnQTByaXZFUmlyeXhR\nS2I5eVQrSENOc3hudmlWVFlQa2tDZWxBPQY7AEY=\n	2015-10-26 03:54:31.436189	2015-10-26 03:54:31.436189
382	417b7e2891ba4bc9f4da97d9a50f096b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2M1BpRmhMTDRrNnc2aUZUS0tJ\nOUkwKzVyalpnWEJsMlJVN0lQazZudEp3PQY7AEY=\n	2015-10-26 03:54:33.054545	2015-10-26 03:54:33.054545
383	b7ead4ad94551dedeab6599aaff80ba6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaRDNMRCtQb1djYmRaSkVZaEhy\naER5cWNWVnBqa1VYR3pEeE5TaTA3MDdFPQY7AEY=\n	2015-10-26 03:54:33.974337	2015-10-26 03:54:33.974337
384	e6b42df3e4819a514d887b5f5c9dd700	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnbzFuWmx1cjZOSEkwa3VPOXA5\nZSs0Nit6MU52UG1odVM1b2luc2pBUjg0PQY7AEY=\n	2015-10-26 04:25:05.966124	2015-10-26 04:25:05.966124
385	b0a05888dc6f509e3500c75acf5fc6e9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFERGRVRUhJK2ZDUkplN2dUbUVC\nbjl2eDhBZitxVWtFR1FHc1hGbnJUZDlJPQY7AEY=\n	2015-10-26 04:30:59.680868	2015-10-26 04:30:59.680868
386	b96625969fe726568807908a2b652779	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWdlEwQUVEL3VVdkNWYUs5Q2Jp\nZGh5SE5wSy9FR25tTERQSURGWFpkbFU4PQY7AEY=\n	2015-10-26 05:10:59.247619	2015-10-26 05:10:59.247619
387	49ddb3d87081903dc03ff1516a866ccb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIV2NLMG1IcG1oSUxaOVRTS2tp\nWG5GbW9MR012TzBaVWhvRjYxd21WRDVrPQY7AEY=\n	2015-10-26 05:51:30.876637	2015-10-26 05:51:30.876637
388	249dc0d0981beaed6219b37e0a3730e7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErVEE2am9Oa0VhUm9TTE9ySGhp\ndzlBMndFL21Kenh2c0V3OGVxWlY3a2NNPQY7AEY=\n	2015-10-26 06:26:25.50591	2015-10-26 06:26:25.50591
389	460242c591f49ba0b396ba52133440a4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6b29IMWRqditoczFTTDNQNDE1\nUEEzUndGN3Z2MW15Q3czMGpqbW9pOXM0PQY7AEY=\n	2015-10-26 07:05:37.753621	2015-10-26 07:05:37.753621
390	f772a79152795a858de5e957813b3e4d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmcHFsWUFacEpVUFFtcDgxYTg0\nY2FNYTY3R0lLeXQ2UHJGVWZUeG0wWEljPQY7AEY=\n	2015-10-26 07:31:47.979629	2015-10-26 07:31:47.979629
391	113b571f908fc58e73baaa78172f65cf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyNWFreHZNdUdVQ2JIc3VqTjhk\nK1greFB6K0o1Qzk1ZlQ1NkhuZ3ZjZ240PQY7AEY=\n	2015-10-26 07:51:07.419474	2015-10-26 07:51:07.419474
392	ee16f4992bc994426d1778e6cd1ad2ed	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzcGw0ZkNoT0RDQWlWY0NjREdt\nc3ErVHZvSklKUTBBZzBjZHdUd1o0MlRNPQY7AEY=\n	2015-10-26 07:51:08.932101	2015-10-26 07:51:08.932101
393	7ae5d204e9212fe7901a5f1e1e4395df	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5RU1xZjBWWDBUOGswdUFQYWti\nR0t1MjZVajl2WnhVT3JyTVI4WCtpNEZBPQY7AEY=\n	2015-10-26 07:51:15.133563	2015-10-26 07:51:15.133563
394	80af02b2523a28e53690bbcce1ea19fe	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2TG9XaEtjZ0RXN1FWTlNjejhR\nUGRFWlFwQ0J2cVVmdUtMN1FXdHVOb0JRPQY7AEY=\n	2015-10-26 08:29:55.105373	2015-10-26 08:29:55.105373
395	9469310697978a87784a12d9f4452192	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaRkRKU1FmeHBPTUptY2I4SUhE\naXVyMkdJUzdSVHZWR0NXNEhVMmhTbVc4PQY7AEY=\n	2015-10-26 08:48:46.913374	2015-10-26 08:48:46.913374
396	9280894a8ddcba07cfe3e7a02521378e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLTllKc0lXNzI3cVRnTVhWZmZx\nY1dNVjJ5UXhTdGE1VVJWdnY5OUVuaDBzPQY7AEY=\n	2015-10-26 09:43:59.325326	2015-10-26 09:43:59.325326
397	324185b2b574888180fe9eac046a22c1	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFodjh4RWlKU1Fhc0s0S1Y2eXRp\ncFVvKzRpVE1NVitLZU1rcGgzdXBjVFFVPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNTgwMTJkNTJmNjg4MTBkYQY7AFRJIg1vcmRlcl9pZAY7AEZpHw==\n	2015-10-26 10:50:26.518653	2015-10-26 10:51:02.54874
398	d8da59bc6a8f8765ce074295fff08de0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnU05vY2hTM3g0MG5sbmd0eW5z\nWHNMZHo0bTlnUVRESE1lS3ZVMjdQR0t3PQY7AEY=\n	2015-10-26 11:19:38.486183	2015-10-26 11:19:38.486183
399	e35f511c80ab840b66f4f713c64579dc	BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNNUJkalkvWlB1K0hWaDJvMGJX\nS0k0b3JuWDZqWlA0b2ZmaExtZGdlMlFjPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVMjczMDZlZGQwMDYzOTE1MwY7AFRJIg1vcmRlcl9pZAY7AEZpIEki\nGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjsARkkiBi8GOwBG\n	2015-10-26 11:21:03.252177	2015-10-26 11:21:53.171992
400	b1a5f345810a6f6b9a39f81f1a0ac22f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyWlpVTnlXNWg2cC9BREdXRzBG\nUXY3c3YrcEluU2RsektPSWpRWnVPMTBNPQY7AEY=\n	2015-10-26 12:51:29.786416	2015-10-26 12:51:29.786416
401	4026104fb2e5ad11de0db1a4d2e0fc8d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaSHhjSklHYmhPWTRLaW1nT1pa\ncGZmdldjYVM3ZkswYlRMYkxJem9sYWNBPQY7AEY=\n	2015-10-26 12:52:36.102424	2015-10-26 12:52:36.102424
402	7ba1970ebe3e3de1fc7c5be9c244a86f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSb25uME9zWWVTY0RubjMrK3Va\nWTZ3bjRXWXFJbXUzUXBmRXdWckFmNXlrPQY7AEY=\n	2015-10-26 12:54:40.892366	2015-10-26 12:54:40.892366
403	30b2c0f3fdc2e9008671ba531ae1cfea	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLTStHZHA1dGlhR0xyRDdrUmF4\nZjdUSm5wNmRKUFFTa3dCbU9FQytmN3JFPQY7AEY=\n	2015-10-26 13:30:21.301083	2015-10-26 13:30:21.301083
404	beee80497133909bdce259967fe4ab99	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUckNoV2xCMjZ2NkhDaTFwUE1B\nTUlIK0tHT3lCTWxmUlRaTFNQT2ZVT0hVPQY7AEY=\n	2015-10-26 13:31:16.894474	2015-10-26 13:31:16.894474
405	9b61656a9ea83defcb19ac41cf3dd22d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5YW5mOFZtYWJwVVVQVDhYSzE0\nSDNtN0NYZVhPRjRHRk95bSt6YUpLdWowPQY7AEY=\n	2015-10-26 13:57:46.887305	2015-10-26 13:57:46.887305
406	d65e4c2fa05cc6740091da41af07b38f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6UGdmdFZwOEVmR0xMYVN1YmRq\nbkMvck5TNkVnYStNMkVwc3dqSzFRMlBvPQY7AEY=\n	2015-10-26 14:55:44.250989	2015-10-26 14:55:44.250989
407	6000b0db7b5a1f8ac8cbd0387c08baab	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDM29oSnZ4dExwLzZMUyt2OXYv\ndVMxRDN4Y1E4NWFoMjNJb01rbjZuMFBzPQY7AEY=\n	2015-10-26 15:06:55.008768	2015-10-26 15:06:55.008768
408	3fe41201521b72b3ea4ff95fdf32f2bd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaaUZXM2VsTWQ5dzZRN1pZNVM0\naktXcWk0eWdUZlo2YXE0YlJjMGxEUnlZPQY7AEY=\n	2015-10-26 16:13:57.069161	2015-10-26 16:13:57.069161
409	3ad21f4a11b7ae743a32c89495b5c862	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjTDhkRjN6eXR5RUlhNzQwaDI0\nYm1CNFUzWGl0ZjNnUUprL0RVWnhsZVNRPQY7AEY=\n	2015-10-26 17:58:57.701896	2015-10-26 17:58:57.701896
410	825907997361e3dd388ee4c13295bb3a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0YnA3Z2xEeGZxaHFxbENTOS82\nQkt4ZndPWUZUMzROMEwvcFRablQ3aHpFPQY7AEY=\n	2015-10-26 18:41:42.574883	2015-10-26 18:41:42.574883
411	d1d0ba16aa3d3eaa67205cece4664577	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVZTllZWUyZjYzZjIyYzZjYgY7\nAFRJIg1vcmRlcl9pZAY7AEZpIUkiEF9jc3JmX3Rva2VuBjsARkkiMU9sQ2Fu\nVWxQYlhCdXdNaDRWa3J5OUlzd05oZ0dhVzB2Qkp3TG9ZWm9HaW89BjsARg==\n	2015-10-26 18:58:45.230773	2015-10-26 18:58:45.230773
412	b3f00744bfd054abc6c8f4c232ebd6a8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoRDhSTWp6UDEzYTRFbGg3ZWth\nK0c2aENseS9uQkxaV1RKV0p4NlUwZHZNPQY7AEY=\n	2015-10-26 19:09:27.332099	2015-10-26 19:09:27.332099
413	c8500f682e3c79863ccba091983e6169	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHUWRSaW9ydG5CRFJ4WXNJOVRH\nVW4vRkhlTTJaNWxaazRNNC9ianhQbHRvPQY7AEY=\n	2015-10-26 19:20:49.611351	2015-10-26 19:20:49.611351
414	3d40c9d43f72d7419d875b8a2e497b41	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3bHZVanlvaExFSzllNEwzeU9R\nVC9RRHJBU2JxdFZwanRnRk0vcVA0N2dZPQY7AEY=\n	2015-10-26 19:47:35.300481	2015-10-26 19:47:35.300481
415	92515a5b6a9da45b9a2be65d62a322b6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUMFdoS2NFNC9XRTVDN01hb1Bj\nb01TVVRVT0ZvLzJDUTNTUEVrd2VYWkxZPQY7AEY=\n	2015-10-26 19:47:40.541845	2015-10-26 19:47:40.541845
416	24fff18fa84f8718c066b1a0e816bae8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4dlZNMXEyUTNGOFF2WUhlUXMv\nem5RY0V6UUlYamlaTFlFazNkS01kS053PQY7AEY=\n	2015-10-26 20:29:04.914047	2015-10-26 20:29:04.914047
417	b3a69f62f6cd8e62fc858567c06deed3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3TmZ0NWpvM0dCdVUvRnphbXM5\nQnkvT2Z5WWQwUjBseUp2T1NoQWJUeHNjPQY7AEY=\n	2015-10-26 21:40:47.934371	2015-10-26 21:40:47.934371
418	a255a39c60d3eab77edd384f6c651d05	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBNEtsVlppUko0TUhDRmxvOHBa\nanFadkczbEtzTHdWMll5WXVKSHJNY01rPQY7AEY=\n	2015-10-26 21:50:00.137314	2015-10-26 21:50:00.137314
419	2f8eb3a29497a95deef8d27d77439228	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzRmJabEJZVFpMTGh1MTZDT1dO\nTm9GaXZpWUh4SEsySzROak8wVjh3SGRRPQY7AEY=\n	2015-10-26 23:19:56.741863	2015-10-26 23:19:56.741863
420	06ff7429f184ae0d1412ce0ee4e462d4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqaUloQ1J5bmF3a2VwUitrOC9F\nSnI0TWVoTU5mMEt2RjBJSFJLUU5zUmNFPQY7AEY=\n	2015-10-27 03:08:14.428758	2015-10-27 03:08:14.428758
421	82fa18765402a2a54b0a6a547a3e1164	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxTm1Hd3VqKzVpQUdZNHlsc2Y5\nQWFvZTg3VnpOQm43bDh3bkdueWdyNGNZPQY7AEY=\n	2015-10-27 04:18:40.024609	2015-10-27 04:18:40.024609
422	0b5b6bd79f153e6fc91a428f431d01d8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoWVcwdUV0NVpubTRyUDNxS04v\nS0p5U1FwMTZXdUJBa0NJOWV4UzBOZGpFPQY7AEY=\n	2015-10-27 04:27:54.604287	2015-10-27 04:27:54.604287
423	e888da9e21b7fe4d8990f1dba470a8cf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTMWx5MmFpVHFzWXQ1akp2enNV\nbURmVWc0ZlM2aE5aNEVzMjJGM2VKa1J3PQY7AEY=\n	2015-10-27 05:13:43.987309	2015-10-27 05:13:43.987309
424	0552e74eba6ccba01314f84c33c2db3e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4REZCdzR3aHdqNWJlZFdFOW83\nV0w2eDFYSm5Lbkh6M0hDOTNsSHZrSWZBPQY7AEY=\n	2015-10-27 05:29:24.136594	2015-10-27 05:29:24.136594
425	365a121b9602dc8afe108dafe843b525	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNdXRHK3lhaWt5bTAwR1ltQWV1\ncXBhYU1HbUhFcFk0dGRHMElTTDNBS0hZPQY7AEY=\n	2015-10-27 06:56:10.363776	2015-10-27 06:56:10.363776
426	ca071720eb85d56b5d69a2714f64009d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4bmtlVGhZb3M5M2tMTTFCWkhO\nV3RZSjE2TlBCSW9NQ0ozOHhtR3Y0dThFPQY7AEY=\n	2015-10-27 07:25:31.711314	2015-10-27 07:25:31.711314
427	11fcdb3349648809a57822dc8d8a11ec	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHVHRUN3ZHU2JiaTNDR0UxL0ZO\nMkY5SkNNOER5U3d5S3lyOGRIbE52dzdzPQY7AEY=\n	2015-10-27 08:20:59.333086	2015-10-27 08:20:59.333086
428	665792b1b1e96e25c0933893162dbc10	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFROC9IeWUycEJGa2JWdDNwM2VR\nMWxUeTI3MDlZdnZHeG1oV0JtbFlIUlM0PQY7AEY=\n	2015-10-27 09:03:40.301689	2015-10-27 09:03:40.301689
429	255251d7f20d3c05db392b957a142753	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHMkJGbWQwTy9kOUFJcmdLK3Rr\nR2lYZFZNTXhRVUVCR2I3a24wKzYyZHlZPQY7AEY=\n	2015-10-27 09:56:09.911783	2015-10-27 09:56:09.911783
430	c90c0acccad247fc50a97ceb05b23953	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYMVZ0NnlXaWdyODFHOWVMNHZY\neWFGZ1QyTHVTMG1CNkRaa3REL3dXN25jPQY7AEY=\n	2015-10-27 11:02:48.405309	2015-10-27 11:02:48.405309
431	6e3d79090f11f3782afdeacdcf998e79	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTL0plTkxLL3RhYUJJRFJSZVh4\nL1hwbG96eUFic1lVejNyTmpkZWlsYm1jPQY7AEY=\n	2015-10-27 11:11:09.913112	2015-10-27 11:11:09.913112
432	b1743effe133b12a6e1f2493269673a9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZWGViK1JENFNPNVE5c3N6QWdY\nbmlHRGJQRmQyRVhCVkxqUm1VcXVkaEk4PQY7AEY=\n	2015-10-27 11:16:58.361433	2015-10-27 11:16:58.361433
433	bade9befc0ffa0db7f776ebb8db2c9e9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2RDNNajhHMTZXTVVEY2xoTjAy\nNFlDUDdqb2p1L2FMUDk1dzVCRENSQndvPQY7AEY=\n	2015-10-27 11:34:37.593231	2015-10-27 11:34:37.593231
434	c9cfe7c081b8ea21573c62e633f41518	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXOXBCQ3h4V3RxQitjR3VyeEIr\nRS93bDBtM1pQTnVHZEpadjVMZXgybVVJPQY7AEY=\n	2015-10-27 12:04:42.140219	2015-10-27 12:04:42.140219
435	accf10ebe7e39c2226bfabbbbac15711	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF1UWxCRWJ3TjBtK0ZDa3oza0R0\nVHZacGFqbWhYd1hJOEFET3oycTJuZTJvPQY7AEY=\n	2015-10-27 12:06:20.70948	2015-10-27 12:06:20.70948
436	cba96f80ac90ec93c49f2e524749ae94	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6VHA4M28yT2lkSVdqejk4MzIw\na2ZvdGU2MTZqMzBJZ1Qzd2lDVkVCYytjPQY7AEY=\n	2015-10-27 12:21:34.653172	2015-10-27 12:21:34.653172
437	f01dffa86d81c694b7a97a9909ea07ec	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5aHZaVU1sck9Da05Pa25qNnZj\nOUdaazFHMit1V2FxdGpTOWgyN2p1TXRvPQY7AEY=\n	2015-10-27 12:42:06.350509	2015-10-27 12:42:06.350509
438	d5c2a0951465f59bf021e55d179ed37d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpRE5ubk84ZGs3emp3MFBqd20x\nRXNXaTVKeW14ekdRYXNuN2lxeENJWTlrPQY7AEY=\n	2015-10-27 13:11:10.205799	2015-10-27 13:11:10.205799
439	534926e615991bf971ca8af47f9886d3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuTTliREk4cDZ4NlpUaTU4Q2ps\naEtIblRkT0pOVm8xK1NsbDg5N3BjVnRNPQY7AEY=\n	2015-10-27 14:04:19.810437	2015-10-27 14:04:19.810437
440	531b7e2d8daacf71593b1956c26ba67b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqb1FFMGV3ODljbS96bWtFQmto\nU2ZJdkdhMEVFTGNLNWY1czhLT0VpODlnPQY7AEY=\n	2015-10-27 15:03:40.194776	2015-10-27 15:03:40.194776
441	e9dc8141913f08f81aca9f26fe689d61	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIekNReVNpMWgxcW85WXV2R3Bz\ncmZlc05qWGg2WlhzMHF2VXpCYSttMXpjPQY7AEY=\n	2015-10-27 15:20:43.222312	2015-10-27 15:20:43.222312
442	38c4a21e3f6995bbf79895ecf8dd784d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhK0U1NWlYUThtWnFyV1hWV3RG\nVW9nTnpkendOQ2ZpLzVEdG1Kb0s0SmpFPQY7AEY=\n	2015-10-27 15:51:34.560173	2015-10-27 15:51:34.560173
443	dc275daab43f44020622393a306ff6b0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExc21Sdlc3WlcydGxhVzh2Y2Uv\ncGZrRFg4S05HLzR1TUx2cURTQzZFZzAwPQY7AEY=\n	2015-10-27 15:51:39.679705	2015-10-27 15:51:39.679705
444	73c6c688291617fc94d3f9531e1f1cb6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsNTZWMFM4MCtGam96Z2hFaVM2\nbFZlV1pUT1ViQzhrVzNUS3RLdjdDWnFnPQY7AEY=\n	2015-10-27 16:26:11.347587	2015-10-27 16:26:11.347587
445	c3b654d1040986c38e28fa4819c446be	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXcnluTEY3TzU1TXF4d1U0YWFo\nYXAvY0hIdFZpcWpLc1VjbWEzUy94NjRVPQY7AEY=\n	2015-10-27 16:48:39.942635	2015-10-27 16:48:39.942635
446	b8921ff23cde3bb7dff2e4f0339aa65b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkbVZ4MVV4eWdJeTE2Mk1lRnJy\namJPMTd0ZWpBNzBMYmFPL1hETFlWblUwPQY7AEY=\n	2015-10-27 17:56:10.653742	2015-10-27 17:56:10.653742
447	6d52fa54035e2960e387c0176152c314	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmdU0rc1pmaFVGU04wLzZSamNI\ndTRKTXRTb2Y5MkFXMjlUdHU2Q3FWOS93PQY7AEY=\n	2015-10-27 18:25:20.969649	2015-10-27 18:25:20.969649
448	84f445dcc81042af6cad1028b7a6aa92	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHQ2ZtTU5yTGpEc3pEZXRSQkh5\nTmIvOW9GcXc1OE11ZmtDckRlN0pnY2FnPQY7AEY=\n	2015-10-27 19:33:39.939789	2015-10-27 19:33:39.939789
449	7f908558ebfad116eba67fe103260d5c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5eU1OQjVqNDVIVzdrREp4eWxR\nUkw2VkVnM1hENFZ2ME4zY1ZhTWJ0UVpVPQY7AEY=\n	2015-10-27 19:50:24.659749	2015-10-27 19:50:24.659749
450	6a93c26f6f663d18671a500ec8b1f215	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPZHRiOFp0SUFzTVc1dlh6WmZk\naERTVHRlMnZSc0JuaXJIRytPQmZaL0xnPQY7AEY=\n	2015-10-27 20:06:13.819469	2015-10-27 20:06:13.819469
451	7bf4915b7a7a8bb2da438f976c61750f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3RndKOTE4VUMzeEF0dHg1NEtt\nb0ZaUWxYS3BJWjJLODNFVWRSWHdFaFBVPQY7AEY=\n	2015-10-27 20:33:40.219104	2015-10-27 20:33:40.219104
452	0fa767932f821a4d8cf2f8c77d10c275	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyeHU1L2N2b0FCajJOeG5LTHJx\nY3hHRnlXNEtjVVZ4U0x0bTFHa2YwT2w4PQY7AEY=\n	2015-10-27 20:55:37.211437	2015-10-27 20:55:37.211437
453	05a3a114769b30fbf227e527ceae44f3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4S2dPdzcrR3lQTnlnZ2RwVTht\nV0dwTFdsMFR1QjlVSG9DbXlGdTllZGhjPQY7AEY=\n	2015-10-27 22:29:52.881472	2015-10-27 22:29:52.881472
454	2b08e88a72fc656c87d589b6f47d991d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtaTU5WnVDZWV2Y2JtR0Fvc2E1\nQmptUnM1RkNXcXljYlBlak9rNlBDS2M0PQY7AEY=\n	2015-10-27 23:30:31.815788	2015-10-27 23:30:31.815788
455	b0646ad69886dc63d53d68f2e4cc8d80	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5bHZGVFRkNVdNY0xKR2J4N09i\nV0ZRR09VWEp0Q1p3dW8zS2J6RWhWenZjPQY7AEY=\n	2015-10-27 23:30:41.926142	2015-10-27 23:30:41.926142
456	28383124505e9022accd2a411b40710f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFSkkreXIzSytweCtSOWptZm95\nZHkxZTVONWNQdXNLM2lwZFdaYkpyWTFFPQY7AEY=\n	2015-10-27 23:30:46.986678	2015-10-27 23:30:46.986678
457	29032e5d1e7453b0c12c9d2d5225aa12	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1UkpNNUxJVzYzcjdIY1ptYnF5\nMDYyZmdNVkgveTFtaXZhNUtYVlllbWZnPQY7AEY=\n	2015-10-27 23:30:56.8364	2015-10-27 23:30:56.8364
458	c2224b505f4c4ad23cb265b5ffa04053	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvZ1YvZStYNVlHaURxV0l2a2xH\nbFhUOUJZeW45ckF5alZaSjNMTFZ2WGVZPQY7AEY=\n	2015-10-27 23:31:06.797723	2015-10-27 23:31:06.797723
459	8e9fe9e38a004471f993acfc02c0b0c7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCcTk3T3dHUzVQRHBOdDBYR1pN\nc21pdTZyODRkeEVwQ3BmRVV6Y2hzNXRRPQY7AEY=\n	2015-10-27 23:31:11.641483	2015-10-27 23:31:11.641483
460	f43971203e08ab33cb272080c90cb55f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqcjhjcmphaGFoc2wxcUtFVWdC\nWXEvZ3VLUDYweHJJS092M2hGV2F1cW40PQY7AEY=\n	2015-10-27 23:31:16.468253	2015-10-27 23:31:16.468253
461	3c7739a4f8d6ed806bf3a1e0ea83b74d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4R0ZvMEpKQkI5d2Z5ZFNSbmdo\nK0ZxMXpES2MzRUI4bFcvSmtST0UvNlBjPQY7AEY=\n	2015-10-27 23:31:21.19026	2015-10-27 23:31:21.19026
462	cae79f0a39069cc3df1829125fd81a5a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5R3BqdmV3ZHVNZVgxNXlrK1M5\naFQrSHlqcDNLeTBEVGxxSHdiblZ2aUY4PQY7AEY=\n	2015-10-27 23:31:30.560772	2015-10-27 23:31:30.560772
463	d19b60d8a7460041889cc3e4e76376d6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrRE0wV1dUbWh5NFNaVmRBNk1m\nVkFpYThMY0hJMTBJcDNKbVN2MGJFcHg0PQY7AEY=\n	2015-10-27 23:31:35.494767	2015-10-27 23:31:35.494767
464	5d4e1a8b3d1ca956a3ec74f396c7f20c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiR1dyOXdSZElpdTlyVGF1dmlV\nSHZsY0RJaVhhNGtYc0szNDhya3VDOWtvPQY7AEY=\n	2015-10-27 23:31:39.793445	2015-10-27 23:31:39.793445
465	788a3c69aca2accfba690504dcefedcd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2QW5qTDVOMlBac1VvNHY4bUcy\neUFYQWN0WXFUaG1kVUU5TEVYK2c1Z2FVPQY7AEY=\n	2015-10-27 23:31:44.125497	2015-10-27 23:31:44.125497
466	2a421ea19973b3f78ff13f68f2365a8b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyTTlhTlRYRTkvd3BjbjdyMmRo\nN29rRi9IUUFBaUQ5NzAyTEVZUnVIbUx3PQY7AEY=\n	2015-10-27 23:31:48.797883	2015-10-27 23:31:48.797883
467	ec1f1300807a5ed9b364de9e44584e66	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFhT0JGaHNxcU9iV2ppaDFPc3BW\nQkRmRVdtZDNQSUE3QlczY0E1ODYxNlpVPQY7AEY=\n	2015-10-27 23:31:52.980273	2015-10-27 23:31:52.980273
468	1e40bf6bb568fccada992b2f231988c3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwNHRrOGZwUlpvanpJNGIrK0sw\nd01sVzliZitia0c2TFBJYVBTSmJQYmY4PQY7AEY=\n	2015-10-27 23:31:57.76745	2015-10-27 23:31:57.76745
469	7fed6b47a71ae104168751026e624564	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkaEduTmEyYXBlNXBxMVJqa3hY\nc2IzZjgwVk5INkVVWmVYeWoyekdZcXRNPQY7AEY=\n	2015-10-27 23:32:02.342346	2015-10-27 23:32:02.342346
470	0b0609703bd0f9c2328e3923b2190f85	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5akVmUWMwclpPVzFLWHNOdUsx\nOGcwSkVjbU8zZWs2ZGZtLzlHZDE5cmVFPQY7AEY=\n	2015-10-27 23:32:06.568942	2015-10-27 23:32:06.568942
471	8eae635823d5816b947a3c2b23490771	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErZ2t0aURmcVZmSUlQbWh0SDA0\nMWV2dTQ2L3hJTHpYYTQ0ZEJ3K3hYSzcwPQY7AEY=\n	2015-10-27 23:32:10.872063	2015-10-27 23:32:10.872063
472	c8f9e35c8363137ded360735345c6aaf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLZklHL2RlKzZ0TmNUQVdPcytq\nM2pEUTlNQXhDMWM0SWJSS0FQY2ZRMkZNPQY7AEY=\n	2015-10-27 23:32:15.287257	2015-10-27 23:32:15.287257
473	2ad97feed609552206c4524a9e6d0752	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyWkIxMDZSSVNJc3pkc2l3QS9y\nUGNkWEN3M3lIbXd0TC9Ka29uWWZYZ3V3PQY7AEY=\n	2015-10-27 23:32:19.690057	2015-10-27 23:32:19.690057
474	c4cba73d1100939d4fb36149359423d5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5eFhibTl4WVlMMFJTa1cxVDky\neTVjK255Ym9wNnlTRGY3c3hDM0h5S3VJPQY7AEY=\n	2015-10-27 23:47:09.926068	2015-10-27 23:47:09.926068
475	fde25066ddab9e56cbb80c5e6ea3b38a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5U1pyNnJtOGFMYnBJM29HTU94\nNjFJN1RmRFJBMXhTMEVtM3lidUhNWkU0PQY7AEY=\n	2015-10-28 01:23:58.132079	2015-10-28 01:23:58.132079
476	c4e11768b03893149332c72512f3088c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPS1NkcCtpeU9DSXRaRWFjQ1Ft\nSzNUSDhjaHAxN2d6NlRHdnYxSVFDQWo4PQY7AEY=\n	2015-10-28 04:47:10.038451	2015-10-28 04:47:10.038451
477	b8d3b2e995eebe496b132c217fb28661	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5bWNHTE1XcWhUaFVqZHpWYlBF\nVk50MnRDTkhMakUrTjRkbWNZVG5EYWdFPQY7AEY=\n	2015-10-28 05:46:02.651963	2015-10-28 05:46:02.651963
478	7dec6c5f75fc7cb5ff012951f7fd9e7a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSc2lPbTlZUURpV21UM1d3Vm5Y\nSDFBeXFkZzBxSkcwVG9sd0FidXZGSE9NPQY7AEY=\n	2015-10-28 06:01:33.724493	2015-10-28 06:01:33.724493
479	d2f60e5ee275219537557e87b7e24fcc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0MjlQaHlsVGgyd2ZDaEdORlhP\nTmt6bnlrNFpDakNrZlFiMWFGMXJHQTJ3PQY7AEY=\n	2015-10-28 06:05:09.876571	2015-10-28 06:05:09.876571
480	95f1b8c53e02fe7a190dcc86e9dfd0bb	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVOTE2MGVlMjkwZWYzYWQzYgY7\nAFRJIg1vcmRlcl9pZAY7AEZpIkkiEF9jc3JmX3Rva2VuBjsARkkiMUZzbGpz\naWpOUWtEZ3NmVU8zeFVlK0xEUjB4SlVSblFQVGhlaHhPUkcvUlk9BjsARg==\n	2015-10-28 06:43:28.96483	2015-10-28 06:43:28.96483
481	feca7b99193af6ffee9bd34dbbe75693	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlTEl0MCttbUtPRlRvTVZqTStx\nOXYyNTlFRisrdTl0YzQ1YWYrbEwxS1dRPQY7AEY=\n	2015-10-28 07:00:21.295956	2015-10-28 07:00:21.295956
482	f752e6b026c706ec24b13ef1ff86d8da	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxaENVWENlY0NVdERKZWRuQ3Zx\nMFpPbzNGcHd0U3FHVTJPZTEvcDZ0TzhVPQY7AEY=\n	2015-10-28 07:00:26.2859	2015-10-28 07:00:26.2859
483	0fb3a2e8c07d5f9bdcd0ae5cf95d077c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZQk1Qbmk0RlRRVnZjNGgyN2pT\naXNvWHdweHc5QWlXVzBpUHc2T0pkQjc4PQY7AEY=\n	2015-10-28 07:00:37.331807	2015-10-28 07:00:37.331807
484	4b150bba850ee78de649fd8639de3ff8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtOGdWYlF6Q0NqYjZuVHpoRUVi\nVkNHOVdJN2pMbG9jc2U0NDgwRFJxWGVJPQY7AEY=\n	2015-10-28 07:02:41.869563	2015-10-28 07:02:41.869563
485	0f1dc3828b4666d786be09bd3620f2a6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5M3ZNYWNDMkloSnZjK1AvS0VN\nODNrWDBCYUZ6eE9nWlNpY2taVFlIdFdNPQY7AEY=\n	2015-10-28 07:07:19.403611	2015-10-28 07:07:19.403611
486	c39bf6d04c12f282cacd8d2c6c603f62	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqckppU0h6Mm54SkZ3Y2s4bmdx\nQ0I3cGRuU0hvNWRHNnB1S2hTU3d3Mks0PQY7AEY=\n	2015-10-28 07:56:34.184402	2015-10-28 07:56:34.184402
487	68a39d93351e5717ac53cd82353336b8	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyMzZvQWtPTVZJY0ZhNTBLY3Jy\nZnBmaEM1cDIxM1laaGNZRXlDTjAzL2k0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNGViMjRkNTI1MWViNjJiZQY7AFRJIg1vcmRlcl9pZAY7AEZpIw==\n	2015-10-28 08:10:49.415492	2015-10-28 08:11:40.200028
488	249acbabca1b1b3b24ba8ef9038255b7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRazd2M1krNC8zZDEzb29MM2JO\nTUxFb0ZEbFQ4a0k3bVNZTDFCYlZoRGdvPQY7AEY=\n	2015-10-28 09:37:23.001711	2015-10-28 09:37:23.001711
489	9a07984f07b762a1227eb8b1d8a5af7a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqc0xXdS8rT1ZuMnZIL1JmVm9B\nbEZTNGVTOEZxcWVCeXFDNW1mVllvZFN3PQY7AEY=\n	2015-10-28 10:16:00.839428	2015-10-28 10:16:00.839428
490	4423c8f3f93497df5f45903edd93e0a6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2eEdIdm5UWU9wb0ZuandkTkJ0\naXl1ZEVkcGU3K215UnJxcEtEZWp2TDhRPQY7AEY=\n	2015-10-28 10:45:06.948973	2015-10-28 10:45:06.948973
491	1963037ba2d8328323d3c95ef9cd9ec1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkS2lLVWJRZTMzOFN5Q0hsWUpo\nTXZjSmxNVzlHZWpaUnlXQ281U052eUVnPQY7AEY=\n	2015-10-28 11:36:45.86412	2015-10-28 11:36:45.86412
492	732829515ed2d7db23e82e5abe90f37a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPYzBwY2J4UGM2c1dLcktDSFJZ\nOW5naWlXSVgzOEM0a2M5c2NNUTdpSytvPQY7AEY=\n	2015-10-28 12:42:59.345532	2015-10-28 12:42:59.345532
493	991fdea220d692c21dba7aff68c83cb4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLb1dCandicnltYlZKSE1pZy9H\nb1JuVUJHMjVqcDUySTlJMTBsK0JTeEp3PQY7AEY=\n	2015-10-28 13:16:30.774362	2015-10-28 13:16:30.774362
494	8cead4910e4300924667073575ac1675	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMcVEydFlDZ1lMa3AxeGlDeEpL\nMndjR21ZME5SRjFMWVIwc1E4RjZoV2U0PQY7AEY=\n	2015-10-28 14:07:34.894253	2015-10-28 14:07:34.894253
495	82e74452e852647355b44d2e5c2a55c7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3VmkzNWc2cnVGM1cyREdhVVFi\nMy8vSlV6RWcreEJEcVJTVHBsRU82UDEwPQY7AEY=\n	2015-10-28 14:23:17.072719	2015-10-28 14:23:17.072719
496	3cd8b8786ddcb2a50125d7086a6cb7fa	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExYUJHSzBIYmtYQmtaK1lNcnJs\nTnYxWDJLU1l6bm1MblZmalNRN2NGcnhjPQY7AEY=\n	2015-10-28 15:09:56.119127	2015-10-28 15:09:56.119127
497	940dc1f37ea025d46d48756868c711c6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyS1F6Zy9TT2U3azA1c2lvT3B5\nSWRJOTV1T3pnc1JVR2VzaFVlSUxDaHE0PQY7AEY=\n	2015-10-28 15:18:31.35815	2015-10-28 15:18:31.35815
498	218facd43a9a7cf246826838893badaf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZUnB1cGRtZUlkMjEyanBWYm0z\nbWxYWGU2VG41K3crZVI2YTlyRnR4WHE4PQY7AEY=\n	2015-10-28 15:18:52.619629	2015-10-28 15:18:52.619629
499	cb78246d371809c06c00da6a0fd329f8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFobXJxRWtiaXBQMlBJejhia0pw\neG5sdmRrTmFrb3Yzd1ZaMUZvdk83TTVZPQY7AEY=\n	2015-10-28 16:50:20.901182	2015-10-28 16:50:20.901182
500	506f5b6f94da49528c90fea8d6b097fe	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtZFI3dEFRSXJ6blRVVkZMSEZp\nQzBoMjdKWExSMDVkTHNReUprQ0dzQzBJPQY7AEY=\n	2015-10-28 16:58:25.530601	2015-10-28 16:58:25.530601
501	27eeffde55e435452fdae054cf3500cd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVTExDd3h2ZVl3a0Fmc0dXU1Nq\nZUVramF6dDRXRDNremJjQU9UUTlSRjlFPQY7AEY=\n	2015-10-28 17:49:22.497769	2015-10-28 17:49:22.497769
502	4cd98147f702c1e36845a2f6ab950f48	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3UHg0RzVkWENJM0VYVFFUTXhS\ndG13eFU2ZGxJV0lkRWEwR3JBSnN2NitJPQY7AEY=\n	2015-10-28 20:59:53.140828	2015-10-28 20:59:53.140828
503	fbed847b91edd5c3843df2114ecf8e05	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFMWpGaGU2NnRpYXFuUkV0MWl2\nQTFaWUV3QTBuaXRncWlWQjVFOVoxYktnPQY7AEY=\n	2015-10-28 21:24:43.744002	2015-10-28 21:24:43.744002
504	04ed0aea11c96f9cea631ea28ec83d66	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYbkcrelJnUmh4TzgzeWNPeEVR\ndGtQNGtZUFRuVXZVTGZQSjREU04wWlUwPQY7AEY=\n	2015-10-28 22:24:35.776945	2015-10-28 22:24:35.776945
505	87ba2db33c096bf09325723f1d8aba20	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuUWYvSjVpQ2Q5ZHBoU2k0elpW\nUm9paTdISjhObThkdUkyZ2FORDgwQklZPQY7AEY=\n	2015-10-28 22:24:45.195267	2015-10-28 22:24:45.195267
506	84080a5bf40a838c9d270836aacc65ec	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLMGoyOG1uNDlReExsRFVVajVq\nQ2NBaEl1UjBVb3BKdkJ6bnJLdDhobkhJPQY7AEY=\n	2015-10-28 22:24:52.733016	2015-10-28 22:24:52.733016
507	14b68c351df2d6805329780ab3c754c7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzSWRCem1WQ2hlRmxxcVNTZVE0\na1M1WittYUNZT2xMZFBCd2s5NlU2UDNFPQY7AEY=\n	2015-10-28 22:25:01.029436	2015-10-28 22:25:01.029436
508	ae4bdd2fab37b54da1e8680c5c80e8ff	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvZ2dkaG1LT2R4SjBTMldMS0Y2\nQ3hYWTNvKy9LV3RjWG5EY0kzTy95ME5FPQY7AEY=\n	2015-10-28 22:32:28.716799	2015-10-28 22:32:28.716799
509	d45c499d596c2d01308cb5346b10a687	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFJUnhWNy9qcmZObmk0enQ3a2xW\neDZUZlNpRktIcDFwWm9vbkFZV0FrcjU0PQY7AEY=\n	2015-10-28 23:13:13.865475	2015-10-28 23:13:13.865475
510	1139b48f2711c1e92164606f29bc05ee	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIR3NLa2ZmOTVCUUFhMkVoUitG\nZXdzcjdTbXhsMGF0VSsyUWQ5UUdNWGxnPQY7AEY=\n	2015-10-28 23:15:44.229466	2015-10-28 23:15:44.229466
511	577c6850c3bf7261db2ea0ef13c75019	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyZnIvOWtaYktWV2tnS3VIV216\nRHRIRWdtb2lRNjRlZVBRbWk1aUlDcU9ZPQY7AEY=\n	2015-10-29 01:28:56.945835	2015-10-29 01:28:56.945835
512	ce83c7bfb7c5389afb8bd9f65018386d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaSU5KdWhRUmtTbmkybkRqRkN4\nOFk2ZHlFMHU5VTdkNE1WT00yYUtYTS8wPQY7AEY=\n	2015-10-29 02:48:50.824574	2015-10-29 02:48:50.824574
513	60f3a2fbd35ee75a8249861ee58aa130	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqTHBBN3JlZ2o2MDUvMVNKcXk5\neGFmaDUzR1F1OWI3TUFhVGVFT015bEc4PQY7AEY=\n	2015-10-29 02:48:55.153335	2015-10-29 02:48:55.153335
514	ab1b2a7603f5f9ec22018dcd2f84ca51	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzZm4zSG9ZcHRSdmJTdE5ZeitR\nVUZIUDA3QzlZUm9NVXZlbnYyd3ZFditFPQY7AEY=\n	2015-10-29 02:48:59.538638	2015-10-29 02:48:59.538638
515	613cddda15b5a44286e5e6a23fef2cf9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuNSt0azZ0OWRXdmttM2F1MzJi\nRWsxbmpicC9YcEh0SFpDU2c2V1R6Y2I4PQY7AEY=\n	2015-10-29 02:49:03.906672	2015-10-29 02:49:03.906672
516	fae96fb5df643958d361dcecde006de3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErZ1FBTXcxRVpCM0UyM1lXK2tN\nTlg2eWh0ZDhUa3BVV1NIVVhNOTFnY1dVPQY7AEY=\n	2015-10-29 02:49:08.270097	2015-10-29 02:49:08.270097
517	950da828f553d0036c5afae3d9c9f230	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTNTE5ZEg3VlczQTltdW1qNWJ5\nQWNqS1FleXZrVFVWdXMxejF0NFIrNHpFPQY7AEY=\n	2015-10-29 03:30:59.563906	2015-10-29 03:30:59.563906
518	f40cbeeb4bace7b97017020dac9d173c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2SThkc0h0TUtRZEQyNmV3L014\nUVoxVCtKQUhncVdGQnlCN003eHdzUE9jPQY7AEY=\n	2015-10-29 04:52:25.573925	2015-10-29 04:52:25.573925
519	d46dba2cab51d630f466a37cf62e7aa5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2L2xnZkZiSjdxdkk2ZmgxcVBD\nenh6YThXdmc2RTIwQzZRWWNxRVN6N0ZBPQY7AEY=\n	2015-10-29 06:08:27.381502	2015-10-29 06:08:27.381502
520	d6d16fd374ff1dfa86522ddfed3dc4d2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKZlZTYUZyNEFWb0xLaFplbGJL\nSFJDcGFLc0NUZEZ6blA4WlpiODRPWUx3PQY7AEY=\n	2015-10-29 06:34:09.720633	2015-10-29 06:34:09.720633
521	228c5f4cd3e2837b8ca2a73ffad5abac	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3ejJ2aUlrWU9GcFFhbkY2blJ4\nenhaWlBjZXRjZTNWTnMrMnl0dUNpS1d3PQY7AEY=\n	2015-10-29 06:41:59.20499	2015-10-29 06:41:59.20499
522	b4d8ca39582df029aefb46ee8c85e4e9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4bE5CSGRtaVFNMmtZSENMcUpK\ndDZpOUx5cDZNQ09wSmlDL0oreXdvYlVRPQY7AEY=\n	2015-10-29 06:49:48.871383	2015-10-29 06:49:48.871383
523	dae871a171e3c015c01edd718a056822	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDaVE0SjAwOWVVdkJlbGgvdkZs\nd0JvY29CcXROWHVtUGxHaTZ5azNzYzRrPQY7AEY=\n	2015-10-29 06:57:38.420024	2015-10-29 06:57:38.420024
524	58395a25dc86cfa791c955b97f7b2c8c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5T2VHbXdBeEVBalVSNlgwd1RW\nbXQ2NWlkbG1nWkpkaWg5RWJEUXFDN3FjPQY7AEY=\n	2015-10-29 07:13:17.665462	2015-10-29 07:13:17.665462
525	5d3d8242f40786891b08d8d3b895d8c8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6eFpYckd2R1d5V0drNlVEeGJN\nQk8wZjZoRzZFYUcrUXRaRUpzVC81anlZPQY7AEY=\n	2015-10-29 08:11:13.981176	2015-10-29 08:11:13.981176
526	4059fd81aa3b6bf1e9dcc558005ea9bb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFxdmJnTUtuNEZ0aGFIdjFhRkp5\nYnJ6QTlXSWNjQTBNU09VbGhnQXpLeFdVPQY7AEY=\n	2015-10-29 10:24:14.711845	2015-10-29 10:24:14.711845
527	c9883a4825731b28140dc06b387d573e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmeGJLRTEzR3VENUtoam5OUzJo\nWExVRVUyMzhwYmR6akVWcGUxZ1h4VnpNPQY7AEY=\n	2015-10-29 14:20:27.421078	2015-10-29 14:20:27.421078
528	9f8dbc2eb3b0b878814b241d46abe6f4	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVMDYxMGIxODNmZmVmMTlkMQY7\nAFRJIg1vcmRlcl9pZAY7AEZpJEkiEF9jc3JmX3Rva2VuBjsARkkiMWdrS2tx\nK1Nhek5vaFgzbUtZSWJac2hGUFFmSVNQbTFHb1d5K3lnZEFIbXM9BjsARg==\n	2015-10-29 14:32:45.603278	2015-10-29 14:32:45.603278
529	c764e7aa4a1e80c6f36b7ca953b4d79f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlNmRXYit6SjRXM0hWQlNValB5\nWkhja3dWL3dyaXFSTEVTeXhxeWMvZjFzPQY7AEY=\n	2015-10-29 16:52:42.167667	2015-10-29 16:52:42.167667
530	d0539805f761775b014a3b62978c7ace	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvdlBZS3pOTmNUWHA2M1ZTUVp3\nYzNibHNVUUZIVVNRUHJNbmdTYnljRGw0PQY7AEY=\n	2015-10-29 19:28:03.744975	2015-10-29 19:28:03.744975
531	247d4fe06d1c351fe964113030fc8fa4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqaW1LN0pHcjRsNTluUWpxSmps\nUFkzL3QzeU9aSUxlWkdFSDRaL3poNGJFPQY7AEY=\n	2015-10-29 19:28:08.090915	2015-10-29 19:28:08.090915
532	55f4101fe6e188d933515ccbf3b2d809	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExT0tTSUdEK01xR3RFa3F3RVN0\nYnVDYTdTWHFoQ0xzYk5HcEZJK3IvTzkwPQY7AEY=\n	2015-10-29 19:42:41.782654	2015-10-29 19:42:41.782654
533	34b54b28a991a5d03822975839653f47	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwVTl0SEl1WVB3a0ZsSm94OGFs\nRTM0SWlpWDJRSmZwTEJrV2xPaVRRRW9VPQY7AEY=\n	2015-10-29 19:42:46.081551	2015-10-29 19:42:46.081551
534	978f03458fe856c59b1ccc707784e4f9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErREpwV1hiT1dKaEprcDlrTmU0\nZGV5U2tWanpaL1h2dFVOMUEzd0tkSHFJPQY7AEY=\n	2015-10-29 20:10:13.93255	2015-10-29 20:10:13.93255
535	a17810907341874a90c56ce47bf6c90a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvMitxamE5UWwrY2ZUZWV1bS9D\nOEEvMm51UERNdlFqdDd0YkhFc2hxQ2NjPQY7AEY=\n	2015-10-30 01:16:56.300562	2015-10-30 01:16:56.300562
536	e3b7173a881ea77bf2c66b1babd67d4b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwSHlaaG00Wkdhc1lZbE1mTzBW\nK2tUR0t3QmpOVXpwOU5ObjFBS2c0N2pjPQY7AEY=\n	2015-10-30 02:26:54.696001	2015-10-30 02:26:54.696001
537	fc43c2733769a4d8ff71a5d1e9e6f89d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZWENTV3dtVU42ZExHL0xHRm9l\nenVkY2NWRUc1L0ErV2piR1dOdk5pcGNVPQY7AEY=\n	2015-10-30 02:26:55.588702	2015-10-30 02:26:55.588702
538	aab949b5ea59a5ddd8de676f0ef3344c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtOVlRekM1QXFZR2RpeG5PUzNn\nOC9QUVhnczBXZENITWtqeURiYVphNFNBPQY7AEY=\n	2015-10-30 02:26:56.384618	2015-10-30 02:26:56.384618
539	91e4d37b0e52b943fe8de0774c79342a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSM0ZuMU1YMWQ4ZmttN0NXZFRV\ncFRaR3VwQkNVR005OWE2RmF0V2NsdC84PQY7AEY=\n	2015-10-30 02:26:57.256064	2015-10-30 02:26:57.256064
540	51a6c803167f7094e03fe6d24081d623	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVeEZnTTdNdUxBUXptWkpINy9R\ncFIyZVV5bHFxZk9ZVzR0WEhxSUZ1eHVrPQY7AEY=\n	2015-10-30 02:27:46.968018	2015-10-30 02:27:46.968018
541	692cba8b53f8bea37a9f766cd2455b9e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFeFptc0gySjJteW8zUUFybHla\nZGorU3pNY012TmtqQ0dKaEpJcklnaXpVPQY7AEY=\n	2015-10-30 03:04:19.264898	2015-10-30 03:04:19.264898
542	90de21c733b1a8570a9e05042f12f341	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQUmRDWjNJemtjUmJlaEUvWmtG\nRjhOQ1p5OUJWR25jbWsvaG1zQVVvaUdRPQY7AEY=\n	2015-10-30 03:04:19.909916	2015-10-30 03:04:19.909916
543	d0b42203c6744111ab55c43890143e74	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFabS9vaUtpR2VoVlNWTnFoTXQ4\nTGkxeGxISXh0SVhhRUZZTXZMQmYwa1pJPQY7AEY=\n	2015-10-30 04:38:55.799918	2015-10-30 04:38:55.799918
544	15443d33a93a02c666eb10efa3f71ee9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFJUHBEcEFyUDR1cS9TSVc0TlJL\nMG40UlpvZ29CREhCQVVBRUtsY29lbkM4PQY7AEY=\n	2015-10-30 04:44:45.877753	2015-10-30 04:44:45.877753
546	706d34bc41680ba0a45c36d8073a559d	BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBQmVvR29CSVI0K2ljVVJlSm9a\nMXNyakR6QktOSXM5YUVwZGU4bDhValBzPQY7AEZJIhlzcHJlZV91c2VyX3Jl\ndHVybl90bwY7AEZJIgYvBjsARkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIu\na2V5BjsAVFsHWwZpE0kiGWtmV2hteFZ1ZXJXM25tcHJTeXdEBjsARkkiDW9y\nZGVyX2lkBjsARmkl\n	2015-10-30 06:05:38.44925	2015-10-30 06:06:59.698184
547	a8099d3d8cfd30acb08f45d67859ed7f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2b0lJczQwSnVqeUU3TkxkZnlx\nSlViejY0TlcyOEw1NnAvMU9ZbE4rYXg0PQY7AEY=\n	2015-10-30 08:09:56.626538	2015-10-30 08:09:56.626538
548	87dd9d99fe843a5f826fddb25e329d71	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGb3ZWTHRvbGdQaUxyaUJ5dFBI\nTjVpRFNxOGJabW5VRTZuWU93TWJQVnJFPQY7AEY=\n	2015-10-30 08:13:26.06974	2015-10-30 08:13:26.06974
549	8b756b5b2c863d102bce1ce178da21af	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVT2VhZXBKWVVCZFR4WjJVRnlX\nTjFabU5tUjZiK2NiRlJ0NnNKVFpMQWRVPQY7AEY=\n	2015-10-30 08:21:25.325388	2015-10-30 08:21:25.325388
550	38b719f7b0082d0589a467f823ce1175	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtMEt5M3UzRUlhdFhWQk5lZzhT\nNHBqYWxwSUx5QkF2RkdFTTI4VHYyUVlzPQY7AEY=\n	2015-10-30 08:21:27.161786	2015-10-30 08:21:27.161786
551	244d9792db705b8de92d2c20eb543688	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1RUt4UXZRTGdsWWltN0NUOXY4\ndHkzTU1VRWFmejcyUmdWTm1ncFU5dXY4PQY7AEY=\n	2015-10-30 08:21:33.124173	2015-10-30 08:21:33.124173
552	99c9a0251e679c2dd3ae013996bae007	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFldmJ6Nmh2RUZ3dytxZjl4a2dL\nV0VVNFlpNzNSN0Q3NUI5SE1CamZ5T2FRPQY7AEY=\n	2015-10-30 09:05:40.383603	2015-10-30 09:05:40.383603
553	3b976eb63f4f7ab143ff39086659d2e8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVaWpxTXJuNjdZZCs3YnJiMm1h\nVTFydGJXejQrZ01tV3JYRTlwN3pOZFhNPQY7AEY=\n	2015-10-30 10:58:43.823392	2015-10-30 10:58:43.823392
554	7d4ecf853c7b278923f77bc5a38980df	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtUFlFSXEzb0dnMklHYXBtT1Rv\nanNEcThyYzMyaFdWU01iOWJiRWtMNGdRPQY7AEY=\n	2015-10-30 12:26:51.190186	2015-10-30 12:26:51.190186
555	301861f0dc41bc8c1d7024a21a9d5e15	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOWWlJTEFnRzNiUTBQM1FySnhs\nUEkzVkJFcmF2bk5oZ0RuZ1FEZE1BcEhrPQY7AEY=\n	2015-10-30 12:36:32.068821	2015-10-30 12:36:32.068821
556	4732733e62674b9071d980e6ab8bb602	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmUWtNekY0REZPMFh1d3k4aFhJ\nN1Y3MU9NTG9sbzFzZG9nWE1mdUJkMktVPQY7AEY=\n	2015-10-30 16:42:17.4763	2015-10-30 16:42:17.4763
557	32e3e737208118e8dfe168df1256f5f4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiRG9RRy9RKzBEMlZ0RmN6aFJy\nNDBVSyswUzhaMHVrT0F1L2MzVzhGN25JPQY7AEY=\n	2015-10-30 17:26:56.408161	2015-10-30 17:26:56.408161
558	3b747b6621bd844b50450cddca53a6e2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzeXI3VExnTHpWOFFCZlFybzZ0\neGk1Ti85NzhYOU1ROEdQUWRFbFFKVGFNPQY7AEY=\n	2015-10-30 18:39:06.384189	2015-10-30 18:39:06.384189
559	2b46bde4c4a0ba05148e9e2ef031d77e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0ejZES3pSeDZrRDlNcjYxQzBZ\nT0t0VlRIcDJiUWhKRDJkMXM5WENiNWdJPQY7AEY=\n	2015-10-30 19:22:35.493366	2015-10-30 19:22:35.493366
560	fcafab70ead8e30d66de254cfd6ff2e6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmTDVlbmtIeDFhZXQ2MHRsb2po\naU5sMzl0Q0k0aDN5MmNvbTkrVkg3dTdjPQY7AEY=\n	2015-10-30 21:12:51.790567	2015-10-30 21:12:51.790567
561	9e65d5f13f3880466da9795b5e779a98	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYcGxZQnpXaVJnQWNtbDJBeWJq\nNjAyREx4YW5PLzdxUUVxdVU5cjdzazJZPQY7AEY=\n	2015-10-30 23:09:50.81786	2015-10-30 23:09:50.81786
562	8fd36646230d63dbd1b39a62963945af	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwYWprVUJ2K1hXbWZxTTFGajBn\nWVBURnl6QUpVbDc3T1dML1NEaVZEVkhVPQY7AEY=\n	2015-10-31 01:11:49.955475	2015-10-31 01:11:49.955475
563	551c6a2e5c330ba2feb6562828ab398d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1MEgxbEs3eHZ6RmhOaWNFKzh5\nRmNnemRSM09oZ1lIM3M2TmZ6Q0Zxa0RzPQY7AEY=\n	2015-10-31 02:13:38.268874	2015-10-31 02:13:38.268874
564	f878e2623da0d497e22b96485c6f0494	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnMHEvLzFvOWRSc2RRTDV5ODBh\nR05QQ0lYVkRtQWNQd0MwMktTcGp6dHBNPQY7AEY=\n	2015-10-31 04:01:23.499746	2015-10-31 04:01:23.499746
565	c85b7896f252016a6e518e1ab52ef88e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4Q1lqOUplclBjK2tQNzlOQkI0\nQ3gvcHpCZm1zYkZFT25IY0pCd05kdHdNPQY7AEY=\n	2015-10-31 10:27:43.729723	2015-10-31 10:27:43.729723
566	feaa8575cf00f27fed57352453e6bacf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYeTB1UzlnYS9DZ3NGOUJrQlNt\nckJSR1pFZEJYZUl6T3BkaVlqNHdPWUpzPQY7AEY=\n	2015-10-31 10:47:02.786151	2015-10-31 10:47:02.786151
567	a378adcfe00406a8abe1b6da807706fa	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyRnRWaWJSQzJpVmErVUJBbWxS\nb0FpWCtGOHVIZVJvNlZhZVNscm8yOG1RPQY7AEY=\n	2015-10-31 12:35:02.641572	2015-10-31 12:35:02.641572
568	0c57f9c8c71c16fa8cfdbfe40df4a008	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFURDRMcFdrN2M3bFNFNkFGcWxD\nMWxGbkNqd3EwZ21XYTZwaUlkR2tmcEpBPQY7AEY=\n	2015-10-31 12:52:35.97485	2015-10-31 12:52:35.97485
569	288f2996b18dfdcebfc46452a2ec0d8e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPTG1BWVBwMUtrekNsdGxsRWVE\nSUw2N3p3RFhwRkRlT0VmYmtrcXRYNTZjPQY7AEY=\n	2015-10-31 16:53:13.746336	2015-10-31 16:53:13.746336
570	0432a0f7e25687d0b6287673313dc1e3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKQmJBZHpvZnhXekc5VGFUQ0ZH\nNE93MEF5SDFaNHFDaUlVRC9mTE91dmtjPQY7AEY=\n	2015-11-01 00:49:41.177611	2015-11-01 00:49:41.177611
571	a7b4e29c48911e3fd5998aa94a7f50f9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDbmtEeXlPTFduUSs0RlhTTXpw\nbWRCOHpvMFRKOTRaTlMvS2d2OVYva3ZVPQY7AEY=\n	2015-11-01 03:25:21.575384	2015-11-01 03:25:21.575384
572	a5fb010c849d19167dd0ff44754a648a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEzVXJjYkhRd1RGTmhFcDJ1WVE1\nOVNFeUViT1JVZENZN2sxdWlPVkF0WUxRPQY7AEY=\n	2015-11-01 06:20:29.055497	2015-11-01 06:20:29.055497
573	fff91f2ba40e9472521d49e4ab62bd1e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXNDMyNFZ4MjRPZjJ6UjJvejQ0\nVzRZdlRzQjZrT0pLY2RsQS9Ubld3UEZNPQY7AEY=\n	2015-11-01 06:20:37.194777	2015-11-01 06:20:37.194777
574	93dc4ff2c35e2e2e1d528a1b53d92253	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkNnRIcW9DUUtjY2ZhUnhpdGUv\nY3lzSjRIQVVqSC80TDlkL2tLT1hXaEUwPQY7AEY=\n	2015-11-01 06:20:40.832306	2015-11-01 06:20:40.832306
575	f1f2625b74810e43cb1fac08808ecef6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwK2ZsVFR1ZEVsOEFFOFZ2TXNh\nancxUkErQmJjU1BQbkQyeFFPck1BSzRNPQY7AEY=\n	2015-11-01 06:20:42.82995	2015-11-01 06:20:42.82995
576	72ffe83556d332240f969437a005bc5e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYM1E2UUI4Z0VsQkt2SEtyT3hQ\nMngvTTV0TVR3WGZKZkxmNVVEWEpTeHVnPQY7AEY=\n	2015-11-01 06:20:45.005083	2015-11-01 06:20:45.005083
577	4efa5ca22a928834c8fc1af00e68b5ba	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3cmZpUHJrTTI1U1BqUTY0NTl6\neUg1Mlk1QnFzMFppWTJ2N0Z1WEJIRys4PQY7AEY=\n	2015-11-01 06:20:46.824768	2015-11-01 06:20:46.824768
578	4af2182dbc1e7946b24d314bf172a611	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUc1hPQVZYWFRXODUyejJZSXJp\nM0ZQcm01RjhPdGF1MUg3a0hocFJodThvPQY7AEY=\n	2015-11-01 06:20:48.956194	2015-11-01 06:20:48.956194
579	46f22cb2d8183da52685695dee1bde66	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXY3p4NVQwU01yNzZ2MG42bVVi\nTDJWSU4wM2p2M3VScHVENFhnUUo5WVgwPQY7AEY=\n	2015-11-01 06:20:50.895841	2015-11-01 06:20:50.895841
580	3bfe09474d090b5d9823941558352a48	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMQ2NGeUdPcXdsSlY2TGJQQ3Zw\najNENEE3TzJsVjIxVmVLNzl5NFAzU05JPQY7AEY=\n	2015-11-01 06:20:55.116067	2015-11-01 06:20:55.116067
581	b1a2d7f337b698027e2b59beea49cecb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlMzhrNk12ei9EbEtyNVl4VGJS\nRmM0WmxvQUg2TVlNVzBDS1VJRTI5U004PQY7AEY=\n	2015-11-01 06:20:57.175713	2015-11-01 06:20:57.175713
582	bb926c37ae78d038cacd5dc852ea5aaf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOaDBqRmZLTlFyc1dWaDBoZEF5\nS0Nia0FkU3dTRFJKNmhlYzRWbGZCV0ZRPQY7AEY=\n	2015-11-01 06:20:59.37198	2015-11-01 06:20:59.37198
583	fcc897bbfec5a2e691965d14f3a28ffc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRZjQ3RjBaVXM0S2Q2RW10V0hL\nYXJPVFQ2b2hlZ0Nnbmd1RFpyK3ZMcDVZPQY7AEY=\n	2015-11-01 09:19:08.434531	2015-11-01 09:19:08.434531
584	ba6b99a5326dab14a3e3edbc531156ff	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHVlgzZFdiclZidXVuUWNERXJ0\nZTh0NFNuZzZwR2pQYTJub0VmWWU2QmFZPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVOWNhNjY4ODY1Mjg5YmRhNAY7AFRJIg1vcmRlcl9pZAY7AEZpJg==\n	2015-11-01 14:53:55.86764	2015-11-01 14:54:41.045775
585	5a235247fba0f2bf96badd23ec587a8c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZVmxlQkxiTzhOc0YvM0MyRWxz\ncmRTZjBnSnJPc1JYMjNGZzkzdURQWW9RPQY7AEY=\n	2015-11-01 17:07:38.707021	2015-11-01 17:07:38.707021
586	1b6105aca93d970d7f1f04e94a6aa900	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4SUJ6YllIMU4vbXlScGJaMGs0\nL01vL1RIcHZzbFc0b1dObDlPSm1ZVlkwPQY7AEY=\n	2015-11-01 18:32:40.164704	2015-11-01 18:32:40.164704
587	31adf715e863959ea60e0a9ee49a5703	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDRDk5TlV6Y3FHM1BSeVR6ejAx\nR3FFYkltTTdwcVFCbklxeDh0d0pYTHFJPQY7AEY=\n	2015-11-01 21:07:33.922797	2015-11-01 21:07:33.922797
588	6aa4bb9809fac7a20931a0d689c9e837	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2c2NJWkRoWUo0OENUT05ST3Vu\nYTFqcW1mZFhVeXl5a3F1V2VaNTJMQVZRPQY7AEY=\n	2015-11-01 21:07:35.994689	2015-11-01 21:07:35.994689
589	39fdd831525d730eafb1894979e0a78f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsVnRBUStnZkNtYUZkNXdXV1NE\nOXkydzVVYWdmWUJ6SkNScm95eW8rQUVFPQY7AEY=\n	2015-11-01 21:07:42.587012	2015-11-01 21:07:42.587012
590	b3a530b71aacc3d8008c7e1f3e23a20f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3Z3ZvNXdDVUpYVncwUUs5RFBC\naVFOV29jbkw3VjN2czVHTERBM3psOUljPQY7AEY=\n	2015-11-02 00:28:06.148196	2015-11-02 00:28:06.148196
591	052df18ab2289539624f5bd2203ebdd6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0dGxFYm5DUXZyUnJ0MmxDTlMv\naGExQWFGUjdkQjdmWFNxLzQ5Y1VmSWZrPQY7AEY=\n	2015-11-02 04:30:10.733236	2015-11-02 04:30:10.733236
592	e0054a7d5a0f41db7628e1634f89627a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXcW1pcjY2bER4cml5TXY3ZDlh\nVWVVM05YNmhnTDhpeUNOZnAwcmJoVHlzPQY7AEY=\n	2015-11-02 04:36:23.287241	2015-11-02 04:36:23.287241
593	e130cd79d3f4e806a2810118fa11e1e4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErRW0yMUVSNk1PZVZEZTJXb01j\ndXVlYllIYUlJNEFGdGZqYTJVSmxhVWhnPQY7AEY=\n	2015-11-02 05:32:28.558925	2015-11-02 05:32:28.558925
594	12eb92bfdefbf20ee5e9894cdb1c6748	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFURHBaR0QxdUdlZDhocHExVHFY\neXpCcThrOGJXT1k4Z2FDYUsxN3ZIY1VFPQY7AEY=\n	2015-11-02 07:47:26.719411	2015-11-02 07:47:26.719411
595	a5538311971bdf72fad45622d44edf3b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2anVIdXR5ckxEVXpwZ3U4MTFR\nejlkaFJBUlNzOFdsQzJvN1BncTE1WThrPQY7AEY=\n	2015-11-02 08:33:33.509339	2015-11-02 08:33:33.509339
599	4dd576aa8581499cda8f75a29926d756	BAh7C0kiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQxJ\nIhl5a3BERGoxWGhIdHpwZXpBd205VwY7AFRJIg1vcmRlcl9pZAY7AEZpG0ki\nGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjsARkkiBi8GOwBGSSIbZXhwaXJlZF9v\ncmRlcl9jeWNsZV9pZAY7AEZpBkkiEF9jc3JmX3Rva2VuBjsARkkiMUxXdFg2\nSlZCNXY4eENWbCtHSHBTMURHdEg3eEszemNyMlBsVVZHVS9IY2M9BjsARkki\nCmZsYXNoBjsARm86JUFjdGlvbkRpc3BhdGNoOjpGbGFzaDo6Rmxhc2hIYXNo\nCToKQHVzZWRvOghTZXQGOgpAaGFzaHsHOgxzdWNjZXNzVDoLYWN0aW9uVDoM\nQGNsb3NlZEY6DUBmbGFzaGVzewc7CkkiJUVudGVycHJpc2VzIHVwZGF0ZWQg\nc3VjY2Vzc2Z1bGx5BjsARjsLSSIlVXBkYXRlZCAxIGVudGVycHJpc2U6IG9m\nbkBvZm4ucnUGOwBGOglAbm93MA==\n	2015-11-02 09:12:26.07195	2015-11-02 09:13:16.91082
600	e7928e2e7be75e4ca31065b27acd877e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVMHJuUWF3eWtjak4yZllhMUVW\nY0d3ajVXNENtZVhrb0hHQkc1dmhNNG04PQY7AEY=\n	2015-11-02 10:05:52.906143	2015-11-02 10:05:52.906143
601	9ace972e20b8a4daffd70f21039f0cba	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1bUhZbmd1Z0Y1eHZXZ2xaU0Rn\nR1pST1Y5ZTlJb1ExdU5xeDkzRmE5N2tZPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVMmNlMTFkODZjM2JkOWM1MQY7AFRJIg1vcmRlcl9pZAY7AEZpJw==\n	2015-11-02 10:42:40.916875	2015-11-02 10:44:13.188056
602	e5b40ba00f8c0c28540d817fc0a8b12f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVSTRrUklvM1VSaGZKVWNsakRv\nOXpzTW5Jd2xTRnZhZ1JJdll1c3JhY0YwPQY7AEY=\n	2015-11-02 13:01:55.68823	2015-11-02 13:01:55.68823
603	54f870603135f7725e1e85ea9fbbaf0b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWNnNENTdhc3hsRjhHK0J4UU9N\nL1NTeW1VSFZMQk5nVWxOT0MxMzhWeUtJPQY7AEY=\n	2015-11-02 19:26:54.368959	2015-11-02 19:26:54.368959
604	d1dd820b2d6a9ceb9b1bdbaf86250be8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjRSttV0tvK2IxQnViUThsZUdS\nTTM4LzYvWVRIZGwzeDYrSlNjT2gvS00wPQY7AEY=\n	2015-11-02 20:33:34.121253	2015-11-02 20:33:34.121253
605	510b7bbe93a2eb02e96c2dbdb9119380	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPSGE1VjZ0SjZqS3BTZ25pNlBN\ncHhzQWVTWURkSHE5elZNY25LRk5NY1BFPQY7AEY=\n	2015-11-02 21:24:27.94836	2015-11-02 21:24:27.94836
606	fd2abec97f2ff940c53184a69e86485d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3NExtOXlFRHZGcUpiaUl2c2Iv\nWFZLbnV0SUUrR3QyMjNFQVJwMTIvL2xVPQY7AEY=\n	2015-11-02 21:39:54.516638	2015-11-02 21:39:54.516638
607	88af7f4bb34a1102b03b9d00a28b3a2e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPTktvdjhLcStGR3VGc0xMSGpO\nQUlrYm5UUTA2ZHZIck1rZE1ydWFhQkxnPQY7AEY=\n	2015-11-02 22:15:21.571516	2015-11-02 22:15:21.571516
608	4d97622cbc435c2aa1959fc530b546bb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRM21VcFA0am9tbnkyYllhVGJD\nS3VOcXZVdlVUekJmUkdvdzNoRXphTTZFPQY7AEY=\n	2015-11-02 23:22:25.109133	2015-11-02 23:22:25.109133
609	289437e63a6b675f69b5601d2a93f50e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFEc0FCSkplSzRjUVVSWU1RbGhV\nMkRGVDBNbHZmMDZqb0NodkJFZkQ0ODM4PQY7AEY=\n	2015-11-03 00:02:45.572212	2015-11-03 00:02:45.572212
610	911a200bb5d546fec7d461fc32066e08	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZQi83OE1EeUJnUGRMSk0vbGdU\nSGIrU09vU0JLVDlNaU81d1U5dHFHeWg0PQY7AEY=\n	2015-11-03 00:15:00.973237	2015-11-03 00:15:00.973237
611	426293847dc30ef64319df4ed12dfeb0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGR091bU8yRFhjeGVzN2pWQlZz\nM3FTa2dmUjRsVUpmc2U4QXFvanFJM2FRPQY7AEY=\n	2015-11-03 02:39:22.277027	2015-11-03 02:39:22.277027
612	4c8f43b3244bdaa5a1caf258e3262515	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKUUIzQlNCUXd0eFcwaDJwZjhz\nblV5NkxBdDZIRUpZN1Z4cnE5NFlsM1FBPQY7AEY=\n	2015-11-03 03:05:56.461415	2015-11-03 03:05:56.461415
613	9543f125490b2366110470a7048f545a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOUDAvanlsRCtoVlE2OVdlODhl\ncG9yaGZDSkFRS2VLc1ZmQTcrekV5czc0PQY7AEY=\n	2015-11-03 03:19:52.850077	2015-11-03 03:19:52.850077
614	fcf62fa401334d9094add390562a01ed	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1Q1poekVOVTViMjFJN3ZGVXV5\nendhV2JmenNtSFJIcEp4cnR4WDFvbVNrPQY7AEY=\n	2015-11-03 03:41:40.368536	2015-11-03 03:41:40.368536
615	4f0186022d30a11d926116555165754f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPZmNVaXVXQVlVdzBlaG9HVmlP\neDFQdGxFQSs2dDFjSnhEeG1ydURoMkUwPQY7AEY=\n	2015-11-03 03:58:14.10301	2015-11-03 03:58:14.10301
616	f9bf6bfe2755c651a220b07459cd2df2	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVYzFiZTFkOWRhMGQ5YzdiOQY7\nAFRJIg1vcmRlcl9pZAY7AEZpKEkiEF9jc3JmX3Rva2VuBjsARkkiMThURlAw\nRHVvekRsOFhKVS9lOC9zMXRtYmNEYnM0YStxYUpNOHV1T3krTGs9BjsARg==\n	2015-11-03 04:03:28.448369	2015-11-03 04:03:28.448369
617	508cc35163da891b1beebbfae3367884	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5OG5nbXp5cStPZEVWek16VVYz\ndEhXNkIrOWZhU2xrSnFvQklrcHFBeGc4PQY7AEY=\n	2015-11-03 04:06:57.069684	2015-11-03 04:06:57.069684
618	23d764bc8e43160bbe37e4e16e45b1db	BAh7CEkiEWFjY2Vzc190b2tlbgY6BkVGSSIVMzNhNzhjMDM0ZDcwMzMwNAY7\nAFRJIg1vcmRlcl9pZAY7AEZpKUkiEF9jc3JmX3Rva2VuBjsARkkiMUlBU2dF\nQUJnVmRVQkQ4Z2FsNHZ2ci9QTmk3TnNJV3dUR0VOYUQyd1pGRm89BjsARg==\n	2015-11-03 04:13:55.835375	2015-11-03 04:13:55.835375
619	22cd9f13c4daae636590d7cfc5013182	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUV1ZPb0RQK3JsVlBzVDdSam5B\nUlVwbXZwRitoOHpBeE5VRWJ5dXR0WmtBPQY7AEY=\n	2015-11-03 04:23:31.025053	2015-11-03 04:23:31.025053
620	5457dc874051a1614b84fb2f140012d9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFwcVVUT2FnbloxUW9rTWRqRENJ\nUFBZcTdJVXllQ3NYTGhjdkpRaUg2aGdJPQY7AEY=\n	2015-11-03 04:24:23.104638	2015-11-03 04:24:23.104638
621	48832b0a799b59ae7d73384029f5c0b5	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaSDh2TFRWWWltY2FONEFTb05E\ndkRyN1FqNVpib2N5cjBxV0g2OTVmMmlZPQY7AEY=\n	2015-11-03 04:27:52.205649	2015-11-03 04:27:52.205649
622	d5432ff6e7fcd3af8d3f215ea34311d9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFuMTVMQWx4TWM1RTY4L1A0TFlG\na2hjM1VPZS9QRHQ1Vm80eWp0ZWpqTGVjPQY7AEY=\n	2015-11-03 04:34:50.639679	2015-11-03 04:34:50.639679
623	8f3f867e07d7db4810139580a139524b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzVElMcEVqSWNCRkVDRDVXY1o4\nQ2hiZDNpZ1N3SHVDelEramR5LzJ4dUk4PQY7AEY=\n	2015-11-03 07:17:02.304841	2015-11-03 07:17:02.304841
624	72a303f46efa269ad2ec17572655004b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqcWVob04yaU9IejQzVzNiQ25O\nRUQxdlF0M0hrT2dUbEhWTTdJREJ2c3lZPQY7AEY=\n	2015-11-03 07:30:57.644928	2015-11-03 07:30:57.644928
625	8c6abb6d92b174a963d2738bfacda2dd	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4U1QxSEdmbFF0R0FYSEJtNHVn\nYWZraWRITVlUbkMyNFE4ZVFXeEU5VnI0PQY7AEY=\n	2015-11-03 07:31:09.61978	2015-11-03 07:31:09.61978
626	1b69105466f2b64240dcd0e722cedc7e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnNTBVS1lJTk1kc3ZLcnJyMEJp\nWU94c0YvMTEvaDRBMVZTeG5DWUNBdEJZPQY7AEY=\n	2015-11-03 07:31:13.768347	2015-11-03 07:31:13.768347
627	bacede9353fd71f8f1e274ed66e171db	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqVkJndHpPRnNCSGg0RFFBWnRu\nWGtpcnExK3BPZThYckhTTXFPenIxTG5nPQY7AEY=\n	2015-11-03 07:31:17.823409	2015-11-03 07:31:17.823409
628	bfe0f8d72b056e99678a44abc4eb3bff	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2V25DQU5wdjZ0NktKS1ZqNXlh\nRC92MERPcjJrcS82a0FwclkzbUptNFZVPQY7AEY=\n	2015-11-03 07:31:21.778875	2015-11-03 07:31:21.778875
629	14678b12cda6a74ebb5c8d1c8b47f831	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFZelB2azNQb0NqeVlSYnBHQkJk\nU2gwbE1LOUptUUlEQ3JwZWs0ZzFpeW1nPQY7AEY=\n	2015-11-03 07:31:30.061731	2015-11-03 07:31:30.061731
630	16d73219397c325664449c53ea9bf737	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFTRTRWM0Yvalg2dUZVd1YzZHVM\neDluMFZLN3BpZzltTGJVdFNxWUNhVmpFPQY7AEY=\n	2015-11-03 07:31:33.626826	2015-11-03 07:31:33.626826
631	cdc50d160f86c5294fa88ff6f1ee0d77	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNNXJoTFMwbTBkbVcxMHEzRG9Z\nRzZiVWlVb0NDWUZaTU9KLzBHODNYN0NRPQY7AEY=\n	2015-11-03 07:31:38.065343	2015-11-03 07:31:38.065343
632	f1257a59fff58f5734626453f6d9f4fe	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFGelFGaWFQYXFaOXYyOU0zNERG\nYi9QUHAwVlg2bWNSVUlGZGMwaVpNdDkwPQY7AEY=\n	2015-11-03 07:31:46.174335	2015-11-03 07:31:46.174335
633	f617afcbf093b356768bfe7c80dd7eb3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFoUlFuSUJuem4xKy9qU2ZNbTFF\neFFXSnpjaVJHNFE0Y3Z1aGdDdEZTYzlnPQY7AEY=\n	2015-11-03 07:31:50.144968	2015-11-03 07:31:50.144968
634	1460b7ede2d71f1eaa3f886f6bd212df	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFqMXdvL2hkbEFMdm9VRTU4ekFm\nSXVBeG16L2tNWHZySXVwUTMxVlJpWTdNPQY7AEY=\n	2015-11-03 07:31:54.133349	2015-11-03 07:31:54.133349
635	85f54f38459c36676f3ee344c968011c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5TEJQMHl4aGt4WkZmc0VYQktS\nQnNFK1JyR0FsNzMwZzcwOVhWQUZpdytrPQY7AEY=\n	2015-11-03 07:31:58.232146	2015-11-03 07:31:58.232146
636	ce651161c9a5502cd20a687aa0b88043	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBb3UxY1hod1BFRElidDhGM3ha\nL0NaZ0Q1TVVXLytnRzZFS2dDQVlZNG9RPQY7AEY=\n	2015-11-03 07:32:02.445413	2015-11-03 07:32:02.445413
637	2272427e488c902c84719dd3eb76a649	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUQWhMNTQ5ZXA0YXU5Z25nWHVz\nSVI2TmJsdG0vaGdPenpnelVsY2lETjZRPQY7AEY=\n	2015-11-03 07:32:06.145573	2015-11-03 07:32:06.145573
638	cebf077f57e2daa5b0879e33dd083f27	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBMEFWREFJUlhTdUN5cDhpSTlY\nTkdSWUgvKzdyRi9nbjRTa0ZwNGFWSW5VPQY7AEY=\n	2015-11-03 07:32:10.145305	2015-11-03 07:32:10.145305
639	a407aba06ae603117e5401e72c83857e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5VThWR2JqUHg0QlV5UlQ3WmUv\nZ2xGeDRCR0dNS1hVV0dhRXRkMUhIZjRJPQY7AEY=\n	2015-11-03 07:32:13.759868	2015-11-03 07:32:13.759868
640	3cf421c23d443ece2a4fa82c1e02f29e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjcXdKTTFiemJaU1J0ZHo1MzdN\nbExFMzEwOXNzU1BtYWtFS3hVQUZPSFJnPQY7AEY=\n	2015-11-03 07:32:18.019888	2015-11-03 07:32:18.019888
641	5135cd1e085b8dc41235c0a4bc005e99	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEydFI1dVVNRVdnaTNFVWdxZWVi\nVEU1ZERuaFRmMnJjU3QyeXloaE1jUEh3PQY7AEY=\n	2015-11-03 07:32:21.972705	2015-11-03 07:32:21.972705
642	d8bd0e91d026967b842679969d8ca3c4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4WmJmMWwvbkZDVk51STB2WHd2\nOFlPZFRxeEFhdTBvSDc5MXRVTVM1QlRrPQY7AEY=\n	2015-11-03 07:33:32.186569	2015-11-03 07:33:32.186569
643	4d00d3c645828506d7b664d655dd58ec	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzSXE5V1E1a2svSXJZcU1QR1Zv\nSWF0QmN6TnYvRy9pdnBoMkdnd1VZK0pnPQY7AEY=\n	2015-11-03 07:34:24.491434	2015-11-03 07:34:24.491434
644	b71cc0b6f73259a9759aa564f1106ab1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRamlZRG1lbmdaM2RLbDJCVUtp\nNSswV01nekExTldESm5DNlJlb053cVYwPQY7AEY=\n	2015-11-03 07:41:47.927701	2015-11-03 07:41:47.927701
645	9877973dc7630f417df2960a6c004dbc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFKZ2RvbHhWSVFRdXBlb2xDU0lp\ndlRHaEZhRmxmWmNXUEdNQW5LT0x1UEcwPQY7AEY=\n	2015-11-03 07:52:42.602241	2015-11-03 07:52:42.602241
646	b5c42c36110f81c4428b04f6ceebddf4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmZmMva2V6MXN5M1cxbmFRei9W\nVEgxYXhYamhab05PMVZuNHBoUW1mdTFnPQY7AEY=\n	2015-11-03 08:18:47.577574	2015-11-03 08:18:47.577574
647	5f979befbc5c544de3e87e9135fee8d1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCNVpIbzUwNEEvNE1NRWRYNDZX\naVJ2UG5hTzlxbm9JODlTNnlhOHNnS3lvPQY7AEY=\n	2015-11-03 08:19:33.338702	2015-11-03 08:19:33.338702
648	4e3c4ad3e51c526c4787b0c117f11a6e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUc200Umw5cExlcW9UR3h1bkFK\nWnR4TWlNeUVDSERtdnBCRDVsTUxzWEFrPQY7AEY=\n	2015-11-03 08:25:46.339928	2015-11-03 08:25:46.339928
649	5c2e9e78247965c897b9548a250250bb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVeWE1am82NVhUTFNyT29nMmRp\nZ2JKN2FUbTVFbjNydUJCMU83dzlYbVpJPQY7AEY=\n	2015-11-03 08:45:31.888254	2015-11-03 08:45:31.888254
650	4bbd80488e882295b29e1153148daf20	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0YlJSNWVGQ2Z0QnBZRmxyUmpS\nM093MFVpSUxOUUZnTDV1SGZDcElVTWo0PQY7AEY=\n	2015-11-03 08:45:42.945998	2015-11-03 08:45:42.945998
651	83b7f1ae1b5375aac3dc82cc9691bccf	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE0akttRUY1NkxDSU9EZmp1NWdX\nWkhPcktzckZVcnVBejlYM0k0enhVLzdJPQY7AEY=\n	2015-11-03 08:45:46.618432	2015-11-03 08:45:46.618432
652	f1d57ba66c7e5cccd7b058996beecfa3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzS05vWjgwVkVKRTJCRU5YcDlK\nN05iR3FaaDBmWTFWaXkvR3pURzcwV2E4PQY7AEY=\n	2015-11-03 08:45:50.297649	2015-11-03 08:45:50.297649
653	a8ab291654a7767d8cc30c3966fa6af1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFnZVF4Y2k5S0hSK0VqTkVYR01W\nVDQ2RDZ4OGo3Ty9TQ3VwdkZFOVBCQktRPQY7AEY=\n	2015-11-03 08:45:54.172568	2015-11-03 08:45:54.172568
654	05460914323ae46619320d3bfa6279a7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFOSzl5R2UycGgzTzJXb3dSNFdp\nUWdzOFlwWnlFNFo4c2R5aGxYK3ZLR0tVPQY7AEY=\n	2015-11-03 08:46:01.072378	2015-11-03 08:46:01.072378
655	68212e0f9f84426fbebd7269f88a4972	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSM1V2c3JNTE5FWlVpaVJneGwz\nVklUTjhFQzJiZGRsWmJDdGVDaytEZHVRPQY7AEY=\n	2015-11-03 08:46:04.657954	2015-11-03 08:46:04.657954
656	964f76b0252cf363582bf0e6a0a66721	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFacTBNamZsWi9aYTNsWEJTWHp3\nSitLSExReEJGVmszTlU5L3BoZ1JZY053PQY7AEY=\n	2015-11-03 08:46:07.967991	2015-11-03 08:46:07.967991
657	60e127d5fb00be1cf0d774da00fe7fe8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSeEFweEhEYlBHQ0QrWUtPcGpY\nRlJ5bWhmV29PS2NMUVpSVHVhT3czOEpBPQY7AEY=\n	2015-11-03 08:46:14.921523	2015-11-03 08:46:14.921523
658	637b6fef72c86b5ac954162d33dcc8fe	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkaC8zN0tnQWt4Snh1M1NzdFcx\nVDVUcFQrZGY1Z29GWUgrS09ab3dpbnFRPQY7AEY=\n	2015-11-03 08:46:18.307314	2015-11-03 08:46:18.307314
659	65cdbb33f84cf8550560ff8ce6f43339	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFQNFZPamVnTlhQMGE1QnlqVUNS\nYmNOZWQ2OWQrOCtGem9samFBajlUVmk4PQY7AEY=\n	2015-11-03 08:46:21.851783	2015-11-03 08:46:21.851783
660	18946e213ecde8cc111e4139385490ad	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWMk52SEd1WXI5cUVrNTNYTy9Y\neXhudTZveUx3VEZIaDFkU05xUDZIOEpFPQY7AEY=\n	2015-11-03 08:46:24.987679	2015-11-03 08:46:24.987679
661	8c38432475376a63223ce937863c6bd8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVZE5FLzlHT1pLekJLb29Hd0RB\nOGR0VmRtNXV0NXZZeThCUVJ6U29oVzhJPQY7AEY=\n	2015-11-03 08:46:28.509992	2015-11-03 08:46:28.509992
662	2c436f8bd6e0894f3d1119ea0cbf0e97	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDaDR1dmRjbDJ1dFdVZjVxOGFP\nNkNPSXJ2Q20xUGQwTE1JVVl1ZmQ1TEl3PQY7AEY=\n	2015-11-03 08:46:31.887551	2015-11-03 08:46:31.887551
663	1e0104ed0640b2cd57d044a293cc7786	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiUnBLakk1ZEJkdlZnRklSODBk\nT1h5T0ZqT0kyc0FjeFRWb0VuekhKL1Y0PQY7AEY=\n	2015-11-03 08:46:35.068512	2015-11-03 08:46:35.068512
664	8e238ddcc825d7e7a9ab591fa3e1a1a1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2bmcrZTZMZzVTZFJJU25idGZa\nbWx6R1pPR1BIbzJTUkVQcHdJazk2aDI0PQY7AEY=\n	2015-11-03 08:46:38.500733	2015-11-03 08:46:38.500733
665	a856bc1ff13b31d6cdb1aa0aa7aee53f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLUGIyVFViNGpQL01pc1QvQ1Qx\nODJRYVlCYzJVUkJSVkE3VnVLSkwzcEdzPQY7AEY=\n	2015-11-03 08:46:41.33638	2015-11-03 08:46:41.33638
666	f6d6c7ea2b85852e119ac220353e4f64	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUZG4vMHVROCtFWWFQUTJsVlBs\ndzNXS0dzQmlPaDlLeTRyaWN2S1RndkJZPQY7AEY=\n	2015-11-03 08:46:44.593502	2015-11-03 08:46:44.593502
667	729947861c4a23d6339491dfe06e65a3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF2R3YzN2d4ZTFnUUlQRndCUFJt\nSlc0REtBZHp5dTNVMFdWOFZvNlBCL2lVPQY7AEY=\n	2015-11-03 09:06:48.728371	2015-11-03 09:06:48.728371
668	e8792c3c5dd3019440f55e4b86a6054a	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3Vm9UMjROOU1rRitiSTloeUxD\nUHpsbjRpTkdXcGIvc29uV2NEbllKeVVRPQY7AEY=\n	2015-11-03 09:08:32.88308	2015-11-03 09:08:32.88308
669	482c1fe99fda376a38b08b1c06f42d5f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFOXBISGNZSUR6SkIxR2liYzJK\nODZSTzNPR2hxK0lkYU9GZVd3aXVLeFV3PQY7AEY=\n	2015-11-03 09:23:19.85441	2015-11-03 09:23:19.85441
670	a767dfb8fdb09ea458d13d23b5c96b99	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFFT1JmOGZtN3RNeTVFb0c4LzVK\nNHE0UnF1blMzc05TNWNOK044cVJtN0JNPQY7AEY=\n	2015-11-03 09:46:24.922064	2015-11-03 09:46:24.922064
671	1fa2c482c62c66d3d038872bcc87e4d7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCUmJZb0VyeVhUZktQNjFDazRC\nVDZQTFQxZ3VmTFVHOUxmN0UzelNnOTI4PQY7AEY=\n	2015-11-03 11:15:05.235826	2015-11-03 11:15:05.235826
672	f78c428fbaa003c2d1f420e0d72e62d7	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFYd2x2OFpSWW1EckpPdk9TcjZM\nYVJpWGkybEM0WDhpZm5STm9kaU45TUYwPQY7AEY=\n	2015-11-03 11:38:22.160507	2015-11-03 11:38:22.160507
673	ab626f7d84d7f37a537315953bbcdba4	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExdGxHUEtiOHFnTmdreHUwcWI0\ncjYrS21CKzF6d00wVURtVnJtbWpHRDU4PQY7AEY=\n	2015-11-03 11:55:51.001027	2015-11-03 11:55:51.001027
674	43d501086e72ca52e19d1f582af4b85d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvaStjbDdHb3VpWTdneFp1cWZi\nbWVkS2FpMitUU2s3Z0Jwc2RISmk4eDNFPQY7AEY=\n	2015-11-03 13:14:05.144944	2015-11-03 13:14:05.144944
675	b8bb100fc221c504eb174034c112f3c6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrYW5WcW5UUlIzQ09pZFg0THBI\nVlphbjUweDZQWTRkdjZLbXgwMnkyZDMwPQY7AEY=\n	2015-11-03 13:14:08.730254	2015-11-03 13:14:08.730254
676	2e9923ff7bb9f20929317ec80925ce4e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFlMXp2Tm4zcWpaWVEyN0U4MHNh\nK0liWDh0M1hxSGo4MEl3Szg1SVg0ajQ0PQY7AEY=\n	2015-11-03 13:43:02.103421	2015-11-03 13:43:02.103421
677	1cae81a4f6c10da9c461bb886cc1b9a1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmOVc5UXBnb3JReHU1MGJTQ0tu\nZzhzUXQ2dEp6ZE1JSVE3VVBHMEltNUJnPQY7AEY=\n	2015-11-03 14:09:49.498114	2015-11-03 14:09:49.498114
679	c871954892e581c91bc68788a142eb7c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpS2RjMzRXMWxGT1B2OVIrOEo1\nbG5aZDFYa0U3STR5dFE5NnlTa3Z2bG5FPQY7AEY=\n	2015-11-03 17:08:05.090621	2015-11-03 17:08:05.090621
680	de96fe7fbb93e43e5938996821ebdbf1	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5Qm5nS1NBcDFhcTV0ejhRekZQ\nWFR5eUdXSXgxdzdoTUc3WjJ1ZUdtMjVBPQY7AEY=\n	2015-11-03 17:24:23.27746	2015-11-03 17:24:23.27746
681	ffef93b33722ff335b153b4025254d06	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjamlpbW5jMEhFTVVtTFdqdms5\nc0lIRkd5S0xyeTF6UlVrUFBBV3VENCtBPQY7AEY=\n	2015-11-03 18:09:49.779063	2015-11-03 18:09:49.779063
682	aefb68000e18a48b23e1a1e7fcd3cf12	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFzTGdzcWdLTVRJQzA5cWNSZzJX\nMVdINWs0ZFdSd096MmRaVXN4K2hWamhzPQY7AEY=\n	2015-11-03 18:50:29.057148	2015-11-03 18:50:29.057148
683	743172bdc1ac9836193e3c55cf1ce4c0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFucFNiVkloK0JYWkthU3g2Zy9C\na2NjTEtLU2Vudzd3Nmt3NW43R0k2emFrPQY7AEY=\n	2015-11-03 19:40:35.214629	2015-11-03 19:40:35.214629
684	79cc912a777d0349539d7d13b15a5e3f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFEKzNkNDJsWVk5b3N6SGt0UDhv\nTUxrUFY5WnAyMEl3WTRlWk9DSEtFQXlnPQY7AEY=\n	2015-11-03 19:52:53.217249	2015-11-03 19:52:53.217249
685	2d8dc1301185a5ec7bc245ccaa26cb17	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFubFA1aVRDM1pXSEQzcFNXWjla\nT0V0b296cUtuMHVCdGFuZG9mcUN4aXk4PQY7AEY=\n	2015-11-03 20:16:15.295392	2015-11-03 20:16:15.295392
678	e4db2ca74265ce26a54c75685a9ef27b	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCRnhYeUNOblVkUytoY3F6RTIx\nRHhHbjU2N3R4U3JYOWs4MWcvbmo4ZHdvPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNWQwYWRjOWExN2RiNmM2YwY7AFRJIg1vcmRlcl9pZAY7AEZpKg==\n	2015-11-03 16:33:53.714092	2015-11-03 20:41:36.210962
686	db01339f646c66262c55b80a024202c0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5V0NIVHI4Z0RVZkZvV3FyZDRC\nUFljbXBUSEViSGFKaTdFQUt5Rjc0c1h3PQY7AEY=\n	2015-11-03 20:41:45.7051	2015-11-03 20:41:45.7051
687	9e9f973853ba27d5b12c6c20ec114174	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFNajlFdXF2RGVmZXd2bXUzcUFM\nRU51OUhVM0ZYcjF3Nm8wM0VTRzVLMWdjPQY7AEY=\n	2015-11-03 21:04:15.054685	2015-11-03 21:04:15.054685
688	919a85a0b97a34827a348dc6b683dfca	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF5YUJOenFzcmxUbVplSW9NK05K\nSGh2Y0YrMnlTRjFuSVNuaHBaTlZLM3JjPQY7AEY=\n	2015-11-03 21:18:33.979514	2015-11-03 21:18:33.979514
689	46de09539ed9db9cfe5c7465dbbcfefb	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjeEJTR0lVQ1FSaEJpbVVyZHh0\neDJBR0pDRFJ0Q2lGMDlYQmFRZnVKeEF3PQY7AEY=\n	2015-11-03 21:22:03.537181	2015-11-03 21:22:03.537181
690	10f1d2817b61ca21b2e361ecbd4ad09e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBT0ovd21rcUU5dmtJUW1qQVlE\nYmtJQjB4VXlPNzdKaVhmaVRlTWhmZDJRPQY7AEY=\n	2015-11-03 21:41:08.8036	2015-11-03 21:41:08.8036
691	e03df55c3c7b00dcc93d01a02ba6be9e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjErc3loQUJZSjNIa0crZHUyTnVJ\nVFlqMmFMQzBUbG0yNnZxZTFlai9scHRrPQY7AEY=\n	2015-11-03 21:55:22.057578	2015-11-03 21:55:22.057578
692	c4b310dc68b3cda5390988704d13e172	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE1WGZQNTVnY1N3cHRicEFHMW1t\nVlRwbWlWUUU5elZhczFxbEUzSEVuMWZvPQY7AEY=\n	2015-11-03 22:39:09.831363	2015-11-03 22:39:09.831363
693	c32c1babbb68872b93794af2e82eded8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvMTh5UzRaN2hPcFR2Ry9UTEYv\nbnVyOHFSUnRUQ0YwcVRBQml6eW8rQmxzPQY7AEY=\n	2015-11-03 22:39:11.618989	2015-11-03 22:39:11.618989
694	6940fe177ecd188127277ba14c1ab42f	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUWlhyUEFaN1g3TEhNVmpMVi9Z\nL3FIT1ViMm5HaWpTbW42ckFXdUkxamlNPQY7AEY=\n	2015-11-03 22:39:20.321968	2015-11-03 22:39:20.321968
695	ffbdd69c53e55a5c6f7805f34757c480	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFHMkpHZFliZy9SY2syZHROZThE\nam1ud0lxYjlWaCtSOVdNSFBwZ0xtNllBPQY7AEY=\n	2015-11-03 22:59:55.790961	2015-11-03 22:59:55.790961
696	7bb6d66df15f1cbdadd4eb9465385bcc	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDdTFNRUcwQXBCNEJlZzd4bjVO\nMDJrMk8rMnJKVGNLUU9lclhhWTVPcWRvPQY7AEY=\n	2015-11-04 00:49:50.47655	2015-11-04 00:49:50.47655
697	e9427e24864bcd6fd6b36c7e55245e6e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE4NUkzdFFteUlIelp3Q0U0TGxk\nL1VWcTdqay9XOG9Sdm5pVWNoNUdNZ0N3PQY7AEY=\n	2015-11-04 05:04:28.896699	2015-11-04 05:04:28.896699
698	2bbc6e60379e0e7de6ed86dbab5af12b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLSTRDS04xTTNnNElleXZrdS9s\nSHFsRlNvd3h2bzQvQ2xiRXJsNkpIUXNBPQY7AEY=\n	2015-11-04 05:07:25.058572	2015-11-04 05:07:25.058572
699	e2ba45d08dafdbccdbe4ec7cf6e4ebf8	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExYVVBWi9WV1pXekhsaWFmbXQx\nRS9LNWdnQmJaV2lETlN2RW8vRE9DcEtZPQY7AEY=\n	2015-11-04 07:13:24.983072	2015-11-04 07:13:24.983072
700	f48035faceced4413e68dc9612052186	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFiQmtabURycnZIUHpSby81UnUw\nVUd6b3N2bVI1VFFFSXJWZnhOZi9sQTZvPQY7AEY=\n	2015-11-04 08:27:14.270307	2015-11-04 08:27:14.270307
701	f9cf9776f9e27f25233d5f08a9556113	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFWQXJzSkh6cXBsNHplMmpDb1dS\nYWtRd2NxQTdMS2VacHFJQ3gzT0dFZ09nPQY7AEY=\n	2015-11-04 08:35:57.78051	2015-11-04 08:35:57.78051
703	776cf74cb3302087a02aea6deb14bd07	BAh7C0kiEF9jc3JmX3Rva2VuBjoGRUZJIjFIRHplazByUzFPNndCSm5hZEtY\nd2dVYjVQc04vaTZOeEF2Vm1FMzY1YWI0PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVZThiY2MwMjUxN2Q4NWI0ZQY7AFRJIg1vcmRlcl9pZAY7AEZpK0ki\nGXNwcmVlX3VzZXJfcmV0dXJuX3RvBjsARkkiBi8GOwBGSSIfd2FyZGVuLnVz\nZXIuc3ByZWVfdXNlci5rZXkGOwBUWwdbBmkUSSIZdlhvbXhxVE1xcE5BZGd5\nYzRMMXUGOwBGSSIKZmxhc2gGOwBGbzolQWN0aW9uRGlzcGF0Y2g6OkZsYXNo\nOjpGbGFzaEhhc2gJOgpAdXNlZG86CFNldAY6CkBoYXNoewY6DHN1Y2Nlc3NU\nOgxAY2xvc2VkRjoNQGZsYXNoZXN7BjsKSSIuV2VsY29tZSEgWW91IGhhdmUg\nc2lnbmVkIHVwIHN1Y2Nlc3NmdWxseS4GOwBUOglAbm93MA==\n	2015-11-04 09:00:26.206951	2015-11-04 09:00:27.358058
704	aec6503212143a553602c08ed29e339d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjExUG9BZXBOdXZJb2RrWmZ3UU1l\nNk05eGVVQlU3NUpkSHRmeFRUS0IrN0pJPQY7AEY=\n	2015-11-04 11:16:01.755151	2015-11-04 11:16:01.755151
705	2dcdc1b8970abfad29b88e1300bafda2	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFERUVrdFJGWmVmLzREYzVQV1dq\ncFRlVlhBaFZDQ05DUmFoOTA0VklhaUg4PQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVNjRiNjlhNzI1NDg0ZWVjYQY7AFRJIg1vcmRlcl9pZAY7AEZpLA==\n	2015-11-04 15:15:03.130578	2015-11-04 15:15:40.282182
706	9b96640dd816d244f429a0b5b7cada47	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEwZUE0L1FFWlY4bGlza21lY01Z\nOG83TDV6STB6eVUvWEE0d1YvM3RlRUE0PQY7AEY=\n	2015-11-04 15:21:01.262451	2015-11-04 15:21:01.262451
707	93e51ad898bf9a0f51f9cad37b76ecac	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFRandLYXRLY3owV3IxQThaR0l0\nV1RmTy9jQlNPa29xbUhTb1Y1eHlkdDdNPQY7AEY=\n	2015-11-04 15:41:48.843883	2015-11-04 15:41:48.843883
708	2ef974c8972263eeb748e9ab0e986264	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrcUJmRVVGSktwNURNdHZzNjdq\nTGIxNzIrdzBYZTRBZFpwd2l6a0NwWkR3PQY7AEY=\n	2015-11-04 17:59:09.224647	2015-11-04 17:59:09.224647
709	c0839fb895f6abe7f799ac8ccfc623e9	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLc0hYY0VVTHZvblBsZU9mTG9O\naW5FdE5MMkxiajdJbmNjY1pUWlZXcnVzPQY7AEY=\n	2015-11-04 18:43:15.612698	2015-11-04 18:43:15.612698
710	a0697a2ebd56822b3d94595dd3b9c6e9	BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrK3hWUno0UXNrS2Q2OC9KbDVu\nc1ZkbHFmVUU2NkM4V2l2ZzVacnVWZ2trPQY7AEZJIhFhY2Nlc3NfdG9rZW4G\nOwBGSSIVMDMxN2ZjNzQ0MzI1MDhhNQY7AFRJIg1vcmRlcl9pZAY7AEZpLQ==\n	2015-11-04 18:43:15.875647	2015-11-04 18:55:17.960587
711	55f5cb0ac4b4209850446ae594e3e86c	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF4ak1ETTJ5bnVsNVBWMnRBcURk\nNVovT3MrSUwyRTdVcUo2Y2VDWm5hTHk4PQY7AEY=\n	2015-11-04 23:10:47.526765	2015-11-04 23:10:47.526765
712	219b3ecdf3f696da6263f9a5e1a7d92e	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFIa0RadGxCcmRwTlBWUEpLVzlm\nTG14K245Q1BGT3VqWVBLV2JsNHFhU1dzPQY7AEY=\n	2015-11-05 01:22:45.24179	2015-11-05 01:22:45.24179
713	c6c1a6694192ce453e2e26129cb9246d	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUMndkOWJDQ0Z3RlZMQjBIWUYx\nZldsWDg5cGxCMXM5dHpXRWx1Y3BkVWd3PQY7AEY=\n	2015-11-05 01:51:21.054173	2015-11-05 01:51:21.054173
714	4f02a78cfc8e24f7e7ace54c17f9fb75	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFjY28xNnNnNS94VlJzOHpVQ3VY\nbTNMZk9hS2IvU2tzZGNCYkk3ZDFqemJrPQY7AEY=\n	2015-11-05 04:33:33.157421	2015-11-05 04:33:33.157421
715	78adac778d408e2e5258d6605f72867b	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF6bStFZkxobllxcElIMG95dWpT\nM2pIWi9PY3lPNE9DcWxDU3JWWnRuK3NBPQY7AEY=\n	2015-11-05 07:01:23.105515	2015-11-05 07:01:23.105515
716	e8c0560432b8b5b56ee1b9d9b00a24b3	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFLTktVbEdoV1FPSno3T1JNN04y\nRUFHTDYzbVdXd2xIbTIwNnVSZllaemM0PQY7AEY=\n	2015-11-05 08:43:28.044967	2015-11-05 08:43:28.044967
717	8a90f6e2ff79b98e80cf26547a0589ed	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMQU9xa0ZIekREamNiVjNlMVpE\nMTIyS2YzRlAzNTBzV0xVY3l1S0g5WENZPQY7AEY=\n	2015-11-05 08:56:18.731059	2015-11-05 08:56:18.731059
718	407728c625ccc1da5eadc4bc67d409ee	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpQklnaUtsNlBHTWtHQUtnOVBB\nRGdMa1Y4S01XL3N1anN3MVN0RllldDVJPQY7AEY=\n	2015-11-05 08:56:21.910932	2015-11-05 08:56:21.910932
719	4f86f0a178141889b356e98d905c92b0	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFUNVN2UHhwYWxEdERFcno5ckw1\nQ0ZodktOcVppQ2FNT1FhRVJ1a3o3MDhvPQY7AEY=\n	2015-11-05 09:06:35.606303	2015-11-05 09:06:35.606303
720	a27079029f612777f498e50260f1e825	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE3MXgyZWplenljYTl1M1RLN0tK\nM2N4NUNhRTh1MzVNSkFxNmJETCtuZnRnPQY7AEY=\n	2015-11-05 09:06:44.021218	2015-11-05 09:06:44.021218
721	585d5eadcf6628a4ffd9ad38a3263fb2	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFMT0FyWGdjTlBZemwrMmw1aUFl\neWYxTWFoR2tJNk00M1BpYzkvMnRreWZZPQY7AEY=\n	2015-11-05 10:03:58.487924	2015-11-05 10:03:58.487924
722	d11a2c620568a46400cca86211f674b6	BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFrWDZMUjlCNm9ZSWphSzg1cWow\nU3hRU3d5TExrLzRFOVVhdWtPcGN6bWd3PQY7AEY=\n	2015-11-05 10:32:25.224722	2015-11-05 10:32:25.224722
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('sessions_id_seq', 722, true);


--
-- Data for Name: spree_activators; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_activators (id, description, expires_at, created_at, updated_at, starts_at, name, event_name, type, usage_limit, match_policy, code, advertise, path) FROM stdin;
\.


--
-- Name: spree_activators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_activators_id_seq', 1, false);


--
-- Data for Name: spree_addresses; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_addresses (id, firstname, lastname, address1, address2, city, zipcode, phone, state_name, alternative_phone, state_id, country_id, created_at, updated_at, company, latitude, longitude) FROM stdin;
1	unused	unused	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	unused	\N	\N	78	230	2015-10-16 03:29:12.625055	2015-10-16 03:29:12.625055	\N	\N	\N
2	unused	unused	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	unused	\N	\N	78	230	2015-10-16 03:29:15.726957	2015-10-16 03:29:15.726957	\N	\N	\N
3	unused	unused	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	ofn@ofn.ru	unused	\N	\N	78	230	2015-10-16 03:30:00.067747	2015-10-16 03:30:00.067747	\N	\N	\N
4	unused	unused	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	unused	\N	\N	78	230	2015-10-16 04:14:45.600333	2015-10-16 04:14:45.600333	\N	\N	\N
5	unused	unused	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	unused	\N	\N	78	230	2015-10-16 04:14:49.571997	2015-10-16 04:14:49.571997	\N	\N	\N
6	unused	unused	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	ofn2@ofn.ru	unused	\N	\N	78	230	2015-10-16 04:15:11.104148	2015-10-16 04:15:11.104148	\N	\N	\N
7	unused	unused	26 Portman Road	\N	Bryanston	2021	unused	\N	\N	74	230	2015-10-16 06:24:49.181716	2015-10-16 06:24:49.181716	\N	-28.530553900000001	30.8958241999999998
8	unused	unused	26 Portman Road	\N	Bryanston	2021	unused	\N	\N	74	230	2015-10-16 06:26:32.242534	2015-10-16 06:26:32.242534	\N	-28.530553900000001	30.8958241999999998
10	unused	unused	78 main street	\N	Howick	3290	unused	\N	\N	74	230	2015-10-23 12:37:29.308738	2015-10-23 12:37:29.308738	\N	-29.4802399999999984	30.2271299999999989
11	unused	unused	78 main street	\N	Howick	3290	unused	\N	\N	74	230	2015-10-23 12:42:00.390474	2015-10-23 12:42:00.390474	\N	-29.4802399999999984	30.2271299999999989
12	unused	unused	78 main street	\N	Howick	3290	unused	\N	\N	74	230	2015-10-23 12:49:33.847351	2015-10-23 12:49:33.847351	\N	-29.4802399999999984	30.2271299999999989
9	unused	unused	26 Portman Road		Bryanston	2060	unused	\N	\N	74	230	2015-10-16 06:27:37.047842	2015-10-23 13:28:32.337416	\N	-26.0506558999999989	28.0276268000000002
13	unused	unused	Misty Meadows Farm	D 17	Howick	3265	unused	\N	\N	74	230	2015-10-30 06:06:59.615814	2015-10-30 06:06:59.615814	\N	-29.4892950999999996	30.2166518999999987
14	unused	unused	Misty Meadows Farm	D 17	Howick	3265	unused	\N	\N	74	230	2015-10-30 06:08:58.857611	2015-10-30 06:08:58.857611	\N	-29.4892950999999996	30.2166518999999987
15	unused	unused	Misty Meadows Farm	D 17	Howick	3265	unused	\N	\N	74	230	2015-10-30 06:16:05.589523	2015-10-30 06:16:05.589523	\N	-29.4892950999999996	30.2166518999999987
\.


--
-- Name: spree_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_addresses_id_seq', 15, true);


--
-- Data for Name: spree_adjustments; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_adjustments (id, source_id, amount, label, source_type, adjustable_id, created_at, updated_at, mandatory, locked, originator_id, originator_type, eligible, adjustable_type, included_tax) FROM stdin;
1	6	0.00	RefundVAT 1.4%	Spree::Order	6	2015-10-16 16:13:37.972612	2015-10-16 16:13:37.972612	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
2	7	0.00	RefundVAT 1.4%	Spree::Order	7	2015-10-18 04:30:33.756809	2015-10-18 04:30:33.756809	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
3	8	0.00	RefundVAT 1.4%	Spree::Order	8	2015-10-18 14:02:14.667615	2015-10-18 14:02:14.667615	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
4	9	0.00	RefundVAT 1.4%	Spree::Order	9	2015-10-18 15:27:36.424497	2015-10-18 15:27:36.424497	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
5	10	0.00	RefundVAT 1.4%	Spree::Order	10	2015-10-18 15:53:41.434602	2015-10-18 15:53:41.434602	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
6	11	0.00	RefundVAT 1.4%	Spree::Order	11	2015-10-18 16:03:44.931448	2015-10-18 16:03:44.931448	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
7	12	0.00	RefundVAT 1.4%	Spree::Order	12	2015-10-18 16:37:09.822393	2015-10-18 16:37:09.822393	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
8	13	0.00	RefundVAT 1.4%	Spree::Order	13	2015-10-18 19:07:30.221868	2015-10-18 19:07:30.221868	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
9	14	0.00	RefundVAT 1.4%	Spree::Order	14	2015-10-18 20:21:01.824649	2015-10-18 20:21:01.824649	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
10	15	0.00	RefundVAT 1.4%	Spree::Order	15	2015-10-19 09:54:36.053416	2015-10-19 09:54:36.053416	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
11	16	0.00	RefundVAT 1.4%	Spree::Order	16	2015-10-19 14:32:16.678401	2015-10-19 14:32:16.678401	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
12	17	0.00	RefundVAT 1.4%	Spree::Order	17	2015-10-19 16:38:35.342488	2015-10-19 16:38:35.342488	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
13	18	0.00	RefundVAT 1.4%	Spree::Order	18	2015-10-19 21:26:45.652289	2015-10-19 21:26:45.652289	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
14	19	0.00	RefundVAT 1.4%	Spree::Order	19	2015-10-20 07:44:54.586105	2015-10-20 07:44:54.586105	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
15	20	0.00	RefundVAT 1.4%	Spree::Order	20	2015-10-23 09:27:09.289169	2015-10-23 09:27:09.289169	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
16	21	0.00	RefundVAT 1.4%	Spree::Order	21	2015-10-23 12:34:38.162035	2015-10-23 12:34:38.162035	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
19	24	0.00	RefundVAT 1.4%	Spree::Order	24	2015-10-25 13:28:55.987417	2015-10-25 13:28:55.987417	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
20	25	0.00	RefundVAT 1.4%	Spree::Order	25	2015-10-25 23:45:05.751979	2015-10-25 23:45:05.751979	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
23	28	0.00	RefundVAT 1.4%	Spree::Order	28	2015-10-26 18:58:44.474344	2015-10-26 18:58:44.474344	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
24	29	0.00	RefundVAT 1.4%	Spree::Order	29	2015-10-28 06:43:28.013519	2015-10-28 06:43:28.013519	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
25	30	0.00	RefundVAT 1.4%	Spree::Order	30	2015-10-28 08:11:39.4605	2015-10-28 08:11:39.4605	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
26	31	0.00	RefundVAT 1.4%	Spree::Order	31	2015-10-29 14:32:44.657883	2015-10-29 14:32:44.657883	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
27	32	0.00	RefundVAT 1.4%	Spree::Order	32	2015-10-30 06:05:38.304896	2015-10-30 06:05:38.304896	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
28	33	0.00	RefundVAT 1.4%	Spree::Order	33	2015-11-01 14:54:40.097629	2015-11-01 14:54:40.097629	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
29	34	0.00	RefundVAT 1.4%	Spree::Order	34	2015-11-02 10:44:12.220409	2015-11-02 10:44:12.220409	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
30	35	0.00	RefundVAT 1.4%	Spree::Order	35	2015-11-03 04:03:27.469798	2015-11-03 04:03:27.469798	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
31	36	0.00	RefundVAT 1.4%	Spree::Order	36	2015-11-03 04:13:55.072499	2015-11-03 04:13:55.072499	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
32	37	0.00	RefundVAT 1.4%	Spree::Order	37	2015-11-03 20:41:35.24107	2015-11-03 20:41:35.24107	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
33	38	0.00	RefundVAT 1.4%	Spree::Order	38	2015-11-04 08:58:55.551464	2015-11-04 08:58:55.551464	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
34	39	0.00	RefundVAT 1.4%	Spree::Order	39	2015-11-04 15:15:39.413512	2015-11-04 15:15:39.413512	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
35	40	0.00	RefundVAT 1.4%	Spree::Order	40	2015-11-04 18:55:16.877559	2015-11-04 18:55:16.877559	\N	t	1	Spree::TaxRate	t	Spree::Order	0.00
\.


--
-- Name: spree_adjustments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_adjustments_id_seq', 35, true);


--
-- Data for Name: spree_assets; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_assets (id, viewable_id, attachment_width, attachment_height, attachment_file_size, "position", viewable_type, attachment_content_type, attachment_file_name, type, attachment_updated_at, alt) FROM stdin;
1	1	2048	1536	360865	1	Spree::Variant	image/jpeg	brocoli.jpeg	Spree::Image	2015-10-16 06:42:18.741557	\N
\.


--
-- Name: spree_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_assets_id_seq', 1, true);


--
-- Data for Name: spree_calculators; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_calculators (id, type, calculable_id, calculable_type, created_at, updated_at) FROM stdin;
1	Spree::Calculator::DefaultTax	1	Spree::TaxRate	2015-10-16 06:40:53.179321	2015-10-16 06:40:53.179321
2	Spree::Calculator::FlatRate	1	Spree::ShippingMethod	2015-10-23 13:01:53.713351	2015-10-23 13:01:53.713351
3	Spree::Calculator::FlatRate	2	Spree::ShippingMethod	2015-10-23 13:03:53.416137	2015-10-23 13:03:53.416137
4	Spree::Calculator::FlatPercentItemTotal	1	EnterpriseFee	2015-10-23 13:05:56.98717	2015-10-23 13:05:56.98717
\.


--
-- Name: spree_calculators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_calculators_id_seq', 4, true);


--
-- Data for Name: spree_configurations; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_configurations (id, name, type, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_configurations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_configurations_id_seq', 1, false);


--
-- Data for Name: spree_countries; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_countries (id, iso_name, iso, iso3, name, numcode, states_required) FROM stdin;
230	SOUTH AFRICA	ZA	\N	South Africa	\N	t
\.


--
-- Name: spree_countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_countries_id_seq', 230, true);


--
-- Data for Name: spree_credit_cards; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_credit_cards (id, month, year, cc_type, last_digits, first_name, last_name, start_month, start_year, issue_number, address_id, created_at, updated_at, gateway_customer_profile_id, gateway_payment_profile_id) FROM stdin;
\.


--
-- Name: spree_credit_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_credit_cards_id_seq', 1, false);


--
-- Data for Name: spree_gateways; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_gateways (id, type, name, description, active, environment, server, test_mode, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_gateways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_gateways_id_seq', 1, false);


--
-- Data for Name: spree_inventory_units; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_inventory_units (id, lock_version, state, variant_id, order_id, created_at, updated_at, shipment_id, return_authorization_id) FROM stdin;
\.


--
-- Name: spree_inventory_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_inventory_units_id_seq', 1, false);


--
-- Data for Name: spree_line_items; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_line_items (id, order_id, variant_id, quantity, price, created_at, updated_at, max_quantity, currency, distribution_fee, shipping_method_name, final_weight_volume) FROM stdin;
1	23	4	1	14.00	2015-10-23 13:35:14.869585	2015-10-23 13:35:14.869585	\N	ZAR	\N	\N	1.00
\.


--
-- Name: spree_line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_line_items_id_seq', 1, true);


--
-- Data for Name: spree_log_entries; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_log_entries (id, source_id, source_type, details, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_log_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_log_entries_id_seq', 1, false);


--
-- Data for Name: spree_mail_methods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_mail_methods (id, environment, active, created_at, updated_at) FROM stdin;
1	production	t	2015-10-16 03:25:39.420207	2015-10-16 03:25:39.420207
\.


--
-- Name: spree_mail_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_mail_methods_id_seq', 1, true);


--
-- Data for Name: spree_option_types; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_option_types (id, name, presentation, created_at, updated_at, "position") FROM stdin;
1	unit_items	Items	2015-10-16 06:42:21.883714	2015-10-16 06:42:21.883714	0
\.


--
-- Name: spree_option_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_option_types_id_seq', 1, true);


--
-- Data for Name: spree_option_types_prototypes; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_option_types_prototypes (prototype_id, option_type_id) FROM stdin;
\.


--
-- Data for Name: spree_option_values; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_option_values (id, "position", name, presentation, option_type_id, created_at, updated_at) FROM stdin;
1	1	1 head	1 head	1	2015-10-16 06:42:21.933165	2015-10-16 06:42:21.933165
2	2	1 Bunch	1 Bunch	1	2015-10-23 13:11:03.56558	2015-10-23 13:11:03.56558
\.


--
-- Name: spree_option_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_option_values_id_seq', 2, true);


--
-- Data for Name: spree_option_values_variants; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_option_values_variants (variant_id, option_value_id) FROM stdin;
2	1
1	1
4	2
3	2
\.


--
-- Data for Name: spree_orders; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_orders (id, number, item_total, total, state, adjustment_total, user_id, created_at, updated_at, completed_at, bill_address_id, ship_address_id, payment_total, shipping_method_id, shipment_state, payment_state, email, special_instructions, distributor_id, order_cycle_id, currency, last_ip_address, cart_id, customer_id) FROM stdin;
2	R841513336	0.00	0.00	cart	0.00	8	2015-10-16 03:28:46.307591	2015-10-16 03:28:46.307591	\N	\N	\N	0.00	\N	\N	\N	ofn@ofn.ru	\N	\N	\N	ZAR	\N	\N	\N
3	R534141640	0.00	0.00	cart	0.00	9	2015-10-16 04:13:40.233358	2015-10-16 04:13:40.233358	\N	\N	\N	0.00	\N	\N	\N	ofn2@ofn.ru	\N	\N	\N	ZAR	\N	\N	\N
4	R117322215	0.00	0.00	cart	0.00	10	2015-10-16 06:18:03.292791	2015-10-16 06:18:03.292791	\N	\N	\N	0.00	\N	\N	\N	info@janemckenzie.com	\N	\N	\N	ZAR	\N	\N	\N
5	R236032280	0.00	0.00	cart	0.00	11	2015-10-16 06:21:15.086848	2015-10-16 06:21:15.086848	\N	\N	\N	0.00	\N	\N	\N	info@janemackenzie.co.za	\N	\N	\N	ZAR	\N	\N	\N
21	R618280607	0.00	0.00	cart	0.00	13	2015-10-23 12:34:37.230192	2015-10-23 13:23:58.222947	\N	\N	\N	0.00	\N	\N	balance_due	info@dovehouse.co.za	\N	4	1	ZAR	41.193.254.24	\N	\N
6	R083142568	0.00	0.00	cart	0.00	\N	2015-10-16 16:13:37.372783	2015-10-16 16:13:38.239156	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	105.236.229.25	\N	\N
37	R710106634	0.00	0.00	cart	0.00	\N	2015-11-03 20:41:35.193334	2015-11-03 20:41:35.617894	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	\N	ZAR	197.214.116.154	\N	\N
7	R516160262	0.00	0.00	cart	0.00	12	2015-10-18 04:30:33.708567	2015-10-18 04:30:48.588764	\N	\N	\N	0.00	\N	\N	balance_due	mslabber@hexfruit.co.za	\N	3	\N	ZAR	197.214.116.154	\N	\N
8	R755821417	0.00	0.00	cart	0.00	\N	2015-10-18 14:02:14.620202	2015-10-18 14:02:14.836188	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	41.132.243.125	\N	\N
30	R870388418	0.00	0.00	cart	0.00	\N	2015-10-28 08:11:39.411893	2015-10-28 08:11:39.630506	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	203.206.113.218	\N	\N
9	R625320535	0.00	0.00	cart	0.00	\N	2015-10-18 15:27:36.377201	2015-10-18 15:27:36.59342	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	41.135.80.211	\N	\N
10	R423565053	0.00	0.00	cart	0.00	\N	2015-10-18 15:53:41.207681	2015-10-18 15:53:41.606413	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	41.135.80.211	\N	\N
23	R556108531	14.00	14.00	cart	0.00	\N	2015-10-23 13:34:47.330225	2015-10-23 13:34:47.55844	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	1	ZAR	41.193.254.24	\N	\N
11	R181015475	0.00	0.00	cart	0.00	\N	2015-10-18 16:03:44.883118	2015-10-18 16:03:45.107202	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	197.87.109.68	\N	\N
31	R266682188	0.00	0.00	cart	0.00	\N	2015-10-29 14:32:44.61022	2015-10-29 14:32:44.825565	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	\N	ZAR	66.249.64.90	\N	\N
12	R661658523	0.00	0.00	cart	0.00	\N	2015-10-18 16:37:09.775205	2015-10-18 16:37:09.991319	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	105.227.179.33	\N	\N
24	R561064600	0.00	0.00	cart	0.00	\N	2015-10-25 13:28:55.939087	2015-10-25 13:28:56.16586	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	1	ZAR	41.76.222.246	\N	\N
13	R458826351	0.00	0.00	cart	0.00	\N	2015-10-18 19:07:30.174029	2015-10-18 19:07:30.39361	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	197.76.142.251	\N	\N
38	R400205017	0.00	0.00	cart	0.00	15	2015-11-04 08:58:54.792399	2015-11-04 09:00:26.171075	\N	\N	\N	0.00	\N	\N	balance_due	nietazan@axxess.co.za	\N	3	\N	ZAR	165.255.163.51	\N	\N
14	R858452711	0.00	0.00	cart	0.00	\N	2015-10-18 20:21:01.597901	2015-10-18 20:21:02.000429	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	66.249.67.73	\N	\N
25	R215751068	0.00	0.00	cart	0.00	\N	2015-10-25 23:45:05.702721	2015-10-25 23:45:05.920242	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	66.249.64.90	\N	\N
15	R213744646	0.00	0.00	cart	0.00	\N	2015-10-19 09:54:35.296783	2015-10-19 09:54:36.313542	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	105.237.48.83	\N	\N
32	R448320765	0.00	0.00	cart	0.00	14	2015-10-30 06:05:38.256269	2015-10-30 06:05:38.256269	\N	\N	\N	0.00	\N	\N	balance_due	qholloi@gmail.com	\N	\N	\N	ZAR	\N	\N	\N
16	R751412023	0.00	0.00	cart	0.00	\N	2015-10-19 14:32:16.629293	2015-10-19 14:32:16.843159	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	197.77.203.109	\N	\N
17	R231131884	0.00	0.00	cart	0.00	\N	2015-10-19 16:38:35.294907	2015-10-19 16:38:35.516737	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	66.249.64.80	\N	\N
33	R487562438	0.00	0.00	cart	0.00	\N	2015-11-01 14:54:40.049739	2015-11-01 14:54:40.270739	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	\N	ZAR	105.229.93.156	\N	\N
18	R338816135	0.00	0.00	cart	0.00	\N	2015-10-19 21:26:45.604832	2015-10-19 21:26:45.983005	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	91.182.125.24	\N	\N
26	R534006553	0.00	0.00	cart	0.00	\N	2015-10-26 10:51:01.753678	2015-10-26 10:54:29.288095	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	1	ZAR	77.234.45.150	\N	\N
19	R170404838	0.00	0.00	cart	0.00	\N	2015-10-20 07:44:54.537761	2015-10-20 07:44:54.755552	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	41.168.22.148	\N	\N
39	R510648024	0.00	0.00	cart	0.00	\N	2015-11-04 15:15:39.365968	2015-11-04 15:15:39.576266	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	80.12.91.176	\N	\N
22	R282381510	0.00	0.00	cart	0.00	7	2015-10-23 13:33:23.029754	2015-11-02 09:12:26.809904	\N	\N	\N	0.00	\N	\N	balance_due	lawrence@kandu.co.za	\N	4	\N	ZAR	41.216.139.90	\N	\N
20	R140803608	0.00	0.00	cart	0.00	\N	2015-10-23 09:27:08.530121	2015-10-23 09:27:09.547457	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	105.227.212.174	\N	\N
27	R818156581	0.00	0.00	cart	0.00	\N	2015-10-26 11:21:30.822293	2015-10-26 11:21:40.959533	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	1	ZAR	105.224.164.119	\N	\N
34	R035207822	0.00	0.00	cart	0.00	\N	2015-11-02 10:44:12.172734	2015-11-02 10:44:12.597379	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	5	\N	ZAR	105.229.164.172	\N	\N
28	R512082651	0.00	0.00	cart	0.00	\N	2015-10-26 18:58:44.425944	2015-10-26 18:58:44.657307	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	1	ZAR	66.249.75.236	\N	\N
40	R704578622	0.00	0.00	cart	0.00	\N	2015-11-04 18:55:15.968717	2015-11-04 18:55:17.139878	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	169.0.176.132	\N	\N
29	R057713363	0.00	0.00	cart	0.00	\N	2015-10-28 06:43:27.965586	2015-10-28 06:43:28.185391	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	\N	ZAR	66.249.64.85	\N	\N
35	R814652568	0.00	0.00	cart	0.00	\N	2015-11-03 04:03:27.422148	2015-11-03 04:03:27.842055	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	3	\N	ZAR	66.249.67.85	\N	\N
36	R201523321	0.00	0.00	cart	0.00	\N	2015-11-03 04:13:55.024035	2015-11-03 04:13:55.242179	\N	\N	\N	0.00	\N	\N	balance_due	\N	\N	4	\N	ZAR	66.249.67.73	\N	\N
\.


--
-- Name: spree_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_orders_id_seq', 40, true);


--
-- Data for Name: spree_payment_methods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_payment_methods (id, type, name, description, active, environment, created_at, updated_at, deleted_at, display_on) FROM stdin;
1	Spree::PaymentMethod::Check	EFT	Electronic Funds Transfer to:\r\n\r\nDove House Organics\r\nFirst National Bank\r\nAcc number 62231899769\r\nBranch Code: 220725\r\n\r\nEmail POP to inof@dovehouse.co.za\r\nsms POP to 0842924354	t	production	2015-10-23 13:19:44.625481	2015-10-23 13:19:44.625481	\N	\N
2	Spree::PaymentMethod::Check	Cash or card  on collection	Please bring correct change 	t	production	2015-10-23 13:20:52.974798	2015-10-23 13:21:22.464297	\N	\N
\.


--
-- Name: spree_payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_payment_methods_id_seq', 2, true);


--
-- Data for Name: spree_payments; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_payments (id, amount, order_id, created_at, updated_at, source_id, source_type, payment_method_id, state, response_code, avs_response, identifier, cvv_response_code, cvv_response_message) FROM stdin;
\.


--
-- Name: spree_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_payments_id_seq', 1, false);


--
-- Data for Name: spree_paypal_accounts; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_paypal_accounts (id, email, payer_id, payer_country, payer_status) FROM stdin;
\.


--
-- Name: spree_paypal_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_paypal_accounts_id_seq', 1, false);


--
-- Data for Name: spree_paypal_express_checkouts; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_paypal_express_checkouts (id, token, payer_id, transaction_id, state, refund_transaction_id, refunded_at, refund_type, created_at) FROM stdin;
\.


--
-- Name: spree_paypal_express_checkouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_paypal_express_checkouts_id_seq', 1, false);


--
-- Data for Name: spree_pending_promotions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_pending_promotions (id, user_id, promotion_id) FROM stdin;
\.


--
-- Name: spree_pending_promotions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_pending_promotions_id_seq', 1, false);


--
-- Data for Name: spree_preferences; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_preferences (id, value, created_at, updated_at, key, value_type) FROM stdin;
22	ofn.kandu.co.za	2015-10-16 04:00:21.092344	2015-10-19 06:40:00.78711	spree/app_configuration/site_url	string
23	t	2015-10-16 04:00:21.108966	2015-10-19 06:40:00.803665	spree/app_configuration/allow_ssl_in_production	boolean
24	t	2015-10-16 04:00:21.125571	2015-10-19 06:40:00.820306	spree/app_configuration/allow_ssl_in_staging	boolean
25	f	2015-10-16 04:00:21.142344	2015-10-19 06:40:00.837005	spree/app_configuration/allow_ssl_in_development_and_test	boolean
26	t	2015-10-16 04:00:21.158935	2015-10-19 06:40:00.853636	spree/app_configuration/check_for_spree_alerts	boolean
27	f	2015-10-16 04:00:21.175565	2015-10-19 06:40:00.870296	spree/app_configuration/display_currency	boolean
28	f	2015-10-16 04:00:21.192264	2015-10-19 06:40:00.886921	spree/app_configuration/hide_cents	boolean
7	t	2015-10-16 03:25:39.429564	2015-10-16 03:35:37.967685	spree/mail_method/enable_mail_delivery/1	boolean
8	ofn@kandu.co.za	2015-10-16 03:25:39.438372	2015-10-16 03:35:37.974028	spree/mail_method/mails_from/1	string
9	lawrence@kandu.co.za,kosenkodmitryv@gmail.com	2015-10-16 03:25:39.444437	2015-10-16 03:35:37.979694	spree/mail_method/mail_bcc/1	string
10		2015-10-16 03:25:39.450388	2015-10-16 03:35:37.985308	spree/mail_method/intercept_email/1	string
11	mail01-dtp.thecloud.co.za	2015-10-16 03:25:39.45626	2015-10-16 03:35:37.990882	spree/mail_method/mail_domain/1	string
12	mail01-dtp.thecloud.co.za	2015-10-16 03:25:39.462226	2015-10-16 03:35:37.996453	spree/mail_method/mail_host/1	string
13	587	2015-10-16 03:25:39.468109	2015-10-16 03:35:38.00208	spree/mail_method/mail_port/1	integer
14	None	2015-10-16 03:25:39.474211	2015-10-16 03:35:38.007864	spree/mail_method/secure_connection_type/1	string
15	plain	2015-10-16 03:25:39.480005	2015-10-16 03:35:38.013431	spree/mail_method/mail_auth_type/1	string
16	ofn@kandu.co.za	2015-10-16 03:25:39.485848	2015-10-16 03:35:38.019028	spree/mail_method/smtp_username/1	string
17	F00dnetwork	2015-10-16 03:25:39.491652	2015-10-16 03:35:38.024706	spree/mail_method/smtp_password/1	string
44		2015-11-02 09:13:00.111034	2015-11-02 09:13:00.111034	enterprise/shopfront_closed_message/2	text
29	before	2015-10-16 04:00:21.225667	2015-10-19 06:40:00.920248	spree/app_configuration/currency_symbol_position	string
30	.	2015-10-16 04:00:21.242241	2015-10-19 06:40:00.937032	spree/app_configuration/currency_decimal_mark	string
31	,	2015-10-16 04:00:21.258918	2015-10-19 06:40:00.953567	spree/app_configuration/currency_thousands_separator	string
45		2015-11-02 09:13:00.1168	2015-11-02 09:13:00.1168	enterprise/shopfront_taxon_order/2	string
32	0.0	2015-10-23 13:02:03.922382	2015-10-23 13:02:03.922382	spree/calculator/flat_rate/amount/2	decimal
33	ZAR	2015-10-23 13:02:03.944591	2015-10-23 13:02:03.944591	spree/calculator/flat_rate/currency/2	string
34	0.0	2015-10-23 13:03:58.998319	2015-10-23 13:03:58.998319	spree/calculator/flat_rate/amount/3	decimal
35	ZAR	2015-10-23 13:03:59.004912	2015-10-23 13:03:59.004912	spree/calculator/flat_rate/currency/3	string
36	5.0	2015-10-23 13:06:15.585734	2015-10-23 13:06:15.585734	spree/calculator/flat_percent_item_total/flat_percent/4	decimal
1	t	2015-10-16 01:43:36.983113	2015-11-05 10:31:33.318455	spree/app_configuration/shipping_instructions	boolean
2	t	2015-10-16 01:43:37.118969	2015-11-05 10:31:33.467854	spree/app_configuration/address_requires_state	boolean
3	South Africa	2015-10-16 01:43:37.13369	2015-11-05 10:31:33.507613	spree/app_configuration/checkout_zone	string
18	OFN  South Africa	2015-10-16 04:00:21.019082	2015-10-19 06:40:00.714994	spree/app_configuration/site_name	string
19	OFN  South Africa	2015-10-16 04:00:21.043405	2015-10-19 06:40:00.737192	spree/app_configuration/default_seo_title	string
20	ofn, south africa, local food, slow food, organic produce, buy direct, farmers direct	2015-10-16 04:00:21.058901	2015-10-19 06:40:00.753617	spree/app_configuration/default_meta_keywords	string
21	open food network south africa	2015-10-16 04:00:21.07563	2015-10-19 06:40:00.77041	spree/app_configuration/default_meta_description	string
4	ZAR	2015-10-16 01:43:37.15023	2015-11-05 10:31:33.540849	spree/app_configuration/currency	string
5	230	2015-10-16 01:43:37.207754	2015-11-05 10:31:33.709255	spree/app_configuration/default_country_id	integer
6	t	2015-10-16 01:43:37.217013	2015-11-05 10:31:33.733036	spree/app_configuration/auto_capture	boolean
40		2015-10-23 13:28:32.206897	2015-10-23 13:28:32.206897	enterprise/shopfront_message/3	text
41		2015-10-23 13:28:32.213281	2015-10-23 13:28:32.213281	enterprise/shopfront_closed_message/3	text
42		2015-10-23 13:28:32.219066	2015-10-23 13:28:32.219066	enterprise/shopfront_taxon_order/3	string
43		2015-11-02 09:13:00.104539	2015-11-02 09:13:00.104539	enterprise/shopfront_message/2	text
\.


--
-- Name: spree_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_preferences_id_seq', 45, true);


--
-- Data for Name: spree_prices; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_prices (id, variant_id, amount, currency) FROM stdin;
1	1	10.00	ZAR
2	2	10.00	ZAR
3	3	14.00	ZAR
4	4	14.00	ZAR
\.


--
-- Name: spree_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_prices_id_seq', 4, true);


--
-- Data for Name: spree_product_groups; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_product_groups (id, name, permalink, "order") FROM stdin;
\.


--
-- Name: spree_product_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_product_groups_id_seq', 1, false);


--
-- Data for Name: spree_product_groups_products; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_product_groups_products (product_id, product_group_id) FROM stdin;
\.


--
-- Data for Name: spree_product_option_types; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_product_option_types (id, "position", product_id, option_type_id, created_at, updated_at) FROM stdin;
1	1	1	1	2015-10-16 06:42:22.118439	2015-10-16 06:42:22.118439
2	1	2	1	2015-10-23 13:11:03.715892	2015-10-23 13:11:03.715892
\.


--
-- Name: spree_product_option_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_product_option_types_id_seq', 2, true);


--
-- Data for Name: spree_product_properties; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_product_properties (id, value, product_id, property_id, created_at, updated_at, "position") FROM stdin;
\.


--
-- Name: spree_product_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_product_properties_id_seq', 1, false);


--
-- Data for Name: spree_product_scopes; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_product_scopes (id, name, arguments, product_group_id) FROM stdin;
\.


--
-- Name: spree_product_scopes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_product_scopes_id_seq', 1, false);


--
-- Data for Name: spree_products; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_products (id, name, description, available_on, deleted_at, permalink, meta_description, meta_keywords, tax_category_id, shipping_category_id, created_at, updated_at, count_on_hand, supplier_id, group_buy, group_buy_unit_size, on_demand, variant_unit, variant_unit_scale, variant_unit_name, notes, primary_taxon_id, inherits_properties) FROM stdin;
1	Brocolli	Naturally grown Brocolli	2015-10-16 06:42:18.493933	\N	brocolli	\N	\N	1	\N	2015-10-16 06:42:21.184856	2015-10-16 06:42:22.031623	5	3	\N	\N	f	items	\N	head	\N	1	t
2	Carrots	Organically Grown Carrots 	2015-10-23 13:11:03.073947	\N	carrots	\N	\N	1	1	2015-10-23 13:11:03.188741	2015-10-23 13:11:03.643843	0	4	\N	\N	t	items	\N	Bunch	\N	1	t
\.


--
-- Name: spree_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_products_id_seq', 2, true);


--
-- Data for Name: spree_products_promotion_rules; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_products_promotion_rules (product_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: spree_products_taxons; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_products_taxons (id, product_id, taxon_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Name: spree_products_taxons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_products_taxons_id_seq', 2, true);


--
-- Data for Name: spree_promotion_action_line_items; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_promotion_action_line_items (id, promotion_action_id, variant_id, quantity) FROM stdin;
\.


--
-- Name: spree_promotion_action_line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_promotion_action_line_items_id_seq', 1, false);


--
-- Data for Name: spree_promotion_actions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_promotion_actions (id, activator_id, "position", type) FROM stdin;
\.


--
-- Name: spree_promotion_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_promotion_actions_id_seq', 1, false);


--
-- Data for Name: spree_promotion_rules; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_promotion_rules (id, activator_id, user_id, product_group_id, type, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_promotion_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_promotion_rules_id_seq', 1, false);


--
-- Data for Name: spree_promotion_rules_users; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_promotion_rules_users (user_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: spree_properties; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_properties (id, name, presentation, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_properties_id_seq', 1, false);


--
-- Data for Name: spree_properties_prototypes; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_properties_prototypes (prototype_id, property_id) FROM stdin;
\.


--
-- Data for Name: spree_prototypes; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_prototypes (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_prototypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_prototypes_id_seq', 1, false);


--
-- Data for Name: spree_return_authorizations; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_return_authorizations (id, number, state, amount, order_id, reason, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_return_authorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_return_authorizations_id_seq', 1, false);


--
-- Data for Name: spree_roles; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_roles (id, name) FROM stdin;
1	admin
2	user
\.


--
-- Name: spree_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_roles_id_seq', 2, true);


--
-- Data for Name: spree_roles_users; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_roles_users (role_id, user_id) FROM stdin;
1	5
1	7
\.


--
-- Data for Name: spree_shipments; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_shipments (id, tracking, number, cost, shipped_at, order_id, shipping_method_id, address_id, created_at, updated_at, state) FROM stdin;
\.


--
-- Name: spree_shipments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_shipments_id_seq', 1, false);


--
-- Data for Name: spree_shipping_categories; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_shipping_categories (id, name, created_at, updated_at, temperature_controlled) FROM stdin;
1	Standard	2015-10-19 06:42:47.585041	2015-10-19 06:42:47.585041	f
2	Coolerbox	2015-10-19 06:43:34.097422	2015-10-19 06:43:34.097422	t
3	Refrigerated 	2015-10-19 06:43:53.319519	2015-10-19 06:43:53.319519	t
\.


--
-- Name: spree_shipping_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_shipping_categories_id_seq', 3, true);


--
-- Data for Name: spree_shipping_methods; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_shipping_methods (id, name, zone_id, created_at, updated_at, display_on, shipping_category_id, match_none, match_all, match_one, deleted_at, require_ship_address, description) FROM stdin;
1	Pick from the shop	4	2015-10-23 13:01:53.69241	2015-10-23 13:01:53.69241	\N	\N	\N	\N	\N	\N	f	Please collect from Dove House Organics at 78 Main street, Howick
2	Wholesale pickup from the farm	4	2015-10-23 13:03:53.412079	2015-10-23 13:03:53.412079	\N	\N	\N	\N	\N	\N	f	Please collect from Dove House Farm, Karkloof road
\.


--
-- Name: spree_shipping_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_shipping_methods_id_seq', 2, true);


--
-- Data for Name: spree_skrill_transactions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_skrill_transactions (id, email, amount, currency, transaction_id, customer_id, payment_type, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_skrill_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_skrill_transactions_id_seq', 1, false);


--
-- Data for Name: spree_state_changes; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_state_changes (id, name, previous_state, stateful_id, user_id, created_at, updated_at, stateful_type, next_state) FROM stdin;
1	payment	\N	6	\N	2015-10-16 16:13:38.051495	2015-10-16 16:13:38.051495	Spree::Order	balance_due
2	payment	\N	7	12	2015-10-18 04:30:33.779785	2015-10-18 04:30:33.779785	Spree::Order	balance_due
3	payment	\N	8	\N	2015-10-18 14:02:14.690481	2015-10-18 14:02:14.690481	Spree::Order	balance_due
4	payment	\N	9	\N	2015-10-18 15:27:36.447395	2015-10-18 15:27:36.447395	Spree::Order	balance_due
5	payment	\N	10	\N	2015-10-18 15:53:41.458168	2015-10-18 15:53:41.458168	Spree::Order	balance_due
6	payment	\N	11	\N	2015-10-18 16:03:44.954573	2015-10-18 16:03:44.954573	Spree::Order	balance_due
7	payment	\N	12	\N	2015-10-18 16:37:09.84525	2015-10-18 16:37:09.84525	Spree::Order	balance_due
8	payment	\N	13	\N	2015-10-18 19:07:30.244815	2015-10-18 19:07:30.244815	Spree::Order	balance_due
9	payment	\N	14	\N	2015-10-18 20:21:01.848015	2015-10-18 20:21:01.848015	Spree::Order	balance_due
10	payment	\N	15	\N	2015-10-19 09:54:36.117095	2015-10-19 09:54:36.117095	Spree::Order	balance_due
11	payment	\N	16	\N	2015-10-19 14:32:16.701708	2015-10-19 14:32:16.701708	Spree::Order	balance_due
12	payment	\N	17	\N	2015-10-19 16:38:35.365497	2015-10-19 16:38:35.365497	Spree::Order	balance_due
13	payment	\N	18	\N	2015-10-19 21:26:45.675109	2015-10-19 21:26:45.675109	Spree::Order	balance_due
14	payment	\N	19	\N	2015-10-20 07:44:54.609215	2015-10-20 07:44:54.609215	Spree::Order	balance_due
15	payment	\N	20	\N	2015-10-23 09:27:09.352098	2015-10-23 09:27:09.352098	Spree::Order	balance_due
16	payment	\N	21	13	2015-10-23 12:34:38.225755	2015-10-23 12:34:38.225755	Spree::Order	balance_due
17	payment	\N	22	7	2015-10-23 13:33:23.440052	2015-10-23 13:33:23.440052	Spree::Order	balance_due
18	payment	\N	23	\N	2015-10-23 13:34:47.401511	2015-10-23 13:34:47.401511	Spree::Order	balance_due
19	payment	\N	24	\N	2015-10-25 13:28:56.010735	2015-10-25 13:28:56.010735	Spree::Order	balance_due
20	payment	\N	25	\N	2015-10-25 23:45:05.775437	2015-10-25 23:45:05.775437	Spree::Order	balance_due
21	payment	\N	26	\N	2015-10-26 10:51:01.824873	2015-10-26 10:51:01.824873	Spree::Order	balance_due
22	payment	\N	27	\N	2015-10-26 11:21:30.895176	2015-10-26 11:21:30.895176	Spree::Order	balance_due
23	payment	\N	28	\N	2015-10-26 18:58:44.497617	2015-10-26 18:58:44.497617	Spree::Order	balance_due
24	payment	\N	29	\N	2015-10-28 06:43:28.036496	2015-10-28 06:43:28.036496	Spree::Order	balance_due
25	payment	\N	30	\N	2015-10-28 08:11:39.483785	2015-10-28 08:11:39.483785	Spree::Order	balance_due
26	payment	\N	31	\N	2015-10-29 14:32:44.680892	2015-10-29 14:32:44.680892	Spree::Order	balance_due
27	payment	\N	32	14	2015-10-30 06:05:38.328031	2015-10-30 06:05:38.328031	Spree::Order	balance_due
28	payment	\N	33	\N	2015-11-01 14:54:40.120734	2015-11-01 14:54:40.120734	Spree::Order	balance_due
29	payment	\N	34	\N	2015-11-02 10:44:12.243419	2015-11-02 10:44:12.243419	Spree::Order	balance_due
30	payment	\N	35	\N	2015-11-03 04:03:27.492793	2015-11-03 04:03:27.492793	Spree::Order	balance_due
31	payment	\N	36	\N	2015-11-03 04:13:55.09571	2015-11-03 04:13:55.09571	Spree::Order	balance_due
32	payment	\N	37	\N	2015-11-03 20:41:35.264026	2015-11-03 20:41:35.264026	Spree::Order	balance_due
33	payment	\N	38	\N	2015-11-04 08:58:55.614463	2015-11-04 08:58:55.614463	Spree::Order	balance_due
34	payment	\N	39	\N	2015-11-04 15:15:39.436369	2015-11-04 15:15:39.436369	Spree::Order	balance_due
35	payment	\N	40	\N	2015-11-04 18:55:16.941921	2015-11-04 18:55:16.941921	Spree::Order	balance_due
\.


--
-- Name: spree_state_changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_state_changes_id_seq', 35, true);


--
-- Data for Name: spree_states; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_states (id, name, abbr, country_id) FROM stdin;
75	Free State	ZA-FS	230
76	Western Cape	ZA-WC	230
77	Northern Cape	ZA-NC	230
78	Eastern Cape	ZA-EC	230
79	Limpopo	ZA-LP	230
80	North West	ZA-NW	230
74	KwaZulu-Natal	ZA-KZN	230
81	Mpumalanga	ZA-MP	230
73	Gauteng	ZA-GP	230
\.


--
-- Name: spree_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_states_id_seq', 81, true);


--
-- Data for Name: spree_tax_categories; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_tax_categories (id, name, description, created_at, updated_at, is_default, deleted_at) FROM stdin;
1	None		2015-10-16 06:38:51.840529	2015-10-16 06:38:51.840529	t	\N
2	VAT	SA Value Added Tax	2015-10-16 06:39:09.564909	2015-10-16 06:39:09.564909	f	\N
\.


--
-- Name: spree_tax_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_tax_categories_id_seq', 2, true);


--
-- Data for Name: spree_tax_rates; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_tax_rates (id, amount, zone_id, tax_category_id, created_at, updated_at, included_in_price, name, show_rate_in_label) FROM stdin;
1	0.01400	4	2	2015-10-16 06:40:53.137002	2015-10-16 06:40:53.137002	t	VAT	t
\.


--
-- Name: spree_tax_rates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_tax_rates_id_seq', 1, true);


--
-- Data for Name: spree_taxonomies; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_taxonomies (id, name, created_at, updated_at, "position") FROM stdin;
1	Fruit & Veg	2015-10-16 06:35:37.85928	2015-10-16 06:35:37.85928	0
2	Dairy	2015-10-16 06:36:42.423293	2015-10-16 06:36:42.423293	0
3	Eggs 	2015-10-16 06:37:22.86879	2015-10-16 06:37:22.86879	0
4	Compost & Fertilisers	2015-10-16 06:37:45.330738	2015-10-16 06:37:45.330738	0
5	Meats	2015-10-16 06:37:59.493256	2015-10-16 06:37:59.493256	0
6	Health & Wellbeing	2015-10-16 06:38:19.174699	2015-10-16 06:38:19.174699	0
7	Seed, seedlings & saplings 	2015-10-18 13:49:30.585707	2015-10-18 13:49:30.585707	0
\.


--
-- Name: spree_taxonomies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_taxonomies_id_seq', 7, true);


--
-- Data for Name: spree_taxons; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_taxons (id, parent_id, "position", name, permalink, taxonomy_id, created_at, updated_at, lft, rgt, icon_file_name, icon_content_type, icon_file_size, icon_updated_at, description, meta_title, meta_description, meta_keywords) FROM stdin;
1	\N	0	Fruit & Veg	fruit-and-veg	1	2015-10-16 06:35:37.972285	2015-10-16 06:35:37.972285	1	2	\N	\N	\N	\N	\N	\N	\N	\N
2	\N	0	Dairy	dairy	2	2015-10-16 06:36:42.435574	2015-10-16 06:36:42.435574	3	4	\N	\N	\N	\N	\N	\N	\N	\N
3	\N	0	Eggs 	eggs	3	2015-10-16 06:37:22.881277	2015-10-16 06:37:22.881277	5	6	\N	\N	\N	\N	\N	\N	\N	\N
4	\N	0	Compost & Fertilisers	compost-and-fertilisers	4	2015-10-16 06:37:45.34438	2015-10-16 06:37:45.34438	7	8	\N	\N	\N	\N	\N	\N	\N	\N
5	\N	0	Meats	meats	5	2015-10-16 06:37:59.505703	2015-10-16 06:37:59.505703	9	10	\N	\N	\N	\N	\N	\N	\N	\N
6	\N	0	Health & Wellbeing	health-and-wellbeing	6	2015-10-16 06:38:19.187022	2015-10-16 06:38:19.187022	11	12	\N	\N	\N	\N	\N	\N	\N	\N
7	\N	0	Seed, seedlings & saplings 	seed-seedlings-and-saplings	7	2015-10-18 13:49:30.612972	2015-10-18 13:49:30.612972	13	14	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: spree_taxons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_taxons_id_seq', 7, true);


--
-- Data for Name: spree_tokenized_permissions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_tokenized_permissions (id, permissable_id, permissable_type, token, created_at, updated_at) FROM stdin;
1	1	Spree::Order	bf0da054d03bd715	2015-10-16 02:07:39.113457	2015-10-16 02:07:39.113457
2	2	Spree::Order	a6a490d3b2a5b593	2015-10-16 03:28:46.316947	2015-10-16 03:28:46.316947
3	3	Spree::Order	a84d89e9eec4da2b	2015-10-16 04:13:40.283573	2015-10-16 04:13:40.283573
4	4	Spree::Order	f837498132733b83	2015-10-16 06:18:03.485068	2015-10-16 06:18:03.485068
5	5	Spree::Order	13e667770a0c71ed	2015-10-16 06:21:15.09559	2015-10-16 06:21:15.09559
6	6	Spree::Order	831cce1e3af9585e	2015-10-16 16:13:37.586425	2015-10-16 16:13:37.586425
7	7	Spree::Order	6f7fd13c4c826531	2015-10-18 04:30:33.717457	2015-10-18 04:30:33.717457
8	8	Spree::Order	b2ff628cb366e24a	2015-10-18 14:02:14.628699	2015-10-18 14:02:14.628699
9	9	Spree::Order	47f2007ca3042182	2015-10-18 15:27:36.385632	2015-10-18 15:27:36.385632
10	10	Spree::Order	5a7cd682c621f7aa	2015-10-18 15:53:41.216096	2015-10-18 15:53:41.216096
11	11	Spree::Order	a967324385b2e75f	2015-10-18 16:03:44.891707	2015-10-18 16:03:44.891707
12	12	Spree::Order	8a39001f92aae543	2015-10-18 16:37:09.783568	2015-10-18 16:37:09.783568
13	13	Spree::Order	bfa198d59abbecda	2015-10-18 19:07:30.182405	2015-10-18 19:07:30.182405
14	14	Spree::Order	6a1230a30693c707	2015-10-18 20:21:01.606235	2015-10-18 20:21:01.606235
15	15	Spree::Order	47791849bf57cb74	2015-10-19 09:54:35.50179	2015-10-19 09:54:35.50179
16	16	Spree::Order	7b8906afd4208452	2015-10-19 14:32:16.637991	2015-10-19 14:32:16.637991
17	17	Spree::Order	1a184f54cae22c87	2015-10-19 16:38:35.303318	2015-10-19 16:38:35.303318
18	18	Spree::Order	78cc97ea8a6c3ae9	2015-10-19 21:26:45.613334	2015-10-19 21:26:45.613334
19	19	Spree::Order	471709aa0c2200d0	2015-10-20 07:44:54.546267	2015-10-20 07:44:54.546267
20	20	Spree::Order	4e7cb55d2757b078	2015-10-23 09:27:08.737624	2015-10-23 09:27:08.737624
21	21	Spree::Order	61d4ebb864a28959	2015-10-23 12:34:37.281313	2015-10-23 12:34:37.281313
22	22	Spree::Order	0c748b79e395a9a4	2015-10-23 13:33:23.066125	2015-10-23 13:33:23.066125
23	23	Spree::Order	7a0617878f6fe505	2015-10-23 13:34:47.338631	2015-10-23 13:34:47.338631
24	24	Spree::Order	7633618b222aedcd	2015-10-25 13:28:55.947582	2015-10-25 13:28:55.947582
25	25	Spree::Order	f2264d4c4377bd73	2015-10-25 23:45:05.711346	2015-10-25 23:45:05.711346
26	26	Spree::Order	58012d52f68810da	2015-10-26 10:51:01.762126	2015-10-26 10:51:01.762126
27	27	Spree::Order	27306edd00639153	2015-10-26 11:21:30.831149	2015-10-26 11:21:30.831149
28	28	Spree::Order	e9eee2f63f22c6cb	2015-10-26 18:58:44.434337	2015-10-26 18:58:44.434337
29	29	Spree::Order	9160ee290ef3ad3b	2015-10-28 06:43:27.974138	2015-10-28 06:43:27.974138
30	30	Spree::Order	4eb24d5251eb62be	2015-10-28 08:11:39.420343	2015-10-28 08:11:39.420343
31	31	Spree::Order	0610b183ffef19d1	2015-10-29 14:32:44.618529	2015-10-29 14:32:44.618529
32	32	Spree::Order	29b49eef6836d85d	2015-10-30 06:05:38.264931	2015-10-30 06:05:38.264931
33	33	Spree::Order	9ca668865289bda4	2015-11-01 14:54:40.058027	2015-11-01 14:54:40.058027
34	34	Spree::Order	2ce11d86c3bd9c51	2015-11-02 10:44:12.181054	2015-11-02 10:44:12.181054
35	35	Spree::Order	c1be1d9da0d9c7b9	2015-11-03 04:03:27.430434	2015-11-03 04:03:27.430434
36	36	Spree::Order	33a78c034d703304	2015-11-03 04:13:55.032473	2015-11-03 04:13:55.032473
37	37	Spree::Order	5d0adc9a17db6c6c	2015-11-03 20:41:35.201641	2015-11-03 20:41:35.201641
38	38	Spree::Order	e8bcc02517d85b4e	2015-11-04 08:58:54.9989	2015-11-04 08:58:54.9989
39	39	Spree::Order	64b69a725484eeca	2015-11-04 15:15:39.374324	2015-11-04 15:15:39.374324
40	40	Spree::Order	0317fc74432508a5	2015-11-04 18:55:16.173036	2015-11-04 18:55:16.173036
\.


--
-- Name: spree_tokenized_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_tokenized_permissions_id_seq', 40, true);


--
-- Data for Name: spree_trackers; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_trackers (id, environment, analytics_id, active, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_trackers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_trackers_id_seq', 1, false);


--
-- Data for Name: spree_users; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_users (id, encrypted_password, password_salt, email, remember_token, persistence_token, reset_password_token, perishable_token, sign_in_count, failed_attempts, last_request_at, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, login, ship_address_id, bill_address_id, created_at, updated_at, authentication_token, unlock_token, locked_at, remember_created_at, spree_api_key, reset_password_sent_at, api_key, enterprise_limit) FROM stdin;
12	e99f4d23bde79182fdcebcc95106e40a4f2f03333b9f9a5e2083b4e32fcfa93f2157a702dc87f5e75f6724cc0f63a8d550a5165d6bfc476628dad575c2e7e8e5	HYxEuMJzVNpsvynKSDgK	mslabber@hexfruit.co.za	WynAm--2HNawmlo2sbXW	\N	\N	\N	2	0	\N	2015-10-18 15:36:09.86386	2015-10-18 04:30:33.660923	41.13.242.77	197.214.116.154	mslabber@hexfruit.co.za	\N	\N	2015-10-18 04:30:33.614297	2015-10-18 15:36:34.57008	\N	\N	\N	2015-10-18 04:30:33.64746	09d947e71614f36672260b31ec69189c93524705239cfb5d	\N	\N	1
5	44d852a157392ecd9306991dc94dd4de21d055a24e2be57327a0fcc1d330542b1fe56652c96f16f296085e5bc0ecd8b5ec28270a6f0b30460a663d825e53054b	e8pmxbUYYyyjMN2ekmRu	dmitry@shopomob.ru	\N	\N	\N	\N	1	0	\N	2015-10-16 03:03:09.766957	2015-10-16 03:03:09.766957	178.35.24.40	178.35.24.40	dmitry@shopomob.ru	\N	\N	2015-10-16 03:02:51.422034	2015-10-16 03:03:11.432766	\N	\N	\N	\N	01e9157f3fefeb912fd8fb692cadafd68d6f43cb296c6d65	\N	\N	1
6	05faeb57d02ace62106acbae00f9edf86df602c1917f00df681a539df3da7528a03999477bfb1acf34ee8260dc48b7a2a1c6b0fd6552049d5e68d68591514836	YocCP2P3XFEXfz5vdWjN	adolphus@mayert.com	\N	\N	\N	\N	0	0	\N	\N	\N	\N	\N	adolphus@mayert.com	\N	\N	2015-10-16 03:08:59.241815	2015-10-16 03:08:59.241815	xxxx14449649396291xxxxxxxxxxxxx	\N	\N	\N	\N	\N	\N	1
14	9c1ae9c563c6c665ca794c1e07b1432461843086ff33dbb83127c82ccb3b751466e5ec779f50d1a3b331446aa8f5b5965b59a83775abc68e25c98c6a4bdefd63	kfWhmxVuerW3nmprSywD	qholloi@gmail.com	\N	\N	\N	\N	2	0	\N	2015-11-02 09:10:53.974398	2015-10-30 06:05:38.21227	41.216.139.90	41.216.139.90	qholloi@gmail.com	\N	\N	2015-10-30 06:05:38.129367	2015-11-02 09:12:08.213258	\N	\N	\N	\N	3f24f0e36bb141137821ef70031c126375c000c26c484574	\N	\N	1
8	a25376c5b7422eed10e25f2f60c21da798b0bb7522a8d18afbe42388c87c758062ead5cd4dad410b8dc8b8c1b7f2c05f5e294a4102a502fbf401df3ef30c297f	QUxQ1oRHGV5b2jUdHTLP	ofn@ofn.ru	\N	\N	\N	\N	1	0	\N	2015-10-16 03:28:46.259633	2015-10-16 03:28:46.259633	178.35.24.40	178.35.24.40	ofn@ofn.ru	\N	\N	2015-10-16 03:28:46.214359	2015-10-16 04:13:16.011022	\N	\N	\N	\N	a04fd73929f725ae5f9b1b628877644a7748506fe649c977	\N	\N	1
7	c52078a2ddf2f6159fe984da3dde908421372d90307b56c74c420cad9ac3d7d8cf7dabc9ca59730057d8150eb6b2d60e546f3f56a0b1b3d8b0cdeb8a4341ac21	ykpDDj1XhHtzpezAwm9W	lawrence@kandu.co.za	gd2bffKlO2pGFxAgfhlb	\N	\N	\N	8	0	\N	2015-11-02 09:12:26.043312	2015-10-23 13:27:14.775321	41.216.139.90	41.193.254.24	spree@example.com	\N	\N	2015-10-16 03:16:05.056406	2015-11-02 09:12:26.04515	\N	\N	\N	2015-11-02 09:12:26.017361	59d1722fce94bcfb0d5da11c0c2e876ac33f6ad12d21b16d	\N	\N	5
11	a1203746283dc8a3727cfa5fb9268e9a1418eb68f228def4fa75a1a31f337fd0c3e3fa489faa969806007e29e5c66fccf52f0e5b5570cee1ac55503112b50de4	vegSEayJH9QizmQ2pXPW	info@janemackenzie.co.za	\N	\N	\N	\N	2	0	\N	2015-10-16 13:04:10.298964	2015-10-16 06:21:15.014736	105.227.193.121	41.216.139.90	info@janemackenzie.co.za	\N	\N	2015-10-16 06:21:14.924021	2015-10-16 13:04:10.300876	\N	\N	\N	\N	95923fc68fbdd6118cd1e03cc8a72ddee475c37bc8693635	\N	\N	1
9	09633c16aa42f00d3be95c88f6a6d468daa72a4a85512e1f37f15b127ca7a3bba7f23b9abf04c7d8b7cc0b38f9026355d5d400378fe030e79eb47c252966f451	JQz8mG54yGtyUYpbYtZV	ofn2@ofn.ru	YhAQnT-LLp0FCRcidXAV	\N	\N	\N	1	0	\N	2015-10-16 04:13:40.013507	2015-10-16 04:13:40.013507	178.35.24.40	178.35.24.40	ofn2@ofn.ru	\N	\N	2015-10-16 04:13:39.969502	2015-10-16 04:13:40.768677	\N	\N	\N	2015-10-16 04:13:39.999738	e44489f9ab504f269226719bfb263c597bffca44754ca0cf	\N	\N	1
13	5a6ff31b4c8880d4e3136f45d5ef52c2e8f5668d13304c62879bcfdd5cb00f411ba856ed85bc770a21de551543b71ed934567bf89de01328e76aec8062bbfeb4	d3eyzZeXroyQXwGypXv5	info@dovehouse.co.za	\N	\N	\N	\N	1	0	\N	2015-10-23 12:34:36.576378	2015-10-23 12:34:36.576378	41.193.254.24	41.193.254.24	info@dovehouse.co.za	\N	\N	2015-10-23 12:34:36.469248	2015-10-23 13:31:10.300745	\N	\N	\N	\N	d632b4be078bf7067f05ebf122aa6bdd5e50c15c3a9afbae	\N	\N	10
10	14fa590717daf17f97aecb098d3538797f9760d271888976dd1a95ec22d44e92d31837cbf445a93af6231e73f2e16a84b64a193ad9f2c6a0b34c69b1cf0205ff	zCPWW9oHeaqbgp7hwKRx	info@janemckenzie.com	\N	\N	\N	\N	1	0	\N	2015-10-16 06:18:02.496034	2015-10-16 06:18:02.496034	41.216.139.90	41.216.139.90	info@janemckenzie.com	\N	\N	2015-10-16 06:18:02.229082	2015-10-16 06:20:21.908532	\N	\N	\N	\N	721c17c545885818196cc35b6e2b9e766f1dad6ed4e7b454	\N	\N	1
15	c6577314bb5cd6eabbe281ff5c3289c15428c1105f0f285f400541fab1d184a44f05d18dbcc4f67eb9b002455ef6a1d8c65e848981c05e55c2225e92ff87b600	vXomxqTMqpNAdgyc4L1u	nietazan@axxess.co.za	yg2GIV-VL4DhZCQ2mehp	\N	\N	\N	1	0	\N	2015-11-04 09:00:26.128376	2015-11-04 09:00:26.128376	165.255.163.51	165.255.163.51	nietazan@axxess.co.za	\N	\N	2015-11-04 09:00:25.862408	2015-11-04 09:00:26.130269	\N	\N	\N	2015-11-04 09:00:26.110585	\N	\N	\N	1
\.


--
-- Name: spree_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_users_id_seq', 15, true);


--
-- Data for Name: spree_variants; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_variants (id, sku, weight, height, width, depth, deleted_at, is_master, product_id, count_on_hand, cost_price, "position", lock_version, on_demand, cost_currency, unit_value, unit_description, display_name, display_as) FROM stdin;
1		\N	\N	\N	\N	\N	t	1	5	\N	1	1	f	ZAR	1		\N	\N
2		\N	\N	\N	\N	\N	f	1	5	\N	2	1	f	ZAR	1		\N	\N
3		\N	\N	\N	\N	\N	t	2	0	\N	1	1	t	ZAR	1		\N	\N
4		\N	\N	\N	\N	\N	f	2	0	\N	2	1	t	ZAR	1		\N	\N
\.


--
-- Name: spree_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_variants_id_seq', 4, true);


--
-- Data for Name: spree_zone_members; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_zone_members (id, zoneable_id, zoneable_type, zone_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: spree_zone_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_zone_members_id_seq', 28, true);


--
-- Data for Name: spree_zones; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY spree_zones (id, name, description, created_at, updated_at, default_tax, zone_members_count) FROM stdin;
4	SA VAT Zone		2015-10-16 06:40:12.48091	2015-10-16 06:40:12.48091	t	0
\.


--
-- Name: spree_zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('spree_zones_id_seq', 4, true);


--
-- Data for Name: suburbs; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY suburbs (id, name, postcode, latitude, longitude, state_id) FROM stdin;
851	Airdlin	2191	-26.0264419999999994	28.0606739999999988	73
852	Barbeque Downs		-26.0069625000000002	28.0727614999999986	73
853	Barbeque Downs Business Park	2066	-26.0121752999999991	28.1030918000000014	73
854	Bloubosrand	2153	-26.0219875000000016	27.9688322000000014	73
855	Blue Hills, Gauteng	1685	-25.9629955000000017	28.0756881999999983	73
856	Broadacres, Gauteng	2191	-25.9946085999999994	27.9911601999999995	73
857	Buccleuch, Gauteng	2066	-26.0533189999999983	28.1034894000000008	73
858	Carlswald	1684	-25.9828924000000008	28.1034894000000008	73
859	Chartwell, Gauteng		-25.9870066999999985	27.9715081999999988	73
860	Country View		-25.9454616999999992	28.1268975999999995	73
861	Crowthorne, Gauteng	1684	-25.9757464999999996	28.0859312999999986	73
862	Dainfern	2191	-25.9833257000000017	27.9981141999999998	73
863	Diepsloot		-25.9395977000000002	28.0127534000000011	73
864	Ebony Park	1632	-26.0013821999999983	28.1774248999999983	73
865	Erand	1686	-25.9833329000000006	28.1166669999999996	73
866	Farmall, Gauteng		-25.9973261999999998	27.9571180000000012	73
867	Glen Austin	1685	-25.9775956999999984	28.1415261000000001	73
868	Halfway Gardens	1686	-25.9912655000000008	28.1151939000000013	73
869	Halfway House Estate	1685	-25.9871394000000002	28.1283604999999994	73
870	Headway Hill	1687	-25.9384134999999993	28.1378690999999996	73
871	Houtkoppen	2169	-26.0290306999999999	27.9578501999999993	73
872	Inadan		-25.4840744000000008	28.2312183999999995	73
873	Ivory Park		-25.9956600000000009	28.1971030999999996	73
874	Kya Sand	2169	-26.0256648999999989	27.9512606999999988	73
875	Kya Sands, Johannesburg	2188	-26.0244885000000004	27.963224799999999	73
876	Kyalami Agricultural Holdings		-30.5594819999999991	22.9375059999999991	73
877	Kyalami Business Park	1685	-25.9955168000000008	28.068113799999999	73
878	Kyalami Estates	1684	-25.9909554000000007	28.0844680000000011	73
879	Maroeladal	2191	-26.0157752000000002	27.9790813999999983	73
880	Midrand		-25.9991795000000003	28.1262927000000005	73
881	Midridge Park	1685	-25.9769208999999996	28.1254346999999996	73
882	Millgate Farm		-30.5594819999999991	22.9375059999999991	73
883	Nietgedacht	1739	-25.9759814999999996	27.9424743000000007	73
884	Noordwyk	1687	-25.9575281000000011	28.121045800000001	73
885	North Champagne Estates	2191	-25.9755466999999989	27.9607787999999999	73
886	Paulshof	2191	-26.0318964999999984	28.0508096999999985	73
887	Plooysville	1686	-26.0051167999999997	28.0815415000000002	73
888	Rabie Ridge	1632	-26.0222605000000016	28.1737043999999983	73
889	Randjespark		-25.9582057000000006	28.1371377000000003	73
890	Salfred	6170	-33.5569399999999973	26.8827800000000003	73
891	Sunninghill, Gauteng	2191	-26.0323925000000003	28.0742249000000008	73
892	Sunrella		-25.9463211999999999	27.935151900000001	73
893	Trevallyn, Gauteng	2163	-26.0275229999999986	27.9443570000000001	73
894	Trojan, Gauteng	2190	-26.2299247999999992	28.0445895000000007	73
895	Vorna Valley	1686	-26.0045637999999997	28.1034894000000008	73
896	Willaway	1684	-25.9961580000000012	28.0822730999999983	73
897	Witkoppen	2191	-26.0129647000000013	28.005434000000001	73
898	Albertskroon	2195	-26.1611733999999991	27.973956900000001	73
899	Albertville, Gauteng	2195	-26.1646223999999989	27.9768852000000017	73
900	Aldara Park	2194	-26.1338925000000017	27.9812775999999985	73
901	Amalgam, Gauteng	2092	-26.209718500000001	28.0039699999999989	73
902	Auckland Park	2006	-26.1826299999999996	28.0039699999999989	73
903	Berario	2195	-26.1345305000000003	27.9556536999999992	73
904	Beverley Gardens	2194	-26.0745237000000003	27.9929902000000013	73
905	Blackheath, Gauteng	2195	-26.1341666000000004	27.9702963999999987	73
906	Blairgowrie, Gauteng	2194	-26.1163765999999988	28.0098257000000004	73
907	Bordeaux, Gauteng	2194	-26.0978415999999989	28.0142172999999985	73
908	Bosmont	2093	-26.1887304000000007	27.9556536999999992	73
909	Brixton, Gauteng	2092	-26.1925130999999993	27.9988461999999991	73
910	Bryanbrink	2194	-26.0821648999999987	28.0017740999999987	73
911	Bryanston West, Gauteng	2191	-26.0787286000000016	28.0173279000000015	73
912	Clynton	2196	-26.1082028000000008	28.0277573000000011	73
913	Country Life Park	2060	-26.0774442999999998	28.0226341999999988	73
914	Cowdray Park, Gauteng		-26.0586145999999985	27.9896960999999997	73
915	Craighall	2196	-26.1116355999999996	28.0259277000000004	73
916	Craighall Park	2196	-26.1247508999999987	28.0215363000000011	73
917	Cramerview	2191	-26.0735001000000004	28.0123874000000015	73
918	Cresta, Gauteng	2194	-26.1269017000000012	27.9790813999999983	73
919	Crown, Gauteng	2025	-26.2247358000000013	28.0098257000000004	73
920	Daniel Brink Park	2194	-26.0740803999999997	27.9999442000000016	73
921	Darrenwood	2194	-26.1289049999999996	27.9856699000000013	73
922	Dunkeld West	2196	-26.1341687	28.0347098999999993	73
923	Dunkeld, Gauteng	2196	-26.1383532999999986	28.0405645999999997	73
924	Emmarentia	2029	-26.1651431000000017	28.0098257000000004	73
925	Ferndale, Gauteng	2194	-26.0875503000000002	27.9922581999999984	73
926	Florida Glen	1709	-26.1647064	27.9410097999999998	73
927	Fontainebleau, Gauteng	2194	-26.1058363	27.9761531000000012	73
928	Forest Town, Gauteng	2193	-26.1714735999999988	28.0376373000000001	73
929	Glenadrienne	2196	-26.0975657000000005	28.0251957999999988	73
931	Greenside, Gauteng	2193	-26.1530743000000001	28.0156810999999983	73
932	Greymont	2035	-26.1630196999999995	27.9651716000000015	73
933	Hurlingham Gardens	2196	-26.0982586000000012	28.0299529000000014	73
934	Hurlingham, Gauteng	2196	-26.1028920000000006	28.0288551000000012	73
935	Hyde Park, Gauteng	2196	-26.1210541999999997	28.0391009000000011	73
936	Jan Hofmeyer, Gauteng	2092	-26.1924467000000014	28.0120214999999995	73
937	Kensington B	2194	-26.078623799999999	28.0025061000000015	73
938	Linden, Gauteng		-26.1363269000000003	27.9922581999999984	73
939	Lyme Park, Gauteng	2191	-26.0842934	28.0142172999999985	73
940	Malanshof	2194	-26.0949954999999996	27.9761531000000012	73
941	Melville, Gauteng		-26.1749328000000006	28.0083617999999994	73
942	Mill Hill, Gauteng	2191	-26.0691279999999992	28.0138512999999989	73
943	Newlands, Gauteng	2092	-26.1749977999999999	27.9629751999999989	73
944	Northcliff		-26.1478991000000001	27.9629751999999989	73
945	Oerder Park	2194	-26.1114047000000014	28.0189747000000011	73
946	Osummit	2194	-26.0694285000000008	27.9962842000000016	73
947	Parkhurst, Gauteng		-26.136819599999999	28.0156810999999983	73
948	Parkmore	2196	-26.0983353999999999	28.0376373000000001	73
949	Parktown North	2193	-26.1451908999999993	28.0273913999999991	73
950	Parkview, Gauteng	2193	-26.1614438999999983	28.0273913999999991	73
951	Praegville	2194	-26.0932426	27.9812775999999985	73
952	President Ridge	2194	-26.1054724	27.9907940999999987	73
953	Randburg		-26.1438398999999997	27.9951861999999991	73
954	Randpark	2194	-26.1097757000000001	27.9702963999999987	73
955	Randpark Ridge	2156	-26.1036681000000002	27.9541894000000006	73
956	River Bend, Gauteng	0157	-25.8407128999999998	28.211112	73
957	Rosebank, Gauteng	2196	-26.1437707999999986	28.0405645999999997	73
958	Ruiterhof	2194	-26.1031610000000001	27.9856699000000013	73
959	Sandhurst, Gauteng	2196	-26.1106484999999999	28.0434918000000017	73
960	Solridge	2191	-26.0795223000000007	28.0208045000000006	73
961	Sophiatown	2092	-26.1743585000000003	27.9787526	73
962	Strijdompark		-23.9984685999999989	27.7666566999999986	73
963	Vandia Grove	2194	-26.0667003999999984	27.9915261999999991	73
964	Vrededorp, Gauteng	2092	-26.1939214999999983	28.0178767999999998	73
965	Westcliff, Gauteng	2193	-26.1722788000000008	28.0273913999999991	73
966	Willowild	2196	-26.0971343000000005	28.0208045000000006	73
967	Bromhof	2188	-26.0866110000000013	27.964439500000001	73
968	Bush Hill, Gauteng	2154	-26.0825576000000012	27.9417420000000014	73
969	Constantia Kloof	1709	-26.1464546999999996	27.9117184999999992	73
970	Douglasdale, Gauteng	2191	-26.0387658000000002	27.9922581999999984	73
971	Fairland, Gauteng	2170	-26.1365549000000001	27.9395454000000001	73
972	Florida Hills	1709	-26.162358900000001	27.9263647000000006	73
973	Florida, Gauteng	1709	-26.1794173000000008	27.9161125000000006	73
974	Johannesburg North	2153	-26.0434964999999998	27.9761531000000012	73
975	Jukskei Park	2153	-26.0357993999999984	27.9805455999999992	73
976	Northgate, Gauteng	2162	-26.0604739999999993	27.9468674999999998	73
977	Northriding	2162	-26.0503233999999999	27.9629751999999989	73
978	Olivedale, Gauteng	2158	-26.0585816000000001	27.9753879999999988	73
979	Roodepoort		-26.1201355	27.9014653999999993	73
980	Weltevredenpark	1715	-26.1194224999999989	27.9307583999999984	73
981	Zandspruit		-26.0101842000000012	27.9410097999999998	73
982	Diepkloof		-26.2445832999999986	27.9541894000000006	73
983	Dobsonville	1863	-26.2233613000000005	27.8487259999999992	73
984	Doornkop		-24.6206862000000015	30.2945361999999996	73
985	Kliptown	1809	-26.2725998999999995	27.8877099999999984	73
986	Meadowlands, Gauteng	1852	-26.202618600000001	27.8765625999999997	73
987	Noordgesig	1804	-26.2270350000000008	27.9410097999999998	73
988	Orlando, Soweto	1804	-26.2223499999999987	27.9117184999999992	73
989	Phiri, Soweto	1818	-26.2719790000000017	27.8560517999999995	73
990	Protea Glen		-26.2725848999999982	27.8124660000000006	73
991	Soweto		-26.2485377	27.8540323000000001	73
992	Zola, South Africa		-30.5753093000000007	27.6156126999999998	73
993	Abbotsford, Johannesburg		-26.1431119999999986	28.066176200000001	73
994	Alexandra, Gauteng	2090	-26.1033012000000006	28.0976369000000012	73
995	Atholhurst	2196	-26.1191655999999988	28.0705664000000006	73
996	Atholl Gardens	2196	-26.1079764999999995	28.0738589999999988	73
997	Atholl, Gauteng	2196	-26.1165512	28.0669079000000004	73
998	Bagleyston	2192	-26.1505596000000011	28.0870287000000012	73
999	Benmore Gardens	2196	-26.0910693999999985	28.0464190000000002	73
1000	Birdhaven, Gauteng	2196	-26.1406865999999987	28.0552002999999992	73
1001	Birnam, Gauteng	2196	-26.1328016000000005	28.0669079000000004	73
1002	Bramley North	2090	-26.1192856999999989	28.0764199000000012	73
1003	Bramley Park	2090	-26.1152231999999991	28.0764199000000012	73
1004	Bramley, Gauteng	2018	-26.1242991000000018	28.0815415000000002	73
1005	Bruma Lake Flea Market, Gauteng		-26.2707593000000017	28.1122678999999991	73
1006	Bruma, Gauteng	2198	-26.1776869999999988	28.1108048000000004	73
1007	Bryanston East, Gauteng	2191	-26.0392280000000014	28.0175109000000013	73
1008	Bryanston, Gauteng	2191	-26.0563986000000014	28.0244639000000006	73
1009	Cheltondale	2192	-26.1515930999999995	28.0837363999999994	73
1010	Chislehurston	2196	-26.1169258999999983	28.0522731999999984	73
1011	Cyrildene	2198	-26.1741287000000007	28.1020262999999986	73
1012	Dalecross	1622	-26.1148540999999987	28.2638737999999989	73
1013	Dennehof, Gauteng	2196	-26.1100139999999996	28.0577614000000004	73
1014	Dunhill, Gauteng	2192	-26.1459372999999999	28.1033064999999986	73
1015	Edenburg, Gauteng	2191	-26.056527899999999	28.0625177000000008	73
1016	Elton Hill	2196	-26.1271704999999983	28.0647127999999988	73
1017	Epsom Downs, Gauteng	2191	-26.0420738000000007	28.0120214999999995	73
1018	Fairway, Gauteng	2196	-26.1321586000000003	28.0603225000000016	73
1019	Fairwood, Gauteng	2192	-26.1655589000000006	28.0881261000000002	73
1020	Fellside, Gauteng		-26.1663680999999997	28.0778831999999987	73
1021	Forbesdale	2192	-26.1534638000000008	28.0820901999999997	73
1022	Fourways	2191	-26.0254684999999988	28.0039699999999989	73
1023	Gallo Manor	2191	-26.0680388000000001	28.0786148000000004	73
1024	The Gardens, Gauteng	2192	-26.149075400000001	28.0764199000000012	73
1025	Glen Athol	2090	-26.1114691999999984	28.074956499999999	73
1026	Glenhazel	2192	-26.1389309999999995	28.1020262999999986	73
1027	Gresswold	2090	-26.1311885000000004	28.0873944999999985	73
1028	Hawkins Estate	2192	-26.1481490000000001	28.0808098000000008	73
1029	Highlands North, Gauteng	2192	-26.1426380000000016	28.0844680000000011	73
1030	Houghton Estate	2198	-26.1648722000000014	28.0625177000000008	73
1031	Hurl Park	2196	-26.0939787999999986	28.0438577000000002	73
1032	Illovo, Gauteng	2196	-26.1294232999999991	28.0508096999999985	73
1033	Inanda, Gauteng	2196	-26.1198493999999997	28.0544684999999987	73
1034	Kentview, Gauteng	2196	-26.1278946999999988	28.0628835000000016	73
1035	Kew, Gauteng	2090	-26.1212119999999999	28.0961737000000014	73
1036	Khyber Rock	2191	-26.0537858	28.0851995999999993	73
1037	Killarney, Gauteng	2193	-26.1683874000000003	28.0522731999999984	73
1038	Klevehill Park	2191	-26.0368497000000012	28.0369053999999984	73
1039	Littlefillan	2057	-26.0865825999999998	28.0444065999999985	73
1040	Lone Hill	2191	-26.0151353999999984	28.0273913999999991	73
1041	Magalies View	2191	-26.0274572000000006	28.0195235999999994	73
1042	Magaliessig	2191	-26.0338531000000017	28.0156810999999983	73
1043	Marlboro Gardens	2090	-26.0914232000000013	28.0961737000000014	73
1044	Marlboro, Gauteng	2090	-26.0932741999999998	28.0873944999999985	73
1045	Maryvale, Gauteng	2192	-26.1539444000000003	28.0870287000000012	73
1046	Melrose Estate	2196	-26.1467205000000007	28.0522731999999984	73
1047	Melrose North	2196	-26.1425373000000008	28.0464190000000002	73
1048	Melrose, Gauteng	2196	-26.1425373000000008	28.0464190000000002	73
1049	Moodie Hill	2057	-26.0860516000000011	28.0412964000000002	73
1050	Morningside Manor	2057	-26.0719799999999999	28.0727614999999986	73
1051	Morningside, Gauteng	2057	-26.0781999000000013	28.0625177000000008	73
1052	Mountain View, Gauteng	0082	-25.6996481999999986	28.1620038999999984	73
1053	Norscot	2055	-26.0367438	28.0083617999999994	73
1054	Northern Acres, Gauteng	2196	-26.0886832999999996	28.0497119999999995	73
1055	Norwood, Gauteng	2192	-26.1586485000000017	28.0727614999999986	73
1056	Oaklands, Gauteng	2192	-26.1473884000000005	28.068371299999999	73
1057	Orange Grove, Gauteng	2192	-26.1609750000000005	28.0873944999999985	73
1058	Percelia Estate	2192	-26.1426611000000015	28.0939790000000009	73
1059	Petervale	2191	-26.0395928999999988	28.0464190000000002	73
1060	Raedene Estate	2192	-26.1480765999999996	28.0939790000000009	73
1061	Raumarais Park	2090	-26.1207595999999995	28.0822730999999983	73
1062	River Club, Gauteng		-26.0781394999999989	28.0434918000000017	73
1063	Riviera, Gauteng	0084	-25.7336357999999983	28.2131879000000012	73
1064	Rivonia	2191	-26.0431661000000005	28.0552002999999992	73
1065	Sandown, Gauteng	2196	-26.1052876000000005	28.0625177000000008	73
1066	Sandton		-26.1075662999999984	28.0567007000000004	73
1067	Savoy Estate	2090	-26.1315920999999989	28.0822730999999983	73
1068	Saxonwold	2132	-26.1589767000000002	28.0391009000000011	73
1069	Simba, Gauteng	2031	-26.1002061999999988	28.0705664000000006	73
1070	Strathavon	2031	-26.0957414000000014	28.0756881999999983	73
1071	Sunningdale Ridge	2192	-26.134571600000001	28.1082445000000014	73
1072	Sunningdale, Gauteng	2192	-26.1338468000000006	28.1100732999999998	73
1073	Sunset Acres	2196	-26.0872211000000007	28.0486143000000006	73
1074	Sydenham, Gauteng	2192	-26.1537053999999998	28.0961737000000014	73
1075	Victoria, Gauteng	2192	-26.1642781000000006	28.074956499999999	73
1076	Wierda Valley	2196	-26.1121528000000005	28.0588590000000018	73
1077	Woodlands, Gauteng		-26.0619118999999984	28.0851995999999993	73
1078	Woodmead		-26.0474147999999985	28.0800781999999991	73
1079	Wynberg, Gauteng	2090	-26.1101409000000011	28.0844680000000011	73
1080	Aeroton	2013	-26.2538112999999989	27.9746890000000015	73
1081	Alan Manor	2091	-26.2782376000000006	27.9937222000000006	73
1082	Aspen Hills, Gauteng		-26.3104228000000013	28.0464190000000002	73
1083	Belgravia, Gauteng	1401	-26.1752299000000015	28.1471942999999989	73
1084	Bellevue East	2198	-26.1836376000000008	28.0698347000000012	73
1085	Bellevue, Gauteng	2198	-26.1793623000000011	28.0676395999999997	73
1086	Benrose	2094	-26.2109476000000008	28.0815415000000002	73
1087	Berea, Gauteng	2198	-26.1867270000000012	28.0552002999999992	73
1088	Bertrams, Gauteng	2094	-26.1932104999999993	28.066176200000001	73
1089	Braamfontein	2000	-26.1921898000000013	28.0373201999999999	73
1090	Braamfontein Werf	2092	-26.1867342000000001	28.0182427999999994	73
1091	Chrisville	2091	-26.253100700000001	28.0230001000000009	73
1092	City and Suburban Industrial, Gauteng	1438	-26.5099446000000007	28.3651872999999988	73
1093	City and Suburban, Gauteng	2094	-26.2083906000000013	28.0552002999999992	73
1094	City Deep, Gauteng	2049	-26.2261473000000009	28.0800781999999991	73
1095	City West-Denver	2198	-26.1905560000000008	28.0570829999999987	73
1096	Crown Gardens	2091	-26.2513918000000004	28.005434000000001	73
1097	Crown North	2092	-26.2107901000000005	28.0149492000000002	73
1098	Doornfontein		-26.1948509999999999	28.0552002999999992	73
1099	Droste Park	2094	-26.2107145999999993	28.0698347000000012	73
1100	Eagles Nest, Gauteng	2091	-26.3044633999999995	27.995369199999999	73
1101	Eastcliff, Gauteng	2190	-26.2677447000000015	28.0530049999999989	73
1102	Elandspark	2197	-26.2405651999999989	28.1078787000000005	73
1103	Elcedes	2094	-26.2072058000000006	28.0848337999999984	73
1104	Electron, Gauteng	2197	-26.240337199999999	28.0961737000000014	73
1105	Elladoone	2197	-26.2392849999999989	28.0899551999999986	73
1106	Evans Park	2091	-26.2444069999999989	28.0032381000000008	73
1107	Fairview, Gauteng	2094	-26.2027943000000008	28.0672737999999988	73
1108	Ferreirasdorp	2001	-26.2081310000000016	28.0339780999999988	73
1109	Fordsburg		-26.2070611999999983	28.0230001000000009	73
1110	Forest Hill, Gauteng	2190	-26.2527171999999993	28.0376373000000001	73
1111	Framton	2091	-26.2288227999999997	28.0193407000000008	73
1112	The Gables, Gauteng	2022	-26.2066985999999993	28.1192171000000002	73
1113	Gillview	2091	-26.2638365	28.0266595000000009	73
1114	Glenanda	2091	-26.2716707000000014	28.0376373000000001	73
1115	Glenesk	2190	-26.2339970999999998	28.0493461000000011	73
1116	Glenvista	2058	-26.2810686999999987	28.0508096999999985	73
1117	Haddon, Gauteng	2190	-26.2555210000000017	28.0339780999999988	73
1118	Heriotdale	2094	-26.2143459000000014	28.1166568999999988	73
1119	Highlands, Gauteng	2198	-26.1886741000000001	28.063615200000001	73
1120	Hillbrow	2001	-26.1931648000000017	28.0471508000000007	73
1121	Jan Hofmeyer	2092	-26.1924467000000014	28.0120214999999995	73
1122	Jeppestown	2094	-26.2046810000000008	28.0727614999999986	73
1123	Jeppestown South	2011	-26.2074570000000016	28.080444	73
1124	Johannesburg South		-26.2738662000000005	27.9951861999999991	73
1125	Joubert Park		-26.190372	28.0412678	73
1126	Judith's Paarl	2094	-26.1916651000000016	28.0734932000000015	73
1127	Kenilworth, Gauteng	2190	-26.2475354000000003	28.0493461000000011	73
1128	Kensington, Gauteng	2101	-26.1953613999999995	28.0976369000000012	73
1129	Kibler Park	2091	-26.3222248000000008	28.0098257000000004	73
1130	Klipriviersberg	2197	-26.2418197000000006	28.0811756000000017	73
1131	Klipriviersberg Estate		-26.2708332999999996	28.0749999999999993	73
1132	La Rochelle, Gauteng	2190	-26.2381753999999994	28.0552002999999992	73
1133	Lake View Estate	2091	-26.2239408000000012	28.0248297999999991	73
1134	Liefde en Vrede	2190	-26.3089875000000006	28.0595907000000011	73
1135	Lindberg Park	2190	-26.2531223999999987	28.0325144000000002	73
1136	Linmeyer	2190	-26.2611100999999998	28.068371299999999	73
1137	Lorentzville	2094	-26.1898845999999992	28.0691029999999984	73
1138	Malvern, Gauteng	2094	-26.2012008999999999	28.1020262999999986	73
1139	Marshalls, Gauteng		-26.2057639000000009	28.0576000000000008	73
1140	Marshalltown, Gauteng	2001	-26.207536600000001	28.0464190000000002	73
1141	Mayfair, Gauteng	2092	-26.2041128999999984	28.0112895000000002	73
1142	Mayfield Park, Gauteng	2091	-26.3157843999999983	28.0178767999999998	73
1143	Meredale	2091	-26.2742462000000003	27.9805455999999992	73
1144	Milpark	6001	-33.9619029999999995	25.5905589999999989	73
1145	Moffat View	2197	-26.2394886000000014	28.0873944999999985	73
1146	Mondeor	2091	-26.2747205999999984	28.0039699999999989	73
1147	Mulbarton, Gauteng	2190	-26.2960725999999987	28.056663799999999	73
1148	Nasrec		-26.2417419999999986	27.9805455999999992	73
1149	New Centre, Gauteng	2001	-26.2164919999999988	28.0456871999999997	73
1150	New Doornfontein	2094	-26.1963229999999996	28.0610542000000009	73
1151	Newtown, Johannesburg	2001	-26.2025006000000005	28.0317825999999997	73
1152	North Doornfontein	2094	-26.2084602000000011	28.0628835000000016	73
1153	Oakdene, Gauteng	2190	-26.2625425999999997	28.0552002999999992	73
1154	Observatory, Gauteng	2198	-26.1774126000000003	28.0800781999999991	73
1155	Ophirton	2091	-26.2247841000000008	28.0288551000000012	73
1156	Ormonde, Gauteng	2091	-26.2501080999999985	27.9922581999999984	73
1157	Pageview, Gauteng	2092	-26.1969387000000005	28.016413	73
1158	Park Central, Gauteng	2001	-26.217728000000001	28.0398327000000016	73
1159	Parktown	2193	-26.1806444999999997	28.0391009000000011	73
1160	Patlynn	2053	-26.3224902999999983	28.0405645999999997	73
1161	Prolecon	2001	-26.2178198999999985	28.0570295999999999	73
1162	Randview	2198	-26.1866066000000011	28.0702005999999997	73
1163	Regency, Gauteng	2197	-26.2369479000000005	28.0658104000000002	73
1164	Regents Park Estate	2197	-26.2404964000000014	28.0698347000000012	73
1165	Regents Park, Gauteng	2197	-26.2359615999999995	28.0672737999999988	73
1166	Reuven, Gauteng	2091	-26.2347849999999987	28.0295869999999994	73
1167	Rewlatch	2197	-26.2419654999999992	28.0756881999999983	73
1168	Reynolds View	2094	-26.2206235999999997	28.0533709000000009	73
1169	Ridgeway, Gauteng	2091	-26.2597069000000012	27.9981141999999998	73
1170	Riepen Park	2196	-26.1104501000000013	28.0299529000000014	73
1171	Risana	2197	-26.2572955999999991	28.0895894000000013	73
1172	Rispark	2053	-26.3185099999999998	28.0273913999999991	73
1173	Robertsham	2091	-26.2451672999999985	28.0156810999999983	73
1174	Roseacre, Gauteng	2197	-26.2380201	28.0815415000000002	73
1175	Rosettenville	2190	-26.252757299999999	28.056663799999999	73
1176	Salisbury Claims	2001	-26.2110760999999997	28.0456871999999997	73
1177	Selby, Gauteng		-26.215614200000001	28.0273913999999991	73
1178	South Hills, Gauteng	2197	-26.2476094999999994	28.0873944999999985	73
1179	Southdale, Gauteng	2091	-26.2427911000000016	28.023731999999999	73
1180	Southfork, Gauteng	2091	-26.3097966999999997	27.9933562000000009	73
1181	Southgate, Gauteng		-26.2666432999999984	27.9812775999999985	73
1182	Spes Bona	2094	-26.2086116999999987	28.0725785999999999	73
1183	Springfield, Gauteng	2190	-26.2277501000000015	28.0500779000000016	73
1184	Stafford, Gauteng	2197	-26.2265878000000008	28.0427600000000012	73
1185	Steeledale	2197	-26.2462726000000011	28.0969052999999995	73
1186	Suideroord	2091	-26.2751899000000009	28.0273913999999991	73
1187	The Hill, Gauteng	2197	-26.2498562	28.0639810999999995	73
1188	Theta, Gauteng	2091	-26.2330503999999998	28.0025061000000015	73
1189	Towerby	2190	-26.2554452000000005	28.0471508000000007	73
1190	Townsview	2190	-26.2585782999999999	28.0515414000000014	73
1191	Troyeville	2094	-26.1998840999999985	28.0698347000000012	73
1192	Tulisa Park	2197	-26.2499247999999987	28.1020262999999986	73
1193	Turf Club, Gauteng	2190	-26.2477066999999984	28.0325144000000002	73
1194	Turffontein	2190	-26.2456384999999983	28.0391009000000011	73
1195	Village Main, Gauteng	2001	-26.2142109999999988	28.0500779000000016	73
1196	Yeoville	2198	-26.1827834000000017	28.0610542000000009	73
1197	Ennerdale, Gauteng		-26.4101351999999991	27.8370041000000015	73
1198	Lawley, Gauteng	1830	-26.3804479000000001	27.810626899999999	73
1199	Lenasia		-26.3335179000000004	27.8663075000000013	73
1200	Orange Farm	1841	-26.459382999999999	27.8604471999999994	73
1201	Akasia		-25.655543999999999	28.1005631999999999	73
1202	Arcadia, Pretoria	0083	-25.7452657999999985	28.2029522999999998	73
1203	Atteridgeville	0006	-25.7730891	28.0830047	73
1204	Booysens, Pretoria	0082	-25.7113593999999992	28.1254346999999996	73
1205	Brooklyn, Pretoria		-25.7649846999999994	28.2380431999999999	73
1206	Chantelle, Pretoria	0201	-25.664457800000001	28.0903209999999994	73
1207	Eersterust		-25.7056639999999987	28.3140487999999984	73
1208	Elardus Park	0181	-25.8317017	28.255586000000001	73
1209	Garsfontein	0081	-25.8001788000000012	28.3023579000000005	73
1210	Groenkloof	0027	-25.7740894999999988	28.2204987000000003	73
1211	Hatfield, Pretoria	0083	-25.7487333000000014	28.2380431999999999	73
1212	Kameeldrift		-25.6540970000000002	28.322379999999999	73
1213	Lynnwood Manor	0081	-25.7588958999999988	28.2862815000000012	73
1214	Lynnwood, Pretoria	0081	-25.7642507999999992	28.2672801000000007	73
1215	Marabastad, Pretoria		-25.739422900000001	28.1758981999999989	73
1216	Menlo Park, Pretoria	0081	-25.7698511000000003	28.2599714000000013	73
1217	Monument Park, Pretoria	0181	-25.8041322000000015	28.2321951999999996	73
1218	Moreleta Park	0181	-25.8263929999999995	28.2935890999999984	73
1219	Pretoria North	0182	-25.6776164999999992	28.1766293999999995	73
1220	Prinshof	7100	-33.9703249000000014	18.6484339000000006	73
1221	Waterkloof	9970	-30.3154295000000005	25.3015383000000007	73
1222	Waterkloof Ridge	0181	-25.7962543999999987	28.2438910000000014	73
1223	Wingate Park	0181	-25.8334180000000018	28.2731269000000012	73
1225	Bluff, KwaZulu-Natal		-29.9218617999999985	31.0048384000000006	74
1227	Cato Manor	4091	-29.8588389999999997	30.9770359999999982	74
1228	Cowies Hill	3610	-29.8247205999999991	30.8915189999999988	74
1230	Forest Hills, Kloof	3624	-29.7542885000000012	30.8355378000000009	74
1231	Gillitts	3610	-29.7903489000000015	30.7867129000000013	74
1232	Glenwood, KwaZulu-Natal	4001	-29.8708430000000007	30.9905000000000008	74
1233	Kennedy Road, Durban	4091	-29.8130999999999986	30.9781039999999983	74
1234	Kloof		-29.7785344000000016	30.8326662999999996	74
1236	La Lucia	4051	-29.7486837000000008	31.059308699999999	74
1237	Magabeni		-30.1695914999999992	30.7680395000000004	74
1240	Ottawa, KwaZulu-Natal	4339	-29.6621831	31.0306432000000001	74
1241	Overport	4091	-29.8374105000000007	30.9912169999999989	74
1242	Queensburgh		-29.879350800000001	30.9073039999999999	74
1243	Shallcross, Durban	4079	-29.8811658999999992	30.8699908000000001	74
1244	Stamford Hill, Durban	4001	-29.8291384999999991	31.0306432000000001	74
1245	Sydenham, Durban	4091	-29.8291205999999995	30.9905000000000008	74
1246	Umlazi		-29.9687501000000012	30.8843433999999988	74
1247	Upper Highway Area		-30.5594819999999991	22.9375059999999991	74
1248	Wentworth, Durban	4052	-29.9267028999999987	30.9962355999999986	74
1250	Winston Park, South Africa	3610	-29.8056243999999992	30.7780948000000016	74
1251	Fauna, Bloemfontein	9301	-29.1692256999999984	26.1905910000000013	75
1252	Heuwelsig	9301	-29.0809394999999995	26.1994517000000009	75
1254	Rondebosch	7700	-33.9657882999999998	18.4810200000000009	76
1255	Wynberg		0	0	76
1256	Newlands	7700	-33.9789128999999974	18.4483762999999996	76
1257	Cornwall Hill	0157	-25.870833300000001	28.2413889000000005	73
1258	Erasmia		-25.8129664000000005	28.0932473999999992	73
1259	Heuweloord	0157	-25.8828968999999987	28.1151939000000013	73
1260	Irene, Gauteng	0157	-25.8811883999999992	28.2263470000000005	73
1226	Botha's Hill	3624	-29.7166670000000011	30.7333330000000018	74
1229	Durban North	4051	-29.7870388999999989	31.0220421999999907	74
1235	KwaMashu		-29.7400389000000018	30.9818962000000013	74
1238	Mariannhill	3610	-29.8445535999999905	30.8297947000000008	74
1239	Morningside, Durban	4001	-29.8231724999999912	31.0134405999999991	74
1249	Westville, KwaZulu-Natal	3629	-29.8316729000000009	30.9302602999999898	74
1253	Willows, Bloemfontein	9301	-29.1218833999999909	26.203881899999999	75
1261	Kloofsig	0157	-25.8118525000000005	28.2051456999999992	73
1262	Laudium		-25.7835855999999985	28.0976369000000012	73
1263	Lyttelton, Gauteng	0157	-25.8316799999999986	28.2160000000000011	73
1264	Olievenhoutbosch		-25.8775833000000013	28.1904234000000002	73
1265	Pierre van Ryneveld Park		-25.7854856999999988	28.1245450000000012	73
1266	Allen Grove, Gauteng	1619	-26.0840077000000008	28.2336571999999997	73
1267	Birchleigh	1618	-26.0573712999999998	28.2380431999999999	73
1268	Bonaero Park	1622	-26.1239938999999985	28.255586000000001	73
1269	Cresslawn	1619	-26.1118549999999985	28.2044145999999998	73
1270	Edleen	1619	-26.0918680999999992	28.2029522999999998	73
1271	Esther Park	1619	-26.1016499000000017	28.2014899999999997	73
1272	Norkem Park	1618	-26.0502630000000011	28.2204987000000003	73
1273	Van Riebeeck Park	1619	-26.0785648999999999	28.2146501000000001	73
1274	Three Rivers East	1929	-26.6590094999999998	28.0039699999999989	73
1275	Three Rivers Proper	2191	-26.0655199999999994	28.0497699999999988	73
930	Gleniffer		-29.6833330000000011	25.5166669999999982	73
1224	Berea, Durban	4091	-29.8325013999999982	31.0159036000000015	74
\.


--
-- Name: suburbs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('suburbs_id_seq', 1275, true);


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
\.


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('taggings_id_seq', 1, false);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY tags (id, name, taggings_count) FROM stdin;
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('tags_id_seq', 1, false);


--
-- Data for Name: variant_overrides; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY variant_overrides (id, variant_id, hub_id, price, count_on_hand) FROM stdin;
\.


--
-- Name: variant_overrides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('variant_overrides_id_seq', 1, false);


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: ofn
--

COPY versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
1	Enterprise	1	update	\N	---\nid: 1\nname: ofn@ofn.ru\ndescription: \nlong_description: \nis_primary_producer: true\ncontact: ofn@ofn.ru\nphone: ofn@ofn.ru\nemail: ofn@ofn.ru\nwebsite: \ntwitter: \nabn: \nacn: \naddress_id: 3\npickup_times: \nnext_collection_at: \ncreated_at: 2015-10-16 03:29:12.649799000 Z\nupdated_at: 2015-10-16 03:30:00.075084000 Z\ndistributor_info: \nlogo_file_name: rescue_mode_or_reinstall_server.png\nlogo_content_type: image/png\nlogo_file_size: 145276\nlogo_updated_at: 2015-10-16 03:29:28.501683000 Z\npromo_image_file_name: rescue_step1.png\npromo_image_content_type: image/png\npromo_image_file_size: 124699\npromo_image_updated_at: 2015-10-16 03:29:39.795128000 Z\nvisible: false\nfacebook: \ninstagram: \nlinkedin: \nowner_id: 8\nsells: unspecified\nconfirmation_token: rDJzKyerqwyFKaDue4zh\nconfirmed_at: \nconfirmation_sent_at: 2015-10-16 03:29:12.649204000 Z\nunconfirmed_email: \nshop_trial_start_date: \nproducer_profile_only: false\npermalink: ofn-ofn-ru\ncharges_sales_tax: true\norigin_code: ofn@ofn.ru\n	2015-10-16 03:33:38.498587
2	Enterprise	2	update	\N	---\nid: 2\nname: ofn2@ofn.ru\ndescription: \nlong_description: \nis_primary_producer: true\ncontact: ofn2@ofn.ru\nphone: ofn2@ofn.ru\nemail: ofn2@ofn.ru\nwebsite: \ntwitter: \nabn: \nacn: \naddress_id: 6\npickup_times: \nnext_collection_at: \ncreated_at: 2015-10-16 04:14:45.624136000 Z\nupdated_at: 2015-10-16 04:15:32.872403000 Z\ndistributor_info: \nlogo_file_name: rescue_mode_or_reinstall_server.png\nlogo_content_type: image/png\nlogo_file_size: 145276\nlogo_updated_at: 2015-10-16 04:15:02.664471000 Z\npromo_image_file_name: \npromo_image_content_type: \npromo_image_file_size: \npromo_image_updated_at: \nvisible: false\nfacebook: \ninstagram: \nlinkedin: \nowner_id: 9\nsells: unspecified\nconfirmation_token: \nconfirmed_at: 2015-10-16 04:15:32.870800000 Z\nconfirmation_sent_at: 2015-10-16 04:14:45.623564000 Z\nunconfirmed_email: \nshop_trial_start_date: \nproducer_profile_only: false\npermalink: ofn2-ofn-ru\ncharges_sales_tax: true\norigin_code: ofn2@ofn\n	2015-10-16 04:45:24.555727
3	Enterprise	3	update	\N	---\nid: 3\nname: Joburg Best Produce Hub\ndescription: A hub for the best produce and natural health products from Jozi\nlong_description: \nis_primary_producer: true\ncontact: Jane Mackenzie\nphone: 0834596208\nemail: info@janemackenzie.co.za\nwebsite: \ntwitter: \nabn: \nacn: \naddress_id: 9\npickup_times: \nnext_collection_at: \ncreated_at: 2015-10-16 06:24:49.329280000 Z\nupdated_at: 2015-10-16 06:27:37.055184000 Z\ndistributor_info: \nlogo_file_name: OFN_ringlogo_black.png\nlogo_content_type: image/png\nlogo_file_size: 14446\nlogo_updated_at: 2015-10-16 06:26:49.177381000 Z\npromo_image_file_name: kale.jpg\npromo_image_content_type: image/jpeg\npromo_image_file_size: 499262\npromo_image_updated_at: 2015-10-16 06:27:28.542974000 Z\nvisible: false\nfacebook: \ninstagram: \nlinkedin: \nowner_id: 11\nsells: unspecified\nconfirmation_token: Jos4L2tD1yCpXHrfTvNa\nconfirmed_at: \nconfirmation_sent_at: 2015-10-16 06:24:49.328642000 Z\nunconfirmed_email: \nshop_trial_start_date: \nproducer_profile_only: false\npermalink: joburg-best-produce-hub\ncharges_sales_tax: false\norigin_code: \n	2015-10-16 06:28:30.652406
4	Enterprise	4	update	\N	---\nid: 4\nname: Dove House Organics\ndescription: KZN Midlands premiere supplier of organic produce\nlong_description: ! '"Our dream was to develop a small scale organic farm using permaculture\n  design principles that would not only provide a healthy lifestyle and income for\n  our family, but also become an inspirational education center where people could\n  come and learn about permaculture and organic gardening / farming techniques. We\n  also dreamed that our community would have easy access to organic health foods and\n  products " -  Paul Duncan'\nis_primary_producer: true\ncontact: Paul Duncan\nphone: 084 292 4354\nemail: info@dovehouse.co.za\nwebsite: http://dovehouse.co.za/\ntwitter: \nabn: \nacn: \naddress_id: 12\npickup_times: \nnext_collection_at: \ncreated_at: 2015-10-23 12:37:29.333293000 Z\nupdated_at: 2015-10-23 12:51:58.950076000 Z\ndistributor_info: \nlogo_file_name: logo.png\nlogo_content_type: image/png\nlogo_file_size: 15787\nlogo_updated_at: 2015-10-23 12:43:00.428738000 Z\npromo_image_file_name: 01_n.jpg\npromo_image_content_type: image/jpeg\npromo_image_file_size: 86862\npromo_image_updated_at: 2015-10-23 12:48:36.133427000 Z\nvisible: false\nfacebook: https://www.facebook.com/dovehouse.organics\ninstagram: \nlinkedin: \nowner_id: 13\nsells: unspecified\nconfirmation_token: \nconfirmed_at: 2015-10-23 12:51:58.948288000 Z\nconfirmation_sent_at: 2015-10-23 12:37:29.332699000 Z\nunconfirmed_email: \nshop_trial_start_date: \nproducer_profile_only: false\npermalink: dove-house-organics\ncharges_sales_tax: false\norigin_code: \n	2015-10-23 12:53:56.164023
5	Enterprise	5	update	\N	---\nid: 5\nname: Dargle Real Foods\ndescription: A hub for produce from the Dargle Valley and surrounds\nlong_description: The Dargle valley in the KwaZulu-Natal Midlands is known for fine\n  produce, magnificent scenery and friendly people. We supply only the finest naturally\n  grown produce from ethical producers in the valley and surrounds.\nis_primary_producer: true\ncontact: Lawrence\nphone: 0824983084\nemail: qholloi@gmail.com\nwebsite: \ntwitter: \nabn: \nacn: \naddress_id: 15\npickup_times: \nnext_collection_at: \ncreated_at: 2015-10-30 06:06:59.635423000 Z\nupdated_at: 2015-10-30 06:16:26.217738000 Z\ndistributor_info: \nlogo_file_name: truffle_logo_180.png\nlogo_content_type: image/png\nlogo_file_size: 40701\nlogo_updated_at: 2015-10-30 06:09:26.496584000 Z\npromo_image_file_name: valley.jpg\npromo_image_content_type: image/jpeg\npromo_image_file_size: 97672\npromo_image_updated_at: 2015-10-30 06:15:57.943379000 Z\nvisible: false\nfacebook: \ninstagram: \nlinkedin: \nowner_id: 14\nsells: unspecified\nconfirmation_token: \nconfirmed_at: 2015-10-30 06:16:26.216042000 Z\nconfirmation_sent_at: 2015-10-30 06:06:59.634827000 Z\nunconfirmed_email: \nshop_trial_start_date: \nproducer_profile_only: false\npermalink: dargle-real-foods\ncharges_sales_tax: false\norigin_code: \n	2015-11-02 09:11:55.35227
\.


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ofn
--

SELECT pg_catalog.setval('versions_id_seq', 5, true);


--
-- Name: account_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY account_invoices
    ADD CONSTRAINT account_invoices_pkey PRIMARY KEY (id);


--
-- Name: adjustment_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY adjustment_metadata
    ADD CONSTRAINT adjustment_metadata_pkey PRIMARY KEY (id);


--
-- Name: billable_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY billable_periods
    ADD CONSTRAINT billable_periods_pkey PRIMARY KEY (id);


--
-- Name: carts_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: cms_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_blocks
    ADD CONSTRAINT cms_blocks_pkey PRIMARY KEY (id);


--
-- Name: cms_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_categories
    ADD CONSTRAINT cms_categories_pkey PRIMARY KEY (id);


--
-- Name: cms_categorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_categorizations
    ADD CONSTRAINT cms_categorizations_pkey PRIMARY KEY (id);


--
-- Name: cms_files_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_files
    ADD CONSTRAINT cms_files_pkey PRIMARY KEY (id);


--
-- Name: cms_layouts_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_layouts
    ADD CONSTRAINT cms_layouts_pkey PRIMARY KEY (id);


--
-- Name: cms_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_pages
    ADD CONSTRAINT cms_pages_pkey PRIMARY KEY (id);


--
-- Name: cms_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_revisions
    ADD CONSTRAINT cms_revisions_pkey PRIMARY KEY (id);


--
-- Name: cms_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_sites
    ADD CONSTRAINT cms_sites_pkey PRIMARY KEY (id);


--
-- Name: cms_snippets_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY cms_snippets
    ADD CONSTRAINT cms_snippets_pkey PRIMARY KEY (id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: distributors_shipping_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY distributors_shipping_methods
    ADD CONSTRAINT distributors_shipping_methods_pkey PRIMARY KEY (id);


--
-- Name: enterprise_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprise_fees
    ADD CONSTRAINT enterprise_fees_pkey PRIMARY KEY (id);


--
-- Name: enterprise_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprise_groups
    ADD CONSTRAINT enterprise_groups_pkey PRIMARY KEY (id);


--
-- Name: enterprise_relationship_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprise_relationship_permissions
    ADD CONSTRAINT enterprise_relationship_permissions_pkey PRIMARY KEY (id);


--
-- Name: enterprise_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprise_relationships
    ADD CONSTRAINT enterprise_relationships_pkey PRIMARY KEY (id);


--
-- Name: enterprise_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprise_roles
    ADD CONSTRAINT enterprise_roles_pkey PRIMARY KEY (id);


--
-- Name: enterprises_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY enterprises
    ADD CONSTRAINT enterprises_pkey PRIMARY KEY (id);


--
-- Name: exchange_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY exchange_fees
    ADD CONSTRAINT exchange_fees_pkey PRIMARY KEY (id);


--
-- Name: exchange_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY exchange_variants
    ADD CONSTRAINT exchange_variants_pkey PRIMARY KEY (id);


--
-- Name: exchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_pkey PRIMARY KEY (id);


--
-- Name: order_cycles_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY order_cycles
    ADD CONSTRAINT order_cycles_pkey PRIMARY KEY (id);


--
-- Name: producer_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY producer_properties
    ADD CONSTRAINT producer_properties_pkey PRIMARY KEY (id);


--
-- Name: product_distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY product_distributions
    ADD CONSTRAINT product_distributions_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: spree_activators_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_activators
    ADD CONSTRAINT spree_activators_pkey PRIMARY KEY (id);


--
-- Name: spree_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_addresses
    ADD CONSTRAINT spree_addresses_pkey PRIMARY KEY (id);


--
-- Name: spree_adjustments_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_adjustments
    ADD CONSTRAINT spree_adjustments_pkey PRIMARY KEY (id);


--
-- Name: spree_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_assets
    ADD CONSTRAINT spree_assets_pkey PRIMARY KEY (id);


--
-- Name: spree_calculators_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_calculators
    ADD CONSTRAINT spree_calculators_pkey PRIMARY KEY (id);


--
-- Name: spree_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_configurations
    ADD CONSTRAINT spree_configurations_pkey PRIMARY KEY (id);


--
-- Name: spree_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_countries
    ADD CONSTRAINT spree_countries_pkey PRIMARY KEY (id);


--
-- Name: spree_credit_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_credit_cards
    ADD CONSTRAINT spree_credit_cards_pkey PRIMARY KEY (id);


--
-- Name: spree_gateways_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_gateways
    ADD CONSTRAINT spree_gateways_pkey PRIMARY KEY (id);


--
-- Name: spree_inventory_units_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_inventory_units
    ADD CONSTRAINT spree_inventory_units_pkey PRIMARY KEY (id);


--
-- Name: spree_line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_line_items
    ADD CONSTRAINT spree_line_items_pkey PRIMARY KEY (id);


--
-- Name: spree_log_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_log_entries
    ADD CONSTRAINT spree_log_entries_pkey PRIMARY KEY (id);


--
-- Name: spree_mail_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_mail_methods
    ADD CONSTRAINT spree_mail_methods_pkey PRIMARY KEY (id);


--
-- Name: spree_option_types_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_option_types
    ADD CONSTRAINT spree_option_types_pkey PRIMARY KEY (id);


--
-- Name: spree_option_values_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_option_values
    ADD CONSTRAINT spree_option_values_pkey PRIMARY KEY (id);


--
-- Name: spree_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_pkey PRIMARY KEY (id);


--
-- Name: spree_payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_payment_methods
    ADD CONSTRAINT spree_payment_methods_pkey PRIMARY KEY (id);


--
-- Name: spree_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_payments
    ADD CONSTRAINT spree_payments_pkey PRIMARY KEY (id);


--
-- Name: spree_paypal_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_paypal_accounts
    ADD CONSTRAINT spree_paypal_accounts_pkey PRIMARY KEY (id);


--
-- Name: spree_paypal_express_checkouts_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_paypal_express_checkouts
    ADD CONSTRAINT spree_paypal_express_checkouts_pkey PRIMARY KEY (id);


--
-- Name: spree_pending_promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_pending_promotions
    ADD CONSTRAINT spree_pending_promotions_pkey PRIMARY KEY (id);


--
-- Name: spree_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_preferences
    ADD CONSTRAINT spree_preferences_pkey PRIMARY KEY (id);


--
-- Name: spree_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_prices
    ADD CONSTRAINT spree_prices_pkey PRIMARY KEY (id);


--
-- Name: spree_product_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_product_groups
    ADD CONSTRAINT spree_product_groups_pkey PRIMARY KEY (id);


--
-- Name: spree_product_option_types_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_product_option_types
    ADD CONSTRAINT spree_product_option_types_pkey PRIMARY KEY (id);


--
-- Name: spree_product_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_product_properties
    ADD CONSTRAINT spree_product_properties_pkey PRIMARY KEY (id);


--
-- Name: spree_product_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_product_scopes
    ADD CONSTRAINT spree_product_scopes_pkey PRIMARY KEY (id);


--
-- Name: spree_products_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_products
    ADD CONSTRAINT spree_products_pkey PRIMARY KEY (id);


--
-- Name: spree_products_taxons_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_products_taxons
    ADD CONSTRAINT spree_products_taxons_pkey PRIMARY KEY (id);


--
-- Name: spree_promotion_action_line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_promotion_action_line_items
    ADD CONSTRAINT spree_promotion_action_line_items_pkey PRIMARY KEY (id);


--
-- Name: spree_promotion_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_promotion_actions
    ADD CONSTRAINT spree_promotion_actions_pkey PRIMARY KEY (id);


--
-- Name: spree_promotion_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_promotion_rules
    ADD CONSTRAINT spree_promotion_rules_pkey PRIMARY KEY (id);


--
-- Name: spree_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_properties
    ADD CONSTRAINT spree_properties_pkey PRIMARY KEY (id);


--
-- Name: spree_prototypes_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_prototypes
    ADD CONSTRAINT spree_prototypes_pkey PRIMARY KEY (id);


--
-- Name: spree_return_authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_return_authorizations
    ADD CONSTRAINT spree_return_authorizations_pkey PRIMARY KEY (id);


--
-- Name: spree_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_roles
    ADD CONSTRAINT spree_roles_pkey PRIMARY KEY (id);


--
-- Name: spree_shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_shipments
    ADD CONSTRAINT spree_shipments_pkey PRIMARY KEY (id);


--
-- Name: spree_shipping_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_shipping_categories
    ADD CONSTRAINT spree_shipping_categories_pkey PRIMARY KEY (id);


--
-- Name: spree_shipping_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_shipping_methods
    ADD CONSTRAINT spree_shipping_methods_pkey PRIMARY KEY (id);


--
-- Name: spree_skrill_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_skrill_transactions
    ADD CONSTRAINT spree_skrill_transactions_pkey PRIMARY KEY (id);


--
-- Name: spree_state_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_state_changes
    ADD CONSTRAINT spree_state_changes_pkey PRIMARY KEY (id);


--
-- Name: spree_states_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_states
    ADD CONSTRAINT spree_states_pkey PRIMARY KEY (id);


--
-- Name: spree_tax_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_tax_categories
    ADD CONSTRAINT spree_tax_categories_pkey PRIMARY KEY (id);


--
-- Name: spree_tax_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_tax_rates
    ADD CONSTRAINT spree_tax_rates_pkey PRIMARY KEY (id);


--
-- Name: spree_taxonomies_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_taxonomies
    ADD CONSTRAINT spree_taxonomies_pkey PRIMARY KEY (id);


--
-- Name: spree_taxons_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_taxons
    ADD CONSTRAINT spree_taxons_pkey PRIMARY KEY (id);


--
-- Name: spree_tokenized_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_tokenized_permissions
    ADD CONSTRAINT spree_tokenized_permissions_pkey PRIMARY KEY (id);


--
-- Name: spree_trackers_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_trackers
    ADD CONSTRAINT spree_trackers_pkey PRIMARY KEY (id);


--
-- Name: spree_users_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_users
    ADD CONSTRAINT spree_users_pkey PRIMARY KEY (id);


--
-- Name: spree_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_variants
    ADD CONSTRAINT spree_variants_pkey PRIMARY KEY (id);


--
-- Name: spree_zone_members_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_zone_members
    ADD CONSTRAINT spree_zone_members_pkey PRIMARY KEY (id);


--
-- Name: spree_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY spree_zones
    ADD CONSTRAINT spree_zones_pkey PRIMARY KEY (id);


--
-- Name: suburbs_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY suburbs
    ADD CONSTRAINT suburbs_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: variant_overrides_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY variant_overrides
    ADD CONSTRAINT variant_overrides_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: ofn; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: email_idx_unique; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX email_idx_unique ON spree_users USING btree (email);


--
-- Name: index_account_invoices_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_account_invoices_on_order_id ON account_invoices USING btree (order_id);


--
-- Name: index_account_invoices_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_account_invoices_on_user_id ON account_invoices USING btree (user_id);


--
-- Name: index_addresses_on_firstname; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_addresses_on_firstname ON spree_addresses USING btree (firstname);


--
-- Name: index_addresses_on_lastname; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_addresses_on_lastname ON spree_addresses USING btree (lastname);


--
-- Name: index_adjustment_metadata_on_adjustment_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_adjustment_metadata_on_adjustment_id ON adjustment_metadata USING btree (adjustment_id);


--
-- Name: index_adjustment_metadata_on_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_adjustment_metadata_on_enterprise_id ON adjustment_metadata USING btree (enterprise_id);


--
-- Name: index_adjustments_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_adjustments_on_order_id ON spree_adjustments USING btree (adjustable_id);


--
-- Name: index_assets_on_viewable_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_assets_on_viewable_id ON spree_assets USING btree (viewable_id);


--
-- Name: index_assets_on_viewable_type_and_type; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_assets_on_viewable_type_and_type ON spree_assets USING btree (viewable_type, type);


--
-- Name: index_billable_periods_on_account_invoice_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_billable_periods_on_account_invoice_id ON billable_periods USING btree (account_invoice_id);


--
-- Name: index_carts_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_carts_on_user_id ON carts USING btree (user_id);


--
-- Name: index_cms_blocks_on_page_id_and_identifier; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_blocks_on_page_id_and_identifier ON cms_blocks USING btree (page_id, identifier);


--
-- Name: index_cms_categories_on_site_id_and_categorized_type_and_label; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_cms_categories_on_site_id_and_categorized_type_and_label ON cms_categories USING btree (site_id, categorized_type, label);


--
-- Name: index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id ON cms_categorizations USING btree (category_id, categorized_type, categorized_id);


--
-- Name: index_cms_files_on_site_id_and_block_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_files_on_site_id_and_block_id ON cms_files USING btree (site_id, block_id);


--
-- Name: index_cms_files_on_site_id_and_file_file_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_files_on_site_id_and_file_file_name ON cms_files USING btree (site_id, file_file_name);


--
-- Name: index_cms_files_on_site_id_and_label; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_files_on_site_id_and_label ON cms_files USING btree (site_id, label);


--
-- Name: index_cms_files_on_site_id_and_position; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_files_on_site_id_and_position ON cms_files USING btree (site_id, "position");


--
-- Name: index_cms_layouts_on_parent_id_and_position; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_layouts_on_parent_id_and_position ON cms_layouts USING btree (parent_id, "position");


--
-- Name: index_cms_layouts_on_site_id_and_identifier; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_cms_layouts_on_site_id_and_identifier ON cms_layouts USING btree (site_id, identifier);


--
-- Name: index_cms_pages_on_parent_id_and_position; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_pages_on_parent_id_and_position ON cms_pages USING btree (parent_id, "position");


--
-- Name: index_cms_pages_on_site_id_and_full_path; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_pages_on_site_id_and_full_path ON cms_pages USING btree (site_id, full_path);


--
-- Name: index_cms_revisions_on_record_type_and_record_id_and_created_at; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_revisions_on_record_type_and_record_id_and_created_at ON cms_revisions USING btree (record_type, record_id, created_at);


--
-- Name: index_cms_sites_on_hostname; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_sites_on_hostname ON cms_sites USING btree (hostname);


--
-- Name: index_cms_sites_on_is_mirrored; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_sites_on_is_mirrored ON cms_sites USING btree (is_mirrored);


--
-- Name: index_cms_snippets_on_site_id_and_identifier; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_cms_snippets_on_site_id_and_identifier ON cms_snippets USING btree (site_id, identifier);


--
-- Name: index_cms_snippets_on_site_id_and_position; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_cms_snippets_on_site_id_and_position ON cms_snippets USING btree (site_id, "position");


--
-- Name: index_configurations_on_name_and_type; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_configurations_on_name_and_type ON spree_configurations USING btree (name, type);


--
-- Name: index_coordinator_fees_on_enterprise_fee_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_coordinator_fees_on_enterprise_fee_id ON coordinator_fees USING btree (enterprise_fee_id);


--
-- Name: index_coordinator_fees_on_order_cycle_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_coordinator_fees_on_order_cycle_id ON coordinator_fees USING btree (order_cycle_id);


--
-- Name: index_customers_on_email; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_customers_on_email ON customers USING btree (email);


--
-- Name: index_customers_on_enterprise_id_and_code; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_customers_on_enterprise_id_and_code ON customers USING btree (enterprise_id, code);


--
-- Name: index_customers_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_customers_on_user_id ON customers USING btree (user_id);


--
-- Name: index_distributors_payment_methods_on_distributor_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_distributors_payment_methods_on_distributor_id ON distributors_payment_methods USING btree (distributor_id);


--
-- Name: index_distributors_payment_methods_on_payment_method_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_distributors_payment_methods_on_payment_method_id ON distributors_payment_methods USING btree (payment_method_id);


--
-- Name: index_distributors_shipping_methods_on_distributor_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_distributors_shipping_methods_on_distributor_id ON distributors_shipping_methods USING btree (distributor_id);


--
-- Name: index_distributors_shipping_methods_on_shipping_method_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_distributors_shipping_methods_on_shipping_method_id ON distributors_shipping_methods USING btree (shipping_method_id);


--
-- Name: index_enterprise_fees_on_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_fees_on_enterprise_id ON enterprise_fees USING btree (enterprise_id);


--
-- Name: index_enterprise_fees_on_tax_category_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_fees_on_tax_category_id ON enterprise_fees USING btree (tax_category_id);


--
-- Name: index_enterprise_groups_enterprises_on_enterprise_group_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_groups_enterprises_on_enterprise_group_id ON enterprise_groups_enterprises USING btree (enterprise_group_id);


--
-- Name: index_enterprise_groups_enterprises_on_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_groups_enterprises_on_enterprise_id ON enterprise_groups_enterprises USING btree (enterprise_id);


--
-- Name: index_enterprise_groups_on_address_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_groups_on_address_id ON enterprise_groups USING btree (address_id);


--
-- Name: index_enterprise_groups_on_owner_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_groups_on_owner_id ON enterprise_groups USING btree (owner_id);


--
-- Name: index_enterprise_groups_on_permalink; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprise_groups_on_permalink ON enterprise_groups USING btree (permalink);


--
-- Name: index_enterprise_relationships_on_child_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_relationships_on_child_id ON enterprise_relationships USING btree (child_id);


--
-- Name: index_enterprise_relationships_on_parent_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_relationships_on_parent_id ON enterprise_relationships USING btree (parent_id);


--
-- Name: index_enterprise_relationships_on_parent_id_and_child_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprise_relationships_on_parent_id_and_child_id ON enterprise_relationships USING btree (parent_id, child_id);


--
-- Name: index_enterprise_roles_on_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_roles_on_enterprise_id ON enterprise_roles USING btree (enterprise_id);


--
-- Name: index_enterprise_roles_on_enterprise_id_and_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprise_roles_on_enterprise_id_and_user_id ON enterprise_roles USING btree (enterprise_id, user_id);


--
-- Name: index_enterprise_roles_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprise_roles_on_user_id ON enterprise_roles USING btree (user_id);


--
-- Name: index_enterprise_roles_on_user_id_and_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprise_roles_on_user_id_and_enterprise_id ON enterprise_roles USING btree (user_id, enterprise_id);


--
-- Name: index_enterprises_on_address_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprises_on_address_id ON enterprises USING btree (address_id);


--
-- Name: index_enterprises_on_confirmation_token; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprises_on_confirmation_token ON enterprises USING btree (confirmation_token);


--
-- Name: index_enterprises_on_is_primary_producer_and_sells; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprises_on_is_primary_producer_and_sells ON enterprises USING btree (is_primary_producer, sells);


--
-- Name: index_enterprises_on_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprises_on_name ON enterprises USING btree (name);


--
-- Name: index_enterprises_on_owner_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprises_on_owner_id ON enterprises USING btree (owner_id);


--
-- Name: index_enterprises_on_permalink; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_enterprises_on_permalink ON enterprises USING btree (permalink);


--
-- Name: index_enterprises_on_sells; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_enterprises_on_sells ON enterprises USING btree (sells);


--
-- Name: index_erp_on_erid; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_erp_on_erid ON enterprise_relationship_permissions USING btree (enterprise_relationship_id);


--
-- Name: index_exchange_fees_on_enterprise_fee_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchange_fees_on_enterprise_fee_id ON exchange_fees USING btree (enterprise_fee_id);


--
-- Name: index_exchange_fees_on_exchange_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchange_fees_on_exchange_id ON exchange_fees USING btree (exchange_id);


--
-- Name: index_exchange_variants_on_exchange_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchange_variants_on_exchange_id ON exchange_variants USING btree (exchange_id);


--
-- Name: index_exchange_variants_on_variant_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchange_variants_on_variant_id ON exchange_variants USING btree (variant_id);


--
-- Name: index_exchanges_on_order_cycle_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchanges_on_order_cycle_id ON exchanges USING btree (order_cycle_id);


--
-- Name: index_exchanges_on_payment_enterprise_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchanges_on_payment_enterprise_id ON exchanges USING btree (payment_enterprise_id);


--
-- Name: index_exchanges_on_receiver_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchanges_on_receiver_id ON exchanges USING btree (receiver_id);


--
-- Name: index_exchanges_on_sender_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_exchanges_on_sender_id ON exchanges USING btree (sender_id);


--
-- Name: index_inventory_units_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_inventory_units_on_order_id ON spree_inventory_units USING btree (order_id);


--
-- Name: index_inventory_units_on_shipment_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_inventory_units_on_shipment_id ON spree_inventory_units USING btree (shipment_id);


--
-- Name: index_inventory_units_on_variant_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_inventory_units_on_variant_id ON spree_inventory_units USING btree (variant_id);


--
-- Name: index_line_items_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_line_items_on_order_id ON spree_line_items USING btree (order_id);


--
-- Name: index_line_items_on_variant_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_line_items_on_variant_id ON spree_line_items USING btree (variant_id);


--
-- Name: index_option_values_variants_on_variant_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_option_values_variants_on_variant_id ON spree_option_values_variants USING btree (variant_id);


--
-- Name: index_option_values_variants_on_variant_id_and_option_value_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_option_values_variants_on_variant_id_and_option_value_id ON spree_option_values_variants USING btree (variant_id, option_value_id);


--
-- Name: index_orders_on_number; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_orders_on_number ON spree_orders USING btree (number);


--
-- Name: index_producer_properties_on_position; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_producer_properties_on_position ON producer_properties USING btree ("position");


--
-- Name: index_producer_properties_on_producer_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_producer_properties_on_producer_id ON producer_properties USING btree (producer_id);


--
-- Name: index_producer_properties_on_property_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_producer_properties_on_property_id ON producer_properties USING btree (property_id);


--
-- Name: index_product_distributions_on_distributor_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_distributions_on_distributor_id ON product_distributions USING btree (distributor_id);


--
-- Name: index_product_distributions_on_enterprise_fee_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_distributions_on_enterprise_fee_id ON product_distributions USING btree (enterprise_fee_id);


--
-- Name: index_product_distributions_on_product_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_distributions_on_product_id ON product_distributions USING btree (product_id);


--
-- Name: index_product_groups_on_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_groups_on_name ON spree_product_groups USING btree (name);


--
-- Name: index_product_groups_on_permalink; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_groups_on_permalink ON spree_product_groups USING btree (permalink);


--
-- Name: index_product_properties_on_product_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_properties_on_product_id ON spree_product_properties USING btree (product_id);


--
-- Name: index_product_scopes_on_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_scopes_on_name ON spree_product_scopes USING btree (name);


--
-- Name: index_product_scopes_on_product_group_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_product_scopes_on_product_group_id ON spree_product_scopes USING btree (product_group_id);


--
-- Name: index_products_on_available_on; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_on_available_on ON spree_products USING btree (available_on);


--
-- Name: index_products_on_deleted_at; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_on_deleted_at ON spree_products USING btree (deleted_at);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_on_name ON spree_products USING btree (name);


--
-- Name: index_products_on_permalink; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_on_permalink ON spree_products USING btree (permalink);


--
-- Name: index_products_promotion_rules_on_product_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_promotion_rules_on_product_id ON spree_products_promotion_rules USING btree (product_id);


--
-- Name: index_products_promotion_rules_on_promotion_rule_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_promotion_rules_on_promotion_rule_id ON spree_products_promotion_rules USING btree (promotion_rule_id);


--
-- Name: index_products_taxons_on_product_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_taxons_on_product_id ON spree_products_taxons USING btree (product_id);


--
-- Name: index_products_taxons_on_taxon_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_products_taxons_on_taxon_id ON spree_products_taxons USING btree (taxon_id);


--
-- Name: index_promotion_rules_on_product_group_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_promotion_rules_on_product_group_id ON spree_promotion_rules USING btree (product_group_id);


--
-- Name: index_promotion_rules_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_promotion_rules_on_user_id ON spree_promotion_rules USING btree (user_id);


--
-- Name: index_promotion_rules_users_on_promotion_rule_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_promotion_rules_users_on_promotion_rule_id ON spree_promotion_rules_users USING btree (promotion_rule_id);


--
-- Name: index_promotion_rules_users_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_promotion_rules_users_on_user_id ON spree_promotion_rules_users USING btree (user_id);


--
-- Name: index_roles_users_on_role_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_roles_users_on_role_id ON spree_roles_users USING btree (role_id);


--
-- Name: index_roles_users_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_roles_users_on_user_id ON spree_roles_users USING btree (user_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_shipments_on_number; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_shipments_on_number ON spree_shipments USING btree (number);


--
-- Name: index_spree_orders_on_customer_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_orders_on_customer_id ON spree_orders USING btree (customer_id);


--
-- Name: index_spree_payments_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_payments_on_order_id ON spree_payments USING btree (order_id);


--
-- Name: index_spree_paypal_express_checkouts_on_transaction_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_paypal_express_checkouts_on_transaction_id ON spree_paypal_express_checkouts USING btree (transaction_id);


--
-- Name: index_spree_pending_promotions_on_promotion_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_pending_promotions_on_promotion_id ON spree_pending_promotions USING btree (promotion_id);


--
-- Name: index_spree_pending_promotions_on_user_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_pending_promotions_on_user_id ON spree_pending_promotions USING btree (user_id);


--
-- Name: index_spree_preferences_on_key; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_spree_preferences_on_key ON spree_preferences USING btree (key);


--
-- Name: index_spree_prices_on_variant_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_prices_on_variant_id ON spree_prices USING btree (variant_id);


--
-- Name: index_spree_products_on_primary_taxon_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_products_on_primary_taxon_id ON spree_products USING btree (primary_taxon_id);


--
-- Name: index_spree_shipments_on_order_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_spree_shipments_on_order_id ON spree_shipments USING btree (order_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_taxons_on_parent_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_taxons_on_parent_id ON spree_taxons USING btree (parent_id);


--
-- Name: index_taxons_on_permalink; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_taxons_on_permalink ON spree_taxons USING btree (permalink);


--
-- Name: index_taxons_on_taxonomy_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_taxons_on_taxonomy_id ON spree_taxons USING btree (taxonomy_id);


--
-- Name: index_tokenized_name_and_type; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_tokenized_name_and_type ON spree_tokenized_permissions USING btree (permissable_id, permissable_type);


--
-- Name: index_users_on_persistence_token; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_users_on_persistence_token ON spree_users USING btree (persistence_token);


--
-- Name: index_variant_overrides_on_variant_id_and_hub_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_variant_overrides_on_variant_id_and_hub_id ON variant_overrides USING btree (variant_id, hub_id);


--
-- Name: index_variants_on_product_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_variants_on_product_id ON spree_variants USING btree (product_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: permalink_idx_unique; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX permalink_idx_unique ON spree_products USING btree (permalink);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX taggings_idx ON taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: ofn; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: account_invoices_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY account_invoices
    ADD CONSTRAINT account_invoices_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: account_invoices_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY account_invoices
    ADD CONSTRAINT account_invoices_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: adjustment_metadata_adjustment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY adjustment_metadata
    ADD CONSTRAINT adjustment_metadata_adjustment_id_fk FOREIGN KEY (adjustment_id) REFERENCES spree_adjustments(id) ON DELETE CASCADE;


--
-- Name: adjustment_metadata_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY adjustment_metadata
    ADD CONSTRAINT adjustment_metadata_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: bill_items_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY billable_periods
    ADD CONSTRAINT bill_items_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: bill_items_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY billable_periods
    ADD CONSTRAINT bill_items_owner_id_fk FOREIGN KEY (owner_id) REFERENCES spree_users(id);


--
-- Name: billable_periods_account_invoice_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY billable_periods
    ADD CONSTRAINT billable_periods_account_invoice_id_fk FOREIGN KEY (account_invoice_id) REFERENCES account_invoices(id);


--
-- Name: carts_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: cms_blocks_page_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_blocks
    ADD CONSTRAINT cms_blocks_page_id_fk FOREIGN KEY (page_id) REFERENCES cms_pages(id);


--
-- Name: cms_categories_site_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_categories
    ADD CONSTRAINT cms_categories_site_id_fk FOREIGN KEY (site_id) REFERENCES cms_sites(id) ON DELETE CASCADE;


--
-- Name: cms_categorizations_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_categorizations
    ADD CONSTRAINT cms_categorizations_category_id_fk FOREIGN KEY (category_id) REFERENCES cms_categories(id);


--
-- Name: cms_files_block_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_files
    ADD CONSTRAINT cms_files_block_id_fk FOREIGN KEY (block_id) REFERENCES cms_blocks(id);


--
-- Name: cms_files_site_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_files
    ADD CONSTRAINT cms_files_site_id_fk FOREIGN KEY (site_id) REFERENCES cms_sites(id);


--
-- Name: cms_layouts_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_layouts
    ADD CONSTRAINT cms_layouts_parent_id_fk FOREIGN KEY (parent_id) REFERENCES cms_layouts(id);


--
-- Name: cms_layouts_site_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_layouts
    ADD CONSTRAINT cms_layouts_site_id_fk FOREIGN KEY (site_id) REFERENCES cms_sites(id) ON DELETE CASCADE;


--
-- Name: cms_pages_layout_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_pages
    ADD CONSTRAINT cms_pages_layout_id_fk FOREIGN KEY (layout_id) REFERENCES cms_layouts(id);


--
-- Name: cms_pages_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_pages
    ADD CONSTRAINT cms_pages_parent_id_fk FOREIGN KEY (parent_id) REFERENCES cms_pages(id);


--
-- Name: cms_pages_site_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_pages
    ADD CONSTRAINT cms_pages_site_id_fk FOREIGN KEY (site_id) REFERENCES cms_sites(id) ON DELETE CASCADE;


--
-- Name: cms_pages_target_page_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_pages
    ADD CONSTRAINT cms_pages_target_page_id_fk FOREIGN KEY (target_page_id) REFERENCES cms_pages(id);


--
-- Name: cms_snippets_site_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY cms_snippets
    ADD CONSTRAINT cms_snippets_site_id_fk FOREIGN KEY (site_id) REFERENCES cms_sites(id) ON DELETE CASCADE;


--
-- Name: coordinator_fees_enterprise_fee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY coordinator_fees
    ADD CONSTRAINT coordinator_fees_enterprise_fee_id_fk FOREIGN KEY (enterprise_fee_id) REFERENCES enterprise_fees(id);


--
-- Name: coordinator_fees_order_cycle_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY coordinator_fees
    ADD CONSTRAINT coordinator_fees_order_cycle_id_fk FOREIGN KEY (order_cycle_id) REFERENCES order_cycles(id);


--
-- Name: customers_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: customers_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: distributors_payment_methods_distributor_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY distributors_payment_methods
    ADD CONSTRAINT distributors_payment_methods_distributor_id_fk FOREIGN KEY (distributor_id) REFERENCES enterprises(id);


--
-- Name: distributors_payment_methods_payment_method_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY distributors_payment_methods
    ADD CONSTRAINT distributors_payment_methods_payment_method_id_fk FOREIGN KEY (payment_method_id) REFERENCES spree_payment_methods(id);


--
-- Name: distributors_shipping_methods_distributor_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY distributors_shipping_methods
    ADD CONSTRAINT distributors_shipping_methods_distributor_id_fk FOREIGN KEY (distributor_id) REFERENCES enterprises(id);


--
-- Name: distributors_shipping_methods_shipping_method_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY distributors_shipping_methods
    ADD CONSTRAINT distributors_shipping_methods_shipping_method_id_fk FOREIGN KEY (shipping_method_id) REFERENCES spree_shipping_methods(id);


--
-- Name: enterprise_fees_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_fees
    ADD CONSTRAINT enterprise_fees_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: enterprise_fees_tax_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_fees
    ADD CONSTRAINT enterprise_fees_tax_category_id_fk FOREIGN KEY (tax_category_id) REFERENCES spree_tax_categories(id);


--
-- Name: enterprise_groups_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_groups
    ADD CONSTRAINT enterprise_groups_address_id_fk FOREIGN KEY (address_id) REFERENCES spree_addresses(id);


--
-- Name: enterprise_groups_enterprises_enterprise_group_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_groups_enterprises
    ADD CONSTRAINT enterprise_groups_enterprises_enterprise_group_id_fk FOREIGN KEY (enterprise_group_id) REFERENCES enterprise_groups(id);


--
-- Name: enterprise_groups_enterprises_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_groups_enterprises
    ADD CONSTRAINT enterprise_groups_enterprises_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: enterprise_groups_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_groups
    ADD CONSTRAINT enterprise_groups_owner_id_fk FOREIGN KEY (owner_id) REFERENCES spree_users(id);


--
-- Name: enterprise_relationships_child_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_relationships
    ADD CONSTRAINT enterprise_relationships_child_id_fk FOREIGN KEY (child_id) REFERENCES enterprises(id);


--
-- Name: enterprise_relationships_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_relationships
    ADD CONSTRAINT enterprise_relationships_parent_id_fk FOREIGN KEY (parent_id) REFERENCES enterprises(id);


--
-- Name: enterprise_roles_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_roles
    ADD CONSTRAINT enterprise_roles_enterprise_id_fk FOREIGN KEY (enterprise_id) REFERENCES enterprises(id);


--
-- Name: enterprise_roles_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_roles
    ADD CONSTRAINT enterprise_roles_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: enterprises_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprises
    ADD CONSTRAINT enterprises_address_id_fk FOREIGN KEY (address_id) REFERENCES spree_addresses(id);


--
-- Name: enterprises_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprises
    ADD CONSTRAINT enterprises_owner_id_fk FOREIGN KEY (owner_id) REFERENCES spree_users(id);


--
-- Name: erp_enterprise_relationship_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY enterprise_relationship_permissions
    ADD CONSTRAINT erp_enterprise_relationship_id_fk FOREIGN KEY (enterprise_relationship_id) REFERENCES enterprise_relationships(id);


--
-- Name: exchange_fees_enterprise_fee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_fees
    ADD CONSTRAINT exchange_fees_enterprise_fee_id_fk FOREIGN KEY (enterprise_fee_id) REFERENCES enterprise_fees(id);


--
-- Name: exchange_fees_exchange_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_fees
    ADD CONSTRAINT exchange_fees_exchange_id_fk FOREIGN KEY (exchange_id) REFERENCES exchanges(id);


--
-- Name: exchange_variants_exchange_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_variants
    ADD CONSTRAINT exchange_variants_exchange_id_fk FOREIGN KEY (exchange_id) REFERENCES exchanges(id);


--
-- Name: exchange_variants_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchange_variants
    ADD CONSTRAINT exchange_variants_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: exchanges_order_cycle_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_order_cycle_id_fk FOREIGN KEY (order_cycle_id) REFERENCES order_cycles(id);


--
-- Name: exchanges_payment_enterprise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_payment_enterprise_id_fk FOREIGN KEY (payment_enterprise_id) REFERENCES enterprises(id);


--
-- Name: exchanges_receiver_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_receiver_id_fk FOREIGN KEY (receiver_id) REFERENCES enterprises(id);


--
-- Name: exchanges_sender_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_sender_id_fk FOREIGN KEY (sender_id) REFERENCES enterprises(id);


--
-- Name: order_cycles_coordinator_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY order_cycles
    ADD CONSTRAINT order_cycles_coordinator_id_fk FOREIGN KEY (coordinator_id) REFERENCES enterprises(id);


--
-- Name: producer_properties_producer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY producer_properties
    ADD CONSTRAINT producer_properties_producer_id_fk FOREIGN KEY (producer_id) REFERENCES enterprises(id);


--
-- Name: producer_properties_property_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY producer_properties
    ADD CONSTRAINT producer_properties_property_id_fk FOREIGN KEY (property_id) REFERENCES spree_properties(id);


--
-- Name: product_distributions_distributor_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY product_distributions
    ADD CONSTRAINT product_distributions_distributor_id_fk FOREIGN KEY (distributor_id) REFERENCES enterprises(id);


--
-- Name: product_distributions_enterprise_fee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY product_distributions
    ADD CONSTRAINT product_distributions_enterprise_fee_id_fk FOREIGN KEY (enterprise_fee_id) REFERENCES enterprise_fees(id);


--
-- Name: product_distributions_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY product_distributions
    ADD CONSTRAINT product_distributions_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id);


--
-- Name: spree_addresses_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_addresses
    ADD CONSTRAINT spree_addresses_country_id_fk FOREIGN KEY (country_id) REFERENCES spree_countries(id);


--
-- Name: spree_addresses_state_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_addresses
    ADD CONSTRAINT spree_addresses_state_id_fk FOREIGN KEY (state_id) REFERENCES spree_states(id);


--
-- Name: spree_inventory_units_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_inventory_units
    ADD CONSTRAINT spree_inventory_units_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: spree_inventory_units_return_authorization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_inventory_units
    ADD CONSTRAINT spree_inventory_units_return_authorization_id_fk FOREIGN KEY (return_authorization_id) REFERENCES spree_return_authorizations(id);


--
-- Name: spree_inventory_units_shipment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_inventory_units
    ADD CONSTRAINT spree_inventory_units_shipment_id_fk FOREIGN KEY (shipment_id) REFERENCES spree_shipments(id);


--
-- Name: spree_inventory_units_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_inventory_units
    ADD CONSTRAINT spree_inventory_units_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: spree_line_items_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_line_items
    ADD CONSTRAINT spree_line_items_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: spree_line_items_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_line_items
    ADD CONSTRAINT spree_line_items_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: spree_option_types_prototypes_option_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_types_prototypes
    ADD CONSTRAINT spree_option_types_prototypes_option_type_id_fk FOREIGN KEY (option_type_id) REFERENCES spree_option_types(id);


--
-- Name: spree_option_types_prototypes_prototype_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_types_prototypes
    ADD CONSTRAINT spree_option_types_prototypes_prototype_id_fk FOREIGN KEY (prototype_id) REFERENCES spree_prototypes(id);


--
-- Name: spree_option_values_option_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_values
    ADD CONSTRAINT spree_option_values_option_type_id_fk FOREIGN KEY (option_type_id) REFERENCES spree_option_types(id);


--
-- Name: spree_option_values_variants_option_value_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_values_variants
    ADD CONSTRAINT spree_option_values_variants_option_value_id_fk FOREIGN KEY (option_value_id) REFERENCES spree_option_values(id);


--
-- Name: spree_option_values_variants_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_option_values_variants
    ADD CONSTRAINT spree_option_values_variants_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: spree_orders_bill_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_bill_address_id_fk FOREIGN KEY (bill_address_id) REFERENCES spree_addresses(id);


--
-- Name: spree_orders_cart_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_cart_id_fk FOREIGN KEY (cart_id) REFERENCES carts(id);


--
-- Name: spree_orders_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customers(id);


--
-- Name: spree_orders_distributor_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_distributor_id_fk FOREIGN KEY (distributor_id) REFERENCES enterprises(id);


--
-- Name: spree_orders_order_cycle_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_order_cycle_id_fk FOREIGN KEY (order_cycle_id) REFERENCES order_cycles(id);


--
-- Name: spree_orders_ship_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_ship_address_id_fk FOREIGN KEY (ship_address_id) REFERENCES spree_addresses(id);


--
-- Name: spree_orders_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_orders
    ADD CONSTRAINT spree_orders_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: spree_payments_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_payments
    ADD CONSTRAINT spree_payments_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: spree_payments_payment_method_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_payments
    ADD CONSTRAINT spree_payments_payment_method_id_fk FOREIGN KEY (payment_method_id) REFERENCES spree_payment_methods(id);


--
-- Name: spree_prices_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_prices
    ADD CONSTRAINT spree_prices_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: spree_product_option_types_option_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_option_types
    ADD CONSTRAINT spree_product_option_types_option_type_id_fk FOREIGN KEY (option_type_id) REFERENCES spree_option_types(id);


--
-- Name: spree_product_option_types_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_option_types
    ADD CONSTRAINT spree_product_option_types_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id);


--
-- Name: spree_product_properties_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_properties
    ADD CONSTRAINT spree_product_properties_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id);


--
-- Name: spree_product_properties_property_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_product_properties
    ADD CONSTRAINT spree_product_properties_property_id_fk FOREIGN KEY (property_id) REFERENCES spree_properties(id);


--
-- Name: spree_products_primary_taxon_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products
    ADD CONSTRAINT spree_products_primary_taxon_id_fk FOREIGN KEY (primary_taxon_id) REFERENCES spree_taxons(id);


--
-- Name: spree_products_promotion_rules_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products_promotion_rules
    ADD CONSTRAINT spree_products_promotion_rules_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id);


--
-- Name: spree_products_promotion_rules_promotion_rule_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products_promotion_rules
    ADD CONSTRAINT spree_products_promotion_rules_promotion_rule_id_fk FOREIGN KEY (promotion_rule_id) REFERENCES spree_promotion_rules(id);


--
-- Name: spree_products_shipping_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products
    ADD CONSTRAINT spree_products_shipping_category_id_fk FOREIGN KEY (shipping_category_id) REFERENCES spree_shipping_categories(id);


--
-- Name: spree_products_supplier_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products
    ADD CONSTRAINT spree_products_supplier_id_fk FOREIGN KEY (supplier_id) REFERENCES enterprises(id);


--
-- Name: spree_products_tax_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products
    ADD CONSTRAINT spree_products_tax_category_id_fk FOREIGN KEY (tax_category_id) REFERENCES spree_tax_categories(id);


--
-- Name: spree_products_taxons_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products_taxons
    ADD CONSTRAINT spree_products_taxons_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id) ON DELETE CASCADE;


--
-- Name: spree_products_taxons_taxon_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_products_taxons
    ADD CONSTRAINT spree_products_taxons_taxon_id_fk FOREIGN KEY (taxon_id) REFERENCES spree_taxons(id) ON DELETE CASCADE;


--
-- Name: spree_promotion_action_line_items_promotion_action_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_action_line_items
    ADD CONSTRAINT spree_promotion_action_line_items_promotion_action_id_fk FOREIGN KEY (promotion_action_id) REFERENCES spree_promotion_actions(id);


--
-- Name: spree_promotion_action_line_items_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_action_line_items
    ADD CONSTRAINT spree_promotion_action_line_items_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


--
-- Name: spree_promotion_actions_activator_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_actions
    ADD CONSTRAINT spree_promotion_actions_activator_id_fk FOREIGN KEY (activator_id) REFERENCES spree_activators(id);


--
-- Name: spree_promotion_rules_activator_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_promotion_rules
    ADD CONSTRAINT spree_promotion_rules_activator_id_fk FOREIGN KEY (activator_id) REFERENCES spree_activators(id);


--
-- Name: spree_properties_prototypes_property_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_properties_prototypes
    ADD CONSTRAINT spree_properties_prototypes_property_id_fk FOREIGN KEY (property_id) REFERENCES spree_properties(id);


--
-- Name: spree_properties_prototypes_prototype_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_properties_prototypes
    ADD CONSTRAINT spree_properties_prototypes_prototype_id_fk FOREIGN KEY (prototype_id) REFERENCES spree_prototypes(id);


--
-- Name: spree_return_authorizations_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_return_authorizations
    ADD CONSTRAINT spree_return_authorizations_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: spree_roles_users_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_roles_users
    ADD CONSTRAINT spree_roles_users_role_id_fk FOREIGN KEY (role_id) REFERENCES spree_roles(id);


--
-- Name: spree_roles_users_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_roles_users
    ADD CONSTRAINT spree_roles_users_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: spree_shipments_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipments
    ADD CONSTRAINT spree_shipments_address_id_fk FOREIGN KEY (address_id) REFERENCES spree_addresses(id);


--
-- Name: spree_shipments_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipments
    ADD CONSTRAINT spree_shipments_order_id_fk FOREIGN KEY (order_id) REFERENCES spree_orders(id);


--
-- Name: spree_shipping_methods_shipping_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipping_methods
    ADD CONSTRAINT spree_shipping_methods_shipping_category_id_fk FOREIGN KEY (shipping_category_id) REFERENCES spree_shipping_categories(id);


--
-- Name: spree_shipping_methods_zone_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_shipping_methods
    ADD CONSTRAINT spree_shipping_methods_zone_id_fk FOREIGN KEY (zone_id) REFERENCES spree_zones(id);


--
-- Name: spree_state_changes_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_state_changes
    ADD CONSTRAINT spree_state_changes_user_id_fk FOREIGN KEY (user_id) REFERENCES spree_users(id);


--
-- Name: spree_states_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_states
    ADD CONSTRAINT spree_states_country_id_fk FOREIGN KEY (country_id) REFERENCES spree_countries(id);


--
-- Name: spree_tax_rates_tax_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_tax_rates
    ADD CONSTRAINT spree_tax_rates_tax_category_id_fk FOREIGN KEY (tax_category_id) REFERENCES spree_tax_categories(id);


--
-- Name: spree_tax_rates_zone_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_tax_rates
    ADD CONSTRAINT spree_tax_rates_zone_id_fk FOREIGN KEY (zone_id) REFERENCES spree_zones(id);


--
-- Name: spree_taxons_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_taxons
    ADD CONSTRAINT spree_taxons_parent_id_fk FOREIGN KEY (parent_id) REFERENCES spree_taxons(id);


--
-- Name: spree_taxons_taxonomy_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_taxons
    ADD CONSTRAINT spree_taxons_taxonomy_id_fk FOREIGN KEY (taxonomy_id) REFERENCES spree_taxonomies(id);


--
-- Name: spree_users_bill_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_users
    ADD CONSTRAINT spree_users_bill_address_id_fk FOREIGN KEY (bill_address_id) REFERENCES spree_addresses(id);


--
-- Name: spree_users_ship_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_users
    ADD CONSTRAINT spree_users_ship_address_id_fk FOREIGN KEY (ship_address_id) REFERENCES spree_addresses(id);


--
-- Name: spree_variants_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_variants
    ADD CONSTRAINT spree_variants_product_id_fk FOREIGN KEY (product_id) REFERENCES spree_products(id);


--
-- Name: spree_zone_members_zone_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY spree_zone_members
    ADD CONSTRAINT spree_zone_members_zone_id_fk FOREIGN KEY (zone_id) REFERENCES spree_zones(id);


--
-- Name: suburbs_state_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY suburbs
    ADD CONSTRAINT suburbs_state_id_fk FOREIGN KEY (state_id) REFERENCES spree_states(id);


--
-- Name: variant_overrides_hub_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY variant_overrides
    ADD CONSTRAINT variant_overrides_hub_id_fk FOREIGN KEY (hub_id) REFERENCES enterprises(id);


--
-- Name: variant_overrides_variant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ofn
--

ALTER TABLE ONLY variant_overrides
    ADD CONSTRAINT variant_overrides_variant_id_fk FOREIGN KEY (variant_id) REFERENCES spree_variants(id);


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

