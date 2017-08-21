IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_mbslayout_company_id_pcnt := AVE(GROUP,IF(h.mbslayout_company_id = (TYPEOF(h.mbslayout_company_id))'',0,100));
    maxlength_mbslayout_company_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mbslayout_company_id)));
    avelength_mbslayout_company_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mbslayout_company_id)),h.mbslayout_company_id<>(typeof(h.mbslayout_company_id))'');
    populated_mbslayout_global_company_id_pcnt := AVE(GROUP,IF(h.mbslayout_global_company_id = (TYPEOF(h.mbslayout_global_company_id))'',0,100));
    maxlength_mbslayout_global_company_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mbslayout_global_company_id)));
    avelength_mbslayout_global_company_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mbslayout_global_company_id)),h.mbslayout_global_company_id<>(typeof(h.mbslayout_global_company_id))'');
    populated_allowlayout_allowflags_pcnt := AVE(GROUP,IF(h.allowlayout_allowflags = (TYPEOF(h.allowlayout_allowflags))'',0,100));
    maxlength_allowlayout_allowflags := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.allowlayout_allowflags)));
    avelength_allowlayout_allowflags := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.allowlayout_allowflags)),h.allowlayout_allowflags<>(typeof(h.allowlayout_allowflags))'');
    populated_businfolayout_primary_market_code_pcnt := AVE(GROUP,IF(h.businfolayout_primary_market_code = (TYPEOF(h.businfolayout_primary_market_code))'',0,100));
    maxlength_businfolayout_primary_market_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_primary_market_code)));
    avelength_businfolayout_primary_market_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_primary_market_code)),h.businfolayout_primary_market_code<>(typeof(h.businfolayout_primary_market_code))'');
    populated_businfolayout_secondary_market_code_pcnt := AVE(GROUP,IF(h.businfolayout_secondary_market_code = (TYPEOF(h.businfolayout_secondary_market_code))'',0,100));
    maxlength_businfolayout_secondary_market_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_secondary_market_code)));
    avelength_businfolayout_secondary_market_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_secondary_market_code)),h.businfolayout_secondary_market_code<>(typeof(h.businfolayout_secondary_market_code))'');
    populated_businfolayout_industry_1_code_pcnt := AVE(GROUP,IF(h.businfolayout_industry_1_code = (TYPEOF(h.businfolayout_industry_1_code))'',0,100));
    maxlength_businfolayout_industry_1_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry_1_code)));
    avelength_businfolayout_industry_1_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry_1_code)),h.businfolayout_industry_1_code<>(typeof(h.businfolayout_industry_1_code))'');
    populated_businfolayout_industry_2_code_pcnt := AVE(GROUP,IF(h.businfolayout_industry_2_code = (TYPEOF(h.businfolayout_industry_2_code))'',0,100));
    maxlength_businfolayout_industry_2_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry_2_code)));
    avelength_businfolayout_industry_2_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry_2_code)),h.businfolayout_industry_2_code<>(typeof(h.businfolayout_industry_2_code))'');
    populated_businfolayout_sub_market_pcnt := AVE(GROUP,IF(h.businfolayout_sub_market = (TYPEOF(h.businfolayout_sub_market))'',0,100));
    maxlength_businfolayout_sub_market := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_sub_market)));
    avelength_businfolayout_sub_market := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_sub_market)),h.businfolayout_sub_market<>(typeof(h.businfolayout_sub_market))'');
    populated_businfolayout_vertical_pcnt := AVE(GROUP,IF(h.businfolayout_vertical = (TYPEOF(h.businfolayout_vertical))'',0,100));
    maxlength_businfolayout_vertical := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_vertical)));
    avelength_businfolayout_vertical := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_vertical)),h.businfolayout_vertical<>(typeof(h.businfolayout_vertical))'');
    populated_businfolayout_use_pcnt := AVE(GROUP,IF(h.businfolayout_use = (TYPEOF(h.businfolayout_use))'',0,100));
    maxlength_businfolayout_use := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_use)));
    avelength_businfolayout_use := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_use)),h.businfolayout_use<>(typeof(h.businfolayout_use))'');
    populated_businfolayout_industry_pcnt := AVE(GROUP,IF(h.businfolayout_industry = (TYPEOF(h.businfolayout_industry))'',0,100));
    maxlength_businfolayout_industry := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry)));
    avelength_businfolayout_industry := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.businfolayout_industry)),h.businfolayout_industry<>(typeof(h.businfolayout_industry))'');
    populated_persondatalayout_full_name_pcnt := AVE(GROUP,IF(h.persondatalayout_full_name = (TYPEOF(h.persondatalayout_full_name))'',0,100));
    maxlength_persondatalayout_full_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_full_name)));
    avelength_persondatalayout_full_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_full_name)),h.persondatalayout_full_name<>(typeof(h.persondatalayout_full_name))'');
    populated_persondatalayout_first_name_pcnt := AVE(GROUP,IF(h.persondatalayout_first_name = (TYPEOF(h.persondatalayout_first_name))'',0,100));
    maxlength_persondatalayout_first_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_first_name)));
    avelength_persondatalayout_first_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_first_name)),h.persondatalayout_first_name<>(typeof(h.persondatalayout_first_name))'');
    populated_persondatalayout_middle_name_pcnt := AVE(GROUP,IF(h.persondatalayout_middle_name = (TYPEOF(h.persondatalayout_middle_name))'',0,100));
    maxlength_persondatalayout_middle_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_middle_name)));
    avelength_persondatalayout_middle_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_middle_name)),h.persondatalayout_middle_name<>(typeof(h.persondatalayout_middle_name))'');
    populated_persondatalayout_last_name_pcnt := AVE(GROUP,IF(h.persondatalayout_last_name = (TYPEOF(h.persondatalayout_last_name))'',0,100));
    maxlength_persondatalayout_last_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_last_name)));
    avelength_persondatalayout_last_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_last_name)),h.persondatalayout_last_name<>(typeof(h.persondatalayout_last_name))'');
    populated_persondatalayout_address_pcnt := AVE(GROUP,IF(h.persondatalayout_address = (TYPEOF(h.persondatalayout_address))'',0,100));
    maxlength_persondatalayout_address := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_address)));
    avelength_persondatalayout_address := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_address)),h.persondatalayout_address<>(typeof(h.persondatalayout_address))'');
    populated_persondatalayout_city_pcnt := AVE(GROUP,IF(h.persondatalayout_city = (TYPEOF(h.persondatalayout_city))'',0,100));
    maxlength_persondatalayout_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_city)));
    avelength_persondatalayout_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_city)),h.persondatalayout_city<>(typeof(h.persondatalayout_city))'');
    populated_persondatalayout_state_pcnt := AVE(GROUP,IF(h.persondatalayout_state = (TYPEOF(h.persondatalayout_state))'',0,100));
    maxlength_persondatalayout_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_state)));
    avelength_persondatalayout_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_state)),h.persondatalayout_state<>(typeof(h.persondatalayout_state))'');
    populated_persondatalayout_zip_pcnt := AVE(GROUP,IF(h.persondatalayout_zip = (TYPEOF(h.persondatalayout_zip))'',0,100));
    maxlength_persondatalayout_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip)));
    avelength_persondatalayout_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip)),h.persondatalayout_zip<>(typeof(h.persondatalayout_zip))'');
    populated_persondatalayout_personal_phone_pcnt := AVE(GROUP,IF(h.persondatalayout_personal_phone = (TYPEOF(h.persondatalayout_personal_phone))'',0,100));
    maxlength_persondatalayout_personal_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_personal_phone)));
    avelength_persondatalayout_personal_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_personal_phone)),h.persondatalayout_personal_phone<>(typeof(h.persondatalayout_personal_phone))'');
    populated_persondatalayout_work_phone_pcnt := AVE(GROUP,IF(h.persondatalayout_work_phone = (TYPEOF(h.persondatalayout_work_phone))'',0,100));
    maxlength_persondatalayout_work_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_work_phone)));
    avelength_persondatalayout_work_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_work_phone)),h.persondatalayout_work_phone<>(typeof(h.persondatalayout_work_phone))'');
    populated_persondatalayout_dob_pcnt := AVE(GROUP,IF(h.persondatalayout_dob = (TYPEOF(h.persondatalayout_dob))'',0,100));
    maxlength_persondatalayout_dob := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dob)));
    avelength_persondatalayout_dob := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dob)),h.persondatalayout_dob<>(typeof(h.persondatalayout_dob))'');
    populated_persondatalayout_dl_pcnt := AVE(GROUP,IF(h.persondatalayout_dl = (TYPEOF(h.persondatalayout_dl))'',0,100));
    maxlength_persondatalayout_dl := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dl)));
    avelength_persondatalayout_dl := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dl)),h.persondatalayout_dl<>(typeof(h.persondatalayout_dl))'');
    populated_persondatalayout_dl_st_pcnt := AVE(GROUP,IF(h.persondatalayout_dl_st = (TYPEOF(h.persondatalayout_dl_st))'',0,100));
    maxlength_persondatalayout_dl_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dl_st)));
    avelength_persondatalayout_dl_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_dl_st)),h.persondatalayout_dl_st<>(typeof(h.persondatalayout_dl_st))'');
    populated_persondatalayout_email_address_pcnt := AVE(GROUP,IF(h.persondatalayout_email_address = (TYPEOF(h.persondatalayout_email_address))'',0,100));
    maxlength_persondatalayout_email_address := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_email_address)));
    avelength_persondatalayout_email_address := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_email_address)),h.persondatalayout_email_address<>(typeof(h.persondatalayout_email_address))'');
    populated_persondatalayout_ssn_pcnt := AVE(GROUP,IF(h.persondatalayout_ssn = (TYPEOF(h.persondatalayout_ssn))'',0,100));
    maxlength_persondatalayout_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_ssn)));
    avelength_persondatalayout_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_ssn)),h.persondatalayout_ssn<>(typeof(h.persondatalayout_ssn))'');
    populated_persondatalayout_linkid_pcnt := AVE(GROUP,IF(h.persondatalayout_linkid = (TYPEOF(h.persondatalayout_linkid))'',0,100));
    maxlength_persondatalayout_linkid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_linkid)));
    avelength_persondatalayout_linkid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_linkid)),h.persondatalayout_linkid<>(typeof(h.persondatalayout_linkid))'');
    populated_persondatalayout_ipaddr_pcnt := AVE(GROUP,IF(h.persondatalayout_ipaddr = (TYPEOF(h.persondatalayout_ipaddr))'',0,100));
    maxlength_persondatalayout_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_ipaddr)));
    avelength_persondatalayout_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_ipaddr)),h.persondatalayout_ipaddr<>(typeof(h.persondatalayout_ipaddr))'');
    populated_persondatalayout_title_pcnt := AVE(GROUP,IF(h.persondatalayout_title = (TYPEOF(h.persondatalayout_title))'',0,100));
    maxlength_persondatalayout_title := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_title)));
    avelength_persondatalayout_title := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_title)),h.persondatalayout_title<>(typeof(h.persondatalayout_title))'');
    populated_persondatalayout_fname_pcnt := AVE(GROUP,IF(h.persondatalayout_fname = (TYPEOF(h.persondatalayout_fname))'',0,100));
    maxlength_persondatalayout_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fname)));
    avelength_persondatalayout_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fname)),h.persondatalayout_fname<>(typeof(h.persondatalayout_fname))'');
    populated_persondatalayout_mname_pcnt := AVE(GROUP,IF(h.persondatalayout_mname = (TYPEOF(h.persondatalayout_mname))'',0,100));
    maxlength_persondatalayout_mname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_mname)));
    avelength_persondatalayout_mname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_mname)),h.persondatalayout_mname<>(typeof(h.persondatalayout_mname))'');
    populated_persondatalayout_lname_pcnt := AVE(GROUP,IF(h.persondatalayout_lname = (TYPEOF(h.persondatalayout_lname))'',0,100));
    maxlength_persondatalayout_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_lname)));
    avelength_persondatalayout_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_lname)),h.persondatalayout_lname<>(typeof(h.persondatalayout_lname))'');
    populated_persondatalayout_name_suffix_pcnt := AVE(GROUP,IF(h.persondatalayout_name_suffix = (TYPEOF(h.persondatalayout_name_suffix))'',0,100));
    maxlength_persondatalayout_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_name_suffix)));
    avelength_persondatalayout_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_name_suffix)),h.persondatalayout_name_suffix<>(typeof(h.persondatalayout_name_suffix))'');
    populated_persondatalayout_prim_range_pcnt := AVE(GROUP,IF(h.persondatalayout_prim_range = (TYPEOF(h.persondatalayout_prim_range))'',0,100));
    maxlength_persondatalayout_prim_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_prim_range)));
    avelength_persondatalayout_prim_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_prim_range)),h.persondatalayout_prim_range<>(typeof(h.persondatalayout_prim_range))'');
    populated_persondatalayout_predir_pcnt := AVE(GROUP,IF(h.persondatalayout_predir = (TYPEOF(h.persondatalayout_predir))'',0,100));
    maxlength_persondatalayout_predir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_predir)));
    avelength_persondatalayout_predir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_predir)),h.persondatalayout_predir<>(typeof(h.persondatalayout_predir))'');
    populated_persondatalayout_prim_name_pcnt := AVE(GROUP,IF(h.persondatalayout_prim_name = (TYPEOF(h.persondatalayout_prim_name))'',0,100));
    maxlength_persondatalayout_prim_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_prim_name)));
    avelength_persondatalayout_prim_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_prim_name)),h.persondatalayout_prim_name<>(typeof(h.persondatalayout_prim_name))'');
    populated_persondatalayout_addr_suffix_pcnt := AVE(GROUP,IF(h.persondatalayout_addr_suffix = (TYPEOF(h.persondatalayout_addr_suffix))'',0,100));
    maxlength_persondatalayout_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_addr_suffix)));
    avelength_persondatalayout_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_addr_suffix)),h.persondatalayout_addr_suffix<>(typeof(h.persondatalayout_addr_suffix))'');
    populated_persondatalayout_postdir_pcnt := AVE(GROUP,IF(h.persondatalayout_postdir = (TYPEOF(h.persondatalayout_postdir))'',0,100));
    maxlength_persondatalayout_postdir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_postdir)));
    avelength_persondatalayout_postdir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_postdir)),h.persondatalayout_postdir<>(typeof(h.persondatalayout_postdir))'');
    populated_persondatalayout_unit_desig_pcnt := AVE(GROUP,IF(h.persondatalayout_unit_desig = (TYPEOF(h.persondatalayout_unit_desig))'',0,100));
    maxlength_persondatalayout_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_unit_desig)));
    avelength_persondatalayout_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_unit_desig)),h.persondatalayout_unit_desig<>(typeof(h.persondatalayout_unit_desig))'');
    populated_persondatalayout_sec_range_pcnt := AVE(GROUP,IF(h.persondatalayout_sec_range = (TYPEOF(h.persondatalayout_sec_range))'',0,100));
    maxlength_persondatalayout_sec_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_sec_range)));
    avelength_persondatalayout_sec_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_sec_range)),h.persondatalayout_sec_range<>(typeof(h.persondatalayout_sec_range))'');
    populated_persondatalayout_v_city_name_pcnt := AVE(GROUP,IF(h.persondatalayout_v_city_name = (TYPEOF(h.persondatalayout_v_city_name))'',0,100));
    maxlength_persondatalayout_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_v_city_name)));
    avelength_persondatalayout_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_v_city_name)),h.persondatalayout_v_city_name<>(typeof(h.persondatalayout_v_city_name))'');
    populated_persondatalayout_st_pcnt := AVE(GROUP,IF(h.persondatalayout_st = (TYPEOF(h.persondatalayout_st))'',0,100));
    maxlength_persondatalayout_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_st)));
    avelength_persondatalayout_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_st)),h.persondatalayout_st<>(typeof(h.persondatalayout_st))'');
    populated_persondatalayout_zip5_pcnt := AVE(GROUP,IF(h.persondatalayout_zip5 = (TYPEOF(h.persondatalayout_zip5))'',0,100));
    maxlength_persondatalayout_zip5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip5)));
    avelength_persondatalayout_zip5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip5)),h.persondatalayout_zip5<>(typeof(h.persondatalayout_zip5))'');
    populated_persondatalayout_zip4_pcnt := AVE(GROUP,IF(h.persondatalayout_zip4 = (TYPEOF(h.persondatalayout_zip4))'',0,100));
    maxlength_persondatalayout_zip4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip4)));
    avelength_persondatalayout_zip4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_zip4)),h.persondatalayout_zip4<>(typeof(h.persondatalayout_zip4))'');
    populated_persondatalayout_addr_rec_type_pcnt := AVE(GROUP,IF(h.persondatalayout_addr_rec_type = (TYPEOF(h.persondatalayout_addr_rec_type))'',0,100));
    maxlength_persondatalayout_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_addr_rec_type)));
    avelength_persondatalayout_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_addr_rec_type)),h.persondatalayout_addr_rec_type<>(typeof(h.persondatalayout_addr_rec_type))'');
    populated_persondatalayout_fips_state_pcnt := AVE(GROUP,IF(h.persondatalayout_fips_state = (TYPEOF(h.persondatalayout_fips_state))'',0,100));
    maxlength_persondatalayout_fips_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fips_state)));
    avelength_persondatalayout_fips_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fips_state)),h.persondatalayout_fips_state<>(typeof(h.persondatalayout_fips_state))'');
    populated_persondatalayout_fips_county_pcnt := AVE(GROUP,IF(h.persondatalayout_fips_county = (TYPEOF(h.persondatalayout_fips_county))'',0,100));
    maxlength_persondatalayout_fips_county := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fips_county)));
    avelength_persondatalayout_fips_county := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_fips_county)),h.persondatalayout_fips_county<>(typeof(h.persondatalayout_fips_county))'');
    populated_persondatalayout_geo_lat_pcnt := AVE(GROUP,IF(h.persondatalayout_geo_lat = (TYPEOF(h.persondatalayout_geo_lat))'',0,100));
    maxlength_persondatalayout_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_lat)));
    avelength_persondatalayout_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_lat)),h.persondatalayout_geo_lat<>(typeof(h.persondatalayout_geo_lat))'');
    populated_persondatalayout_geo_long_pcnt := AVE(GROUP,IF(h.persondatalayout_geo_long = (TYPEOF(h.persondatalayout_geo_long))'',0,100));
    maxlength_persondatalayout_geo_long := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_long)));
    avelength_persondatalayout_geo_long := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_long)),h.persondatalayout_geo_long<>(typeof(h.persondatalayout_geo_long))'');
    populated_persondatalayout_cbsa_pcnt := AVE(GROUP,IF(h.persondatalayout_cbsa = (TYPEOF(h.persondatalayout_cbsa))'',0,100));
    maxlength_persondatalayout_cbsa := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_cbsa)));
    avelength_persondatalayout_cbsa := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_cbsa)),h.persondatalayout_cbsa<>(typeof(h.persondatalayout_cbsa))'');
    populated_persondatalayout_geo_blk_pcnt := AVE(GROUP,IF(h.persondatalayout_geo_blk = (TYPEOF(h.persondatalayout_geo_blk))'',0,100));
    maxlength_persondatalayout_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_blk)));
    avelength_persondatalayout_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_blk)),h.persondatalayout_geo_blk<>(typeof(h.persondatalayout_geo_blk))'');
    populated_persondatalayout_geo_match_pcnt := AVE(GROUP,IF(h.persondatalayout_geo_match = (TYPEOF(h.persondatalayout_geo_match))'',0,100));
    maxlength_persondatalayout_geo_match := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_match)));
    avelength_persondatalayout_geo_match := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_geo_match)),h.persondatalayout_geo_match<>(typeof(h.persondatalayout_geo_match))'');
    populated_persondatalayout_err_stat_pcnt := AVE(GROUP,IF(h.persondatalayout_err_stat = (TYPEOF(h.persondatalayout_err_stat))'',0,100));
    maxlength_persondatalayout_err_stat := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_err_stat)));
    avelength_persondatalayout_err_stat := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_err_stat)),h.persondatalayout_err_stat<>(typeof(h.persondatalayout_err_stat))'');
    populated_persondatalayout_appended_ssn_pcnt := AVE(GROUP,IF(h.persondatalayout_appended_ssn = (TYPEOF(h.persondatalayout_appended_ssn))'',0,100));
    maxlength_persondatalayout_appended_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_appended_ssn)));
    avelength_persondatalayout_appended_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_appended_ssn)),h.persondatalayout_appended_ssn<>(typeof(h.persondatalayout_appended_ssn))'');
    populated_persondatalayout_appended_adl_pcnt := AVE(GROUP,IF(h.persondatalayout_appended_adl = (TYPEOF(h.persondatalayout_appended_adl))'',0,100));
    maxlength_persondatalayout_appended_adl := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_appended_adl)));
    avelength_persondatalayout_appended_adl := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.persondatalayout_appended_adl)),h.persondatalayout_appended_adl<>(typeof(h.persondatalayout_appended_adl))'');
    populated_permissablelayout_glb_purpose_pcnt := AVE(GROUP,IF(h.permissablelayout_glb_purpose = (TYPEOF(h.permissablelayout_glb_purpose))'',0,100));
    maxlength_permissablelayout_glb_purpose := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_glb_purpose)));
    avelength_permissablelayout_glb_purpose := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_glb_purpose)),h.permissablelayout_glb_purpose<>(typeof(h.permissablelayout_glb_purpose))'');
    populated_permissablelayout_dppa_purpose_pcnt := AVE(GROUP,IF(h.permissablelayout_dppa_purpose = (TYPEOF(h.permissablelayout_dppa_purpose))'',0,100));
    maxlength_permissablelayout_dppa_purpose := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_dppa_purpose)));
    avelength_permissablelayout_dppa_purpose := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_dppa_purpose)),h.permissablelayout_dppa_purpose<>(typeof(h.permissablelayout_dppa_purpose))'');
    populated_permissablelayout_fcra_purpose_pcnt := AVE(GROUP,IF(h.permissablelayout_fcra_purpose = (TYPEOF(h.permissablelayout_fcra_purpose))'',0,100));
    maxlength_permissablelayout_fcra_purpose := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_fcra_purpose)));
    avelength_permissablelayout_fcra_purpose := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.permissablelayout_fcra_purpose)),h.permissablelayout_fcra_purpose<>(typeof(h.permissablelayout_fcra_purpose))'');
    populated_searchlayout_datetime_pcnt := AVE(GROUP,IF(h.searchlayout_datetime = (TYPEOF(h.searchlayout_datetime))'',0,100));
    maxlength_searchlayout_datetime := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_datetime)));
    avelength_searchlayout_datetime := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_datetime)),h.searchlayout_datetime<>(typeof(h.searchlayout_datetime))'');
    populated_searchlayout_start_monitor_pcnt := AVE(GROUP,IF(h.searchlayout_start_monitor = (TYPEOF(h.searchlayout_start_monitor))'',0,100));
    maxlength_searchlayout_start_monitor := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_start_monitor)));
    avelength_searchlayout_start_monitor := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_start_monitor)),h.searchlayout_start_monitor<>(typeof(h.searchlayout_start_monitor))'');
    populated_searchlayout_stop_monitor_pcnt := AVE(GROUP,IF(h.searchlayout_stop_monitor = (TYPEOF(h.searchlayout_stop_monitor))'',0,100));
    maxlength_searchlayout_stop_monitor := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_stop_monitor)));
    avelength_searchlayout_stop_monitor := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_stop_monitor)),h.searchlayout_stop_monitor<>(typeof(h.searchlayout_stop_monitor))'');
    populated_searchlayout_login_history_id_pcnt := AVE(GROUP,IF(h.searchlayout_login_history_id = (TYPEOF(h.searchlayout_login_history_id))'',0,100));
    maxlength_searchlayout_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_login_history_id)));
    avelength_searchlayout_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_login_history_id)),h.searchlayout_login_history_id<>(typeof(h.searchlayout_login_history_id))'');
    populated_searchlayout_transaction_id_pcnt := AVE(GROUP,IF(h.searchlayout_transaction_id = (TYPEOF(h.searchlayout_transaction_id))'',0,100));
    maxlength_searchlayout_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_transaction_id)));
    avelength_searchlayout_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_transaction_id)),h.searchlayout_transaction_id<>(typeof(h.searchlayout_transaction_id))'');
    populated_searchlayout_sequence_number_pcnt := AVE(GROUP,IF(h.searchlayout_sequence_number = (TYPEOF(h.searchlayout_sequence_number))'',0,100));
    maxlength_searchlayout_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_sequence_number)));
    avelength_searchlayout_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_sequence_number)),h.searchlayout_sequence_number<>(typeof(h.searchlayout_sequence_number))'');
    populated_searchlayout_method_pcnt := AVE(GROUP,IF(h.searchlayout_method = (TYPEOF(h.searchlayout_method))'',0,100));
    maxlength_searchlayout_method := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_method)));
    avelength_searchlayout_method := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_method)),h.searchlayout_method<>(typeof(h.searchlayout_method))'');
    populated_searchlayout_product_code_pcnt := AVE(GROUP,IF(h.searchlayout_product_code = (TYPEOF(h.searchlayout_product_code))'',0,100));
    maxlength_searchlayout_product_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_product_code)));
    avelength_searchlayout_product_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_product_code)),h.searchlayout_product_code<>(typeof(h.searchlayout_product_code))'');
    populated_searchlayout_transaction_type_pcnt := AVE(GROUP,IF(h.searchlayout_transaction_type = (TYPEOF(h.searchlayout_transaction_type))'',0,100));
    maxlength_searchlayout_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_transaction_type)));
    avelength_searchlayout_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_transaction_type)),h.searchlayout_transaction_type<>(typeof(h.searchlayout_transaction_type))'');
    populated_searchlayout_function_description_pcnt := AVE(GROUP,IF(h.searchlayout_function_description = (TYPEOF(h.searchlayout_function_description))'',0,100));
    maxlength_searchlayout_function_description := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_function_description)));
    avelength_searchlayout_function_description := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_function_description)),h.searchlayout_function_description<>(typeof(h.searchlayout_function_description))'');
    populated_searchlayout_ipaddr_pcnt := AVE(GROUP,IF(h.searchlayout_ipaddr = (TYPEOF(h.searchlayout_ipaddr))'',0,100));
    maxlength_searchlayout_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_ipaddr)));
    avelength_searchlayout_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.searchlayout_ipaddr)),h.searchlayout_ipaddr<>(typeof(h.searchlayout_ipaddr))'');
    populated_fraudpoint_score_pcnt := AVE(GROUP,IF(h.fraudpoint_score = (TYPEOF(h.fraudpoint_score))'',0,100));
    maxlength_fraudpoint_score := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fraudpoint_score)));
    avelength_fraudpoint_score := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fraudpoint_score)),h.fraudpoint_score<>(typeof(h.fraudpoint_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_mbslayout_company_id_pcnt *   0.00 / 100 + T.Populated_mbslayout_global_company_id_pcnt *   0.00 / 100 + T.Populated_allowlayout_allowflags_pcnt *   0.00 / 100 + T.Populated_businfolayout_primary_market_code_pcnt *   0.00 / 100 + T.Populated_businfolayout_secondary_market_code_pcnt *   0.00 / 100 + T.Populated_businfolayout_industry_1_code_pcnt *   0.00 / 100 + T.Populated_businfolayout_industry_2_code_pcnt *   0.00 / 100 + T.Populated_businfolayout_sub_market_pcnt *   0.00 / 100 + T.Populated_businfolayout_vertical_pcnt *   0.00 / 100 + T.Populated_businfolayout_use_pcnt *   0.00 / 100 + T.Populated_businfolayout_industry_pcnt *   0.00 / 100 + T.Populated_persondatalayout_full_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_first_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_middle_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_last_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_address_pcnt *   0.00 / 100 + T.Populated_persondatalayout_city_pcnt *   0.00 / 100 + T.Populated_persondatalayout_state_pcnt *   0.00 / 100 + T.Populated_persondatalayout_zip_pcnt *   0.00 / 100 + T.Populated_persondatalayout_personal_phone_pcnt *   0.00 / 100 + T.Populated_persondatalayout_work_phone_pcnt *   0.00 / 100 + T.Populated_persondatalayout_dob_pcnt *   0.00 / 100 + T.Populated_persondatalayout_dl_pcnt *   0.00 / 100 + T.Populated_persondatalayout_dl_st_pcnt *   0.00 / 100 + T.Populated_persondatalayout_email_address_pcnt *   0.00 / 100 + T.Populated_persondatalayout_ssn_pcnt *   0.00 / 100 + T.Populated_persondatalayout_linkid_pcnt *   0.00 / 100 + T.Populated_persondatalayout_ipaddr_pcnt *   0.00 / 100 + T.Populated_persondatalayout_title_pcnt *   0.00 / 100 + T.Populated_persondatalayout_fname_pcnt *   0.00 / 100 + T.Populated_persondatalayout_mname_pcnt *   0.00 / 100 + T.Populated_persondatalayout_lname_pcnt *   0.00 / 100 + T.Populated_persondatalayout_name_suffix_pcnt *   0.00 / 100 + T.Populated_persondatalayout_prim_range_pcnt *   0.00 / 100 + T.Populated_persondatalayout_predir_pcnt *   0.00 / 100 + T.Populated_persondatalayout_prim_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_addr_suffix_pcnt *   0.00 / 100 + T.Populated_persondatalayout_postdir_pcnt *   0.00 / 100 + T.Populated_persondatalayout_unit_desig_pcnt *   0.00 / 100 + T.Populated_persondatalayout_sec_range_pcnt *   0.00 / 100 + T.Populated_persondatalayout_v_city_name_pcnt *   0.00 / 100 + T.Populated_persondatalayout_st_pcnt *   0.00 / 100 + T.Populated_persondatalayout_zip5_pcnt *   0.00 / 100 + T.Populated_persondatalayout_zip4_pcnt *   0.00 / 100 + T.Populated_persondatalayout_addr_rec_type_pcnt *   0.00 / 100 + T.Populated_persondatalayout_fips_state_pcnt *   0.00 / 100 + T.Populated_persondatalayout_fips_county_pcnt *   0.00 / 100 + T.Populated_persondatalayout_geo_lat_pcnt *   0.00 / 100 + T.Populated_persondatalayout_geo_long_pcnt *   0.00 / 100 + T.Populated_persondatalayout_cbsa_pcnt *   0.00 / 100 + T.Populated_persondatalayout_geo_blk_pcnt *   0.00 / 100 + T.Populated_persondatalayout_geo_match_pcnt *   0.00 / 100 + T.Populated_persondatalayout_err_stat_pcnt *   0.00 / 100 + T.Populated_persondatalayout_appended_ssn_pcnt *   0.00 / 100 + T.Populated_persondatalayout_appended_adl_pcnt *   0.00 / 100 + T.Populated_permissablelayout_glb_purpose_pcnt *   0.00 / 100 + T.Populated_permissablelayout_dppa_purpose_pcnt *   0.00 / 100 + T.Populated_permissablelayout_fcra_purpose_pcnt *   0.00 / 100 + T.Populated_searchlayout_datetime_pcnt *   0.00 / 100 + T.Populated_searchlayout_start_monitor_pcnt *   0.00 / 100 + T.Populated_searchlayout_stop_monitor_pcnt *   0.00 / 100 + T.Populated_searchlayout_login_history_id_pcnt *   0.00 / 100 + T.Populated_searchlayout_transaction_id_pcnt *   0.00 / 100 + T.Populated_searchlayout_sequence_number_pcnt *   0.00 / 100 + T.Populated_searchlayout_method_pcnt *   0.00 / 100 + T.Populated_searchlayout_product_code_pcnt *   0.00 / 100 + T.Populated_searchlayout_transaction_type_pcnt *   0.00 / 100 + T.Populated_searchlayout_function_description_pcnt *   0.00 / 100 + T.Populated_searchlayout_ipaddr_pcnt *   0.00 / 100 + T.Populated_fraudpoint_score_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_mbslayout_company_id_pcnt,le.populated_mbslayout_global_company_id_pcnt,le.populated_allowlayout_allowflags_pcnt,le.populated_businfolayout_primary_market_code_pcnt,le.populated_businfolayout_secondary_market_code_pcnt,le.populated_businfolayout_industry_1_code_pcnt,le.populated_businfolayout_industry_2_code_pcnt,le.populated_businfolayout_sub_market_pcnt,le.populated_businfolayout_vertical_pcnt,le.populated_businfolayout_use_pcnt,le.populated_businfolayout_industry_pcnt,le.populated_persondatalayout_full_name_pcnt,le.populated_persondatalayout_first_name_pcnt,le.populated_persondatalayout_middle_name_pcnt,le.populated_persondatalayout_last_name_pcnt,le.populated_persondatalayout_address_pcnt,le.populated_persondatalayout_city_pcnt,le.populated_persondatalayout_state_pcnt,le.populated_persondatalayout_zip_pcnt,le.populated_persondatalayout_personal_phone_pcnt,le.populated_persondatalayout_work_phone_pcnt,le.populated_persondatalayout_dob_pcnt,le.populated_persondatalayout_dl_pcnt,le.populated_persondatalayout_dl_st_pcnt,le.populated_persondatalayout_email_address_pcnt,le.populated_persondatalayout_ssn_pcnt,le.populated_persondatalayout_linkid_pcnt,le.populated_persondatalayout_ipaddr_pcnt,le.populated_persondatalayout_title_pcnt,le.populated_persondatalayout_fname_pcnt,le.populated_persondatalayout_mname_pcnt,le.populated_persondatalayout_lname_pcnt,le.populated_persondatalayout_name_suffix_pcnt,le.populated_persondatalayout_prim_range_pcnt,le.populated_persondatalayout_predir_pcnt,le.populated_persondatalayout_prim_name_pcnt,le.populated_persondatalayout_addr_suffix_pcnt,le.populated_persondatalayout_postdir_pcnt,le.populated_persondatalayout_unit_desig_pcnt,le.populated_persondatalayout_sec_range_pcnt,le.populated_persondatalayout_v_city_name_pcnt,le.populated_persondatalayout_st_pcnt,le.populated_persondatalayout_zip5_pcnt,le.populated_persondatalayout_zip4_pcnt,le.populated_persondatalayout_addr_rec_type_pcnt,le.populated_persondatalayout_fips_state_pcnt,le.populated_persondatalayout_fips_county_pcnt,le.populated_persondatalayout_geo_lat_pcnt,le.populated_persondatalayout_geo_long_pcnt,le.populated_persondatalayout_cbsa_pcnt,le.populated_persondatalayout_geo_blk_pcnt,le.populated_persondatalayout_geo_match_pcnt,le.populated_persondatalayout_err_stat_pcnt,le.populated_persondatalayout_appended_ssn_pcnt,le.populated_persondatalayout_appended_adl_pcnt,le.populated_permissablelayout_glb_purpose_pcnt,le.populated_permissablelayout_dppa_purpose_pcnt,le.populated_permissablelayout_fcra_purpose_pcnt,le.populated_searchlayout_datetime_pcnt,le.populated_searchlayout_start_monitor_pcnt,le.populated_searchlayout_stop_monitor_pcnt,le.populated_searchlayout_login_history_id_pcnt,le.populated_searchlayout_transaction_id_pcnt,le.populated_searchlayout_sequence_number_pcnt,le.populated_searchlayout_method_pcnt,le.populated_searchlayout_product_code_pcnt,le.populated_searchlayout_transaction_type_pcnt,le.populated_searchlayout_function_description_pcnt,le.populated_searchlayout_ipaddr_pcnt,le.populated_fraudpoint_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_mbslayout_company_id,le.maxlength_mbslayout_global_company_id,le.maxlength_allowlayout_allowflags,le.maxlength_businfolayout_primary_market_code,le.maxlength_businfolayout_secondary_market_code,le.maxlength_businfolayout_industry_1_code,le.maxlength_businfolayout_industry_2_code,le.maxlength_businfolayout_sub_market,le.maxlength_businfolayout_vertical,le.maxlength_businfolayout_use,le.maxlength_businfolayout_industry,le.maxlength_persondatalayout_full_name,le.maxlength_persondatalayout_first_name,le.maxlength_persondatalayout_middle_name,le.maxlength_persondatalayout_last_name,le.maxlength_persondatalayout_address,le.maxlength_persondatalayout_city,le.maxlength_persondatalayout_state,le.maxlength_persondatalayout_zip,le.maxlength_persondatalayout_personal_phone,le.maxlength_persondatalayout_work_phone,le.maxlength_persondatalayout_dob,le.maxlength_persondatalayout_dl,le.maxlength_persondatalayout_dl_st,le.maxlength_persondatalayout_email_address,le.maxlength_persondatalayout_ssn,le.maxlength_persondatalayout_linkid,le.maxlength_persondatalayout_ipaddr,le.maxlength_persondatalayout_title,le.maxlength_persondatalayout_fname,le.maxlength_persondatalayout_mname,le.maxlength_persondatalayout_lname,le.maxlength_persondatalayout_name_suffix,le.maxlength_persondatalayout_prim_range,le.maxlength_persondatalayout_predir,le.maxlength_persondatalayout_prim_name,le.maxlength_persondatalayout_addr_suffix,le.maxlength_persondatalayout_postdir,le.maxlength_persondatalayout_unit_desig,le.maxlength_persondatalayout_sec_range,le.maxlength_persondatalayout_v_city_name,le.maxlength_persondatalayout_st,le.maxlength_persondatalayout_zip5,le.maxlength_persondatalayout_zip4,le.maxlength_persondatalayout_addr_rec_type,le.maxlength_persondatalayout_fips_state,le.maxlength_persondatalayout_fips_county,le.maxlength_persondatalayout_geo_lat,le.maxlength_persondatalayout_geo_long,le.maxlength_persondatalayout_cbsa,le.maxlength_persondatalayout_geo_blk,le.maxlength_persondatalayout_geo_match,le.maxlength_persondatalayout_err_stat,le.maxlength_persondatalayout_appended_ssn,le.maxlength_persondatalayout_appended_adl,le.maxlength_permissablelayout_glb_purpose,le.maxlength_permissablelayout_dppa_purpose,le.maxlength_permissablelayout_fcra_purpose,le.maxlength_searchlayout_datetime,le.maxlength_searchlayout_start_monitor,le.maxlength_searchlayout_stop_monitor,le.maxlength_searchlayout_login_history_id,le.maxlength_searchlayout_transaction_id,le.maxlength_searchlayout_sequence_number,le.maxlength_searchlayout_method,le.maxlength_searchlayout_product_code,le.maxlength_searchlayout_transaction_type,le.maxlength_searchlayout_function_description,le.maxlength_searchlayout_ipaddr,le.maxlength_fraudpoint_score);
  SELF.avelength := CHOOSE(C,le.avelength_mbslayout_company_id,le.avelength_mbslayout_global_company_id,le.avelength_allowlayout_allowflags,le.avelength_businfolayout_primary_market_code,le.avelength_businfolayout_secondary_market_code,le.avelength_businfolayout_industry_1_code,le.avelength_businfolayout_industry_2_code,le.avelength_businfolayout_sub_market,le.avelength_businfolayout_vertical,le.avelength_businfolayout_use,le.avelength_businfolayout_industry,le.avelength_persondatalayout_full_name,le.avelength_persondatalayout_first_name,le.avelength_persondatalayout_middle_name,le.avelength_persondatalayout_last_name,le.avelength_persondatalayout_address,le.avelength_persondatalayout_city,le.avelength_persondatalayout_state,le.avelength_persondatalayout_zip,le.avelength_persondatalayout_personal_phone,le.avelength_persondatalayout_work_phone,le.avelength_persondatalayout_dob,le.avelength_persondatalayout_dl,le.avelength_persondatalayout_dl_st,le.avelength_persondatalayout_email_address,le.avelength_persondatalayout_ssn,le.avelength_persondatalayout_linkid,le.avelength_persondatalayout_ipaddr,le.avelength_persondatalayout_title,le.avelength_persondatalayout_fname,le.avelength_persondatalayout_mname,le.avelength_persondatalayout_lname,le.avelength_persondatalayout_name_suffix,le.avelength_persondatalayout_prim_range,le.avelength_persondatalayout_predir,le.avelength_persondatalayout_prim_name,le.avelength_persondatalayout_addr_suffix,le.avelength_persondatalayout_postdir,le.avelength_persondatalayout_unit_desig,le.avelength_persondatalayout_sec_range,le.avelength_persondatalayout_v_city_name,le.avelength_persondatalayout_st,le.avelength_persondatalayout_zip5,le.avelength_persondatalayout_zip4,le.avelength_persondatalayout_addr_rec_type,le.avelength_persondatalayout_fips_state,le.avelength_persondatalayout_fips_county,le.avelength_persondatalayout_geo_lat,le.avelength_persondatalayout_geo_long,le.avelength_persondatalayout_cbsa,le.avelength_persondatalayout_geo_blk,le.avelength_persondatalayout_geo_match,le.avelength_persondatalayout_err_stat,le.avelength_persondatalayout_appended_ssn,le.avelength_persondatalayout_appended_adl,le.avelength_permissablelayout_glb_purpose,le.avelength_permissablelayout_dppa_purpose,le.avelength_permissablelayout_fcra_purpose,le.avelength_searchlayout_datetime,le.avelength_searchlayout_start_monitor,le.avelength_searchlayout_stop_monitor,le.avelength_searchlayout_login_history_id,le.avelength_searchlayout_transaction_id,le.avelength_searchlayout_sequence_number,le.avelength_searchlayout_method,le.avelength_searchlayout_product_code,le.avelength_searchlayout_transaction_type,le.avelength_searchlayout_function_description,le.avelength_searchlayout_ipaddr,le.avelength_fraudpoint_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 70, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.mbslayout_company_id),TRIM((SALT32.StrType)le.mbslayout_global_company_id),IF (le.allowlayout_allowflags <> 0,TRIM((SALT32.StrType)le.allowlayout_allowflags), ''),TRIM((SALT32.StrType)le.businfolayout_primary_market_code),TRIM((SALT32.StrType)le.businfolayout_secondary_market_code),TRIM((SALT32.StrType)le.businfolayout_industry_1_code),TRIM((SALT32.StrType)le.businfolayout_industry_2_code),TRIM((SALT32.StrType)le.businfolayout_sub_market),TRIM((SALT32.StrType)le.businfolayout_vertical),TRIM((SALT32.StrType)le.businfolayout_use),TRIM((SALT32.StrType)le.businfolayout_industry),TRIM((SALT32.StrType)le.persondatalayout_full_name),TRIM((SALT32.StrType)le.persondatalayout_first_name),TRIM((SALT32.StrType)le.persondatalayout_middle_name),TRIM((SALT32.StrType)le.persondatalayout_last_name),TRIM((SALT32.StrType)le.persondatalayout_address),TRIM((SALT32.StrType)le.persondatalayout_city),TRIM((SALT32.StrType)le.persondatalayout_state),TRIM((SALT32.StrType)le.persondatalayout_zip),TRIM((SALT32.StrType)le.persondatalayout_personal_phone),TRIM((SALT32.StrType)le.persondatalayout_work_phone),TRIM((SALT32.StrType)le.persondatalayout_dob),TRIM((SALT32.StrType)le.persondatalayout_dl),TRIM((SALT32.StrType)le.persondatalayout_dl_st),TRIM((SALT32.StrType)le.persondatalayout_email_address),TRIM((SALT32.StrType)le.persondatalayout_ssn),TRIM((SALT32.StrType)le.persondatalayout_linkid),TRIM((SALT32.StrType)le.persondatalayout_ipaddr),TRIM((SALT32.StrType)le.persondatalayout_title),TRIM((SALT32.StrType)le.persondatalayout_fname),TRIM((SALT32.StrType)le.persondatalayout_mname),TRIM((SALT32.StrType)le.persondatalayout_lname),TRIM((SALT32.StrType)le.persondatalayout_name_suffix),TRIM((SALT32.StrType)le.persondatalayout_prim_range),TRIM((SALT32.StrType)le.persondatalayout_predir),TRIM((SALT32.StrType)le.persondatalayout_prim_name),TRIM((SALT32.StrType)le.persondatalayout_addr_suffix),TRIM((SALT32.StrType)le.persondatalayout_postdir),TRIM((SALT32.StrType)le.persondatalayout_unit_desig),TRIM((SALT32.StrType)le.persondatalayout_sec_range),TRIM((SALT32.StrType)le.persondatalayout_v_city_name),TRIM((SALT32.StrType)le.persondatalayout_st),TRIM((SALT32.StrType)le.persondatalayout_zip5),TRIM((SALT32.StrType)le.persondatalayout_zip4),TRIM((SALT32.StrType)le.persondatalayout_addr_rec_type),TRIM((SALT32.StrType)le.persondatalayout_fips_state),TRIM((SALT32.StrType)le.persondatalayout_fips_county),TRIM((SALT32.StrType)le.persondatalayout_geo_lat),TRIM((SALT32.StrType)le.persondatalayout_geo_long),TRIM((SALT32.StrType)le.persondatalayout_cbsa),TRIM((SALT32.StrType)le.persondatalayout_geo_blk),TRIM((SALT32.StrType)le.persondatalayout_geo_match),TRIM((SALT32.StrType)le.persondatalayout_err_stat),TRIM((SALT32.StrType)le.persondatalayout_appended_ssn),IF (le.persondatalayout_appended_adl <> 0,TRIM((SALT32.StrType)le.persondatalayout_appended_adl), ''),TRIM((SALT32.StrType)le.permissablelayout_glb_purpose),TRIM((SALT32.StrType)le.permissablelayout_dppa_purpose),TRIM((SALT32.StrType)le.permissablelayout_fcra_purpose),TRIM((SALT32.StrType)le.searchlayout_datetime),TRIM((SALT32.StrType)le.searchlayout_start_monitor),TRIM((SALT32.StrType)le.searchlayout_stop_monitor),TRIM((SALT32.StrType)le.searchlayout_login_history_id),TRIM((SALT32.StrType)le.searchlayout_transaction_id),TRIM((SALT32.StrType)le.searchlayout_sequence_number),TRIM((SALT32.StrType)le.searchlayout_method),TRIM((SALT32.StrType)le.searchlayout_product_code),TRIM((SALT32.StrType)le.searchlayout_transaction_type),TRIM((SALT32.StrType)le.searchlayout_function_description),TRIM((SALT32.StrType)le.searchlayout_ipaddr),TRIM((SALT32.StrType)le.fraudpoint_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,70,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 70);
  SELF.FldNo2 := 1 + (C % 70);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.mbslayout_company_id),TRIM((SALT32.StrType)le.mbslayout_global_company_id),IF (le.allowlayout_allowflags <> 0,TRIM((SALT32.StrType)le.allowlayout_allowflags), ''),TRIM((SALT32.StrType)le.businfolayout_primary_market_code),TRIM((SALT32.StrType)le.businfolayout_secondary_market_code),TRIM((SALT32.StrType)le.businfolayout_industry_1_code),TRIM((SALT32.StrType)le.businfolayout_industry_2_code),TRIM((SALT32.StrType)le.businfolayout_sub_market),TRIM((SALT32.StrType)le.businfolayout_vertical),TRIM((SALT32.StrType)le.businfolayout_use),TRIM((SALT32.StrType)le.businfolayout_industry),TRIM((SALT32.StrType)le.persondatalayout_full_name),TRIM((SALT32.StrType)le.persondatalayout_first_name),TRIM((SALT32.StrType)le.persondatalayout_middle_name),TRIM((SALT32.StrType)le.persondatalayout_last_name),TRIM((SALT32.StrType)le.persondatalayout_address),TRIM((SALT32.StrType)le.persondatalayout_city),TRIM((SALT32.StrType)le.persondatalayout_state),TRIM((SALT32.StrType)le.persondatalayout_zip),TRIM((SALT32.StrType)le.persondatalayout_personal_phone),TRIM((SALT32.StrType)le.persondatalayout_work_phone),TRIM((SALT32.StrType)le.persondatalayout_dob),TRIM((SALT32.StrType)le.persondatalayout_dl),TRIM((SALT32.StrType)le.persondatalayout_dl_st),TRIM((SALT32.StrType)le.persondatalayout_email_address),TRIM((SALT32.StrType)le.persondatalayout_ssn),TRIM((SALT32.StrType)le.persondatalayout_linkid),TRIM((SALT32.StrType)le.persondatalayout_ipaddr),TRIM((SALT32.StrType)le.persondatalayout_title),TRIM((SALT32.StrType)le.persondatalayout_fname),TRIM((SALT32.StrType)le.persondatalayout_mname),TRIM((SALT32.StrType)le.persondatalayout_lname),TRIM((SALT32.StrType)le.persondatalayout_name_suffix),TRIM((SALT32.StrType)le.persondatalayout_prim_range),TRIM((SALT32.StrType)le.persondatalayout_predir),TRIM((SALT32.StrType)le.persondatalayout_prim_name),TRIM((SALT32.StrType)le.persondatalayout_addr_suffix),TRIM((SALT32.StrType)le.persondatalayout_postdir),TRIM((SALT32.StrType)le.persondatalayout_unit_desig),TRIM((SALT32.StrType)le.persondatalayout_sec_range),TRIM((SALT32.StrType)le.persondatalayout_v_city_name),TRIM((SALT32.StrType)le.persondatalayout_st),TRIM((SALT32.StrType)le.persondatalayout_zip5),TRIM((SALT32.StrType)le.persondatalayout_zip4),TRIM((SALT32.StrType)le.persondatalayout_addr_rec_type),TRIM((SALT32.StrType)le.persondatalayout_fips_state),TRIM((SALT32.StrType)le.persondatalayout_fips_county),TRIM((SALT32.StrType)le.persondatalayout_geo_lat),TRIM((SALT32.StrType)le.persondatalayout_geo_long),TRIM((SALT32.StrType)le.persondatalayout_cbsa),TRIM((SALT32.StrType)le.persondatalayout_geo_blk),TRIM((SALT32.StrType)le.persondatalayout_geo_match),TRIM((SALT32.StrType)le.persondatalayout_err_stat),TRIM((SALT32.StrType)le.persondatalayout_appended_ssn),IF (le.persondatalayout_appended_adl <> 0,TRIM((SALT32.StrType)le.persondatalayout_appended_adl), ''),TRIM((SALT32.StrType)le.permissablelayout_glb_purpose),TRIM((SALT32.StrType)le.permissablelayout_dppa_purpose),TRIM((SALT32.StrType)le.permissablelayout_fcra_purpose),TRIM((SALT32.StrType)le.searchlayout_datetime),TRIM((SALT32.StrType)le.searchlayout_start_monitor),TRIM((SALT32.StrType)le.searchlayout_stop_monitor),TRIM((SALT32.StrType)le.searchlayout_login_history_id),TRIM((SALT32.StrType)le.searchlayout_transaction_id),TRIM((SALT32.StrType)le.searchlayout_sequence_number),TRIM((SALT32.StrType)le.searchlayout_method),TRIM((SALT32.StrType)le.searchlayout_product_code),TRIM((SALT32.StrType)le.searchlayout_transaction_type),TRIM((SALT32.StrType)le.searchlayout_function_description),TRIM((SALT32.StrType)le.searchlayout_ipaddr),TRIM((SALT32.StrType)le.fraudpoint_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.mbslayout_company_id),TRIM((SALT32.StrType)le.mbslayout_global_company_id),IF (le.allowlayout_allowflags <> 0,TRIM((SALT32.StrType)le.allowlayout_allowflags), ''),TRIM((SALT32.StrType)le.businfolayout_primary_market_code),TRIM((SALT32.StrType)le.businfolayout_secondary_market_code),TRIM((SALT32.StrType)le.businfolayout_industry_1_code),TRIM((SALT32.StrType)le.businfolayout_industry_2_code),TRIM((SALT32.StrType)le.businfolayout_sub_market),TRIM((SALT32.StrType)le.businfolayout_vertical),TRIM((SALT32.StrType)le.businfolayout_use),TRIM((SALT32.StrType)le.businfolayout_industry),TRIM((SALT32.StrType)le.persondatalayout_full_name),TRIM((SALT32.StrType)le.persondatalayout_first_name),TRIM((SALT32.StrType)le.persondatalayout_middle_name),TRIM((SALT32.StrType)le.persondatalayout_last_name),TRIM((SALT32.StrType)le.persondatalayout_address),TRIM((SALT32.StrType)le.persondatalayout_city),TRIM((SALT32.StrType)le.persondatalayout_state),TRIM((SALT32.StrType)le.persondatalayout_zip),TRIM((SALT32.StrType)le.persondatalayout_personal_phone),TRIM((SALT32.StrType)le.persondatalayout_work_phone),TRIM((SALT32.StrType)le.persondatalayout_dob),TRIM((SALT32.StrType)le.persondatalayout_dl),TRIM((SALT32.StrType)le.persondatalayout_dl_st),TRIM((SALT32.StrType)le.persondatalayout_email_address),TRIM((SALT32.StrType)le.persondatalayout_ssn),TRIM((SALT32.StrType)le.persondatalayout_linkid),TRIM((SALT32.StrType)le.persondatalayout_ipaddr),TRIM((SALT32.StrType)le.persondatalayout_title),TRIM((SALT32.StrType)le.persondatalayout_fname),TRIM((SALT32.StrType)le.persondatalayout_mname),TRIM((SALT32.StrType)le.persondatalayout_lname),TRIM((SALT32.StrType)le.persondatalayout_name_suffix),TRIM((SALT32.StrType)le.persondatalayout_prim_range),TRIM((SALT32.StrType)le.persondatalayout_predir),TRIM((SALT32.StrType)le.persondatalayout_prim_name),TRIM((SALT32.StrType)le.persondatalayout_addr_suffix),TRIM((SALT32.StrType)le.persondatalayout_postdir),TRIM((SALT32.StrType)le.persondatalayout_unit_desig),TRIM((SALT32.StrType)le.persondatalayout_sec_range),TRIM((SALT32.StrType)le.persondatalayout_v_city_name),TRIM((SALT32.StrType)le.persondatalayout_st),TRIM((SALT32.StrType)le.persondatalayout_zip5),TRIM((SALT32.StrType)le.persondatalayout_zip4),TRIM((SALT32.StrType)le.persondatalayout_addr_rec_type),TRIM((SALT32.StrType)le.persondatalayout_fips_state),TRIM((SALT32.StrType)le.persondatalayout_fips_county),TRIM((SALT32.StrType)le.persondatalayout_geo_lat),TRIM((SALT32.StrType)le.persondatalayout_geo_long),TRIM((SALT32.StrType)le.persondatalayout_cbsa),TRIM((SALT32.StrType)le.persondatalayout_geo_blk),TRIM((SALT32.StrType)le.persondatalayout_geo_match),TRIM((SALT32.StrType)le.persondatalayout_err_stat),TRIM((SALT32.StrType)le.persondatalayout_appended_ssn),IF (le.persondatalayout_appended_adl <> 0,TRIM((SALT32.StrType)le.persondatalayout_appended_adl), ''),TRIM((SALT32.StrType)le.permissablelayout_glb_purpose),TRIM((SALT32.StrType)le.permissablelayout_dppa_purpose),TRIM((SALT32.StrType)le.permissablelayout_fcra_purpose),TRIM((SALT32.StrType)le.searchlayout_datetime),TRIM((SALT32.StrType)le.searchlayout_start_monitor),TRIM((SALT32.StrType)le.searchlayout_stop_monitor),TRIM((SALT32.StrType)le.searchlayout_login_history_id),TRIM((SALT32.StrType)le.searchlayout_transaction_id),TRIM((SALT32.StrType)le.searchlayout_sequence_number),TRIM((SALT32.StrType)le.searchlayout_method),TRIM((SALT32.StrType)le.searchlayout_product_code),TRIM((SALT32.StrType)le.searchlayout_transaction_type),TRIM((SALT32.StrType)le.searchlayout_function_description),TRIM((SALT32.StrType)le.searchlayout_ipaddr),TRIM((SALT32.StrType)le.fraudpoint_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),70*70,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'mbslayout_company_id'}
      ,{2,'mbslayout_global_company_id'}
      ,{3,'allowlayout_allowflags'}
      ,{4,'businfolayout_primary_market_code'}
      ,{5,'businfolayout_secondary_market_code'}
      ,{6,'businfolayout_industry_1_code'}
      ,{7,'businfolayout_industry_2_code'}
      ,{8,'businfolayout_sub_market'}
      ,{9,'businfolayout_vertical'}
      ,{10,'businfolayout_use'}
      ,{11,'businfolayout_industry'}
      ,{12,'persondatalayout_full_name'}
      ,{13,'persondatalayout_first_name'}
      ,{14,'persondatalayout_middle_name'}
      ,{15,'persondatalayout_last_name'}
      ,{16,'persondatalayout_address'}
      ,{17,'persondatalayout_city'}
      ,{18,'persondatalayout_state'}
      ,{19,'persondatalayout_zip'}
      ,{20,'persondatalayout_personal_phone'}
      ,{21,'persondatalayout_work_phone'}
      ,{22,'persondatalayout_dob'}
      ,{23,'persondatalayout_dl'}
      ,{24,'persondatalayout_dl_st'}
      ,{25,'persondatalayout_email_address'}
      ,{26,'persondatalayout_ssn'}
      ,{27,'persondatalayout_linkid'}
      ,{28,'persondatalayout_ipaddr'}
      ,{29,'persondatalayout_title'}
      ,{30,'persondatalayout_fname'}
      ,{31,'persondatalayout_mname'}
      ,{32,'persondatalayout_lname'}
      ,{33,'persondatalayout_name_suffix'}
      ,{34,'persondatalayout_prim_range'}
      ,{35,'persondatalayout_predir'}
      ,{36,'persondatalayout_prim_name'}
      ,{37,'persondatalayout_addr_suffix'}
      ,{38,'persondatalayout_postdir'}
      ,{39,'persondatalayout_unit_desig'}
      ,{40,'persondatalayout_sec_range'}
      ,{41,'persondatalayout_v_city_name'}
      ,{42,'persondatalayout_st'}
      ,{43,'persondatalayout_zip5'}
      ,{44,'persondatalayout_zip4'}
      ,{45,'persondatalayout_addr_rec_type'}
      ,{46,'persondatalayout_fips_state'}
      ,{47,'persondatalayout_fips_county'}
      ,{48,'persondatalayout_geo_lat'}
      ,{49,'persondatalayout_geo_long'}
      ,{50,'persondatalayout_cbsa'}
      ,{51,'persondatalayout_geo_blk'}
      ,{52,'persondatalayout_geo_match'}
      ,{53,'persondatalayout_err_stat'}
      ,{54,'persondatalayout_appended_ssn'}
      ,{55,'persondatalayout_appended_adl'}
      ,{56,'permissablelayout_glb_purpose'}
      ,{57,'permissablelayout_dppa_purpose'}
      ,{58,'permissablelayout_fcra_purpose'}
      ,{59,'searchlayout_datetime'}
      ,{60,'searchlayout_start_monitor'}
      ,{61,'searchlayout_stop_monitor'}
      ,{62,'searchlayout_login_history_id'}
      ,{63,'searchlayout_transaction_id'}
      ,{64,'searchlayout_sequence_number'}
      ,{65,'searchlayout_method'}
      ,{66,'searchlayout_product_code'}
      ,{67,'searchlayout_transaction_type'}
      ,{68,'searchlayout_function_description'}
      ,{69,'searchlayout_ipaddr'}
      ,{70,'fraudpoint_score'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_mbslayout_company_id((SALT32.StrType)le.mbslayout_company_id),
    Fields.InValid_mbslayout_global_company_id((SALT32.StrType)le.mbslayout_global_company_id),
    Fields.InValid_allowlayout_allowflags((SALT32.StrType)le.allowlayout_allowflags),
    Fields.InValid_businfolayout_primary_market_code((SALT32.StrType)le.businfolayout_primary_market_code),
    Fields.InValid_businfolayout_secondary_market_code((SALT32.StrType)le.businfolayout_secondary_market_code),
    Fields.InValid_businfolayout_industry_1_code((SALT32.StrType)le.businfolayout_industry_1_code),
    Fields.InValid_businfolayout_industry_2_code((SALT32.StrType)le.businfolayout_industry_2_code),
    Fields.InValid_businfolayout_sub_market((SALT32.StrType)le.businfolayout_sub_market),
    Fields.InValid_businfolayout_vertical((SALT32.StrType)le.businfolayout_vertical),
    Fields.InValid_businfolayout_use((SALT32.StrType)le.businfolayout_use),
    Fields.InValid_businfolayout_industry((SALT32.StrType)le.businfolayout_industry),
    Fields.InValid_persondatalayout_full_name((SALT32.StrType)le.persondatalayout_full_name),
    Fields.InValid_persondatalayout_first_name((SALT32.StrType)le.persondatalayout_first_name),
    Fields.InValid_persondatalayout_middle_name((SALT32.StrType)le.persondatalayout_middle_name),
    Fields.InValid_persondatalayout_last_name((SALT32.StrType)le.persondatalayout_last_name),
    Fields.InValid_persondatalayout_address((SALT32.StrType)le.persondatalayout_address),
    Fields.InValid_persondatalayout_city((SALT32.StrType)le.persondatalayout_city),
    Fields.InValid_persondatalayout_state((SALT32.StrType)le.persondatalayout_state),
    Fields.InValid_persondatalayout_zip((SALT32.StrType)le.persondatalayout_zip),
    Fields.InValid_persondatalayout_personal_phone((SALT32.StrType)le.persondatalayout_personal_phone),
    Fields.InValid_persondatalayout_work_phone((SALT32.StrType)le.persondatalayout_work_phone),
    Fields.InValid_persondatalayout_dob((SALT32.StrType)le.persondatalayout_dob),
    Fields.InValid_persondatalayout_dl((SALT32.StrType)le.persondatalayout_dl),
    Fields.InValid_persondatalayout_dl_st((SALT32.StrType)le.persondatalayout_dl_st),
    Fields.InValid_persondatalayout_email_address((SALT32.StrType)le.persondatalayout_email_address),
    Fields.InValid_persondatalayout_ssn((SALT32.StrType)le.persondatalayout_ssn),
    Fields.InValid_persondatalayout_linkid((SALT32.StrType)le.persondatalayout_linkid),
    Fields.InValid_persondatalayout_ipaddr((SALT32.StrType)le.persondatalayout_ipaddr),
    Fields.InValid_persondatalayout_title((SALT32.StrType)le.persondatalayout_title),
    Fields.InValid_persondatalayout_fname((SALT32.StrType)le.persondatalayout_fname),
    Fields.InValid_persondatalayout_mname((SALT32.StrType)le.persondatalayout_mname),
    Fields.InValid_persondatalayout_lname((SALT32.StrType)le.persondatalayout_lname),
    Fields.InValid_persondatalayout_name_suffix((SALT32.StrType)le.persondatalayout_name_suffix),
    Fields.InValid_persondatalayout_prim_range((SALT32.StrType)le.persondatalayout_prim_range),
    Fields.InValid_persondatalayout_predir((SALT32.StrType)le.persondatalayout_predir),
    Fields.InValid_persondatalayout_prim_name((SALT32.StrType)le.persondatalayout_prim_name),
    Fields.InValid_persondatalayout_addr_suffix((SALT32.StrType)le.persondatalayout_addr_suffix),
    Fields.InValid_persondatalayout_postdir((SALT32.StrType)le.persondatalayout_postdir),
    Fields.InValid_persondatalayout_unit_desig((SALT32.StrType)le.persondatalayout_unit_desig),
    Fields.InValid_persondatalayout_sec_range((SALT32.StrType)le.persondatalayout_sec_range),
    Fields.InValid_persondatalayout_v_city_name((SALT32.StrType)le.persondatalayout_v_city_name),
    Fields.InValid_persondatalayout_st((SALT32.StrType)le.persondatalayout_st),
    Fields.InValid_persondatalayout_zip5((SALT32.StrType)le.persondatalayout_zip5),
    Fields.InValid_persondatalayout_zip4((SALT32.StrType)le.persondatalayout_zip4),
    Fields.InValid_persondatalayout_addr_rec_type((SALT32.StrType)le.persondatalayout_addr_rec_type),
    Fields.InValid_persondatalayout_fips_state((SALT32.StrType)le.persondatalayout_fips_state),
    Fields.InValid_persondatalayout_fips_county((SALT32.StrType)le.persondatalayout_fips_county),
    Fields.InValid_persondatalayout_geo_lat((SALT32.StrType)le.persondatalayout_geo_lat),
    Fields.InValid_persondatalayout_geo_long((SALT32.StrType)le.persondatalayout_geo_long),
    Fields.InValid_persondatalayout_cbsa((SALT32.StrType)le.persondatalayout_cbsa),
    Fields.InValid_persondatalayout_geo_blk((SALT32.StrType)le.persondatalayout_geo_blk),
    Fields.InValid_persondatalayout_geo_match((SALT32.StrType)le.persondatalayout_geo_match),
    Fields.InValid_persondatalayout_err_stat((SALT32.StrType)le.persondatalayout_err_stat),
    Fields.InValid_persondatalayout_appended_ssn((SALT32.StrType)le.persondatalayout_appended_ssn),
    Fields.InValid_persondatalayout_appended_adl((SALT32.StrType)le.persondatalayout_appended_adl),
    Fields.InValid_permissablelayout_glb_purpose((SALT32.StrType)le.permissablelayout_glb_purpose),
    Fields.InValid_permissablelayout_dppa_purpose((SALT32.StrType)le.permissablelayout_dppa_purpose),
    Fields.InValid_permissablelayout_fcra_purpose((SALT32.StrType)le.permissablelayout_fcra_purpose),
    Fields.InValid_searchlayout_datetime((SALT32.StrType)le.searchlayout_datetime),
    Fields.InValid_searchlayout_start_monitor((SALT32.StrType)le.searchlayout_start_monitor),
    Fields.InValid_searchlayout_stop_monitor((SALT32.StrType)le.searchlayout_stop_monitor),
    Fields.InValid_searchlayout_login_history_id((SALT32.StrType)le.searchlayout_login_history_id),
    Fields.InValid_searchlayout_transaction_id((SALT32.StrType)le.searchlayout_transaction_id),
    Fields.InValid_searchlayout_sequence_number((SALT32.StrType)le.searchlayout_sequence_number),
    Fields.InValid_searchlayout_method((SALT32.StrType)le.searchlayout_method),
    Fields.InValid_searchlayout_product_code((SALT32.StrType)le.searchlayout_product_code),
    Fields.InValid_searchlayout_transaction_type((SALT32.StrType)le.searchlayout_transaction_type),
    Fields.InValid_searchlayout_function_description((SALT32.StrType)le.searchlayout_function_description),
    Fields.InValid_searchlayout_ipaddr((SALT32.StrType)le.searchlayout_ipaddr),
    Fields.InValid_fraudpoint_score((SALT32.StrType)le.fraudpoint_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,70,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_mbslayout_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbslayout_global_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_allowlayout_allowflags(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_primary_market_code(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_secondary_market_code(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_industry_1_code(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_industry_2_code(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_sub_market(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_vertical(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_use(TotalErrors.ErrorNum),Fields.InValidMessage_businfolayout_industry(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_address(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_city(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_state(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_zip(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_personal_phone(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_dob(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_dl(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_dl_st(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_linkid(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_title(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_fname(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_mname(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_lname(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_predir(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_st(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_addr_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_appended_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_persondatalayout_appended_adl(TotalErrors.ErrorNum),Fields.InValidMessage_permissablelayout_glb_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_permissablelayout_dppa_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_permissablelayout_fcra_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_datetime(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_start_monitor(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_stop_monitor(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_sequence_number(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_method(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_product_code(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_function_description(TotalErrors.ErrorNum),Fields.InValidMessage_searchlayout_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_fraudpoint_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
