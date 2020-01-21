IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_BASE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_company_name_pcnt := AVE(GROUP,IF(h.dt_first_seen_company_name = (TYPEOF(h.dt_first_seen_company_name))'',0,100));
    maxlength_dt_first_seen_company_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_company_name)));
    avelength_dt_first_seen_company_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_company_name)),h.dt_first_seen_company_name<>(typeof(h.dt_first_seen_company_name))'');
    populated_dt_last_seen_company_name_pcnt := AVE(GROUP,IF(h.dt_last_seen_company_name = (TYPEOF(h.dt_last_seen_company_name))'',0,100));
    maxlength_dt_last_seen_company_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_company_name)));
    avelength_dt_last_seen_company_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_company_name)),h.dt_last_seen_company_name<>(typeof(h.dt_last_seen_company_name))'');
    populated_dt_first_seen_company_address_pcnt := AVE(GROUP,IF(h.dt_first_seen_company_address = (TYPEOF(h.dt_first_seen_company_address))'',0,100));
    maxlength_dt_first_seen_company_address := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_company_address)));
    avelength_dt_first_seen_company_address := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_company_address)),h.dt_first_seen_company_address<>(typeof(h.dt_first_seen_company_address))'');
    populated_dt_last_seen_company_address_pcnt := AVE(GROUP,IF(h.dt_last_seen_company_address = (TYPEOF(h.dt_last_seen_company_address))'',0,100));
    maxlength_dt_last_seen_company_address := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_company_address)));
    avelength_dt_last_seen_company_address := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_company_address)),h.dt_last_seen_company_address<>(typeof(h.dt_last_seen_company_address))'');
    populated_dt_first_seen_contact_pcnt := AVE(GROUP,IF(h.dt_first_seen_contact = (TYPEOF(h.dt_first_seen_contact))'',0,100));
    maxlength_dt_first_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_contact)));
    avelength_dt_first_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen_contact)),h.dt_first_seen_contact<>(typeof(h.dt_first_seen_contact))'');
    populated_dt_last_seen_contact_pcnt := AVE(GROUP,IF(h.dt_last_seen_contact = (TYPEOF(h.dt_last_seen_contact))'',0,100));
    maxlength_dt_last_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_contact)));
    avelength_dt_last_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen_contact)),h.dt_last_seen_contact<>(typeof(h.dt_last_seen_contact))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_iscorp_pcnt := AVE(GROUP,IF(h.iscorp = (TYPEOF(h.iscorp))'',0,100));
    maxlength_iscorp := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.iscorp)));
    avelength_iscorp := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.iscorp)),h.iscorp<>(typeof(h.iscorp))'');
    populated_cnp_hasnumber_pcnt := AVE(GROUP,IF(h.cnp_hasnumber = (TYPEOF(h.cnp_hasnumber))'',0,100));
    maxlength_cnp_hasnumber := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_hasnumber)));
    avelength_cnp_hasnumber := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_hasnumber)),h.cnp_hasnumber<>(typeof(h.cnp_hasnumber))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_aceaid_pcnt := AVE(GROUP,IF(h.company_aceaid = (TYPEOF(h.company_aceaid))'',0,100));
    maxlength_company_aceaid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_aceaid)));
    avelength_company_aceaid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_aceaid)),h.company_aceaid<>(typeof(h.company_aceaid))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_dba_name_pcnt := AVE(GROUP,IF(h.dba_name = (TYPEOF(h.dba_name))'',0,100));
    maxlength_dba_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dba_name)));
    avelength_dba_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dba_name)),h.dba_name<>(typeof(h.dba_name))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_hist_enterprise_number_pcnt := AVE(GROUP,IF(h.hist_enterprise_number = (TYPEOF(h.hist_enterprise_number))'',0,100));
    maxlength_hist_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_enterprise_number)));
    avelength_hist_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_enterprise_number)),h.hist_enterprise_number<>(typeof(h.hist_enterprise_number))'');
    populated_ebr_file_number_pcnt := AVE(GROUP,IF(h.ebr_file_number = (TYPEOF(h.ebr_file_number))'',0,100));
    maxlength_ebr_file_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.ebr_file_number)));
    avelength_ebr_file_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.ebr_file_number)),h.ebr_file_number<>(typeof(h.ebr_file_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
    populated_employee_count_org_raw_pcnt := AVE(GROUP,IF(h.employee_count_org_raw = (TYPEOF(h.employee_count_org_raw))'',0,100));
    maxlength_employee_count_org_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_org_raw)));
    avelength_employee_count_org_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_org_raw)),h.employee_count_org_raw<>(typeof(h.employee_count_org_raw))'');
    populated_employee_count_org_derived_pcnt := AVE(GROUP,IF(h.employee_count_org_derived = (TYPEOF(h.employee_count_org_derived))'',0,100));
    maxlength_employee_count_org_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_org_derived)));
    avelength_employee_count_org_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_org_derived)),h.employee_count_org_derived<>(typeof(h.employee_count_org_derived))'');
    populated_revenue_org_raw_pcnt := AVE(GROUP,IF(h.revenue_org_raw = (TYPEOF(h.revenue_org_raw))'',0,100));
    maxlength_revenue_org_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_org_raw)));
    avelength_revenue_org_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_org_raw)),h.revenue_org_raw<>(typeof(h.revenue_org_raw))'');
    populated_revenue_org_derived_pcnt := AVE(GROUP,IF(h.revenue_org_derived = (TYPEOF(h.revenue_org_derived))'',0,100));
    maxlength_revenue_org_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_org_derived)));
    avelength_revenue_org_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_org_derived)),h.revenue_org_derived<>(typeof(h.revenue_org_derived))'');
    populated_employee_count_local_raw_pcnt := AVE(GROUP,IF(h.employee_count_local_raw = (TYPEOF(h.employee_count_local_raw))'',0,100));
    maxlength_employee_count_local_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_local_raw)));
    avelength_employee_count_local_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_local_raw)),h.employee_count_local_raw<>(typeof(h.employee_count_local_raw))'');
    populated_employee_count_local_derived_pcnt := AVE(GROUP,IF(h.employee_count_local_derived = (TYPEOF(h.employee_count_local_derived))'',0,100));
    maxlength_employee_count_local_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_local_derived)));
    avelength_employee_count_local_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.employee_count_local_derived)),h.employee_count_local_derived<>(typeof(h.employee_count_local_derived))'');
    populated_revenue_local_raw_pcnt := AVE(GROUP,IF(h.revenue_local_raw = (TYPEOF(h.revenue_local_raw))'',0,100));
    maxlength_revenue_local_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_local_raw)));
    avelength_revenue_local_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_local_raw)),h.revenue_local_raw<>(typeof(h.revenue_local_raw))'');
    populated_revenue_local_derived_pcnt := AVE(GROUP,IF(h.revenue_local_derived = (TYPEOF(h.revenue_local_derived))'',0,100));
    maxlength_revenue_local_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_local_derived)));
    avelength_revenue_local_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.revenue_local_derived)),h.revenue_local_derived<>(typeof(h.revenue_local_derived))'');
    populated_locid_pcnt := AVE(GROUP,IF(h.locid = (TYPEOF(h.locid))'',0,100));
    maxlength_locid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.locid)));
    avelength_locid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.locid)),h.locid<>(typeof(h.locid))'');
    populated_source_docid_pcnt := AVE(GROUP,IF(h.source_docid = (TYPEOF(h.source_docid))'',0,100));
    maxlength_source_docid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.source_docid)));
    avelength_source_docid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.source_docid)),h.source_docid<>(typeof(h.source_docid))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_name_type_raw_pcnt := AVE(GROUP,IF(h.company_name_type_raw = (TYPEOF(h.company_name_type_raw))'',0,100));
    maxlength_company_name_type_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_type_raw)));
    avelength_company_name_type_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_type_raw)),h.company_name_type_raw<>(typeof(h.company_name_type_raw))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_company_rawaid_pcnt := AVE(GROUP,IF(h.company_rawaid = (TYPEOF(h.company_rawaid))'',0,100));
    maxlength_company_rawaid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_rawaid)));
    avelength_company_rawaid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_rawaid)),h.company_rawaid<>(typeof(h.company_rawaid))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_company_address_type_raw_pcnt := AVE(GROUP,IF(h.company_address_type_raw = (TYPEOF(h.company_address_type_raw))'',0,100));
    maxlength_company_address_type_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_address_type_raw)));
    avelength_company_address_type_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_address_type_raw)),h.company_address_type_raw<>(typeof(h.company_address_type_raw))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_best_fein_indicator_pcnt := AVE(GROUP,IF(h.best_fein_indicator = (TYPEOF(h.best_fein_indicator))'',0,100));
    maxlength_best_fein_indicator := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.best_fein_indicator)));
    avelength_best_fein_indicator := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.best_fein_indicator)),h.best_fein_indicator<>(typeof(h.best_fein_indicator))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_phone_score_pcnt := AVE(GROUP,IF(h.phone_score = (TYPEOF(h.phone_score))'',0,100));
    maxlength_phone_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.phone_score)));
    avelength_phone_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.phone_score)),h.phone_score<>(typeof(h.phone_score))'');
    populated_company_org_structure_raw_pcnt := AVE(GROUP,IF(h.company_org_structure_raw = (TYPEOF(h.company_org_structure_raw))'',0,100));
    maxlength_company_org_structure_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_org_structure_raw)));
    avelength_company_org_structure_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_org_structure_raw)),h.company_org_structure_raw<>(typeof(h.company_org_structure_raw))'');
    populated_company_incorporation_date_pcnt := AVE(GROUP,IF(h.company_incorporation_date = (TYPEOF(h.company_incorporation_date))'',0,100));
    maxlength_company_incorporation_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_incorporation_date)));
    avelength_company_incorporation_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_incorporation_date)),h.company_incorporation_date<>(typeof(h.company_incorporation_date))'');
    populated_company_sic_code1_pcnt := AVE(GROUP,IF(h.company_sic_code1 = (TYPEOF(h.company_sic_code1))'',0,100));
    maxlength_company_sic_code1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code1)));
    avelength_company_sic_code1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code1)),h.company_sic_code1<>(typeof(h.company_sic_code1))'');
    populated_company_sic_code2_pcnt := AVE(GROUP,IF(h.company_sic_code2 = (TYPEOF(h.company_sic_code2))'',0,100));
    maxlength_company_sic_code2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code2)));
    avelength_company_sic_code2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code2)),h.company_sic_code2<>(typeof(h.company_sic_code2))'');
    populated_company_sic_code3_pcnt := AVE(GROUP,IF(h.company_sic_code3 = (TYPEOF(h.company_sic_code3))'',0,100));
    maxlength_company_sic_code3 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code3)));
    avelength_company_sic_code3 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code3)),h.company_sic_code3<>(typeof(h.company_sic_code3))'');
    populated_company_sic_code4_pcnt := AVE(GROUP,IF(h.company_sic_code4 = (TYPEOF(h.company_sic_code4))'',0,100));
    maxlength_company_sic_code4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code4)));
    avelength_company_sic_code4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code4)),h.company_sic_code4<>(typeof(h.company_sic_code4))'');
    populated_company_sic_code5_pcnt := AVE(GROUP,IF(h.company_sic_code5 = (TYPEOF(h.company_sic_code5))'',0,100));
    maxlength_company_sic_code5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code5)));
    avelength_company_sic_code5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_sic_code5)),h.company_sic_code5<>(typeof(h.company_sic_code5))'');
    populated_company_naics_code1_pcnt := AVE(GROUP,IF(h.company_naics_code1 = (TYPEOF(h.company_naics_code1))'',0,100));
    maxlength_company_naics_code1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code1)));
    avelength_company_naics_code1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code1)),h.company_naics_code1<>(typeof(h.company_naics_code1))'');
    populated_company_naics_code2_pcnt := AVE(GROUP,IF(h.company_naics_code2 = (TYPEOF(h.company_naics_code2))'',0,100));
    maxlength_company_naics_code2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code2)));
    avelength_company_naics_code2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code2)),h.company_naics_code2<>(typeof(h.company_naics_code2))'');
    populated_company_naics_code3_pcnt := AVE(GROUP,IF(h.company_naics_code3 = (TYPEOF(h.company_naics_code3))'',0,100));
    maxlength_company_naics_code3 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code3)));
    avelength_company_naics_code3 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code3)),h.company_naics_code3<>(typeof(h.company_naics_code3))'');
    populated_company_naics_code4_pcnt := AVE(GROUP,IF(h.company_naics_code4 = (TYPEOF(h.company_naics_code4))'',0,100));
    maxlength_company_naics_code4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code4)));
    avelength_company_naics_code4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code4)),h.company_naics_code4<>(typeof(h.company_naics_code4))'');
    populated_company_naics_code5_pcnt := AVE(GROUP,IF(h.company_naics_code5 = (TYPEOF(h.company_naics_code5))'',0,100));
    maxlength_company_naics_code5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code5)));
    avelength_company_naics_code5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_naics_code5)),h.company_naics_code5<>(typeof(h.company_naics_code5))'');
    populated_company_ticker_pcnt := AVE(GROUP,IF(h.company_ticker = (TYPEOF(h.company_ticker))'',0,100));
    maxlength_company_ticker := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_ticker)));
    avelength_company_ticker := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_ticker)),h.company_ticker<>(typeof(h.company_ticker))'');
    populated_company_ticker_exchange_pcnt := AVE(GROUP,IF(h.company_ticker_exchange = (TYPEOF(h.company_ticker_exchange))'',0,100));
    maxlength_company_ticker_exchange := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_ticker_exchange)));
    avelength_company_ticker_exchange := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_ticker_exchange)),h.company_ticker_exchange<>(typeof(h.company_ticker_exchange))'');
    populated_company_foreign_domestic_pcnt := AVE(GROUP,IF(h.company_foreign_domestic = (TYPEOF(h.company_foreign_domestic))'',0,100));
    maxlength_company_foreign_domestic := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_foreign_domestic)));
    avelength_company_foreign_domestic := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_foreign_domestic)),h.company_foreign_domestic<>(typeof(h.company_foreign_domestic))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_company_filing_date_pcnt := AVE(GROUP,IF(h.company_filing_date = (TYPEOF(h.company_filing_date))'',0,100));
    maxlength_company_filing_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_filing_date)));
    avelength_company_filing_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_filing_date)),h.company_filing_date<>(typeof(h.company_filing_date))'');
    populated_company_status_date_pcnt := AVE(GROUP,IF(h.company_status_date = (TYPEOF(h.company_status_date))'',0,100));
    maxlength_company_status_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_date)));
    avelength_company_status_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_date)),h.company_status_date<>(typeof(h.company_status_date))'');
    populated_company_foreign_date_pcnt := AVE(GROUP,IF(h.company_foreign_date = (TYPEOF(h.company_foreign_date))'',0,100));
    maxlength_company_foreign_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_foreign_date)));
    avelength_company_foreign_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_foreign_date)),h.company_foreign_date<>(typeof(h.company_foreign_date))'');
    populated_event_filing_date_pcnt := AVE(GROUP,IF(h.event_filing_date = (TYPEOF(h.event_filing_date))'',0,100));
    maxlength_event_filing_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.event_filing_date)));
    avelength_event_filing_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.event_filing_date)),h.event_filing_date<>(typeof(h.event_filing_date))'');
    populated_company_name_status_raw_pcnt := AVE(GROUP,IF(h.company_name_status_raw = (TYPEOF(h.company_name_status_raw))'',0,100));
    maxlength_company_name_status_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_status_raw)));
    avelength_company_name_status_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_status_raw)),h.company_name_status_raw<>(typeof(h.company_name_status_raw))'');
    populated_company_status_raw_pcnt := AVE(GROUP,IF(h.company_status_raw = (TYPEOF(h.company_status_raw))'',0,100));
    maxlength_company_status_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_raw)));
    avelength_company_status_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_raw)),h.company_status_raw<>(typeof(h.company_status_raw))'');
    populated_vl_id_pcnt := AVE(GROUP,IF(h.vl_id = (TYPEOF(h.vl_id))'',0,100));
    maxlength_vl_id := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.vl_id)));
    avelength_vl_id := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.vl_id)),h.vl_id<>(typeof(h.vl_id))'');
    populated_current_pcnt := AVE(GROUP,IF(h.current = (TYPEOF(h.current))'',0,100));
    maxlength_current := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.current)));
    avelength_current := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.current)),h.current<>(typeof(h.current))'');
    populated_contact_did_pcnt := AVE(GROUP,IF(h.contact_did = (TYPEOF(h.contact_did))'',0,100));
    maxlength_contact_did := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_did)));
    avelength_contact_did := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_did)),h.contact_did<>(typeof(h.contact_did))'');
    populated_contact_type_raw_pcnt := AVE(GROUP,IF(h.contact_type_raw = (TYPEOF(h.contact_type_raw))'',0,100));
    maxlength_contact_type_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_type_raw)));
    avelength_contact_type_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_type_raw)),h.contact_type_raw<>(typeof(h.contact_type_raw))'');
    populated_contact_job_title_raw_pcnt := AVE(GROUP,IF(h.contact_job_title_raw = (TYPEOF(h.contact_job_title_raw))'',0,100));
    maxlength_contact_job_title_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_job_title_raw)));
    avelength_contact_job_title_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_job_title_raw)),h.contact_job_title_raw<>(typeof(h.contact_job_title_raw))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_contact_dob_pcnt := AVE(GROUP,IF(h.contact_dob = (TYPEOF(h.contact_dob))'',0,100));
    maxlength_contact_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_dob)));
    avelength_contact_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_dob)),h.contact_dob<>(typeof(h.contact_dob))'');
    populated_contact_status_raw_pcnt := AVE(GROUP,IF(h.contact_status_raw = (TYPEOF(h.contact_status_raw))'',0,100));
    maxlength_contact_status_raw := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_status_raw)));
    avelength_contact_status_raw := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_status_raw)),h.contact_status_raw<>(typeof(h.contact_status_raw))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_contact_email_username_pcnt := AVE(GROUP,IF(h.contact_email_username = (TYPEOF(h.contact_email_username))'',0,100));
    maxlength_contact_email_username := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email_username)));
    avelength_contact_email_username := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email_username)),h.contact_email_username<>(typeof(h.contact_email_username))'');
    populated_contact_email_domain_pcnt := AVE(GROUP,IF(h.contact_email_domain = (TYPEOF(h.contact_email_domain))'',0,100));
    maxlength_contact_email_domain := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email_domain)));
    avelength_contact_email_domain := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_email_domain)),h.contact_email_domain<>(typeof(h.contact_email_domain))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_from_hdr_pcnt := AVE(GROUP,IF(h.from_hdr = (TYPEOF(h.from_hdr))'',0,100));
    maxlength_from_hdr := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.from_hdr)));
    avelength_from_hdr := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.from_hdr)),h.from_hdr<>(typeof(h.from_hdr))'');
    populated_company_department_pcnt := AVE(GROUP,IF(h.company_department = (TYPEOF(h.company_department))'',0,100));
    maxlength_company_department := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_department)));
    avelength_company_department := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_department)),h.company_department<>(typeof(h.company_department))'');
    populated_company_address_type_derived_pcnt := AVE(GROUP,IF(h.company_address_type_derived = (TYPEOF(h.company_address_type_derived))'',0,100));
    maxlength_company_address_type_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_address_type_derived)));
    avelength_company_address_type_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_address_type_derived)),h.company_address_type_derived<>(typeof(h.company_address_type_derived))'');
    populated_company_org_structure_derived_pcnt := AVE(GROUP,IF(h.company_org_structure_derived = (TYPEOF(h.company_org_structure_derived))'',0,100));
    maxlength_company_org_structure_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_org_structure_derived)));
    avelength_company_org_structure_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_org_structure_derived)),h.company_org_structure_derived<>(typeof(h.company_org_structure_derived))'');
    populated_company_name_status_derived_pcnt := AVE(GROUP,IF(h.company_name_status_derived = (TYPEOF(h.company_name_status_derived))'',0,100));
    maxlength_company_name_status_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_status_derived)));
    avelength_company_name_status_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name_status_derived)),h.company_name_status_derived<>(typeof(h.company_name_status_derived))'');
    populated_company_status_derived_pcnt := AVE(GROUP,IF(h.company_status_derived = (TYPEOF(h.company_status_derived))'',0,100));
    maxlength_company_status_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_derived)));
    avelength_company_status_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_status_derived)),h.company_status_derived<>(typeof(h.company_status_derived))'');
    populated_contact_type_derived_pcnt := AVE(GROUP,IF(h.contact_type_derived = (TYPEOF(h.contact_type_derived))'',0,100));
    maxlength_contact_type_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_type_derived)));
    avelength_contact_type_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_type_derived)),h.contact_type_derived<>(typeof(h.contact_type_derived))'');
    populated_contact_job_title_derived_pcnt := AVE(GROUP,IF(h.contact_job_title_derived = (TYPEOF(h.contact_job_title_derived))'',0,100));
    maxlength_contact_job_title_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_job_title_derived)));
    avelength_contact_job_title_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_job_title_derived)),h.contact_job_title_derived<>(typeof(h.contact_job_title_derived))'');
    populated_contact_status_derived_pcnt := AVE(GROUP,IF(h.contact_status_derived = (TYPEOF(h.contact_status_derived))'',0,100));
    maxlength_contact_status_derived := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_status_derived)));
    avelength_contact_status_derived := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.contact_status_derived)),h.contact_status_derived<>(typeof(h.contact_status_derived))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_source_record_id_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_company_name_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_company_name_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_company_address_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_company_address_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_contact_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_contact_pcnt *   0.00 / 100 + T.Populated_isContact_pcnt *   0.00 / 100 + T.Populated_iscorp_pcnt *   0.00 / 100 + T.Populated_cnp_hasnumber_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *   0.00 / 100 + T.Populated_cnp_number_pcnt *   0.00 / 100 + T.Populated_cnp_btype_pcnt *   0.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_translated_pcnt *   0.00 / 100 + T.Populated_cnp_classid_pcnt *   0.00 / 100 + T.Populated_company_aceaid_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_dba_name_pcnt *   0.00 / 100 + T.Populated_active_duns_number_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_enterprise_number_pcnt *   0.00 / 100 + T.Populated_hist_enterprise_number_pcnt *   0.00 / 100 + T.Populated_ebr_file_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100 + T.Populated_employee_count_org_raw_pcnt *   0.00 / 100 + T.Populated_employee_count_org_derived_pcnt *   0.00 / 100 + T.Populated_revenue_org_raw_pcnt *   0.00 / 100 + T.Populated_revenue_org_derived_pcnt *   0.00 / 100 + T.Populated_employee_count_local_raw_pcnt *   0.00 / 100 + T.Populated_employee_count_local_derived_pcnt *   0.00 / 100 + T.Populated_revenue_local_raw_pcnt *   0.00 / 100 + T.Populated_revenue_local_derived_pcnt *   0.00 / 100 + T.Populated_locid_pcnt *   0.00 / 100 + T.Populated_source_docid_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_company_name_type_raw_pcnt *   0.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_company_rawaid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_company_address_type_raw_pcnt *   0.00 / 100 + T.Populated_company_fein_pcnt *   0.00 / 100 + T.Populated_best_fein_indicator_pcnt *   0.00 / 100 + T.Populated_company_phone_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_phone_score_pcnt *   0.00 / 100 + T.Populated_company_org_structure_raw_pcnt *   0.00 / 100 + T.Populated_company_incorporation_date_pcnt *   0.00 / 100 + T.Populated_company_sic_code1_pcnt *   0.00 / 100 + T.Populated_company_sic_code2_pcnt *   0.00 / 100 + T.Populated_company_sic_code3_pcnt *   0.00 / 100 + T.Populated_company_sic_code4_pcnt *   0.00 / 100 + T.Populated_company_sic_code5_pcnt *   0.00 / 100 + T.Populated_company_naics_code1_pcnt *   0.00 / 100 + T.Populated_company_naics_code2_pcnt *   0.00 / 100 + T.Populated_company_naics_code3_pcnt *   0.00 / 100 + T.Populated_company_naics_code4_pcnt *   0.00 / 100 + T.Populated_company_naics_code5_pcnt *   0.00 / 100 + T.Populated_company_ticker_pcnt *   0.00 / 100 + T.Populated_company_ticker_exchange_pcnt *   0.00 / 100 + T.Populated_company_foreign_domestic_pcnt *   0.00 / 100 + T.Populated_company_url_pcnt *   0.00 / 100 + T.Populated_company_inc_state_pcnt *   0.00 / 100 + T.Populated_company_charter_number_pcnt *   0.00 / 100 + T.Populated_company_filing_date_pcnt *   0.00 / 100 + T.Populated_company_status_date_pcnt *   0.00 / 100 + T.Populated_company_foreign_date_pcnt *   0.00 / 100 + T.Populated_event_filing_date_pcnt *   0.00 / 100 + T.Populated_company_name_status_raw_pcnt *   0.00 / 100 + T.Populated_company_status_raw_pcnt *   0.00 / 100 + T.Populated_vl_id_pcnt *   0.00 / 100 + T.Populated_current_pcnt *   0.00 / 100 + T.Populated_contact_did_pcnt *   0.00 / 100 + T.Populated_contact_type_raw_pcnt *   0.00 / 100 + T.Populated_contact_job_title_raw_pcnt *   0.00 / 100 + T.Populated_contact_ssn_pcnt *   0.00 / 100 + T.Populated_contact_dob_pcnt *   0.00 / 100 + T.Populated_contact_status_raw_pcnt *   0.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100 + T.Populated_contact_email_username_pcnt *   0.00 / 100 + T.Populated_contact_email_domain_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_from_hdr_pcnt *   0.00 / 100 + T.Populated_company_department_pcnt *   0.00 / 100 + T.Populated_company_address_type_derived_pcnt *   0.00 / 100 + T.Populated_company_org_structure_derived_pcnt *   0.00 / 100 + T.Populated_company_name_status_derived_pcnt *   0.00 / 100 + T.Populated_company_status_derived_pcnt *   0.00 / 100 + T.Populated_contact_type_derived_pcnt *   0.00 / 100 + T.Populated_contact_job_title_derived_pcnt *   0.00 / 100 + T.Populated_contact_status_derived_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_source_record_id_pcnt*ri.Populated_source_record_id_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_company_name_pcnt*ri.Populated_dt_first_seen_company_name_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_company_name_pcnt*ri.Populated_dt_last_seen_company_name_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_company_address_pcnt*ri.Populated_dt_first_seen_company_address_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_company_address_pcnt*ri.Populated_dt_last_seen_company_address_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_contact_pcnt*ri.Populated_dt_first_seen_contact_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_contact_pcnt*ri.Populated_dt_last_seen_contact_pcnt *   0.00 / 10000 + le.Populated_isContact_pcnt*ri.Populated_isContact_pcnt *   0.00 / 10000 + le.Populated_iscorp_pcnt*ri.Populated_iscorp_pcnt *   0.00 / 10000 + le.Populated_cnp_hasnumber_pcnt*ri.Populated_cnp_hasnumber_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *   0.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *   0.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   0.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_translated_pcnt*ri.Populated_cnp_translated_pcnt *   0.00 / 10000 + le.Populated_cnp_classid_pcnt*ri.Populated_cnp_classid_pcnt *   0.00 / 10000 + le.Populated_company_aceaid_pcnt*ri.Populated_company_aceaid_pcnt *   0.00 / 10000 + le.Populated_corp_legal_name_pcnt*ri.Populated_corp_legal_name_pcnt *   0.00 / 10000 + le.Populated_dba_name_pcnt*ri.Populated_dba_name_pcnt *   0.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_enterprise_number_pcnt*ri.Populated_active_enterprise_number_pcnt *   0.00 / 10000 + le.Populated_hist_enterprise_number_pcnt*ri.Populated_hist_enterprise_number_pcnt *   0.00 / 10000 + le.Populated_ebr_file_number_pcnt*ri.Populated_ebr_file_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_global_sid_pcnt*ri.Populated_global_sid_pcnt *   0.00 / 10000 + le.Populated_record_sid_pcnt*ri.Populated_record_sid_pcnt *   0.00 / 10000 + le.Populated_employee_count_org_raw_pcnt*ri.Populated_employee_count_org_raw_pcnt *   0.00 / 10000 + le.Populated_employee_count_org_derived_pcnt*ri.Populated_employee_count_org_derived_pcnt *   0.00 / 10000 + le.Populated_revenue_org_raw_pcnt*ri.Populated_revenue_org_raw_pcnt *   0.00 / 10000 + le.Populated_revenue_org_derived_pcnt*ri.Populated_revenue_org_derived_pcnt *   0.00 / 10000 + le.Populated_employee_count_local_raw_pcnt*ri.Populated_employee_count_local_raw_pcnt *   0.00 / 10000 + le.Populated_employee_count_local_derived_pcnt*ri.Populated_employee_count_local_derived_pcnt *   0.00 / 10000 + le.Populated_revenue_local_raw_pcnt*ri.Populated_revenue_local_raw_pcnt *   0.00 / 10000 + le.Populated_revenue_local_derived_pcnt*ri.Populated_revenue_local_derived_pcnt *   0.00 / 10000 + le.Populated_locid_pcnt*ri.Populated_locid_pcnt *   0.00 / 10000 + le.Populated_source_docid_pcnt*ri.Populated_source_docid_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_company_name_type_raw_pcnt*ri.Populated_company_name_type_raw_pcnt *   0.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_rawaid_pcnt*ri.Populated_company_rawaid_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_company_address_type_raw_pcnt*ri.Populated_company_address_type_raw_pcnt *   0.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *   0.00 / 10000 + le.Populated_best_fein_indicator_pcnt*ri.Populated_best_fein_indicator_pcnt *   0.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *   0.00 / 10000 + le.Populated_phone_type_pcnt*ri.Populated_phone_type_pcnt *   0.00 / 10000 + le.Populated_phone_score_pcnt*ri.Populated_phone_score_pcnt *   0.00 / 10000 + le.Populated_company_org_structure_raw_pcnt*ri.Populated_company_org_structure_raw_pcnt *   0.00 / 10000 + le.Populated_company_incorporation_date_pcnt*ri.Populated_company_incorporation_date_pcnt *   0.00 / 10000 + le.Populated_company_sic_code1_pcnt*ri.Populated_company_sic_code1_pcnt *   0.00 / 10000 + le.Populated_company_sic_code2_pcnt*ri.Populated_company_sic_code2_pcnt *   0.00 / 10000 + le.Populated_company_sic_code3_pcnt*ri.Populated_company_sic_code3_pcnt *   0.00 / 10000 + le.Populated_company_sic_code4_pcnt*ri.Populated_company_sic_code4_pcnt *   0.00 / 10000 + le.Populated_company_sic_code5_pcnt*ri.Populated_company_sic_code5_pcnt *   0.00 / 10000 + le.Populated_company_naics_code1_pcnt*ri.Populated_company_naics_code1_pcnt *   0.00 / 10000 + le.Populated_company_naics_code2_pcnt*ri.Populated_company_naics_code2_pcnt *   0.00 / 10000 + le.Populated_company_naics_code3_pcnt*ri.Populated_company_naics_code3_pcnt *   0.00 / 10000 + le.Populated_company_naics_code4_pcnt*ri.Populated_company_naics_code4_pcnt *   0.00 / 10000 + le.Populated_company_naics_code5_pcnt*ri.Populated_company_naics_code5_pcnt *   0.00 / 10000 + le.Populated_company_ticker_pcnt*ri.Populated_company_ticker_pcnt *   0.00 / 10000 + le.Populated_company_ticker_exchange_pcnt*ri.Populated_company_ticker_exchange_pcnt *   0.00 / 10000 + le.Populated_company_foreign_domestic_pcnt*ri.Populated_company_foreign_domestic_pcnt *   0.00 / 10000 + le.Populated_company_url_pcnt*ri.Populated_company_url_pcnt *   0.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   0.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *   0.00 / 10000 + le.Populated_company_filing_date_pcnt*ri.Populated_company_filing_date_pcnt *   0.00 / 10000 + le.Populated_company_status_date_pcnt*ri.Populated_company_status_date_pcnt *   0.00 / 10000 + le.Populated_company_foreign_date_pcnt*ri.Populated_company_foreign_date_pcnt *   0.00 / 10000 + le.Populated_event_filing_date_pcnt*ri.Populated_event_filing_date_pcnt *   0.00 / 10000 + le.Populated_company_name_status_raw_pcnt*ri.Populated_company_name_status_raw_pcnt *   0.00 / 10000 + le.Populated_company_status_raw_pcnt*ri.Populated_company_status_raw_pcnt *   0.00 / 10000 + le.Populated_vl_id_pcnt*ri.Populated_vl_id_pcnt *   0.00 / 10000 + le.Populated_current_pcnt*ri.Populated_current_pcnt *   0.00 / 10000 + le.Populated_contact_did_pcnt*ri.Populated_contact_did_pcnt *   0.00 / 10000 + le.Populated_contact_type_raw_pcnt*ri.Populated_contact_type_raw_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_raw_pcnt*ri.Populated_contact_job_title_raw_pcnt *   0.00 / 10000 + le.Populated_contact_ssn_pcnt*ri.Populated_contact_ssn_pcnt *   0.00 / 10000 + le.Populated_contact_dob_pcnt*ri.Populated_contact_dob_pcnt *   0.00 / 10000 + le.Populated_contact_status_raw_pcnt*ri.Populated_contact_status_raw_pcnt *   0.00 / 10000 + le.Populated_contact_email_pcnt*ri.Populated_contact_email_pcnt *   0.00 / 10000 + le.Populated_contact_email_username_pcnt*ri.Populated_contact_email_username_pcnt *   0.00 / 10000 + le.Populated_contact_email_domain_pcnt*ri.Populated_contact_email_domain_pcnt *   0.00 / 10000 + le.Populated_contact_phone_pcnt*ri.Populated_contact_phone_pcnt *   0.00 / 10000 + le.Populated_from_hdr_pcnt*ri.Populated_from_hdr_pcnt *   0.00 / 10000 + le.Populated_company_department_pcnt*ri.Populated_company_department_pcnt *   0.00 / 10000 + le.Populated_company_address_type_derived_pcnt*ri.Populated_company_address_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_org_structure_derived_pcnt*ri.Populated_company_org_structure_derived_pcnt *   0.00 / 10000 + le.Populated_company_name_status_derived_pcnt*ri.Populated_company_name_status_derived_pcnt *   0.00 / 10000 + le.Populated_company_status_derived_pcnt*ri.Populated_company_status_derived_pcnt *   0.00 / 10000 + le.Populated_contact_type_derived_pcnt*ri.Populated_contact_type_derived_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_derived_pcnt*ri.Populated_contact_job_title_derived_pcnt *   0.00 / 10000 + le.Populated_contact_status_derived_pcnt*ri.Populated_contact_status_derived_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT35.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'source','source_record_id','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','dt_first_seen_contact','dt_last_seen_contact','isContact','iscorp','cnp_hasnumber','cnp_name','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_aceaid','corp_legal_name','dba_name','active_duns_number','hist_duns_number','active_enterprise_number','hist_enterprise_number','ebr_file_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','global_sid','record_sid','employee_count_org_raw','employee_count_org_derived','revenue_org_raw','revenue_org_derived','employee_count_local_raw','employee_count_local_derived','revenue_local_raw','revenue_local_derived','locid','source_docid','title','fname','mname','lname','name_suffix','name_score','company_name','company_name_type_raw','company_name_type_derived','company_rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','company_bdid','company_address_type_raw','company_fein','best_fein_indicator','company_phone','phone_type','phone_score','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_charter_number','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','vl_id','current','contact_did','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_email','contact_email_username','contact_email_domain','contact_phone','from_hdr','company_department','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','contact_type_derived','contact_job_title_derived','contact_status_derived');
  SELF.populated_pcnt := CHOOSE(C,le.populated_source_pcnt,le.populated_source_record_id_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_company_name_pcnt,le.populated_dt_last_seen_company_name_pcnt,le.populated_dt_first_seen_company_address_pcnt,le.populated_dt_last_seen_company_address_pcnt,le.populated_dt_first_seen_contact_pcnt,le.populated_dt_last_seen_contact_pcnt,le.populated_isContact_pcnt,le.populated_iscorp_pcnt,le.populated_cnp_hasnumber_pcnt,le.populated_cnp_name_pcnt,le.populated_cnp_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_translated_pcnt,le.populated_cnp_classid_pcnt,le.populated_company_aceaid_pcnt,le.populated_corp_legal_name_pcnt,le.populated_dba_name_pcnt,le.populated_active_duns_number_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_enterprise_number_pcnt,le.populated_hist_enterprise_number_pcnt,le.populated_ebr_file_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt,le.populated_employee_count_org_raw_pcnt,le.populated_employee_count_org_derived_pcnt,le.populated_revenue_org_raw_pcnt,le.populated_revenue_org_derived_pcnt,le.populated_employee_count_local_raw_pcnt,le.populated_employee_count_local_derived_pcnt,le.populated_revenue_local_raw_pcnt,le.populated_revenue_local_derived_pcnt,le.populated_locid_pcnt,le.populated_source_docid_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_company_name_pcnt,le.populated_company_name_type_raw_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_company_rawaid_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_company_bdid_pcnt,le.populated_company_address_type_raw_pcnt,le.populated_company_fein_pcnt,le.populated_best_fein_indicator_pcnt,le.populated_company_phone_pcnt,le.populated_phone_type_pcnt,le.populated_phone_score_pcnt,le.populated_company_org_structure_raw_pcnt,le.populated_company_incorporation_date_pcnt,le.populated_company_sic_code1_pcnt,le.populated_company_sic_code2_pcnt,le.populated_company_sic_code3_pcnt,le.populated_company_sic_code4_pcnt,le.populated_company_sic_code5_pcnt,le.populated_company_naics_code1_pcnt,le.populated_company_naics_code2_pcnt,le.populated_company_naics_code3_pcnt,le.populated_company_naics_code4_pcnt,le.populated_company_naics_code5_pcnt,le.populated_company_ticker_pcnt,le.populated_company_ticker_exchange_pcnt,le.populated_company_foreign_domestic_pcnt,le.populated_company_url_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_company_filing_date_pcnt,le.populated_company_status_date_pcnt,le.populated_company_foreign_date_pcnt,le.populated_event_filing_date_pcnt,le.populated_company_name_status_raw_pcnt,le.populated_company_status_raw_pcnt,le.populated_vl_id_pcnt,le.populated_current_pcnt,le.populated_contact_did_pcnt,le.populated_contact_type_raw_pcnt,le.populated_contact_job_title_raw_pcnt,le.populated_contact_ssn_pcnt,le.populated_contact_dob_pcnt,le.populated_contact_status_raw_pcnt,le.populated_contact_email_pcnt,le.populated_contact_email_username_pcnt,le.populated_contact_email_domain_pcnt,le.populated_contact_phone_pcnt,le.populated_from_hdr_pcnt,le.populated_company_department_pcnt,le.populated_company_address_type_derived_pcnt,le.populated_company_org_structure_derived_pcnt,le.populated_company_name_status_derived_pcnt,le.populated_company_status_derived_pcnt,le.populated_contact_type_derived_pcnt,le.populated_contact_job_title_derived_pcnt,le.populated_contact_status_derived_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_source,le.maxlength_source_record_id,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen_company_name,le.maxlength_dt_last_seen_company_name,le.maxlength_dt_first_seen_company_address,le.maxlength_dt_last_seen_company_address,le.maxlength_dt_first_seen_contact,le.maxlength_dt_last_seen_contact,le.maxlength_isContact,le.maxlength_iscorp,le.maxlength_cnp_hasnumber,le.maxlength_cnp_name,le.maxlength_cnp_number,le.maxlength_cnp_btype,le.maxlength_cnp_lowv,le.maxlength_cnp_translated,le.maxlength_cnp_classid,le.maxlength_company_aceaid,le.maxlength_corp_legal_name,le.maxlength_dba_name,le.maxlength_active_duns_number,le.maxlength_hist_duns_number,le.maxlength_active_enterprise_number,le.maxlength_hist_enterprise_number,le.maxlength_ebr_file_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_global_sid,le.maxlength_record_sid,le.maxlength_employee_count_org_raw,le.maxlength_employee_count_org_derived,le.maxlength_revenue_org_raw,le.maxlength_revenue_org_derived,le.maxlength_employee_count_local_raw,le.maxlength_employee_count_local_derived,le.maxlength_revenue_local_raw,le.maxlength_revenue_local_derived,le.maxlength_locid,le.maxlength_source_docid,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_company_name,le.maxlength_company_name_type_raw,le.maxlength_company_name_type_derived,le.maxlength_company_rawaid,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_company_bdid,le.maxlength_company_address_type_raw,le.maxlength_company_fein,le.maxlength_best_fein_indicator,le.maxlength_company_phone,le.maxlength_phone_type,le.maxlength_phone_score,le.maxlength_company_org_structure_raw,le.maxlength_company_incorporation_date,le.maxlength_company_sic_code1,le.maxlength_company_sic_code2,le.maxlength_company_sic_code3,le.maxlength_company_sic_code4,le.maxlength_company_sic_code5,le.maxlength_company_naics_code1,le.maxlength_company_naics_code2,le.maxlength_company_naics_code3,le.maxlength_company_naics_code4,le.maxlength_company_naics_code5,le.maxlength_company_ticker,le.maxlength_company_ticker_exchange,le.maxlength_company_foreign_domestic,le.maxlength_company_url,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_company_filing_date,le.maxlength_company_status_date,le.maxlength_company_foreign_date,le.maxlength_event_filing_date,le.maxlength_company_name_status_raw,le.maxlength_company_status_raw,le.maxlength_vl_id,le.maxlength_current,le.maxlength_contact_did,le.maxlength_contact_type_raw,le.maxlength_contact_job_title_raw,le.maxlength_contact_ssn,le.maxlength_contact_dob,le.maxlength_contact_status_raw,le.maxlength_contact_email,le.maxlength_contact_email_username,le.maxlength_contact_email_domain,le.maxlength_contact_phone,le.maxlength_from_hdr,le.maxlength_company_department,le.maxlength_company_address_type_derived,le.maxlength_company_org_structure_derived,le.maxlength_company_name_status_derived,le.maxlength_company_status_derived,le.maxlength_contact_type_derived,le.maxlength_contact_job_title_derived,le.maxlength_contact_status_derived);
  SELF.avelength := CHOOSE(C,le.avelength_source,le.avelength_source_record_id,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen_company_name,le.avelength_dt_last_seen_company_name,le.avelength_dt_first_seen_company_address,le.avelength_dt_last_seen_company_address,le.avelength_dt_first_seen_contact,le.avelength_dt_last_seen_contact,le.avelength_isContact,le.avelength_iscorp,le.avelength_cnp_hasnumber,le.avelength_cnp_name,le.avelength_cnp_number,le.avelength_cnp_btype,le.avelength_cnp_lowv,le.avelength_cnp_translated,le.avelength_cnp_classid,le.avelength_company_aceaid,le.avelength_corp_legal_name,le.avelength_dba_name,le.avelength_active_duns_number,le.avelength_hist_duns_number,le.avelength_active_enterprise_number,le.avelength_hist_enterprise_number,le.avelength_ebr_file_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_global_sid,le.avelength_record_sid,le.avelength_employee_count_org_raw,le.avelength_employee_count_org_derived,le.avelength_revenue_org_raw,le.avelength_revenue_org_derived,le.avelength_employee_count_local_raw,le.avelength_employee_count_local_derived,le.avelength_revenue_local_raw,le.avelength_revenue_local_derived,le.avelength_locid,le.avelength_source_docid,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_company_name,le.avelength_company_name_type_raw,le.avelength_company_name_type_derived,le.avelength_company_rawaid,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_company_bdid,le.avelength_company_address_type_raw,le.avelength_company_fein,le.avelength_best_fein_indicator,le.avelength_company_phone,le.avelength_phone_type,le.avelength_phone_score,le.avelength_company_org_structure_raw,le.avelength_company_incorporation_date,le.avelength_company_sic_code1,le.avelength_company_sic_code2,le.avelength_company_sic_code3,le.avelength_company_sic_code4,le.avelength_company_sic_code5,le.avelength_company_naics_code1,le.avelength_company_naics_code2,le.avelength_company_naics_code3,le.avelength_company_naics_code4,le.avelength_company_naics_code5,le.avelength_company_ticker,le.avelength_company_ticker_exchange,le.avelength_company_foreign_domestic,le.avelength_company_url,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_company_filing_date,le.avelength_company_status_date,le.avelength_company_foreign_date,le.avelength_event_filing_date,le.avelength_company_name_status_raw,le.avelength_company_status_raw,le.avelength_vl_id,le.avelength_current,le.avelength_contact_did,le.avelength_contact_type_raw,le.avelength_contact_job_title_raw,le.avelength_contact_ssn,le.avelength_contact_dob,le.avelength_contact_status_raw,le.avelength_contact_email,le.avelength_contact_email_username,le.avelength_contact_email_domain,le.avelength_contact_phone,le.avelength_from_hdr,le.avelength_company_department,le.avelength_company_address_type_derived,le.avelength_company_org_structure_derived,le.avelength_company_name_status_derived,le.avelength_company_status_derived,le.avelength_contact_type_derived,le.avelength_contact_job_title_derived,le.avelength_contact_status_derived);
END;
EXPORT invSummary := NORMALIZE(summary0, 134, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.DOTid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.source),TRIM((SALT35.StrType)le.source_record_id),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen),TRIM((SALT35.StrType)le.dt_vendor_first_reported),TRIM((SALT35.StrType)le.dt_vendor_last_reported),TRIM((SALT35.StrType)le.dt_first_seen_company_name),TRIM((SALT35.StrType)le.dt_last_seen_company_name),TRIM((SALT35.StrType)le.dt_first_seen_company_address),TRIM((SALT35.StrType)le.dt_last_seen_company_address),TRIM((SALT35.StrType)le.dt_first_seen_contact),TRIM((SALT35.StrType)le.dt_last_seen_contact),TRIM((SALT35.StrType)le.isContact),TRIM((SALT35.StrType)le.iscorp),TRIM((SALT35.StrType)le.cnp_hasnumber),TRIM((SALT35.StrType)le.cnp_name),TRIM((SALT35.StrType)le.cnp_number),TRIM((SALT35.StrType)le.cnp_btype),TRIM((SALT35.StrType)le.cnp_lowv),TRIM((SALT35.StrType)le.cnp_translated),TRIM((SALT35.StrType)le.cnp_classid),TRIM((SALT35.StrType)le.company_aceaid),TRIM((SALT35.StrType)le.corp_legal_name),TRIM((SALT35.StrType)le.dba_name),TRIM((SALT35.StrType)le.active_duns_number),TRIM((SALT35.StrType)le.hist_duns_number),TRIM((SALT35.StrType)le.active_enterprise_number),TRIM((SALT35.StrType)le.hist_enterprise_number),TRIM((SALT35.StrType)le.ebr_file_number),TRIM((SALT35.StrType)le.active_domestic_corp_key),TRIM((SALT35.StrType)le.hist_domestic_corp_key),TRIM((SALT35.StrType)le.foreign_corp_key),TRIM((SALT35.StrType)le.unk_corp_key),TRIM((SALT35.StrType)le.global_sid),TRIM((SALT35.StrType)le.record_sid),TRIM((SALT35.StrType)le.employee_count_org_raw),TRIM((SALT35.StrType)le.employee_count_org_derived),TRIM((SALT35.StrType)le.revenue_org_raw),TRIM((SALT35.StrType)le.revenue_org_derived),TRIM((SALT35.StrType)le.employee_count_local_raw),TRIM((SALT35.StrType)le.employee_count_local_derived),TRIM((SALT35.StrType)le.revenue_local_raw),TRIM((SALT35.StrType)le.revenue_local_derived),TRIM((SALT35.StrType)le.locid),TRIM((SALT35.StrType)le.source_docid),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.company_name_type_raw),TRIM((SALT35.StrType)le.company_name_type_derived),TRIM((SALT35.StrType)le.company_rawaid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.fips_state),TRIM((SALT35.StrType)le.fips_county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat),TRIM((SALT35.StrType)le.company_bdid),TRIM((SALT35.StrType)le.company_address_type_raw),TRIM((SALT35.StrType)le.company_fein),TRIM((SALT35.StrType)le.best_fein_indicator),TRIM((SALT35.StrType)le.company_phone),TRIM((SALT35.StrType)le.phone_type),TRIM((SALT35.StrType)le.phone_score),TRIM((SALT35.StrType)le.company_org_structure_raw),TRIM((SALT35.StrType)le.company_incorporation_date),TRIM((SALT35.StrType)le.company_sic_code1),TRIM((SALT35.StrType)le.company_sic_code2),TRIM((SALT35.StrType)le.company_sic_code3),TRIM((SALT35.StrType)le.company_sic_code4),TRIM((SALT35.StrType)le.company_sic_code5),TRIM((SALT35.StrType)le.company_naics_code1),TRIM((SALT35.StrType)le.company_naics_code2),TRIM((SALT35.StrType)le.company_naics_code3),TRIM((SALT35.StrType)le.company_naics_code4),TRIM((SALT35.StrType)le.company_naics_code5),TRIM((SALT35.StrType)le.company_ticker),TRIM((SALT35.StrType)le.company_ticker_exchange),TRIM((SALT35.StrType)le.company_foreign_domestic),TRIM((SALT35.StrType)le.company_url),TRIM((SALT35.StrType)le.company_inc_state),TRIM((SALT35.StrType)le.company_charter_number),TRIM((SALT35.StrType)le.company_filing_date),TRIM((SALT35.StrType)le.company_status_date),TRIM((SALT35.StrType)le.company_foreign_date),TRIM((SALT35.StrType)le.event_filing_date),TRIM((SALT35.StrType)le.company_name_status_raw),TRIM((SALT35.StrType)le.company_status_raw),TRIM((SALT35.StrType)le.vl_id),TRIM((SALT35.StrType)le.current),TRIM((SALT35.StrType)le.contact_did),TRIM((SALT35.StrType)le.contact_type_raw),TRIM((SALT35.StrType)le.contact_job_title_raw),TRIM((SALT35.StrType)le.contact_ssn),TRIM((SALT35.StrType)le.contact_dob),TRIM((SALT35.StrType)le.contact_status_raw),TRIM((SALT35.StrType)le.contact_email),TRIM((SALT35.StrType)le.contact_email_username),TRIM((SALT35.StrType)le.contact_email_domain),TRIM((SALT35.StrType)le.contact_phone),TRIM((SALT35.StrType)le.from_hdr),TRIM((SALT35.StrType)le.company_department),TRIM((SALT35.StrType)le.company_address_type_derived),TRIM((SALT35.StrType)le.company_org_structure_derived),TRIM((SALT35.StrType)le.company_name_status_derived),TRIM((SALT35.StrType)le.company_status_derived),TRIM((SALT35.StrType)le.contact_type_derived),TRIM((SALT35.StrType)le.contact_job_title_derived),TRIM((SALT35.StrType)le.contact_status_derived)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,134,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 134);
  SELF.FldNo2 := 1 + (C % 134);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.source),TRIM((SALT35.StrType)le.source_record_id),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen),TRIM((SALT35.StrType)le.dt_vendor_first_reported),TRIM((SALT35.StrType)le.dt_vendor_last_reported),TRIM((SALT35.StrType)le.dt_first_seen_company_name),TRIM((SALT35.StrType)le.dt_last_seen_company_name),TRIM((SALT35.StrType)le.dt_first_seen_company_address),TRIM((SALT35.StrType)le.dt_last_seen_company_address),TRIM((SALT35.StrType)le.dt_first_seen_contact),TRIM((SALT35.StrType)le.dt_last_seen_contact),TRIM((SALT35.StrType)le.isContact),TRIM((SALT35.StrType)le.iscorp),TRIM((SALT35.StrType)le.cnp_hasnumber),TRIM((SALT35.StrType)le.cnp_name),TRIM((SALT35.StrType)le.cnp_number),TRIM((SALT35.StrType)le.cnp_btype),TRIM((SALT35.StrType)le.cnp_lowv),TRIM((SALT35.StrType)le.cnp_translated),TRIM((SALT35.StrType)le.cnp_classid),TRIM((SALT35.StrType)le.company_aceaid),TRIM((SALT35.StrType)le.corp_legal_name),TRIM((SALT35.StrType)le.dba_name),TRIM((SALT35.StrType)le.active_duns_number),TRIM((SALT35.StrType)le.hist_duns_number),TRIM((SALT35.StrType)le.active_enterprise_number),TRIM((SALT35.StrType)le.hist_enterprise_number),TRIM((SALT35.StrType)le.ebr_file_number),TRIM((SALT35.StrType)le.active_domestic_corp_key),TRIM((SALT35.StrType)le.hist_domestic_corp_key),TRIM((SALT35.StrType)le.foreign_corp_key),TRIM((SALT35.StrType)le.unk_corp_key),TRIM((SALT35.StrType)le.global_sid),TRIM((SALT35.StrType)le.record_sid),TRIM((SALT35.StrType)le.employee_count_org_raw),TRIM((SALT35.StrType)le.employee_count_org_derived),TRIM((SALT35.StrType)le.revenue_org_raw),TRIM((SALT35.StrType)le.revenue_org_derived),TRIM((SALT35.StrType)le.employee_count_local_raw),TRIM((SALT35.StrType)le.employee_count_local_derived),TRIM((SALT35.StrType)le.revenue_local_raw),TRIM((SALT35.StrType)le.revenue_local_derived),TRIM((SALT35.StrType)le.locid),TRIM((SALT35.StrType)le.source_docid),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.company_name_type_raw),TRIM((SALT35.StrType)le.company_name_type_derived),TRIM((SALT35.StrType)le.company_rawaid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.fips_state),TRIM((SALT35.StrType)le.fips_county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat),TRIM((SALT35.StrType)le.company_bdid),TRIM((SALT35.StrType)le.company_address_type_raw),TRIM((SALT35.StrType)le.company_fein),TRIM((SALT35.StrType)le.best_fein_indicator),TRIM((SALT35.StrType)le.company_phone),TRIM((SALT35.StrType)le.phone_type),TRIM((SALT35.StrType)le.phone_score),TRIM((SALT35.StrType)le.company_org_structure_raw),TRIM((SALT35.StrType)le.company_incorporation_date),TRIM((SALT35.StrType)le.company_sic_code1),TRIM((SALT35.StrType)le.company_sic_code2),TRIM((SALT35.StrType)le.company_sic_code3),TRIM((SALT35.StrType)le.company_sic_code4),TRIM((SALT35.StrType)le.company_sic_code5),TRIM((SALT35.StrType)le.company_naics_code1),TRIM((SALT35.StrType)le.company_naics_code2),TRIM((SALT35.StrType)le.company_naics_code3),TRIM((SALT35.StrType)le.company_naics_code4),TRIM((SALT35.StrType)le.company_naics_code5),TRIM((SALT35.StrType)le.company_ticker),TRIM((SALT35.StrType)le.company_ticker_exchange),TRIM((SALT35.StrType)le.company_foreign_domestic),TRIM((SALT35.StrType)le.company_url),TRIM((SALT35.StrType)le.company_inc_state),TRIM((SALT35.StrType)le.company_charter_number),TRIM((SALT35.StrType)le.company_filing_date),TRIM((SALT35.StrType)le.company_status_date),TRIM((SALT35.StrType)le.company_foreign_date),TRIM((SALT35.StrType)le.event_filing_date),TRIM((SALT35.StrType)le.company_name_status_raw),TRIM((SALT35.StrType)le.company_status_raw),TRIM((SALT35.StrType)le.vl_id),TRIM((SALT35.StrType)le.current),TRIM((SALT35.StrType)le.contact_did),TRIM((SALT35.StrType)le.contact_type_raw),TRIM((SALT35.StrType)le.contact_job_title_raw),TRIM((SALT35.StrType)le.contact_ssn),TRIM((SALT35.StrType)le.contact_dob),TRIM((SALT35.StrType)le.contact_status_raw),TRIM((SALT35.StrType)le.contact_email),TRIM((SALT35.StrType)le.contact_email_username),TRIM((SALT35.StrType)le.contact_email_domain),TRIM((SALT35.StrType)le.contact_phone),TRIM((SALT35.StrType)le.from_hdr),TRIM((SALT35.StrType)le.company_department),TRIM((SALT35.StrType)le.company_address_type_derived),TRIM((SALT35.StrType)le.company_org_structure_derived),TRIM((SALT35.StrType)le.company_name_status_derived),TRIM((SALT35.StrType)le.company_status_derived),TRIM((SALT35.StrType)le.contact_type_derived),TRIM((SALT35.StrType)le.contact_job_title_derived),TRIM((SALT35.StrType)le.contact_status_derived)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.source),TRIM((SALT35.StrType)le.source_record_id),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen),TRIM((SALT35.StrType)le.dt_vendor_first_reported),TRIM((SALT35.StrType)le.dt_vendor_last_reported),TRIM((SALT35.StrType)le.dt_first_seen_company_name),TRIM((SALT35.StrType)le.dt_last_seen_company_name),TRIM((SALT35.StrType)le.dt_first_seen_company_address),TRIM((SALT35.StrType)le.dt_last_seen_company_address),TRIM((SALT35.StrType)le.dt_first_seen_contact),TRIM((SALT35.StrType)le.dt_last_seen_contact),TRIM((SALT35.StrType)le.isContact),TRIM((SALT35.StrType)le.iscorp),TRIM((SALT35.StrType)le.cnp_hasnumber),TRIM((SALT35.StrType)le.cnp_name),TRIM((SALT35.StrType)le.cnp_number),TRIM((SALT35.StrType)le.cnp_btype),TRIM((SALT35.StrType)le.cnp_lowv),TRIM((SALT35.StrType)le.cnp_translated),TRIM((SALT35.StrType)le.cnp_classid),TRIM((SALT35.StrType)le.company_aceaid),TRIM((SALT35.StrType)le.corp_legal_name),TRIM((SALT35.StrType)le.dba_name),TRIM((SALT35.StrType)le.active_duns_number),TRIM((SALT35.StrType)le.hist_duns_number),TRIM((SALT35.StrType)le.active_enterprise_number),TRIM((SALT35.StrType)le.hist_enterprise_number),TRIM((SALT35.StrType)le.ebr_file_number),TRIM((SALT35.StrType)le.active_domestic_corp_key),TRIM((SALT35.StrType)le.hist_domestic_corp_key),TRIM((SALT35.StrType)le.foreign_corp_key),TRIM((SALT35.StrType)le.unk_corp_key),TRIM((SALT35.StrType)le.global_sid),TRIM((SALT35.StrType)le.record_sid),TRIM((SALT35.StrType)le.employee_count_org_raw),TRIM((SALT35.StrType)le.employee_count_org_derived),TRIM((SALT35.StrType)le.revenue_org_raw),TRIM((SALT35.StrType)le.revenue_org_derived),TRIM((SALT35.StrType)le.employee_count_local_raw),TRIM((SALT35.StrType)le.employee_count_local_derived),TRIM((SALT35.StrType)le.revenue_local_raw),TRIM((SALT35.StrType)le.revenue_local_derived),TRIM((SALT35.StrType)le.locid),TRIM((SALT35.StrType)le.source_docid),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.company_name_type_raw),TRIM((SALT35.StrType)le.company_name_type_derived),TRIM((SALT35.StrType)le.company_rawaid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.fips_state),TRIM((SALT35.StrType)le.fips_county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat),TRIM((SALT35.StrType)le.company_bdid),TRIM((SALT35.StrType)le.company_address_type_raw),TRIM((SALT35.StrType)le.company_fein),TRIM((SALT35.StrType)le.best_fein_indicator),TRIM((SALT35.StrType)le.company_phone),TRIM((SALT35.StrType)le.phone_type),TRIM((SALT35.StrType)le.phone_score),TRIM((SALT35.StrType)le.company_org_structure_raw),TRIM((SALT35.StrType)le.company_incorporation_date),TRIM((SALT35.StrType)le.company_sic_code1),TRIM((SALT35.StrType)le.company_sic_code2),TRIM((SALT35.StrType)le.company_sic_code3),TRIM((SALT35.StrType)le.company_sic_code4),TRIM((SALT35.StrType)le.company_sic_code5),TRIM((SALT35.StrType)le.company_naics_code1),TRIM((SALT35.StrType)le.company_naics_code2),TRIM((SALT35.StrType)le.company_naics_code3),TRIM((SALT35.StrType)le.company_naics_code4),TRIM((SALT35.StrType)le.company_naics_code5),TRIM((SALT35.StrType)le.company_ticker),TRIM((SALT35.StrType)le.company_ticker_exchange),TRIM((SALT35.StrType)le.company_foreign_domestic),TRIM((SALT35.StrType)le.company_url),TRIM((SALT35.StrType)le.company_inc_state),TRIM((SALT35.StrType)le.company_charter_number),TRIM((SALT35.StrType)le.company_filing_date),TRIM((SALT35.StrType)le.company_status_date),TRIM((SALT35.StrType)le.company_foreign_date),TRIM((SALT35.StrType)le.event_filing_date),TRIM((SALT35.StrType)le.company_name_status_raw),TRIM((SALT35.StrType)le.company_status_raw),TRIM((SALT35.StrType)le.vl_id),TRIM((SALT35.StrType)le.current),TRIM((SALT35.StrType)le.contact_did),TRIM((SALT35.StrType)le.contact_type_raw),TRIM((SALT35.StrType)le.contact_job_title_raw),TRIM((SALT35.StrType)le.contact_ssn),TRIM((SALT35.StrType)le.contact_dob),TRIM((SALT35.StrType)le.contact_status_raw),TRIM((SALT35.StrType)le.contact_email),TRIM((SALT35.StrType)le.contact_email_username),TRIM((SALT35.StrType)le.contact_email_domain),TRIM((SALT35.StrType)le.contact_phone),TRIM((SALT35.StrType)le.from_hdr),TRIM((SALT35.StrType)le.company_department),TRIM((SALT35.StrType)le.company_address_type_derived),TRIM((SALT35.StrType)le.company_org_structure_derived),TRIM((SALT35.StrType)le.company_name_status_derived),TRIM((SALT35.StrType)le.company_status_derived),TRIM((SALT35.StrType)le.contact_type_derived),TRIM((SALT35.StrType)le.contact_job_title_derived),TRIM((SALT35.StrType)le.contact_status_derived)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),134*134,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'source'}
      ,{2,'source_record_id'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'dt_first_seen_company_name'}
      ,{8,'dt_last_seen_company_name'}
      ,{9,'dt_first_seen_company_address'}
      ,{10,'dt_last_seen_company_address'}
      ,{11,'dt_first_seen_contact'}
      ,{12,'dt_last_seen_contact'}
      ,{13,'isContact'}
      ,{14,'iscorp'}
      ,{15,'cnp_hasnumber'}
      ,{16,'cnp_name'}
      ,{17,'cnp_number'}
      ,{18,'cnp_btype'}
      ,{19,'cnp_lowv'}
      ,{20,'cnp_translated'}
      ,{21,'cnp_classid'}
      ,{22,'company_aceaid'}
      ,{23,'corp_legal_name'}
      ,{24,'dba_name'}
      ,{25,'active_duns_number'}
      ,{26,'hist_duns_number'}
      ,{27,'active_enterprise_number'}
      ,{28,'hist_enterprise_number'}
      ,{29,'ebr_file_number'}
      ,{30,'active_domestic_corp_key'}
      ,{31,'hist_domestic_corp_key'}
      ,{32,'foreign_corp_key'}
      ,{33,'unk_corp_key'}
      ,{34,'global_sid'}
      ,{35,'record_sid'}
      ,{36,'employee_count_org_raw'}
      ,{37,'employee_count_org_derived'}
      ,{38,'revenue_org_raw'}
      ,{39,'revenue_org_derived'}
      ,{40,'employee_count_local_raw'}
      ,{41,'employee_count_local_derived'}
      ,{42,'revenue_local_raw'}
      ,{43,'revenue_local_derived'}
      ,{44,'locid'}
      ,{45,'source_docid'}
      ,{46,'title'}
      ,{47,'fname'}
      ,{48,'mname'}
      ,{49,'lname'}
      ,{50,'name_suffix'}
      ,{51,'name_score'}
      ,{52,'company_name'}
      ,{53,'company_name_type_raw'}
      ,{54,'company_name_type_derived'}
      ,{55,'company_rawaid'}
      ,{56,'prim_range'}
      ,{57,'predir'}
      ,{58,'prim_name'}
      ,{59,'addr_suffix'}
      ,{60,'postdir'}
      ,{61,'unit_desig'}
      ,{62,'sec_range'}
      ,{63,'p_city_name'}
      ,{64,'v_city_name'}
      ,{65,'st'}
      ,{66,'zip'}
      ,{67,'zip4'}
      ,{68,'cart'}
      ,{69,'cr_sort_sz'}
      ,{70,'lot'}
      ,{71,'lot_order'}
      ,{72,'dbpc'}
      ,{73,'chk_digit'}
      ,{74,'rec_type'}
      ,{75,'fips_state'}
      ,{76,'fips_county'}
      ,{77,'geo_lat'}
      ,{78,'geo_long'}
      ,{79,'msa'}
      ,{80,'geo_blk'}
      ,{81,'geo_match'}
      ,{82,'err_stat'}
      ,{83,'company_bdid'}
      ,{84,'company_address_type_raw'}
      ,{85,'company_fein'}
      ,{86,'best_fein_indicator'}
      ,{87,'company_phone'}
      ,{88,'phone_type'}
      ,{89,'phone_score'}
      ,{90,'company_org_structure_raw'}
      ,{91,'company_incorporation_date'}
      ,{92,'company_sic_code1'}
      ,{93,'company_sic_code2'}
      ,{94,'company_sic_code3'}
      ,{95,'company_sic_code4'}
      ,{96,'company_sic_code5'}
      ,{97,'company_naics_code1'}
      ,{98,'company_naics_code2'}
      ,{99,'company_naics_code3'}
      ,{100,'company_naics_code4'}
      ,{101,'company_naics_code5'}
      ,{102,'company_ticker'}
      ,{103,'company_ticker_exchange'}
      ,{104,'company_foreign_domestic'}
      ,{105,'company_url'}
      ,{106,'company_inc_state'}
      ,{107,'company_charter_number'}
      ,{108,'company_filing_date'}
      ,{109,'company_status_date'}
      ,{110,'company_foreign_date'}
      ,{111,'event_filing_date'}
      ,{112,'company_name_status_raw'}
      ,{113,'company_status_raw'}
      ,{114,'vl_id'}
      ,{115,'current'}
      ,{116,'contact_did'}
      ,{117,'contact_type_raw'}
      ,{118,'contact_job_title_raw'}
      ,{119,'contact_ssn'}
      ,{120,'contact_dob'}
      ,{121,'contact_status_raw'}
      ,{122,'contact_email'}
      ,{123,'contact_email_username'}
      ,{124,'contact_email_domain'}
      ,{125,'contact_phone'}
      ,{126,'from_hdr'}
      ,{127,'company_department'}
      ,{128,'company_address_type_derived'}
      ,{129,'company_org_structure_derived'}
      ,{130,'company_name_status_derived'}
      ,{131,'company_status_derived'}
      ,{132,'contact_type_derived'}
      ,{133,'contact_job_title_derived'}
      ,{134,'contact_status_derived'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_source((SALT35.StrType)le.source),
    Fields.InValid_source_record_id((SALT35.StrType)le.source_record_id),
    Fields.InValid_dt_first_seen((SALT35.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT35.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT35.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT35.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen_company_name((SALT35.StrType)le.dt_first_seen_company_name),
    Fields.InValid_dt_last_seen_company_name((SALT35.StrType)le.dt_last_seen_company_name),
    Fields.InValid_dt_first_seen_company_address((SALT35.StrType)le.dt_first_seen_company_address),
    Fields.InValid_dt_last_seen_company_address((SALT35.StrType)le.dt_last_seen_company_address),
    Fields.InValid_dt_first_seen_contact((SALT35.StrType)le.dt_first_seen_contact),
    Fields.InValid_dt_last_seen_contact((SALT35.StrType)le.dt_last_seen_contact),
    Fields.InValid_isContact((SALT35.StrType)le.isContact),
    Fields.InValid_iscorp((SALT35.StrType)le.iscorp),
    Fields.InValid_cnp_hasnumber((SALT35.StrType)le.cnp_hasnumber),
    Fields.InValid_cnp_name((SALT35.StrType)le.cnp_name),
    Fields.InValid_cnp_number((SALT35.StrType)le.cnp_number),
    Fields.InValid_cnp_btype((SALT35.StrType)le.cnp_btype),
    Fields.InValid_cnp_lowv((SALT35.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT35.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT35.StrType)le.cnp_classid),
    Fields.InValid_company_aceaid((SALT35.StrType)le.company_aceaid),
    Fields.InValid_corp_legal_name((SALT35.StrType)le.corp_legal_name),
    Fields.InValid_dba_name((SALT35.StrType)le.dba_name),
    Fields.InValid_active_duns_number((SALT35.StrType)le.active_duns_number),
    Fields.InValid_hist_duns_number((SALT35.StrType)le.hist_duns_number),
    Fields.InValid_active_enterprise_number((SALT35.StrType)le.active_enterprise_number),
    Fields.InValid_hist_enterprise_number((SALT35.StrType)le.hist_enterprise_number),
    Fields.InValid_ebr_file_number((SALT35.StrType)le.ebr_file_number),
    Fields.InValid_active_domestic_corp_key((SALT35.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT35.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT35.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT35.StrType)le.unk_corp_key),
    Fields.InValid_global_sid((SALT35.StrType)le.global_sid),
    Fields.InValid_record_sid((SALT35.StrType)le.record_sid),
    Fields.InValid_employee_count_org_raw((SALT35.StrType)le.employee_count_org_raw),
    Fields.InValid_employee_count_org_derived((SALT35.StrType)le.employee_count_org_derived),
    Fields.InValid_revenue_org_raw((SALT35.StrType)le.revenue_org_raw),
    Fields.InValid_revenue_org_derived((SALT35.StrType)le.revenue_org_derived),
    Fields.InValid_employee_count_local_raw((SALT35.StrType)le.employee_count_local_raw),
    Fields.InValid_employee_count_local_derived((SALT35.StrType)le.employee_count_local_derived),
    Fields.InValid_revenue_local_raw((SALT35.StrType)le.revenue_local_raw),
    Fields.InValid_revenue_local_derived((SALT35.StrType)le.revenue_local_derived),
    Fields.InValid_locid((SALT35.StrType)le.locid),
    Fields.InValid_source_docid((SALT35.StrType)le.source_docid),
    Fields.InValid_title((SALT35.StrType)le.title),
    Fields.InValid_fname((SALT35.StrType)le.fname),
    Fields.InValid_mname((SALT35.StrType)le.mname),
    Fields.InValid_lname((SALT35.StrType)le.lname),
    Fields.InValid_name_suffix((SALT35.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT35.StrType)le.name_score),
    Fields.InValid_company_name((SALT35.StrType)le.company_name),
    Fields.InValid_company_name_type_raw((SALT35.StrType)le.company_name_type_raw),
    Fields.InValid_company_name_type_derived((SALT35.StrType)le.company_name_type_derived),
    Fields.InValid_company_rawaid((SALT35.StrType)le.company_rawaid),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_predir((SALT35.StrType)le.predir),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT35.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT35.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT35.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT35.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_st((SALT35.StrType)le.st),
    Fields.InValid_zip((SALT35.StrType)le.zip),
    Fields.InValid_zip4((SALT35.StrType)le.zip4),
    Fields.InValid_cart((SALT35.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT35.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT35.StrType)le.lot),
    Fields.InValid_lot_order((SALT35.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT35.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT35.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT35.StrType)le.rec_type),
    Fields.InValid_fips_state((SALT35.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT35.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT35.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT35.StrType)le.geo_long),
    Fields.InValid_msa((SALT35.StrType)le.msa),
    Fields.InValid_geo_blk((SALT35.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT35.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT35.StrType)le.err_stat),
    Fields.InValid_company_bdid((SALT35.StrType)le.company_bdid),
    Fields.InValid_company_address_type_raw((SALT35.StrType)le.company_address_type_raw),
    Fields.InValid_company_fein((SALT35.StrType)le.company_fein),
    Fields.InValid_best_fein_indicator((SALT35.StrType)le.best_fein_indicator),
    Fields.InValid_company_phone((SALT35.StrType)le.company_phone),
    Fields.InValid_phone_type((SALT35.StrType)le.phone_type),
    Fields.InValid_phone_score((SALT35.StrType)le.phone_score),
    Fields.InValid_company_org_structure_raw((SALT35.StrType)le.company_org_structure_raw),
    Fields.InValid_company_incorporation_date((SALT35.StrType)le.company_incorporation_date),
    Fields.InValid_company_sic_code1((SALT35.StrType)le.company_sic_code1),
    Fields.InValid_company_sic_code2((SALT35.StrType)le.company_sic_code2),
    Fields.InValid_company_sic_code3((SALT35.StrType)le.company_sic_code3),
    Fields.InValid_company_sic_code4((SALT35.StrType)le.company_sic_code4),
    Fields.InValid_company_sic_code5((SALT35.StrType)le.company_sic_code5),
    Fields.InValid_company_naics_code1((SALT35.StrType)le.company_naics_code1),
    Fields.InValid_company_naics_code2((SALT35.StrType)le.company_naics_code2),
    Fields.InValid_company_naics_code3((SALT35.StrType)le.company_naics_code3),
    Fields.InValid_company_naics_code4((SALT35.StrType)le.company_naics_code4),
    Fields.InValid_company_naics_code5((SALT35.StrType)le.company_naics_code5),
    Fields.InValid_company_ticker((SALT35.StrType)le.company_ticker),
    Fields.InValid_company_ticker_exchange((SALT35.StrType)le.company_ticker_exchange),
    Fields.InValid_company_foreign_domestic((SALT35.StrType)le.company_foreign_domestic),
    Fields.InValid_company_url((SALT35.StrType)le.company_url),
    Fields.InValid_company_inc_state((SALT35.StrType)le.company_inc_state),
    Fields.InValid_company_charter_number((SALT35.StrType)le.company_charter_number),
    Fields.InValid_company_filing_date((SALT35.StrType)le.company_filing_date),
    Fields.InValid_company_status_date((SALT35.StrType)le.company_status_date),
    Fields.InValid_company_foreign_date((SALT35.StrType)le.company_foreign_date),
    Fields.InValid_event_filing_date((SALT35.StrType)le.event_filing_date),
    Fields.InValid_company_name_status_raw((SALT35.StrType)le.company_name_status_raw),
    Fields.InValid_company_status_raw((SALT35.StrType)le.company_status_raw),
    Fields.InValid_vl_id((SALT35.StrType)le.vl_id),
    Fields.InValid_current((SALT35.StrType)le.current),
    Fields.InValid_contact_did((SALT35.StrType)le.contact_did),
    Fields.InValid_contact_type_raw((SALT35.StrType)le.contact_type_raw),
    Fields.InValid_contact_job_title_raw((SALT35.StrType)le.contact_job_title_raw),
    Fields.InValid_contact_ssn((SALT35.StrType)le.contact_ssn),
    Fields.InValid_contact_dob((SALT35.StrType)le.contact_dob),
    Fields.InValid_contact_status_raw((SALT35.StrType)le.contact_status_raw),
    Fields.InValid_contact_email((SALT35.StrType)le.contact_email),
    Fields.InValid_contact_email_username((SALT35.StrType)le.contact_email_username),
    Fields.InValid_contact_email_domain((SALT35.StrType)le.contact_email_domain),
    Fields.InValid_contact_phone((SALT35.StrType)le.contact_phone),
    Fields.InValid_from_hdr((SALT35.StrType)le.from_hdr),
    Fields.InValid_company_department((SALT35.StrType)le.company_department),
    Fields.InValid_company_address_type_derived((SALT35.StrType)le.company_address_type_derived),
    Fields.InValid_company_org_structure_derived((SALT35.StrType)le.company_org_structure_derived),
    Fields.InValid_company_name_status_derived((SALT35.StrType)le.company_name_status_derived),
    Fields.InValid_company_status_derived((SALT35.StrType)le.company_status_derived),
    Fields.InValid_contact_type_derived((SALT35.StrType)le.contact_type_derived),
    Fields.InValid_contact_job_title_derived((SALT35.StrType)le.contact_job_title_derived),
    Fields.InValid_contact_status_derived((SALT35.StrType)le.contact_status_derived),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,134,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','fld_contact','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','number09','Unknown','number9','Unknown','number09','CORPKEY_FMT','Unknown','CORPKEY_FMT','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','NAME','NAME','NAME','WORDSTR','Unknown','Noblanks','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','CITY','alpha_st','zip5','hasZip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','number','Unknown','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','alpha02','NAME','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','SSN_FMT','Unknown','Unknown','EMAIL_FMT','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen_company_address(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen_company_address(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen_contact(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen_contact(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_iscorp(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasnumber(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_dba_name(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_ebr_file_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_record_sid(TotalErrors.ErrorNum),Fields.InValidMessage_employee_count_org_raw(TotalErrors.ErrorNum),Fields.InValidMessage_employee_count_org_derived(TotalErrors.ErrorNum),Fields.InValidMessage_revenue_org_raw(TotalErrors.ErrorNum),Fields.InValidMessage_revenue_org_derived(TotalErrors.ErrorNum),Fields.InValidMessage_employee_count_local_raw(TotalErrors.ErrorNum),Fields.InValidMessage_employee_count_local_derived(TotalErrors.ErrorNum),Fields.InValidMessage_revenue_local_raw(TotalErrors.ErrorNum),Fields.InValidMessage_revenue_local_derived(TotalErrors.ErrorNum),Fields.InValidMessage_locid(TotalErrors.ErrorNum),Fields.InValidMessage_source_docid(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_company_address_type_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_best_fein_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),Fields.InValidMessage_phone_score(TotalErrors.ErrorNum),Fields.InValidMessage_company_org_structure_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_incorporation_date(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code1(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code2(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code3(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code4(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code5(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code1(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code2(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code3(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code4(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code5(TotalErrors.ErrorNum),Fields.InValidMessage_company_ticker(TotalErrors.ErrorNum),Fields.InValidMessage_company_ticker_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_company_foreign_domestic(TotalErrors.ErrorNum),Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_company_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_company_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_company_foreign_date(TotalErrors.ErrorNum),Fields.InValidMessage_event_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_status_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_status_raw(TotalErrors.ErrorNum),Fields.InValidMessage_vl_id(TotalErrors.ErrorNum),Fields.InValidMessage_current(TotalErrors.ErrorNum),Fields.InValidMessage_contact_did(TotalErrors.ErrorNum),Fields.InValidMessage_contact_type_raw(TotalErrors.ErrorNum),Fields.InValidMessage_contact_job_title_raw(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_contact_dob(TotalErrors.ErrorNum),Fields.InValidMessage_contact_status_raw(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email_domain(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_from_hdr(TotalErrors.ErrorNum),Fields.InValidMessage_company_department(TotalErrors.ErrorNum),Fields.InValidMessage_company_address_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_org_structure_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_status_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_status_derived(TotalErrors.ErrorNum),Fields.InValidMessage_contact_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_contact_job_title_derived(TotalErrors.ErrorNum),Fields.InValidMessage_contact_status_derived(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have DOTid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT35.MOD_ClusterStats.Counts(h,DOTid);
EXPORT ClusterSrc := SALT35.MOD_ClusterStats.Sources(h,DOTid,source);
END;
