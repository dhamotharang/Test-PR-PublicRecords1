IMPORT SALT39,STD;
EXPORT CA_Party_hygiene(dataset(CA_Party_layout_UCCV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_tmsid_cnt := COUNT(GROUP,h.tmsid <> (TYPEOF(h.tmsid))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_rmsid_cnt := COUNT(GROUP,h.rmsid <> (TYPEOF(h.rmsid))'');
    populated_rmsid_pcnt := AVE(GROUP,IF(h.rmsid = (TYPEOF(h.rmsid))'',0,100));
    maxlength_rmsid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rmsid)));
    avelength_rmsid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rmsid)),h.rmsid<>(typeof(h.rmsid))'');
    populated_orig_name_cnt := COUNT(GROUP,h.orig_name <> (TYPEOF(h.orig_name))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_suffix_cnt := COUNT(GROUP,h.orig_suffix <> (TYPEOF(h.orig_suffix))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_duns_number_cnt := COUNT(GROUP,h.duns_number <> (TYPEOF(h.duns_number))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_hq_duns_number_cnt := COUNT(GROUP,h.hq_duns_number <> (TYPEOF(h.hq_duns_number))'');
    populated_hq_duns_number_pcnt := AVE(GROUP,IF(h.hq_duns_number = (TYPEOF(h.hq_duns_number))'',0,100));
    maxlength_hq_duns_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.hq_duns_number)));
    avelength_hq_duns_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.hq_duns_number)),h.hq_duns_number<>(typeof(h.hq_duns_number))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_fein_cnt := COUNT(GROUP,h.fein <> (TYPEOF(h.fein))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_incorp_state_cnt := COUNT(GROUP,h.incorp_state <> (TYPEOF(h.incorp_state))'');
    populated_incorp_state_pcnt := AVE(GROUP,IF(h.incorp_state = (TYPEOF(h.incorp_state))'',0,100));
    maxlength_incorp_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.incorp_state)));
    avelength_incorp_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.incorp_state)),h.incorp_state<>(typeof(h.incorp_state))'');
    populated_corp_number_cnt := COUNT(GROUP,h.corp_number <> (TYPEOF(h.corp_number))'');
    populated_corp_number_pcnt := AVE(GROUP,IF(h.corp_number = (TYPEOF(h.corp_number))'',0,100));
    maxlength_corp_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.corp_number)));
    avelength_corp_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.corp_number)),h.corp_number<>(typeof(h.corp_number))'');
    populated_corp_type_cnt := COUNT(GROUP,h.corp_type <> (TYPEOF(h.corp_type))'');
    populated_corp_type_pcnt := AVE(GROUP,IF(h.corp_type = (TYPEOF(h.corp_type))'',0,100));
    maxlength_corp_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.corp_type)));
    avelength_corp_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.corp_type)),h.corp_type<>(typeof(h.corp_type))'');
    populated_orig_address1_cnt := COUNT(GROUP,h.orig_address1 <> (TYPEOF(h.orig_address1))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_cnt := COUNT(GROUP,h.orig_address2 <> (TYPEOF(h.orig_address2))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip5_cnt := COUNT(GROUP,h.orig_zip5 <> (TYPEOF(h.orig_zip5))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_country_cnt := COUNT(GROUP,h.orig_country <> (TYPEOF(h.orig_country))'');
    populated_orig_country_pcnt := AVE(GROUP,IF(h.orig_country = (TYPEOF(h.orig_country))'',0,100));
    maxlength_orig_country := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_country)));
    avelength_orig_country := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_country)),h.orig_country<>(typeof(h.orig_country))'');
    populated_orig_province_cnt := COUNT(GROUP,h.orig_province <> (TYPEOF(h.orig_province))'');
    populated_orig_province_pcnt := AVE(GROUP,IF(h.orig_province = (TYPEOF(h.orig_province))'',0,100));
    maxlength_orig_province := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_province)));
    avelength_orig_province := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_province)),h.orig_province<>(typeof(h.orig_province))'');
    populated_orig_postal_code_cnt := COUNT(GROUP,h.orig_postal_code <> (TYPEOF(h.orig_postal_code))'');
    populated_orig_postal_code_pcnt := AVE(GROUP,IF(h.orig_postal_code = (TYPEOF(h.orig_postal_code))'',0,100));
    maxlength_orig_postal_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_postal_code)));
    avelength_orig_postal_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_postal_code)),h.orig_postal_code<>(typeof(h.orig_postal_code))'');
    populated_foreign_indc_cnt := COUNT(GROUP,h.foreign_indc <> (TYPEOF(h.foreign_indc))'');
    populated_foreign_indc_pcnt := AVE(GROUP,IF(h.foreign_indc = (TYPEOF(h.foreign_indc))'',0,100));
    maxlength_foreign_indc := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.foreign_indc)));
    avelength_foreign_indc := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.foreign_indc)),h.foreign_indc<>(typeof(h.foreign_indc))'');
    populated_party_type_cnt := COUNT(GROUP,h.party_type <> (TYPEOF(h.party_type))'');
    populated_party_type_pcnt := AVE(GROUP,IF(h.party_type = (TYPEOF(h.party_type))'',0,100));
    maxlength_party_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.party_type)));
    avelength_party_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.party_type)),h.party_type<>(typeof(h.party_type))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_cnt := COUNT(GROUP,h.ace_fips_county <> (TYPEOF(h.ace_fips_county))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_last_line_cnt := COUNT(GROUP,h.prep_addr_last_line <> (TYPEOF(h.prep_addr_last_line))'');
    populated_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.prep_addr_last_line = (TYPEOF(h.prep_addr_last_line))'',0,100));
    maxlength_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prep_addr_last_line)));
    avelength_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prep_addr_last_line)),h.prep_addr_last_line<>(typeof(h.prep_addr_last_line))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_cnt := COUNT(GROUP,h.aceaid <> (TYPEOF(h.aceaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_rmsid_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_duns_number_pcnt *   0.00 / 100 + T.Populated_hq_duns_number_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_incorp_state_pcnt *   0.00 / 100 + T.Populated_corp_number_pcnt *   0.00 / 100 + T.Populated_corp_type_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_country_pcnt *   0.00 / 100 + T.Populated_orig_province_pcnt *   0.00 / 100 + T.Populated_orig_postal_code_pcnt *   0.00 / 100 + T.Populated_foreign_indc_pcnt *   0.00 / 100 + T.Populated_party_type_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tmsid','rmsid','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','duns_number','hq_duns_number','ssn','fein','incorp_state','corp_number','corp_type','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_country','orig_province','orig_postal_code','foreign_indc','party_type','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','process_date','title','fname','mname','lname','name_suffix','name_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','did','did_score','bdid_score','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tmsid_pcnt,le.populated_rmsid_pcnt,le.populated_orig_name_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_suffix_pcnt,le.populated_duns_number_pcnt,le.populated_hq_duns_number_pcnt,le.populated_ssn_pcnt,le.populated_fein_pcnt,le.populated_incorp_state_pcnt,le.populated_corp_number_pcnt,le.populated_corp_type_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_country_pcnt,le.populated_orig_province_pcnt,le.populated_orig_postal_code_pcnt,le.populated_foreign_indc_pcnt,le.populated_party_type_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_process_date_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_company_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_county_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_bdid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_score_pcnt,le.populated_source_rec_id_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_last_line_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tmsid,le.maxlength_rmsid,le.maxlength_orig_name,le.maxlength_orig_lname,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_suffix,le.maxlength_duns_number,le.maxlength_hq_duns_number,le.maxlength_ssn,le.maxlength_fein,le.maxlength_incorp_state,le.maxlength_corp_number,le.maxlength_corp_type,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip5,le.maxlength_orig_zip4,le.maxlength_orig_country,le.maxlength_orig_province,le.maxlength_orig_postal_code,le.maxlength_foreign_indc,le.maxlength_party_type,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_process_date,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_company_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_county,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_bdid,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid_score,le.maxlength_source_rec_id,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_last_line,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_tmsid,le.avelength_rmsid,le.avelength_orig_name,le.avelength_orig_lname,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_suffix,le.avelength_duns_number,le.avelength_hq_duns_number,le.avelength_ssn,le.avelength_fein,le.avelength_incorp_state,le.avelength_corp_number,le.avelength_corp_type,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip5,le.avelength_orig_zip4,le.avelength_orig_country,le.avelength_orig_province,le.avelength_orig_postal_code,le.avelength_foreign_indc,le.avelength_party_type,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_process_date,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_company_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_county,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_bdid,le.avelength_did,le.avelength_did_score,le.avelength_bdid_score,le.avelength_source_rec_id,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_prep_addr_line1,le.avelength_prep_addr_last_line,le.avelength_rawaid,le.avelength_aceaid,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 96, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.tmsid),TRIM((SALT39.StrType)le.rmsid),TRIM((SALT39.StrType)le.orig_name),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_suffix),TRIM((SALT39.StrType)le.duns_number),TRIM((SALT39.StrType)le.hq_duns_number),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.fein),TRIM((SALT39.StrType)le.incorp_state),TRIM((SALT39.StrType)le.corp_number),TRIM((SALT39.StrType)le.corp_type),TRIM((SALT39.StrType)le.orig_address1),TRIM((SALT39.StrType)le.orig_address2),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip5),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_country),TRIM((SALT39.StrType)le.orig_province),TRIM((SALT39.StrType)le.orig_postal_code),TRIM((SALT39.StrType)le.foreign_indc),TRIM((SALT39.StrType)le.party_type),IF (le.dt_first_seen <> 0,TRIM((SALT39.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT39.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.company_name),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip5),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.county),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.ace_fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),IF (le.bdid <> 0,TRIM((SALT39.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),IF (le.bdid_score <> 0,TRIM((SALT39.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT39.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT39.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT39.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT39.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT39.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT39.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT39.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT39.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT39.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT39.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT39.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT39.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT39.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT39.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT39.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT39.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT39.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT39.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT39.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT39.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT39.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT39.StrType)le.ultweight), ''),TRIM((SALT39.StrType)le.prep_addr_line1),TRIM((SALT39.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT39.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT39.StrType)le.aceaid), ''),IF (le.persistent_record_id <> 0,TRIM((SALT39.StrType)le.persistent_record_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,96,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 96);
  SELF.FldNo2 := 1 + (C % 96);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.tmsid),TRIM((SALT39.StrType)le.rmsid),TRIM((SALT39.StrType)le.orig_name),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_suffix),TRIM((SALT39.StrType)le.duns_number),TRIM((SALT39.StrType)le.hq_duns_number),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.fein),TRIM((SALT39.StrType)le.incorp_state),TRIM((SALT39.StrType)le.corp_number),TRIM((SALT39.StrType)le.corp_type),TRIM((SALT39.StrType)le.orig_address1),TRIM((SALT39.StrType)le.orig_address2),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip5),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_country),TRIM((SALT39.StrType)le.orig_province),TRIM((SALT39.StrType)le.orig_postal_code),TRIM((SALT39.StrType)le.foreign_indc),TRIM((SALT39.StrType)le.party_type),IF (le.dt_first_seen <> 0,TRIM((SALT39.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT39.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.company_name),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip5),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.county),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.ace_fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),IF (le.bdid <> 0,TRIM((SALT39.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),IF (le.bdid_score <> 0,TRIM((SALT39.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT39.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT39.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT39.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT39.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT39.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT39.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT39.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT39.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT39.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT39.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT39.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT39.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT39.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT39.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT39.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT39.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT39.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT39.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT39.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT39.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT39.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT39.StrType)le.ultweight), ''),TRIM((SALT39.StrType)le.prep_addr_line1),TRIM((SALT39.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT39.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT39.StrType)le.aceaid), ''),IF (le.persistent_record_id <> 0,TRIM((SALT39.StrType)le.persistent_record_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.tmsid),TRIM((SALT39.StrType)le.rmsid),TRIM((SALT39.StrType)le.orig_name),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_suffix),TRIM((SALT39.StrType)le.duns_number),TRIM((SALT39.StrType)le.hq_duns_number),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.fein),TRIM((SALT39.StrType)le.incorp_state),TRIM((SALT39.StrType)le.corp_number),TRIM((SALT39.StrType)le.corp_type),TRIM((SALT39.StrType)le.orig_address1),TRIM((SALT39.StrType)le.orig_address2),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip5),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_country),TRIM((SALT39.StrType)le.orig_province),TRIM((SALT39.StrType)le.orig_postal_code),TRIM((SALT39.StrType)le.foreign_indc),TRIM((SALT39.StrType)le.party_type),IF (le.dt_first_seen <> 0,TRIM((SALT39.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT39.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT39.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.company_name),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip5),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.county),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.ace_fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),IF (le.bdid <> 0,TRIM((SALT39.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),IF (le.bdid_score <> 0,TRIM((SALT39.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT39.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT39.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT39.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT39.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT39.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT39.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT39.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT39.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT39.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT39.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT39.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT39.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT39.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT39.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT39.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT39.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT39.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT39.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT39.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT39.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT39.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT39.StrType)le.ultweight), ''),TRIM((SALT39.StrType)le.prep_addr_line1),TRIM((SALT39.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT39.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT39.StrType)le.aceaid), ''),IF (le.persistent_record_id <> 0,TRIM((SALT39.StrType)le.persistent_record_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),96*96,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tmsid'}
      ,{2,'rmsid'}
      ,{3,'orig_name'}
      ,{4,'orig_lname'}
      ,{5,'orig_fname'}
      ,{6,'orig_mname'}
      ,{7,'orig_suffix'}
      ,{8,'duns_number'}
      ,{9,'hq_duns_number'}
      ,{10,'ssn'}
      ,{11,'fein'}
      ,{12,'incorp_state'}
      ,{13,'corp_number'}
      ,{14,'corp_type'}
      ,{15,'orig_address1'}
      ,{16,'orig_address2'}
      ,{17,'orig_city'}
      ,{18,'orig_state'}
      ,{19,'orig_zip5'}
      ,{20,'orig_zip4'}
      ,{21,'orig_country'}
      ,{22,'orig_province'}
      ,{23,'orig_postal_code'}
      ,{24,'foreign_indc'}
      ,{25,'party_type'}
      ,{26,'dt_first_seen'}
      ,{27,'dt_last_seen'}
      ,{28,'dt_vendor_last_reported'}
      ,{29,'dt_vendor_first_reported'}
      ,{30,'process_date'}
      ,{31,'title'}
      ,{32,'fname'}
      ,{33,'mname'}
      ,{34,'lname'}
      ,{35,'name_suffix'}
      ,{36,'name_score'}
      ,{37,'company_name'}
      ,{38,'prim_range'}
      ,{39,'predir'}
      ,{40,'prim_name'}
      ,{41,'suffix'}
      ,{42,'postdir'}
      ,{43,'unit_desig'}
      ,{44,'sec_range'}
      ,{45,'p_city_name'}
      ,{46,'v_city_name'}
      ,{47,'st'}
      ,{48,'zip5'}
      ,{49,'zip4'}
      ,{50,'county'}
      ,{51,'cart'}
      ,{52,'cr_sort_sz'}
      ,{53,'lot'}
      ,{54,'lot_order'}
      ,{55,'dpbc'}
      ,{56,'chk_digit'}
      ,{57,'rec_type'}
      ,{58,'ace_fips_st'}
      ,{59,'ace_fips_county'}
      ,{60,'geo_lat'}
      ,{61,'geo_long'}
      ,{62,'msa'}
      ,{63,'geo_blk'}
      ,{64,'geo_match'}
      ,{65,'err_stat'}
      ,{66,'bdid'}
      ,{67,'did'}
      ,{68,'did_score'}
      ,{69,'bdid_score'}
      ,{70,'source_rec_id'}
      ,{71,'dotid'}
      ,{72,'dotscore'}
      ,{73,'dotweight'}
      ,{74,'empid'}
      ,{75,'empscore'}
      ,{76,'empweight'}
      ,{77,'powid'}
      ,{78,'powscore'}
      ,{79,'powweight'}
      ,{80,'proxid'}
      ,{81,'proxscore'}
      ,{82,'proxweight'}
      ,{83,'seleid'}
      ,{84,'selescore'}
      ,{85,'seleweight'}
      ,{86,'orgid'}
      ,{87,'orgscore'}
      ,{88,'orgweight'}
      ,{89,'ultid'}
      ,{90,'ultscore'}
      ,{91,'ultweight'}
      ,{92,'prep_addr_line1'}
      ,{93,'prep_addr_last_line'}
      ,{94,'rawaid'}
      ,{95,'aceaid'}
      ,{96,'persistent_record_id'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CA_Party_Fields.InValid_tmsid((SALT39.StrType)le.tmsid),
    CA_Party_Fields.InValid_rmsid((SALT39.StrType)le.rmsid),
    CA_Party_Fields.InValid_orig_name((SALT39.StrType)le.orig_name,(SALT39.StrType)le.orig_lname,(SALT39.StrType)le.orig_fname),
    CA_Party_Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname,(SALT39.StrType)le.orig_name,(SALT39.StrType)le.orig_fname),
    CA_Party_Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname,(SALT39.StrType)le.orig_name,(SALT39.StrType)le.orig_lname),
    CA_Party_Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname),
    CA_Party_Fields.InValid_orig_suffix((SALT39.StrType)le.orig_suffix),
    CA_Party_Fields.InValid_duns_number((SALT39.StrType)le.duns_number),
    CA_Party_Fields.InValid_hq_duns_number((SALT39.StrType)le.hq_duns_number),
    CA_Party_Fields.InValid_ssn((SALT39.StrType)le.ssn),
    CA_Party_Fields.InValid_fein((SALT39.StrType)le.fein),
    CA_Party_Fields.InValid_incorp_state((SALT39.StrType)le.incorp_state),
    CA_Party_Fields.InValid_corp_number((SALT39.StrType)le.corp_number),
    CA_Party_Fields.InValid_corp_type((SALT39.StrType)le.corp_type),
    CA_Party_Fields.InValid_orig_address1((SALT39.StrType)le.orig_address1),
    CA_Party_Fields.InValid_orig_address2((SALT39.StrType)le.orig_address2),
    CA_Party_Fields.InValid_orig_city((SALT39.StrType)le.orig_city),
    CA_Party_Fields.InValid_orig_state((SALT39.StrType)le.orig_state),
    CA_Party_Fields.InValid_orig_zip5((SALT39.StrType)le.orig_zip5,(SALT39.StrType)le.orig_country),
    CA_Party_Fields.InValid_orig_zip4((SALT39.StrType)le.orig_zip4),
    CA_Party_Fields.InValid_orig_country((SALT39.StrType)le.orig_country),
    CA_Party_Fields.InValid_orig_province((SALT39.StrType)le.orig_province),
    CA_Party_Fields.InValid_orig_postal_code((SALT39.StrType)le.orig_postal_code),
    CA_Party_Fields.InValid_foreign_indc((SALT39.StrType)le.foreign_indc),
    CA_Party_Fields.InValid_party_type((SALT39.StrType)le.party_type),
    CA_Party_Fields.InValid_dt_first_seen((SALT39.StrType)le.dt_first_seen),
    CA_Party_Fields.InValid_dt_last_seen((SALT39.StrType)le.dt_last_seen),
    CA_Party_Fields.InValid_dt_vendor_last_reported((SALT39.StrType)le.dt_vendor_last_reported),
    CA_Party_Fields.InValid_dt_vendor_first_reported((SALT39.StrType)le.dt_vendor_first_reported),
    CA_Party_Fields.InValid_process_date((SALT39.StrType)le.process_date),
    CA_Party_Fields.InValid_title((SALT39.StrType)le.title),
    CA_Party_Fields.InValid_fname((SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname,(SALT39.StrType)le.company_name),
    CA_Party_Fields.InValid_mname((SALT39.StrType)le.mname,(SALT39.StrType)le.fname,(SALT39.StrType)le.lname,(SALT39.StrType)le.company_name),
    CA_Party_Fields.InValid_lname((SALT39.StrType)le.lname,(SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.company_name),
    CA_Party_Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix),
    CA_Party_Fields.InValid_name_score((SALT39.StrType)le.name_score),
    CA_Party_Fields.InValid_company_name((SALT39.StrType)le.company_name,(SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname),
    CA_Party_Fields.InValid_prim_range((SALT39.StrType)le.prim_range),
    CA_Party_Fields.InValid_predir((SALT39.StrType)le.predir),
    CA_Party_Fields.InValid_prim_name((SALT39.StrType)le.prim_name),
    CA_Party_Fields.InValid_suffix((SALT39.StrType)le.suffix),
    CA_Party_Fields.InValid_postdir((SALT39.StrType)le.postdir),
    CA_Party_Fields.InValid_unit_desig((SALT39.StrType)le.unit_desig),
    CA_Party_Fields.InValid_sec_range((SALT39.StrType)le.sec_range),
    CA_Party_Fields.InValid_p_city_name((SALT39.StrType)le.p_city_name),
    CA_Party_Fields.InValid_v_city_name((SALT39.StrType)le.v_city_name),
    CA_Party_Fields.InValid_st((SALT39.StrType)le.st),
    CA_Party_Fields.InValid_zip5((SALT39.StrType)le.zip5),
    CA_Party_Fields.InValid_zip4((SALT39.StrType)le.zip4),
    CA_Party_Fields.InValid_county((SALT39.StrType)le.county),
    CA_Party_Fields.InValid_cart((SALT39.StrType)le.cart),
    CA_Party_Fields.InValid_cr_sort_sz((SALT39.StrType)le.cr_sort_sz),
    CA_Party_Fields.InValid_lot((SALT39.StrType)le.lot),
    CA_Party_Fields.InValid_lot_order((SALT39.StrType)le.lot_order),
    CA_Party_Fields.InValid_dpbc((SALT39.StrType)le.dpbc),
    CA_Party_Fields.InValid_chk_digit((SALT39.StrType)le.chk_digit),
    CA_Party_Fields.InValid_rec_type((SALT39.StrType)le.rec_type),
    CA_Party_Fields.InValid_ace_fips_st((SALT39.StrType)le.ace_fips_st),
    CA_Party_Fields.InValid_ace_fips_county((SALT39.StrType)le.ace_fips_county),
    CA_Party_Fields.InValid_geo_lat((SALT39.StrType)le.geo_lat),
    CA_Party_Fields.InValid_geo_long((SALT39.StrType)le.geo_long),
    CA_Party_Fields.InValid_msa((SALT39.StrType)le.msa),
    CA_Party_Fields.InValid_geo_blk((SALT39.StrType)le.geo_blk),
    CA_Party_Fields.InValid_geo_match((SALT39.StrType)le.geo_match),
    CA_Party_Fields.InValid_err_stat((SALT39.StrType)le.err_stat),
    CA_Party_Fields.InValid_bdid((SALT39.StrType)le.bdid),
    CA_Party_Fields.InValid_did((SALT39.StrType)le.did),
    CA_Party_Fields.InValid_did_score((SALT39.StrType)le.did_score),
    CA_Party_Fields.InValid_bdid_score((SALT39.StrType)le.bdid_score),
    CA_Party_Fields.InValid_source_rec_id((SALT39.StrType)le.source_rec_id),
    CA_Party_Fields.InValid_dotid((SALT39.StrType)le.dotid),
    CA_Party_Fields.InValid_dotscore((SALT39.StrType)le.dotscore),
    CA_Party_Fields.InValid_dotweight((SALT39.StrType)le.dotweight),
    CA_Party_Fields.InValid_empid((SALT39.StrType)le.empid),
    CA_Party_Fields.InValid_empscore((SALT39.StrType)le.empscore),
    CA_Party_Fields.InValid_empweight((SALT39.StrType)le.empweight),
    CA_Party_Fields.InValid_powid((SALT39.StrType)le.powid),
    CA_Party_Fields.InValid_powscore((SALT39.StrType)le.powscore),
    CA_Party_Fields.InValid_powweight((SALT39.StrType)le.powweight),
    CA_Party_Fields.InValid_proxid((SALT39.StrType)le.proxid),
    CA_Party_Fields.InValid_proxscore((SALT39.StrType)le.proxscore),
    CA_Party_Fields.InValid_proxweight((SALT39.StrType)le.proxweight),
    CA_Party_Fields.InValid_seleid((SALT39.StrType)le.seleid),
    CA_Party_Fields.InValid_selescore((SALT39.StrType)le.selescore),
    CA_Party_Fields.InValid_seleweight((SALT39.StrType)le.seleweight),
    CA_Party_Fields.InValid_orgid((SALT39.StrType)le.orgid),
    CA_Party_Fields.InValid_orgscore((SALT39.StrType)le.orgscore),
    CA_Party_Fields.InValid_orgweight((SALT39.StrType)le.orgweight),
    CA_Party_Fields.InValid_ultid((SALT39.StrType)le.ultid),
    CA_Party_Fields.InValid_ultscore((SALT39.StrType)le.ultscore),
    CA_Party_Fields.InValid_ultweight((SALT39.StrType)le.ultweight),
    CA_Party_Fields.InValid_prep_addr_line1((SALT39.StrType)le.prep_addr_line1),
    CA_Party_Fields.InValid_prep_addr_last_line((SALT39.StrType)le.prep_addr_last_line),
    CA_Party_Fields.InValid_rawaid((SALT39.StrType)le.rawaid),
    CA_Party_Fields.InValid_aceaid((SALT39.StrType)le.aceaid),
    CA_Party_Fields.InValid_persistent_record_id((SALT39.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,96,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := CA_Party_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_tmsid','invalid_rmsid','invalid_orig_name','invalid_orig_lname','invalid_orig_fname','Unknown','Unknown','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory','Unknown','invalid_mandatory','invalid_orig_state','invalid_orig_zip5','invalid_orig_zip4','invalid_mandatory','Unknown','Unknown','invalid_boolean_yn','invalid_party_type','invalid_pastdate6','invalid_pastdate6','invalid_pastdate6','invalid_pastdate6','invalid_pastdate8','Unknown','invalid_fname','invalid_mname','invalid_lname','Unknown','Unknown','invalid_company_name','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_mandatory','invalid_mandatory','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CA_Party_Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_rmsid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_hq_duns_number(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_fein(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_incorp_state(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_corp_number(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_corp_type(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_country(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_province(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orig_postal_code(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_foreign_indc(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_party_type(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_title(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_fname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_mname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_lname(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_predir(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_st(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_county(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_cart(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_lot(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_msa(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_did(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_empid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_powid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_prep_addr_last_line(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),CA_Party_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_UCCV2, CA_Party_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
