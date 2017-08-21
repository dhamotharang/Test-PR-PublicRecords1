import ut,SALT28;
export hygiene(dataset(layout_inquiry_Acclogs_FCRA_SSN) h) := MODULE
//A simple summary record
export Summary(SALT28.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_mbs_company_id_pcnt := AVE(GROUP,IF(h.mbs_company_id = (TYPEOF(h.mbs_company_id))'',0,100));
    maxlength_mbs_company_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.mbs_company_id)));
    avelength_mbs_company_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.mbs_company_id)),h.mbs_company_id<>(typeof(h.mbs_company_id))'');
    populated_mbs_global_company_id_pcnt := AVE(GROUP,IF(h.mbs_global_company_id = (TYPEOF(h.mbs_global_company_id))'',0,100));
    maxlength_mbs_global_company_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.mbs_global_company_id)));
    avelength_mbs_global_company_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.mbs_global_company_id)),h.mbs_global_company_id<>(typeof(h.mbs_global_company_id))'');
    populated_allow_flags_allowflags_pcnt := AVE(GROUP,IF(h.allow_flags_allowflags = (TYPEOF(h.allow_flags_allowflags))'',0,100));
    maxlength_allow_flags_allowflags := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.allow_flags_allowflags)));
    avelength_allow_flags_allowflags := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.allow_flags_allowflags)),h.allow_flags_allowflags<>(typeof(h.allow_flags_allowflags))'');
    populated_bus_intel_primary_market_code_pcnt := AVE(GROUP,IF(h.bus_intel_primary_market_code = (TYPEOF(h.bus_intel_primary_market_code))'',0,100));
    maxlength_bus_intel_primary_market_code := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_primary_market_code)));
    avelength_bus_intel_primary_market_code := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_primary_market_code)),h.bus_intel_primary_market_code<>(typeof(h.bus_intel_primary_market_code))'');
    populated_bus_intel_secondary_market_code_pcnt := AVE(GROUP,IF(h.bus_intel_secondary_market_code = (TYPEOF(h.bus_intel_secondary_market_code))'',0,100));
    maxlength_bus_intel_secondary_market_code := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_secondary_market_code)));
    avelength_bus_intel_secondary_market_code := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_secondary_market_code)),h.bus_intel_secondary_market_code<>(typeof(h.bus_intel_secondary_market_code))'');
    populated_bus_intel_industry_1_code_pcnt := AVE(GROUP,IF(h.bus_intel_industry_1_code = (TYPEOF(h.bus_intel_industry_1_code))'',0,100));
    maxlength_bus_intel_industry_1_code := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry_1_code)));
    avelength_bus_intel_industry_1_code := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry_1_code)),h.bus_intel_industry_1_code<>(typeof(h.bus_intel_industry_1_code))'');
    populated_bus_intel_industry_2_code_pcnt := AVE(GROUP,IF(h.bus_intel_industry_2_code = (TYPEOF(h.bus_intel_industry_2_code))'',0,100));
    maxlength_bus_intel_industry_2_code := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry_2_code)));
    avelength_bus_intel_industry_2_code := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry_2_code)),h.bus_intel_industry_2_code<>(typeof(h.bus_intel_industry_2_code))'');
    populated_bus_intel_sub_market_pcnt := AVE(GROUP,IF(h.bus_intel_sub_market = (TYPEOF(h.bus_intel_sub_market))'',0,100));
    maxlength_bus_intel_sub_market := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_sub_market)));
    avelength_bus_intel_sub_market := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_sub_market)),h.bus_intel_sub_market<>(typeof(h.bus_intel_sub_market))'');
    populated_bus_intel_vertical_pcnt := AVE(GROUP,IF(h.bus_intel_vertical = (TYPEOF(h.bus_intel_vertical))'',0,100));
    maxlength_bus_intel_vertical := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_vertical)));
    avelength_bus_intel_vertical := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_vertical)),h.bus_intel_vertical<>(typeof(h.bus_intel_vertical))'');
    populated_bus_intel_use_pcnt := AVE(GROUP,IF(h.bus_intel_use = (TYPEOF(h.bus_intel_use))'',0,100));
    maxlength_bus_intel_use := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_use)));
    avelength_bus_intel_use := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_use)),h.bus_intel_use<>(typeof(h.bus_intel_use))'');
    populated_bus_intel_industry_pcnt := AVE(GROUP,IF(h.bus_intel_industry = (TYPEOF(h.bus_intel_industry))'',0,100));
    maxlength_bus_intel_industry := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry)));
    avelength_bus_intel_industry := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_intel_industry)),h.bus_intel_industry<>(typeof(h.bus_intel_industry))'');
    populated_person_q_full_name_pcnt := AVE(GROUP,IF(h.person_q_full_name = (TYPEOF(h.person_q_full_name))'',0,100));
    maxlength_person_q_full_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_full_name)));
    avelength_person_q_full_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_full_name)),h.person_q_full_name<>(typeof(h.person_q_full_name))'');
    populated_person_q_first_name_pcnt := AVE(GROUP,IF(h.person_q_first_name = (TYPEOF(h.person_q_first_name))'',0,100));
    maxlength_person_q_first_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_first_name)));
    avelength_person_q_first_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_first_name)),h.person_q_first_name<>(typeof(h.person_q_first_name))'');
    populated_person_q_middle_name_pcnt := AVE(GROUP,IF(h.person_q_middle_name = (TYPEOF(h.person_q_middle_name))'',0,100));
    maxlength_person_q_middle_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_middle_name)));
    avelength_person_q_middle_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_middle_name)),h.person_q_middle_name<>(typeof(h.person_q_middle_name))'');
    populated_person_q_last_name_pcnt := AVE(GROUP,IF(h.person_q_last_name = (TYPEOF(h.person_q_last_name))'',0,100));
    maxlength_person_q_last_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_last_name)));
    avelength_person_q_last_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_last_name)),h.person_q_last_name<>(typeof(h.person_q_last_name))'');
    populated_person_q_address_pcnt := AVE(GROUP,IF(h.person_q_address = (TYPEOF(h.person_q_address))'',0,100));
    maxlength_person_q_address := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_address)));
    avelength_person_q_address := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_address)),h.person_q_address<>(typeof(h.person_q_address))'');
    populated_person_q_city_pcnt := AVE(GROUP,IF(h.person_q_city = (TYPEOF(h.person_q_city))'',0,100));
    maxlength_person_q_city := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_city)));
    avelength_person_q_city := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_city)),h.person_q_city<>(typeof(h.person_q_city))'');
    populated_person_q_state_pcnt := AVE(GROUP,IF(h.person_q_state = (TYPEOF(h.person_q_state))'',0,100));
    maxlength_person_q_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_state)));
    avelength_person_q_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_state)),h.person_q_state<>(typeof(h.person_q_state))'');
    populated_person_q_zip_pcnt := AVE(GROUP,IF(h.person_q_zip = (TYPEOF(h.person_q_zip))'',0,100));
    maxlength_person_q_zip := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip)));
    avelength_person_q_zip := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip)),h.person_q_zip<>(typeof(h.person_q_zip))'');
    populated_person_q_personal_phone_pcnt := AVE(GROUP,IF(h.person_q_personal_phone = (TYPEOF(h.person_q_personal_phone))'',0,100));
    maxlength_person_q_personal_phone := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_personal_phone)));
    avelength_person_q_personal_phone := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_personal_phone)),h.person_q_personal_phone<>(typeof(h.person_q_personal_phone))'');
    populated_person_q_work_phone_pcnt := AVE(GROUP,IF(h.person_q_work_phone = (TYPEOF(h.person_q_work_phone))'',0,100));
    maxlength_person_q_work_phone := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_work_phone)));
    avelength_person_q_work_phone := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_work_phone)),h.person_q_work_phone<>(typeof(h.person_q_work_phone))'');
    populated_person_q_dob_pcnt := AVE(GROUP,IF(h.person_q_dob = (TYPEOF(h.person_q_dob))'',0,100));
    maxlength_person_q_dob := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dob)));
    avelength_person_q_dob := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dob)),h.person_q_dob<>(typeof(h.person_q_dob))'');
    populated_person_q_dl_pcnt := AVE(GROUP,IF(h.person_q_dl = (TYPEOF(h.person_q_dl))'',0,100));
    maxlength_person_q_dl := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dl)));
    avelength_person_q_dl := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dl)),h.person_q_dl<>(typeof(h.person_q_dl))'');
    populated_person_q_dl_st_pcnt := AVE(GROUP,IF(h.person_q_dl_st = (TYPEOF(h.person_q_dl_st))'',0,100));
    maxlength_person_q_dl_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dl_st)));
    avelength_person_q_dl_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_dl_st)),h.person_q_dl_st<>(typeof(h.person_q_dl_st))'');
    populated_person_q_email_address_pcnt := AVE(GROUP,IF(h.person_q_email_address = (TYPEOF(h.person_q_email_address))'',0,100));
    maxlength_person_q_email_address := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_email_address)));
    avelength_person_q_email_address := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_email_address)),h.person_q_email_address<>(typeof(h.person_q_email_address))'');
    populated_person_q_ssn_pcnt := AVE(GROUP,IF(h.person_q_ssn = (TYPEOF(h.person_q_ssn))'',0,100));
    maxlength_person_q_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_ssn)));
    avelength_person_q_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_ssn)),h.person_q_ssn<>(typeof(h.person_q_ssn))'');
    populated_person_q_linkid_pcnt := AVE(GROUP,IF(h.person_q_linkid = (TYPEOF(h.person_q_linkid))'',0,100));
    maxlength_person_q_linkid := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_linkid)));
    avelength_person_q_linkid := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_linkid)),h.person_q_linkid<>(typeof(h.person_q_linkid))'');
    populated_person_q_ipaddr_pcnt := AVE(GROUP,IF(h.person_q_ipaddr = (TYPEOF(h.person_q_ipaddr))'',0,100));
    maxlength_person_q_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_ipaddr)));
    avelength_person_q_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_ipaddr)),h.person_q_ipaddr<>(typeof(h.person_q_ipaddr))'');
    populated_person_q_title_pcnt := AVE(GROUP,IF(h.person_q_title = (TYPEOF(h.person_q_title))'',0,100));
    maxlength_person_q_title := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_title)));
    avelength_person_q_title := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_title)),h.person_q_title<>(typeof(h.person_q_title))'');
    populated_person_q_fname_pcnt := AVE(GROUP,IF(h.person_q_fname = (TYPEOF(h.person_q_fname))'',0,100));
    maxlength_person_q_fname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fname)));
    avelength_person_q_fname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fname)),h.person_q_fname<>(typeof(h.person_q_fname))'');
    populated_person_q_mname_pcnt := AVE(GROUP,IF(h.person_q_mname = (TYPEOF(h.person_q_mname))'',0,100));
    maxlength_person_q_mname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_mname)));
    avelength_person_q_mname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_mname)),h.person_q_mname<>(typeof(h.person_q_mname))'');
    populated_person_q_lname_pcnt := AVE(GROUP,IF(h.person_q_lname = (TYPEOF(h.person_q_lname))'',0,100));
    maxlength_person_q_lname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_lname)));
    avelength_person_q_lname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_lname)),h.person_q_lname<>(typeof(h.person_q_lname))'');
    populated_person_q_name_suffix_pcnt := AVE(GROUP,IF(h.person_q_name_suffix = (TYPEOF(h.person_q_name_suffix))'',0,100));
    maxlength_person_q_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_name_suffix)));
    avelength_person_q_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_name_suffix)),h.person_q_name_suffix<>(typeof(h.person_q_name_suffix))'');
    populated_person_q_prim_range_pcnt := AVE(GROUP,IF(h.person_q_prim_range = (TYPEOF(h.person_q_prim_range))'',0,100));
    maxlength_person_q_prim_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_prim_range)));
    avelength_person_q_prim_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_prim_range)),h.person_q_prim_range<>(typeof(h.person_q_prim_range))'');
    populated_person_q_predir_pcnt := AVE(GROUP,IF(h.person_q_predir = (TYPEOF(h.person_q_predir))'',0,100));
    maxlength_person_q_predir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_predir)));
    avelength_person_q_predir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_predir)),h.person_q_predir<>(typeof(h.person_q_predir))'');
    populated_person_q_prim_name_pcnt := AVE(GROUP,IF(h.person_q_prim_name = (TYPEOF(h.person_q_prim_name))'',0,100));
    maxlength_person_q_prim_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_prim_name)));
    avelength_person_q_prim_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_prim_name)),h.person_q_prim_name<>(typeof(h.person_q_prim_name))'');
    populated_person_q_addr_suffix_pcnt := AVE(GROUP,IF(h.person_q_addr_suffix = (TYPEOF(h.person_q_addr_suffix))'',0,100));
    maxlength_person_q_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_addr_suffix)));
    avelength_person_q_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_addr_suffix)),h.person_q_addr_suffix<>(typeof(h.person_q_addr_suffix))'');
    populated_person_q_postdir_pcnt := AVE(GROUP,IF(h.person_q_postdir = (TYPEOF(h.person_q_postdir))'',0,100));
    maxlength_person_q_postdir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_postdir)));
    avelength_person_q_postdir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_postdir)),h.person_q_postdir<>(typeof(h.person_q_postdir))'');
    populated_person_q_unit_desig_pcnt := AVE(GROUP,IF(h.person_q_unit_desig = (TYPEOF(h.person_q_unit_desig))'',0,100));
    maxlength_person_q_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_unit_desig)));
    avelength_person_q_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_unit_desig)),h.person_q_unit_desig<>(typeof(h.person_q_unit_desig))'');
    populated_person_q_sec_range_pcnt := AVE(GROUP,IF(h.person_q_sec_range = (TYPEOF(h.person_q_sec_range))'',0,100));
    maxlength_person_q_sec_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_sec_range)));
    avelength_person_q_sec_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_sec_range)),h.person_q_sec_range<>(typeof(h.person_q_sec_range))'');
    populated_person_q_v_city_name_pcnt := AVE(GROUP,IF(h.person_q_v_city_name = (TYPEOF(h.person_q_v_city_name))'',0,100));
    maxlength_person_q_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_v_city_name)));
    avelength_person_q_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_v_city_name)),h.person_q_v_city_name<>(typeof(h.person_q_v_city_name))'');
    populated_person_q_st_pcnt := AVE(GROUP,IF(h.person_q_st = (TYPEOF(h.person_q_st))'',0,100));
    maxlength_person_q_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_st)));
    avelength_person_q_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_st)),h.person_q_st<>(typeof(h.person_q_st))'');
    populated_person_q_zip5_pcnt := AVE(GROUP,IF(h.person_q_zip5 = (TYPEOF(h.person_q_zip5))'',0,100));
    maxlength_person_q_zip5 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip5)));
    avelength_person_q_zip5 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip5)),h.person_q_zip5<>(typeof(h.person_q_zip5))'');
    populated_person_q_zip4_pcnt := AVE(GROUP,IF(h.person_q_zip4 = (TYPEOF(h.person_q_zip4))'',0,100));
    maxlength_person_q_zip4 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip4)));
    avelength_person_q_zip4 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_zip4)),h.person_q_zip4<>(typeof(h.person_q_zip4))'');
    populated_person_q_addr_rec_type_pcnt := AVE(GROUP,IF(h.person_q_addr_rec_type = (TYPEOF(h.person_q_addr_rec_type))'',0,100));
    maxlength_person_q_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_addr_rec_type)));
    avelength_person_q_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_addr_rec_type)),h.person_q_addr_rec_type<>(typeof(h.person_q_addr_rec_type))'');
    populated_person_q_fips_state_pcnt := AVE(GROUP,IF(h.person_q_fips_state = (TYPEOF(h.person_q_fips_state))'',0,100));
    maxlength_person_q_fips_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fips_state)));
    avelength_person_q_fips_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fips_state)),h.person_q_fips_state<>(typeof(h.person_q_fips_state))'');
    populated_person_q_fips_county_pcnt := AVE(GROUP,IF(h.person_q_fips_county = (TYPEOF(h.person_q_fips_county))'',0,100));
    maxlength_person_q_fips_county := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fips_county)));
    avelength_person_q_fips_county := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_fips_county)),h.person_q_fips_county<>(typeof(h.person_q_fips_county))'');
    populated_person_q_geo_lat_pcnt := AVE(GROUP,IF(h.person_q_geo_lat = (TYPEOF(h.person_q_geo_lat))'',0,100));
    maxlength_person_q_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_lat)));
    avelength_person_q_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_lat)),h.person_q_geo_lat<>(typeof(h.person_q_geo_lat))'');
    populated_person_q_geo_long_pcnt := AVE(GROUP,IF(h.person_q_geo_long = (TYPEOF(h.person_q_geo_long))'',0,100));
    maxlength_person_q_geo_long := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_long)));
    avelength_person_q_geo_long := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_long)),h.person_q_geo_long<>(typeof(h.person_q_geo_long))'');
    populated_person_q_cbsa_pcnt := AVE(GROUP,IF(h.person_q_cbsa = (TYPEOF(h.person_q_cbsa))'',0,100));
    maxlength_person_q_cbsa := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_cbsa)));
    avelength_person_q_cbsa := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_cbsa)),h.person_q_cbsa<>(typeof(h.person_q_cbsa))'');
    populated_person_q_geo_blk_pcnt := AVE(GROUP,IF(h.person_q_geo_blk = (TYPEOF(h.person_q_geo_blk))'',0,100));
    maxlength_person_q_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_blk)));
    avelength_person_q_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_blk)),h.person_q_geo_blk<>(typeof(h.person_q_geo_blk))'');
    populated_person_q_geo_match_pcnt := AVE(GROUP,IF(h.person_q_geo_match = (TYPEOF(h.person_q_geo_match))'',0,100));
    maxlength_person_q_geo_match := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_match)));
    avelength_person_q_geo_match := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_geo_match)),h.person_q_geo_match<>(typeof(h.person_q_geo_match))'');
    populated_person_q_err_stat_pcnt := AVE(GROUP,IF(h.person_q_err_stat = (TYPEOF(h.person_q_err_stat))'',0,100));
    maxlength_person_q_err_stat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_err_stat)));
    avelength_person_q_err_stat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_err_stat)),h.person_q_err_stat<>(typeof(h.person_q_err_stat))'');
    populated_person_q_appended_ssn_pcnt := AVE(GROUP,IF(h.person_q_appended_ssn = (TYPEOF(h.person_q_appended_ssn))'',0,100));
    maxlength_person_q_appended_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_appended_ssn)));
    avelength_person_q_appended_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_appended_ssn)),h.person_q_appended_ssn<>(typeof(h.person_q_appended_ssn))'');
    populated_person_q_appended_adl_pcnt := AVE(GROUP,IF(h.person_q_appended_adl = (TYPEOF(h.person_q_appended_adl))'',0,100));
    maxlength_person_q_appended_adl := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_appended_adl)));
    avelength_person_q_appended_adl := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.person_q_appended_adl)),h.person_q_appended_adl<>(typeof(h.person_q_appended_adl))'');
    populated_bus_q_cname_pcnt := AVE(GROUP,IF(h.bus_q_cname = (TYPEOF(h.bus_q_cname))'',0,100));
    maxlength_bus_q_cname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_cname)));
    avelength_bus_q_cname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_cname)),h.bus_q_cname<>(typeof(h.bus_q_cname))'');
    populated_bus_q_address_pcnt := AVE(GROUP,IF(h.bus_q_address = (TYPEOF(h.bus_q_address))'',0,100));
    maxlength_bus_q_address := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_address)));
    avelength_bus_q_address := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_address)),h.bus_q_address<>(typeof(h.bus_q_address))'');
    populated_bus_q_city_pcnt := AVE(GROUP,IF(h.bus_q_city = (TYPEOF(h.bus_q_city))'',0,100));
    maxlength_bus_q_city := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_city)));
    avelength_bus_q_city := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_city)),h.bus_q_city<>(typeof(h.bus_q_city))'');
    populated_bus_q_state_pcnt := AVE(GROUP,IF(h.bus_q_state = (TYPEOF(h.bus_q_state))'',0,100));
    maxlength_bus_q_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_state)));
    avelength_bus_q_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_state)),h.bus_q_state<>(typeof(h.bus_q_state))'');
    populated_bus_q_zip_pcnt := AVE(GROUP,IF(h.bus_q_zip = (TYPEOF(h.bus_q_zip))'',0,100));
    maxlength_bus_q_zip := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip)));
    avelength_bus_q_zip := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip)),h.bus_q_zip<>(typeof(h.bus_q_zip))'');
    populated_bus_q_company_phone_pcnt := AVE(GROUP,IF(h.bus_q_company_phone = (TYPEOF(h.bus_q_company_phone))'',0,100));
    maxlength_bus_q_company_phone := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_company_phone)));
    avelength_bus_q_company_phone := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_company_phone)),h.bus_q_company_phone<>(typeof(h.bus_q_company_phone))'');
    populated_bus_q_ein_pcnt := AVE(GROUP,IF(h.bus_q_ein = (TYPEOF(h.bus_q_ein))'',0,100));
    maxlength_bus_q_ein := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_ein)));
    avelength_bus_q_ein := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_ein)),h.bus_q_ein<>(typeof(h.bus_q_ein))'');
    populated_bus_q_charter_number_pcnt := AVE(GROUP,IF(h.bus_q_charter_number = (TYPEOF(h.bus_q_charter_number))'',0,100));
    maxlength_bus_q_charter_number := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_charter_number)));
    avelength_bus_q_charter_number := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_charter_number)),h.bus_q_charter_number<>(typeof(h.bus_q_charter_number))'');
    populated_bus_q_ucc_number_pcnt := AVE(GROUP,IF(h.bus_q_ucc_number = (TYPEOF(h.bus_q_ucc_number))'',0,100));
    maxlength_bus_q_ucc_number := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_ucc_number)));
    avelength_bus_q_ucc_number := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_ucc_number)),h.bus_q_ucc_number<>(typeof(h.bus_q_ucc_number))'');
    populated_bus_q_domain_name_pcnt := AVE(GROUP,IF(h.bus_q_domain_name = (TYPEOF(h.bus_q_domain_name))'',0,100));
    maxlength_bus_q_domain_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_domain_name)));
    avelength_bus_q_domain_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_domain_name)),h.bus_q_domain_name<>(typeof(h.bus_q_domain_name))'');
    populated_bus_q_prim_range_pcnt := AVE(GROUP,IF(h.bus_q_prim_range = (TYPEOF(h.bus_q_prim_range))'',0,100));
    maxlength_bus_q_prim_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_prim_range)));
    avelength_bus_q_prim_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_prim_range)),h.bus_q_prim_range<>(typeof(h.bus_q_prim_range))'');
    populated_bus_q_predir_pcnt := AVE(GROUP,IF(h.bus_q_predir = (TYPEOF(h.bus_q_predir))'',0,100));
    maxlength_bus_q_predir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_predir)));
    avelength_bus_q_predir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_predir)),h.bus_q_predir<>(typeof(h.bus_q_predir))'');
    populated_bus_q_prim_name_pcnt := AVE(GROUP,IF(h.bus_q_prim_name = (TYPEOF(h.bus_q_prim_name))'',0,100));
    maxlength_bus_q_prim_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_prim_name)));
    avelength_bus_q_prim_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_prim_name)),h.bus_q_prim_name<>(typeof(h.bus_q_prim_name))'');
    populated_bus_q_addr_suffix_pcnt := AVE(GROUP,IF(h.bus_q_addr_suffix = (TYPEOF(h.bus_q_addr_suffix))'',0,100));
    maxlength_bus_q_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_addr_suffix)));
    avelength_bus_q_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_addr_suffix)),h.bus_q_addr_suffix<>(typeof(h.bus_q_addr_suffix))'');
    populated_bus_q_postdir_pcnt := AVE(GROUP,IF(h.bus_q_postdir = (TYPEOF(h.bus_q_postdir))'',0,100));
    maxlength_bus_q_postdir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_postdir)));
    avelength_bus_q_postdir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_postdir)),h.bus_q_postdir<>(typeof(h.bus_q_postdir))'');
    populated_bus_q_unit_desig_pcnt := AVE(GROUP,IF(h.bus_q_unit_desig = (TYPEOF(h.bus_q_unit_desig))'',0,100));
    maxlength_bus_q_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_unit_desig)));
    avelength_bus_q_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_unit_desig)),h.bus_q_unit_desig<>(typeof(h.bus_q_unit_desig))'');
    populated_bus_q_sec_range_pcnt := AVE(GROUP,IF(h.bus_q_sec_range = (TYPEOF(h.bus_q_sec_range))'',0,100));
    maxlength_bus_q_sec_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_sec_range)));
    avelength_bus_q_sec_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_sec_range)),h.bus_q_sec_range<>(typeof(h.bus_q_sec_range))'');
    populated_bus_q_v_city_name_pcnt := AVE(GROUP,IF(h.bus_q_v_city_name = (TYPEOF(h.bus_q_v_city_name))'',0,100));
    maxlength_bus_q_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_v_city_name)));
    avelength_bus_q_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_v_city_name)),h.bus_q_v_city_name<>(typeof(h.bus_q_v_city_name))'');
    populated_bus_q_st_pcnt := AVE(GROUP,IF(h.bus_q_st = (TYPEOF(h.bus_q_st))'',0,100));
    maxlength_bus_q_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_st)));
    avelength_bus_q_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_st)),h.bus_q_st<>(typeof(h.bus_q_st))'');
    populated_bus_q_zip5_pcnt := AVE(GROUP,IF(h.bus_q_zip5 = (TYPEOF(h.bus_q_zip5))'',0,100));
    maxlength_bus_q_zip5 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip5)));
    avelength_bus_q_zip5 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip5)),h.bus_q_zip5<>(typeof(h.bus_q_zip5))'');
    populated_bus_q_zip4_pcnt := AVE(GROUP,IF(h.bus_q_zip4 = (TYPEOF(h.bus_q_zip4))'',0,100));
    maxlength_bus_q_zip4 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip4)));
    avelength_bus_q_zip4 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_zip4)),h.bus_q_zip4<>(typeof(h.bus_q_zip4))'');
    populated_bus_q_addr_rec_type_pcnt := AVE(GROUP,IF(h.bus_q_addr_rec_type = (TYPEOF(h.bus_q_addr_rec_type))'',0,100));
    maxlength_bus_q_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_addr_rec_type)));
    avelength_bus_q_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_addr_rec_type)),h.bus_q_addr_rec_type<>(typeof(h.bus_q_addr_rec_type))'');
    populated_bus_q_fips_state_pcnt := AVE(GROUP,IF(h.bus_q_fips_state = (TYPEOF(h.bus_q_fips_state))'',0,100));
    maxlength_bus_q_fips_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_fips_state)));
    avelength_bus_q_fips_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_fips_state)),h.bus_q_fips_state<>(typeof(h.bus_q_fips_state))'');
    populated_bus_q_fips_county_pcnt := AVE(GROUP,IF(h.bus_q_fips_county = (TYPEOF(h.bus_q_fips_county))'',0,100));
    maxlength_bus_q_fips_county := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_fips_county)));
    avelength_bus_q_fips_county := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_fips_county)),h.bus_q_fips_county<>(typeof(h.bus_q_fips_county))'');
    populated_bus_q_geo_lat_pcnt := AVE(GROUP,IF(h.bus_q_geo_lat = (TYPEOF(h.bus_q_geo_lat))'',0,100));
    maxlength_bus_q_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_lat)));
    avelength_bus_q_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_lat)),h.bus_q_geo_lat<>(typeof(h.bus_q_geo_lat))'');
    populated_bus_q_geo_long_pcnt := AVE(GROUP,IF(h.bus_q_geo_long = (TYPEOF(h.bus_q_geo_long))'',0,100));
    maxlength_bus_q_geo_long := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_long)));
    avelength_bus_q_geo_long := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_long)),h.bus_q_geo_long<>(typeof(h.bus_q_geo_long))'');
    populated_bus_q_cbsa_pcnt := AVE(GROUP,IF(h.bus_q_cbsa = (TYPEOF(h.bus_q_cbsa))'',0,100));
    maxlength_bus_q_cbsa := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_cbsa)));
    avelength_bus_q_cbsa := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_cbsa)),h.bus_q_cbsa<>(typeof(h.bus_q_cbsa))'');
    populated_bus_q_geo_blk_pcnt := AVE(GROUP,IF(h.bus_q_geo_blk = (TYPEOF(h.bus_q_geo_blk))'',0,100));
    maxlength_bus_q_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_blk)));
    avelength_bus_q_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_blk)),h.bus_q_geo_blk<>(typeof(h.bus_q_geo_blk))'');
    populated_bus_q_geo_match_pcnt := AVE(GROUP,IF(h.bus_q_geo_match = (TYPEOF(h.bus_q_geo_match))'',0,100));
    maxlength_bus_q_geo_match := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_match)));
    avelength_bus_q_geo_match := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_geo_match)),h.bus_q_geo_match<>(typeof(h.bus_q_geo_match))'');
    populated_bus_q_err_stat_pcnt := AVE(GROUP,IF(h.bus_q_err_stat = (TYPEOF(h.bus_q_err_stat))'',0,100));
    maxlength_bus_q_err_stat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_err_stat)));
    avelength_bus_q_err_stat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_err_stat)),h.bus_q_err_stat<>(typeof(h.bus_q_err_stat))'');
    populated_bus_q_appended_bdid_pcnt := AVE(GROUP,IF(h.bus_q_appended_bdid = (TYPEOF(h.bus_q_appended_bdid))'',0,100));
    maxlength_bus_q_appended_bdid := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_appended_bdid)));
    avelength_bus_q_appended_bdid := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_appended_bdid)),h.bus_q_appended_bdid<>(typeof(h.bus_q_appended_bdid))'');
    populated_bus_q_appended_ein_pcnt := AVE(GROUP,IF(h.bus_q_appended_ein = (TYPEOF(h.bus_q_appended_ein))'',0,100));
    maxlength_bus_q_appended_ein := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_appended_ein)));
    avelength_bus_q_appended_ein := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bus_q_appended_ein)),h.bus_q_appended_ein<>(typeof(h.bus_q_appended_ein))'');
    populated_bususer_q_personal_phone_pcnt := AVE(GROUP,IF(h.bususer_q_personal_phone = (TYPEOF(h.bususer_q_personal_phone))'',0,100));
    maxlength_bususer_q_personal_phone := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_personal_phone)));
    avelength_bususer_q_personal_phone := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_personal_phone)),h.bususer_q_personal_phone<>(typeof(h.bususer_q_personal_phone))'');
    populated_bususer_q_dob_pcnt := AVE(GROUP,IF(h.bususer_q_dob = (TYPEOF(h.bususer_q_dob))'',0,100));
    maxlength_bususer_q_dob := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dob)));
    avelength_bususer_q_dob := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dob)),h.bususer_q_dob<>(typeof(h.bususer_q_dob))'');
    populated_bususer_q_dl_pcnt := AVE(GROUP,IF(h.bususer_q_dl = (TYPEOF(h.bususer_q_dl))'',0,100));
    maxlength_bususer_q_dl := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dl)));
    avelength_bususer_q_dl := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dl)),h.bususer_q_dl<>(typeof(h.bususer_q_dl))'');
    populated_bususer_q_dl_st_pcnt := AVE(GROUP,IF(h.bususer_q_dl_st = (TYPEOF(h.bususer_q_dl_st))'',0,100));
    maxlength_bususer_q_dl_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dl_st)));
    avelength_bususer_q_dl_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_dl_st)),h.bususer_q_dl_st<>(typeof(h.bususer_q_dl_st))'');
    populated_bususer_q_ssn_pcnt := AVE(GROUP,IF(h.bususer_q_ssn = (TYPEOF(h.bususer_q_ssn))'',0,100));
    maxlength_bususer_q_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_ssn)));
    avelength_bususer_q_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_ssn)),h.bususer_q_ssn<>(typeof(h.bususer_q_ssn))'');
    populated_bususer_q_title_pcnt := AVE(GROUP,IF(h.bususer_q_title = (TYPEOF(h.bususer_q_title))'',0,100));
    maxlength_bususer_q_title := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_title)));
    avelength_bususer_q_title := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_title)),h.bususer_q_title<>(typeof(h.bususer_q_title))'');
    populated_bususer_q_fname_pcnt := AVE(GROUP,IF(h.bususer_q_fname = (TYPEOF(h.bususer_q_fname))'',0,100));
    maxlength_bususer_q_fname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fname)));
    avelength_bususer_q_fname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fname)),h.bususer_q_fname<>(typeof(h.bususer_q_fname))'');
    populated_bususer_q_mname_pcnt := AVE(GROUP,IF(h.bususer_q_mname = (TYPEOF(h.bususer_q_mname))'',0,100));
    maxlength_bususer_q_mname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_mname)));
    avelength_bususer_q_mname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_mname)),h.bususer_q_mname<>(typeof(h.bususer_q_mname))'');
    populated_bususer_q_lname_pcnt := AVE(GROUP,IF(h.bususer_q_lname = (TYPEOF(h.bususer_q_lname))'',0,100));
    maxlength_bususer_q_lname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_lname)));
    avelength_bususer_q_lname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_lname)),h.bususer_q_lname<>(typeof(h.bususer_q_lname))'');
    populated_bususer_q_name_suffix_pcnt := AVE(GROUP,IF(h.bususer_q_name_suffix = (TYPEOF(h.bususer_q_name_suffix))'',0,100));
    maxlength_bususer_q_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_name_suffix)));
    avelength_bususer_q_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_name_suffix)),h.bususer_q_name_suffix<>(typeof(h.bususer_q_name_suffix))'');
    populated_bususer_q_prim_range_pcnt := AVE(GROUP,IF(h.bususer_q_prim_range = (TYPEOF(h.bususer_q_prim_range))'',0,100));
    maxlength_bususer_q_prim_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_prim_range)));
    avelength_bususer_q_prim_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_prim_range)),h.bususer_q_prim_range<>(typeof(h.bususer_q_prim_range))'');
    populated_bususer_q_predir_pcnt := AVE(GROUP,IF(h.bususer_q_predir = (TYPEOF(h.bususer_q_predir))'',0,100));
    maxlength_bususer_q_predir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_predir)));
    avelength_bususer_q_predir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_predir)),h.bususer_q_predir<>(typeof(h.bususer_q_predir))'');
    populated_bususer_q_prim_name_pcnt := AVE(GROUP,IF(h.bususer_q_prim_name = (TYPEOF(h.bususer_q_prim_name))'',0,100));
    maxlength_bususer_q_prim_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_prim_name)));
    avelength_bususer_q_prim_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_prim_name)),h.bususer_q_prim_name<>(typeof(h.bususer_q_prim_name))'');
    populated_bususer_q_addr_suffix_pcnt := AVE(GROUP,IF(h.bususer_q_addr_suffix = (TYPEOF(h.bususer_q_addr_suffix))'',0,100));
    maxlength_bususer_q_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_addr_suffix)));
    avelength_bususer_q_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_addr_suffix)),h.bususer_q_addr_suffix<>(typeof(h.bususer_q_addr_suffix))'');
    populated_bususer_q_postdir_pcnt := AVE(GROUP,IF(h.bususer_q_postdir = (TYPEOF(h.bususer_q_postdir))'',0,100));
    maxlength_bususer_q_postdir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_postdir)));
    avelength_bususer_q_postdir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_postdir)),h.bususer_q_postdir<>(typeof(h.bususer_q_postdir))'');
    populated_bususer_q_unit_desig_pcnt := AVE(GROUP,IF(h.bususer_q_unit_desig = (TYPEOF(h.bususer_q_unit_desig))'',0,100));
    maxlength_bususer_q_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_unit_desig)));
    avelength_bususer_q_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_unit_desig)),h.bususer_q_unit_desig<>(typeof(h.bususer_q_unit_desig))'');
    populated_bususer_q_sec_range_pcnt := AVE(GROUP,IF(h.bususer_q_sec_range = (TYPEOF(h.bususer_q_sec_range))'',0,100));
    maxlength_bususer_q_sec_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_sec_range)));
    avelength_bususer_q_sec_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_sec_range)),h.bususer_q_sec_range<>(typeof(h.bususer_q_sec_range))'');
    populated_bususer_q_v_city_name_pcnt := AVE(GROUP,IF(h.bususer_q_v_city_name = (TYPEOF(h.bususer_q_v_city_name))'',0,100));
    maxlength_bususer_q_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_v_city_name)));
    avelength_bususer_q_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_v_city_name)),h.bususer_q_v_city_name<>(typeof(h.bususer_q_v_city_name))'');
    populated_bususer_q_st_pcnt := AVE(GROUP,IF(h.bususer_q_st = (TYPEOF(h.bususer_q_st))'',0,100));
    maxlength_bususer_q_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_st)));
    avelength_bususer_q_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_st)),h.bususer_q_st<>(typeof(h.bususer_q_st))'');
    populated_bususer_q_zip5_pcnt := AVE(GROUP,IF(h.bususer_q_zip5 = (TYPEOF(h.bususer_q_zip5))'',0,100));
    maxlength_bususer_q_zip5 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_zip5)));
    avelength_bususer_q_zip5 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_zip5)),h.bususer_q_zip5<>(typeof(h.bususer_q_zip5))'');
    populated_bususer_q_zip4_pcnt := AVE(GROUP,IF(h.bususer_q_zip4 = (TYPEOF(h.bususer_q_zip4))'',0,100));
    maxlength_bususer_q_zip4 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_zip4)));
    avelength_bususer_q_zip4 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_zip4)),h.bususer_q_zip4<>(typeof(h.bususer_q_zip4))'');
    populated_bususer_q_addr_rec_type_pcnt := AVE(GROUP,IF(h.bususer_q_addr_rec_type = (TYPEOF(h.bususer_q_addr_rec_type))'',0,100));
    maxlength_bususer_q_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_addr_rec_type)));
    avelength_bususer_q_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_addr_rec_type)),h.bususer_q_addr_rec_type<>(typeof(h.bususer_q_addr_rec_type))'');
    populated_bususer_q_fips_state_pcnt := AVE(GROUP,IF(h.bususer_q_fips_state = (TYPEOF(h.bususer_q_fips_state))'',0,100));
    maxlength_bususer_q_fips_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fips_state)));
    avelength_bususer_q_fips_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fips_state)),h.bususer_q_fips_state<>(typeof(h.bususer_q_fips_state))'');
    populated_bususer_q_fips_county_pcnt := AVE(GROUP,IF(h.bususer_q_fips_county = (TYPEOF(h.bususer_q_fips_county))'',0,100));
    maxlength_bususer_q_fips_county := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fips_county)));
    avelength_bususer_q_fips_county := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_fips_county)),h.bususer_q_fips_county<>(typeof(h.bususer_q_fips_county))'');
    populated_bususer_q_geo_lat_pcnt := AVE(GROUP,IF(h.bususer_q_geo_lat = (TYPEOF(h.bususer_q_geo_lat))'',0,100));
    maxlength_bususer_q_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_lat)));
    avelength_bususer_q_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_lat)),h.bususer_q_geo_lat<>(typeof(h.bususer_q_geo_lat))'');
    populated_bususer_q_geo_long_pcnt := AVE(GROUP,IF(h.bususer_q_geo_long = (TYPEOF(h.bususer_q_geo_long))'',0,100));
    maxlength_bususer_q_geo_long := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_long)));
    avelength_bususer_q_geo_long := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_long)),h.bususer_q_geo_long<>(typeof(h.bususer_q_geo_long))'');
    populated_bususer_q_cbsa_pcnt := AVE(GROUP,IF(h.bususer_q_cbsa = (TYPEOF(h.bususer_q_cbsa))'',0,100));
    maxlength_bususer_q_cbsa := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_cbsa)));
    avelength_bususer_q_cbsa := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_cbsa)),h.bususer_q_cbsa<>(typeof(h.bususer_q_cbsa))'');
    populated_bususer_q_geo_blk_pcnt := AVE(GROUP,IF(h.bususer_q_geo_blk = (TYPEOF(h.bususer_q_geo_blk))'',0,100));
    maxlength_bususer_q_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_blk)));
    avelength_bususer_q_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_blk)),h.bususer_q_geo_blk<>(typeof(h.bususer_q_geo_blk))'');
    populated_bususer_q_geo_match_pcnt := AVE(GROUP,IF(h.bususer_q_geo_match = (TYPEOF(h.bususer_q_geo_match))'',0,100));
    maxlength_bususer_q_geo_match := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_match)));
    avelength_bususer_q_geo_match := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_geo_match)),h.bususer_q_geo_match<>(typeof(h.bususer_q_geo_match))'');
    populated_bususer_q_err_stat_pcnt := AVE(GROUP,IF(h.bususer_q_err_stat = (TYPEOF(h.bususer_q_err_stat))'',0,100));
    maxlength_bususer_q_err_stat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_err_stat)));
    avelength_bususer_q_err_stat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_err_stat)),h.bususer_q_err_stat<>(typeof(h.bususer_q_err_stat))'');
    populated_bususer_q_appended_ssn_pcnt := AVE(GROUP,IF(h.bususer_q_appended_ssn = (TYPEOF(h.bususer_q_appended_ssn))'',0,100));
    maxlength_bususer_q_appended_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_appended_ssn)));
    avelength_bususer_q_appended_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_appended_ssn)),h.bususer_q_appended_ssn<>(typeof(h.bususer_q_appended_ssn))'');
    populated_bususer_q_appended_adl_pcnt := AVE(GROUP,IF(h.bususer_q_appended_adl = (TYPEOF(h.bususer_q_appended_adl))'',0,100));
    maxlength_bususer_q_appended_adl := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_appended_adl)));
    avelength_bususer_q_appended_adl := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.bususer_q_appended_adl)),h.bususer_q_appended_adl<>(typeof(h.bususer_q_appended_adl))'');
    populated_permissions_glb_purpose_pcnt := AVE(GROUP,IF(h.permissions_glb_purpose = (TYPEOF(h.permissions_glb_purpose))'',0,100));
    maxlength_permissions_glb_purpose := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_glb_purpose)));
    avelength_permissions_glb_purpose := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_glb_purpose)),h.permissions_glb_purpose<>(typeof(h.permissions_glb_purpose))'');
    populated_permissions_dppa_purpose_pcnt := AVE(GROUP,IF(h.permissions_dppa_purpose = (TYPEOF(h.permissions_dppa_purpose))'',0,100));
    maxlength_permissions_dppa_purpose := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_dppa_purpose)));
    avelength_permissions_dppa_purpose := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_dppa_purpose)),h.permissions_dppa_purpose<>(typeof(h.permissions_dppa_purpose))'');
    populated_permissions_fcra_purpose_pcnt := AVE(GROUP,IF(h.permissions_fcra_purpose = (TYPEOF(h.permissions_fcra_purpose))'',0,100));
    maxlength_permissions_fcra_purpose := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_fcra_purpose)));
    avelength_permissions_fcra_purpose := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.permissions_fcra_purpose)),h.permissions_fcra_purpose<>(typeof(h.permissions_fcra_purpose))'');
    populated_search_info_datetime_pcnt := AVE(GROUP,IF(h.search_info_datetime = (TYPEOF(h.search_info_datetime))'',0,100));
    maxlength_search_info_datetime := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_datetime)));
    avelength_search_info_datetime := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_datetime)),h.search_info_datetime<>(typeof(h.search_info_datetime))'');
    populated_search_info_start_monitor_pcnt := AVE(GROUP,IF(h.search_info_start_monitor = (TYPEOF(h.search_info_start_monitor))'',0,100));
    maxlength_search_info_start_monitor := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_start_monitor)));
    avelength_search_info_start_monitor := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_start_monitor)),h.search_info_start_monitor<>(typeof(h.search_info_start_monitor))'');
    populated_search_info_stop_monitor_pcnt := AVE(GROUP,IF(h.search_info_stop_monitor = (TYPEOF(h.search_info_stop_monitor))'',0,100));
    maxlength_search_info_stop_monitor := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_stop_monitor)));
    avelength_search_info_stop_monitor := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_stop_monitor)),h.search_info_stop_monitor<>(typeof(h.search_info_stop_monitor))'');
    populated_search_info_login_history_id_pcnt := AVE(GROUP,IF(h.search_info_login_history_id = (TYPEOF(h.search_info_login_history_id))'',0,100));
    maxlength_search_info_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_login_history_id)));
    avelength_search_info_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_login_history_id)),h.search_info_login_history_id<>(typeof(h.search_info_login_history_id))'');
    populated_search_info_transaction_id_pcnt := AVE(GROUP,IF(h.search_info_transaction_id = (TYPEOF(h.search_info_transaction_id))'',0,100));
    maxlength_search_info_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_transaction_id)));
    avelength_search_info_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_transaction_id)),h.search_info_transaction_id<>(typeof(h.search_info_transaction_id))'');
    populated_search_info_sequence_number_pcnt := AVE(GROUP,IF(h.search_info_sequence_number = (TYPEOF(h.search_info_sequence_number))'',0,100));
    maxlength_search_info_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_sequence_number)));
    avelength_search_info_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_sequence_number)),h.search_info_sequence_number<>(typeof(h.search_info_sequence_number))'');
    populated_search_info_method_pcnt := AVE(GROUP,IF(h.search_info_method = (TYPEOF(h.search_info_method))'',0,100));
    maxlength_search_info_method := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_method)));
    avelength_search_info_method := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_method)),h.search_info_method<>(typeof(h.search_info_method))'');
    populated_search_info_product_code_pcnt := AVE(GROUP,IF(h.search_info_product_code = (TYPEOF(h.search_info_product_code))'',0,100));
    maxlength_search_info_product_code := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_product_code)));
    avelength_search_info_product_code := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_product_code)),h.search_info_product_code<>(typeof(h.search_info_product_code))'');
    populated_search_info_transaction_type_pcnt := AVE(GROUP,IF(h.search_info_transaction_type = (TYPEOF(h.search_info_transaction_type))'',0,100));
    maxlength_search_info_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_transaction_type)));
    avelength_search_info_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_transaction_type)),h.search_info_transaction_type<>(typeof(h.search_info_transaction_type))'');
    populated_search_info_function_description_pcnt := AVE(GROUP,IF(h.search_info_function_description = (TYPEOF(h.search_info_function_description))'',0,100));
    maxlength_search_info_function_description := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_function_description)));
    avelength_search_info_function_description := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_function_description)),h.search_info_function_description<>(typeof(h.search_info_function_description))'');
    populated_search_info_ipaddr_pcnt := AVE(GROUP,IF(h.search_info_ipaddr = (TYPEOF(h.search_info_ipaddr))'',0,100));
    maxlength_search_info_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_ipaddr)));
    avelength_search_info_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.search_info_ipaddr)),h.search_info_ipaddr<>(typeof(h.search_info_ipaddr))'');
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT28.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT28.StrType)le.ssn),TRIM((SALT28.StrType)le.mbs_company_id),TRIM((SALT28.StrType)le.mbs_global_company_id),TRIM((SALT28.StrType)le.allow_flags_allowflags),TRIM((SALT28.StrType)le.bus_intel_primary_market_code),TRIM((SALT28.StrType)le.bus_intel_secondary_market_code),TRIM((SALT28.StrType)le.bus_intel_industry_1_code),TRIM((SALT28.StrType)le.bus_intel_industry_2_code),TRIM((SALT28.StrType)le.bus_intel_sub_market),TRIM((SALT28.StrType)le.bus_intel_vertical),TRIM((SALT28.StrType)le.bus_intel_use),TRIM((SALT28.StrType)le.bus_intel_industry),TRIM((SALT28.StrType)le.person_q_full_name),TRIM((SALT28.StrType)le.person_q_first_name),TRIM((SALT28.StrType)le.person_q_middle_name),TRIM((SALT28.StrType)le.person_q_last_name),TRIM((SALT28.StrType)le.person_q_address),TRIM((SALT28.StrType)le.person_q_city),TRIM((SALT28.StrType)le.person_q_state),TRIM((SALT28.StrType)le.person_q_zip),TRIM((SALT28.StrType)le.person_q_personal_phone),TRIM((SALT28.StrType)le.person_q_work_phone),TRIM((SALT28.StrType)le.person_q_dob),TRIM((SALT28.StrType)le.person_q_dl),TRIM((SALT28.StrType)le.person_q_dl_st),TRIM((SALT28.StrType)le.person_q_email_address),TRIM((SALT28.StrType)le.person_q_ssn),TRIM((SALT28.StrType)le.person_q_linkid),TRIM((SALT28.StrType)le.person_q_ipaddr),TRIM((SALT28.StrType)le.person_q_title),TRIM((SALT28.StrType)le.person_q_fname),TRIM((SALT28.StrType)le.person_q_mname),TRIM((SALT28.StrType)le.person_q_lname),TRIM((SALT28.StrType)le.person_q_name_suffix),TRIM((SALT28.StrType)le.person_q_prim_range),TRIM((SALT28.StrType)le.person_q_predir),TRIM((SALT28.StrType)le.person_q_prim_name),TRIM((SALT28.StrType)le.person_q_addr_suffix),TRIM((SALT28.StrType)le.person_q_postdir),TRIM((SALT28.StrType)le.person_q_unit_desig),TRIM((SALT28.StrType)le.person_q_sec_range),TRIM((SALT28.StrType)le.person_q_v_city_name),TRIM((SALT28.StrType)le.person_q_st),TRIM((SALT28.StrType)le.person_q_zip5),TRIM((SALT28.StrType)le.person_q_zip4),TRIM((SALT28.StrType)le.person_q_addr_rec_type),TRIM((SALT28.StrType)le.person_q_fips_state),TRIM((SALT28.StrType)le.person_q_fips_county),TRIM((SALT28.StrType)le.person_q_geo_lat),TRIM((SALT28.StrType)le.person_q_geo_long),TRIM((SALT28.StrType)le.person_q_cbsa),TRIM((SALT28.StrType)le.person_q_geo_blk),TRIM((SALT28.StrType)le.person_q_geo_match),TRIM((SALT28.StrType)le.person_q_err_stat),TRIM((SALT28.StrType)le.person_q_appended_ssn),TRIM((SALT28.StrType)le.person_q_appended_adl),TRIM((SALT28.StrType)le.bus_q_cname),TRIM((SALT28.StrType)le.bus_q_address),TRIM((SALT28.StrType)le.bus_q_city),TRIM((SALT28.StrType)le.bus_q_state),TRIM((SALT28.StrType)le.bus_q_zip),TRIM((SALT28.StrType)le.bus_q_company_phone),TRIM((SALT28.StrType)le.bus_q_ein),TRIM((SALT28.StrType)le.bus_q_charter_number),TRIM((SALT28.StrType)le.bus_q_ucc_number),TRIM((SALT28.StrType)le.bus_q_domain_name),TRIM((SALT28.StrType)le.bus_q_prim_range),TRIM((SALT28.StrType)le.bus_q_predir),TRIM((SALT28.StrType)le.bus_q_prim_name),TRIM((SALT28.StrType)le.bus_q_addr_suffix),TRIM((SALT28.StrType)le.bus_q_postdir),TRIM((SALT28.StrType)le.bus_q_unit_desig),TRIM((SALT28.StrType)le.bus_q_sec_range),TRIM((SALT28.StrType)le.bus_q_v_city_name),TRIM((SALT28.StrType)le.bus_q_st),TRIM((SALT28.StrType)le.bus_q_zip5),TRIM((SALT28.StrType)le.bus_q_zip4),TRIM((SALT28.StrType)le.bus_q_addr_rec_type),TRIM((SALT28.StrType)le.bus_q_fips_state),TRIM((SALT28.StrType)le.bus_q_fips_county),TRIM((SALT28.StrType)le.bus_q_geo_lat),TRIM((SALT28.StrType)le.bus_q_geo_long),TRIM((SALT28.StrType)le.bus_q_cbsa),TRIM((SALT28.StrType)le.bus_q_geo_blk),TRIM((SALT28.StrType)le.bus_q_geo_match),TRIM((SALT28.StrType)le.bus_q_err_stat),TRIM((SALT28.StrType)le.bus_q_appended_bdid),TRIM((SALT28.StrType)le.bus_q_appended_ein),TRIM((SALT28.StrType)le.bususer_q_personal_phone),TRIM((SALT28.StrType)le.bususer_q_dob),TRIM((SALT28.StrType)le.bususer_q_dl),TRIM((SALT28.StrType)le.bususer_q_dl_st),TRIM((SALT28.StrType)le.bususer_q_ssn),TRIM((SALT28.StrType)le.bususer_q_title),TRIM((SALT28.StrType)le.bususer_q_fname),TRIM((SALT28.StrType)le.bususer_q_mname),TRIM((SALT28.StrType)le.bususer_q_lname),TRIM((SALT28.StrType)le.bususer_q_name_suffix),TRIM((SALT28.StrType)le.bususer_q_prim_range),TRIM((SALT28.StrType)le.bususer_q_predir),TRIM((SALT28.StrType)le.bususer_q_prim_name),TRIM((SALT28.StrType)le.bususer_q_addr_suffix),TRIM((SALT28.StrType)le.bususer_q_postdir),TRIM((SALT28.StrType)le.bususer_q_unit_desig),TRIM((SALT28.StrType)le.bususer_q_sec_range),TRIM((SALT28.StrType)le.bususer_q_v_city_name),TRIM((SALT28.StrType)le.bususer_q_st),TRIM((SALT28.StrType)le.bususer_q_zip5),TRIM((SALT28.StrType)le.bususer_q_zip4),TRIM((SALT28.StrType)le.bususer_q_addr_rec_type),TRIM((SALT28.StrType)le.bususer_q_fips_state),TRIM((SALT28.StrType)le.bususer_q_fips_county),TRIM((SALT28.StrType)le.bususer_q_geo_lat),TRIM((SALT28.StrType)le.bususer_q_geo_long),TRIM((SALT28.StrType)le.bususer_q_cbsa),TRIM((SALT28.StrType)le.bususer_q_geo_blk),TRIM((SALT28.StrType)le.bususer_q_geo_match),TRIM((SALT28.StrType)le.bususer_q_err_stat),TRIM((SALT28.StrType)le.bususer_q_appended_ssn),TRIM((SALT28.StrType)le.bususer_q_appended_adl),TRIM((SALT28.StrType)le.permissions_glb_purpose),TRIM((SALT28.StrType)le.permissions_dppa_purpose),TRIM((SALT28.StrType)le.permissions_fcra_purpose),TRIM((SALT28.StrType)le.search_info_datetime),TRIM((SALT28.StrType)le.search_info_start_monitor),TRIM((SALT28.StrType)le.search_info_stop_monitor),TRIM((SALT28.StrType)le.search_info_login_history_id),TRIM((SALT28.StrType)le.search_info_transaction_id),TRIM((SALT28.StrType)le.search_info_sequence_number),TRIM((SALT28.StrType)le.search_info_method),TRIM((SALT28.StrType)le.search_info_product_code),TRIM((SALT28.StrType)le.search_info_transaction_type),TRIM((SALT28.StrType)le.search_info_function_description),TRIM((SALT28.StrType)le.search_info_ipaddr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,134,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'ssn'}
      ,{2,'mbs_company_id'}
      ,{3,'mbs_global_company_id'}
      ,{4,'allow_flags_allowflags'}
      ,{5,'bus_intel_primary_market_code'}
      ,{6,'bus_intel_secondary_market_code'}
      ,{7,'bus_intel_industry_1_code'}
      ,{8,'bus_intel_industry_2_code'}
      ,{9,'bus_intel_sub_market'}
      ,{10,'bus_intel_vertical'}
      ,{11,'bus_intel_use'}
      ,{12,'bus_intel_industry'}
      ,{13,'person_q_full_name'}
      ,{14,'person_q_first_name'}
      ,{15,'person_q_middle_name'}
      ,{16,'person_q_last_name'}
      ,{17,'person_q_address'}
      ,{18,'person_q_city'}
      ,{19,'person_q_state'}
      ,{20,'person_q_zip'}
      ,{21,'person_q_personal_phone'}
      ,{22,'person_q_work_phone'}
      ,{23,'person_q_dob'}
      ,{24,'person_q_dl'}
      ,{25,'person_q_dl_st'}
      ,{26,'person_q_email_address'}
      ,{27,'person_q_ssn'}
      ,{28,'person_q_linkid'}
      ,{29,'person_q_ipaddr'}
      ,{30,'person_q_title'}
      ,{31,'person_q_fname'}
      ,{32,'person_q_mname'}
      ,{33,'person_q_lname'}
      ,{34,'person_q_name_suffix'}
      ,{35,'person_q_prim_range'}
      ,{36,'person_q_predir'}
      ,{37,'person_q_prim_name'}
      ,{38,'person_q_addr_suffix'}
      ,{39,'person_q_postdir'}
      ,{40,'person_q_unit_desig'}
      ,{41,'person_q_sec_range'}
      ,{42,'person_q_v_city_name'}
      ,{43,'person_q_st'}
      ,{44,'person_q_zip5'}
      ,{45,'person_q_zip4'}
      ,{46,'person_q_addr_rec_type'}
      ,{47,'person_q_fips_state'}
      ,{48,'person_q_fips_county'}
      ,{49,'person_q_geo_lat'}
      ,{50,'person_q_geo_long'}
      ,{51,'person_q_cbsa'}
      ,{52,'person_q_geo_blk'}
      ,{53,'person_q_geo_match'}
      ,{54,'person_q_err_stat'}
      ,{55,'person_q_appended_ssn'}
      ,{56,'person_q_appended_adl'}
      ,{57,'bus_q_cname'}
      ,{58,'bus_q_address'}
      ,{59,'bus_q_city'}
      ,{60,'bus_q_state'}
      ,{61,'bus_q_zip'}
      ,{62,'bus_q_company_phone'}
      ,{63,'bus_q_ein'}
      ,{64,'bus_q_charter_number'}
      ,{65,'bus_q_ucc_number'}
      ,{66,'bus_q_domain_name'}
      ,{67,'bus_q_prim_range'}
      ,{68,'bus_q_predir'}
      ,{69,'bus_q_prim_name'}
      ,{70,'bus_q_addr_suffix'}
      ,{71,'bus_q_postdir'}
      ,{72,'bus_q_unit_desig'}
      ,{73,'bus_q_sec_range'}
      ,{74,'bus_q_v_city_name'}
      ,{75,'bus_q_st'}
      ,{76,'bus_q_zip5'}
      ,{77,'bus_q_zip4'}
      ,{78,'bus_q_addr_rec_type'}
      ,{79,'bus_q_fips_state'}
      ,{80,'bus_q_fips_county'}
      ,{81,'bus_q_geo_lat'}
      ,{82,'bus_q_geo_long'}
      ,{83,'bus_q_cbsa'}
      ,{84,'bus_q_geo_blk'}
      ,{85,'bus_q_geo_match'}
      ,{86,'bus_q_err_stat'}
      ,{87,'bus_q_appended_bdid'}
      ,{88,'bus_q_appended_ein'}
      ,{89,'bususer_q_personal_phone'}
      ,{90,'bususer_q_dob'}
      ,{91,'bususer_q_dl'}
      ,{92,'bususer_q_dl_st'}
      ,{93,'bususer_q_ssn'}
      ,{94,'bususer_q_title'}
      ,{95,'bususer_q_fname'}
      ,{96,'bususer_q_mname'}
      ,{97,'bususer_q_lname'}
      ,{98,'bususer_q_name_suffix'}
      ,{99,'bususer_q_prim_range'}
      ,{100,'bususer_q_predir'}
      ,{101,'bususer_q_prim_name'}
      ,{102,'bususer_q_addr_suffix'}
      ,{103,'bususer_q_postdir'}
      ,{104,'bususer_q_unit_desig'}
      ,{105,'bususer_q_sec_range'}
      ,{106,'bususer_q_v_city_name'}
      ,{107,'bususer_q_st'}
      ,{108,'bususer_q_zip5'}
      ,{109,'bususer_q_zip4'}
      ,{110,'bususer_q_addr_rec_type'}
      ,{111,'bususer_q_fips_state'}
      ,{112,'bususer_q_fips_county'}
      ,{113,'bususer_q_geo_lat'}
      ,{114,'bususer_q_geo_long'}
      ,{115,'bususer_q_cbsa'}
      ,{116,'bususer_q_geo_blk'}
      ,{117,'bususer_q_geo_match'}
      ,{118,'bususer_q_err_stat'}
      ,{119,'bususer_q_appended_ssn'}
      ,{120,'bususer_q_appended_adl'}
      ,{121,'permissions_glb_purpose'}
      ,{122,'permissions_dppa_purpose'}
      ,{123,'permissions_fcra_purpose'}
      ,{124,'search_info_datetime'}
      ,{125,'search_info_start_monitor'}
      ,{126,'search_info_stop_monitor'}
      ,{127,'search_info_login_history_id'}
      ,{128,'search_info_transaction_id'}
      ,{129,'search_info_sequence_number'}
      ,{130,'search_info_method'}
      ,{131,'search_info_product_code'}
      ,{132,'search_info_transaction_type'}
      ,{133,'search_info_function_description'}
      ,{134,'search_info_ipaddr'}],SALT28.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT28.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT28.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_ssn((SALT28.StrType)le.ssn),
    Fields.InValid_mbs_company_id((SALT28.StrType)le.mbs_company_id),
    Fields.InValid_mbs_global_company_id((SALT28.StrType)le.mbs_global_company_id),
    Fields.InValid_allow_flags_allowflags((SALT28.StrType)le.allow_flags_allowflags),
    Fields.InValid_bus_intel_primary_market_code((SALT28.StrType)le.bus_intel_primary_market_code),
    Fields.InValid_bus_intel_secondary_market_code((SALT28.StrType)le.bus_intel_secondary_market_code),
    Fields.InValid_bus_intel_industry_1_code((SALT28.StrType)le.bus_intel_industry_1_code),
    Fields.InValid_bus_intel_industry_2_code((SALT28.StrType)le.bus_intel_industry_2_code),
    Fields.InValid_bus_intel_sub_market((SALT28.StrType)le.bus_intel_sub_market),
    Fields.InValid_bus_intel_vertical((SALT28.StrType)le.bus_intel_vertical),
    Fields.InValid_bus_intel_use((SALT28.StrType)le.bus_intel_use),
    Fields.InValid_bus_intel_industry((SALT28.StrType)le.bus_intel_industry),
    Fields.InValid_person_q_full_name((SALT28.StrType)le.person_q_full_name),
    Fields.InValid_person_q_first_name((SALT28.StrType)le.person_q_first_name),
    Fields.InValid_person_q_middle_name((SALT28.StrType)le.person_q_middle_name),
    Fields.InValid_person_q_last_name((SALT28.StrType)le.person_q_last_name),
    Fields.InValid_person_q_address((SALT28.StrType)le.person_q_address),
    Fields.InValid_person_q_city((SALT28.StrType)le.person_q_city),
    Fields.InValid_person_q_state((SALT28.StrType)le.person_q_state),
    Fields.InValid_person_q_zip((SALT28.StrType)le.person_q_zip),
    Fields.InValid_person_q_personal_phone((SALT28.StrType)le.person_q_personal_phone),
    Fields.InValid_person_q_work_phone((SALT28.StrType)le.person_q_work_phone),
    Fields.InValid_person_q_dob((SALT28.StrType)le.person_q_dob),
    Fields.InValid_person_q_dl((SALT28.StrType)le.person_q_dl),
    Fields.InValid_person_q_dl_st((SALT28.StrType)le.person_q_dl_st),
    Fields.InValid_person_q_email_address((SALT28.StrType)le.person_q_email_address),
    Fields.InValid_person_q_ssn((SALT28.StrType)le.person_q_ssn),
    Fields.InValid_person_q_linkid((SALT28.StrType)le.person_q_linkid),
    Fields.InValid_person_q_ipaddr((SALT28.StrType)le.person_q_ipaddr),
    Fields.InValid_person_q_title((SALT28.StrType)le.person_q_title),
    Fields.InValid_person_q_fname((SALT28.StrType)le.person_q_fname),
    Fields.InValid_person_q_mname((SALT28.StrType)le.person_q_mname),
    Fields.InValid_person_q_lname((SALT28.StrType)le.person_q_lname),
    Fields.InValid_person_q_name_suffix((SALT28.StrType)le.person_q_name_suffix),
    Fields.InValid_person_q_prim_range((SALT28.StrType)le.person_q_prim_range),
    Fields.InValid_person_q_predir((SALT28.StrType)le.person_q_predir),
    Fields.InValid_person_q_prim_name((SALT28.StrType)le.person_q_prim_name),
    Fields.InValid_person_q_addr_suffix((SALT28.StrType)le.person_q_addr_suffix),
    Fields.InValid_person_q_postdir((SALT28.StrType)le.person_q_postdir),
    Fields.InValid_person_q_unit_desig((SALT28.StrType)le.person_q_unit_desig),
    Fields.InValid_person_q_sec_range((SALT28.StrType)le.person_q_sec_range),
    Fields.InValid_person_q_v_city_name((SALT28.StrType)le.person_q_v_city_name),
    Fields.InValid_person_q_st((SALT28.StrType)le.person_q_st),
    Fields.InValid_person_q_zip5((SALT28.StrType)le.person_q_zip5),
    Fields.InValid_person_q_zip4((SALT28.StrType)le.person_q_zip4),
    Fields.InValid_person_q_addr_rec_type((SALT28.StrType)le.person_q_addr_rec_type),
    Fields.InValid_person_q_fips_state((SALT28.StrType)le.person_q_fips_state),
    Fields.InValid_person_q_fips_county((SALT28.StrType)le.person_q_fips_county),
    Fields.InValid_person_q_geo_lat((SALT28.StrType)le.person_q_geo_lat),
    Fields.InValid_person_q_geo_long((SALT28.StrType)le.person_q_geo_long),
    Fields.InValid_person_q_cbsa((SALT28.StrType)le.person_q_cbsa),
    Fields.InValid_person_q_geo_blk((SALT28.StrType)le.person_q_geo_blk),
    Fields.InValid_person_q_geo_match((SALT28.StrType)le.person_q_geo_match),
    Fields.InValid_person_q_err_stat((SALT28.StrType)le.person_q_err_stat),
    Fields.InValid_person_q_appended_ssn((SALT28.StrType)le.person_q_appended_ssn),
    Fields.InValid_person_q_appended_adl((SALT28.StrType)le.person_q_appended_adl),
    Fields.InValid_bus_q_cname((SALT28.StrType)le.bus_q_cname),
    Fields.InValid_bus_q_address((SALT28.StrType)le.bus_q_address),
    Fields.InValid_bus_q_city((SALT28.StrType)le.bus_q_city),
    Fields.InValid_bus_q_state((SALT28.StrType)le.bus_q_state),
    Fields.InValid_bus_q_zip((SALT28.StrType)le.bus_q_zip),
    Fields.InValid_bus_q_company_phone((SALT28.StrType)le.bus_q_company_phone),
    Fields.InValid_bus_q_ein((SALT28.StrType)le.bus_q_ein),
    Fields.InValid_bus_q_charter_number((SALT28.StrType)le.bus_q_charter_number),
    Fields.InValid_bus_q_ucc_number((SALT28.StrType)le.bus_q_ucc_number),
    Fields.InValid_bus_q_domain_name((SALT28.StrType)le.bus_q_domain_name),
    Fields.InValid_bus_q_prim_range((SALT28.StrType)le.bus_q_prim_range),
    Fields.InValid_bus_q_predir((SALT28.StrType)le.bus_q_predir),
    Fields.InValid_bus_q_prim_name((SALT28.StrType)le.bus_q_prim_name),
    Fields.InValid_bus_q_addr_suffix((SALT28.StrType)le.bus_q_addr_suffix),
    Fields.InValid_bus_q_postdir((SALT28.StrType)le.bus_q_postdir),
    Fields.InValid_bus_q_unit_desig((SALT28.StrType)le.bus_q_unit_desig),
    Fields.InValid_bus_q_sec_range((SALT28.StrType)le.bus_q_sec_range),
    Fields.InValid_bus_q_v_city_name((SALT28.StrType)le.bus_q_v_city_name),
    Fields.InValid_bus_q_st((SALT28.StrType)le.bus_q_st),
    Fields.InValid_bus_q_zip5((SALT28.StrType)le.bus_q_zip5),
    Fields.InValid_bus_q_zip4((SALT28.StrType)le.bus_q_zip4),
    Fields.InValid_bus_q_addr_rec_type((SALT28.StrType)le.bus_q_addr_rec_type),
    Fields.InValid_bus_q_fips_state((SALT28.StrType)le.bus_q_fips_state),
    Fields.InValid_bus_q_fips_county((SALT28.StrType)le.bus_q_fips_county),
    Fields.InValid_bus_q_geo_lat((SALT28.StrType)le.bus_q_geo_lat),
    Fields.InValid_bus_q_geo_long((SALT28.StrType)le.bus_q_geo_long),
    Fields.InValid_bus_q_cbsa((SALT28.StrType)le.bus_q_cbsa),
    Fields.InValid_bus_q_geo_blk((SALT28.StrType)le.bus_q_geo_blk),
    Fields.InValid_bus_q_geo_match((SALT28.StrType)le.bus_q_geo_match),
    Fields.InValid_bus_q_err_stat((SALT28.StrType)le.bus_q_err_stat),
    Fields.InValid_bus_q_appended_bdid((SALT28.StrType)le.bus_q_appended_bdid),
    Fields.InValid_bus_q_appended_ein((SALT28.StrType)le.bus_q_appended_ein),
    Fields.InValid_bususer_q_personal_phone((SALT28.StrType)le.bususer_q_personal_phone),
    Fields.InValid_bususer_q_dob((SALT28.StrType)le.bususer_q_dob),
    Fields.InValid_bususer_q_dl((SALT28.StrType)le.bususer_q_dl),
    Fields.InValid_bususer_q_dl_st((SALT28.StrType)le.bususer_q_dl_st),
    Fields.InValid_bususer_q_ssn((SALT28.StrType)le.bususer_q_ssn),
    Fields.InValid_bususer_q_title((SALT28.StrType)le.bususer_q_title),
    Fields.InValid_bususer_q_fname((SALT28.StrType)le.bususer_q_fname),
    Fields.InValid_bususer_q_mname((SALT28.StrType)le.bususer_q_mname),
    Fields.InValid_bususer_q_lname((SALT28.StrType)le.bususer_q_lname),
    Fields.InValid_bususer_q_name_suffix((SALT28.StrType)le.bususer_q_name_suffix),
    Fields.InValid_bususer_q_prim_range((SALT28.StrType)le.bususer_q_prim_range),
    Fields.InValid_bususer_q_predir((SALT28.StrType)le.bususer_q_predir),
    Fields.InValid_bususer_q_prim_name((SALT28.StrType)le.bususer_q_prim_name),
    Fields.InValid_bususer_q_addr_suffix((SALT28.StrType)le.bususer_q_addr_suffix),
    Fields.InValid_bususer_q_postdir((SALT28.StrType)le.bususer_q_postdir),
    Fields.InValid_bususer_q_unit_desig((SALT28.StrType)le.bususer_q_unit_desig),
    Fields.InValid_bususer_q_sec_range((SALT28.StrType)le.bususer_q_sec_range),
    Fields.InValid_bususer_q_v_city_name((SALT28.StrType)le.bususer_q_v_city_name),
    Fields.InValid_bususer_q_st((SALT28.StrType)le.bususer_q_st),
    Fields.InValid_bususer_q_zip5((SALT28.StrType)le.bususer_q_zip5),
    Fields.InValid_bususer_q_zip4((SALT28.StrType)le.bususer_q_zip4),
    Fields.InValid_bususer_q_addr_rec_type((SALT28.StrType)le.bususer_q_addr_rec_type),
    Fields.InValid_bususer_q_fips_state((SALT28.StrType)le.bususer_q_fips_state),
    Fields.InValid_bususer_q_fips_county((SALT28.StrType)le.bususer_q_fips_county),
    Fields.InValid_bususer_q_geo_lat((SALT28.StrType)le.bususer_q_geo_lat),
    Fields.InValid_bususer_q_geo_long((SALT28.StrType)le.bususer_q_geo_long),
    Fields.InValid_bususer_q_cbsa((SALT28.StrType)le.bususer_q_cbsa),
    Fields.InValid_bususer_q_geo_blk((SALT28.StrType)le.bususer_q_geo_blk),
    Fields.InValid_bususer_q_geo_match((SALT28.StrType)le.bususer_q_geo_match),
    Fields.InValid_bususer_q_err_stat((SALT28.StrType)le.bususer_q_err_stat),
    Fields.InValid_bususer_q_appended_ssn((SALT28.StrType)le.bususer_q_appended_ssn),
    Fields.InValid_bususer_q_appended_adl((SALT28.StrType)le.bususer_q_appended_adl),
    Fields.InValid_permissions_glb_purpose((SALT28.StrType)le.permissions_glb_purpose),
    Fields.InValid_permissions_dppa_purpose((SALT28.StrType)le.permissions_dppa_purpose),
    Fields.InValid_permissions_fcra_purpose((SALT28.StrType)le.permissions_fcra_purpose),
    Fields.InValid_search_info_datetime((SALT28.StrType)le.search_info_datetime),
    Fields.InValid_search_info_start_monitor((SALT28.StrType)le.search_info_start_monitor),
    Fields.InValid_search_info_stop_monitor((SALT28.StrType)le.search_info_stop_monitor),
    Fields.InValid_search_info_login_history_id((SALT28.StrType)le.search_info_login_history_id),
    Fields.InValid_search_info_transaction_id((SALT28.StrType)le.search_info_transaction_id),
    Fields.InValid_search_info_sequence_number((SALT28.StrType)le.search_info_sequence_number),
    Fields.InValid_search_info_method((SALT28.StrType)le.search_info_method),
    Fields.InValid_search_info_product_code((SALT28.StrType)le.search_info_product_code),
    Fields.InValid_search_info_transaction_type((SALT28.StrType)le.search_info_transaction_type),
    Fields.InValid_search_info_function_description((SALT28.StrType)le.search_info_function_description),
    Fields.InValid_search_info_ipaddr((SALT28.StrType)le.search_info_ipaddr),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,134,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := record
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_global_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_allow_flags_allowflags(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_primary_market_code(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_secondary_market_code(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_industry_1_code(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_industry_2_code(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_sub_market(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_vertical(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_use(TotalErrors.ErrorNum),Fields.InValidMessage_bus_intel_industry(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_address(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_city(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_state(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_zip(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_personal_phone(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_dob(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_dl(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_dl_st(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_linkid(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_title(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_fname(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_mname(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_lname(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_predir(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_st(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_addr_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_appended_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_person_q_appended_adl(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_cname(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_address(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_city(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_state(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_zip(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_ein(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_ucc_number(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_domain_name(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_predir(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_st(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_addr_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_appended_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bus_q_appended_ein(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_personal_phone(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_dob(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_dl(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_dl_st(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_title(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_fname(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_mname(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_lname(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_predir(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_st(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_addr_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_appended_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_bususer_q_appended_adl(TotalErrors.ErrorNum),Fields.InValidMessage_permissions_glb_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_permissions_dppa_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_permissions_fcra_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_datetime(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_start_monitor(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_stop_monitor(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_sequence_number(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_method(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_product_code(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_function_description(TotalErrors.ErrorNum),Fields.InValidMessage_search_info_ipaddr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
END;
