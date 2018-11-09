IMPORT ut,RoxieKeyBuild,_control, PRTE2_Gong,PRTE2_Common, PRTE, strata;

EXPORT proc_build_keys(string file_date, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 					:= is_running_in_prod AND NOT skipDOPS;
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_cbrs_phone10_gong,
		'~prte::key::cbrs.phone10_gong_@version@',
		Constants.Gong_Weekly  + file_date + '::cbrs.phone10_gong', build_key_cbrs_phone10_gong);
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_npa,
		'~prte::key::gong::@version@::npa',
		Constants.Gong_Key + file_date + '::npa', build_key_gong_npa);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_zip,
		'~prte::key::gong::@version@::zip',
		Constants.Gong_Key + file_date + '::zip', build_key_gong_zip);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_address_current,
		'~prte::key::gong_address_current_@version@',
		Constants.Gong_Weekly  + file_date + '::address_current', build_key_gong_address_current);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_cn,
		'~prte::key::gong_cn_@version@',
		Constants.Gong_Weekly  + file_date + '::cn', build_key_gong_cn);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_cn_to_company,
		'~prte::key::gong_cn_to_company_@version@',
		Constants.Gong_Weekly  + file_date + '::cn_to_company', build_key_gong_cn_to_company);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_czsslf,
		'~prte::key::gong_czsslf_@version@',
		Constants.Gong_Weekly  + file_date + '::czsslf', build_key_gong_czsslf);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_did,
		'~prte::key::gong_did_@version@',
		Constants.Gong_Weekly  + file_date + '::did', build_key_gong_did);
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_eda_npa_nxx_line,
		'~prte::key::gong_eda_npa_nxx_line_@version@',
		Constants.Gong_Weekly  + file_date + '::eda_npa_nxx_line', build_key_gong_eda_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_eda_st_bizword_city,
		'~prte::key::gong_eda_st_bizword_city_@version@',
		Constants.Gong_Weekly  + file_date + '::eda_st_bizword_city', build_key_gong_eda_st_bizword_city);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_eda_st_city_prim_name_prim_range,
		'~prte::key::gong_eda_st_city_prim_name_prim_range_@version@',
		Constants.Gong_Weekly  + file_date + '::eda_st_city_prim_name_prim_range', build_key_gong_eda_st_city_prim_name_prim_range);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_eda_st_lname_city,
		'~prte::key::gong_eda_st_lname_city_@version@',
		Constants.Gong_Weekly  + file_date + '::eda_st_lname_city', build_key_gong_eda_st_lname_city);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_eda_st_lname_fname_city,
		'~prte::key::gong_eda_st_lname_fname_city_@version@',
		Constants.Gong_Weekly  + file_date + '::eda_st_lname_fname_city', build_key_gong_eda_st_lname_fname_city);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_hhid,
		'~prte::key::gong_hhid_@version@',
		Constants.Gong_Weekly  + file_date + '::hhid', build_key_gong_hhid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_surnames,
		'~prte::key::gong_history::@version@::surnames',
		Constants.Gong_History + file_date + '::surnames', build_key_gong_history_surnames);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_address(false),
		'~prte::key::gong_history_address_@version@',
		Constants.Gong_History + file_date + '::address', build_key_gong_history_address);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_city_st_name,
		'~prte::key::gong_history_city_st_name_@version@',
		Constants.Gong_History + file_date + '::city_st_name', build_key_gong_history_city_st_name);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_cleanname,
		'~prte::key::gong_history_cleanname_@version@',
		Constants.Gong_History + file_date + '::cleanname', build_key_gong_history_cleanname);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_companyname,
		'~prte::key::gong_history_companyname_@version@',
		Constants.Gong_History + file_date + '::companyname', build_key_gong_history_companyname);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_did(false),
		'~prte::key::gong_history_did_@version@',
		Constants.Gong_History + file_date + '::did', build_key_gong_history_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_hhid,
		'~prte::key::gong_history_hhid_@version@',
		Constants.Gong_History + file_date + '::hhid', build_key_gong_history_hhid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.linkids.Key,
		'~prte::key::gong_history_linkids_@version@',
		Constants.Gong_History + file_date + '::linkids', build_key_gong_history_linkids);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_name,
		'~prte::key::gong_history_name_@version@',
		Constants.Gong_History + file_date + '::name', build_key_gong_history_name);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_npa_nxx_line,
		'~prte::key::gong_history_npa_nxx_line_@version@',
		Constants.Gong_History + file_date + '::npa_nxx_line', build_key_gong_history_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_phone(false),
		'~prte::key::gong_history_phone_@version@',
		Constants.Gong_History + file_date + '::phone', build_key_gong_history_phone);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_wdtg,
		'~prte::key::gong_history_wdtg_@version@',
		Constants.Gong_History + file_date + '::wdtg', build_key_gong_history_wdtg);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_wild_name_zip,
		'~prte::key::gong_history_wild_name_zip_@version@',
		Constants.Gong_History + file_date + '::wild_name_zip', build_key_gong_history_wild_name_zip);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_zip_name,
		'~prte::key::gong_history_zip_name_@version@',
		Constants.Gong_History + file_date + '::zip_name', build_key_gong_history_zip_name);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_hist_bdid,
		'~prte::key::gong_hist_bdid_@version@',
		Constants.Gong_History + file_date + '::bdid', build_key_gong_hist_bdid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_lczf,
		'~prte::key::gong_lczf_@version@',
		Constants.Gong_Weekly  + file_date + '::lczf', build_key_gong_lczf);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_phone,
		'~prte::key::gong_phone_@version@',
		Constants.Gong_Weekly  + file_date + '::phone', build_key_gong_phone);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_scoring,
		'~prte::key::gong_scoring_@version@',
		'~prte::key::gong_scoring::' + file_date + '::phone_nm', build_key_gong_scoring);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_surnamecnt,
		'~prte::key::gong_surnamecnt_@version@',
		Constants.Gong_Weekly  + file_date + '::surnamecnt', build_key_gong_surnamecnt);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_phone_table_v2(false,false),
		'~prte::key::phone_table_v2_@version@',
		'~prte::key::business_header::' + file_date + '::hri::phone10_v2', build_key_phone_table_v2);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_phone_table_v2(true,true),
		'~prte::key::business_header::filtered::fcra::@version@::hri::phone10_v2',
		'~prte::key::business_header::filtered::fcra::' + file_date + '::hri::phone10_v2', build_key_business_headerfilteredfcra_hriphone10_v2);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_address(true),
		'~prte::key::gong_history::fcra::@version@::address',
		Constants.Gong_History_FCRA + file_date + '::address', build_key_gong_historyfcra_address);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_did(true),
		'~prte::key::gong_history::fcra::@version@::did',
		Constants.Gong_History_FCRA + file_date + '::did', build_key_gong_historyfcra_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_gong_history_phone(true),
		'~prte::key::gong_history::fcra::@version@::phone',
		Constants.Gong_History_FCRA + file_date + '::phone', build_key_gong_historyfcra_phone);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::cbrs.phone10_gong_@version@', 
		Constants.Gong_Weekly  + file_date + '::cbrs.phone10_gong',
		move_built_key_cbrs_phone10_gong);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong::@version@::npa', 
		Constants.Gong_Key + file_date + '::npa',
		move_built_key_gong_npa);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong::@version@::zip', 
		Constants.Gong_Key + file_date + '::zip',
		move_built_key_gong_zip);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_address_current_@version@', 
		Constants.Gong_Weekly  + file_date + '::address_current',
		move_built_key_gong_address_current);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_cn_@version@', 
		Constants.Gong_Weekly  + file_date + '::cn',
		move_built_key_gong_cn);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_cn_to_company_@version@', 
		Constants.Gong_Weekly  + file_date + '::cn_to_company',
		move_built_key_gong_cn_to_company);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_czsslf_@version@', 
		Constants.Gong_Weekly  + file_date + '::czsslf',
		move_built_key_gong_czsslf);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_did_@version@', 
		Constants.Gong_Weekly  + file_date + '::did',
		move_built_key_gong_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_eda_npa_nxx_line_@version@', 
		Constants.Gong_Weekly  + file_date + '::eda_npa_nxx_line',
		move_built_key_gong_eda_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_eda_st_bizword_city_@version@', 
		Constants.Gong_Weekly  + file_date + '::eda_st_bizword_city',
		move_built_key_gong_eda_st_bizword_city);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_eda_st_city_prim_name_prim_range_@version@', 
		Constants.Gong_Weekly  + file_date + '::eda_st_city_prim_name_prim_range',
		move_built_key_gong_eda_st_city_prim_name_prim_range);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_eda_st_lname_city_@version@', 
		Constants.Gong_Weekly  + file_date + '::eda_st_lname_city',
		move_built_key_gong_eda_st_lname_city);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_eda_st_lname_fname_city_@version@', 
		Constants.Gong_Weekly  + file_date + '::eda_st_lname_fname_city',
		move_built_key_gong_eda_st_lname_fname_city);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_hhid_@version@', 
		Constants.Gong_Weekly  + file_date + '::hhid',
		move_built_key_gong_hhid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history::@version@::surnames', 
		Constants.Gong_History + file_date + '::surnames',
		move_built_key_gong_history_surnames);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_address_@version@', 
		Constants.Gong_History + file_date + '::address',
		move_built_key_gong_history_address);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_city_st_name_@version@', 
		Constants.Gong_History + file_date + '::city_st_name',
		move_built_key_gong_history_city_st_name);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_cleanname_@version@', 
		Constants.Gong_History + file_date + '::cleanname',
		move_built_key_gong_history_cleanname);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_companyname_@version@', 
		Constants.Gong_History + file_date + '::companyname',
		move_built_key_gong_history_companyname);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_did_@version@', 
		Constants.Gong_History + file_date + '::did',
		move_built_key_gong_history_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_hhid_@version@', 
		Constants.Gong_History + file_date + '::hhid',
		move_built_key_gong_history_hhid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_linkids_@version@', 
		Constants.Gong_History + file_date + '::linkids',
		move_built_key_gong_history_linkids);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_name_@version@', 
		Constants.Gong_History + file_date + '::name',
		move_built_key_gong_history_name);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_npa_nxx_line_@version@', 
		Constants.Gong_History + file_date + '::npa_nxx_line',
		move_built_key_gong_history_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_phone_@version@', 
		Constants.Gong_History + file_date + '::phone',
		move_built_key_gong_history_phone);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_wdtg_@version@', 
		Constants.Gong_History + file_date + '::wdtg',
		move_built_key_gong_history_wdtg);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_wild_name_zip_@version@', 
		Constants.Gong_History + file_date + '::wild_name_zip',
		move_built_key_gong_history_wild_name_zip);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history_zip_name_@version@', 
		Constants.Gong_History + file_date + '::zip_name',
		move_built_key_gong_history_zip_name);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_hist_bdid_@version@', 
		Constants.Gong_History + file_date + '::bdid',
		move_built_key_gong_hist_bdid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_lczf_@version@', 
		Constants.Gong_Weekly  + file_date + '::lczf',
		move_built_key_gong_lczf);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_phone_@version@', 
		Constants.Gong_Weekly  + file_date + '::phone',
		move_built_key_gong_phone);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_scoring_@version@', 
		'~prte::key::gong_scoring::' + file_date + '::phone_nm',
		move_built_key_gong_scoring);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_surnamecnt_@version@', 
		Constants.Gong_Weekly  + file_date + '::surnamecnt',
		move_built_key_gong_surnamecnt);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::phone_table_v2_@version@', 
		'~prte::key::business_header::' + file_date + '::hri::phone10_v2',
		move_built_key_phone_table_v2);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::business_header::filtered::fcra::@version@::hri::phone10_v2', 
		'~prte::key::business_header::filtered::fcra::' + file_date + '::hri::phone10_v2',
		move_built_key_business_headerfilteredfcra_hriphone10_v2);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history::fcra::@version@::address', 
		Constants.Gong_History_FCRA + file_date + '::address',
		move_built_key_gong_historyfcra_address);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history::fcra::@version@::did', 
		Constants.Gong_History_FCRA + file_date + '::did',
		move_built_key_gong_historyfcra_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::gong_history::fcra::@version@::phone', 
		Constants.Gong_History_FCRA + file_date + '::phone',
		move_built_key_gong_historyfcra_phone);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::cbrs.phone10_gong_@version@', 
		'Q', 
		move_qa_key_cbrs_phone10_gong);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong::@version@::npa', 
		'Q', 
		move_qa_key_gong_npa);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong::@version@::zip', 
		'Q', 
		move_qa_key_gong_zip);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_address_current_@version@', 
		'Q', 
		move_qa_key_gong_address_current);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_cn_@version@', 
		'Q', 
		move_qa_key_gong_cn);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_cn_to_company_@version@', 
		'Q', 
		move_qa_key_gong_cn_to_company);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_czsslf_@version@', 
		'Q', 
		move_qa_key_gong_czsslf);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_did_@version@', 
		'Q', 
		move_qa_key_gong_did);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_eda_npa_nxx_line_@version@', 
		'Q', 
		move_qa_key_gong_eda_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_eda_st_bizword_city_@version@', 
		'Q', 
		move_qa_key_gong_eda_st_bizword_city);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_eda_st_city_prim_name_prim_range_@version@', 
		'Q', 
		move_qa_key_gong_eda_st_city_prim_name_prim_range);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_eda_st_lname_city_@version@', 
		'Q', 
		move_qa_key_gong_eda_st_lname_city);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_eda_st_lname_fname_city_@version@', 
		'Q', 
		move_qa_key_gong_eda_st_lname_fname_city);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_hhid_@version@', 
		'Q', 
		move_qa_key_gong_hhid);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history::@version@::surnames', 
		'Q', 
		move_qa_key_gong_history_surnames);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_address_@version@', 
		'Q', 
		move_qa_key_gong_history_address);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_city_st_name_@version@', 
		'Q', 
		move_qa_key_gong_history_city_st_name);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_cleanname_@version@', 
		'Q', 
		move_qa_key_gong_history_cleanname);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_companyname_@version@', 
		'Q', 
		move_qa_key_gong_history_companyname);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_did_@version@', 
		'Q', 
		move_qa_key_gong_history_did);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_hhid_@version@', 
		'Q', 
		move_qa_key_gong_history_hhid);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_linkids_@version@', 
		'Q', 
		move_qa_key_gong_history_linkids);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_name_@version@', 
		'Q', 
		move_qa_key_gong_history_name);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_npa_nxx_line_@version@', 
		'Q', 
		move_qa_key_gong_history_npa_nxx_line);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_phone_@version@', 
		'Q', 
		move_qa_key_gong_history_phone);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_wdtg_@version@', 
		'Q', 
		move_qa_key_gong_history_wdtg);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_wild_name_zip_@version@', 
		'Q', 
		move_qa_key_gong_history_wild_name_zip);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history_zip_name_@version@', 
		'Q', 
		move_qa_key_gong_history_zip_name);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_hist_bdid_@version@', 
		'Q', 
		move_qa_key_gong_hist_bdid);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_lczf_@version@', 
		'Q', 
		move_qa_key_gong_lczf);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_phone_@version@', 
		'Q', 
		move_qa_key_gong_phone);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_scoring_@version@', 
		'Q', 
		move_qa_key_gong_scoring);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_surnamecnt_@version@', 
		'Q', 
		move_qa_key_gong_surnamecnt);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::phone_table_v2_@version@', 
		'Q', 
		move_qa_key_phone_table_v2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::business_header::filtered::fcra::@version@::hri::phone10_v2', 
		'Q', 
		move_qa_key_business_headerfilteredfcra_hriphone10_v2);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history::fcra::@version@::address', 
		'Q', 
		move_qa_key_gong_historyfcra_address);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history::fcra::@version@::did', 
		'Q', 
		move_qa_key_gong_historyfcra_did);

	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::gong_history::fcra::@version@::phone', 
		'Q', 
		move_qa_key_gong_historyfcra_phone);
		
	//DF-22185 Verify followings fields are cleared in fcra keys
cnt_gong_fcra_address := OUTPUT(strata.macf_pops(Keys.key_gong_history_address(true),,,,,,FALSE,
																['caption_text','county_code','designation','disc_cnt18','disc_cnt6',
																'prior_area_code','see_also_text']), 
																named('CNT_HISTORY_ADDRESS_FCRA'));
cnt_gong_fcra_did 		:= OUTPUT(strata.macf_pops(Keys.key_gong_history_did(true),,,,,,FALSE,
																['caption_text','county_code','designation','disc_cnt18','disc_cnt6',
																'prior_area_code','see_also_text']), 
																named('CNT_HISTORY_DID_FCRA'));
cnt_gong_fcra_phone 	:= OUTPUT(strata.macf_pops(Keys.key_gong_history_phone(true),,,,,,FALSE,
																['caption_text','county_code','designation','disc_cnt18','disc_cnt6',
																'prior_area_code','see_also_text']), 
																 named('CNT_HISTORY_PHONE_FCRA'));
	
		
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('GongKeys', file_date, notifyEmail,'B','N','N');
	updatedops_fcra  		:=  PRTE.UpdateVersion('FCRA_GongKeys',file_date,notifyEmail,'B','F','N');
	
	
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops,updatedops_fcra),NoUpdate);

	RETURN 		sequential(			
				build_key_cbrs_phone10_gong, 
				build_key_gong_npa, 
				build_key_gong_zip, 
				build_key_gong_address_current, 
				build_key_gong_cn, 
				build_key_gong_cn_to_company, 
				build_key_gong_czsslf, 
				build_key_gong_did, 
				build_key_gong_eda_npa_nxx_line, 
				build_key_gong_eda_st_bizword_city, 
				build_key_gong_eda_st_city_prim_name_prim_range, 
				build_key_gong_eda_st_lname_city, 
				build_key_gong_eda_st_lname_fname_city, 
				build_key_gong_hhid, 
				build_key_gong_history_surnames, 
				build_key_gong_history_address, 
				build_key_gong_history_city_st_name, 
				build_key_gong_history_cleanname, 
				build_key_gong_history_companyname, 
				build_key_gong_history_did, 
				build_key_gong_history_hhid, 
				build_key_gong_history_linkids, 
				build_key_gong_history_name, 
				build_key_gong_history_npa_nxx_line, 
				build_key_gong_history_phone, 
				build_key_gong_history_wdtg, 
				build_key_gong_history_wild_name_zip, 
				build_key_gong_history_zip_name, 
				build_key_gong_hist_bdid, 
				build_key_gong_lczf, 
				build_key_gong_phone, 
				build_key_gong_scoring, 
				build_key_gong_surnamecnt, 
				build_key_phone_table_v2, 
				build_key_business_headerfilteredfcra_hriphone10_v2, 
				build_key_gong_historyfcra_address, 
				build_key_gong_historyfcra_did, 
				build_key_gong_historyfcra_phone, 
				move_built_key_cbrs_phone10_gong, 
				move_built_key_gong_npa, 
				move_built_key_gong_zip, 
				move_built_key_gong_address_current, 
				move_built_key_gong_cn, 
				move_built_key_gong_cn_to_company, 
				move_built_key_gong_czsslf, 
				move_built_key_gong_did, 
				move_built_key_gong_eda_npa_nxx_line, 
				move_built_key_gong_eda_st_bizword_city, 
				move_built_key_gong_eda_st_city_prim_name_prim_range, 
				move_built_key_gong_eda_st_lname_city, 
				move_built_key_gong_eda_st_lname_fname_city, 
				move_built_key_gong_hhid, 
				move_built_key_gong_history_surnames, 
				move_built_key_gong_history_address, 
				move_built_key_gong_history_city_st_name, 
				move_built_key_gong_history_cleanname, 
				move_built_key_gong_history_companyname, 
				move_built_key_gong_history_did, 
				move_built_key_gong_history_hhid, 
				move_built_key_gong_history_linkids, 
				move_built_key_gong_history_name, 
				move_built_key_gong_history_npa_nxx_line, 
				move_built_key_gong_history_phone, 
				move_built_key_gong_history_wdtg, 
				move_built_key_gong_history_wild_name_zip, 
				move_built_key_gong_history_zip_name, 
				move_built_key_gong_hist_bdid, 
				move_built_key_gong_lczf, 
				move_built_key_gong_phone, 
				move_built_key_gong_scoring, 
				move_built_key_gong_surnamecnt, 
				move_built_key_phone_table_v2, 
				move_built_key_business_headerfilteredfcra_hriphone10_v2, 
				move_built_key_gong_historyfcra_address, 
				move_built_key_gong_historyfcra_did, 
				move_built_key_gong_historyfcra_phone, 
				move_qa_key_cbrs_phone10_gong, 
				move_qa_key_gong_npa, 
				move_qa_key_gong_zip, 
				move_qa_key_gong_address_current, 
				move_qa_key_gong_cn, 
				move_qa_key_gong_cn_to_company, 
				move_qa_key_gong_czsslf, 
				move_qa_key_gong_did, 
				move_qa_key_gong_eda_npa_nxx_line, 
				move_qa_key_gong_eda_st_bizword_city, 
				move_qa_key_gong_eda_st_city_prim_name_prim_range, 
				move_qa_key_gong_eda_st_lname_city, 
				move_qa_key_gong_eda_st_lname_fname_city, 
				move_qa_key_gong_hhid, 
				move_qa_key_gong_history_surnames, 
				move_qa_key_gong_history_address, 
				move_qa_key_gong_history_city_st_name, 
				move_qa_key_gong_history_cleanname, 
				move_qa_key_gong_history_companyname, 
				move_qa_key_gong_history_did, 
				move_qa_key_gong_history_hhid, 
				move_qa_key_gong_history_linkids, 
				move_qa_key_gong_history_name, 
				move_qa_key_gong_history_npa_nxx_line, 
				move_qa_key_gong_history_phone, 
				move_qa_key_gong_history_wdtg, 
				move_qa_key_gong_history_wild_name_zip, 
				move_qa_key_gong_history_zip_name, 
				move_qa_key_gong_hist_bdid, 
				move_qa_key_gong_lczf, 
				move_qa_key_gong_phone, 
				move_qa_key_gong_scoring, 
				move_qa_key_gong_surnamecnt, 
				move_qa_key_phone_table_v2, 
				move_qa_key_business_headerfilteredfcra_hriphone10_v2, 
				move_qa_key_gong_historyfcra_address, 
				move_qa_key_gong_historyfcra_did, 
				move_qa_key_gong_historyfcra_phone,
				parallel(cnt_gong_fcra_address, cnt_gong_fcra_did, cnt_gong_fcra_phone),
				PerformUpdateOrNot
				);

END;
