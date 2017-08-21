IMPORT ut,SALT33;
EXPORT LinkID_hygiene(dataset(LinkID_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_timestamp_pcnt := AVE(GROUP,IF(h.timestamp = (TYPEOF(h.timestamp))'',0,100));
    maxlength_timestamp := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.timestamp)));
    avelength_timestamp := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.timestamp)),h.timestamp<>(typeof(h.timestamp))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_datawarehouse_first_reported_pcnt := AVE(GROUP,IF(h.dt_datawarehouse_first_reported = (TYPEOF(h.dt_datawarehouse_first_reported))'',0,100));
    maxlength_dt_datawarehouse_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_datawarehouse_first_reported)));
    avelength_dt_datawarehouse_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_datawarehouse_first_reported)),h.dt_datawarehouse_first_reported<>(typeof(h.dt_datawarehouse_first_reported))'');
    populated_dt_datawarehouse_last_reported_pcnt := AVE(GROUP,IF(h.dt_datawarehouse_last_reported = (TYPEOF(h.dt_datawarehouse_last_reported))'',0,100));
    maxlength_dt_datawarehouse_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_datawarehouse_last_reported)));
    avelength_dt_datawarehouse_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_datawarehouse_last_reported)),h.dt_datawarehouse_last_reported<>(typeof(h.dt_datawarehouse_last_reported))'');
    populated_sbfe_contributor_number_pcnt := AVE(GROUP,IF(h.sbfe_contributor_number = (TYPEOF(h.sbfe_contributor_number))'',0,100));
    maxlength_sbfe_contributor_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sbfe_contributor_number)));
    avelength_sbfe_contributor_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sbfe_contributor_number)),h.sbfe_contributor_number<>(typeof(h.sbfe_contributor_number))'');
    populated_contract_account_number_pcnt := AVE(GROUP,IF(h.contract_account_number = (TYPEOF(h.contract_account_number))'',0,100));
    maxlength_contract_account_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.contract_account_number)));
    avelength_contract_account_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.contract_account_number)),h.contract_account_number<>(typeof(h.contract_account_number))'');
    populated_account_type_reported_pcnt := AVE(GROUP,IF(h.account_type_reported = (TYPEOF(h.account_type_reported))'',0,100));
    maxlength_account_type_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_type_reported)));
    avelength_account_type_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_type_reported)),h.account_type_reported<>(typeof(h.account_type_reported))'');
    populated_extracted_date_pcnt := AVE(GROUP,IF(h.extracted_date = (TYPEOF(h.extracted_date))'',0,100));
    maxlength_extracted_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.extracted_date)));
    avelength_extracted_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.extracted_date)),h.extracted_date<>(typeof(h.extracted_date))'');
    populated_cycle_end_date_pcnt := AVE(GROUP,IF(h.cycle_end_date = (TYPEOF(h.cycle_end_date))'',0,100));
    maxlength_cycle_end_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cycle_end_date)));
    avelength_cycle_end_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cycle_end_date)),h.cycle_end_date<>(typeof(h.cycle_end_date))'');
    populated_account_holder_business_name_pcnt := AVE(GROUP,IF(h.account_holder_business_name = (TYPEOF(h.account_holder_business_name))'',0,100));
    maxlength_account_holder_business_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_holder_business_name)));
    avelength_account_holder_business_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_holder_business_name)),h.account_holder_business_name<>(typeof(h.account_holder_business_name))'');
    populated_clean_account_holder_business_name_pcnt := AVE(GROUP,IF(h.clean_account_holder_business_name = (TYPEOF(h.clean_account_holder_business_name))'',0,100));
    maxlength_clean_account_holder_business_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_account_holder_business_name)));
    avelength_clean_account_holder_business_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_account_holder_business_name)),h.clean_account_holder_business_name<>(typeof(h.clean_account_holder_business_name))'');
    populated_dba_pcnt := AVE(GROUP,IF(h.dba = (TYPEOF(h.dba))'',0,100));
    maxlength_dba := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dba)));
    avelength_dba := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dba)),h.dba<>(typeof(h.dba))'');
    populated_clean_dba_pcnt := AVE(GROUP,IF(h.clean_dba = (TYPEOF(h.clean_dba))'',0,100));
    maxlength_clean_dba := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_dba)));
    avelength_clean_dba := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_dba)),h.clean_dba<>(typeof(h.clean_dba))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_clean_business_name_pcnt := AVE(GROUP,IF(h.clean_business_name = (TYPEOF(h.clean_business_name))'',0,100));
    maxlength_clean_business_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_business_name)));
    avelength_clean_business_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_business_name)),h.clean_business_name<>(typeof(h.clean_business_name))'');
    populated_company_website_pcnt := AVE(GROUP,IF(h.company_website = (TYPEOF(h.company_website))'',0,100));
    maxlength_company_website := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.company_website)));
    avelength_company_website := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.company_website)),h.company_website<>(typeof(h.company_website))'');
    populated_original_fname_pcnt := AVE(GROUP,IF(h.original_fname = (TYPEOF(h.original_fname))'',0,100));
    maxlength_original_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_fname)));
    avelength_original_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_fname)),h.original_fname<>(typeof(h.original_fname))'');
    populated_original_mname_pcnt := AVE(GROUP,IF(h.original_mname = (TYPEOF(h.original_mname))'',0,100));
    maxlength_original_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_mname)));
    avelength_original_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_mname)),h.original_mname<>(typeof(h.original_mname))'');
    populated_original_lname_pcnt := AVE(GROUP,IF(h.original_lname = (TYPEOF(h.original_lname))'',0,100));
    maxlength_original_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_lname)));
    avelength_original_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_lname)),h.original_lname<>(typeof(h.original_lname))'');
    populated_original_suffix_pcnt := AVE(GROUP,IF(h.original_suffix = (TYPEOF(h.original_suffix))'',0,100));
    maxlength_original_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_suffix)));
    avelength_original_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_suffix)),h.original_suffix<>(typeof(h.original_suffix))'');
    populated_e_mail_address_pcnt := AVE(GROUP,IF(h.e_mail_address = (TYPEOF(h.e_mail_address))'',0,100));
    maxlength_e_mail_address := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.e_mail_address)));
    avelength_e_mail_address := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.e_mail_address)),h.e_mail_address<>(typeof(h.e_mail_address))'');
    populated_guarantor_owner_indicator_pcnt := AVE(GROUP,IF(h.guarantor_owner_indicator = (TYPEOF(h.guarantor_owner_indicator))'',0,100));
    maxlength_guarantor_owner_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantor_owner_indicator)));
    avelength_guarantor_owner_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantor_owner_indicator)),h.guarantor_owner_indicator<>(typeof(h.guarantor_owner_indicator))'');
    populated_relationship_to_business_indicator_pcnt := AVE(GROUP,IF(h.relationship_to_business_indicator = (TYPEOF(h.relationship_to_business_indicator))'',0,100));
    maxlength_relationship_to_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.relationship_to_business_indicator)));
    avelength_relationship_to_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.relationship_to_business_indicator)),h.relationship_to_business_indicator<>(typeof(h.relationship_to_business_indicator))'');
    populated_business_title_pcnt := AVE(GROUP,IF(h.business_title = (TYPEOF(h.business_title))'',0,100));
    maxlength_business_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_title)));
    avelength_business_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_title)),h.business_title<>(typeof(h.business_title))'');
    populated_clean_title_pcnt := AVE(GROUP,IF(h.clean_title = (TYPEOF(h.clean_title))'',0,100));
    maxlength_clean_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_title)));
    avelength_clean_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_title)),h.clean_title<>(typeof(h.clean_title))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
    populated_clean_suffix_pcnt := AVE(GROUP,IF(h.clean_suffix = (TYPEOF(h.clean_suffix))'',0,100));
    maxlength_clean_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_suffix)));
    avelength_clean_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_suffix)),h.clean_suffix<>(typeof(h.clean_suffix))'');
    populated_original_address_line_1_pcnt := AVE(GROUP,IF(h.original_address_line_1 = (TYPEOF(h.original_address_line_1))'',0,100));
    maxlength_original_address_line_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_address_line_1)));
    avelength_original_address_line_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_address_line_1)),h.original_address_line_1<>(typeof(h.original_address_line_1))'');
    populated_original_address_line_2_pcnt := AVE(GROUP,IF(h.original_address_line_2 = (TYPEOF(h.original_address_line_2))'',0,100));
    maxlength_original_address_line_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_address_line_2)));
    avelength_original_address_line_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_address_line_2)),h.original_address_line_2<>(typeof(h.original_address_line_2))'');
    populated_original_city_pcnt := AVE(GROUP,IF(h.original_city = (TYPEOF(h.original_city))'',0,100));
    maxlength_original_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_city)));
    avelength_original_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_city)),h.original_city<>(typeof(h.original_city))'');
    populated_original_state_pcnt := AVE(GROUP,IF(h.original_state = (TYPEOF(h.original_state))'',0,100));
    maxlength_original_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_state)));
    avelength_original_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_state)),h.original_state<>(typeof(h.original_state))'');
    populated_original_zip_code_or_ca_postal_code_pcnt := AVE(GROUP,IF(h.original_zip_code_or_ca_postal_code = (TYPEOF(h.original_zip_code_or_ca_postal_code))'',0,100));
    maxlength_original_zip_code_or_ca_postal_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_zip_code_or_ca_postal_code)));
    avelength_original_zip_code_or_ca_postal_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_zip_code_or_ca_postal_code)),h.original_zip_code_or_ca_postal_code<>(typeof(h.original_zip_code_or_ca_postal_code))'');
    populated_original_postal_code_pcnt := AVE(GROUP,IF(h.original_postal_code = (TYPEOF(h.original_postal_code))'',0,100));
    maxlength_original_postal_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_postal_code)));
    avelength_original_postal_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_postal_code)),h.original_postal_code<>(typeof(h.original_postal_code))'');
    populated_original_country_code_pcnt := AVE(GROUP,IF(h.original_country_code = (TYPEOF(h.original_country_code))'',0,100));
    maxlength_original_country_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_country_code)));
    avelength_original_country_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_country_code)),h.original_country_code<>(typeof(h.original_country_code))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_original_area_code_pcnt := AVE(GROUP,IF(h.original_area_code = (TYPEOF(h.original_area_code))'',0,100));
    maxlength_original_area_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_area_code)));
    avelength_original_area_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_area_code)),h.original_area_code<>(typeof(h.original_area_code))'');
    populated_original_phone_number_pcnt := AVE(GROUP,IF(h.original_phone_number = (TYPEOF(h.original_phone_number))'',0,100));
    maxlength_original_phone_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_phone_number)));
    avelength_original_phone_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_phone_number)),h.original_phone_number<>(typeof(h.original_phone_number))'');
    populated_phone_extension_pcnt := AVE(GROUP,IF(h.phone_extension = (TYPEOF(h.phone_extension))'',0,100));
    maxlength_phone_extension := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_extension)));
    avelength_phone_extension := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_extension)),h.phone_extension<>(typeof(h.phone_extension))'');
    populated_primary_phone_indicator_pcnt := AVE(GROUP,IF(h.primary_phone_indicator = (TYPEOF(h.primary_phone_indicator))'',0,100));
    maxlength_primary_phone_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.primary_phone_indicator)));
    avelength_primary_phone_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.primary_phone_indicator)),h.primary_phone_indicator<>(typeof(h.primary_phone_indicator))'');
    populated_published_unlisted_indicator_pcnt := AVE(GROUP,IF(h.published_unlisted_indicator = (TYPEOF(h.published_unlisted_indicator))'',0,100));
    maxlength_published_unlisted_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.published_unlisted_indicator)));
    avelength_published_unlisted_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.published_unlisted_indicator)),h.published_unlisted_indicator<>(typeof(h.published_unlisted_indicator))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_federal_taxid_ssn_pcnt := AVE(GROUP,IF(h.federal_taxid_ssn = (TYPEOF(h.federal_taxid_ssn))'',0,100));
    maxlength_federal_taxid_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.federal_taxid_ssn)));
    avelength_federal_taxid_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.federal_taxid_ssn)),h.federal_taxid_ssn<>(typeof(h.federal_taxid_ssn))'');
    populated_federal_taxid_ssn_identifier_pcnt := AVE(GROUP,IF(h.federal_taxid_ssn_identifier = (TYPEOF(h.federal_taxid_ssn_identifier))'',0,100));
    maxlength_federal_taxid_ssn_identifier := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.federal_taxid_ssn_identifier)));
    avelength_federal_taxid_ssn_identifier := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.federal_taxid_ssn_identifier)),h.federal_taxid_ssn_identifier<>(typeof(h.federal_taxid_ssn_identifier))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_sbfe_id_pcnt := AVE(GROUP,IF(h.sbfe_id = (TYPEOF(h.sbfe_id))'',0,100));
    maxlength_sbfe_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sbfe_id)));
    avelength_sbfe_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sbfe_id)),h.sbfe_id<>(typeof(h.sbfe_id))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_active_pcnt := AVE(GROUP,IF(h.active = (TYPEOF(h.active))'',0,100));
    maxlength_active := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.active)));
    avelength_active := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.active)),h.active<>(typeof(h.active))'');
    populated_legal_business_structure_pcnt := AVE(GROUP,IF(h.legal_business_structure = (TYPEOF(h.legal_business_structure))'',0,100));
    maxlength_legal_business_structure := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_business_structure)));
    avelength_legal_business_structure := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_business_structure)),h.legal_business_structure<>(typeof(h.legal_business_structure))'');
    populated_business_established_date_pcnt := AVE(GROUP,IF(h.business_established_date = (TYPEOF(h.business_established_date))'',0,100));
    maxlength_business_established_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_established_date)));
    avelength_business_established_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_established_date)),h.business_established_date<>(typeof(h.business_established_date))'');
    populated_account_status_1_pcnt := AVE(GROUP,IF(h.account_status_1 = (TYPEOF(h.account_status_1))'',0,100));
    maxlength_account_status_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_1)));
    avelength_account_status_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_1)),h.account_status_1<>(typeof(h.account_status_1))'');
    populated_account_status_2_pcnt := AVE(GROUP,IF(h.account_status_2 = (TYPEOF(h.account_status_2))'',0,100));
    maxlength_account_status_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_2)));
    avelength_account_status_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_2)),h.account_status_2<>(typeof(h.account_status_2))'');
    populated_date_account_opened_pcnt := AVE(GROUP,IF(h.date_account_opened = (TYPEOF(h.date_account_opened))'',0,100));
    maxlength_date_account_opened := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_opened)));
    avelength_date_account_opened := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_opened)),h.date_account_opened<>(typeof(h.date_account_opened))'');
    populated_date_account_closed_pcnt := AVE(GROUP,IF(h.date_account_closed = (TYPEOF(h.date_account_closed))'',0,100));
    maxlength_date_account_closed := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_closed)));
    avelength_date_account_closed := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_closed)),h.date_account_closed<>(typeof(h.date_account_closed))'');
    populated_account_closure_basis_pcnt := AVE(GROUP,IF(h.account_closure_basis = (TYPEOF(h.account_closure_basis))'',0,100));
    maxlength_account_closure_basis := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_closure_basis)));
    avelength_account_closure_basis := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_closure_basis)),h.account_closure_basis<>(typeof(h.account_closure_basis))'');
    populated_account_expiration_date_pcnt := AVE(GROUP,IF(h.account_expiration_date = (TYPEOF(h.account_expiration_date))'',0,100));
    maxlength_account_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_expiration_date)));
    avelength_account_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_expiration_date)),h.account_expiration_date<>(typeof(h.account_expiration_date))'');
    populated_last_activity_date_pcnt := AVE(GROUP,IF(h.last_activity_date = (TYPEOF(h.last_activity_date))'',0,100));
    maxlength_last_activity_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_date)));
    avelength_last_activity_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_date)),h.last_activity_date<>(typeof(h.last_activity_date))'');
    populated_last_activity_type_pcnt := AVE(GROUP,IF(h.last_activity_type = (TYPEOF(h.last_activity_type))'',0,100));
    maxlength_last_activity_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_type)));
    avelength_last_activity_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_type)),h.last_activity_type<>(typeof(h.last_activity_type))'');
    populated_recent_activity_indicator_pcnt := AVE(GROUP,IF(h.recent_activity_indicator = (TYPEOF(h.recent_activity_indicator))'',0,100));
    maxlength_recent_activity_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_activity_indicator)));
    avelength_recent_activity_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_activity_indicator)),h.recent_activity_indicator<>(typeof(h.recent_activity_indicator))'');
    populated_original_credit_limit_pcnt := AVE(GROUP,IF(h.original_credit_limit = (TYPEOF(h.original_credit_limit))'',0,100));
    maxlength_original_credit_limit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_credit_limit)));
    avelength_original_credit_limit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_credit_limit)),h.original_credit_limit<>(typeof(h.original_credit_limit))'');
    populated_highest_credit_used_pcnt := AVE(GROUP,IF(h.highest_credit_used = (TYPEOF(h.highest_credit_used))'',0,100));
    maxlength_highest_credit_used := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.highest_credit_used)));
    avelength_highest_credit_used := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.highest_credit_used)),h.highest_credit_used<>(typeof(h.highest_credit_used))'');
    populated_current_credit_limit_pcnt := AVE(GROUP,IF(h.current_credit_limit = (TYPEOF(h.current_credit_limit))'',0,100));
    maxlength_current_credit_limit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_credit_limit)));
    avelength_current_credit_limit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_credit_limit)),h.current_credit_limit<>(typeof(h.current_credit_limit))'');
    populated_reporting_indicator_length_pcnt := AVE(GROUP,IF(h.reporting_indicator_length = (TYPEOF(h.reporting_indicator_length))'',0,100));
    maxlength_reporting_indicator_length := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reporting_indicator_length)));
    avelength_reporting_indicator_length := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reporting_indicator_length)),h.reporting_indicator_length<>(typeof(h.reporting_indicator_length))'');
    populated_payment_interval_pcnt := AVE(GROUP,IF(h.payment_interval = (TYPEOF(h.payment_interval))'',0,100));
    maxlength_payment_interval := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_interval)));
    avelength_payment_interval := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_interval)),h.payment_interval<>(typeof(h.payment_interval))'');
    populated_payment_status_category_pcnt := AVE(GROUP,IF(h.payment_status_category = (TYPEOF(h.payment_status_category))'',0,100));
    maxlength_payment_status_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_status_category)));
    avelength_payment_status_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_status_category)),h.payment_status_category<>(typeof(h.payment_status_category))'');
    populated_term_of_account_in_months_pcnt := AVE(GROUP,IF(h.term_of_account_in_months = (TYPEOF(h.term_of_account_in_months))'',0,100));
    maxlength_term_of_account_in_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.term_of_account_in_months)));
    avelength_term_of_account_in_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.term_of_account_in_months)),h.term_of_account_in_months<>(typeof(h.term_of_account_in_months))'');
    populated_first_payment_due_date_pcnt := AVE(GROUP,IF(h.first_payment_due_date = (TYPEOF(h.first_payment_due_date))'',0,100));
    maxlength_first_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_payment_due_date)));
    avelength_first_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_payment_due_date)),h.first_payment_due_date<>(typeof(h.first_payment_due_date))'');
    populated_final_payment_due_date_pcnt := AVE(GROUP,IF(h.final_payment_due_date = (TYPEOF(h.final_payment_due_date))'',0,100));
    maxlength_final_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.final_payment_due_date)));
    avelength_final_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.final_payment_due_date)),h.final_payment_due_date<>(typeof(h.final_payment_due_date))'');
    populated_original_rate_pcnt := AVE(GROUP,IF(h.original_rate = (TYPEOF(h.original_rate))'',0,100));
    maxlength_original_rate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_rate)));
    avelength_original_rate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_rate)),h.original_rate<>(typeof(h.original_rate))'');
    populated_floating_rate_pcnt := AVE(GROUP,IF(h.floating_rate = (TYPEOF(h.floating_rate))'',0,100));
    maxlength_floating_rate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.floating_rate)));
    avelength_floating_rate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.floating_rate)),h.floating_rate<>(typeof(h.floating_rate))'');
    populated_grace_period_pcnt := AVE(GROUP,IF(h.grace_period = (TYPEOF(h.grace_period))'',0,100));
    maxlength_grace_period := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.grace_period)));
    avelength_grace_period := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.grace_period)),h.grace_period<>(typeof(h.grace_period))'');
    populated_payment_category_pcnt := AVE(GROUP,IF(h.payment_category = (TYPEOF(h.payment_category))'',0,100));
    maxlength_payment_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_category)));
    avelength_payment_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_category)),h.payment_category<>(typeof(h.payment_category))'');
    populated_payment_history_profile_12_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_12_months = (TYPEOF(h.payment_history_profile_12_months))'',0,100));
    maxlength_payment_history_profile_12_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_12_months)));
    avelength_payment_history_profile_12_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_12_months)),h.payment_history_profile_12_months<>(typeof(h.payment_history_profile_12_months))'');
    populated_payment_history_profile_13_24_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_13_24_months = (TYPEOF(h.payment_history_profile_13_24_months))'',0,100));
    maxlength_payment_history_profile_13_24_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_13_24_months)));
    avelength_payment_history_profile_13_24_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_13_24_months)),h.payment_history_profile_13_24_months<>(typeof(h.payment_history_profile_13_24_months))'');
    populated_payment_history_profile_25_36_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_25_36_months = (TYPEOF(h.payment_history_profile_25_36_months))'',0,100));
    maxlength_payment_history_profile_25_36_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_25_36_months)));
    avelength_payment_history_profile_25_36_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_25_36_months)),h.payment_history_profile_25_36_months<>(typeof(h.payment_history_profile_25_36_months))'');
    populated_payment_history_profile_37_48_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_37_48_months = (TYPEOF(h.payment_history_profile_37_48_months))'',0,100));
    maxlength_payment_history_profile_37_48_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_37_48_months)));
    avelength_payment_history_profile_37_48_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_37_48_months)),h.payment_history_profile_37_48_months<>(typeof(h.payment_history_profile_37_48_months))'');
    populated_payment_history_length_pcnt := AVE(GROUP,IF(h.payment_history_length = (TYPEOF(h.payment_history_length))'',0,100));
    maxlength_payment_history_length := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_length)));
    avelength_payment_history_length := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_length)),h.payment_history_length<>(typeof(h.payment_history_length))'');
    populated_year_to_date_purchases_count_pcnt := AVE(GROUP,IF(h.year_to_date_purchases_count = (TYPEOF(h.year_to_date_purchases_count))'',0,100));
    maxlength_year_to_date_purchases_count := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_count)));
    avelength_year_to_date_purchases_count := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_count)),h.year_to_date_purchases_count<>(typeof(h.year_to_date_purchases_count))'');
    populated_lifetime_to_date_purchases_count_pcnt := AVE(GROUP,IF(h.lifetime_to_date_purchases_count = (TYPEOF(h.lifetime_to_date_purchases_count))'',0,100));
    maxlength_lifetime_to_date_purchases_count := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_count)));
    avelength_lifetime_to_date_purchases_count := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_count)),h.lifetime_to_date_purchases_count<>(typeof(h.lifetime_to_date_purchases_count))'');
    populated_year_to_date_purchases_sum_amount_pcnt := AVE(GROUP,IF(h.year_to_date_purchases_sum_amount = (TYPEOF(h.year_to_date_purchases_sum_amount))'',0,100));
    maxlength_year_to_date_purchases_sum_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_sum_amount)));
    avelength_year_to_date_purchases_sum_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_sum_amount)),h.year_to_date_purchases_sum_amount<>(typeof(h.year_to_date_purchases_sum_amount))'');
    populated_lifetime_to_date_purchases_sum_amount_pcnt := AVE(GROUP,IF(h.lifetime_to_date_purchases_sum_amount = (TYPEOF(h.lifetime_to_date_purchases_sum_amount))'',0,100));
    maxlength_lifetime_to_date_purchases_sum_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_sum_amount)));
    avelength_lifetime_to_date_purchases_sum_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_sum_amount)),h.lifetime_to_date_purchases_sum_amount<>(typeof(h.lifetime_to_date_purchases_sum_amount))'');
    populated_payment_amount_scheduled_pcnt := AVE(GROUP,IF(h.payment_amount_scheduled = (TYPEOF(h.payment_amount_scheduled))'',0,100));
    maxlength_payment_amount_scheduled := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_amount_scheduled)));
    avelength_payment_amount_scheduled := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_amount_scheduled)),h.payment_amount_scheduled<>(typeof(h.payment_amount_scheduled))'');
    populated_recent_payment_amount_pcnt := AVE(GROUP,IF(h.recent_payment_amount = (TYPEOF(h.recent_payment_amount))'',0,100));
    maxlength_recent_payment_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_amount)));
    avelength_recent_payment_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_amount)),h.recent_payment_amount<>(typeof(h.recent_payment_amount))'');
    populated_recent_payment_date_pcnt := AVE(GROUP,IF(h.recent_payment_date = (TYPEOF(h.recent_payment_date))'',0,100));
    maxlength_recent_payment_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_date)));
    avelength_recent_payment_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_date)),h.recent_payment_date<>(typeof(h.recent_payment_date))'');
    populated_remaining_balance_pcnt := AVE(GROUP,IF(h.remaining_balance = (TYPEOF(h.remaining_balance))'',0,100));
    maxlength_remaining_balance := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.remaining_balance)));
    avelength_remaining_balance := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.remaining_balance)),h.remaining_balance<>(typeof(h.remaining_balance))'');
    populated_carried_over_amount_pcnt := AVE(GROUP,IF(h.carried_over_amount = (TYPEOF(h.carried_over_amount))'',0,100));
    maxlength_carried_over_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.carried_over_amount)));
    avelength_carried_over_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.carried_over_amount)),h.carried_over_amount<>(typeof(h.carried_over_amount))'');
    populated_new_applied_charges_pcnt := AVE(GROUP,IF(h.new_applied_charges = (TYPEOF(h.new_applied_charges))'',0,100));
    maxlength_new_applied_charges := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.new_applied_charges)));
    avelength_new_applied_charges := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.new_applied_charges)),h.new_applied_charges<>(typeof(h.new_applied_charges))'');
    populated_balloon_payment_due_pcnt := AVE(GROUP,IF(h.balloon_payment_due = (TYPEOF(h.balloon_payment_due))'',0,100));
    maxlength_balloon_payment_due := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due)));
    avelength_balloon_payment_due := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due)),h.balloon_payment_due<>(typeof(h.balloon_payment_due))'');
    populated_balloon_payment_due_date_pcnt := AVE(GROUP,IF(h.balloon_payment_due_date = (TYPEOF(h.balloon_payment_due_date))'',0,100));
    maxlength_balloon_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due_date)));
    avelength_balloon_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due_date)),h.balloon_payment_due_date<>(typeof(h.balloon_payment_due_date))'');
    populated_delinquency_date_pcnt := AVE(GROUP,IF(h.delinquency_date = (TYPEOF(h.delinquency_date))'',0,100));
    maxlength_delinquency_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.delinquency_date)));
    avelength_delinquency_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.delinquency_date)),h.delinquency_date<>(typeof(h.delinquency_date))'');
    populated_days_delinquent_pcnt := AVE(GROUP,IF(h.days_delinquent = (TYPEOF(h.days_delinquent))'',0,100));
    maxlength_days_delinquent := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.days_delinquent)));
    avelength_days_delinquent := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.days_delinquent)),h.days_delinquent<>(typeof(h.days_delinquent))'');
    populated_past_due_amount_pcnt := AVE(GROUP,IF(h.past_due_amount = (TYPEOF(h.past_due_amount))'',0,100));
    maxlength_past_due_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_amount)));
    avelength_past_due_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_amount)),h.past_due_amount<>(typeof(h.past_due_amount))'');
    populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt := AVE(GROUP,IF(h.maximum_number_of_past_due_aging_amounts_buckets_provided = (TYPEOF(h.maximum_number_of_past_due_aging_amounts_buckets_provided))'',0,100));
    maxlength_maximum_number_of_past_due_aging_amounts_buckets_provided := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_past_due_aging_amounts_buckets_provided)));
    avelength_maximum_number_of_past_due_aging_amounts_buckets_provided := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_past_due_aging_amounts_buckets_provided)),h.maximum_number_of_past_due_aging_amounts_buckets_provided<>(typeof(h.maximum_number_of_past_due_aging_amounts_buckets_provided))'');
    populated_past_due_aging_bucket_type_pcnt := AVE(GROUP,IF(h.past_due_aging_bucket_type = (TYPEOF(h.past_due_aging_bucket_type))'',0,100));
    maxlength_past_due_aging_bucket_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_bucket_type)));
    avelength_past_due_aging_bucket_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_bucket_type)),h.past_due_aging_bucket_type<>(typeof(h.past_due_aging_bucket_type))'');
    populated_past_due_aging_amount_bucket_1_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_1 = (TYPEOF(h.past_due_aging_amount_bucket_1))'',0,100));
    maxlength_past_due_aging_amount_bucket_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_1)));
    avelength_past_due_aging_amount_bucket_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_1)),h.past_due_aging_amount_bucket_1<>(typeof(h.past_due_aging_amount_bucket_1))'');
    populated_past_due_aging_amount_bucket_2_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_2 = (TYPEOF(h.past_due_aging_amount_bucket_2))'',0,100));
    maxlength_past_due_aging_amount_bucket_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_2)));
    avelength_past_due_aging_amount_bucket_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_2)),h.past_due_aging_amount_bucket_2<>(typeof(h.past_due_aging_amount_bucket_2))'');
    populated_past_due_aging_amount_bucket_3_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_3 = (TYPEOF(h.past_due_aging_amount_bucket_3))'',0,100));
    maxlength_past_due_aging_amount_bucket_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_3)));
    avelength_past_due_aging_amount_bucket_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_3)),h.past_due_aging_amount_bucket_3<>(typeof(h.past_due_aging_amount_bucket_3))'');
    populated_past_due_aging_amount_bucket_4_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_4 = (TYPEOF(h.past_due_aging_amount_bucket_4))'',0,100));
    maxlength_past_due_aging_amount_bucket_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_4)));
    avelength_past_due_aging_amount_bucket_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_4)),h.past_due_aging_amount_bucket_4<>(typeof(h.past_due_aging_amount_bucket_4))'');
    populated_past_due_aging_amount_bucket_5_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_5 = (TYPEOF(h.past_due_aging_amount_bucket_5))'',0,100));
    maxlength_past_due_aging_amount_bucket_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_5)));
    avelength_past_due_aging_amount_bucket_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_5)),h.past_due_aging_amount_bucket_5<>(typeof(h.past_due_aging_amount_bucket_5))'');
    populated_past_due_aging_amount_bucket_6_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_6 = (TYPEOF(h.past_due_aging_amount_bucket_6))'',0,100));
    maxlength_past_due_aging_amount_bucket_6 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_6)));
    avelength_past_due_aging_amount_bucket_6 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_6)),h.past_due_aging_amount_bucket_6<>(typeof(h.past_due_aging_amount_bucket_6))'');
    populated_past_due_aging_amount_bucket_7_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_7 = (TYPEOF(h.past_due_aging_amount_bucket_7))'',0,100));
    maxlength_past_due_aging_amount_bucket_7 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_7)));
    avelength_past_due_aging_amount_bucket_7 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_7)),h.past_due_aging_amount_bucket_7<>(typeof(h.past_due_aging_amount_bucket_7))'');
    populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt := AVE(GROUP,IF(h.maximum_number_of_payment_tracking_cycle_periods_provided = (TYPEOF(h.maximum_number_of_payment_tracking_cycle_periods_provided))'',0,100));
    maxlength_maximum_number_of_payment_tracking_cycle_periods_provided := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_payment_tracking_cycle_periods_provided)));
    avelength_maximum_number_of_payment_tracking_cycle_periods_provided := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_payment_tracking_cycle_periods_provided)),h.maximum_number_of_payment_tracking_cycle_periods_provided<>(typeof(h.maximum_number_of_payment_tracking_cycle_periods_provided))'');
    populated_payment_tracking_cycle_type_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_type = (TYPEOF(h.payment_tracking_cycle_type))'',0,100));
    maxlength_payment_tracking_cycle_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_type)));
    avelength_payment_tracking_cycle_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_type)),h.payment_tracking_cycle_type<>(typeof(h.payment_tracking_cycle_type))'');
    populated_payment_tracking_cycle_0_current_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_0_current = (TYPEOF(h.payment_tracking_cycle_0_current))'',0,100));
    maxlength_payment_tracking_cycle_0_current := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_0_current)));
    avelength_payment_tracking_cycle_0_current := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_0_current)),h.payment_tracking_cycle_0_current<>(typeof(h.payment_tracking_cycle_0_current))'');
    populated_payment_tracking_cycle_1_1_to_30_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_1_1_to_30_days = (TYPEOF(h.payment_tracking_cycle_1_1_to_30_days))'',0,100));
    maxlength_payment_tracking_cycle_1_1_to_30_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_1_1_to_30_days)));
    avelength_payment_tracking_cycle_1_1_to_30_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_1_1_to_30_days)),h.payment_tracking_cycle_1_1_to_30_days<>(typeof(h.payment_tracking_cycle_1_1_to_30_days))'');
    populated_payment_tracking_cycle_2_31_to_60_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_2_31_to_60_days = (TYPEOF(h.payment_tracking_cycle_2_31_to_60_days))'',0,100));
    maxlength_payment_tracking_cycle_2_31_to_60_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_2_31_to_60_days)));
    avelength_payment_tracking_cycle_2_31_to_60_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_2_31_to_60_days)),h.payment_tracking_cycle_2_31_to_60_days<>(typeof(h.payment_tracking_cycle_2_31_to_60_days))'');
    populated_payment_tracking_cycle_3_61_to_90_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_3_61_to_90_days = (TYPEOF(h.payment_tracking_cycle_3_61_to_90_days))'',0,100));
    maxlength_payment_tracking_cycle_3_61_to_90_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_3_61_to_90_days)));
    avelength_payment_tracking_cycle_3_61_to_90_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_3_61_to_90_days)),h.payment_tracking_cycle_3_61_to_90_days<>(typeof(h.payment_tracking_cycle_3_61_to_90_days))'');
    populated_payment_tracking_cycle_4_91_to_120_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_4_91_to_120_days = (TYPEOF(h.payment_tracking_cycle_4_91_to_120_days))'',0,100));
    maxlength_payment_tracking_cycle_4_91_to_120_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_4_91_to_120_days)));
    avelength_payment_tracking_cycle_4_91_to_120_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_4_91_to_120_days)),h.payment_tracking_cycle_4_91_to_120_days<>(typeof(h.payment_tracking_cycle_4_91_to_120_days))'');
    populated_payment_tracking_cycle_5_121_to_150days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_5_121_to_150days = (TYPEOF(h.payment_tracking_cycle_5_121_to_150days))'',0,100));
    maxlength_payment_tracking_cycle_5_121_to_150days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_5_121_to_150days)));
    avelength_payment_tracking_cycle_5_121_to_150days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_5_121_to_150days)),h.payment_tracking_cycle_5_121_to_150days<>(typeof(h.payment_tracking_cycle_5_121_to_150days))'');
    populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt := AVE(GROUP,IF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days = (TYPEOF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days))'',0,100));
    maxlength_payment_tracking_number_of_times_cycle_6_151_to_180_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_6_151_to_180_days)));
    avelength_payment_tracking_number_of_times_cycle_6_151_to_180_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_6_151_to_180_days)),h.payment_tracking_number_of_times_cycle_6_151_to_180_days<>(typeof(h.payment_tracking_number_of_times_cycle_6_151_to_180_days))'');
    populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt := AVE(GROUP,IF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days = (TYPEOF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days))'',0,100));
    maxlength_payment_tracking_number_of_times_cycle_7_181_or_greater_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_7_181_or_greater_days)));
    avelength_payment_tracking_number_of_times_cycle_7_181_or_greater_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_7_181_or_greater_days)),h.payment_tracking_number_of_times_cycle_7_181_or_greater_days<>(typeof(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days))'');
    populated_date_account_was_charged_off_pcnt := AVE(GROUP,IF(h.date_account_was_charged_off = (TYPEOF(h.date_account_was_charged_off))'',0,100));
    maxlength_date_account_was_charged_off := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_was_charged_off)));
    avelength_date_account_was_charged_off := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_was_charged_off)),h.date_account_was_charged_off<>(typeof(h.date_account_was_charged_off))'');
    populated_amount_charged_off_by_creditor_pcnt := AVE(GROUP,IF(h.amount_charged_off_by_creditor = (TYPEOF(h.amount_charged_off_by_creditor))'',0,100));
    maxlength_amount_charged_off_by_creditor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount_charged_off_by_creditor)));
    avelength_amount_charged_off_by_creditor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount_charged_off_by_creditor)),h.amount_charged_off_by_creditor<>(typeof(h.amount_charged_off_by_creditor))'');
    populated_charge_off_type_indicator_pcnt := AVE(GROUP,IF(h.charge_off_type_indicator = (TYPEOF(h.charge_off_type_indicator))'',0,100));
    maxlength_charge_off_type_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.charge_off_type_indicator)));
    avelength_charge_off_type_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.charge_off_type_indicator)),h.charge_off_type_indicator<>(typeof(h.charge_off_type_indicator))'');
    populated_total_charge_off_recoveries_to_date_pcnt := AVE(GROUP,IF(h.total_charge_off_recoveries_to_date = (TYPEOF(h.total_charge_off_recoveries_to_date))'',0,100));
    maxlength_total_charge_off_recoveries_to_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_charge_off_recoveries_to_date)));
    avelength_total_charge_off_recoveries_to_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_charge_off_recoveries_to_date)),h.total_charge_off_recoveries_to_date<>(typeof(h.total_charge_off_recoveries_to_date))'');
    populated_government_guarantee_flag_pcnt := AVE(GROUP,IF(h.government_guarantee_flag = (TYPEOF(h.government_guarantee_flag))'',0,100));
    maxlength_government_guarantee_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_flag)));
    avelength_government_guarantee_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_flag)),h.government_guarantee_flag<>(typeof(h.government_guarantee_flag))'');
    populated_government_guarantee_category_pcnt := AVE(GROUP,IF(h.government_guarantee_category = (TYPEOF(h.government_guarantee_category))'',0,100));
    maxlength_government_guarantee_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_category)));
    avelength_government_guarantee_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_category)),h.government_guarantee_category<>(typeof(h.government_guarantee_category))'');
    populated_portion_of_account_guaranteed_by_government_pcnt := AVE(GROUP,IF(h.portion_of_account_guaranteed_by_government = (TYPEOF(h.portion_of_account_guaranteed_by_government))'',0,100));
    maxlength_portion_of_account_guaranteed_by_government := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.portion_of_account_guaranteed_by_government)));
    avelength_portion_of_account_guaranteed_by_government := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.portion_of_account_guaranteed_by_government)),h.portion_of_account_guaranteed_by_government<>(typeof(h.portion_of_account_guaranteed_by_government))'');
    populated_guarantors_indicator_pcnt := AVE(GROUP,IF(h.guarantors_indicator = (TYPEOF(h.guarantors_indicator))'',0,100));
    maxlength_guarantors_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantors_indicator)));
    avelength_guarantors_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantors_indicator)),h.guarantors_indicator<>(typeof(h.guarantors_indicator))'');
    populated_number_of_guarantors_pcnt := AVE(GROUP,IF(h.number_of_guarantors = (TYPEOF(h.number_of_guarantors))'',0,100));
    maxlength_number_of_guarantors := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_guarantors)));
    avelength_number_of_guarantors := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_guarantors)),h.number_of_guarantors<>(typeof(h.number_of_guarantors))'');
    populated_owners_indicator_pcnt := AVE(GROUP,IF(h.owners_indicator = (TYPEOF(h.owners_indicator))'',0,100));
    maxlength_owners_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.owners_indicator)));
    avelength_owners_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.owners_indicator)),h.owners_indicator<>(typeof(h.owners_indicator))'');
    populated_number_of_principals_pcnt := AVE(GROUP,IF(h.number_of_principals = (TYPEOF(h.number_of_principals))'',0,100));
    maxlength_number_of_principals := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_principals)));
    avelength_number_of_principals := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_principals)),h.number_of_principals<>(typeof(h.number_of_principals))'');
    populated_account_update_deletion_indicator_pcnt := AVE(GROUP,IF(h.account_update_deletion_indicator = (TYPEOF(h.account_update_deletion_indicator))'',0,100));
    maxlength_account_update_deletion_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_update_deletion_indicator)));
    avelength_account_update_deletion_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_update_deletion_indicator)),h.account_update_deletion_indicator<>(typeof(h.account_update_deletion_indicator))'');
    populated_percent_of_liability_pcnt := AVE(GROUP,IF(h.percent_of_liability = (TYPEOF(h.percent_of_liability))'',0,100));
    maxlength_percent_of_liability := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.percent_of_liability)));
    avelength_percent_of_liability := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.percent_of_liability)),h.percent_of_liability<>(typeof(h.percent_of_liability))'');
    populated_percent_of_ownership_pcnt := AVE(GROUP,IF(h.percent_of_ownership = (TYPEOF(h.percent_of_ownership))'',0,100));
    maxlength_percent_of_ownership := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.percent_of_ownership)));
    avelength_percent_of_ownership := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.percent_of_ownership)),h.percent_of_ownership<>(typeof(h.percent_of_ownership))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_timestamp_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_datawarehouse_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_datawarehouse_last_reported_pcnt *   0.00 / 100 + T.Populated_sbfe_contributor_number_pcnt *   0.00 / 100 + T.Populated_contract_account_number_pcnt *   0.00 / 100 + T.Populated_account_type_reported_pcnt *   0.00 / 100 + T.Populated_extracted_date_pcnt *   0.00 / 100 + T.Populated_cycle_end_date_pcnt *   0.00 / 100 + T.Populated_account_holder_business_name_pcnt *   0.00 / 100 + T.Populated_clean_account_holder_business_name_pcnt *   0.00 / 100 + T.Populated_dba_pcnt *   0.00 / 100 + T.Populated_clean_dba_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_clean_business_name_pcnt *   0.00 / 100 + T.Populated_company_website_pcnt *   0.00 / 100 + T.Populated_original_fname_pcnt *   0.00 / 100 + T.Populated_original_mname_pcnt *   0.00 / 100 + T.Populated_original_lname_pcnt *   0.00 / 100 + T.Populated_original_suffix_pcnt *   0.00 / 100 + T.Populated_e_mail_address_pcnt *   0.00 / 100 + T.Populated_guarantor_owner_indicator_pcnt *   0.00 / 100 + T.Populated_relationship_to_business_indicator_pcnt *   0.00 / 100 + T.Populated_business_title_pcnt *   0.00 / 100 + T.Populated_clean_title_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100 + T.Populated_clean_suffix_pcnt *   0.00 / 100 + T.Populated_original_address_line_1_pcnt *   0.00 / 100 + T.Populated_original_address_line_2_pcnt *   0.00 / 100 + T.Populated_original_city_pcnt *   0.00 / 100 + T.Populated_original_state_pcnt *   0.00 / 100 + T.Populated_original_zip_code_or_ca_postal_code_pcnt *   0.00 / 100 + T.Populated_original_postal_code_pcnt *   0.00 / 100 + T.Populated_original_country_code_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_original_area_code_pcnt *   0.00 / 100 + T.Populated_original_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_extension_pcnt *   0.00 / 100 + T.Populated_primary_phone_indicator_pcnt *   0.00 / 100 + T.Populated_published_unlisted_indicator_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_federal_taxid_ssn_pcnt *   0.00 / 100 + T.Populated_federal_taxid_ssn_identifier_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_sbfe_id_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_active_pcnt *   0.00 / 100 + T.Populated_legal_business_structure_pcnt *   0.00 / 100 + T.Populated_business_established_date_pcnt *   0.00 / 100 + T.Populated_account_status_1_pcnt *   0.00 / 100 + T.Populated_account_status_2_pcnt *   0.00 / 100 + T.Populated_date_account_opened_pcnt *   0.00 / 100 + T.Populated_date_account_closed_pcnt *   0.00 / 100 + T.Populated_account_closure_basis_pcnt *   0.00 / 100 + T.Populated_account_expiration_date_pcnt *   0.00 / 100 + T.Populated_last_activity_date_pcnt *   0.00 / 100 + T.Populated_last_activity_type_pcnt *   0.00 / 100 + T.Populated_recent_activity_indicator_pcnt *   0.00 / 100 + T.Populated_original_credit_limit_pcnt *   0.00 / 100 + T.Populated_highest_credit_used_pcnt *   0.00 / 100 + T.Populated_current_credit_limit_pcnt *   0.00 / 100 + T.Populated_reporting_indicator_length_pcnt *   0.00 / 100 + T.Populated_payment_interval_pcnt *   0.00 / 100 + T.Populated_payment_status_category_pcnt *   0.00 / 100 + T.Populated_term_of_account_in_months_pcnt *   0.00 / 100 + T.Populated_first_payment_due_date_pcnt *   0.00 / 100 + T.Populated_final_payment_due_date_pcnt *   0.00 / 100 + T.Populated_original_rate_pcnt *   0.00 / 100 + T.Populated_floating_rate_pcnt *   0.00 / 100 + T.Populated_grace_period_pcnt *   0.00 / 100 + T.Populated_payment_category_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_12_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_13_24_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_25_36_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_37_48_months_pcnt *   0.00 / 100 + T.Populated_payment_history_length_pcnt *   0.00 / 100 + T.Populated_year_to_date_purchases_count_pcnt *   0.00 / 100 + T.Populated_lifetime_to_date_purchases_count_pcnt *   0.00 / 100 + T.Populated_year_to_date_purchases_sum_amount_pcnt *   0.00 / 100 + T.Populated_lifetime_to_date_purchases_sum_amount_pcnt *   0.00 / 100 + T.Populated_payment_amount_scheduled_pcnt *   0.00 / 100 + T.Populated_recent_payment_amount_pcnt *   0.00 / 100 + T.Populated_recent_payment_date_pcnt *   0.00 / 100 + T.Populated_remaining_balance_pcnt *   0.00 / 100 + T.Populated_carried_over_amount_pcnt *   0.00 / 100 + T.Populated_new_applied_charges_pcnt *   0.00 / 100 + T.Populated_balloon_payment_due_pcnt *   0.00 / 100 + T.Populated_balloon_payment_due_date_pcnt *   0.00 / 100 + T.Populated_delinquency_date_pcnt *   0.00 / 100 + T.Populated_days_delinquent_pcnt *   0.00 / 100 + T.Populated_past_due_amount_pcnt *   0.00 / 100 + T.Populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt *   0.00 / 100 + T.Populated_past_due_aging_bucket_type_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_1_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_2_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_3_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_4_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_5_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_6_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_7_pcnt *   0.00 / 100 + T.Populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_type_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_0_current_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_1_1_to_30_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_2_31_to_60_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_3_61_to_90_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_4_91_to_120_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_5_121_to_150days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt *   0.00 / 100 + T.Populated_date_account_was_charged_off_pcnt *   0.00 / 100 + T.Populated_amount_charged_off_by_creditor_pcnt *   0.00 / 100 + T.Populated_charge_off_type_indicator_pcnt *   0.00 / 100 + T.Populated_total_charge_off_recoveries_to_date_pcnt *   0.00 / 100 + T.Populated_government_guarantee_flag_pcnt *   0.00 / 100 + T.Populated_government_guarantee_category_pcnt *   0.00 / 100 + T.Populated_portion_of_account_guaranteed_by_government_pcnt *   0.00 / 100 + T.Populated_guarantors_indicator_pcnt *   0.00 / 100 + T.Populated_number_of_guarantors_pcnt *   0.00 / 100 + T.Populated_owners_indicator_pcnt *   0.00 / 100 + T.Populated_number_of_principals_pcnt *   0.00 / 100 + T.Populated_account_update_deletion_indicator_pcnt *   0.00 / 100 + T.Populated_percent_of_liability_pcnt *   0.00 / 100 + T.Populated_percent_of_ownership_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'timestamp','process_date','record_type','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_datawarehouse_first_reported','dt_datawarehouse_last_reported','sbfe_contributor_number','contract_account_number','account_type_reported','extracted_date','cycle_end_date','account_holder_business_name','clean_account_holder_business_name','dba','clean_dba','business_name','clean_business_name','company_website','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','clean_title','clean_fname','clean_mname','clean_lname','clean_suffix','original_address_line_1','original_address_line_2','original_city','original_state','original_zip_code_or_ca_postal_code','original_postal_code','original_country_code','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','original_area_code','original_phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type','phone_number','federal_taxid_ssn','federal_taxid_ssn_identifier','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','persistent_record_id','sbfe_id','source','active','legal_business_structure','business_established_date','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator','percent_of_liability','percent_of_ownership');
  SELF.populated_pcnt := CHOOSE(C,le.populated_timestamp_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_datawarehouse_first_reported_pcnt,le.populated_dt_datawarehouse_last_reported_pcnt,le.populated_sbfe_contributor_number_pcnt,le.populated_contract_account_number_pcnt,le.populated_account_type_reported_pcnt,le.populated_extracted_date_pcnt,le.populated_cycle_end_date_pcnt,le.populated_account_holder_business_name_pcnt,le.populated_clean_account_holder_business_name_pcnt,le.populated_dba_pcnt,le.populated_clean_dba_pcnt,le.populated_business_name_pcnt,le.populated_clean_business_name_pcnt,le.populated_company_website_pcnt,le.populated_original_fname_pcnt,le.populated_original_mname_pcnt,le.populated_original_lname_pcnt,le.populated_original_suffix_pcnt,le.populated_e_mail_address_pcnt,le.populated_guarantor_owner_indicator_pcnt,le.populated_relationship_to_business_indicator_pcnt,le.populated_business_title_pcnt,le.populated_clean_title_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt,le.populated_clean_suffix_pcnt,le.populated_original_address_line_1_pcnt,le.populated_original_address_line_2_pcnt,le.populated_original_city_pcnt,le.populated_original_state_pcnt,le.populated_original_zip_code_or_ca_postal_code_pcnt,le.populated_original_postal_code_pcnt,le.populated_original_country_code_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_original_area_code_pcnt,le.populated_original_phone_number_pcnt,le.populated_phone_extension_pcnt,le.populated_primary_phone_indicator_pcnt,le.populated_published_unlisted_indicator_pcnt,le.populated_phone_type_pcnt,le.populated_phone_number_pcnt,le.populated_federal_taxid_ssn_pcnt,le.populated_federal_taxid_ssn_identifier_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_persistent_record_id_pcnt,le.populated_sbfe_id_pcnt,le.populated_source_pcnt,le.populated_active_pcnt,le.populated_legal_business_structure_pcnt,le.populated_business_established_date_pcnt,le.populated_account_status_1_pcnt,le.populated_account_status_2_pcnt,le.populated_date_account_opened_pcnt,le.populated_date_account_closed_pcnt,le.populated_account_closure_basis_pcnt,le.populated_account_expiration_date_pcnt,le.populated_last_activity_date_pcnt,le.populated_last_activity_type_pcnt,le.populated_recent_activity_indicator_pcnt,le.populated_original_credit_limit_pcnt,le.populated_highest_credit_used_pcnt,le.populated_current_credit_limit_pcnt,le.populated_reporting_indicator_length_pcnt,le.populated_payment_interval_pcnt,le.populated_payment_status_category_pcnt,le.populated_term_of_account_in_months_pcnt,le.populated_first_payment_due_date_pcnt,le.populated_final_payment_due_date_pcnt,le.populated_original_rate_pcnt,le.populated_floating_rate_pcnt,le.populated_grace_period_pcnt,le.populated_payment_category_pcnt,le.populated_payment_history_profile_12_months_pcnt,le.populated_payment_history_profile_13_24_months_pcnt,le.populated_payment_history_profile_25_36_months_pcnt,le.populated_payment_history_profile_37_48_months_pcnt,le.populated_payment_history_length_pcnt,le.populated_year_to_date_purchases_count_pcnt,le.populated_lifetime_to_date_purchases_count_pcnt,le.populated_year_to_date_purchases_sum_amount_pcnt,le.populated_lifetime_to_date_purchases_sum_amount_pcnt,le.populated_payment_amount_scheduled_pcnt,le.populated_recent_payment_amount_pcnt,le.populated_recent_payment_date_pcnt,le.populated_remaining_balance_pcnt,le.populated_carried_over_amount_pcnt,le.populated_new_applied_charges_pcnt,le.populated_balloon_payment_due_pcnt,le.populated_balloon_payment_due_date_pcnt,le.populated_delinquency_date_pcnt,le.populated_days_delinquent_pcnt,le.populated_past_due_amount_pcnt,le.populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt,le.populated_past_due_aging_bucket_type_pcnt,le.populated_past_due_aging_amount_bucket_1_pcnt,le.populated_past_due_aging_amount_bucket_2_pcnt,le.populated_past_due_aging_amount_bucket_3_pcnt,le.populated_past_due_aging_amount_bucket_4_pcnt,le.populated_past_due_aging_amount_bucket_5_pcnt,le.populated_past_due_aging_amount_bucket_6_pcnt,le.populated_past_due_aging_amount_bucket_7_pcnt,le.populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt,le.populated_payment_tracking_cycle_type_pcnt,le.populated_payment_tracking_cycle_0_current_pcnt,le.populated_payment_tracking_cycle_1_1_to_30_days_pcnt,le.populated_payment_tracking_cycle_2_31_to_60_days_pcnt,le.populated_payment_tracking_cycle_3_61_to_90_days_pcnt,le.populated_payment_tracking_cycle_4_91_to_120_days_pcnt,le.populated_payment_tracking_cycle_5_121_to_150days_pcnt,le.populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt,le.populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt,le.populated_date_account_was_charged_off_pcnt,le.populated_amount_charged_off_by_creditor_pcnt,le.populated_charge_off_type_indicator_pcnt,le.populated_total_charge_off_recoveries_to_date_pcnt,le.populated_government_guarantee_flag_pcnt,le.populated_government_guarantee_category_pcnt,le.populated_portion_of_account_guaranteed_by_government_pcnt,le.populated_guarantors_indicator_pcnt,le.populated_number_of_guarantors_pcnt,le.populated_owners_indicator_pcnt,le.populated_number_of_principals_pcnt,le.populated_account_update_deletion_indicator_pcnt,le.populated_percent_of_liability_pcnt,le.populated_percent_of_ownership_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_timestamp,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_did,le.maxlength_did_score,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_datawarehouse_first_reported,le.maxlength_dt_datawarehouse_last_reported,le.maxlength_sbfe_contributor_number,le.maxlength_contract_account_number,le.maxlength_account_type_reported,le.maxlength_extracted_date,le.maxlength_cycle_end_date,le.maxlength_account_holder_business_name,le.maxlength_clean_account_holder_business_name,le.maxlength_dba,le.maxlength_clean_dba,le.maxlength_business_name,le.maxlength_clean_business_name,le.maxlength_company_website,le.maxlength_original_fname,le.maxlength_original_mname,le.maxlength_original_lname,le.maxlength_original_suffix,le.maxlength_e_mail_address,le.maxlength_guarantor_owner_indicator,le.maxlength_relationship_to_business_indicator,le.maxlength_business_title,le.maxlength_clean_title,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname,le.maxlength_clean_suffix,le.maxlength_original_address_line_1,le.maxlength_original_address_line_2,le.maxlength_original_city,le.maxlength_original_state,le.maxlength_original_zip_code_or_ca_postal_code,le.maxlength_original_postal_code,le.maxlength_original_country_code,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_original_area_code,le.maxlength_original_phone_number,le.maxlength_phone_extension,le.maxlength_primary_phone_indicator,le.maxlength_published_unlisted_indicator,le.maxlength_phone_type,le.maxlength_phone_number,le.maxlength_federal_taxid_ssn,le.maxlength_federal_taxid_ssn_identifier,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_persistent_record_id,le.maxlength_sbfe_id,le.maxlength_source,le.maxlength_active,le.maxlength_legal_business_structure,le.maxlength_business_established_date,le.maxlength_account_status_1,le.maxlength_account_status_2,le.maxlength_date_account_opened,le.maxlength_date_account_closed,le.maxlength_account_closure_basis,le.maxlength_account_expiration_date,le.maxlength_last_activity_date,le.maxlength_last_activity_type,le.maxlength_recent_activity_indicator,le.maxlength_original_credit_limit,le.maxlength_highest_credit_used,le.maxlength_current_credit_limit,le.maxlength_reporting_indicator_length,le.maxlength_payment_interval,le.maxlength_payment_status_category,le.maxlength_term_of_account_in_months,le.maxlength_first_payment_due_date,le.maxlength_final_payment_due_date,le.maxlength_original_rate,le.maxlength_floating_rate,le.maxlength_grace_period,le.maxlength_payment_category,le.maxlength_payment_history_profile_12_months,le.maxlength_payment_history_profile_13_24_months,le.maxlength_payment_history_profile_25_36_months,le.maxlength_payment_history_profile_37_48_months,le.maxlength_payment_history_length,le.maxlength_year_to_date_purchases_count,le.maxlength_lifetime_to_date_purchases_count,le.maxlength_year_to_date_purchases_sum_amount,le.maxlength_lifetime_to_date_purchases_sum_amount,le.maxlength_payment_amount_scheduled,le.maxlength_recent_payment_amount,le.maxlength_recent_payment_date,le.maxlength_remaining_balance,le.maxlength_carried_over_amount,le.maxlength_new_applied_charges,le.maxlength_balloon_payment_due,le.maxlength_balloon_payment_due_date,le.maxlength_delinquency_date,le.maxlength_days_delinquent,le.maxlength_past_due_amount,le.maxlength_maximum_number_of_past_due_aging_amounts_buckets_provided,le.maxlength_past_due_aging_bucket_type,le.maxlength_past_due_aging_amount_bucket_1,le.maxlength_past_due_aging_amount_bucket_2,le.maxlength_past_due_aging_amount_bucket_3,le.maxlength_past_due_aging_amount_bucket_4,le.maxlength_past_due_aging_amount_bucket_5,le.maxlength_past_due_aging_amount_bucket_6,le.maxlength_past_due_aging_amount_bucket_7,le.maxlength_maximum_number_of_payment_tracking_cycle_periods_provided,le.maxlength_payment_tracking_cycle_type,le.maxlength_payment_tracking_cycle_0_current,le.maxlength_payment_tracking_cycle_1_1_to_30_days,le.maxlength_payment_tracking_cycle_2_31_to_60_days,le.maxlength_payment_tracking_cycle_3_61_to_90_days,le.maxlength_payment_tracking_cycle_4_91_to_120_days,le.maxlength_payment_tracking_cycle_5_121_to_150days,le.maxlength_payment_tracking_number_of_times_cycle_6_151_to_180_days,le.maxlength_payment_tracking_number_of_times_cycle_7_181_or_greater_days,le.maxlength_date_account_was_charged_off,le.maxlength_amount_charged_off_by_creditor,le.maxlength_charge_off_type_indicator,le.maxlength_total_charge_off_recoveries_to_date,le.maxlength_government_guarantee_flag,le.maxlength_government_guarantee_category,le.maxlength_portion_of_account_guaranteed_by_government,le.maxlength_guarantors_indicator,le.maxlength_number_of_guarantors,le.maxlength_owners_indicator,le.maxlength_number_of_principals,le.maxlength_account_update_deletion_indicator,le.maxlength_percent_of_liability,le.maxlength_percent_of_ownership);
  SELF.avelength := CHOOSE(C,le.avelength_timestamp,le.avelength_process_date,le.avelength_record_type,le.avelength_did,le.avelength_did_score,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_datawarehouse_first_reported,le.avelength_dt_datawarehouse_last_reported,le.avelength_sbfe_contributor_number,le.avelength_contract_account_number,le.avelength_account_type_reported,le.avelength_extracted_date,le.avelength_cycle_end_date,le.avelength_account_holder_business_name,le.avelength_clean_account_holder_business_name,le.avelength_dba,le.avelength_clean_dba,le.avelength_business_name,le.avelength_clean_business_name,le.avelength_company_website,le.avelength_original_fname,le.avelength_original_mname,le.avelength_original_lname,le.avelength_original_suffix,le.avelength_e_mail_address,le.avelength_guarantor_owner_indicator,le.avelength_relationship_to_business_indicator,le.avelength_business_title,le.avelength_clean_title,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname,le.avelength_clean_suffix,le.avelength_original_address_line_1,le.avelength_original_address_line_2,le.avelength_original_city,le.avelength_original_state,le.avelength_original_zip_code_or_ca_postal_code,le.avelength_original_postal_code,le.avelength_original_country_code,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_original_area_code,le.avelength_original_phone_number,le.avelength_phone_extension,le.avelength_primary_phone_indicator,le.avelength_published_unlisted_indicator,le.avelength_phone_type,le.avelength_phone_number,le.avelength_federal_taxid_ssn,le.avelength_federal_taxid_ssn_identifier,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_persistent_record_id,le.avelength_sbfe_id,le.avelength_source,le.avelength_active,le.avelength_legal_business_structure,le.avelength_business_established_date,le.avelength_account_status_1,le.avelength_account_status_2,le.avelength_date_account_opened,le.avelength_date_account_closed,le.avelength_account_closure_basis,le.avelength_account_expiration_date,le.avelength_last_activity_date,le.avelength_last_activity_type,le.avelength_recent_activity_indicator,le.avelength_original_credit_limit,le.avelength_highest_credit_used,le.avelength_current_credit_limit,le.avelength_reporting_indicator_length,le.avelength_payment_interval,le.avelength_payment_status_category,le.avelength_term_of_account_in_months,le.avelength_first_payment_due_date,le.avelength_final_payment_due_date,le.avelength_original_rate,le.avelength_floating_rate,le.avelength_grace_period,le.avelength_payment_category,le.avelength_payment_history_profile_12_months,le.avelength_payment_history_profile_13_24_months,le.avelength_payment_history_profile_25_36_months,le.avelength_payment_history_profile_37_48_months,le.avelength_payment_history_length,le.avelength_year_to_date_purchases_count,le.avelength_lifetime_to_date_purchases_count,le.avelength_year_to_date_purchases_sum_amount,le.avelength_lifetime_to_date_purchases_sum_amount,le.avelength_payment_amount_scheduled,le.avelength_recent_payment_amount,le.avelength_recent_payment_date,le.avelength_remaining_balance,le.avelength_carried_over_amount,le.avelength_new_applied_charges,le.avelength_balloon_payment_due,le.avelength_balloon_payment_due_date,le.avelength_delinquency_date,le.avelength_days_delinquent,le.avelength_past_due_amount,le.avelength_maximum_number_of_past_due_aging_amounts_buckets_provided,le.avelength_past_due_aging_bucket_type,le.avelength_past_due_aging_amount_bucket_1,le.avelength_past_due_aging_amount_bucket_2,le.avelength_past_due_aging_amount_bucket_3,le.avelength_past_due_aging_amount_bucket_4,le.avelength_past_due_aging_amount_bucket_5,le.avelength_past_due_aging_amount_bucket_6,le.avelength_past_due_aging_amount_bucket_7,le.avelength_maximum_number_of_payment_tracking_cycle_periods_provided,le.avelength_payment_tracking_cycle_type,le.avelength_payment_tracking_cycle_0_current,le.avelength_payment_tracking_cycle_1_1_to_30_days,le.avelength_payment_tracking_cycle_2_31_to_60_days,le.avelength_payment_tracking_cycle_3_61_to_90_days,le.avelength_payment_tracking_cycle_4_91_to_120_days,le.avelength_payment_tracking_cycle_5_121_to_150days,le.avelength_payment_tracking_number_of_times_cycle_6_151_to_180_days,le.avelength_payment_tracking_number_of_times_cycle_7_181_or_greater_days,le.avelength_date_account_was_charged_off,le.avelength_amount_charged_off_by_creditor,le.avelength_charge_off_type_indicator,le.avelength_total_charge_off_recoveries_to_date,le.avelength_government_guarantee_flag,le.avelength_government_guarantee_category,le.avelength_portion_of_account_guaranteed_by_government,le.avelength_guarantors_indicator,le.avelength_number_of_guarantors,le.avelength_owners_indicator,le.avelength_number_of_principals,le.avelength_account_update_deletion_indicator,le.avelength_percent_of_liability,le.avelength_percent_of_ownership);
END;
EXPORT invSummary := NORMALIZE(summary0, 182, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.timestamp),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT33.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT33.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_datawarehouse_first_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_first_reported), ''),IF (le.dt_datawarehouse_last_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_last_reported), ''),TRIM((SALT33.StrType)le.sbfe_contributor_number),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.extracted_date),TRIM((SALT33.StrType)le.cycle_end_date),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.clean_account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.clean_dba),TRIM((SALT33.StrType)le.business_name),TRIM((SALT33.StrType)le.clean_business_name),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.original_fname),TRIM((SALT33.StrType)le.original_mname),TRIM((SALT33.StrType)le.original_lname),TRIM((SALT33.StrType)le.original_suffix),TRIM((SALT33.StrType)le.e_mail_address),TRIM((SALT33.StrType)le.guarantor_owner_indicator),TRIM((SALT33.StrType)le.relationship_to_business_indicator),TRIM((SALT33.StrType)le.business_title),TRIM((SALT33.StrType)le.clean_title),TRIM((SALT33.StrType)le.clean_fname),TRIM((SALT33.StrType)le.clean_mname),TRIM((SALT33.StrType)le.clean_lname),TRIM((SALT33.StrType)le.clean_suffix),TRIM((SALT33.StrType)le.original_address_line_1),TRIM((SALT33.StrType)le.original_address_line_2),TRIM((SALT33.StrType)le.original_city),TRIM((SALT33.StrType)le.original_state),TRIM((SALT33.StrType)le.original_zip_code_or_ca_postal_code),TRIM((SALT33.StrType)le.original_postal_code),TRIM((SALT33.StrType)le.original_country_code),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.original_area_code),TRIM((SALT33.StrType)le.original_phone_number),TRIM((SALT33.StrType)le.phone_extension),TRIM((SALT33.StrType)le.primary_phone_indicator),TRIM((SALT33.StrType)le.published_unlisted_indicator),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_number),TRIM((SALT33.StrType)le.federal_taxid_ssn),TRIM((SALT33.StrType)le.federal_taxid_ssn_identifier),IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.persistent_record_id <> 0,TRIM((SALT33.StrType)le.persistent_record_id), ''),IF (le.sbfe_id <> 0,TRIM((SALT33.StrType)le.sbfe_id), ''),TRIM((SALT33.StrType)le.source),TRIM((SALT33.StrType)le.active),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator),TRIM((SALT33.StrType)le.percent_of_liability),TRIM((SALT33.StrType)le.percent_of_ownership)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,182,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 182);
  SELF.FldNo2 := 1 + (C % 182);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.timestamp),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT33.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT33.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_datawarehouse_first_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_first_reported), ''),IF (le.dt_datawarehouse_last_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_last_reported), ''),TRIM((SALT33.StrType)le.sbfe_contributor_number),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.extracted_date),TRIM((SALT33.StrType)le.cycle_end_date),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.clean_account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.clean_dba),TRIM((SALT33.StrType)le.business_name),TRIM((SALT33.StrType)le.clean_business_name),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.original_fname),TRIM((SALT33.StrType)le.original_mname),TRIM((SALT33.StrType)le.original_lname),TRIM((SALT33.StrType)le.original_suffix),TRIM((SALT33.StrType)le.e_mail_address),TRIM((SALT33.StrType)le.guarantor_owner_indicator),TRIM((SALT33.StrType)le.relationship_to_business_indicator),TRIM((SALT33.StrType)le.business_title),TRIM((SALT33.StrType)le.clean_title),TRIM((SALT33.StrType)le.clean_fname),TRIM((SALT33.StrType)le.clean_mname),TRIM((SALT33.StrType)le.clean_lname),TRIM((SALT33.StrType)le.clean_suffix),TRIM((SALT33.StrType)le.original_address_line_1),TRIM((SALT33.StrType)le.original_address_line_2),TRIM((SALT33.StrType)le.original_city),TRIM((SALT33.StrType)le.original_state),TRIM((SALT33.StrType)le.original_zip_code_or_ca_postal_code),TRIM((SALT33.StrType)le.original_postal_code),TRIM((SALT33.StrType)le.original_country_code),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.original_area_code),TRIM((SALT33.StrType)le.original_phone_number),TRIM((SALT33.StrType)le.phone_extension),TRIM((SALT33.StrType)le.primary_phone_indicator),TRIM((SALT33.StrType)le.published_unlisted_indicator),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_number),TRIM((SALT33.StrType)le.federal_taxid_ssn),TRIM((SALT33.StrType)le.federal_taxid_ssn_identifier),IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.persistent_record_id <> 0,TRIM((SALT33.StrType)le.persistent_record_id), ''),IF (le.sbfe_id <> 0,TRIM((SALT33.StrType)le.sbfe_id), ''),TRIM((SALT33.StrType)le.source),TRIM((SALT33.StrType)le.active),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator),TRIM((SALT33.StrType)le.percent_of_liability),TRIM((SALT33.StrType)le.percent_of_ownership)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.timestamp),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT33.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT33.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_datawarehouse_first_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_first_reported), ''),IF (le.dt_datawarehouse_last_reported <> 0,TRIM((SALT33.StrType)le.dt_datawarehouse_last_reported), ''),TRIM((SALT33.StrType)le.sbfe_contributor_number),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.extracted_date),TRIM((SALT33.StrType)le.cycle_end_date),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.clean_account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.clean_dba),TRIM((SALT33.StrType)le.business_name),TRIM((SALT33.StrType)le.clean_business_name),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.original_fname),TRIM((SALT33.StrType)le.original_mname),TRIM((SALT33.StrType)le.original_lname),TRIM((SALT33.StrType)le.original_suffix),TRIM((SALT33.StrType)le.e_mail_address),TRIM((SALT33.StrType)le.guarantor_owner_indicator),TRIM((SALT33.StrType)le.relationship_to_business_indicator),TRIM((SALT33.StrType)le.business_title),TRIM((SALT33.StrType)le.clean_title),TRIM((SALT33.StrType)le.clean_fname),TRIM((SALT33.StrType)le.clean_mname),TRIM((SALT33.StrType)le.clean_lname),TRIM((SALT33.StrType)le.clean_suffix),TRIM((SALT33.StrType)le.original_address_line_1),TRIM((SALT33.StrType)le.original_address_line_2),TRIM((SALT33.StrType)le.original_city),TRIM((SALT33.StrType)le.original_state),TRIM((SALT33.StrType)le.original_zip_code_or_ca_postal_code),TRIM((SALT33.StrType)le.original_postal_code),TRIM((SALT33.StrType)le.original_country_code),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.original_area_code),TRIM((SALT33.StrType)le.original_phone_number),TRIM((SALT33.StrType)le.phone_extension),TRIM((SALT33.StrType)le.primary_phone_indicator),TRIM((SALT33.StrType)le.published_unlisted_indicator),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_number),TRIM((SALT33.StrType)le.federal_taxid_ssn),TRIM((SALT33.StrType)le.federal_taxid_ssn_identifier),IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.persistent_record_id <> 0,TRIM((SALT33.StrType)le.persistent_record_id), ''),IF (le.sbfe_id <> 0,TRIM((SALT33.StrType)le.sbfe_id), ''),TRIM((SALT33.StrType)le.source),TRIM((SALT33.StrType)le.active),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator),TRIM((SALT33.StrType)le.percent_of_liability),TRIM((SALT33.StrType)le.percent_of_ownership)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),182*182,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'timestamp'}
      ,{2,'process_date'}
      ,{3,'record_type'}
      ,{4,'did'}
      ,{5,'did_score'}
      ,{6,'dt_first_seen'}
      ,{7,'dt_last_seen'}
      ,{8,'dt_vendor_first_reported'}
      ,{9,'dt_vendor_last_reported'}
      ,{10,'dt_datawarehouse_first_reported'}
      ,{11,'dt_datawarehouse_last_reported'}
      ,{12,'sbfe_contributor_number'}
      ,{13,'contract_account_number'}
      ,{14,'account_type_reported'}
      ,{15,'extracted_date'}
      ,{16,'cycle_end_date'}
      ,{17,'account_holder_business_name'}
      ,{18,'clean_account_holder_business_name'}
      ,{19,'dba'}
      ,{20,'clean_dba'}
      ,{21,'business_name'}
      ,{22,'clean_business_name'}
      ,{23,'company_website'}
      ,{24,'original_fname'}
      ,{25,'original_mname'}
      ,{26,'original_lname'}
      ,{27,'original_suffix'}
      ,{28,'e_mail_address'}
      ,{29,'guarantor_owner_indicator'}
      ,{30,'relationship_to_business_indicator'}
      ,{31,'business_title'}
      ,{32,'clean_title'}
      ,{33,'clean_fname'}
      ,{34,'clean_mname'}
      ,{35,'clean_lname'}
      ,{36,'clean_suffix'}
      ,{37,'original_address_line_1'}
      ,{38,'original_address_line_2'}
      ,{39,'original_city'}
      ,{40,'original_state'}
      ,{41,'original_zip_code_or_ca_postal_code'}
      ,{42,'original_postal_code'}
      ,{43,'original_country_code'}
      ,{44,'prim_range'}
      ,{45,'predir'}
      ,{46,'prim_name'}
      ,{47,'addr_suffix'}
      ,{48,'postdir'}
      ,{49,'unit_desig'}
      ,{50,'sec_range'}
      ,{51,'p_city_name'}
      ,{52,'v_city_name'}
      ,{53,'st'}
      ,{54,'zip'}
      ,{55,'zip4'}
      ,{56,'cart'}
      ,{57,'cr_sort_sz'}
      ,{58,'lot'}
      ,{59,'lot_order'}
      ,{60,'dbpc'}
      ,{61,'chk_digit'}
      ,{62,'rec_type'}
      ,{63,'fips_state'}
      ,{64,'fips_county'}
      ,{65,'geo_lat'}
      ,{66,'geo_long'}
      ,{67,'msa'}
      ,{68,'geo_blk'}
      ,{69,'geo_match'}
      ,{70,'err_stat'}
      ,{71,'rawaid'}
      ,{72,'original_area_code'}
      ,{73,'original_phone_number'}
      ,{74,'phone_extension'}
      ,{75,'primary_phone_indicator'}
      ,{76,'published_unlisted_indicator'}
      ,{77,'phone_type'}
      ,{78,'phone_number'}
      ,{79,'federal_taxid_ssn'}
      ,{80,'federal_taxid_ssn_identifier'}
      ,{81,'dotid'}
      ,{82,'dotscore'}
      ,{83,'dotweight'}
      ,{84,'empid'}
      ,{85,'empscore'}
      ,{86,'empweight'}
      ,{87,'powid'}
      ,{88,'powscore'}
      ,{89,'powweight'}
      ,{90,'proxid'}
      ,{91,'proxscore'}
      ,{92,'proxweight'}
      ,{93,'seleid'}
      ,{94,'selescore'}
      ,{95,'seleweight'}
      ,{96,'orgid'}
      ,{97,'orgscore'}
      ,{98,'orgweight'}
      ,{99,'ultid'}
      ,{100,'ultscore'}
      ,{101,'ultweight'}
      ,{102,'persistent_record_id'}
      ,{103,'sbfe_id'}
      ,{104,'source'}
      ,{105,'active'}
      ,{106,'legal_business_structure'}
      ,{107,'business_established_date'}
      ,{108,'account_status_1'}
      ,{109,'account_status_2'}
      ,{110,'date_account_opened'}
      ,{111,'date_account_closed'}
      ,{112,'account_closure_basis'}
      ,{113,'account_expiration_date'}
      ,{114,'last_activity_date'}
      ,{115,'last_activity_type'}
      ,{116,'recent_activity_indicator'}
      ,{117,'original_credit_limit'}
      ,{118,'highest_credit_used'}
      ,{119,'current_credit_limit'}
      ,{120,'reporting_indicator_length'}
      ,{121,'payment_interval'}
      ,{122,'payment_status_category'}
      ,{123,'term_of_account_in_months'}
      ,{124,'first_payment_due_date'}
      ,{125,'final_payment_due_date'}
      ,{126,'original_rate'}
      ,{127,'floating_rate'}
      ,{128,'grace_period'}
      ,{129,'payment_category'}
      ,{130,'payment_history_profile_12_months'}
      ,{131,'payment_history_profile_13_24_months'}
      ,{132,'payment_history_profile_25_36_months'}
      ,{133,'payment_history_profile_37_48_months'}
      ,{134,'payment_history_length'}
      ,{135,'year_to_date_purchases_count'}
      ,{136,'lifetime_to_date_purchases_count'}
      ,{137,'year_to_date_purchases_sum_amount'}
      ,{138,'lifetime_to_date_purchases_sum_amount'}
      ,{139,'payment_amount_scheduled'}
      ,{140,'recent_payment_amount'}
      ,{141,'recent_payment_date'}
      ,{142,'remaining_balance'}
      ,{143,'carried_over_amount'}
      ,{144,'new_applied_charges'}
      ,{145,'balloon_payment_due'}
      ,{146,'balloon_payment_due_date'}
      ,{147,'delinquency_date'}
      ,{148,'days_delinquent'}
      ,{149,'past_due_amount'}
      ,{150,'maximum_number_of_past_due_aging_amounts_buckets_provided'}
      ,{151,'past_due_aging_bucket_type'}
      ,{152,'past_due_aging_amount_bucket_1'}
      ,{153,'past_due_aging_amount_bucket_2'}
      ,{154,'past_due_aging_amount_bucket_3'}
      ,{155,'past_due_aging_amount_bucket_4'}
      ,{156,'past_due_aging_amount_bucket_5'}
      ,{157,'past_due_aging_amount_bucket_6'}
      ,{158,'past_due_aging_amount_bucket_7'}
      ,{159,'maximum_number_of_payment_tracking_cycle_periods_provided'}
      ,{160,'payment_tracking_cycle_type'}
      ,{161,'payment_tracking_cycle_0_current'}
      ,{162,'payment_tracking_cycle_1_1_to_30_days'}
      ,{163,'payment_tracking_cycle_2_31_to_60_days'}
      ,{164,'payment_tracking_cycle_3_61_to_90_days'}
      ,{165,'payment_tracking_cycle_4_91_to_120_days'}
      ,{166,'payment_tracking_cycle_5_121_to_150days'}
      ,{167,'payment_tracking_number_of_times_cycle_6_151_to_180_days'}
      ,{168,'payment_tracking_number_of_times_cycle_7_181_or_greater_days'}
      ,{169,'date_account_was_charged_off'}
      ,{170,'amount_charged_off_by_creditor'}
      ,{171,'charge_off_type_indicator'}
      ,{172,'total_charge_off_recoveries_to_date'}
      ,{173,'government_guarantee_flag'}
      ,{174,'government_guarantee_category'}
      ,{175,'portion_of_account_guaranteed_by_government'}
      ,{176,'guarantors_indicator'}
      ,{177,'number_of_guarantors'}
      ,{178,'owners_indicator'}
      ,{179,'number_of_principals'}
      ,{180,'account_update_deletion_indicator'}
      ,{181,'percent_of_liability'}
      ,{182,'percent_of_ownership'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    LinkID_Fields.InValid_timestamp((SALT33.StrType)le.timestamp),
    LinkID_Fields.InValid_process_date((SALT33.StrType)le.process_date),
    LinkID_Fields.InValid_record_type((SALT33.StrType)le.record_type),
    LinkID_Fields.InValid_did((SALT33.StrType)le.did),
    LinkID_Fields.InValid_did_score((SALT33.StrType)le.did_score),
    LinkID_Fields.InValid_dt_first_seen((SALT33.StrType)le.dt_first_seen),
    LinkID_Fields.InValid_dt_last_seen((SALT33.StrType)le.dt_last_seen),
    LinkID_Fields.InValid_dt_vendor_first_reported((SALT33.StrType)le.dt_vendor_first_reported),
    LinkID_Fields.InValid_dt_vendor_last_reported((SALT33.StrType)le.dt_vendor_last_reported),
    LinkID_Fields.InValid_dt_datawarehouse_first_reported((SALT33.StrType)le.dt_datawarehouse_first_reported),
    LinkID_Fields.InValid_dt_datawarehouse_last_reported((SALT33.StrType)le.dt_datawarehouse_last_reported),
    LinkID_Fields.InValid_sbfe_contributor_number((SALT33.StrType)le.sbfe_contributor_number),
    LinkID_Fields.InValid_contract_account_number((SALT33.StrType)le.contract_account_number),
    LinkID_Fields.InValid_account_type_reported((SALT33.StrType)le.account_type_reported),
    LinkID_Fields.InValid_extracted_date((SALT33.StrType)le.extracted_date),
    LinkID_Fields.InValid_cycle_end_date((SALT33.StrType)le.cycle_end_date),
    LinkID_Fields.InValid_account_holder_business_name((SALT33.StrType)le.account_holder_business_name),
    LinkID_Fields.InValid_clean_account_holder_business_name((SALT33.StrType)le.clean_account_holder_business_name),
    LinkID_Fields.InValid_dba((SALT33.StrType)le.dba),
    LinkID_Fields.InValid_clean_dba((SALT33.StrType)le.clean_dba),
    LinkID_Fields.InValid_business_name((SALT33.StrType)le.business_name),
    LinkID_Fields.InValid_clean_business_name((SALT33.StrType)le.clean_business_name),
    LinkID_Fields.InValid_company_website((SALT33.StrType)le.company_website),
    LinkID_Fields.InValid_original_fname((SALT33.StrType)le.original_fname),
    LinkID_Fields.InValid_original_mname((SALT33.StrType)le.original_mname),
    LinkID_Fields.InValid_original_lname((SALT33.StrType)le.original_lname),
    LinkID_Fields.InValid_original_suffix((SALT33.StrType)le.original_suffix),
    LinkID_Fields.InValid_e_mail_address((SALT33.StrType)le.e_mail_address),
    LinkID_Fields.InValid_guarantor_owner_indicator((SALT33.StrType)le.guarantor_owner_indicator),
    LinkID_Fields.InValid_relationship_to_business_indicator((SALT33.StrType)le.relationship_to_business_indicator),
    LinkID_Fields.InValid_business_title((SALT33.StrType)le.business_title),
    LinkID_Fields.InValid_clean_title((SALT33.StrType)le.clean_title),
    LinkID_Fields.InValid_clean_fname((SALT33.StrType)le.clean_fname),
    LinkID_Fields.InValid_clean_mname((SALT33.StrType)le.clean_mname),
    LinkID_Fields.InValid_clean_lname((SALT33.StrType)le.clean_lname),
    LinkID_Fields.InValid_clean_suffix((SALT33.StrType)le.clean_suffix),
    LinkID_Fields.InValid_original_address_line_1((SALT33.StrType)le.original_address_line_1),
    LinkID_Fields.InValid_original_address_line_2((SALT33.StrType)le.original_address_line_2),
    LinkID_Fields.InValid_original_city((SALT33.StrType)le.original_city),
    LinkID_Fields.InValid_original_state((SALT33.StrType)le.original_state),
    LinkID_Fields.InValid_original_zip_code_or_ca_postal_code((SALT33.StrType)le.original_zip_code_or_ca_postal_code),
    LinkID_Fields.InValid_original_postal_code((SALT33.StrType)le.original_postal_code),
    LinkID_Fields.InValid_original_country_code((SALT33.StrType)le.original_country_code),
    LinkID_Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    LinkID_Fields.InValid_predir((SALT33.StrType)le.predir),
    LinkID_Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    LinkID_Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    LinkID_Fields.InValid_postdir((SALT33.StrType)le.postdir),
    LinkID_Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    LinkID_Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    LinkID_Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    LinkID_Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    LinkID_Fields.InValid_st((SALT33.StrType)le.st),
    LinkID_Fields.InValid_zip((SALT33.StrType)le.zip),
    LinkID_Fields.InValid_zip4((SALT33.StrType)le.zip4),
    LinkID_Fields.InValid_cart((SALT33.StrType)le.cart),
    LinkID_Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    LinkID_Fields.InValid_lot((SALT33.StrType)le.lot),
    LinkID_Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    LinkID_Fields.InValid_dbpc((SALT33.StrType)le.dbpc),
    LinkID_Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    LinkID_Fields.InValid_rec_type((SALT33.StrType)le.rec_type),
    LinkID_Fields.InValid_fips_state((SALT33.StrType)le.fips_state),
    LinkID_Fields.InValid_fips_county((SALT33.StrType)le.fips_county),
    LinkID_Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    LinkID_Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    LinkID_Fields.InValid_msa((SALT33.StrType)le.msa),
    LinkID_Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    LinkID_Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    LinkID_Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    LinkID_Fields.InValid_rawaid((SALT33.StrType)le.rawaid),
    LinkID_Fields.InValid_original_area_code((SALT33.StrType)le.original_area_code),
    LinkID_Fields.InValid_original_phone_number((SALT33.StrType)le.original_phone_number),
    LinkID_Fields.InValid_phone_extension((SALT33.StrType)le.phone_extension),
    LinkID_Fields.InValid_primary_phone_indicator((SALT33.StrType)le.primary_phone_indicator),
    LinkID_Fields.InValid_published_unlisted_indicator((SALT33.StrType)le.published_unlisted_indicator),
    LinkID_Fields.InValid_phone_type((SALT33.StrType)le.phone_type),
    LinkID_Fields.InValid_phone_number((SALT33.StrType)le.phone_number),
    LinkID_Fields.InValid_federal_taxid_ssn((SALT33.StrType)le.federal_taxid_ssn),
    LinkID_Fields.InValid_federal_taxid_ssn_identifier((SALT33.StrType)le.federal_taxid_ssn_identifier),
    LinkID_Fields.InValid_dotid((SALT33.StrType)le.dotid),
    LinkID_Fields.InValid_dotscore((SALT33.StrType)le.dotscore),
    LinkID_Fields.InValid_dotweight((SALT33.StrType)le.dotweight),
    LinkID_Fields.InValid_empid((SALT33.StrType)le.empid),
    LinkID_Fields.InValid_empscore((SALT33.StrType)le.empscore),
    LinkID_Fields.InValid_empweight((SALT33.StrType)le.empweight),
    LinkID_Fields.InValid_powid((SALT33.StrType)le.powid),
    LinkID_Fields.InValid_powscore((SALT33.StrType)le.powscore),
    LinkID_Fields.InValid_powweight((SALT33.StrType)le.powweight),
    LinkID_Fields.InValid_proxid((SALT33.StrType)le.proxid),
    LinkID_Fields.InValid_proxscore((SALT33.StrType)le.proxscore),
    LinkID_Fields.InValid_proxweight((SALT33.StrType)le.proxweight),
    LinkID_Fields.InValid_seleid((SALT33.StrType)le.seleid),
    LinkID_Fields.InValid_selescore((SALT33.StrType)le.selescore),
    LinkID_Fields.InValid_seleweight((SALT33.StrType)le.seleweight),
    LinkID_Fields.InValid_orgid((SALT33.StrType)le.orgid),
    LinkID_Fields.InValid_orgscore((SALT33.StrType)le.orgscore),
    LinkID_Fields.InValid_orgweight((SALT33.StrType)le.orgweight),
    LinkID_Fields.InValid_ultid((SALT33.StrType)le.ultid),
    LinkID_Fields.InValid_ultscore((SALT33.StrType)le.ultscore),
    LinkID_Fields.InValid_ultweight((SALT33.StrType)le.ultweight),
    LinkID_Fields.InValid_persistent_record_id((SALT33.StrType)le.persistent_record_id),
    LinkID_Fields.InValid_sbfe_id((SALT33.StrType)le.sbfe_id),
    LinkID_Fields.InValid_source((SALT33.StrType)le.source),
    LinkID_Fields.InValid_active((SALT33.StrType)le.active),
    LinkID_Fields.InValid_legal_business_structure((SALT33.StrType)le.legal_business_structure),
    LinkID_Fields.InValid_business_established_date((SALT33.StrType)le.business_established_date),
    LinkID_Fields.InValid_account_status_1((SALT33.StrType)le.account_status_1),
    LinkID_Fields.InValid_account_status_2((SALT33.StrType)le.account_status_2),
    LinkID_Fields.InValid_date_account_opened((SALT33.StrType)le.date_account_opened),
    LinkID_Fields.InValid_date_account_closed((SALT33.StrType)le.date_account_closed),
    LinkID_Fields.InValid_account_closure_basis((SALT33.StrType)le.account_closure_basis),
    LinkID_Fields.InValid_account_expiration_date((SALT33.StrType)le.account_expiration_date),
    LinkID_Fields.InValid_last_activity_date((SALT33.StrType)le.last_activity_date),
    LinkID_Fields.InValid_last_activity_type((SALT33.StrType)le.last_activity_type),
    LinkID_Fields.InValid_recent_activity_indicator((SALT33.StrType)le.recent_activity_indicator),
    LinkID_Fields.InValid_original_credit_limit((SALT33.StrType)le.original_credit_limit),
    LinkID_Fields.InValid_highest_credit_used((SALT33.StrType)le.highest_credit_used),
    LinkID_Fields.InValid_current_credit_limit((SALT33.StrType)le.current_credit_limit),
    LinkID_Fields.InValid_reporting_indicator_length((SALT33.StrType)le.reporting_indicator_length),
    LinkID_Fields.InValid_payment_interval((SALT33.StrType)le.payment_interval),
    LinkID_Fields.InValid_payment_status_category((SALT33.StrType)le.payment_status_category),
    LinkID_Fields.InValid_term_of_account_in_months((SALT33.StrType)le.term_of_account_in_months),
    LinkID_Fields.InValid_first_payment_due_date((SALT33.StrType)le.first_payment_due_date),
    LinkID_Fields.InValid_final_payment_due_date((SALT33.StrType)le.final_payment_due_date),
    LinkID_Fields.InValid_original_rate((SALT33.StrType)le.original_rate),
    LinkID_Fields.InValid_floating_rate((SALT33.StrType)le.floating_rate),
    LinkID_Fields.InValid_grace_period((SALT33.StrType)le.grace_period),
    LinkID_Fields.InValid_payment_category((SALT33.StrType)le.payment_category),
    LinkID_Fields.InValid_payment_history_profile_12_months((SALT33.StrType)le.payment_history_profile_12_months),
    LinkID_Fields.InValid_payment_history_profile_13_24_months((SALT33.StrType)le.payment_history_profile_13_24_months),
    LinkID_Fields.InValid_payment_history_profile_25_36_months((SALT33.StrType)le.payment_history_profile_25_36_months),
    LinkID_Fields.InValid_payment_history_profile_37_48_months((SALT33.StrType)le.payment_history_profile_37_48_months),
    LinkID_Fields.InValid_payment_history_length((SALT33.StrType)le.payment_history_length),
    LinkID_Fields.InValid_year_to_date_purchases_count((SALT33.StrType)le.year_to_date_purchases_count),
    LinkID_Fields.InValid_lifetime_to_date_purchases_count((SALT33.StrType)le.lifetime_to_date_purchases_count),
    LinkID_Fields.InValid_year_to_date_purchases_sum_amount((SALT33.StrType)le.year_to_date_purchases_sum_amount),
    LinkID_Fields.InValid_lifetime_to_date_purchases_sum_amount((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),
    LinkID_Fields.InValid_payment_amount_scheduled((SALT33.StrType)le.payment_amount_scheduled),
    LinkID_Fields.InValid_recent_payment_amount((SALT33.StrType)le.recent_payment_amount),
    LinkID_Fields.InValid_recent_payment_date((SALT33.StrType)le.recent_payment_date),
    LinkID_Fields.InValid_remaining_balance((SALT33.StrType)le.remaining_balance),
    LinkID_Fields.InValid_carried_over_amount((SALT33.StrType)le.carried_over_amount),
    LinkID_Fields.InValid_new_applied_charges((SALT33.StrType)le.new_applied_charges),
    LinkID_Fields.InValid_balloon_payment_due((SALT33.StrType)le.balloon_payment_due),
    LinkID_Fields.InValid_balloon_payment_due_date((SALT33.StrType)le.balloon_payment_due_date),
    LinkID_Fields.InValid_delinquency_date((SALT33.StrType)le.delinquency_date),
    LinkID_Fields.InValid_days_delinquent((SALT33.StrType)le.days_delinquent),
    LinkID_Fields.InValid_past_due_amount((SALT33.StrType)le.past_due_amount),
    LinkID_Fields.InValid_maximum_number_of_past_due_aging_amounts_buckets_provided((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),
    LinkID_Fields.InValid_past_due_aging_bucket_type((SALT33.StrType)le.past_due_aging_bucket_type),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_1((SALT33.StrType)le.past_due_aging_amount_bucket_1),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_2((SALT33.StrType)le.past_due_aging_amount_bucket_2),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_3((SALT33.StrType)le.past_due_aging_amount_bucket_3),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_4((SALT33.StrType)le.past_due_aging_amount_bucket_4),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_5((SALT33.StrType)le.past_due_aging_amount_bucket_5),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_6((SALT33.StrType)le.past_due_aging_amount_bucket_6),
    LinkID_Fields.InValid_past_due_aging_amount_bucket_7((SALT33.StrType)le.past_due_aging_amount_bucket_7),
    LinkID_Fields.InValid_maximum_number_of_payment_tracking_cycle_periods_provided((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),
    LinkID_Fields.InValid_payment_tracking_cycle_type((SALT33.StrType)le.payment_tracking_cycle_type),
    LinkID_Fields.InValid_payment_tracking_cycle_0_current((SALT33.StrType)le.payment_tracking_cycle_0_current),
    LinkID_Fields.InValid_payment_tracking_cycle_1_1_to_30_days((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),
    LinkID_Fields.InValid_payment_tracking_cycle_2_31_to_60_days((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),
    LinkID_Fields.InValid_payment_tracking_cycle_3_61_to_90_days((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),
    LinkID_Fields.InValid_payment_tracking_cycle_4_91_to_120_days((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),
    LinkID_Fields.InValid_payment_tracking_cycle_5_121_to_150days((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),
    LinkID_Fields.InValid_payment_tracking_number_of_times_cycle_6_151_to_180_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),
    LinkID_Fields.InValid_payment_tracking_number_of_times_cycle_7_181_or_greater_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),
    LinkID_Fields.InValid_date_account_was_charged_off((SALT33.StrType)le.date_account_was_charged_off),
    LinkID_Fields.InValid_amount_charged_off_by_creditor((SALT33.StrType)le.amount_charged_off_by_creditor),
    LinkID_Fields.InValid_charge_off_type_indicator((SALT33.StrType)le.charge_off_type_indicator),
    LinkID_Fields.InValid_total_charge_off_recoveries_to_date((SALT33.StrType)le.total_charge_off_recoveries_to_date),
    LinkID_Fields.InValid_government_guarantee_flag((SALT33.StrType)le.government_guarantee_flag),
    LinkID_Fields.InValid_government_guarantee_category((SALT33.StrType)le.government_guarantee_category),
    LinkID_Fields.InValid_portion_of_account_guaranteed_by_government((SALT33.StrType)le.portion_of_account_guaranteed_by_government),
    LinkID_Fields.InValid_guarantors_indicator((SALT33.StrType)le.guarantors_indicator),
    LinkID_Fields.InValid_number_of_guarantors((SALT33.StrType)le.number_of_guarantors),
    LinkID_Fields.InValid_owners_indicator((SALT33.StrType)le.owners_indicator),
    LinkID_Fields.InValid_number_of_principals((SALT33.StrType)le.number_of_principals),
    LinkID_Fields.InValid_account_update_deletion_indicator((SALT33.StrType)le.account_update_deletion_indicator),
    LinkID_Fields.InValid_percent_of_liability((SALT33.StrType)le.percent_of_liability),
    LinkID_Fields.InValid_percent_of_ownership((SALT33.StrType)le.percent_of_ownership),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,182,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := LinkID_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_timestamp','invalid_process_date','invalid_invalid_record_type','invalid_did','invalid_did_score','invalid_dt_first_seen','invalid_dt_last_seen','invalid_dt_vendor_first_reported','invalid_dt_vendor_last_reported','invalid_dt_datawarehouse_first_reported','invalid_dt_datawarehouse_last_reported','invalid_sbfe_contributor_num','invalid_contractacc_num','Unknown','invalid_extracted_date','invalid_cycleend_date','invalid_accholder_businessname','invalid_cln_accholder_businessname','invalid_dba','invalid_cln_dba','invalid_business_name','invalid_cln_business_name','invalid_comp_website','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_cln_title','invalid_cln_fname','invalid_cln_mname','invalid_cln_lname','invalid_cln_suffix','invalid_orig_address_line_1','invalid_orig_address_line_2','invalid_orig_city','invalid_orig_state','invalid_orig_zip_code_or_ca_postal_code','invalid_orig_postal_code','invalid_orig_country_code','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_st','invalid_zip','invalid_zip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_orig_area_code','invalid_orig_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype','invalid_phonenumber','invalid_federal_tax_id_ssn','invalid_federal_tax_id_ssn_identifier','invalid_dotid','invalid_dotscore','invalid_dotweight','invalid_empid','invalid_empscore','invalid_empweight','invalid_powid','invalid_powscore','invalid_powweight','invalid_proxid','invalid_proxscore','invalid_proxweight','invalid_seleid','invalid_selescore','invalid_seleweight','invalid_orgid','invalid_orgscore','invalid_orgweight','invalid_ultid','invalid_ultscore','invalid_ultweight','Unknown','invalid_sbfe_id','Unknown','Unknown','invalid_legal_busi_structure','invalid_busi_established_date','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_origrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_number_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_maximum_number_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_num','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator','invalid_percent','invalid_percent');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,LinkID_Fields.InValidMessage_timestamp(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_did(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_datawarehouse_first_reported(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dt_datawarehouse_last_reported(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_sbfe_contributor_number(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_contract_account_number(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_type_reported(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_extracted_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_cycle_end_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_holder_business_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_account_holder_business_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dba(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_dba(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_business_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_company_website(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_fname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_mname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_lname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_suffix(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_e_mail_address(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_guarantor_owner_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_relationship_to_business_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_business_title(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_title(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_clean_suffix(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_address_line_1(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_address_line_2(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_city(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_state(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_zip_code_or_ca_postal_code(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_postal_code(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_country_code(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_predir(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_st(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_zip(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_cart(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_lot(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_msa(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_area_code(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_phone_number(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_phone_extension(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_primary_phone_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_published_unlisted_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_federal_taxid_ssn(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_federal_taxid_ssn_identifier(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_empid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_powid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_sbfe_id(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_source(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_active(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_legal_business_structure(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_business_established_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_status_1(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_status_2(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_date_account_opened(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_date_account_closed(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_closure_basis(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_expiration_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_last_activity_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_last_activity_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_recent_activity_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_credit_limit(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_highest_credit_used(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_current_credit_limit(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_reporting_indicator_length(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_interval(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_status_category(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_term_of_account_in_months(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_first_payment_due_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_final_payment_due_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_original_rate(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_floating_rate(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_grace_period(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_category(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_history_profile_12_months(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_history_profile_13_24_months(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_history_profile_25_36_months(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_history_profile_37_48_months(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_history_length(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_year_to_date_purchases_count(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_lifetime_to_date_purchases_count(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_year_to_date_purchases_sum_amount(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_lifetime_to_date_purchases_sum_amount(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_amount_scheduled(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_recent_payment_amount(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_recent_payment_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_remaining_balance(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_carried_over_amount(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_new_applied_charges(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_balloon_payment_due(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_balloon_payment_due_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_delinquency_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_days_delinquent(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_amount(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_bucket_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_1(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_2(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_3(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_4(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_5(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_6(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_past_due_aging_amount_bucket_7(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_type(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_0_current(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_1_1_to_30_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_2_31_to_60_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_3_61_to_90_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_4_91_to_120_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_cycle_5_121_to_150days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_date_account_was_charged_off(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_amount_charged_off_by_creditor(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_charge_off_type_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_total_charge_off_recoveries_to_date(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_government_guarantee_flag(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_government_guarantee_category(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_portion_of_account_guaranteed_by_government(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_guarantors_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_number_of_guarantors(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_owners_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_number_of_principals(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_account_update_deletion_indicator(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_percent_of_liability(TotalErrors.ErrorNum),LinkID_Fields.InValidMessage_percent_of_ownership(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
