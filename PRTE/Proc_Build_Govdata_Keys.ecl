 import	_control;

export Proc_Build_Govdata_Keys(string pIndexVersion) := function 
	 sec_broker_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string8 dt_first_reported;
		string8 dt_last_reported;
		string10 cik_number;
		string60 company_name;
		string8 reporting_file_number;
		string40 address1;
		string40 address2;
		string30 city;
		string2 state_code;
		string10 zip_code;
		string9 irs_taxpayer_id;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		data2 is_company_flag;
		string60 cname;
		string1 lf;
		unsigned8 __internal_fpos__;
	 END;

	 sec_broker_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		string8 dt_first_reported;
		string8 dt_last_reported;
		string10 cik_number;
		string60 company_name;
		string8 reporting_file_number;
		string40 address1;
		string40 address2;
		string30 city;
		string2 state_code;
		string10 zip_code;
		string9 irs_taxpayer_id;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		data2 is_company_flag;
		string60 cname;
		string1 lf;
		unsigned6 bdid;
		integer1 fp;
	 END;

	 ca_sales_tax_bdid_KeyLayout:=RECORD
			unsigned6 bdid;
			string3 district_branch;
			string9 account_number;
			string4 sub_account_number;
			string3 district_branch_of_location;
			string3 tat;
			string1 tat_ind;
			string50 firm_name;
			string50 owner_name;
			string40 location_street;
			string30 location_city;
			string2 location_state;
			string5 location_zip;
			string4 location_zip_plus_4;
			string7 location_foreign_zip;
			string35 location_country_name;
			string40 mailing_street;
			string30 mailing_city;
			string2 mailing_state;
			string5 mailing_zip;
			string4 mailing_zip_plus_4;
			string7 mailing_foreign_zip;
			string35 mailing_country_name;
			string8 start_date;
			string5 business_code;
			string2 country_code;
			string3 city_code;
			string1 ownership_code;
			string10 prim_range;
			string2 predir;
			string28 prim_name;
			string4 addr_suffix;
			string2 postdir;
			string10 unit_desig;
			string8 sec_range;
			string25 p_city_name;
			string25 v_city_name;
			string2 st;
			string5 zip;
			string4 zip4;
			string4 cart;
			string1 cr_sort_sz;
			string4 lot;
			string1 lot_order;
			string2 dpbc;
			string1 chk_digit;
			string2 record_type;
			string2 ace_fips_st;
			string3 fipscounty;
			string10 geo_lat;
			string11 geo_long;
			string4 msa;
			string7 geo_blk;
			string1 geo_match;
			string4 err_stat;
			string5 name_prefix;
			string20 name_first;
			string20 name_middle;
			string20 name_last;
			string5 name_suffix;
			string3 score;
			string10 mail_prim_range;
			string2 mail_predir;
			string28 mail_prim_name;
			string4 mail_addr_suffix;
			string2 mail_postdir;
			string10 mail_unit_desig;
			string8 mail_sec_range;
			string25 mail_p_city_name;
			string25 mail_v_city_name;
			string2 mail_st;
			string5 mail_zip;
			string4 mail_zip4;
			string4 mail_cart;
			string1 mail_cr_sort_sz;
			string4 mail_lot;
			string1 mail_lot_order;
			string2 mail_dpbc;
			string1 mail_chk_digit;
			string2 mail_record_type;
			string2 mail_ace_fips_st;
			string3 mail_fipscounty;
			string10 mail_geo_lat;
			string11 mail_geo_long;
			string4 mail_msa;
			string7 mail_geo_blk;
			string1 mail_geo_match;
			string4 mail_err_stat;
			string2 crlf;
			unsigned8 __internal_fpos__;
	 END;
	 
	 ca_sales_tax_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		string3 district_branch;
		string9 account_number;
		string4 sub_account_number;
		string3 district_branch_of_location;
		string3 tat;
		string1 tat_ind;
		string50 firm_name;
		string50 owner_name;
		string40 location_street;
		string30 location_city;
		string2 location_state;
		string5 location_zip;
		string4 location_zip_plus_4;
		string7 location_foreign_zip;
		string35 location_country_name;
		string40 mailing_street;
		string30 mailing_city;
		string2 mailing_state;
		string5 mailing_zip;
		string4 mailing_zip_plus_4;
		string7 mailing_foreign_zip;
		string35 mailing_country_name;
		string8 start_date;
		string5 business_code;
		string2 country_code;
		string3 city_code;
		string1 ownership_code;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 fipscounty;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string5 name_prefix;
		string20 name_first;
		string20 name_middle;
		string20 name_last;
		string5 name_suffix;
		string3 score;
		string10 mail_prim_range;
		string2 mail_predir;
		string28 mail_prim_name;
		string4 mail_addr_suffix;
		string2 mail_postdir;
		string10 mail_unit_desig;
		string8 mail_sec_range;
		string25 mail_p_city_name;
		string25 mail_v_city_name;
		string2 mail_st;
		string5 mail_zip;
		string4 mail_zip4;
		string4 mail_cart;
		string1 mail_cr_sort_sz;
		string4 mail_lot;
		string1 mail_lot_order;
		string2 mail_dpbc;
		string1 mail_chk_digit;
		string2 mail_record_type;
		string2 mail_ace_fips_st;
		string3 mail_fipscounty;
		string10 mail_geo_lat;
		string11 mail_geo_long;
		string4 mail_msa;
		string7 mail_geo_blk;
		string1 mail_geo_match;
		string4 mail_err_stat;
		string2 crlf;
		unsigned6 bdid;
		unsigned8 source_rec_id;
		integer1 fp;
	 END;
	 
	fdic_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string8 process_date;
		string35 stname;
		string5 cert;
		string5 docket;
		string1 active;
		string60 address;
		string11 asset;
		string2 bkclass;
		string3 changec1;
		string3 changec2;
		string3 changec3;
		string3 changec4;
		string3 changec5;
		string5 charter;
		string5 chrtagnt;
		string1 conserve;
		string35 city;
		string2 clcode;
		string10 dateupdt;
		string5 denovo;
		string11 dep;
		string10 effdate;
		string10 endefymd;
		string10 eq;
		string10 estymd;
		string2 fdicdbs;
		string2 fed;
		string8 fed_rssd;
		string1 fedchrtr;
		string1 iba;
		string1 inactive;
		string4 insagnt1;
		string5 insagnt2;
		string10 insdate;
		string5 instcrcd;
		string1 insbif;
		string1 inscoml;
		string1 insfdic;
		string1 inssaif;
		string1 inssave;
		string75 name;
		string5 newcert;
		string1 oakar;
		string1 occdist;
		string1 otsdist;
		string10 procdate;
		string1 qbprcoml;
		string10 repdte;
		string10 risdate;
		string1 stchrtr;
		string12 roa;
		string12 roaq;
		string12 roe;
		string12 roeq;
		string10 rundate;
		string1 sasser;
		string15 stalp;
		string15 stcnty;
		string54 webaddr;
		string5 zip;
		string19 fldoff;
		string4 regagnt;
		string20 county;
		string42 msa;
		string53 cmsa;
		string9 otsregnm;
		string13 fdicregn;
		string4 offices;
		string30 cityhcr;
		string11 depdom;
		string5 form31;
		string5 hctmult;
		string5 instag;
		string5 mutual;
		string95 namehcr;
		string9 netinc;
		string9 netincq;
		string8 offdom;
		string8 offfor;
		string10 rssdhcr;
		string2 stalphcr;
		string5 stmult;
		string1 subchaps;
		string13 fdicsupv;
		string10 parcert_;
		string10 roaptx;
		string10 roaptxq;
		string4 trust;
		string10 certcons;
		string4 msa_no;
		string5 cmsa_no;
		string5 specgrp;
		string37 specgrpn;
		string1 lf;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 fipscounty;
		string10 geo_lat;
		string11 geo_long;
		string4 msa_code;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned8 __internal_fpos__;
	 END;
	 
	fdic_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		string8 process_date;
		string35 stname;
		string5 cert;
		string5 docket;
		string1 active;
		string60 address;
		string11 asset;
		string2 bkclass;
		string3 changec1;
		string3 changec2;
		string3 changec3;
		string3 changec4;
		string3 changec5;
		string5 charter;
		string5 chrtagnt;
		string1 conserve;
		string35 city;
		string2 clcode;
		string10 dateupdt;
		string5 denovo;
		string11 dep;
		string10 effdate;
		string10 endefymd;
		string10 eq;
		string10 estymd;
		string2 fdicdbs;
		string2 fed;
		string8 fed_rssd;
		string1 fedchrtr;
		string1 iba;
		string1 inactive;
		string4 insagnt1;
		string5 insagnt2;
		string10 insdate;
		string5 instcrcd;
		string1 insbif;
		string1 inscoml;
		string1 insfdic;
		string1 inssaif;
		string1 inssave;
		string75 name;
		string5 newcert;
		string1 oakar;
		string1 occdist;
		string1 otsdist;
		string10 procdate;
		string1 qbprcoml;
		string10 repdte;
		string10 risdate;
		string1 stchrtr;
		string12 roa;
		string12 roaq;
		string12 roe;
		string12 roeq;
		string10 rundate;
		string1 sasser;
		string15 stalp;
		string15 stcnty;
		string54 webaddr;
		string5 zip;
		string19 fldoff;
		string4 regagnt;
		string20 county;
		string42 msa;
		string53 cmsa;
		string9 otsregnm;
		string13 fdicregn;
		string4 offices;
		string30 cityhcr;
		string11 depdom;
		string5 form31;
		string5 hctmult;
		string5 instag;
		string5 mutual;
		string95 namehcr;
		string9 netinc;
		string9 netincq;
		string8 offdom;
		string8 offfor;
		string10 rssdhcr;
		string2 stalphcr;
		string5 stmult;
		string1 subchaps;
		string13 fdicsupv;
		string10 parcert_;
		string10 roaptx;
		string10 roaptxq;
		string4 trust;
		string10 certcons;
		string4 msa_no;
		string5 cmsa_no;
		string5 specgrp;
		string37 specgrpn;
		string1 lf;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 fipscounty;
		string10 geo_lat;
		string11 geo_long;
		string4 msa_code;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned6 bdid;
		unsigned8 append_rawaid;
		unsigned8 append_aceaid;
		string100 prep_addr_line1;
		string50 prep_addr_last_line;
		unsigned8 source_rec_id;
		integer1 fp;
	 END;
	 
	ia_sales_tax_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string9 permit_nbr;
		string35 owner_name;
		string35 trade_name;
		string24 mailing_street_1;
		string24 mailing_street_2;
		string13 mailing_city;
		string2 mailing_state;
		string5 mailing_zip_code;
		string4 mailing_zip_plus4;
		string24 location_street_1;
		string24 location_street_2;
		string13 location_city;
		string2 location_state;
		string5 location_zip_code;
		string4 location_zip_plus4;
		string8 issue_date;
		string5 owner_name_prefix;
		string20 owner_name_first;
		string20 owner_name_middle;
		string20 owner_name_last;
		string5 owner_name_suffix;
		string3 owner_name_score;
		string35 company_name_1;
		string5 trade_name_prefix;
		string20 trade_name_first;
		string20 trade_name_middle;
		string20 trade_name_last;
		string5 trade_name_suffix;
		string3 trade_name_score;
		string35 company_name_2;
		string10 mailing_prim_range;
		string2 mailing_predir;
		string28 mailing_prim_name;
		string4 mailing_addr_suffix;
		string2 mailing_postdir;
		string10 mailing_unit_desig;
		string8 mailing_sec_range;
		string25 mailing_p_city_name;
		string25 mailing_v_city_name;
		string2 mailing_st;
		string5 mailing_zip;
		string4 mailing_zip4;
		string4 mailing_cart;
		string1 mailing_cr_sort_sz;
		string4 mailing_lot;
		string1 mailing_lot_order;
		string2 mailing_dpbc;
		string1 mailing_chk_digit;
		string2 mailing_record_type;
		string2 mailing_ace_fips_st;
		string3 mailing_fipscounty;
		string10 mailing_geo_lat;
		string11 mailing_geo_long;
		string4 mailing_msa;
		string7 mailing_geo_blk;
		string1 mailing_geo_match;
		string4 mailing_err_stat;
		string10 location_prim_range;
		string2 location_predir;
		string28 location_prim_name;
		string4 location_addr_suffix;
		string2 location_postdir;
		string10 location_unit_desig;
		string8 location_sec_range;
		string25 location_p_city_name;
		string25 location_v_city_name;
		string2 location_st;
		string5 location_zip;
		string4 location_zip4;
		string4 location_cart;
		string1 location_cr_sort_sz;
		string4 location_lot;
		string1 location_lot_order;
		string2 location_dpbc;
		string1 location_chk_digit;
		string2 location_record_type;
		string2 location_ace_fips_st;
		string3 location_fipscounty;
		string10 location_geo_lat;
		string11 location_geo_long;
		string4 location_msa;
		string7 location_geo_blk;
		string1 location_geo_match;
		string4 location_err_stat;
		string2 crlf;
		unsigned8 __internal_fpos__;
	 END;
	 
	ia_sales_tax_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		unsigned6 bdid;
		string9 permit_nbr;
		string35 owner_name;
		string35 trade_name;
		string24 mailing_street_1;
		string24 mailing_street_2;
		string13 mailing_city;
		string2 mailing_state;
		string5 mailing_zip_code;
		string4 mailing_zip_plus4;
		string24 location_street_1;
		string24 location_street_2;
		string13 location_city;
		string2 location_state;
		string5 location_zip_code;
		string4 location_zip_plus4;
		string8 issue_date;
		string5 owner_name_prefix;
		string20 owner_name_first;
		string20 owner_name_middle;
		string20 owner_name_last;
		string5 owner_name_suffix;
		string3 owner_name_score;
		string35 company_name_1;
		string5 trade_name_prefix;
		string20 trade_name_first;
		string20 trade_name_middle;
		string20 trade_name_last;
		string5 trade_name_suffix;
		string3 trade_name_score;
		string35 company_name_2;
		string10 mailing_prim_range;
		string2 mailing_predir;
		string28 mailing_prim_name;
		string4 mailing_addr_suffix;
		string2 mailing_postdir;
		string10 mailing_unit_desig;
		string8 mailing_sec_range;
		string25 mailing_p_city_name;
		string25 mailing_v_city_name;
		string2 mailing_st;
		string5 mailing_zip;
		string4 mailing_zip4;
		string4 mailing_cart;
		string1 mailing_cr_sort_sz;
		string4 mailing_lot;
		string1 mailing_lot_order;
		string2 mailing_dpbc;
		string1 mailing_chk_digit;
		string2 mailing_record_type;
		string2 mailing_ace_fips_st;
		string3 mailing_fipscounty;
		string10 mailing_geo_lat;
		string11 mailing_geo_long;
		string4 mailing_msa;
		string7 mailing_geo_blk;
		string1 mailing_geo_match;
		string4 mailing_err_stat;
		string10 location_prim_range;
		string2 location_predir;
		string28 location_prim_name;
		string4 location_addr_suffix;
		string2 location_postdir;
		string10 location_unit_desig;
		string8 location_sec_range;
		string25 location_p_city_name;
		string25 location_v_city_name;
		string2 location_st;
		string5 location_zip;
		string4 location_zip4;
		string4 location_cart;
		string1 location_cr_sort_sz;
		string4 location_lot;
		string1 location_lot_order;
		string2 location_dpbc;
		string1 location_chk_digit;
		string2 location_record_type;
		string2 location_ace_fips_st;
		string3 location_fipscounty;
		string10 location_geo_lat;
		string11 location_geo_long;
		string4 location_msa;
		string7 location_geo_blk;
		string1 location_geo_match;
		string4 location_err_stat;
		string2 crlf;
		integer1 fp;
	 END;
	 
	irs_nonprofit_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string8 process_date;
		string9 employer_id_number;
		string70 primary_name_of_organization;
		string35 in_care_of_name;
		string35 street_address;
		string22 city;
		string2 state;
		string10 zip_code;
		string4 group_exemption_number;
		string2 subsection_code;
		string1 affiliation_code;
		string4 classification_code;
		string6 ruling_date;
		string1 deductibility_code;
		string2 foundation_code;
		string9 activity_codes;
		string1 organization_code;
		string2 univ_loc_code;
		string6 advance_ruling_exp_date;
		string6 tax_period;
		string1 asset_code;
		string1 income_code;
		string2 filing_requirement_code_part1;
		string1 filing_requirement_code_part2;
		string2 accounting_period;
		string13 asset_amount;
		string13 income_amount;
		string1 negative_sign;
		string13 form_990_revenue_amount;
		string1 negative_rev_amount;
		string4 national_taxonomy_exempt;
		string35 sort_name;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string35 cname;
		string1 lf;
		unsigned8 __internal_fpos__;
	 END;
	 
	irs_nonprofit_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		unsigned6 bdid;
		string8 process_date;
		string9 employer_id_number;
		string70 primary_name_of_organization;
		string35 in_care_of_name;
		string35 street_address;
		string22 city;
		string2 state;
		string10 zip_code;
		string4 group_exemption_number;
		string2 subsection_code;
		string1 affiliation_code;
		string4 classification_code;
		string6 ruling_date;
		string1 deductibility_code;
		string2 foundation_code;
		string9 activity_codes;
		string1 organization_code;
		string2 univ_loc_code;
		string6 advance_ruling_exp_date;
		string6 tax_period;
		string1 asset_code;
		string1 income_code;
		string2 filing_requirement_code_part1;
		string1 filing_requirement_code_part2;
		string2 accounting_period;
		string13 asset_amount;
		string13 income_amount;
		string1 negative_sign;
		string13 form_990_revenue_amount;
		string1 negative_rev_amount;
		string4 national_taxonomy_exempt;
		string35 sort_name;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string35 cname;
		unsigned8 append_rawaid;
		unsigned8 append_aceaid;
		string100 prep_addr_line1;
		string50 prep_addr_last_line;
		unsigned8 source_rec_id;
		integer1 fp;
	 END;
	 
	ms_workers_comp_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string32 employer_name;
		string50 employer_address;
		string15 employer_city;
		string2 employer_state;
		string5 employer_zip;
		string4 employer_sic;
		string9 employer_fein;
		string20 carrier_claim_no;
		string32 carrier_name;
		string9 claimant_ssn;
		string8 claimant_dob;
		string32 claimant_name;
		string25 claimant_address;
		string25 claimant_apt;
		string15 claimant_city;
		string2 claimant_state;
		string5 claimant_zip;
		string1 claimant_sex;
		string2 claimant_age;
		string7 mwee_no;
		string8 date_of_injury;
		string8 date_claim_filed;
		string8 date_ret_to_work;
		string8 date_hired;
		string8 employer_aware;
		string8 disability_date;
		string8 death_date;
		string8 b31_approved_date;
		string12 county_of_inlury;
		string6 weekly_wage;
		string32 atty_name;
		string26 name_of_injury;
		string20 part_of_body;
		string25 cause_of_injury;
		string3 nature_code;
		string3 part_code;
		string3 cause_code;
		string2 filler;
		string10 emp_prim_range;
		string2 emp_predir;
		string28 emp_prim_name;
		string4 emp_addr_suffix;
		string2 emp_postdir;
		string10 emp_unit_desig;
		string8 emp_sec_range;
		string25 emp_p_city_name;
		string25 emp_v_city_name;
		string2 emp_st;
		string5 emp_zip5;
		string4 emp_zip4;
		string4 emp_cart;
		string1 emp_cr_sort_sz;
		string4 emp_lot;
		string1 emp_lot_order;
		string2 emp_dpbc;
		string1 emp_chk_digit;
		string2 emp_record_type;
		string2 emp_ace_fips_st;
		string3 emp_fipscounty;
		string10 emp_geo_lat;
		string11 emp_geo_long;
		string4 emp_msa;
		string7 emp_geo_blk;
		string1 emp_geo_match;
		string4 emp_err_stat;
		string5 claim_name_prefix;
		string20 claim_name_first;
		string20 claim_name_middle;
		string20 claim_name_last;
		string5 claim_name_suffix;
		string3 claim_name_score;
		string10 claimant_prim_range;
		string2 claimant_predir;
		string28 claimant_prim_name;
		string4 claimant_addr_suffix;
		string2 claimant_postdir;
		string10 claimant_unit_desig;
		string8 claimant_sec_range;
		string25 claimant_p_city_name;
		string25 claimant_v_city_name;
		string2 claimant_st;
		string5 claimant_zip5;
		string4 claimant_zip4;
		string4 claimant_cart;
		string1 claimant_cr_sort_sz;
		string4 claimant_lot;
		string1 claimant_lot_order;
		string2 claimant_dpbc;
		string1 claimant_chk_digit;
		string2 claimant_record_type;
		string2 claimant_ace_fips_st;
		string3 claimant_fipscounty;
		string10 claimant_geo_lat;
		string11 claimant_geo_long;
		string4 claimant_msa;
		string7 claimant_geo_blk;
		string1 claimant_geo_match;
		string4 claimant_err_stat;
		string5 atty_name_prefix;
		string20 atty_name_first;
		string20 atty_name_middle;
		string20 atty_name_last;
		string5 atty_name_suffix;
		string3 atty_name_score;
		string1 status;
		string2 crlf;
		unsigned8 __internal_fpos__;
	 END;
	 
	ms_workers_comp_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		unsigned6 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string32 employer_name;
		string50 employer_address;
		string15 employer_city;
		string2 employer_state;
		string5 employer_zip;
		string4 employer_sic;
		string9 employer_fein;
		string20 carrier_claim_no;
		string32 carrier_name;
		string9 claimant_ssn;
		string8 claimant_dob;
		string32 claimant_name;
		string25 claimant_address;
		string25 claimant_apt;
		string15 claimant_city;
		string2 claimant_state;
		string5 claimant_zip;
		string1 claimant_sex;
		string2 claimant_age;
		string7 mwee_no;
		string8 date_of_injury;
		string8 date_claim_filed;
		string8 date_ret_to_work;
		string8 date_hired;
		string8 employer_aware;
		string8 disability_date;
		string8 death_date;
		string8 b31_approved_date;
		string12 county_of_inlury;
		string6 weekly_wage;
		string32 atty_name;
		string26 name_of_injury;
		string20 part_of_body;
		string25 cause_of_injury;
		string3 nature_code;
		string3 part_code;
		string3 cause_code;
		string2 filler;
		string10 emp_prim_range;
		string2 emp_predir;
		string28 emp_prim_name;
		string4 emp_addr_suffix;
		string2 emp_postdir;
		string10 emp_unit_desig;
		string8 emp_sec_range;
		string25 emp_p_city_name;
		string25 emp_v_city_name;
		string2 emp_st;
		string5 emp_zip5;
		string4 emp_zip4;
		string4 emp_cart;
		string1 emp_cr_sort_sz;
		string4 emp_lot;
		string1 emp_lot_order;
		string2 emp_dpbc;
		string1 emp_chk_digit;
		string2 emp_record_type;
		string2 emp_ace_fips_st;
		string3 emp_fipscounty;
		string10 emp_geo_lat;
		string11 emp_geo_long;
		string4 emp_msa;
		string7 emp_geo_blk;
		string1 emp_geo_match;
		string4 emp_err_stat;
		string5 claim_name_prefix;
		string20 claim_name_first;
		string20 claim_name_middle;
		string20 claim_name_last;
		string5 claim_name_suffix;
		string3 claim_name_score;
		string10 claimant_prim_range;
		string2 claimant_predir;
		string28 claimant_prim_name;
		string4 claimant_addr_suffix;
		string2 claimant_postdir;
		string10 claimant_unit_desig;
		string8 claimant_sec_range;
		string25 claimant_p_city_name;
		string25 claimant_v_city_name;
		string2 claimant_st;
		string5 claimant_zip5;
		string4 claimant_zip4;
		string4 claimant_cart;
		string1 claimant_cr_sort_sz;
		string4 claimant_lot;
		string1 claimant_lot_order;
		string2 claimant_dpbc;
		string1 claimant_chk_digit;
		string2 claimant_record_type;
		string2 claimant_ace_fips_st;
		string3 claimant_fipscounty;
		string10 claimant_geo_lat;
		string11 claimant_geo_long;
		string4 claimant_msa;
		string7 claimant_geo_blk;
		string1 claimant_geo_match;
		string4 claimant_err_stat;
		string5 atty_name_prefix;
		string20 atty_name_first;
		string20 atty_name_middle;
		string20 atty_name_last;
		string5 atty_name_suffix;
		string3 atty_name_score;
		string1 status;
		string2 crlf;
		integer1 fp;
	 END;
	 
	or_workers_comp_bdid_KeyLayout:=RECORD
		unsigned6 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string1 tab;
		string10 ppb_phone_number;
		string50 employer_legal_name;
		string50 doing_business_as_name_1;
		string50 doing_business_as_name_2;
		string50 doing_business_as_name_3;
		string50 doing_business_as_name_4;
		string50 doing_business_as_name_5;
		string50 ppb_address_line_1;
		string50 ppb_address_line_2;
		string50 ppb_city;
		string5 ppb_zip_code;
		string8 liability_end_date_for_most_recent_coverage;
		string7 last_reported_number_of_employees;
		string7 employer_number;
		string4 ncci_class_code;
		string50 mailing_address_line_1;
		string50 mailing_address_line_2;
		string50 mailing_city;
		string2 mailing_state;
		string5 mailing_zip_code;
		string4 mailing_zip_code_extension;
		string1 bad_mailing_address_code;
		string2 ppb_state;
		string4 ppb_zip_code_extension;
		string12 ppb_county;
		string1 ownership_code;
		string2 or_osha_region_code;
		string4 standard_industrial_class_code;
		string18 business_description;
		string2 entity_code;
		string1 elc_flag;
		string9 elc_license_number;
		string7 leasing_co__employer_no_;
		string50 leasing_company_name;
		string7 insurer_type;
		string4 insurer_number;
		string30 insurer_name;
		string30 policy_number;
		string8 liability_begin_date_for_most_recent_coverage;
		string8 cancel_request_date;
		string1 cancel_reason_code;
		string2 last_coverage_document;
		string10 ppb_prim_range;
		string2 ppb_predir;
		string28 ppb_prim_name;
		string4 ppb_addr_suffix;
		string2 ppb_postdir;
		string10 ppb_unit_desig;
		string8 ppb_sec_range;
		string25 ppb_p_city_name;
		string25 ppb_v_city_name;
		string2 ppb_st;
		string5 ppb_zip5;
		string4 ppb_zip4;
		string4 ppb_cart;
		string1 ppb_cr_sort_sz;
		string4 ppb_lot;
		string1 ppb_lot_order;
		string2 ppb_dpbc;
		string1 ppb_chk_digit;
		string2 ppb_record_type;
		string2 ppb_ace_fips_st;
		string3 ppb_fipscounty;
		string10 ppb_geo_lat;
		string11 ppb_geo_long;
		string4 ppb_msa;
		string7 ppb_geo_blk;
		string1 ppb_geo_match;
		string4 ppb_err_stat;
		string10 mailing_prim_range;
		string2 mailing_predir;
		string28 mailing_prim_name;
		string4 mailing_addr_suffix;
		string2 mailing_postdir;
		string10 mailing_unit_desig;
		string8 mailing_sec_range;
		string25 mailing_p_city_name;
		string25 mailing_v_city_name;
		string2 mailing_st;
		string5 mailing_zip5;
		string4 mailing_zip4;
		string4 mailing_cart;
		string1 mailing_cr_sort_sz;
		string4 mailing_lot;
		string1 mailing_lot_order;
		string2 mailing_dpbc;
		string1 mailing_chk_digit;
		string2 mailing_record_type;
		string2 mailing_ace_fips_st;
		string3 mailing_fipscounty;
		string10 mailing_geo_lat;
		string11 mailing_geo_long;
		string4 mailing_msa;
		string7 mailing_geo_blk;
		string1 mailing_geo_match;
		string4 mailing_err_stat;
		string2 crlf;
		unsigned8 __internal_fpos__;
	 END;
	 
	or_workers_comp_linkIds_KeyLayout:=RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		unsigned6 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string1 tab;
		string10 ppb_phone_number;
		string50 employer_legal_name;
		string50 doing_business_as_name_1;
		string50 doing_business_as_name_2;
		string50 doing_business_as_name_3;
		string50 doing_business_as_name_4;
		string50 doing_business_as_name_5;
		string50 ppb_address_line_1;
		string50 ppb_address_line_2;
		string50 ppb_city;
		string5 ppb_zip_code;
		string8 liability_end_date_for_most_recent_coverage;
		string7 last_reported_number_of_employees;
		string7 employer_number;
		string4 ncci_class_code;
		string50 mailing_address_line_1;
		string50 mailing_address_line_2;
		string50 mailing_city;
		string2 mailing_state;
		string5 mailing_zip_code;
		string4 mailing_zip_code_extension;
		string1 bad_mailing_address_code;
		string2 ppb_state;
		string4 ppb_zip_code_extension;
		string12 ppb_county;
		string1 ownership_code;
		string2 or_osha_region_code;
		string4 standard_industrial_class_code;
		string18 business_description;
		string2 entity_code;
		string1 elc_flag;
		string9 elc_license_number;
		string7 leasing_co__employer_no_;
		string50 leasing_company_name;
		string7 insurer_type;
		string4 insurer_number;
		string30 insurer_name;
		string30 policy_number;
		string8 liability_begin_date_for_most_recent_coverage;
		string8 cancel_request_date;
		string1 cancel_reason_code;
		string2 last_coverage_document;
		string10 ppb_prim_range;
		string2 ppb_predir;
		string28 ppb_prim_name;
		string4 ppb_addr_suffix;
		string2 ppb_postdir;
		string10 ppb_unit_desig;
		string8 ppb_sec_range;
		string25 ppb_p_city_name;
		string25 ppb_v_city_name;
		string2 ppb_st;
		string5 ppb_zip5;
		string4 ppb_zip4;
		string4 ppb_cart;
		string1 ppb_cr_sort_sz;
		string4 ppb_lot;
		string1 ppb_lot_order;
		string2 ppb_dpbc;
		string1 ppb_chk_digit;
		string2 ppb_record_type;
		string2 ppb_ace_fips_st;
		string3 ppb_fipscounty;
		string10 ppb_geo_lat;
		string11 ppb_geo_long;
		string4 ppb_msa;
		string7 ppb_geo_blk;
		string1 ppb_geo_match;
		string4 ppb_err_stat;
		string10 mailing_prim_range;
		string2 mailing_predir;
		string28 mailing_prim_name;
		string4 mailing_addr_suffix;
		string2 mailing_postdir;
		string10 mailing_unit_desig;
		string8 mailing_sec_range;
		string25 mailing_p_city_name;
		string25 mailing_v_city_name;
		string2 mailing_st;
		string5 mailing_zip5;
		string4 mailing_zip4;
		string4 mailing_cart;
		string1 mailing_cr_sort_sz;
		string4 mailing_lot;
		string1 mailing_lot_order;
		string2 mailing_dpbc;
		string1 mailing_chk_digit;
		string2 mailing_record_type;
		string2 mailing_ace_fips_st;
		string3 mailing_fipscounty;
		string10 mailing_geo_lat;
		string11 mailing_geo_long;
		string4 mailing_msa;
		string7 mailing_geo_blk;
		string1 mailing_geo_match;
		string4 mailing_err_stat;
		string2 crlf;
		integer1 fp;
	 END;
	 
		ds_sec_broker_bdid						:= dataset([],sec_broker_bdid_KeyLayout);  
		ds_sec_broker_linkids					:= dataset([],sec_broker_linkids_KeyLayout);  
		ds_ca_sales_tax_bdid					:= dataset([],ca_sales_tax_bdid_KeyLayout); 
		ds_ca_sales_tax_linkids				:= dataset([],ca_sales_tax_linkids_KeyLayout); 		
		ds_fdic_bdid									:= dataset([],fdic_bdid_KeyLayout);
		ds_fdic_linkids								:= dataset([],fdic_linkids_KeyLayout);
		ds_ia_sales_tax_bdid					:= dataset([],ia_sales_tax_bdid_KeyLayout); 
		ds_ia_sales_tax_linkids				:= dataset([],ia_sales_tax_linkids_KeyLayout);
		ds_irs_nonprofit_bdid					:= dataset([],irs_nonprofit_bdid_KeyLayout);
		ds_irs_nonprofit_linkids			:= dataset([],irs_nonprofit_linkids_KeyLayout);
		ds_ms_workers_comp_bdid				:= dataset([],ms_workers_comp_bdid_KeyLayout);
		ds_ms_workers_comp_linkids		:= dataset([],ms_workers_comp_linkids_KeyLayout);
		ds_or_workers_comp_bdid				:= dataset([],or_workers_comp_bdid_KeyLayout);
		ds_or_workers_comp_linkids		:= dataset([],or_workers_comp_linkids_KeyLayout);	
		
		sec_broker_bdid_IN						:= index(ds_sec_broker_bdid, {bdid}, {ds_sec_broker_bdid}, '~prte::key::sec_broker_dealer::'+pIndexVersion+'::bdid');  
		sec_broker_linkids_IN					:= index(ds_sec_broker_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_sec_broker_linkids}, '~prte::key::sec_broker_dealer::'+pIndexVersion+'::linkids');
		ca_sales_tax_bdid_IN					:= index(ds_ca_sales_tax_bdid, {bdid}, {ds_ca_sales_tax_bdid}, '~prte::key::salestax::'+pIndexVersion+'::ca::bdid');
		ca_sales_tax_linkids_IN				:= index(ds_ca_sales_tax_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_ca_sales_tax_linkids}, '~prte::key::salestax::'+pIndexVersion+'::ca::linkids');
		fdic_bdid_IN									:= index(ds_fdic_bdid, {bdid}, {ds_fdic_bdid}, '~prte::key::fdic::'+pIndexVersion+'::bdid');
		fdic_linkids_IN								:= index(ds_fdic_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_fdic_linkids}, '~prte::key::fdic::'+pIndexVersion+'::linkids');
		ia_sales_tax_bdid_IN					:= index(ds_ia_sales_tax_bdid, {bdid}, {ds_ia_sales_tax_bdid}, '~prte::key::salestax::'+pIndexVersion+'::ia::bdid');
		ia_sales_tax_linkids_IN				:= index(ds_ia_sales_tax_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_ia_sales_tax_linkids}, '~prte::key::salestax::'+pIndexVersion+'::ia::linkids');
		irs_nonprofit_bdid_IN				  := index(ds_irs_nonprofit_bdid, {bdid}, {ds_irs_nonprofit_bdid}, '~prte::key::irsnonprofit::'+pIndexVersion+'::bdid');
		irs_nonprofit_linkids_IN			:= index(ds_irs_nonprofit_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_irs_nonprofit_linkids}, '~prte::key::irsnonprofit::'+pIndexVersion+'::linkids'); 
		ms_workers_comp_bdid_IN				:= index(ds_ms_workers_comp_bdid, {bdid}, {ds_ms_workers_comp_bdid}, '~prte::key::ms_workers_comp::'+pIndexVersion+'::bdid');
		ms_workers_comp_linkids_IN		:= index(ds_ms_workers_comp_linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_ms_workers_comp_linkids}, '~prte::key::ms_workers_comp::'+pIndexVersion+'::linkids');
		or_workers_comp_bdid_IN				:= index(ds_or_workers_comp_bdid, {bdid}, {ds_or_workers_comp_bdid}, '~prte::key::or_workers_comp::'+pIndexVersion+'::bdid');
		or_workers_comp_linkids_IN		:= index(ds_or_workers_comp_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_or_workers_comp_linkids}, '~prte::key::or_workers_comp::'+pIndexVersion+'::linkids');
			
															 
		return sequential(  parallel( build(sec_broker_bdid_IN	, update),
																	build(sec_broker_linkids_IN	, update),
																	build(ca_sales_tax_bdid_IN	, update),
																	build(ca_sales_tax_linkids_IN	, update),
																	build(fdic_bdid_IN	, update),
																	build(fdic_linkids_IN	, update),
																	build(ia_sales_tax_bdid_IN	, update),
																	build(ia_sales_tax_linkids_IN	, update),
																	build(irs_nonprofit_bdid_IN	, update),
																	build(irs_nonprofit_linkids_IN	, update),
																	build(ms_workers_comp_bdid_IN	, update),
																	build(ms_workers_comp_linkids_IN	, update),
																	build(or_workers_comp_bdid_IN	, update),
																	build(or_workers_comp_linkids_IN	, update)
															   ),								
													  PRTE.UpdateVersion('GovdataKeys',													 //	Package name
																								pIndexVersion,												//	Package version
																								_control.MyInfo.EmailAddressNormal,	 //	Who to email with specifics
																							 'B',																	//	B = Boca, A = Alpharetta
																							 'N',																 //	N = Non-FCRA, F = FCRA
																							 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																							 )
										   );

end;





