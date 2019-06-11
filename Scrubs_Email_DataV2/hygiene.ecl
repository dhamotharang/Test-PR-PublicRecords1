IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Email_DataV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.email_src))'', MAX(GROUP,h.email_src));
    NumberOfRecords := COUNT(GROUP);
    populated_clean_email_cnt := COUNT(GROUP,h.clean_email <> (TYPEOF(h.clean_email))'');
    populated_clean_email_pcnt := AVE(GROUP,IF(h.clean_email = (TYPEOF(h.clean_email))'',0,100));
    maxlength_clean_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_email)));
    avelength_clean_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_email)),h.clean_email<>(typeof(h.clean_email))'');
    populated_append_email_username_cnt := COUNT(GROUP,h.append_email_username <> (TYPEOF(h.append_email_username))'');
    populated_append_email_username_pcnt := AVE(GROUP,IF(h.append_email_username = (TYPEOF(h.append_email_username))'',0,100));
    maxlength_append_email_username := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_email_username)));
    avelength_append_email_username := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_email_username)),h.append_email_username<>(typeof(h.append_email_username))'');
    populated_append_domain_cnt := COUNT(GROUP,h.append_domain <> (TYPEOF(h.append_domain))'');
    populated_append_domain_pcnt := AVE(GROUP,IF(h.append_domain = (TYPEOF(h.append_domain))'',0,100));
    maxlength_append_domain := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain)));
    avelength_append_domain := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain)),h.append_domain<>(typeof(h.append_domain))'');
    populated_append_domain_type_cnt := COUNT(GROUP,h.append_domain_type <> (TYPEOF(h.append_domain_type))'');
    populated_append_domain_type_pcnt := AVE(GROUP,IF(h.append_domain_type = (TYPEOF(h.append_domain_type))'',0,100));
    maxlength_append_domain_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_type)));
    avelength_append_domain_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_type)),h.append_domain_type<>(typeof(h.append_domain_type))'');
    populated_append_domain_root_cnt := COUNT(GROUP,h.append_domain_root <> (TYPEOF(h.append_domain_root))'');
    populated_append_domain_root_pcnt := AVE(GROUP,IF(h.append_domain_root = (TYPEOF(h.append_domain_root))'',0,100));
    maxlength_append_domain_root := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_root)));
    avelength_append_domain_root := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_root)),h.append_domain_root<>(typeof(h.append_domain_root))'');
    populated_append_domain_ext_cnt := COUNT(GROUP,h.append_domain_ext <> (TYPEOF(h.append_domain_ext))'');
    populated_append_domain_ext_pcnt := AVE(GROUP,IF(h.append_domain_ext = (TYPEOF(h.append_domain_ext))'',0,100));
    maxlength_append_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_ext)));
    avelength_append_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_ext)),h.append_domain_ext<>(typeof(h.append_domain_ext))'');
    populated_append_is_tld_state_cnt := COUNT(GROUP,h.append_is_tld_state <> (TYPEOF(h.append_is_tld_state))'');
    populated_append_is_tld_state_pcnt := AVE(GROUP,IF(h.append_is_tld_state = (TYPEOF(h.append_is_tld_state))'',0,100));
    maxlength_append_is_tld_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_state)));
    avelength_append_is_tld_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_state)),h.append_is_tld_state<>(typeof(h.append_is_tld_state))'');
    populated_append_is_tld_generic_cnt := COUNT(GROUP,h.append_is_tld_generic <> (TYPEOF(h.append_is_tld_generic))'');
    populated_append_is_tld_generic_pcnt := AVE(GROUP,IF(h.append_is_tld_generic = (TYPEOF(h.append_is_tld_generic))'',0,100));
    maxlength_append_is_tld_generic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_generic)));
    avelength_append_is_tld_generic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_generic)),h.append_is_tld_generic<>(typeof(h.append_is_tld_generic))'');
    populated_append_is_tld_country_cnt := COUNT(GROUP,h.append_is_tld_country <> (TYPEOF(h.append_is_tld_country))'');
    populated_append_is_tld_country_pcnt := AVE(GROUP,IF(h.append_is_tld_country = (TYPEOF(h.append_is_tld_country))'',0,100));
    maxlength_append_is_tld_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_country)));
    avelength_append_is_tld_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_country)),h.append_is_tld_country<>(typeof(h.append_is_tld_country))'');
    populated_append_is_valid_domain_ext_cnt := COUNT(GROUP,h.append_is_valid_domain_ext <> (TYPEOF(h.append_is_valid_domain_ext))'');
    populated_append_is_valid_domain_ext_pcnt := AVE(GROUP,IF(h.append_is_valid_domain_ext = (TYPEOF(h.append_is_valid_domain_ext))'',0,100));
    maxlength_append_is_valid_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_valid_domain_ext)));
    avelength_append_is_valid_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_valid_domain_ext)),h.append_is_valid_domain_ext<>(typeof(h.append_is_valid_domain_ext))'');
    populated_email_rec_key_cnt := COUNT(GROUP,h.email_rec_key <> (TYPEOF(h.email_rec_key))'');
    populated_email_rec_key_pcnt := AVE(GROUP,IF(h.email_rec_key = (TYPEOF(h.email_rec_key))'',0,100));
    maxlength_email_rec_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_rec_key)));
    avelength_email_rec_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_rec_key)),h.email_rec_key<>(typeof(h.email_rec_key))'');
    populated_email_src_cnt := COUNT(GROUP,h.email_src <> (TYPEOF(h.email_src))'');
    populated_email_src_pcnt := AVE(GROUP,IF(h.email_src = (TYPEOF(h.email_src))'',0,100));
    maxlength_email_src := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_src)));
    avelength_email_src := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_src)),h.email_src<>(typeof(h.email_src))'');
    populated_orig_pmghousehold_id_cnt := COUNT(GROUP,h.orig_pmghousehold_id <> (TYPEOF(h.orig_pmghousehold_id))'');
    populated_orig_pmghousehold_id_pcnt := AVE(GROUP,IF(h.orig_pmghousehold_id = (TYPEOF(h.orig_pmghousehold_id))'',0,100));
    maxlength_orig_pmghousehold_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pmghousehold_id)));
    avelength_orig_pmghousehold_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pmghousehold_id)),h.orig_pmghousehold_id<>(typeof(h.orig_pmghousehold_id))'');
    populated_orig_pmgindividual_id_cnt := COUNT(GROUP,h.orig_pmgindividual_id <> (TYPEOF(h.orig_pmgindividual_id))'');
    populated_orig_pmgindividual_id_pcnt := AVE(GROUP,IF(h.orig_pmgindividual_id = (TYPEOF(h.orig_pmgindividual_id))'',0,100));
    maxlength_orig_pmgindividual_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pmgindividual_id)));
    avelength_orig_pmgindividual_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pmgindividual_id)),h.orig_pmgindividual_id<>(typeof(h.orig_pmgindividual_id))'');
    populated_orig_first_name_cnt := COUNT(GROUP,h.orig_first_name <> (TYPEOF(h.orig_first_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_last_name_cnt := COUNT(GROUP,h.orig_last_name <> (TYPEOF(h.orig_last_name))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_middle_name_cnt := COUNT(GROUP,h.orig_middle_name <> (TYPEOF(h.orig_middle_name))'');
    populated_orig_middle_name_pcnt := AVE(GROUP,IF(h.orig_middle_name = (TYPEOF(h.orig_middle_name))'',0,100));
    maxlength_orig_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_middle_name)));
    avelength_orig_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_middle_name)),h.orig_middle_name<>(typeof(h.orig_middle_name))'');
    populated_orig_name_suffix_cnt := COUNT(GROUP,h.orig_name_suffix <> (TYPEOF(h.orig_name_suffix))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_email_cnt := COUNT(GROUP,h.orig_email <> (TYPEOF(h.orig_email))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_ip_cnt := COUNT(GROUP,h.orig_ip <> (TYPEOF(h.orig_ip))'');
    populated_orig_ip_pcnt := AVE(GROUP,IF(h.orig_ip = (TYPEOF(h.orig_ip))'',0,100));
    maxlength_orig_ip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ip)));
    avelength_orig_ip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ip)),h.orig_ip<>(typeof(h.orig_ip))'');
    populated_orig_login_date_cnt := COUNT(GROUP,h.orig_login_date <> (TYPEOF(h.orig_login_date))'');
    populated_orig_login_date_pcnt := AVE(GROUP,IF(h.orig_login_date = (TYPEOF(h.orig_login_date))'',0,100));
    maxlength_orig_login_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_login_date)));
    avelength_orig_login_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_login_date)),h.orig_login_date<>(typeof(h.orig_login_date))'');
    populated_orig_site_cnt := COUNT(GROUP,h.orig_site <> (TYPEOF(h.orig_site))'');
    populated_orig_site_pcnt := AVE(GROUP,IF(h.orig_site = (TYPEOF(h.orig_site))'',0,100));
    maxlength_orig_site := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_site)));
    avelength_orig_site := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_site)),h.orig_site<>(typeof(h.orig_site))'');
    populated_orig_e360_id_cnt := COUNT(GROUP,h.orig_e360_id <> (TYPEOF(h.orig_e360_id))'');
    populated_orig_e360_id_pcnt := AVE(GROUP,IF(h.orig_e360_id = (TYPEOF(h.orig_e360_id))'',0,100));
    maxlength_orig_e360_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_e360_id)));
    avelength_orig_e360_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_e360_id)),h.orig_e360_id<>(typeof(h.orig_e360_id))'');
    populated_orig_teramedia_id_cnt := COUNT(GROUP,h.orig_teramedia_id <> (TYPEOF(h.orig_teramedia_id))'');
    populated_orig_teramedia_id_pcnt := AVE(GROUP,IF(h.orig_teramedia_id = (TYPEOF(h.orig_teramedia_id))'',0,100));
    maxlength_orig_teramedia_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_teramedia_id)));
    avelength_orig_teramedia_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_teramedia_id)),h.orig_teramedia_id<>(typeof(h.orig_teramedia_id))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_did_type_cnt := COUNT(GROUP,h.did_type <> (TYPEOF(h.did_type))'');
    populated_did_type_pcnt := AVE(GROUP,IF(h.did_type = (TYPEOF(h.did_type))'',0,100));
    maxlength_did_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_type)));
    avelength_did_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_type)),h.did_type<>(typeof(h.did_type))'');
    populated_hhid_cnt := COUNT(GROUP,h.hhid <> (TYPEOF(h.hhid))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_append_rawaid_cnt := COUNT(GROUP,h.append_rawaid <> (TYPEOF(h.append_rawaid))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_ssn_cnt := COUNT(GROUP,h.clean_ssn <> (TYPEOF(h.clean_ssn))'');
    populated_clean_ssn_pcnt := AVE(GROUP,IF(h.clean_ssn = (TYPEOF(h.clean_ssn))'',0,100));
    maxlength_clean_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_ssn)));
    avelength_clean_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_ssn)),h.clean_ssn<>(typeof(h.clean_ssn))'');
    populated_clean_dob_cnt := COUNT(GROUP,h.clean_dob <> (TYPEOF(h.clean_dob))'');
    populated_clean_dob_pcnt := AVE(GROUP,IF(h.clean_dob = (TYPEOF(h.clean_dob))'',0,100));
    maxlength_clean_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dob)));
    avelength_clean_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dob)),h.clean_dob<>(typeof(h.clean_dob))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_activecode_cnt := COUNT(GROUP,h.activecode <> (TYPEOF(h.activecode))'');
    populated_activecode_pcnt := AVE(GROUP,IF(h.activecode = (TYPEOF(h.activecode))'',0,100));
    maxlength_activecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activecode)));
    avelength_activecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activecode)),h.activecode<>(typeof(h.activecode))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_current_rec_cnt := COUNT(GROUP,h.current_rec <> (TYPEOF(h.current_rec))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
    populated_orig_companyname_cnt := COUNT(GROUP,h.orig_companyname <> (TYPEOF(h.orig_companyname))'');
    populated_orig_companyname_pcnt := AVE(GROUP,IF(h.orig_companyname = (TYPEOF(h.orig_companyname))'',0,100));
    maxlength_orig_companyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_companyname)));
    avelength_orig_companyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_companyname)),h.orig_companyname<>(typeof(h.orig_companyname))'');
    populated_cln_companyname_cnt := COUNT(GROUP,h.cln_companyname <> (TYPEOF(h.cln_companyname))'');
    populated_cln_companyname_pcnt := AVE(GROUP,IF(h.cln_companyname = (TYPEOF(h.cln_companyname))'',0,100));
    maxlength_cln_companyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_companyname)));
    avelength_cln_companyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_companyname)),h.cln_companyname<>(typeof(h.cln_companyname))'');
    populated_companytitle_cnt := COUNT(GROUP,h.companytitle <> (TYPEOF(h.companytitle))'');
    populated_companytitle_pcnt := AVE(GROUP,IF(h.companytitle = (TYPEOF(h.companytitle))'',0,100));
    maxlength_companytitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.companytitle)));
    avelength_companytitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.companytitle)),h.companytitle<>(typeof(h.companytitle))'');
    populated_rules_cnt := COUNT(GROUP,h.rules <> (TYPEOF(h.rules))'');
    populated_rules_pcnt := AVE(GROUP,IF(h.rules = (TYPEOF(h.rules))'',0,100));
    maxlength_rules := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rules)));
    avelength_rules := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rules)),h.rules<>(typeof(h.rules))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,email_src,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_clean_email_pcnt *   0.00 / 100 + T.Populated_append_email_username_pcnt *   0.00 / 100 + T.Populated_append_domain_pcnt *   0.00 / 100 + T.Populated_append_domain_type_pcnt *   0.00 / 100 + T.Populated_append_domain_root_pcnt *   0.00 / 100 + T.Populated_append_domain_ext_pcnt *   0.00 / 100 + T.Populated_append_is_tld_state_pcnt *   0.00 / 100 + T.Populated_append_is_tld_generic_pcnt *   0.00 / 100 + T.Populated_append_is_tld_country_pcnt *   0.00 / 100 + T.Populated_append_is_valid_domain_ext_pcnt *   0.00 / 100 + T.Populated_email_rec_key_pcnt *   0.00 / 100 + T.Populated_email_src_pcnt *   0.00 / 100 + T.Populated_orig_pmghousehold_id_pcnt *   0.00 / 100 + T.Populated_orig_pmgindividual_id_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_email_pcnt *   0.00 / 100 + T.Populated_orig_ip_pcnt *   0.00 / 100 + T.Populated_orig_login_date_pcnt *   0.00 / 100 + T.Populated_orig_site_pcnt *   0.00 / 100 + T.Populated_orig_e360_id_pcnt *   0.00 / 100 + T.Populated_orig_teramedia_id_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_did_type_pcnt *   0.00 / 100 + T.Populated_hhid_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_append_rawaid_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_ssn_pcnt *   0.00 / 100 + T.Populated_clean_dob_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_activecode_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100 + T.Populated_orig_companyname_pcnt *   0.00 / 100 + T.Populated_cln_companyname_pcnt *   0.00 / 100 + T.Populated_companytitle_pcnt *   0.00 / 100 + T.Populated_rules_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING email_src1;
    STRING email_src2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.email_src1 := le.Source;
    SELF.email_src2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_clean_email_pcnt*ri.Populated_clean_email_pcnt *   0.00 / 10000 + le.Populated_append_email_username_pcnt*ri.Populated_append_email_username_pcnt *   0.00 / 10000 + le.Populated_append_domain_pcnt*ri.Populated_append_domain_pcnt *   0.00 / 10000 + le.Populated_append_domain_type_pcnt*ri.Populated_append_domain_type_pcnt *   0.00 / 10000 + le.Populated_append_domain_root_pcnt*ri.Populated_append_domain_root_pcnt *   0.00 / 10000 + le.Populated_append_domain_ext_pcnt*ri.Populated_append_domain_ext_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_state_pcnt*ri.Populated_append_is_tld_state_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_generic_pcnt*ri.Populated_append_is_tld_generic_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_country_pcnt*ri.Populated_append_is_tld_country_pcnt *   0.00 / 10000 + le.Populated_append_is_valid_domain_ext_pcnt*ri.Populated_append_is_valid_domain_ext_pcnt *   0.00 / 10000 + le.Populated_email_rec_key_pcnt*ri.Populated_email_rec_key_pcnt *   0.00 / 10000 + le.Populated_email_src_pcnt*ri.Populated_email_src_pcnt *   0.00 / 10000 + le.Populated_orig_pmghousehold_id_pcnt*ri.Populated_orig_pmghousehold_id_pcnt *   0.00 / 10000 + le.Populated_orig_pmgindividual_id_pcnt*ri.Populated_orig_pmgindividual_id_pcnt *   0.00 / 10000 + le.Populated_orig_first_name_pcnt*ri.Populated_orig_first_name_pcnt *   0.00 / 10000 + le.Populated_orig_last_name_pcnt*ri.Populated_orig_last_name_pcnt *   0.00 / 10000 + le.Populated_orig_middle_name_pcnt*ri.Populated_orig_middle_name_pcnt *   0.00 / 10000 + le.Populated_orig_name_suffix_pcnt*ri.Populated_orig_name_suffix_pcnt *   0.00 / 10000 + le.Populated_orig_address_pcnt*ri.Populated_orig_address_pcnt *   0.00 / 10000 + le.Populated_orig_city_pcnt*ri.Populated_orig_city_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_zip_pcnt*ri.Populated_orig_zip_pcnt *   0.00 / 10000 + le.Populated_orig_zip4_pcnt*ri.Populated_orig_zip4_pcnt *   0.00 / 10000 + le.Populated_orig_email_pcnt*ri.Populated_orig_email_pcnt *   0.00 / 10000 + le.Populated_orig_ip_pcnt*ri.Populated_orig_ip_pcnt *   0.00 / 10000 + le.Populated_orig_login_date_pcnt*ri.Populated_orig_login_date_pcnt *   0.00 / 10000 + le.Populated_orig_site_pcnt*ri.Populated_orig_site_pcnt *   0.00 / 10000 + le.Populated_orig_e360_id_pcnt*ri.Populated_orig_e360_id_pcnt *   0.00 / 10000 + le.Populated_orig_teramedia_id_pcnt*ri.Populated_orig_teramedia_id_pcnt *   0.00 / 10000 + le.Populated_orig_phone_pcnt*ri.Populated_orig_phone_pcnt *   0.00 / 10000 + le.Populated_orig_ssn_pcnt*ri.Populated_orig_ssn_pcnt *   0.00 / 10000 + le.Populated_orig_dob_pcnt*ri.Populated_orig_dob_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_did_type_pcnt*ri.Populated_did_type_pcnt *   0.00 / 10000 + le.Populated_hhid_pcnt*ri.Populated_hhid_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_append_rawaid_pcnt*ri.Populated_append_rawaid_pcnt *   0.00 / 10000 + le.Populated_clean_phone_pcnt*ri.Populated_clean_phone_pcnt *   0.00 / 10000 + le.Populated_clean_ssn_pcnt*ri.Populated_clean_ssn_pcnt *   0.00 / 10000 + le.Populated_clean_dob_pcnt*ri.Populated_clean_dob_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_activecode_pcnt*ri.Populated_activecode_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_current_rec_pcnt*ri.Populated_current_rec_pcnt *   0.00 / 10000 + le.Populated_orig_companyname_pcnt*ri.Populated_orig_companyname_pcnt *   0.00 / 10000 + le.Populated_cln_companyname_pcnt*ri.Populated_cln_companyname_pcnt *   0.00 / 10000 + le.Populated_companytitle_pcnt*ri.Populated_companytitle_pcnt *   0.00 / 10000 + le.Populated_rules_pcnt*ri.Populated_rules_pcnt *   0.00 / 10000 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_global_sid_pcnt*ri.Populated_global_sid_pcnt *   0.00 / 10000 + le.Populated_record_sid_pcnt*ri.Populated_record_sid_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_rec_key','email_src','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_middle_name','orig_name_suffix','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','orig_phone','orig_ssn','orig_dob','did','did_score','did_type','hhid','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','clean_phone','clean_ssn','clean_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec','orig_companyname','cln_companyname','companytitle','rules','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_clean_email_pcnt,le.populated_append_email_username_pcnt,le.populated_append_domain_pcnt,le.populated_append_domain_type_pcnt,le.populated_append_domain_root_pcnt,le.populated_append_domain_ext_pcnt,le.populated_append_is_tld_state_pcnt,le.populated_append_is_tld_generic_pcnt,le.populated_append_is_tld_country_pcnt,le.populated_append_is_valid_domain_ext_pcnt,le.populated_email_rec_key_pcnt,le.populated_email_src_pcnt,le.populated_orig_pmghousehold_id_pcnt,le.populated_orig_pmgindividual_id_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_last_name_pcnt,le.populated_orig_middle_name_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_email_pcnt,le.populated_orig_ip_pcnt,le.populated_orig_login_date_pcnt,le.populated_orig_site_pcnt,le.populated_orig_e360_id_pcnt,le.populated_orig_teramedia_id_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_dob_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_did_type_pcnt,le.populated_hhid_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_append_rawaid_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_ssn_pcnt,le.populated_clean_dob_pcnt,le.populated_process_date_pcnt,le.populated_activecode_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_current_rec_pcnt,le.populated_orig_companyname_pcnt,le.populated_cln_companyname_pcnt,le.populated_companytitle_pcnt,le.populated_rules_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_clean_email,le.maxlength_append_email_username,le.maxlength_append_domain,le.maxlength_append_domain_type,le.maxlength_append_domain_root,le.maxlength_append_domain_ext,le.maxlength_append_is_tld_state,le.maxlength_append_is_tld_generic,le.maxlength_append_is_tld_country,le.maxlength_append_is_valid_domain_ext,le.maxlength_email_rec_key,le.maxlength_email_src,le.maxlength_orig_pmghousehold_id,le.maxlength_orig_pmgindividual_id,le.maxlength_orig_first_name,le.maxlength_orig_last_name,le.maxlength_orig_middle_name,le.maxlength_orig_name_suffix,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_zip4,le.maxlength_orig_email,le.maxlength_orig_ip,le.maxlength_orig_login_date,le.maxlength_orig_site,le.maxlength_orig_e360_id,le.maxlength_orig_teramedia_id,le.maxlength_orig_phone,le.maxlength_orig_ssn,le.maxlength_orig_dob,le.maxlength_did,le.maxlength_did_score,le.maxlength_did_type,le.maxlength_hhid,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_append_rawaid,le.maxlength_clean_phone,le.maxlength_clean_ssn,le.maxlength_clean_dob,le.maxlength_process_date,le.maxlength_activecode,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_current_rec,le.maxlength_orig_companyname,le.maxlength_cln_companyname,le.maxlength_companytitle,le.maxlength_rules,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_clean_email,le.avelength_append_email_username,le.avelength_append_domain,le.avelength_append_domain_type,le.avelength_append_domain_root,le.avelength_append_domain_ext,le.avelength_append_is_tld_state,le.avelength_append_is_tld_generic,le.avelength_append_is_tld_country,le.avelength_append_is_valid_domain_ext,le.avelength_email_rec_key,le.avelength_email_src,le.avelength_orig_pmghousehold_id,le.avelength_orig_pmgindividual_id,le.avelength_orig_first_name,le.avelength_orig_last_name,le.avelength_orig_middle_name,le.avelength_orig_name_suffix,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_zip4,le.avelength_orig_email,le.avelength_orig_ip,le.avelength_orig_login_date,le.avelength_orig_site,le.avelength_orig_e360_id,le.avelength_orig_teramedia_id,le.avelength_orig_phone,le.avelength_orig_ssn,le.avelength_orig_dob,le.avelength_did,le.avelength_did_score,le.avelength_did_type,le.avelength_hhid,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_append_rawaid,le.avelength_clean_phone,le.avelength_clean_ssn,le.avelength_clean_dob,le.avelength_process_date,le.avelength_activecode,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_current_rec,le.avelength_orig_companyname,le.avelength_cln_companyname,le.avelength_companytitle,le.avelength_rules,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 106, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.email_src;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.clean_email),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),IF (le.email_rec_key <> 0,TRIM((SALT311.StrType)le.email_rec_key), ''),TRIM((SALT311.StrType)le.email_src),TRIM((SALT311.StrType)le.orig_pmghousehold_id),TRIM((SALT311.StrType)le.orig_pmgindividual_id),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ip),TRIM((SALT311.StrType)le.orig_login_date),TRIM((SALT311.StrType)le.orig_site),TRIM((SALT311.StrType)le.orig_e360_id),TRIM((SALT311.StrType)le.orig_teramedia_id),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dob),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.did_type),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT311.StrType)le.clean_dob), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.activecode),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.current_rec),TRIM((SALT311.StrType)le.orig_companyname),TRIM((SALT311.StrType)le.cln_companyname),TRIM((SALT311.StrType)le.companytitle),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,106,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 106);
  SELF.FldNo2 := 1 + (C % 106);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.clean_email),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),IF (le.email_rec_key <> 0,TRIM((SALT311.StrType)le.email_rec_key), ''),TRIM((SALT311.StrType)le.email_src),TRIM((SALT311.StrType)le.orig_pmghousehold_id),TRIM((SALT311.StrType)le.orig_pmgindividual_id),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ip),TRIM((SALT311.StrType)le.orig_login_date),TRIM((SALT311.StrType)le.orig_site),TRIM((SALT311.StrType)le.orig_e360_id),TRIM((SALT311.StrType)le.orig_teramedia_id),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dob),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.did_type),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT311.StrType)le.clean_dob), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.activecode),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.current_rec),TRIM((SALT311.StrType)le.orig_companyname),TRIM((SALT311.StrType)le.cln_companyname),TRIM((SALT311.StrType)le.companytitle),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.clean_email),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),IF (le.email_rec_key <> 0,TRIM((SALT311.StrType)le.email_rec_key), ''),TRIM((SALT311.StrType)le.email_src),TRIM((SALT311.StrType)le.orig_pmghousehold_id),TRIM((SALT311.StrType)le.orig_pmgindividual_id),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ip),TRIM((SALT311.StrType)le.orig_login_date),TRIM((SALT311.StrType)le.orig_site),TRIM((SALT311.StrType)le.orig_e360_id),TRIM((SALT311.StrType)le.orig_teramedia_id),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dob),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.did_type),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT311.StrType)le.clean_dob), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.activecode),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.current_rec),TRIM((SALT311.StrType)le.orig_companyname),TRIM((SALT311.StrType)le.cln_companyname),TRIM((SALT311.StrType)le.companytitle),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),106*106,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'clean_email'}
      ,{2,'append_email_username'}
      ,{3,'append_domain'}
      ,{4,'append_domain_type'}
      ,{5,'append_domain_root'}
      ,{6,'append_domain_ext'}
      ,{7,'append_is_tld_state'}
      ,{8,'append_is_tld_generic'}
      ,{9,'append_is_tld_country'}
      ,{10,'append_is_valid_domain_ext'}
      ,{11,'email_rec_key'}
      ,{12,'email_src'}
      ,{13,'orig_pmghousehold_id'}
      ,{14,'orig_pmgindividual_id'}
      ,{15,'orig_first_name'}
      ,{16,'orig_last_name'}
      ,{17,'orig_middle_name'}
      ,{18,'orig_name_suffix'}
      ,{19,'orig_address'}
      ,{20,'orig_city'}
      ,{21,'orig_state'}
      ,{22,'orig_zip'}
      ,{23,'orig_zip4'}
      ,{24,'orig_email'}
      ,{25,'orig_ip'}
      ,{26,'orig_login_date'}
      ,{27,'orig_site'}
      ,{28,'orig_e360_id'}
      ,{29,'orig_teramedia_id'}
      ,{30,'orig_phone'}
      ,{31,'orig_ssn'}
      ,{32,'orig_dob'}
      ,{33,'did'}
      ,{34,'did_score'}
      ,{35,'did_type'}
      ,{36,'hhid'}
      ,{37,'title'}
      ,{38,'fname'}
      ,{39,'mname'}
      ,{40,'lname'}
      ,{41,'name_suffix'}
      ,{42,'name_score'}
      ,{43,'prim_range'}
      ,{44,'predir'}
      ,{45,'prim_name'}
      ,{46,'addr_suffix'}
      ,{47,'postdir'}
      ,{48,'unit_desig'}
      ,{49,'sec_range'}
      ,{50,'p_city_name'}
      ,{51,'v_city_name'}
      ,{52,'st'}
      ,{53,'zip'}
      ,{54,'zip4'}
      ,{55,'cart'}
      ,{56,'cr_sort_sz'}
      ,{57,'lot'}
      ,{58,'lot_order'}
      ,{59,'dbpc'}
      ,{60,'chk_digit'}
      ,{61,'rec_type'}
      ,{62,'county'}
      ,{63,'geo_lat'}
      ,{64,'geo_long'}
      ,{65,'msa'}
      ,{66,'geo_blk'}
      ,{67,'geo_match'}
      ,{68,'err_stat'}
      ,{69,'append_rawaid'}
      ,{70,'clean_phone'}
      ,{71,'clean_ssn'}
      ,{72,'clean_dob'}
      ,{73,'process_date'}
      ,{74,'activecode'}
      ,{75,'date_first_seen'}
      ,{76,'date_last_seen'}
      ,{77,'date_vendor_first_reported'}
      ,{78,'date_vendor_last_reported'}
      ,{79,'current_rec'}
      ,{80,'orig_companyname'}
      ,{81,'cln_companyname'}
      ,{82,'companytitle'}
      ,{83,'rules'}
      ,{84,'dotid'}
      ,{85,'dotscore'}
      ,{86,'dotweight'}
      ,{87,'empid'}
      ,{88,'empscore'}
      ,{89,'empweight'}
      ,{90,'powid'}
      ,{91,'powscore'}
      ,{92,'powweight'}
      ,{93,'proxid'}
      ,{94,'proxscore'}
      ,{95,'proxweight'}
      ,{96,'seleid'}
      ,{97,'selescore'}
      ,{98,'seleweight'}
      ,{99,'orgid'}
      ,{100,'orgscore'}
      ,{101,'orgweight'}
      ,{102,'ultid'}
      ,{103,'ultscore'}
      ,{104,'ultweight'}
      ,{105,'global_sid'}
      ,{106,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.email_src) email_src; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_clean_email((SALT311.StrType)le.clean_email),
    Fields.InValid_append_email_username((SALT311.StrType)le.append_email_username),
    Fields.InValid_append_domain((SALT311.StrType)le.append_domain),
    Fields.InValid_append_domain_type((SALT311.StrType)le.append_domain_type),
    Fields.InValid_append_domain_root((SALT311.StrType)le.append_domain_root),
    Fields.InValid_append_domain_ext((SALT311.StrType)le.append_domain_ext),
    Fields.InValid_append_is_tld_state((SALT311.StrType)le.append_is_tld_state),
    Fields.InValid_append_is_tld_generic((SALT311.StrType)le.append_is_tld_generic),
    Fields.InValid_append_is_tld_country((SALT311.StrType)le.append_is_tld_country),
    Fields.InValid_append_is_valid_domain_ext((SALT311.StrType)le.append_is_valid_domain_ext),
    Fields.InValid_email_rec_key((SALT311.StrType)le.email_rec_key),
    Fields.InValid_email_src((SALT311.StrType)le.email_src),
    Fields.InValid_orig_pmghousehold_id((SALT311.StrType)le.orig_pmghousehold_id),
    Fields.InValid_orig_pmgindividual_id((SALT311.StrType)le.orig_pmgindividual_id),
    Fields.InValid_orig_first_name((SALT311.StrType)le.orig_first_name),
    Fields.InValid_orig_last_name((SALT311.StrType)le.orig_last_name),
    Fields.InValid_orig_middle_name((SALT311.StrType)le.orig_middle_name),
    Fields.InValid_orig_name_suffix((SALT311.StrType)le.orig_name_suffix),
    Fields.InValid_orig_address((SALT311.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4),
    Fields.InValid_orig_email((SALT311.StrType)le.orig_email),
    Fields.InValid_orig_ip((SALT311.StrType)le.orig_ip),
    Fields.InValid_orig_login_date((SALT311.StrType)le.orig_login_date),
    Fields.InValid_orig_site((SALT311.StrType)le.orig_site),
    Fields.InValid_orig_e360_id((SALT311.StrType)le.orig_e360_id),
    Fields.InValid_orig_teramedia_id((SALT311.StrType)le.orig_teramedia_id),
    Fields.InValid_orig_phone((SALT311.StrType)le.orig_phone),
    Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn),
    Fields.InValid_orig_dob((SALT311.StrType)le.orig_dob),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_did_type((SALT311.StrType)le.did_type),
    Fields.InValid_hhid((SALT311.StrType)le.hhid),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid),
    Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone),
    Fields.InValid_clean_ssn((SALT311.StrType)le.clean_ssn),
    Fields.InValid_clean_dob((SALT311.StrType)le.clean_dob),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_activecode((SALT311.StrType)le.activecode),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_current_rec((SALT311.StrType)le.current_rec),
    Fields.InValid_orig_companyname((SALT311.StrType)le.orig_companyname),
    Fields.InValid_cln_companyname((SALT311.StrType)le.cln_companyname),
    Fields.InValid_companytitle((SALT311.StrType)le.companytitle),
    Fields.InValid_rules((SALT311.StrType)le.rules),
    Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Fields.InValid_empid((SALT311.StrType)le.empid),
    Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Fields.InValid_powid((SALT311.StrType)le.powid),
    Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.email_src := le.email_src;
END;
Errors := NORMALIZE(h,106,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.email_src;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,email_src,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.email_src;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_clean_email(TotalErrors.ErrorNum),Fields.InValidMessage_append_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_root(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_state(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_generic(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_country(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_valid_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_email_rec_key(TotalErrors.ErrorNum),Fields.InValidMessage_email_src(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pmghousehold_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pmgindividual_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_site(TotalErrors.ErrorNum),Fields.InValidMessage_orig_e360_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_teramedia_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_did_type(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dob(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_activecode(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum),Fields.InValidMessage_orig_companyname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_companyname(TotalErrors.ErrorNum),Fields.InValidMessage_companytitle(TotalErrors.ErrorNum),Fields.InValidMessage_rules(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.email_src=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Email_DataV2, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
