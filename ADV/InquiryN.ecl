IMPORT Adv; 

/////////////////////////////////////////////////
//
// ECL Module InquiryN
//
// ECL module describing the attributes shared
// across all Non-FCRA Inquiry files covered
// in the ADV process.
//
/////////////////////////////////////////////////

EXPORT InquiryN := MODULE

	EXPORT Layout := RECORD
		Adv.Inquiry.mbslayout mbs;
		Adv.Inquiry.allowlayout allow_flags;
		Adv.Inquiry.businfolayout bus_intel;
		Adv.Inquiry.persondatalayout person_q;
		Adv.Inquiry.busdatalayout bus_q;
		Adv.Inquiry.bususerdatalayout bususer_q;
		Adv.Inquiry.permissablelayout permissions;
		Adv.Inquiry.searchlayout search_info;
		STRING source;
		STRING3 fraudpoint_score;
	END;

	EXPORT FlatLayout := RECORD
		//mbslayout   
		STRING company_id;
		STRING global_company_id;

		//allowlayout
		UNSIGNED8 allowflags;

		//businfolayout
		STRING primary_market_code;
		STRING secondary_market_code;
		STRING industry_1_code;
		STRING industry_2_code;
		STRING sub_market;
		STRING vertical;
		STRING use;
		STRING industry;

		//persondatalayout	 
		STRING full_name;
		STRING first_name;
		STRING middle_name;
		STRING last_name;
		STRING address;
		STRING city;
		STRING state;
		STRING zip;
		STRING personal_phone;
		STRING work_phone;
		STRING dob;
		STRING dl;
		STRING dl_st;
		STRING email_address;
		STRING ssn;
		STRING linkid;
		STRING ipaddr;
		STRING5 title;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5 name_suffix;
		STRING10 prim_range;
		STRING2 predir;
		STRING28 prim_name;
		STRING4 addr_suffix;
		STRING2 postdir;
		STRING10 unit_desig;
		STRING8 sec_range;
		STRING25 v_city_name;
		STRING2 st;
		STRING5 zip5;
		STRING4 zip4;
		STRING2 addr_rec_type;
		STRING2 fips_state;
		STRING3 fips_county;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4 cbsa;
		STRING7 geo_blk;
		STRING1 geo_match;
		STRING4 err_stat;
		STRING appended_ssn;
		UNSIGNED6 appended_adl;

		//busdatalayout
		STRING bdl_cname;
		STRING bdl_address;
		STRING bdl_city;
		STRING bdl_state;
		STRING bdl_zip;
		STRING bdl_company_phone;
		STRING bdl_ein;
		STRING bdl_charter_number;
		STRING bdl_ucc_number;
		STRING bdl_domain_name;
		STRING10 bdl_prim_range;
		STRING2 bdl_predir;
		STRING28 bdl_prim_name;
		STRING4 bdl_addr_suffix;
		STRING2 bdl_postdir;
		STRING10 bdl_unit_desig;
		STRING8 bdl_sec_range;
		STRING25 bdl_v_city_name;
		STRING2 bdl_st;
		STRING5 bdl_zip5;
		STRING4 bdl_zip4;
		STRING2 bdl_addr_rec_type;
		STRING2 bdl_fips_state;
		STRING3 bdl_fips_county;
		STRING10 bdl_geo_lat;
		STRING11 bdl_geo_long;
		STRING4 bdl_cbsa;
		STRING7 bdl_geo_blk;
		STRING1 bdl_geo_match;
		STRING4 bdl_err_stat;
		UNSIGNED6 bdl_appended_bdid;
		STRING bdl_appended_ein;

		//bususerdatalayout
		STRING budl_first_name;
		STRING budl_middle_name;
		STRING budl_last_name;
		STRING budl_address;
		STRING budl_city;
		STRING budl_state;
		STRING budl_zip;
		STRING budl_personal_phone;
		STRING budl_dob;
		STRING budl_dl;
		STRING budl_dl_st;
		STRING budl_ssn;
		STRING5 budl_title;
		STRING20 budl_fname;
		STRING20 budl_mname;
		STRING20 budl_lname;
		STRING5 budl_name_suffix;
		STRING10 budl_prim_range;
		STRING2 budl_predir;
		STRING28 budl_prim_name;
		STRING4 budl_addr_suffix;
		STRING2 budl_postdir;
		STRING10 budl_unit_desig;
		STRING8 budl_sec_range;
		STRING25 budl_v_city_name;
		STRING2 budl_st;
		STRING5 budl_zip5;
		STRING4 budl_zip4;
		STRING2 budl_addr_rec_type;
		STRING2 budl_fips_state;
		STRING3 budl_fips_county;
		STRING10 budl_geo_lat;
		STRING11 budl_geo_long;
		STRING4 budl_cbsa;
		STRING7 budl_geo_blk;
		STRING1 budl_geo_match;
		STRING4 budl_err_stat;
		STRING budl_appended_ssn;
		UNSIGNED6 budl_appended_adl;

		//permissablelayout
		STRING pl_glb_purpose;
		STRING pl_dppa_purpose;
		STRING pl_fcra_purpose;

		//searchlayout	 
		STRING sl_datetime;
		STRING sl_start_monitor;
		STRING sl_stop_monitor;
		STRING sl_login_history_id;
		STRING sl_transaction_id;
		STRING sl_sequence_number;
		STRING sl_method;
		STRING sl_product_code;
		STRING sl_transaction_type;
		STRING sl_function_description;
		STRING sl_ipaddr;

		STRING source;
		STRING3 fraudpoint_score;
	end;
	
	EXPORT FlattenLayout(Layout l) := TRANSFORM(FlatLayout,
		SELF.company_id            := l.mbs.company_id;
		SELF.global_company_id     := l.mbs.global_company_id;
		SELF.allowflags            := l.allow_flags.allowflags;
		SELF.primary_market_code   := l.bus_intel.primary_market_code;
		SELF.secondary_market_code := l.bus_intel.secondary_market_code;
		SELF.industry_1_code       := l.bus_intel.industry_1_code;
		SELF.industry_2_code       := l.bus_intel.industry_2_code;
		SELF.sub_market            := l.bus_intel.sub_market;
		SELF.vertical              := l.bus_intel.vertical;
		SELF.use                   := l.bus_intel.use;
		SELF.industry              := l.bus_intel.industry;
		
		SELF.full_name      := l.person_q.full_name;
		SELF.first_name     := l.person_q.first_name;
		SELF.middle_name    := l.person_q.middle_name;
		SELF.last_name      := l.person_q.last_name;
		SELF.address        := l.person_q.address;
		SELF.city           := l.person_q.city;
		SELF.state          := l.person_q.state;
		SELF.zip            := l.person_q.zip;
		SELF.personal_phone := l.person_q.personal_phone;
		SELF.work_phone     := l.person_q.work_phone;
		SELF.dob            := l.person_q.dob;
		SELF.dl             := l.person_q.dl;
		SELF.dl_st          := l.person_q.dl_st;
		SELF.email_address  := l.person_q.email_address;
		SELF.ssn            := l.person_q.ssn;
		SELF.linkid         := l.person_q.linkid;
		SELF.ipaddr         := l.person_q.ipaddr;
		SELF.title          := l.person_q.title;
		SELF.fname          := l.person_q.fname;
		SELF.mname          := l.person_q.mname;
		SELF.lname          := l.person_q.lname;
		SELF.name_suffix    := l.person_q.name_suffix;
		SELF.prim_range     := l.person_q.prim_range;
		SELF.predir         := l.person_q.predir;
		SELF.prim_name      := l.person_q.prim_name;
		SELF.addr_suffix    := l.person_q.addr_suffix;
		SELF.postdir        := l.person_q.postdir;
		SELF.unit_desig     := l.person_q.unit_desig;
		SELF.sec_range      := l.person_q.sec_range;
		SELF.v_city_name    := l.person_q.v_city_name;
		SELF.st             := l.person_q.st;
		SELF.zip5           := l.person_q.zip5;
		SELF.zip4           := l.person_q.zip4;
		SELF.addr_rec_type  := l.person_q.addr_rec_type;
		SELF.fips_state     := l.person_q.fips_state;
		SELF.fips_county    := l.person_q.fips_county;
		SELF.geo_lat        := l.person_q.geo_lat;
		SELF.geo_long       := l.person_q.geo_long;
		SELF.cbsa           := l.person_q.cbsa;
		SELF.geo_blk        := l.person_q.geo_blk;
		SELF.geo_match      := l.person_q.geo_match;
		SELF.err_stat       := l.person_q.err_stat;
		SELF.appended_ssn   := l.person_q.appended_ssn;
		SELF.appended_adl   := l.person_q.appended_adl;
		
		SELF.bdl_cname          := l.bus_q.cname;
		SELF.bdl_address        := l.bus_q.address;
		SELF.bdl_city           := l.bus_q.city;
		SELF.bdl_state          := l.bus_q.state;
		SELF.bdl_zip            := l.bus_q.zip;
		SELF.bdl_company_phone  := l.bus_q.company_phone;
		SELF.bdl_ein            := l.bus_q.ein;
		SELF.bdl_charter_number := l.bus_q.charter_number;
		SELF.bdl_ucc_number     := l.bus_q.ucc_number;
		SELF.bdl_domain_name    := l.bus_q.domain_name;
		SELF.bdl_prim_range     := l.bus_q.prim_range;
		SELF.bdl_predir         := l.bus_q.predir;
		SELF.bdl_prim_name      := l.bus_q.prim_name;
		SELF.bdl_addr_suffix    := l.bus_q.addr_suffix;
		SELF.bdl_postdir        := l.bus_q.postdir;
		SELF.bdl_unit_desig     := l.bus_q.unit_desig;
		SELF.bdl_sec_range      := l.bus_q.sec_range;
		SELF.bdl_v_city_name    := l.bus_q.v_city_name;
		SELF.bdl_st             := l.bus_q.st;
		SELF.bdl_zip5           := l.bus_q.zip5;
		SELF.bdl_zip4           := l.bus_q.zip4;
		SELF.bdl_addr_rec_type  := l.bus_q.addr_rec_type;
		SELF.bdl_fips_state     := l.bus_q.fips_state;
		SELF.bdl_fips_county    := l.bus_q.fips_county;
		SELF.bdl_geo_lat        := l.bus_q.geo_lat;
		SELF.bdl_geo_long       := l.bus_q.geo_long;
		SELF.bdl_cbsa           := l.bus_q.cbsa;
		SELF.bdl_geo_blk        := l.bus_q.geo_blk;
		SELF.bdl_geo_match      := l.bus_q.geo_match;
		SELF.bdl_err_stat       := l.bus_q.err_stat;
		SELF.bdl_appended_bdid  := l.bus_q.appended_bdid;
		SELF.bdl_appended_ein   := l.bus_q.appended_ein;
		
		SELF.budl_first_name     := l.bususer_q.first_name;
		SELF.budl_middle_name    := l.bususer_q.middle_name;
		SELF.budl_last_name      := l.bususer_q.last_name;
		SELF.budl_address        := l.bususer_q.address;
		SELF.budl_city           := l.bususer_q.city;
		SELF.budl_state          := l.bususer_q.state;
		SELF.budl_zip            := l.bususer_q.zip;
		SELF.budl_personal_phone := l.bususer_q.personal_phone;
		SELF.budl_dob            := l.bususer_q.dob;
		SELF.budl_dl             := l.bususer_q.dl;
		SELF.budl_dl_st          := l.bususer_q.dl_st;
		SELF.budl_ssn            := l.bususer_q.ssn;
		SELF.budl_title          := l.bususer_q.title;
		SELF.budl_fname          := l.bususer_q.fname;
		SELF.budl_mname          := l.bususer_q.mname;
		SELF.budl_lname          := l.bususer_q.lname;
		SELF.budl_name_suffix    := l.bususer_q.name_suffix;
		SELF.budl_prim_range     := l.bususer_q.prim_range;
		SELF.budl_predir         := l.bususer_q.predir;
		SELF.budl_prim_name      := l.bususer_q.prim_name;
		SELF.budl_addr_suffix    := l.bususer_q.addr_suffix;
		SELF.budl_postdir        := l.bususer_q.postdir;
		SELF.budl_unit_desig     := l.bususer_q.unit_desig;
		SELF.budl_sec_range      := l.bususer_q.sec_range;
		SELF.budl_v_city_name    := l.bususer_q.v_city_name;
		SELF.budl_st             := l.bususer_q.st;
		SELF.budl_zip5           := l.bususer_q.zip5;
		SELF.budl_zip4           := l.bususer_q.zip4;
		SELF.budl_addr_rec_type  := l.bususer_q.addr_rec_type;
		SELF.budl_fips_state     := l.bususer_q.fips_state;
		SELF.budl_fips_county    := l.bususer_q.fips_county;
		SELF.budl_geo_lat        := l.bususer_q.geo_lat;
		SELF.budl_geo_long       := l.bususer_q.geo_long;
		SELF.budl_cbsa           := l.bususer_q.cbsa;
		SELF.budl_geo_blk        := l.bususer_q.geo_blk;
		SELF.budl_geo_match      := l.bususer_q.geo_match;
		SELF.budl_err_stat       := l.bususer_q.err_stat;
		SELF.budl_appended_ssn   := l.bususer_q.appended_ssn;
		SELF.budl_appended_adl   := l.bususer_q.appended_adl;
		
		SELF.pl_glb_purpose  := l.permissions.glb_purpose;
		SELF.pl_dppa_purpose := l.permissions.dppa_purpose;
		SELF.pl_fcra_purpose := l.permissions.fcra_purpose;
		
		SELF.sl_datetime             := l.search_info.datetime;
		SELF.sl_start_monitor        := l.search_info.start_monitor;
		SELF.sl_stop_monitor         := l.search_info.stop_monitor;
		SELF.sl_login_history_id     := l.search_info.login_history_id;
		SELF.sl_transaction_id       := l.search_info.transaction_id;
		SELF.sl_sequence_number      := l.search_info.sequence_number;
		SELF.sl_method               := l.search_info.method;
		SELF.sl_product_code         := l.search_info.product_code;
		SELF.sl_transaction_type     := l.search_info.transaction_type;
		SELF.sl_function_description := l.search_info.function_description;
		SELF.sl_ipaddr               := l.search_info.ipaddr;
		
		SELF.source           := l.source;
		SELF.fraudpoint_score := l.fraudpoint_score;
	);	
	
END;