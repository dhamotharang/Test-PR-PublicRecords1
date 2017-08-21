
EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;

SHARED MakeSuperFiles(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION

MakeSuperKeys ('~prte::key::cbrs.phone10_gong_@version@');
MakeSuperKeys ('~prte::key::gong::@version@::npa');
MakeSuperKeys ('~prte::key::gong::@version@::zip');
MakeSuperKeys ('~prte::key::gong_address_current_@version@');
MakeSuperKeys ('~prte::key::gong_cn_@version@');
MakeSuperKeys ('~prte::key::gong_cn_to_company_@version@');
MakeSuperKeys ('~prte::key::gong_czsslf_@version@');
MakeSuperKeys ('~prte::key::gong_did_@version@');
MakeSuperKeys ('~prte::key::gong_eda_npa_nxx_line_@version@');
MakeSuperKeys ('~prte::key::gong_eda_st_bizword_city_@version@');
MakeSuperKeys ('~prte::key::gong_eda_st_city_prim_name_prim_range_@version@');
MakeSuperKeys ('~prte::key::gong_eda_st_lname_city_@version@');
MakeSuperKeys ('~prte::key::gong_eda_st_lname_fname_city_@version@');
MakeSuperKeys ('~prte::key::gong_hhid_@version@');
MakeSuperKeys ('~prte::key::gong_history::@version@::surnames');
MakeSuperKeys ('~prte::key::gong_history_address_@version@');
MakeSuperKeys ('~prte::key::gong_history_city_st_name_@version@');
MakeSuperKeys ('~prte::key::gong_history_cleanname_@version@');
MakeSuperKeys ('~prte::key::gong_history_companyname_@version@');
MakeSuperKeys ('~prte::key::gong_history_did_@version@');
MakeSuperKeys ('~prte::key::gong_history_hhid_@version@');
MakeSuperKeys ('~prte::key::gong_history_linkids_@version@');
MakeSuperKeys ('~prte::key::gong_history_name_@version@');
MakeSuperKeys ('~prte::key::gong_history_npa_nxx_line_@version@');
MakeSuperKeys ('~prte::key::gong_history_phone_@version@');
MakeSuperKeys ('~prte::key::gong_history_wdtg_@version@');
MakeSuperKeys ('~prte::key::gong_history_wild_name_zip_@version@');
MakeSuperKeys ('~prte::key::gong_history_zip_name_@version@');
MakeSuperKeys ('~prte::key::gong_hist_bdid_@version@');
MakeSuperKeys ('~prte::key::gong_lczf_@version@');
MakeSuperKeys ('~prte::key::gong_phone_@version@');
MakeSuperKeys ('~prte::key::gong_scoring_@version@');
MakeSuperKeys ('~prte::key::gong_surnamecnt_@version@');
MakeSuperKeys ('~prte::key::phone_table_v2_@version@');
MakeSuperKeys ('~prte::key::business_header::filtered::fcra::@version@::hri::phone10_v2');
MakeSuperKeys ('~prte::key::gong_history::fcra::@version@::address');
MakeSuperKeys ('~prte::key::gong_history::fcra::@version@::did');
MakeSuperKeys ('~prte::key::gong_history::fcra::@version@::phone');


MakeSuperFiles ('~PRTE::BASE::Gong_History@version@');
MakeSuperFiles ('~PRTE::BASE::Gong_Weekly@version@');

FileServices.CreateSuperFile ('~PRTE::IN::Gong_History');
FileServices.CreateSuperFile ('~PRTE::IN::Gong_Weekly');
FileServices.CreateSuperFile ('~PRTE::IN::Gong_Santander');

RETURN 'SUCCESS';

End;

End;