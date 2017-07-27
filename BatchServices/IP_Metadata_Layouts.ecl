IMPORT BatchShare,IP_Metadata;

EXPORT IP_Metadata_Layouts := MODULE

	EXPORT batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING45 IP_Address;
		STRING20 orig_acctno;
	END;

	EXPORT batch_in_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.MAC_ExpandLayout.Generate({batch_in.IP_Address},'',3);
	END;

	EXPORT batch_out_raw := RECORD
		batch_in.IP_Address;
		IP_Metadata.Layout_IP_Metadata.base.ip_rng_beg;
		IP_Metadata.Layout_IP_Metadata.base.ip_rng_end;
		IP_Metadata.Layout_IP_Metadata.base.edge_country;
		IP_Metadata.Layout_IP_Metadata.base.edge_region;
		IP_Metadata.Layout_IP_Metadata.base.edge_city;
		IP_Metadata.Layout_IP_Metadata.base.edge_conn_speed;
		IP_Metadata.Layout_IP_Metadata.base.edge_metro_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_latitude;
		IP_Metadata.Layout_IP_Metadata.base.edge_longitude;
		IP_Metadata.Layout_IP_Metadata.base.edge_postal_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_country_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_region_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_city_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_continent_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_two_letter_country;
		IP_Metadata.Layout_IP_Metadata.base.edge_internal_code;
		IP_Metadata.Layout_IP_Metadata.base.edge_area_codes;
		IP_Metadata.Layout_IP_Metadata.base.edge_country_conf;
		IP_Metadata.Layout_IP_Metadata.base.edge_region_conf;
		IP_Metadata.Layout_IP_Metadata.base.edge_city_conf;
		IP_Metadata.Layout_IP_Metadata.base.edge_postal_conf;
		IP_Metadata.Layout_IP_Metadata.base.edge_gmt_offset;
		IP_Metadata.Layout_IP_Metadata.base.edge_in_dst;
		IP_Metadata.Layout_IP_Metadata.base.sic_code;
		IP_Metadata.Layout_IP_Metadata.base.domain_name;
		IP_Metadata.Layout_IP_Metadata.base.isp_name;
		IP_Metadata.Layout_IP_Metadata.base.homebiz_type;
		IP_Metadata.Layout_IP_Metadata.base.asn;
		IP_Metadata.Layout_IP_Metadata.base.asn_name;
		IP_Metadata.Layout_IP_Metadata.base.primary_lang;
		IP_Metadata.Layout_IP_Metadata.base.secondary_lang;
		IP_Metadata.Layout_IP_Metadata.base.proxy_type;
		IP_Metadata.Layout_IP_Metadata.base.proxy_description;
		IP_Metadata.Layout_IP_Metadata.base.is_an_isp;
		IP_Metadata.Layout_IP_Metadata.base.company_name;
		IP_Metadata.Layout_IP_Metadata.base.ranks;
		IP_Metadata.Layout_IP_Metadata.base.households;
		IP_Metadata.Layout_IP_Metadata.base.women;
		IP_Metadata.Layout_IP_Metadata.base.w18_34;
		IP_Metadata.Layout_IP_Metadata.base.w35_49;
		IP_Metadata.Layout_IP_Metadata.base.men;
		IP_Metadata.Layout_IP_Metadata.base.m18_34;
		IP_Metadata.Layout_IP_Metadata.base.m35_49;
		IP_Metadata.Layout_IP_Metadata.base.teens;
		IP_Metadata.Layout_IP_Metadata.base.kids;
		IP_Metadata.Layout_IP_Metadata.base.naics_code;
		IP_Metadata.Layout_IP_Metadata.base.cbsa_code;
		IP_Metadata.Layout_IP_Metadata.base.cbsa_title;
		IP_Metadata.Layout_IP_Metadata.base.cbsa_type;
		IP_Metadata.Layout_IP_Metadata.base.csa_code;
		IP_Metadata.Layout_IP_Metadata.base.csa_title;
		IP_Metadata.Layout_IP_Metadata.base.md_code;
		IP_Metadata.Layout_IP_Metadata.base.md_title;
		IP_Metadata.Layout_IP_Metadata.base.organization_name;
	END;

	EXPORT batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		batch_out_raw;
		batch_in.orig_acctno;
	END;

	EXPORT batch_out_flat := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.MAC_ExpandLayout.Generate(batch_out_raw,'',3);
	END;

	EXPORT batch_out_flat_acctno := RECORD
		batch_out_flat;
		batch_in.orig_acctno;
	END;

END;