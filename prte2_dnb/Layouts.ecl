﻿IMPORT DNB,DNB_DMI, BIPV2, STANDARD;
EXPORT Layouts := module

	shared Working_Fields := Record
		string50  cust_name;
		string10	bug_num;
		string9		link_fein;
		STRING8 	link_inc_date;
	End;
	EXPORT Layout_DNB_autokey := record
		unsigned6 bdid := 0;
		string9   duns_number :='';
		string90  business_name :='';
		string10  telephone_number :='';
		standard.Addr_Slim;
	end;
	EXPORT 	bdid_layout := record
		unsigned6 bd;
		string9 duns_number;
	end;
	EXPORT layout_autokey := record
	  Layout_DNB_autokey;
	  unsigned1 zero := 0;
	  string1 blank := '';
		dnb_dmi.layouts.Base.CCPA_fields;
	end;
  EXPORT CompaniesForBIP2 := DNB_DMI.Layouts.Base.CompaniesForBIP2;
	EXPORT Layout_DNB_Base := RECORD(DNB.Layout_DNB_Base)
			string8 date_vendor_first_reported;
			string8 date_vendor_last_reported;
			unsigned8 mail_rawaid;
			unsigned8 rawaid;
	END;
	EXPORT Layout_DNB_Base_Plus := Layout_DNB_Base or Working_Fields or  BIPV2.IDlayouts.l_xlink_ids;
	EXPORT Base_Contacts := DNB_DMI.Layouts.Base.Contacts;
	EXPORT Layout_DunsNum := {DNB.Layout_DNB_Base, BIPV2.IDlayouts.l_xlink_ids};
	EXPORT Layout_In := RECORD
		unsigned6 rid;
		unsigned6 bdid;
		unsigned1 bdid_score;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string9 duns_number;
		string90 business_name;
		string30 trade_style;
		string25 street;
		string20 city;
		string2 state;
		string9 zip_code;
		string17 mail_address;
		string14 mail_city;
		string2 mail_state;
		string5 mail_zip_code;
		string10 telephone_number;
		string21 county_name;
		string4 msa_code;
		string40 msa_name;
		string128 line_of_business_description;
		string8 sic1;
		string60 sic1desc;
		string8 sic1a;
		string60 sic1adesc;
		string8 sic1b;
		string60 sic1bdesc;
		string8 sic1c;
		string60 sic1cdesc;
		string8 sic1d;
		string60 sic1ddesc;
		string8 sic2;
		string60 sic2desc;
		string8 sic2a;
		string60 sic2adesc;
		string8 sic2b;
		string60 sic2bdesc;
		string8 sic2c;
		string60 sic2cdesc;
		string8 sic2d;
		string60 sic2ddesc;
		string8 sic3;
		string60 sic3desc;
		string8 sic3a;
		string60 sic3adesc;
		string8 sic3b;
		string60 sic3bdesc;
		string8 sic3c;
		string60 sic3cdesc;
		string8 sic3d;
		string60 sic3ddesc;
		string8 sic4;
		string60 sic4desc;
		string8 sic4a;
		string60 sic4adesc;
		string8 sic4b;
		string60 sic4bdesc;
		string8 sic4c;
		string60 sic4cdesc;
		string8 sic4d;
		string60 sic4ddesc;
		string8 sic5;
		string60 sic5desc;
		string8 sic5a;
		string60 sic5adesc;
		string8 sic5b;
		string60 sic5bdesc;
		string8 sic5c;
		string60 sic5cdesc;
		string8 sic5d;
		string60 sic5ddesc;
		string8 sic6;
		string60 sic6desc;
		string8 sic6a;
		string60 sic6adesc;
		string8 sic6b;
		string60 sic6bdesc;
		string8 sic6c;
		string60 sic6cdesc;
		string8 sic6d;
		string60 sic6ddesc;
		string1 industry_group;
		string4 year_started;
		string8 date_of_incorporation;
		string2 state_of_incorporation_abbr;
		string1 annual_sales_volume_sign;
		string15 annual_sales_volume;
		string1 annual_sales_code;
		string1 employees_here_sign;
		string10 employees_here;
		string1 employees_total_sign;
		string10 employees_total;
		string1 employees_here_code;
		string1 internal_use;
		string8 annual_sales_revision_date;
		string1 net_worth_sign;
		string12 net_worth;
		string1 trend_sales_sign;
		string15 trend_sales;
		string1 trend_employment_total_sign;
		string10 trend_employment_total;
		string1 base_sales_sign;
		string15 base_sales;
		string1 base_employment_total_sign;
		string10 base_employment_total;
		string1 percentage_sales_growth_sign;
		string4 percentage_sales_growth;
		string1 percentage_employment_growth_sign;
		string4 percentage_employment_growth;
		string9 square_footage;
		string1 sales_territory;
		string1 owns_rents;
		string9 number_of_accounts;
		string9 bank_duns_number;
		string30 bank_name;
		string30 accounting_firm_name;
		string1 small_business_indicator;
		string1 minority_owned;
		string1 cottage_indicator;
		string1 foreign_owned;
		string1 manufacturing_here_indicator;
		string1 public_indicator;
		string1 importer_exporter_indicator;
		string1 structure_type;
		string1 type_of_establishment;
		string9 parent_duns_number;
		string9 ultimate_duns_number;
		string9 headquarters_duns_number;
		string30 parent_company_name;
		string30 ultimate_company_name;
		string9 dias_code;
		string3 hierarchy_code;
		string1 ultimate_indicator;
		string30 internal_use1;
		string10 internal_use2;
		string1 internal_use3;
		string1 hot_list_new_indicator;
		string1 hot_list_ownership_change_indicator;
		string1 hot_list_ceo_change_indicator;
		string1 hot_list_company_name_change_ind;
		string1 hot_list_address_change_indicator;
		string1 hot_list_telephone_change_indicator;
		string6 hot_list_new_change_date;
		string6 hot_list_ownership_change_date;
		string6 hot_list_ceo_change_date;
		string6 hot_list_company_name_chg_date;
		string6 hot_list_address_change_date;
		string6 hot_list_telephone_change_date;
		string8 report_date;
		string1 delete_record_indicator;
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
		string2 mail_dbpc;
		string1 mail_chk_digit;
		string2 mail_rec_type;
		string2 mail_fips_state;
		string5 mail_county;
		string10 mail_geo_lat;
		string11 mail_geo_long;
		string4 mail_msa;
		string7 mail_geo_blk;
		string1 mail_geo_match;
		string4 mail_err_stat;
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
		string2 fips_state;
		string5 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string1 record_type;
		string1 active_duns_number;
		unsigned8 mail_rawaid;
		unsigned8 mail_aceaid;
		unsigned8 rawaid;
		unsigned8 aceaid;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		string50  cust_name;
		string10  bug_num;
		string9		link_fein;
		STRING8 	link_inc_date;
END;
END;