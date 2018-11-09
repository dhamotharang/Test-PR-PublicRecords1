IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_DNB_FEIN) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_tmsid_cnt := COUNT(GROUP,h.tmsid <> (TYPEOF(h.tmsid))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_orig_company_name_cnt := COUNT(GROUP,h.orig_company_name <> (TYPEOF(h.orig_company_name))'');
    populated_orig_company_name_pcnt := AVE(GROUP,IF(h.orig_company_name = (TYPEOF(h.orig_company_name))'',0,100));
    maxlength_orig_company_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_company_name)));
    avelength_orig_company_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_company_name)),h.orig_company_name<>(typeof(h.orig_company_name))'');
    populated_clean_cname_cnt := COUNT(GROUP,h.clean_cname <> (TYPEOF(h.clean_cname))'');
    populated_clean_cname_pcnt := AVE(GROUP,IF(h.clean_cname = (TYPEOF(h.clean_cname))'',0,100));
    maxlength_clean_cname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cname)));
    avelength_clean_cname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cname)),h.clean_cname<>(typeof(h.clean_cname))'');
    populated_orig_address1_cnt := COUNT(GROUP,h.orig_address1 <> (TYPEOF(h.orig_address1))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_cnt := COUNT(GROUP,h.orig_address2 <> (TYPEOF(h.orig_address2))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip5_cnt := COUNT(GROUP,h.orig_zip5 <> (TYPEOF(h.orig_zip5))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_county_cnt := COUNT(GROUP,h.orig_county <> (TYPEOF(h.orig_county))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_fein_cnt := COUNT(GROUP,h.fein <> (TYPEOF(h.fein))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_source_duns_number_cnt := COUNT(GROUP,h.source_duns_number <> (TYPEOF(h.source_duns_number))'');
    populated_source_duns_number_pcnt := AVE(GROUP,IF(h.source_duns_number = (TYPEOF(h.source_duns_number))'',0,100));
    maxlength_source_duns_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_duns_number)));
    avelength_source_duns_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_duns_number)),h.source_duns_number<>(typeof(h.source_duns_number))'');
    populated_case_duns_number_cnt := COUNT(GROUP,h.case_duns_number <> (TYPEOF(h.case_duns_number))'');
    populated_case_duns_number_pcnt := AVE(GROUP,IF(h.case_duns_number = (TYPEOF(h.case_duns_number))'',0,100));
    maxlength_case_duns_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.case_duns_number)));
    avelength_case_duns_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.case_duns_number)),h.case_duns_number<>(typeof(h.case_duns_number))'');
    populated_duns_orig_source_cnt := COUNT(GROUP,h.duns_orig_source <> (TYPEOF(h.duns_orig_source))'');
    populated_duns_orig_source_pcnt := AVE(GROUP,IF(h.duns_orig_source = (TYPEOF(h.duns_orig_source))'',0,100));
    maxlength_duns_orig_source := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.duns_orig_source)));
    avelength_duns_orig_source := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.duns_orig_source)),h.duns_orig_source<>(typeof(h.duns_orig_source))'');
    populated_confidence_code_cnt := COUNT(GROUP,h.confidence_code <> (TYPEOF(h.confidence_code))'');
    populated_confidence_code_pcnt := AVE(GROUP,IF(h.confidence_code = (TYPEOF(h.confidence_code))'',0,100));
    maxlength_confidence_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.confidence_code)));
    avelength_confidence_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.confidence_code)),h.confidence_code<>(typeof(h.confidence_code))'');
    populated_indirect_direct_source_ind_cnt := COUNT(GROUP,h.indirect_direct_source_ind <> (TYPEOF(h.indirect_direct_source_ind))'');
    populated_indirect_direct_source_ind_pcnt := AVE(GROUP,IF(h.indirect_direct_source_ind = (TYPEOF(h.indirect_direct_source_ind))'',0,100));
    maxlength_indirect_direct_source_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.indirect_direct_source_ind)));
    avelength_indirect_direct_source_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.indirect_direct_source_ind)),h.indirect_direct_source_ind<>(typeof(h.indirect_direct_source_ind))'');
    populated_best_fein_indicator_cnt := COUNT(GROUP,h.best_fein_indicator <> (TYPEOF(h.best_fein_indicator))'');
    populated_best_fein_indicator_pcnt := AVE(GROUP,IF(h.best_fein_indicator = (TYPEOF(h.best_fein_indicator))'',0,100));
    maxlength_best_fein_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_fein_indicator)));
    avelength_best_fein_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_fein_indicator)),h.best_fein_indicator<>(typeof(h.best_fein_indicator))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_trade_style_cnt := COUNT(GROUP,h.trade_style <> (TYPEOF(h.trade_style))'');
    populated_trade_style_pcnt := AVE(GROUP,IF(h.trade_style = (TYPEOF(h.trade_style))'',0,100));
    maxlength_trade_style := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.trade_style)));
    avelength_trade_style := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.trade_style)),h.trade_style<>(typeof(h.trade_style))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_telephone_number_cnt := COUNT(GROUP,h.telephone_number <> (TYPEOF(h.telephone_number))'');
    populated_telephone_number_pcnt := AVE(GROUP,IF(h.telephone_number = (TYPEOF(h.telephone_number))'',0,100));
    maxlength_telephone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.telephone_number)));
    avelength_telephone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.telephone_number)),h.telephone_number<>(typeof(h.telephone_number))'');
    populated_top_contact_name_cnt := COUNT(GROUP,h.top_contact_name <> (TYPEOF(h.top_contact_name))'');
    populated_top_contact_name_pcnt := AVE(GROUP,IF(h.top_contact_name = (TYPEOF(h.top_contact_name))'',0,100));
    maxlength_top_contact_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.top_contact_name)));
    avelength_top_contact_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.top_contact_name)),h.top_contact_name<>(typeof(h.top_contact_name))'');
    populated_top_contact_title_cnt := COUNT(GROUP,h.top_contact_title <> (TYPEOF(h.top_contact_title))'');
    populated_top_contact_title_pcnt := AVE(GROUP,IF(h.top_contact_title = (TYPEOF(h.top_contact_title))'',0,100));
    maxlength_top_contact_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.top_contact_title)));
    avelength_top_contact_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.top_contact_title)),h.top_contact_title<>(typeof(h.top_contact_title))'');
    populated_hdqtr_parent_duns_number_cnt := COUNT(GROUP,h.hdqtr_parent_duns_number <> (TYPEOF(h.hdqtr_parent_duns_number))'');
    populated_hdqtr_parent_duns_number_pcnt := AVE(GROUP,IF(h.hdqtr_parent_duns_number = (TYPEOF(h.hdqtr_parent_duns_number))'',0,100));
    maxlength_hdqtr_parent_duns_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.hdqtr_parent_duns_number)));
    avelength_hdqtr_parent_duns_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.hdqtr_parent_duns_number)),h.hdqtr_parent_duns_number<>(typeof(h.hdqtr_parent_duns_number))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_orig_company_name_pcnt *   0.00 / 100 + T.Populated_clean_cname_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_source_duns_number_pcnt *   0.00 / 100 + T.Populated_case_duns_number_pcnt *   0.00 / 100 + T.Populated_duns_orig_source_pcnt *   0.00 / 100 + T.Populated_confidence_code_pcnt *   0.00 / 100 + T.Populated_indirect_direct_source_ind_pcnt *   0.00 / 100 + T.Populated_best_fein_indicator_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_trade_style_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_telephone_number_pcnt *   0.00 / 100 + T.Populated_top_contact_name_pcnt *   0.00 / 100 + T.Populated_top_contact_title_pcnt *   0.00 / 100 + T.Populated_hdqtr_parent_duns_number_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tmsid','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','orig_company_name','clean_cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','fein','source_duns_number','case_duns_number','duns_orig_source','confidence_code','indirect_direct_source_ind','best_fein_indicator','company_name','trade_style','sic_code','telephone_number','top_contact_name','top_contact_title','hdqtr_parent_duns_number','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tmsid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_orig_company_name_pcnt,le.populated_clean_cname_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_county_pcnt,le.populated_fein_pcnt,le.populated_source_duns_number_pcnt,le.populated_case_duns_number_pcnt,le.populated_duns_orig_source_pcnt,le.populated_confidence_code_pcnt,le.populated_indirect_direct_source_ind_pcnt,le.populated_best_fein_indicator_pcnt,le.populated_company_name_pcnt,le.populated_trade_style_pcnt,le.populated_sic_code_pcnt,le.populated_telephone_number_pcnt,le.populated_top_contact_name_pcnt,le.populated_top_contact_title_pcnt,le.populated_hdqtr_parent_duns_number_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_source_rec_id_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tmsid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_orig_company_name,le.maxlength_clean_cname,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip5,le.maxlength_orig_zip4,le.maxlength_orig_county,le.maxlength_fein,le.maxlength_source_duns_number,le.maxlength_case_duns_number,le.maxlength_duns_orig_source,le.maxlength_confidence_code,le.maxlength_indirect_direct_source_ind,le.maxlength_best_fein_indicator,le.maxlength_company_name,le.maxlength_trade_style,le.maxlength_sic_code,le.maxlength_telephone_number,le.maxlength_top_contact_name,le.maxlength_top_contact_title,le.maxlength_hdqtr_parent_duns_number,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_source_rec_id,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_tmsid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_orig_company_name,le.avelength_clean_cname,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip5,le.avelength_orig_zip4,le.avelength_orig_county,le.avelength_fein,le.avelength_source_duns_number,le.avelength_case_duns_number,le.avelength_duns_orig_source,le.avelength_confidence_code,le.avelength_indirect_direct_source_ind,le.avelength_best_fein_indicator,le.avelength_company_name,le.avelength_trade_style,le.avelength_sic_code,le.avelength_telephone_number,le.avelength_top_contact_name,le.avelength_top_contact_title,le.avelength_hdqtr_parent_duns_number,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_source_rec_id,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 87, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.tmsid),TRIM((SALT38.StrType)le.bdid),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.date_vendor_first_reported),TRIM((SALT38.StrType)le.date_vendor_last_reported),TRIM((SALT38.StrType)le.orig_company_name),TRIM((SALT38.StrType)le.clean_cname),TRIM((SALT38.StrType)le.orig_address1),TRIM((SALT38.StrType)le.orig_address2),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip5),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.fein),TRIM((SALT38.StrType)le.source_duns_number),TRIM((SALT38.StrType)le.case_duns_number),TRIM((SALT38.StrType)le.duns_orig_source),TRIM((SALT38.StrType)le.confidence_code),TRIM((SALT38.StrType)le.indirect_direct_source_ind),TRIM((SALT38.StrType)le.best_fein_indicator),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.trade_style),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.telephone_number),TRIM((SALT38.StrType)le.top_contact_name),TRIM((SALT38.StrType)le.top_contact_title),TRIM((SALT38.StrType)le.hdqtr_parent_duns_number),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,87,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 87);
  SELF.FldNo2 := 1 + (C % 87);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.tmsid),TRIM((SALT38.StrType)le.bdid),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.date_vendor_first_reported),TRIM((SALT38.StrType)le.date_vendor_last_reported),TRIM((SALT38.StrType)le.orig_company_name),TRIM((SALT38.StrType)le.clean_cname),TRIM((SALT38.StrType)le.orig_address1),TRIM((SALT38.StrType)le.orig_address2),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip5),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.fein),TRIM((SALT38.StrType)le.source_duns_number),TRIM((SALT38.StrType)le.case_duns_number),TRIM((SALT38.StrType)le.duns_orig_source),TRIM((SALT38.StrType)le.confidence_code),TRIM((SALT38.StrType)le.indirect_direct_source_ind),TRIM((SALT38.StrType)le.best_fein_indicator),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.trade_style),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.telephone_number),TRIM((SALT38.StrType)le.top_contact_name),TRIM((SALT38.StrType)le.top_contact_title),TRIM((SALT38.StrType)le.hdqtr_parent_duns_number),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.tmsid),TRIM((SALT38.StrType)le.bdid),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.date_vendor_first_reported),TRIM((SALT38.StrType)le.date_vendor_last_reported),TRIM((SALT38.StrType)le.orig_company_name),TRIM((SALT38.StrType)le.clean_cname),TRIM((SALT38.StrType)le.orig_address1),TRIM((SALT38.StrType)le.orig_address2),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip5),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.fein),TRIM((SALT38.StrType)le.source_duns_number),TRIM((SALT38.StrType)le.case_duns_number),TRIM((SALT38.StrType)le.duns_orig_source),TRIM((SALT38.StrType)le.confidence_code),TRIM((SALT38.StrType)le.indirect_direct_source_ind),TRIM((SALT38.StrType)le.best_fein_indicator),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.trade_style),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.telephone_number),TRIM((SALT38.StrType)le.top_contact_name),TRIM((SALT38.StrType)le.top_contact_title),TRIM((SALT38.StrType)le.hdqtr_parent_duns_number),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),87*87,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tmsid'}
      ,{2,'bdid'}
      ,{3,'date_first_seen'}
      ,{4,'date_last_seen'}
      ,{5,'date_vendor_first_reported'}
      ,{6,'date_vendor_last_reported'}
      ,{7,'orig_company_name'}
      ,{8,'clean_cname'}
      ,{9,'orig_address1'}
      ,{10,'orig_address2'}
      ,{11,'orig_city'}
      ,{12,'orig_state'}
      ,{13,'orig_zip5'}
      ,{14,'orig_zip4'}
      ,{15,'orig_county'}
      ,{16,'fein'}
      ,{17,'source_duns_number'}
      ,{18,'case_duns_number'}
      ,{19,'duns_orig_source'}
      ,{20,'confidence_code'}
      ,{21,'indirect_direct_source_ind'}
      ,{22,'best_fein_indicator'}
      ,{23,'company_name'}
      ,{24,'trade_style'}
      ,{25,'sic_code'}
      ,{26,'telephone_number'}
      ,{27,'top_contact_name'}
      ,{28,'top_contact_title'}
      ,{29,'hdqtr_parent_duns_number'}
      ,{30,'title'}
      ,{31,'fname'}
      ,{32,'mname'}
      ,{33,'lname'}
      ,{34,'name_suffix'}
      ,{35,'name_score'}
      ,{36,'prim_range'}
      ,{37,'predir'}
      ,{38,'prim_name'}
      ,{39,'addr_suffix'}
      ,{40,'postdir'}
      ,{41,'unit_desig'}
      ,{42,'sec_range'}
      ,{43,'p_city_name'}
      ,{44,'v_city_name'}
      ,{45,'st'}
      ,{46,'zip'}
      ,{47,'zip4'}
      ,{48,'cart'}
      ,{49,'cr_sort_sz'}
      ,{50,'lot'}
      ,{51,'lot_order'}
      ,{52,'dbpc'}
      ,{53,'chk_digit'}
      ,{54,'rec_type'}
      ,{55,'county'}
      ,{56,'geo_lat'}
      ,{57,'geo_long'}
      ,{58,'msa'}
      ,{59,'geo_blk'}
      ,{60,'geo_match'}
      ,{61,'err_stat'}
      ,{62,'raw_aid'}
      ,{63,'ace_aid'}
      ,{64,'prep_addr_line1'}
      ,{65,'prep_addr_line_last'}
      ,{66,'source_rec_id'}
      ,{67,'dotid'}
      ,{68,'dotscore'}
      ,{69,'dotweight'}
      ,{70,'empid'}
      ,{71,'empscore'}
      ,{72,'empweight'}
      ,{73,'powid'}
      ,{74,'powscore'}
      ,{75,'powweight'}
      ,{76,'proxid'}
      ,{77,'proxscore'}
      ,{78,'proxweight'}
      ,{79,'seleid'}
      ,{80,'selescore'}
      ,{81,'seleweight'}
      ,{82,'orgid'}
      ,{83,'orgscore'}
      ,{84,'orgweight'}
      ,{85,'ultid'}
      ,{86,'ultscore'}
      ,{87,'ultweight'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_tmsid((SALT38.StrType)le.tmsid),
    Base_Fields.InValid_bdid((SALT38.StrType)le.bdid),
    Base_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen),
    Base_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen),
    Base_Fields.InValid_date_vendor_first_reported((SALT38.StrType)le.date_vendor_first_reported),
    Base_Fields.InValid_date_vendor_last_reported((SALT38.StrType)le.date_vendor_last_reported),
    Base_Fields.InValid_orig_company_name((SALT38.StrType)le.orig_company_name),
    Base_Fields.InValid_clean_cname((SALT38.StrType)le.clean_cname),
    Base_Fields.InValid_orig_address1((SALT38.StrType)le.orig_address1),
    Base_Fields.InValid_orig_address2((SALT38.StrType)le.orig_address2),
    Base_Fields.InValid_orig_city((SALT38.StrType)le.orig_city),
    Base_Fields.InValid_orig_state((SALT38.StrType)le.orig_state),
    Base_Fields.InValid_orig_zip5((SALT38.StrType)le.orig_zip5),
    Base_Fields.InValid_orig_zip4((SALT38.StrType)le.orig_zip4),
    Base_Fields.InValid_orig_county((SALT38.StrType)le.orig_county),
    Base_Fields.InValid_fein((SALT38.StrType)le.fein),
    Base_Fields.InValid_source_duns_number((SALT38.StrType)le.source_duns_number),
    Base_Fields.InValid_case_duns_number((SALT38.StrType)le.case_duns_number),
    Base_Fields.InValid_duns_orig_source((SALT38.StrType)le.duns_orig_source),
    Base_Fields.InValid_confidence_code((SALT38.StrType)le.confidence_code),
    Base_Fields.InValid_indirect_direct_source_ind((SALT38.StrType)le.indirect_direct_source_ind),
    Base_Fields.InValid_best_fein_indicator((SALT38.StrType)le.best_fein_indicator),
    Base_Fields.InValid_company_name((SALT38.StrType)le.company_name),
    Base_Fields.InValid_trade_style((SALT38.StrType)le.trade_style),
    Base_Fields.InValid_sic_code((SALT38.StrType)le.sic_code),
    Base_Fields.InValid_telephone_number((SALT38.StrType)le.telephone_number),
    Base_Fields.InValid_top_contact_name((SALT38.StrType)le.top_contact_name),
    Base_Fields.InValid_top_contact_title((SALT38.StrType)le.top_contact_title),
    Base_Fields.InValid_hdqtr_parent_duns_number((SALT38.StrType)le.hdqtr_parent_duns_number),
    Base_Fields.InValid_title((SALT38.StrType)le.title),
    Base_Fields.InValid_fname((SALT38.StrType)le.fname),
    Base_Fields.InValid_mname((SALT38.StrType)le.mname),
    Base_Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.top_contact_name),
    Base_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Base_Fields.InValid_name_score((SALT38.StrType)le.name_score),
    Base_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT38.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT38.StrType)le.st),
    Base_Fields.InValid_zip((SALT38.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT38.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT38.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT38.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Base_Fields.InValid_county((SALT38.StrType)le.county),
    Base_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT38.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid),
    Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last),
    Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id),
    Base_Fields.InValid_dotid((SALT38.StrType)le.dotid),
    Base_Fields.InValid_dotscore((SALT38.StrType)le.dotscore),
    Base_Fields.InValid_dotweight((SALT38.StrType)le.dotweight),
    Base_Fields.InValid_empid((SALT38.StrType)le.empid),
    Base_Fields.InValid_empscore((SALT38.StrType)le.empscore),
    Base_Fields.InValid_empweight((SALT38.StrType)le.empweight),
    Base_Fields.InValid_powid((SALT38.StrType)le.powid),
    Base_Fields.InValid_powscore((SALT38.StrType)le.powscore),
    Base_Fields.InValid_powweight((SALT38.StrType)le.powweight),
    Base_Fields.InValid_proxid((SALT38.StrType)le.proxid),
    Base_Fields.InValid_proxscore((SALT38.StrType)le.proxscore),
    Base_Fields.InValid_proxweight((SALT38.StrType)le.proxweight),
    Base_Fields.InValid_seleid((SALT38.StrType)le.seleid),
    Base_Fields.InValid_selescore((SALT38.StrType)le.selescore),
    Base_Fields.InValid_seleweight((SALT38.StrType)le.seleweight),
    Base_Fields.InValid_orgid((SALT38.StrType)le.orgid),
    Base_Fields.InValid_orgscore((SALT38.StrType)le.orgscore),
    Base_Fields.InValid_orgweight((SALT38.StrType)le.orgweight),
    Base_Fields.InValid_ultid((SALT38.StrType)le.ultid),
    Base_Fields.InValid_ultscore((SALT38.StrType)le.ultscore),
    Base_Fields.InValid_ultweight((SALT38.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,87,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_tmsid','invalid_bdid','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','invalid_mandatory','invalid_orig_state','invalid_orig_zip5','Unknown','Unknown','invalid_fein','invalid_source_duns_number','invalid_case_duns_number','invalid_mandatory','invalid_confidence_code','invalid_indirect_direct_source_ind','invalid_best_fein_indicator','invalid_mandatory','Unknown','invalid_sic_code','invalid_telephone_number','invalid_mandatory','Unknown','invalid_hdqtr_parent_duns_number','Unknown','Unknown','Unknown','invalid_lname','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_source_rec_id','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_cname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fein(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_duns_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_case_duns_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_duns_orig_source(TotalErrors.ErrorNum),Base_Fields.InValidMessage_confidence_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_indirect_direct_source_ind(TotalErrors.ErrorNum),Base_Fields.InValidMessage_best_fein_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_trade_style(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_telephone_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_top_contact_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_top_contact_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hdqtr_parent_duns_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DNB_FEIN, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
