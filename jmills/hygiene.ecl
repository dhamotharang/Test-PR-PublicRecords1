import ut,SALT28;
export hygiene(dataset(file_Key_fcra_email) h) := MODULE
//A simple summary record
export Summary(SALT28.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_flag_file_id_pcnt := AVE(GROUP,IF(h.flag_file_id = (TYPEOF(h.flag_file_id))'',0,100));
    maxlength_flag_file_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.flag_file_id)));
    avelength_flag_file_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.flag_file_id)),h.flag_file_id<>(typeof(h.flag_file_id))'');
    populated_clean_email_pcnt := AVE(GROUP,IF(h.clean_email = (TYPEOF(h.clean_email))'',0,100));
    maxlength_clean_email := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.clean_email)));
    avelength_clean_email := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.clean_email)),h.clean_email<>(typeof(h.clean_email))'');
    populated_append_email_username_pcnt := AVE(GROUP,IF(h.append_email_username = (TYPEOF(h.append_email_username))'',0,100));
    maxlength_append_email_username := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_email_username)));
    avelength_append_email_username := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_email_username)),h.append_email_username<>(typeof(h.append_email_username))'');
    populated_append_domain_pcnt := AVE(GROUP,IF(h.append_domain = (TYPEOF(h.append_domain))'',0,100));
    maxlength_append_domain := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain)));
    avelength_append_domain := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain)),h.append_domain<>(typeof(h.append_domain))'');
    populated_append_domain_type_pcnt := AVE(GROUP,IF(h.append_domain_type = (TYPEOF(h.append_domain_type))'',0,100));
    maxlength_append_domain_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_type)));
    avelength_append_domain_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_type)),h.append_domain_type<>(typeof(h.append_domain_type))'');
    populated_append_domain_root_pcnt := AVE(GROUP,IF(h.append_domain_root = (TYPEOF(h.append_domain_root))'',0,100));
    maxlength_append_domain_root := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_root)));
    avelength_append_domain_root := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_root)),h.append_domain_root<>(typeof(h.append_domain_root))'');
    populated_append_domain_ext_pcnt := AVE(GROUP,IF(h.append_domain_ext = (TYPEOF(h.append_domain_ext))'',0,100));
    maxlength_append_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_ext)));
    avelength_append_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_domain_ext)),h.append_domain_ext<>(typeof(h.append_domain_ext))'');
    populated_append_is_tld_state_pcnt := AVE(GROUP,IF(h.append_is_tld_state = (TYPEOF(h.append_is_tld_state))'',0,100));
    maxlength_append_is_tld_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_state)));
    avelength_append_is_tld_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_state)),h.append_is_tld_state<>(typeof(h.append_is_tld_state))'');
    populated_append_is_tld_generic_pcnt := AVE(GROUP,IF(h.append_is_tld_generic = (TYPEOF(h.append_is_tld_generic))'',0,100));
    maxlength_append_is_tld_generic := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_generic)));
    avelength_append_is_tld_generic := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_generic)),h.append_is_tld_generic<>(typeof(h.append_is_tld_generic))'');
    populated_append_is_tld_country_pcnt := AVE(GROUP,IF(h.append_is_tld_country = (TYPEOF(h.append_is_tld_country))'',0,100));
    maxlength_append_is_tld_country := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_country)));
    avelength_append_is_tld_country := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_tld_country)),h.append_is_tld_country<>(typeof(h.append_is_tld_country))'');
    populated_append_is_valid_domain_ext_pcnt := AVE(GROUP,IF(h.append_is_valid_domain_ext = (TYPEOF(h.append_is_valid_domain_ext))'',0,100));
    maxlength_append_is_valid_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_valid_domain_ext)));
    avelength_append_is_valid_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_is_valid_domain_ext)),h.append_is_valid_domain_ext<>(typeof(h.append_is_valid_domain_ext))'');
    populated_email_rec_key_pcnt := AVE(GROUP,IF(h.email_rec_key = (TYPEOF(h.email_rec_key))'',0,100));
    maxlength_email_rec_key := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_rec_key)));
    avelength_email_rec_key := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_rec_key)),h.email_rec_key<>(typeof(h.email_rec_key))'');
    populated_email_src_pcnt := AVE(GROUP,IF(h.email_src = (TYPEOF(h.email_src))'',0,100));
    maxlength_email_src := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src)));
    avelength_email_src := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src)),h.email_src<>(typeof(h.email_src))'');
    populated_rec_src_all_pcnt := AVE(GROUP,IF(h.rec_src_all = (TYPEOF(h.rec_src_all))'',0,100));
    maxlength_rec_src_all := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.rec_src_all)));
    avelength_rec_src_all := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.rec_src_all)),h.rec_src_all<>(typeof(h.rec_src_all))'');
    populated_email_src_all_pcnt := AVE(GROUP,IF(h.email_src_all = (TYPEOF(h.email_src_all))'',0,100));
    maxlength_email_src_all := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src_all)));
    avelength_email_src_all := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src_all)),h.email_src_all<>(typeof(h.email_src_all))'');
    populated_email_src_num_pcnt := AVE(GROUP,IF(h.email_src_num = (TYPEOF(h.email_src_num))'',0,100));
    maxlength_email_src_num := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src_num)));
    avelength_email_src_num := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.email_src_num)),h.email_src_num<>(typeof(h.email_src_num))'');
    populated_num_email_per_did_pcnt := AVE(GROUP,IF(h.num_email_per_did = (TYPEOF(h.num_email_per_did))'',0,100));
    maxlength_num_email_per_did := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.num_email_per_did)));
    avelength_num_email_per_did := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.num_email_per_did)),h.num_email_per_did<>(typeof(h.num_email_per_did))'');
    populated_num_did_per_email_pcnt := AVE(GROUP,IF(h.num_did_per_email = (TYPEOF(h.num_did_per_email))'',0,100));
    maxlength_num_did_per_email := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.num_did_per_email)));
    avelength_num_did_per_email := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.num_did_per_email)),h.num_did_per_email<>(typeof(h.num_did_per_email))'');
    populated_orig_pmghousehold_id_pcnt := AVE(GROUP,IF(h.orig_pmghousehold_id = (TYPEOF(h.orig_pmghousehold_id))'',0,100));
    maxlength_orig_pmghousehold_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_pmghousehold_id)));
    avelength_orig_pmghousehold_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_pmghousehold_id)),h.orig_pmghousehold_id<>(typeof(h.orig_pmghousehold_id))'');
    populated_orig_pmgindividual_id_pcnt := AVE(GROUP,IF(h.orig_pmgindividual_id = (TYPEOF(h.orig_pmgindividual_id))'',0,100));
    maxlength_orig_pmgindividual_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_pmgindividual_id)));
    avelength_orig_pmgindividual_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_pmgindividual_id)),h.orig_pmgindividual_id<>(typeof(h.orig_pmgindividual_id))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_ip_pcnt := AVE(GROUP,IF(h.orig_ip = (TYPEOF(h.orig_ip))'',0,100));
    maxlength_orig_ip := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_ip)));
    avelength_orig_ip := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_ip)),h.orig_ip<>(typeof(h.orig_ip))'');
    populated_orig_login_date_pcnt := AVE(GROUP,IF(h.orig_login_date = (TYPEOF(h.orig_login_date))'',0,100));
    maxlength_orig_login_date := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_login_date)));
    avelength_orig_login_date := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_login_date)),h.orig_login_date<>(typeof(h.orig_login_date))'');
    populated_orig_site_pcnt := AVE(GROUP,IF(h.orig_site = (TYPEOF(h.orig_site))'',0,100));
    maxlength_orig_site := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_site)));
    avelength_orig_site := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_site)),h.orig_site<>(typeof(h.orig_site))'');
    populated_orig_e360_id_pcnt := AVE(GROUP,IF(h.orig_e360_id = (TYPEOF(h.orig_e360_id))'',0,100));
    maxlength_orig_e360_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_e360_id)));
    avelength_orig_e360_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_e360_id)),h.orig_e360_id<>(typeof(h.orig_e360_id))'');
    populated_orig_teramedia_id_pcnt := AVE(GROUP,IF(h.orig_teramedia_id = (TYPEOF(h.orig_teramedia_id))'',0,100));
    maxlength_orig_teramedia_id := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_teramedia_id)));
    avelength_orig_teramedia_id := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.orig_teramedia_id)),h.orig_teramedia_id<>(typeof(h.orig_teramedia_id))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_did_type_pcnt := AVE(GROUP,IF(h.did_type = (TYPEOF(h.did_type))'',0,100));
    maxlength_did_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.did_type)));
    avelength_did_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.did_type)),h.did_type<>(typeof(h.did_type))'');
    populated_is_did_prop_pcnt := AVE(GROUP,IF(h.is_did_prop = (TYPEOF(h.is_did_prop))'',0,100));
    maxlength_is_did_prop := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.is_did_prop)));
    avelength_is_did_prop := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.is_did_prop)),h.is_did_prop<>(typeof(h.is_did_prop))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_best_dob_pcnt := AVE(GROUP,IF(h.best_dob = (TYPEOF(h.best_dob))'',0,100));
    maxlength_best_dob := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.best_dob)));
    avelength_best_dob := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.best_dob)),h.best_dob<>(typeof(h.best_dob))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_activecode_pcnt := AVE(GROUP,IF(h.activecode = (TYPEOF(h.activecode))'',0,100));
    maxlength_activecode := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.activecode)));
    avelength_activecode := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.activecode)),h.activecode<>(typeof(h.activecode))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT28.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT28.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT28.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT28.StrType)le.flag_file_id),TRIM((SALT28.StrType)le.clean_email),TRIM((SALT28.StrType)le.append_email_username),TRIM((SALT28.StrType)le.append_domain),TRIM((SALT28.StrType)le.append_domain_type),TRIM((SALT28.StrType)le.append_domain_root),TRIM((SALT28.StrType)le.append_domain_ext),TRIM((SALT28.StrType)le.append_is_tld_state),TRIM((SALT28.StrType)le.append_is_tld_generic),TRIM((SALT28.StrType)le.append_is_tld_country),TRIM((SALT28.StrType)le.append_is_valid_domain_ext),TRIM((SALT28.StrType)le.email_rec_key),TRIM((SALT28.StrType)le.email_src),TRIM((SALT28.StrType)le.rec_src_all),TRIM((SALT28.StrType)le.email_src_all),TRIM((SALT28.StrType)le.email_src_num),TRIM((SALT28.StrType)le.num_email_per_did),TRIM((SALT28.StrType)le.num_did_per_email),TRIM((SALT28.StrType)le.orig_pmghousehold_id),TRIM((SALT28.StrType)le.orig_pmgindividual_id),TRIM((SALT28.StrType)le.orig_first_name),TRIM((SALT28.StrType)le.orig_last_name),TRIM((SALT28.StrType)le.orig_address),TRIM((SALT28.StrType)le.orig_city),TRIM((SALT28.StrType)le.orig_state),TRIM((SALT28.StrType)le.orig_zip),TRIM((SALT28.StrType)le.orig_zip4),TRIM((SALT28.StrType)le.orig_email),TRIM((SALT28.StrType)le.orig_ip),TRIM((SALT28.StrType)le.orig_login_date),TRIM((SALT28.StrType)le.orig_site),TRIM((SALT28.StrType)le.orig_e360_id),TRIM((SALT28.StrType)le.orig_teramedia_id),TRIM((SALT28.StrType)le.did),TRIM((SALT28.StrType)le.did_score),TRIM((SALT28.StrType)le.did_type),TRIM((SALT28.StrType)le.is_did_prop),TRIM((SALT28.StrType)le.hhid),TRIM((SALT28.StrType)le.title),TRIM((SALT28.StrType)le.fname),TRIM((SALT28.StrType)le.mname),TRIM((SALT28.StrType)le.lname),TRIM((SALT28.StrType)le.name_suffix),TRIM((SALT28.StrType)le.name_score),TRIM((SALT28.StrType)le.prim_range),TRIM((SALT28.StrType)le.predir),TRIM((SALT28.StrType)le.prim_name),TRIM((SALT28.StrType)le.addr_suffix),TRIM((SALT28.StrType)le.postdir),TRIM((SALT28.StrType)le.unit_desig),TRIM((SALT28.StrType)le.sec_range),TRIM((SALT28.StrType)le.p_city_name),TRIM((SALT28.StrType)le.v_city_name),TRIM((SALT28.StrType)le.st),TRIM((SALT28.StrType)le.zip),TRIM((SALT28.StrType)le.zip4),TRIM((SALT28.StrType)le.cart),TRIM((SALT28.StrType)le.cr_sort_sz),TRIM((SALT28.StrType)le.lot),TRIM((SALT28.StrType)le.lot_order),TRIM((SALT28.StrType)le.dbpc),TRIM((SALT28.StrType)le.chk_digit),TRIM((SALT28.StrType)le.rec_type),TRIM((SALT28.StrType)le.county),TRIM((SALT28.StrType)le.geo_lat),TRIM((SALT28.StrType)le.geo_long),TRIM((SALT28.StrType)le.msa),TRIM((SALT28.StrType)le.geo_blk),TRIM((SALT28.StrType)le.geo_match),TRIM((SALT28.StrType)le.err_stat),TRIM((SALT28.StrType)le.append_rawaid),TRIM((SALT28.StrType)le.best_ssn),TRIM((SALT28.StrType)le.best_dob),TRIM((SALT28.StrType)le.process_date),TRIM((SALT28.StrType)le.activecode),TRIM((SALT28.StrType)le.date_first_seen),TRIM((SALT28.StrType)le.date_last_seen),TRIM((SALT28.StrType)le.date_vendor_first_reported),TRIM((SALT28.StrType)le.date_vendor_last_reported),TRIM((SALT28.StrType)le.current_rec)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,80,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'flag_file_id'}
      ,{2,'clean_email'}
      ,{3,'append_email_username'}
      ,{4,'append_domain'}
      ,{5,'append_domain_type'}
      ,{6,'append_domain_root'}
      ,{7,'append_domain_ext'}
      ,{8,'append_is_tld_state'}
      ,{9,'append_is_tld_generic'}
      ,{10,'append_is_tld_country'}
      ,{11,'append_is_valid_domain_ext'}
      ,{12,'email_rec_key'}
      ,{13,'email_src'}
      ,{14,'rec_src_all'}
      ,{15,'email_src_all'}
      ,{16,'email_src_num'}
      ,{17,'num_email_per_did'}
      ,{18,'num_did_per_email'}
      ,{19,'orig_pmghousehold_id'}
      ,{20,'orig_pmgindividual_id'}
      ,{21,'orig_first_name'}
      ,{22,'orig_last_name'}
      ,{23,'orig_address'}
      ,{24,'orig_city'}
      ,{25,'orig_state'}
      ,{26,'orig_zip'}
      ,{27,'orig_zip4'}
      ,{28,'orig_email'}
      ,{29,'orig_ip'}
      ,{30,'orig_login_date'}
      ,{31,'orig_site'}
      ,{32,'orig_e360_id'}
      ,{33,'orig_teramedia_id'}
      ,{34,'did'}
      ,{35,'did_score'}
      ,{36,'did_type'}
      ,{37,'is_did_prop'}
      ,{38,'hhid'}
      ,{39,'title'}
      ,{40,'fname'}
      ,{41,'mname'}
      ,{42,'lname'}
      ,{43,'name_suffix'}
      ,{44,'name_score'}
      ,{45,'prim_range'}
      ,{46,'predir'}
      ,{47,'prim_name'}
      ,{48,'addr_suffix'}
      ,{49,'postdir'}
      ,{50,'unit_desig'}
      ,{51,'sec_range'}
      ,{52,'p_city_name'}
      ,{53,'v_city_name'}
      ,{54,'st'}
      ,{55,'zip'}
      ,{56,'zip4'}
      ,{57,'cart'}
      ,{58,'cr_sort_sz'}
      ,{59,'lot'}
      ,{60,'lot_order'}
      ,{61,'dbpc'}
      ,{62,'chk_digit'}
      ,{63,'rec_type'}
      ,{64,'county'}
      ,{65,'geo_lat'}
      ,{66,'geo_long'}
      ,{67,'msa'}
      ,{68,'geo_blk'}
      ,{69,'geo_match'}
      ,{70,'err_stat'}
      ,{71,'append_rawaid'}
      ,{72,'best_ssn'}
      ,{73,'best_dob'}
      ,{74,'process_date'}
      ,{75,'activecode'}
      ,{76,'date_first_seen'}
      ,{77,'date_last_seen'}
      ,{78,'date_vendor_first_reported'}
      ,{79,'date_vendor_last_reported'}
      ,{80,'current_rec'}],SALT28.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT28.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT28.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_flag_file_id((SALT28.StrType)le.flag_file_id),
    Fields.InValid_clean_email((SALT28.StrType)le.clean_email),
    Fields.InValid_append_email_username((SALT28.StrType)le.append_email_username),
    Fields.InValid_append_domain((SALT28.StrType)le.append_domain),
    Fields.InValid_append_domain_type((SALT28.StrType)le.append_domain_type),
    Fields.InValid_append_domain_root((SALT28.StrType)le.append_domain_root),
    Fields.InValid_append_domain_ext((SALT28.StrType)le.append_domain_ext),
    Fields.InValid_append_is_tld_state((SALT28.StrType)le.append_is_tld_state),
    Fields.InValid_append_is_tld_generic((SALT28.StrType)le.append_is_tld_generic),
    Fields.InValid_append_is_tld_country((SALT28.StrType)le.append_is_tld_country),
    Fields.InValid_append_is_valid_domain_ext((SALT28.StrType)le.append_is_valid_domain_ext),
    Fields.InValid_email_rec_key((SALT28.StrType)le.email_rec_key),
    Fields.InValid_email_src((SALT28.StrType)le.email_src),
    Fields.InValid_rec_src_all((SALT28.StrType)le.rec_src_all),
    Fields.InValid_email_src_all((SALT28.StrType)le.email_src_all),
    Fields.InValid_email_src_num((SALT28.StrType)le.email_src_num),
    Fields.InValid_num_email_per_did((SALT28.StrType)le.num_email_per_did),
    Fields.InValid_num_did_per_email((SALT28.StrType)le.num_did_per_email),
    Fields.InValid_orig_pmghousehold_id((SALT28.StrType)le.orig_pmghousehold_id),
    Fields.InValid_orig_pmgindividual_id((SALT28.StrType)le.orig_pmgindividual_id),
    Fields.InValid_orig_first_name((SALT28.StrType)le.orig_first_name),
    Fields.InValid_orig_last_name((SALT28.StrType)le.orig_last_name),
    Fields.InValid_orig_address((SALT28.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT28.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT28.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT28.StrType)le.orig_zip),
    Fields.InValid_orig_zip4((SALT28.StrType)le.orig_zip4),
    Fields.InValid_orig_email((SALT28.StrType)le.orig_email),
    Fields.InValid_orig_ip((SALT28.StrType)le.orig_ip),
    Fields.InValid_orig_login_date((SALT28.StrType)le.orig_login_date),
    Fields.InValid_orig_site((SALT28.StrType)le.orig_site),
    Fields.InValid_orig_e360_id((SALT28.StrType)le.orig_e360_id),
    Fields.InValid_orig_teramedia_id((SALT28.StrType)le.orig_teramedia_id),
    Fields.InValid_did((SALT28.StrType)le.did),
    Fields.InValid_did_score((SALT28.StrType)le.did_score),
    Fields.InValid_did_type((SALT28.StrType)le.did_type),
    Fields.InValid_is_did_prop((SALT28.StrType)le.is_did_prop),
    Fields.InValid_hhid((SALT28.StrType)le.hhid),
    Fields.InValid_title((SALT28.StrType)le.title),
    Fields.InValid_fname((SALT28.StrType)le.fname),
    Fields.InValid_mname((SALT28.StrType)le.mname),
    Fields.InValid_lname((SALT28.StrType)le.lname),
    Fields.InValid_name_suffix((SALT28.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT28.StrType)le.name_score),
    Fields.InValid_prim_range((SALT28.StrType)le.prim_range),
    Fields.InValid_predir((SALT28.StrType)le.predir),
    Fields.InValid_prim_name((SALT28.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT28.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT28.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT28.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT28.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT28.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT28.StrType)le.v_city_name),
    Fields.InValid_st((SALT28.StrType)le.st),
    Fields.InValid_zip((SALT28.StrType)le.zip),
    Fields.InValid_zip4((SALT28.StrType)le.zip4),
    Fields.InValid_cart((SALT28.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT28.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT28.StrType)le.lot),
    Fields.InValid_lot_order((SALT28.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT28.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT28.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT28.StrType)le.rec_type),
    Fields.InValid_county((SALT28.StrType)le.county),
    Fields.InValid_geo_lat((SALT28.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT28.StrType)le.geo_long),
    Fields.InValid_msa((SALT28.StrType)le.msa),
    Fields.InValid_geo_blk((SALT28.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT28.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT28.StrType)le.err_stat),
    Fields.InValid_append_rawaid((SALT28.StrType)le.append_rawaid),
    Fields.InValid_best_ssn((SALT28.StrType)le.best_ssn),
    Fields.InValid_best_dob((SALT28.StrType)le.best_dob),
    Fields.InValid_process_date((SALT28.StrType)le.process_date),
    Fields.InValid_activecode((SALT28.StrType)le.activecode),
    Fields.InValid_date_first_seen((SALT28.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT28.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT28.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT28.StrType)le.date_vendor_last_reported),
    Fields.InValid_current_rec((SALT28.StrType)le.current_rec),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,80,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := record
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_flag_file_id(TotalErrors.ErrorNum),Fields.InValidMessage_clean_email(TotalErrors.ErrorNum),Fields.InValidMessage_append_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_root(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_state(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_generic(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_country(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_valid_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_email_rec_key(TotalErrors.ErrorNum),Fields.InValidMessage_email_src(TotalErrors.ErrorNum),Fields.InValidMessage_rec_src_all(TotalErrors.ErrorNum),Fields.InValidMessage_email_src_all(TotalErrors.ErrorNum),Fields.InValidMessage_email_src_num(TotalErrors.ErrorNum),Fields.InValidMessage_num_email_per_did(TotalErrors.ErrorNum),Fields.InValidMessage_num_did_per_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pmghousehold_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pmgindividual_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_site(TotalErrors.ErrorNum),Fields.InValidMessage_orig_e360_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_teramedia_id(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_did_type(TotalErrors.ErrorNum),Fields.InValidMessage_is_did_prop(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_best_dob(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_activecode(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
END;
