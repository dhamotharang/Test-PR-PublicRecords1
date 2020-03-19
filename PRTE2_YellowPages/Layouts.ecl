﻿IMPORT bipv2, address, YellowPages;

EXPORT Layouts := MODULE

	SHARED Addr_Cleaning_Fields := RECORD
		UNSIGNED8 append_rawaid;
		UNSIGNED8 append_aceaid;
		STRING100 prep_addr_line1;
		STRING50 	prep_addr_last_line;
		UNSIGNED8 source_rec_id;
	END;
	
	EXPORT Layout_YellowPages_In := RECORD
		STRING dt_first_seen;
		STRING dt_last_seen;
		STRING dt_vendor_first_reported;
		STRING dt_vendor_last_reported;
		bipv2.IDlayouts.l_xlink_ids;
		INTEGER bdid;
		STRING primary_key;
		STRING business_name;
		STRING orig_street;
		STRING orig_city;
		STRING orig_state;
		STRING orig_zip;
		STRING orig_latitude;
		STRING orig_longitude;
		STRING orig_phone10;
		STRING phone10;
		STRING heading_string;
		STRING sic_code;
		STRING toll_free_indicator;
		STRING fax_indicator;
		STRING pub_date;
		STRING index_value;
		STRING naics_code;
		STRING web_address;
		STRING email_address;
		STRING employee_code;
		STRING executive_title;
		STRING executive_name;
		STRING derog_legal_indicator;
		STRING record_type;
		STRING addr_suffix_flag;
		INTEGER rawaid;
		STRING prim_range;
		STRING predir;
		STRING prim_name;
		STRING suffix;
		STRING postdir;
		STRING unit_desig;
		STRING sec_range;
		STRING p_city_name;
		STRING v_city_name;
		STRING st;
		STRING zip;
		STRING zip4;
		STRING cart;
		STRING cr_sort_sz;
		STRING lot;
		STRING lot_order;
		STRING dpbc;
		STRING chk_digit;
		STRING rec_type;
		STRING ace_fips_st;
		STRING county;
		STRING geo_lat;
		STRING geo_long;
		STRING msa;
		STRING geo_blk;
		STRING geo_match;
		STRING err_stat;
		STRING bus_name_flag;
		STRING aka_name;
		STRING title;
		STRING fname;
		STRING mname;
		STRING lname;
		STRING name_suffix;
		STRING name_score;
		STRING exec_title;
		STRING exec_fname;
		STRING exec_mname;
		STRING exec_lname;
		STRING exec_name_suffix;
		STRING exec_name_score;
		STRING nn_fix_city;
		STRING nn_fix_state;
		STRING nn_fix_zip;
		STRING nn_fix_ace_flag;
		STRING nn_fix_alt_city1;
		STRING nn_fix_alt_zip1;
		STRING nn_fix_alt_city2;
		STRING nn_fix_alt_zip2;
		STRING n_fix_state;
		STRING address_override;
		STRING phone_override;
		STRING phone_type;
		STRING source;
		STRING chainid;
		STRING busshortname;
		STRING busdeptname;
		STRING fips;
		STRING countycode;
		STRING sic2;
		STRING sic3;
		STRING sic4;
		STRING indstryclass;
		STRING nosolicitcode;
		STRING dso;
		STRING timezone;
		STRING singleaddrflag;
		INTEGER source_rec_id;
		STRING dpc;
		STRING carrierroute;
		STRING z4type;
		STRING ctract;
		STRING cblockgroup;
		STRING cblockid;
		STRING cbsa;
		STRING mcdcode;
		STRING addrsensitivity;
		STRING maildeliverabilitycode;
		STRING sic1_4;
		STRING mlsc;
		STRING validationflag;
		STRING validationdate;
		STRING secvalidationcode;
		STRING gender;
		STRING execname;
		STRING exectitlecode;
		STRING exectitle;
		STRING condtitlecode;
		STRING condtitle;
		STRING contfunctioncode;
		STRING contfunction;
		STRING profession;
		STRING emplsizecode;
		STRING annualsalescode;
		STRING yrsinbus;
		STRING ethniccode;
		STRING latlongmatchlevel;
		STRING ypheading2;
		STRING ypheading3;
		STRING ypheading4;
		STRING ypheading5;
		STRING ypheading6;
		STRING maxypadsize;
		STRING faxac;
		STRING faxexchge;
		STRING faxphone;
		STRING altac;
		STRING altexchge;
		STRING altphone;
		STRING mobileac;
		STRING mobileexchge;
		STRING mobilephone;
		STRING tollfreeac;
		STRING tollfreeexchge;
		STRING tollfreephone;
		STRING creditcards;
		STRING brands;
		STRING stdhrs;
		STRING hrsopen;
		STRING services;
		STRING condheading;
		STRING tagline;
		STRING totaladspend;
		STRING aceaid;
		STRING append_prep_address_situs;
		STRING append_prep_address_last_situs;
		STRING cust_name;
		STRING bug_num;
		STRING link_fein;
		STRING link_inc_date;
	END;
	
	EXPORT Layout_YellowPages_Base := RECORD
		Layout_YellowPages_In;
		Addr_Cleaning_Fields;
		bipv2.IDlayouts.l_xlink_ids;
	END;
	
END;