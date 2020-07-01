import dx_ip_metadata;
EXPORT Layout_IP_Metadata := MODULE

	EXPORT Common := RECORD
		string20 ip_rng_beg;
		string20 ip_rng_end;
		string5		edge_country;
		string10	edge_region;
		string60	edge_city;
		string10	edge_conn_speed;
		unsigned	edge_metro_code;
		string10	edge_latitude;
		string10	edge_longitude;
		string10	edge_postal_code;
		unsigned	edge_country_code;
		unsigned	edge_region_code;
		unsigned	edge_city_code;
		unsigned	edge_continent_code;
		string5		edge_two_letter_country;
		unsigned	edge_internal_code;
		string20	edge_area_codes;
		unsigned	edge_country_conf;
		unsigned	edge_region_conf;
		unsigned	edge_city_conf;
		unsigned	edge_postal_conf;
		integer		edge_gmt_offset;
		string5		edge_in_dst;
		string40 edge_timezone_name;
		string10	sic_code;
		string70	domain_name;
		string200	isp_name;
		string10	homebiz_type;
		unsigned	asn;
		string200	asn_name;
		string40	primary_lang;
		string105	secondary_lang;
		string15	proxy_type;
		string15	proxy_description;
		string5		is_an_isp;
		string70	company_name;
		string10	ranks;
		string10	households;
		string10	women;
		string10	w18_34;
		string10	w35_49;
		string10	men;
		string10	m18_34;
		string10	m35_49;
		string10	teens;
		string10	kids;
		unsigned	naics_code;
		unsigned	cbsa_code;
		string55	cbsa_title;
		string10	cbsa_type;
		unsigned	csa_code;
		string55	csa_title;
		unsigned	md_code;
		string55	md_title;
		string100	organization_name;
	END;

	EXPORT Raw := RECORD
		Common - [sic_code];
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT History := RECORD
		Common - [sic_code];
		string255 filename;
	END;

	EXPORT Base := RECORD
	 string8	 dt_first_seen;
		string8  dt_last_seen;
		unsigned beg_octet1;
		unsigned end_octet1;
		unsigned beg_octet2;
		unsigned end_octet2;
		unsigned beg_octets34;
		unsigned end_octets34;
		//Common Layout
		string20 ip_rng_beg;
		string20 ip_rng_end;
		string5		edge_country;
		string10	edge_region;
		string60	edge_city;
		string10	edge_conn_speed;
		unsigned	edge_metro_code;
		string10	edge_latitude;
		string10	edge_longitude;
		string10	edge_postal_code;
		unsigned	edge_country_code;
		unsigned	edge_region_code;
		unsigned	edge_city_code;
		unsigned	edge_continent_code;
		string5		edge_two_letter_country;
		unsigned	edge_internal_code;
		string20	edge_area_codes;
		unsigned	edge_country_conf;
		unsigned	edge_region_conf;
		unsigned	edge_city_conf;
		unsigned	edge_postal_conf;
		integer		edge_gmt_offset;
		string5		edge_in_dst;
		string40 edge_timezone_name;
		string10	sic_code;
		string70	domain_name;
		string200	isp_name;
		string10	homebiz_type;
		unsigned	asn;
		string200	asn_name;
		string40	primary_lang;
		string105	secondary_lang;
		string15	proxy_type;
		string15	proxy_description;
		string5		is_an_isp;
		string70	company_name;
		string10	ranks;
		string10	households;
		string10	women;
		string10	w18_34;
		string10	w35_49;
		string10	men;
		string10	m18_34;
		string10	m35_49;
		string10	teens;
		string10	kids;
		unsigned	naics_code;
		unsigned	cbsa_code;
		string55	cbsa_title;
		string10	cbsa_type;
		unsigned	csa_code;
		string55	csa_title;
		unsigned	md_code;
		string55	md_title;
		string100	organization_name;
		////////////////////////////
		boolean		generated_rec;
		boolean  is_current;
	END;

	export base_in_ipv6 := record
		string39 ip_rng_beg_full;
		string39 ip_rng_end_full;
		string8 dt_first_seen;
		string8 dt_last_seen;
		string39 ip_rng_beg;  // note: revised from ipv4 layout of string20
		string39 ip_rng_end;  // note: revised from ipv4 layout of string20
		string4 beg_hextet1;
		string4 end_hextet1;
		Common;
		boolean generated_rec;
		boolean is_current;
	END;

	export base_ipv6 := dx_ip_metadata.Layout_IP_Metadata.base_ipv6;

	EXPORT Raw_ipv6 := RECORD
		string39 ip_rng_beg;  // note: revised from ipv4 layout of string20
		string39 ip_rng_end;  // note: revised from ipv4 layout of string20
		Common - [sic_code];
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT History_ipv6 := RECORD
		string39 ip_rng_beg;  // note: revised from ipv4 layout of string20
		string39 ip_rng_end;  // note: revised from ipv4 layout of string20
		Common - [sic_code];
		string255 filename;
	END;
END;