IMPORT ut,SALT31;
EXPORT hygiene(dataset(layout_Prof_License_Mari) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.std_source_upd);    NumberOfRecords := COUNT(GROUP);
    populated_primary_key_pcnt := AVE(GROUP,IF(h.primary_key = (TYPEOF(h.primary_key))'',0,100));
    maxlength_primary_key := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_key)));
    avelength_primary_key := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_key)),h.primary_key<>(typeof(h.primary_key))'');
    populated_create_dte_pcnt := AVE(GROUP,IF(h.create_dte = (TYPEOF(h.create_dte))'',0,100));
    maxlength_create_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.create_dte)));
    avelength_create_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.create_dte)),h.create_dte<>(typeof(h.create_dte))'');
    populated_last_upd_dte_pcnt := AVE(GROUP,IF(h.last_upd_dte = (TYPEOF(h.last_upd_dte))'',0,100));
    maxlength_last_upd_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.last_upd_dte)));
    avelength_last_upd_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.last_upd_dte)),h.last_upd_dte<>(typeof(h.last_upd_dte))'');
    populated_stamp_dte_pcnt := AVE(GROUP,IF(h.stamp_dte = (TYPEOF(h.stamp_dte))'',0,100));
    maxlength_stamp_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.stamp_dte)));
    avelength_stamp_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.stamp_dte)),h.stamp_dte<>(typeof(h.stamp_dte))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_gen_nbr_pcnt := AVE(GROUP,IF(h.gen_nbr = (TYPEOF(h.gen_nbr))'',0,100));
    maxlength_gen_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gen_nbr)));
    avelength_gen_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gen_nbr)),h.gen_nbr<>(typeof(h.gen_nbr))'');
    populated_std_prof_cd_pcnt := AVE(GROUP,IF(h.std_prof_cd = (TYPEOF(h.std_prof_cd))'',0,100));
    maxlength_std_prof_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_prof_cd)));
    avelength_std_prof_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_prof_cd)),h.std_prof_cd<>(typeof(h.std_prof_cd))'');
    populated_std_prof_desc_pcnt := AVE(GROUP,IF(h.std_prof_desc = (TYPEOF(h.std_prof_desc))'',0,100));
    maxlength_std_prof_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_prof_desc)));
    avelength_std_prof_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_prof_desc)),h.std_prof_desc<>(typeof(h.std_prof_desc))'');
    populated_std_source_upd_pcnt := AVE(GROUP,IF(h.std_source_upd = (TYPEOF(h.std_source_upd))'',0,100));
    maxlength_std_source_upd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_source_upd)));
    avelength_std_source_upd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_source_upd)),h.std_source_upd<>(typeof(h.std_source_upd))'');
    populated_std_source_desc_pcnt := AVE(GROUP,IF(h.std_source_desc = (TYPEOF(h.std_source_desc))'',0,100));
    maxlength_std_source_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_source_desc)));
    avelength_std_source_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_source_desc)),h.std_source_desc<>(typeof(h.std_source_desc))'');
    populated_type_cd_pcnt := AVE(GROUP,IF(h.type_cd = (TYPEOF(h.type_cd))'',0,100));
    maxlength_type_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_cd)));
    avelength_type_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_cd)),h.type_cd<>(typeof(h.type_cd))'');
    populated_name_org_prefx_pcnt := AVE(GROUP,IF(h.name_org_prefx = (TYPEOF(h.name_org_prefx))'',0,100));
    maxlength_name_org_prefx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_prefx)));
    avelength_name_org_prefx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_prefx)),h.name_org_prefx<>(typeof(h.name_org_prefx))'');
    populated_name_org_pcnt := AVE(GROUP,IF(h.name_org = (TYPEOF(h.name_org))'',0,100));
    maxlength_name_org := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org)));
    avelength_name_org := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org)),h.name_org<>(typeof(h.name_org))'');
    populated_name_org_sufx_pcnt := AVE(GROUP,IF(h.name_org_sufx = (TYPEOF(h.name_org_sufx))'',0,100));
    maxlength_name_org_sufx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_sufx)));
    avelength_name_org_sufx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_sufx)),h.name_org_sufx<>(typeof(h.name_org_sufx))'');
    populated_store_nbr_pcnt := AVE(GROUP,IF(h.store_nbr = (TYPEOF(h.store_nbr))'',0,100));
    maxlength_store_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.store_nbr)));
    avelength_store_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.store_nbr)),h.store_nbr<>(typeof(h.store_nbr))'');
    populated_name_dba_prefx_pcnt := AVE(GROUP,IF(h.name_dba_prefx = (TYPEOF(h.name_dba_prefx))'',0,100));
    maxlength_name_dba_prefx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_prefx)));
    avelength_name_dba_prefx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_prefx)),h.name_dba_prefx<>(typeof(h.name_dba_prefx))'');
    populated_name_dba_pcnt := AVE(GROUP,IF(h.name_dba = (TYPEOF(h.name_dba))'',0,100));
    maxlength_name_dba := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba)));
    avelength_name_dba := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba)),h.name_dba<>(typeof(h.name_dba))'');
    populated_name_dba_sufx_pcnt := AVE(GROUP,IF(h.name_dba_sufx = (TYPEOF(h.name_dba_sufx))'',0,100));
    maxlength_name_dba_sufx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_sufx)));
    avelength_name_dba_sufx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_sufx)),h.name_dba_sufx<>(typeof(h.name_dba_sufx))'');
    populated_store_nbr_dba_pcnt := AVE(GROUP,IF(h.store_nbr_dba = (TYPEOF(h.store_nbr_dba))'',0,100));
    maxlength_store_nbr_dba := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.store_nbr_dba)));
    avelength_store_nbr_dba := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.store_nbr_dba)),h.store_nbr_dba<>(typeof(h.store_nbr_dba))'');
    populated_dba_flag_pcnt := AVE(GROUP,IF(h.dba_flag = (TYPEOF(h.dba_flag))'',0,100));
    maxlength_dba_flag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dba_flag)));
    avelength_dba_flag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dba_flag)),h.dba_flag<>(typeof(h.dba_flag))'');
    populated_name_office_pcnt := AVE(GROUP,IF(h.name_office = (TYPEOF(h.name_office))'',0,100));
    maxlength_name_office := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_office)));
    avelength_name_office := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_office)),h.name_office<>(typeof(h.name_office))'');
    populated_office_parse_pcnt := AVE(GROUP,IF(h.office_parse = (TYPEOF(h.office_parse))'',0,100));
    maxlength_office_parse := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.office_parse)));
    avelength_office_parse := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.office_parse)),h.office_parse<>(typeof(h.office_parse))'');
    populated_name_prefx_pcnt := AVE(GROUP,IF(h.name_prefx = (TYPEOF(h.name_prefx))'',0,100));
    maxlength_name_prefx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_prefx)));
    avelength_name_prefx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_prefx)),h.name_prefx<>(typeof(h.name_prefx))'');
    populated_name_first_pcnt := AVE(GROUP,IF(h.name_first = (TYPEOF(h.name_first))'',0,100));
    maxlength_name_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_first)));
    avelength_name_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_first)),h.name_first<>(typeof(h.name_first))'');
    populated_name_mid_pcnt := AVE(GROUP,IF(h.name_mid = (TYPEOF(h.name_mid))'',0,100));
    maxlength_name_mid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mid)));
    avelength_name_mid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mid)),h.name_mid<>(typeof(h.name_mid))'');
    populated_name_last_pcnt := AVE(GROUP,IF(h.name_last = (TYPEOF(h.name_last))'',0,100));
    maxlength_name_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_last)));
    avelength_name_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_last)),h.name_last<>(typeof(h.name_last))'');
    populated_name_sufx_pcnt := AVE(GROUP,IF(h.name_sufx = (TYPEOF(h.name_sufx))'',0,100));
    maxlength_name_sufx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_sufx)));
    avelength_name_sufx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_sufx)),h.name_sufx<>(typeof(h.name_sufx))'');
    populated_name_nick_pcnt := AVE(GROUP,IF(h.name_nick = (TYPEOF(h.name_nick))'',0,100));
    maxlength_name_nick := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_nick)));
    avelength_name_nick := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_nick)),h.name_nick<>(typeof(h.name_nick))'');
    populated_birth_dte_pcnt := AVE(GROUP,IF(h.birth_dte = (TYPEOF(h.birth_dte))'',0,100));
    maxlength_birth_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.birth_dte)));
    avelength_birth_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.birth_dte)),h.birth_dte<>(typeof(h.birth_dte))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_prov_stat_pcnt := AVE(GROUP,IF(h.prov_stat = (TYPEOF(h.prov_stat))'',0,100));
    maxlength_prov_stat := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_stat)));
    avelength_prov_stat := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_stat)),h.prov_stat<>(typeof(h.prov_stat))'');
    populated_credential_pcnt := AVE(GROUP,IF(h.credential = (TYPEOF(h.credential))'',0,100));
    maxlength_credential := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.credential)));
    avelength_credential := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.credential)),h.credential<>(typeof(h.credential))'');
    populated_license_nbr_pcnt := AVE(GROUP,IF(h.license_nbr = (TYPEOF(h.license_nbr))'',0,100));
    maxlength_license_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_nbr)));
    avelength_license_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_nbr)),h.license_nbr<>(typeof(h.license_nbr))'');
    populated_off_license_nbr_pcnt := AVE(GROUP,IF(h.off_license_nbr = (TYPEOF(h.off_license_nbr))'',0,100));
    maxlength_off_license_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.off_license_nbr)));
    avelength_off_license_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.off_license_nbr)),h.off_license_nbr<>(typeof(h.off_license_nbr))'');
    populated_prev_license_nbr_pcnt := AVE(GROUP,IF(h.prev_license_nbr = (TYPEOF(h.prev_license_nbr))'',0,100));
    maxlength_prev_license_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_license_nbr)));
    avelength_prev_license_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_license_nbr)),h.prev_license_nbr<>(typeof(h.prev_license_nbr))'');
    populated_prev_license_type_pcnt := AVE(GROUP,IF(h.prev_license_type = (TYPEOF(h.prev_license_type))'',0,100));
    maxlength_prev_license_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_license_type)));
    avelength_prev_license_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_license_type)),h.prev_license_type<>(typeof(h.prev_license_type))'');
    populated_license_state_pcnt := AVE(GROUP,IF(h.license_state = (TYPEOF(h.license_state))'',0,100));
    maxlength_license_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_state)));
    avelength_license_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_state)),h.license_state<>(typeof(h.license_state))'');
    populated_raw_license_type_pcnt := AVE(GROUP,IF(h.raw_license_type = (TYPEOF(h.raw_license_type))'',0,100));
    maxlength_raw_license_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_license_type)));
    avelength_raw_license_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_license_type)),h.raw_license_type<>(typeof(h.raw_license_type))'');
    populated_std_license_type_pcnt := AVE(GROUP,IF(h.std_license_type = (TYPEOF(h.std_license_type))'',0,100));
    maxlength_std_license_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_type)));
    avelength_std_license_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_type)),h.std_license_type<>(typeof(h.std_license_type))'');
    populated_std_license_desc_pcnt := AVE(GROUP,IF(h.std_license_desc = (TYPEOF(h.std_license_desc))'',0,100));
    maxlength_std_license_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_desc)));
    avelength_std_license_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_desc)),h.std_license_desc<>(typeof(h.std_license_desc))'');
    populated_raw_license_status_pcnt := AVE(GROUP,IF(h.raw_license_status = (TYPEOF(h.raw_license_status))'',0,100));
    maxlength_raw_license_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_license_status)));
    avelength_raw_license_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_license_status)),h.raw_license_status<>(typeof(h.raw_license_status))'');
    populated_std_license_status_pcnt := AVE(GROUP,IF(h.std_license_status = (TYPEOF(h.std_license_status))'',0,100));
    maxlength_std_license_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_status)));
    avelength_std_license_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_license_status)),h.std_license_status<>(typeof(h.std_license_status))'');
    populated_std_status_desc_pcnt := AVE(GROUP,IF(h.std_status_desc = (TYPEOF(h.std_status_desc))'',0,100));
    maxlength_std_status_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_status_desc)));
    avelength_std_status_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_status_desc)),h.std_status_desc<>(typeof(h.std_status_desc))'');
    populated_curr_issue_dte_pcnt := AVE(GROUP,IF(h.curr_issue_dte = (TYPEOF(h.curr_issue_dte))'',0,100));
    maxlength_curr_issue_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.curr_issue_dte)));
    avelength_curr_issue_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.curr_issue_dte)),h.curr_issue_dte<>(typeof(h.curr_issue_dte))'');
    populated_orig_issue_dte_pcnt := AVE(GROUP,IF(h.orig_issue_dte = (TYPEOF(h.orig_issue_dte))'',0,100));
    maxlength_orig_issue_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_issue_dte)));
    avelength_orig_issue_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_issue_dte)),h.orig_issue_dte<>(typeof(h.orig_issue_dte))'');
    populated_expire_dte_pcnt := AVE(GROUP,IF(h.expire_dte = (TYPEOF(h.expire_dte))'',0,100));
    maxlength_expire_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.expire_dte)));
    avelength_expire_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.expire_dte)),h.expire_dte<>(typeof(h.expire_dte))'');
    populated_renewal_dte_pcnt := AVE(GROUP,IF(h.renewal_dte = (TYPEOF(h.renewal_dte))'',0,100));
    maxlength_renewal_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_dte)));
    avelength_renewal_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_dte)),h.renewal_dte<>(typeof(h.renewal_dte))'');
    populated_active_flag_pcnt := AVE(GROUP,IF(h.active_flag = (TYPEOF(h.active_flag))'',0,100));
    maxlength_active_flag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_flag)));
    avelength_active_flag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.active_flag)),h.active_flag<>(typeof(h.active_flag))'');
    populated_ssn_taxid_1_pcnt := AVE(GROUP,IF(h.ssn_taxid_1 = (TYPEOF(h.ssn_taxid_1))'',0,100));
    maxlength_ssn_taxid_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ssn_taxid_1)));
    avelength_ssn_taxid_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ssn_taxid_1)),h.ssn_taxid_1<>(typeof(h.ssn_taxid_1))'');
    populated_tax_type_1_pcnt := AVE(GROUP,IF(h.tax_type_1 = (TYPEOF(h.tax_type_1))'',0,100));
    maxlength_tax_type_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.tax_type_1)));
    avelength_tax_type_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.tax_type_1)),h.tax_type_1<>(typeof(h.tax_type_1))'');
    populated_ssn_taxid_2_pcnt := AVE(GROUP,IF(h.ssn_taxid_2 = (TYPEOF(h.ssn_taxid_2))'',0,100));
    maxlength_ssn_taxid_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ssn_taxid_2)));
    avelength_ssn_taxid_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ssn_taxid_2)),h.ssn_taxid_2<>(typeof(h.ssn_taxid_2))'');
    populated_tax_type_2_pcnt := AVE(GROUP,IF(h.tax_type_2 = (TYPEOF(h.tax_type_2))'',0,100));
    maxlength_tax_type_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.tax_type_2)));
    avelength_tax_type_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.tax_type_2)),h.tax_type_2<>(typeof(h.tax_type_2))'');
    populated_fed_rssd_pcnt := AVE(GROUP,IF(h.fed_rssd = (TYPEOF(h.fed_rssd))'',0,100));
    maxlength_fed_rssd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fed_rssd)));
    avelength_fed_rssd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fed_rssd)),h.fed_rssd<>(typeof(h.fed_rssd))'');
    populated_addr_bus_ind_pcnt := AVE(GROUP,IF(h.addr_bus_ind = (TYPEOF(h.addr_bus_ind))'',0,100));
    maxlength_addr_bus_ind := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_bus_ind)));
    avelength_addr_bus_ind := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_bus_ind)),h.addr_bus_ind<>(typeof(h.addr_bus_ind))'');
    populated_name_format_pcnt := AVE(GROUP,IF(h.name_format = (TYPEOF(h.name_format))'',0,100));
    maxlength_name_format := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_format)));
    avelength_name_format := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_format)),h.name_format<>(typeof(h.name_format))'');
    populated_name_org_orig_pcnt := AVE(GROUP,IF(h.name_org_orig = (TYPEOF(h.name_org_orig))'',0,100));
    maxlength_name_org_orig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_orig)));
    avelength_name_org_orig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_org_orig)),h.name_org_orig<>(typeof(h.name_org_orig))'');
    populated_name_dba_orig_pcnt := AVE(GROUP,IF(h.name_dba_orig = (TYPEOF(h.name_dba_orig))'',0,100));
    maxlength_name_dba_orig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_orig)));
    avelength_name_dba_orig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_dba_orig)),h.name_dba_orig<>(typeof(h.name_dba_orig))'');
    populated_name_mari_org_pcnt := AVE(GROUP,IF(h.name_mari_org = (TYPEOF(h.name_mari_org))'',0,100));
    maxlength_name_mari_org := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mari_org)));
    avelength_name_mari_org := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mari_org)),h.name_mari_org<>(typeof(h.name_mari_org))'');
    populated_name_mari_dba_pcnt := AVE(GROUP,IF(h.name_mari_dba = (TYPEOF(h.name_mari_dba))'',0,100));
    maxlength_name_mari_dba := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mari_dba)));
    avelength_name_mari_dba := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_mari_dba)),h.name_mari_dba<>(typeof(h.name_mari_dba))'');
    populated_phn_mari_1_pcnt := AVE(GROUP,IF(h.phn_mari_1 = (TYPEOF(h.phn_mari_1))'',0,100));
    maxlength_phn_mari_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_1)));
    avelength_phn_mari_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_1)),h.phn_mari_1<>(typeof(h.phn_mari_1))'');
    populated_phn_mari_fax_1_pcnt := AVE(GROUP,IF(h.phn_mari_fax_1 = (TYPEOF(h.phn_mari_fax_1))'',0,100));
    maxlength_phn_mari_fax_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_fax_1)));
    avelength_phn_mari_fax_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_fax_1)),h.phn_mari_fax_1<>(typeof(h.phn_mari_fax_1))'');
    populated_phn_mari_2_pcnt := AVE(GROUP,IF(h.phn_mari_2 = (TYPEOF(h.phn_mari_2))'',0,100));
    maxlength_phn_mari_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_2)));
    avelength_phn_mari_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_2)),h.phn_mari_2<>(typeof(h.phn_mari_2))'');
    populated_phn_mari_fax_2_pcnt := AVE(GROUP,IF(h.phn_mari_fax_2 = (TYPEOF(h.phn_mari_fax_2))'',0,100));
    maxlength_phn_mari_fax_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_fax_2)));
    avelength_phn_mari_fax_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_mari_fax_2)),h.phn_mari_fax_2<>(typeof(h.phn_mari_fax_2))'');
    populated_addr_addr1_1_pcnt := AVE(GROUP,IF(h.addr_addr1_1 = (TYPEOF(h.addr_addr1_1))'',0,100));
    maxlength_addr_addr1_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr1_1)));
    avelength_addr_addr1_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr1_1)),h.addr_addr1_1<>(typeof(h.addr_addr1_1))'');
    populated_addr_addr2_1_pcnt := AVE(GROUP,IF(h.addr_addr2_1 = (TYPEOF(h.addr_addr2_1))'',0,100));
    maxlength_addr_addr2_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr2_1)));
    avelength_addr_addr2_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr2_1)),h.addr_addr2_1<>(typeof(h.addr_addr2_1))'');
    populated_addr_addr3_1_pcnt := AVE(GROUP,IF(h.addr_addr3_1 = (TYPEOF(h.addr_addr3_1))'',0,100));
    maxlength_addr_addr3_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr3_1)));
    avelength_addr_addr3_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr3_1)),h.addr_addr3_1<>(typeof(h.addr_addr3_1))'');
    populated_addr_addr4_1_pcnt := AVE(GROUP,IF(h.addr_addr4_1 = (TYPEOF(h.addr_addr4_1))'',0,100));
    maxlength_addr_addr4_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr4_1)));
    avelength_addr_addr4_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr4_1)),h.addr_addr4_1<>(typeof(h.addr_addr4_1))'');
    populated_addr_city_1_pcnt := AVE(GROUP,IF(h.addr_city_1 = (TYPEOF(h.addr_city_1))'',0,100));
    maxlength_addr_city_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_city_1)));
    avelength_addr_city_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_city_1)),h.addr_city_1<>(typeof(h.addr_city_1))'');
    populated_addr_state_1_pcnt := AVE(GROUP,IF(h.addr_state_1 = (TYPEOF(h.addr_state_1))'',0,100));
    maxlength_addr_state_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_state_1)));
    avelength_addr_state_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_state_1)),h.addr_state_1<>(typeof(h.addr_state_1))'');
    populated_addr_zip5_1_pcnt := AVE(GROUP,IF(h.addr_zip5_1 = (TYPEOF(h.addr_zip5_1))'',0,100));
    maxlength_addr_zip5_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip5_1)));
    avelength_addr_zip5_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip5_1)),h.addr_zip5_1<>(typeof(h.addr_zip5_1))'');
    populated_addr_zip4_1_pcnt := AVE(GROUP,IF(h.addr_zip4_1 = (TYPEOF(h.addr_zip4_1))'',0,100));
    maxlength_addr_zip4_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip4_1)));
    avelength_addr_zip4_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip4_1)),h.addr_zip4_1<>(typeof(h.addr_zip4_1))'');
    populated_phn_phone_1_pcnt := AVE(GROUP,IF(h.phn_phone_1 = (TYPEOF(h.phn_phone_1))'',0,100));
    maxlength_phn_phone_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_phone_1)));
    avelength_phn_phone_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_phone_1)),h.phn_phone_1<>(typeof(h.phn_phone_1))'');
    populated_phn_fax_1_pcnt := AVE(GROUP,IF(h.phn_fax_1 = (TYPEOF(h.phn_fax_1))'',0,100));
    maxlength_phn_fax_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_fax_1)));
    avelength_phn_fax_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_fax_1)),h.phn_fax_1<>(typeof(h.phn_fax_1))'');
    populated_addr_cnty_1_pcnt := AVE(GROUP,IF(h.addr_cnty_1 = (TYPEOF(h.addr_cnty_1))'',0,100));
    maxlength_addr_cnty_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cnty_1)));
    avelength_addr_cnty_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cnty_1)),h.addr_cnty_1<>(typeof(h.addr_cnty_1))'');
    populated_addr_cntry_1_pcnt := AVE(GROUP,IF(h.addr_cntry_1 = (TYPEOF(h.addr_cntry_1))'',0,100));
    maxlength_addr_cntry_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cntry_1)));
    avelength_addr_cntry_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cntry_1)),h.addr_cntry_1<>(typeof(h.addr_cntry_1))'');
    populated_sud_key_1_pcnt := AVE(GROUP,IF(h.sud_key_1 = (TYPEOF(h.sud_key_1))'',0,100));
    maxlength_sud_key_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sud_key_1)));
    avelength_sud_key_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sud_key_1)),h.sud_key_1<>(typeof(h.sud_key_1))'');
    populated_ooc_ind_1_pcnt := AVE(GROUP,IF(h.ooc_ind_1 = (TYPEOF(h.ooc_ind_1))'',0,100));
    maxlength_ooc_ind_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ooc_ind_1)));
    avelength_ooc_ind_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ooc_ind_1)),h.ooc_ind_1<>(typeof(h.ooc_ind_1))'');
    populated_addr_mail_ind_pcnt := AVE(GROUP,IF(h.addr_mail_ind = (TYPEOF(h.addr_mail_ind))'',0,100));
    maxlength_addr_mail_ind := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_mail_ind)));
    avelength_addr_mail_ind := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_mail_ind)),h.addr_mail_ind<>(typeof(h.addr_mail_ind))'');
    populated_addr_addr1_2_pcnt := AVE(GROUP,IF(h.addr_addr1_2 = (TYPEOF(h.addr_addr1_2))'',0,100));
    maxlength_addr_addr1_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr1_2)));
    avelength_addr_addr1_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr1_2)),h.addr_addr1_2<>(typeof(h.addr_addr1_2))'');
    populated_addr_addr2_2_pcnt := AVE(GROUP,IF(h.addr_addr2_2 = (TYPEOF(h.addr_addr2_2))'',0,100));
    maxlength_addr_addr2_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr2_2)));
    avelength_addr_addr2_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr2_2)),h.addr_addr2_2<>(typeof(h.addr_addr2_2))'');
    populated_addr_addr3_2_pcnt := AVE(GROUP,IF(h.addr_addr3_2 = (TYPEOF(h.addr_addr3_2))'',0,100));
    maxlength_addr_addr3_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr3_2)));
    avelength_addr_addr3_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr3_2)),h.addr_addr3_2<>(typeof(h.addr_addr3_2))'');
    populated_addr_addr4_2_pcnt := AVE(GROUP,IF(h.addr_addr4_2 = (TYPEOF(h.addr_addr4_2))'',0,100));
    maxlength_addr_addr4_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr4_2)));
    avelength_addr_addr4_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_addr4_2)),h.addr_addr4_2<>(typeof(h.addr_addr4_2))'');
    populated_addr_city_2_pcnt := AVE(GROUP,IF(h.addr_city_2 = (TYPEOF(h.addr_city_2))'',0,100));
    maxlength_addr_city_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_city_2)));
    avelength_addr_city_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_city_2)),h.addr_city_2<>(typeof(h.addr_city_2))'');
    populated_addr_state_2_pcnt := AVE(GROUP,IF(h.addr_state_2 = (TYPEOF(h.addr_state_2))'',0,100));
    maxlength_addr_state_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_state_2)));
    avelength_addr_state_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_state_2)),h.addr_state_2<>(typeof(h.addr_state_2))'');
    populated_addr_zip5_2_pcnt := AVE(GROUP,IF(h.addr_zip5_2 = (TYPEOF(h.addr_zip5_2))'',0,100));
    maxlength_addr_zip5_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip5_2)));
    avelength_addr_zip5_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip5_2)),h.addr_zip5_2<>(typeof(h.addr_zip5_2))'');
    populated_addr_zip4_2_pcnt := AVE(GROUP,IF(h.addr_zip4_2 = (TYPEOF(h.addr_zip4_2))'',0,100));
    maxlength_addr_zip4_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip4_2)));
    avelength_addr_zip4_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_zip4_2)),h.addr_zip4_2<>(typeof(h.addr_zip4_2))'');
    populated_addr_cnty_2_pcnt := AVE(GROUP,IF(h.addr_cnty_2 = (TYPEOF(h.addr_cnty_2))'',0,100));
    maxlength_addr_cnty_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cnty_2)));
    avelength_addr_cnty_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cnty_2)),h.addr_cnty_2<>(typeof(h.addr_cnty_2))'');
    populated_addr_cntry_2_pcnt := AVE(GROUP,IF(h.addr_cntry_2 = (TYPEOF(h.addr_cntry_2))'',0,100));
    maxlength_addr_cntry_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cntry_2)));
    avelength_addr_cntry_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_cntry_2)),h.addr_cntry_2<>(typeof(h.addr_cntry_2))'');
    populated_phn_phone_2_pcnt := AVE(GROUP,IF(h.phn_phone_2 = (TYPEOF(h.phn_phone_2))'',0,100));
    maxlength_phn_phone_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_phone_2)));
    avelength_phn_phone_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_phone_2)),h.phn_phone_2<>(typeof(h.phn_phone_2))'');
    populated_phn_fax_2_pcnt := AVE(GROUP,IF(h.phn_fax_2 = (TYPEOF(h.phn_fax_2))'',0,100));
    maxlength_phn_fax_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_fax_2)));
    avelength_phn_fax_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_fax_2)),h.phn_fax_2<>(typeof(h.phn_fax_2))'');
    populated_sud_key_2_pcnt := AVE(GROUP,IF(h.sud_key_2 = (TYPEOF(h.sud_key_2))'',0,100));
    maxlength_sud_key_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sud_key_2)));
    avelength_sud_key_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sud_key_2)),h.sud_key_2<>(typeof(h.sud_key_2))'');
    populated_ooc_ind_2_pcnt := AVE(GROUP,IF(h.ooc_ind_2 = (TYPEOF(h.ooc_ind_2))'',0,100));
    maxlength_ooc_ind_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ooc_ind_2)));
    avelength_ooc_ind_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ooc_ind_2)),h.ooc_ind_2<>(typeof(h.ooc_ind_2))'');
    populated_license_nbr_contact_pcnt := AVE(GROUP,IF(h.license_nbr_contact = (TYPEOF(h.license_nbr_contact))'',0,100));
    maxlength_license_nbr_contact := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_nbr_contact)));
    avelength_license_nbr_contact := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_nbr_contact)),h.license_nbr_contact<>(typeof(h.license_nbr_contact))'');
    populated_name_contact_prefx_pcnt := AVE(GROUP,IF(h.name_contact_prefx = (TYPEOF(h.name_contact_prefx))'',0,100));
    maxlength_name_contact_prefx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_prefx)));
    avelength_name_contact_prefx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_prefx)),h.name_contact_prefx<>(typeof(h.name_contact_prefx))'');
    populated_name_contact_first_pcnt := AVE(GROUP,IF(h.name_contact_first = (TYPEOF(h.name_contact_first))'',0,100));
    maxlength_name_contact_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_first)));
    avelength_name_contact_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_first)),h.name_contact_first<>(typeof(h.name_contact_first))'');
    populated_name_contact_mid_pcnt := AVE(GROUP,IF(h.name_contact_mid = (TYPEOF(h.name_contact_mid))'',0,100));
    maxlength_name_contact_mid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_mid)));
    avelength_name_contact_mid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_mid)),h.name_contact_mid<>(typeof(h.name_contact_mid))'');
    populated_name_contact_last_pcnt := AVE(GROUP,IF(h.name_contact_last = (TYPEOF(h.name_contact_last))'',0,100));
    maxlength_name_contact_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_last)));
    avelength_name_contact_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_last)),h.name_contact_last<>(typeof(h.name_contact_last))'');
    populated_name_contact_sufx_pcnt := AVE(GROUP,IF(h.name_contact_sufx = (TYPEOF(h.name_contact_sufx))'',0,100));
    maxlength_name_contact_sufx := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_sufx)));
    avelength_name_contact_sufx := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_sufx)),h.name_contact_sufx<>(typeof(h.name_contact_sufx))'');
    populated_name_contact_nick_pcnt := AVE(GROUP,IF(h.name_contact_nick = (TYPEOF(h.name_contact_nick))'',0,100));
    maxlength_name_contact_nick := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_nick)));
    avelength_name_contact_nick := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_nick)),h.name_contact_nick<>(typeof(h.name_contact_nick))'');
    populated_name_contact_ttl_pcnt := AVE(GROUP,IF(h.name_contact_ttl = (TYPEOF(h.name_contact_ttl))'',0,100));
    maxlength_name_contact_ttl := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_ttl)));
    avelength_name_contact_ttl := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_contact_ttl)),h.name_contact_ttl<>(typeof(h.name_contact_ttl))'');
    populated_phn_contact_pcnt := AVE(GROUP,IF(h.phn_contact = (TYPEOF(h.phn_contact))'',0,100));
    maxlength_phn_contact := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact)));
    avelength_phn_contact := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact)),h.phn_contact<>(typeof(h.phn_contact))'');
    populated_phn_contact_ext_pcnt := AVE(GROUP,IF(h.phn_contact_ext = (TYPEOF(h.phn_contact_ext))'',0,100));
    maxlength_phn_contact_ext := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact_ext)));
    avelength_phn_contact_ext := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact_ext)),h.phn_contact_ext<>(typeof(h.phn_contact_ext))'');
    populated_phn_contact_fax_pcnt := AVE(GROUP,IF(h.phn_contact_fax = (TYPEOF(h.phn_contact_fax))'',0,100));
    maxlength_phn_contact_fax := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact_fax)));
    avelength_phn_contact_fax := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phn_contact_fax)),h.phn_contact_fax<>(typeof(h.phn_contact_fax))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_bk_class_pcnt := AVE(GROUP,IF(h.bk_class = (TYPEOF(h.bk_class))'',0,100));
    maxlength_bk_class := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bk_class)));
    avelength_bk_class := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bk_class)),h.bk_class<>(typeof(h.bk_class))'');
    populated_bk_class_desc_pcnt := AVE(GROUP,IF(h.bk_class_desc = (TYPEOF(h.bk_class_desc))'',0,100));
    maxlength_bk_class_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bk_class_desc)));
    avelength_bk_class_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bk_class_desc)),h.bk_class_desc<>(typeof(h.bk_class_desc))'');
    populated_charter_pcnt := AVE(GROUP,IF(h.charter = (TYPEOF(h.charter))'',0,100));
    maxlength_charter := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.charter)));
    avelength_charter := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.charter)),h.charter<>(typeof(h.charter))'');
    populated_inst_beg_dte_pcnt := AVE(GROUP,IF(h.inst_beg_dte = (TYPEOF(h.inst_beg_dte))'',0,100));
    maxlength_inst_beg_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.inst_beg_dte)));
    avelength_inst_beg_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.inst_beg_dte)),h.inst_beg_dte<>(typeof(h.inst_beg_dte))'');
    populated_origin_cd_pcnt := AVE(GROUP,IF(h.origin_cd = (TYPEOF(h.origin_cd))'',0,100));
    maxlength_origin_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.origin_cd)));
    avelength_origin_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.origin_cd)),h.origin_cd<>(typeof(h.origin_cd))'');
    populated_origin_cd_desc_pcnt := AVE(GROUP,IF(h.origin_cd_desc = (TYPEOF(h.origin_cd_desc))'',0,100));
    maxlength_origin_cd_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.origin_cd_desc)));
    avelength_origin_cd_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.origin_cd_desc)),h.origin_cd_desc<>(typeof(h.origin_cd_desc))'');
    populated_disp_type_cd_pcnt := AVE(GROUP,IF(h.disp_type_cd = (TYPEOF(h.disp_type_cd))'',0,100));
    maxlength_disp_type_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.disp_type_cd)));
    avelength_disp_type_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.disp_type_cd)),h.disp_type_cd<>(typeof(h.disp_type_cd))'');
    populated_disp_type_desc_pcnt := AVE(GROUP,IF(h.disp_type_desc = (TYPEOF(h.disp_type_desc))'',0,100));
    maxlength_disp_type_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.disp_type_desc)));
    avelength_disp_type_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.disp_type_desc)),h.disp_type_desc<>(typeof(h.disp_type_desc))'');
    populated_reg_agent_pcnt := AVE(GROUP,IF(h.reg_agent = (TYPEOF(h.reg_agent))'',0,100));
    maxlength_reg_agent := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.reg_agent)));
    avelength_reg_agent := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.reg_agent)),h.reg_agent<>(typeof(h.reg_agent))'');
    populated_regulator_pcnt := AVE(GROUP,IF(h.regulator = (TYPEOF(h.regulator))'',0,100));
    maxlength_regulator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.regulator)));
    avelength_regulator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.regulator)),h.regulator<>(typeof(h.regulator))'');
    populated_hqtr_city_pcnt := AVE(GROUP,IF(h.hqtr_city = (TYPEOF(h.hqtr_city))'',0,100));
    maxlength_hqtr_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hqtr_city)));
    avelength_hqtr_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hqtr_city)),h.hqtr_city<>(typeof(h.hqtr_city))'');
    populated_hqtr_name_pcnt := AVE(GROUP,IF(h.hqtr_name = (TYPEOF(h.hqtr_name))'',0,100));
    maxlength_hqtr_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hqtr_name)));
    avelength_hqtr_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hqtr_name)),h.hqtr_name<>(typeof(h.hqtr_name))'');
    populated_domestic_off_nbr_pcnt := AVE(GROUP,IF(h.domestic_off_nbr = (TYPEOF(h.domestic_off_nbr))'',0,100));
    maxlength_domestic_off_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.domestic_off_nbr)));
    avelength_domestic_off_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.domestic_off_nbr)),h.domestic_off_nbr<>(typeof(h.domestic_off_nbr))'');
    populated_foreign_off_nbr_pcnt := AVE(GROUP,IF(h.foreign_off_nbr = (TYPEOF(h.foreign_off_nbr))'',0,100));
    maxlength_foreign_off_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.foreign_off_nbr)));
    avelength_foreign_off_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.foreign_off_nbr)),h.foreign_off_nbr<>(typeof(h.foreign_off_nbr))'');
    populated_hcr_rssd_pcnt := AVE(GROUP,IF(h.hcr_rssd = (TYPEOF(h.hcr_rssd))'',0,100));
    maxlength_hcr_rssd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hcr_rssd)));
    avelength_hcr_rssd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hcr_rssd)),h.hcr_rssd<>(typeof(h.hcr_rssd))'');
    populated_hcr_location_pcnt := AVE(GROUP,IF(h.hcr_location = (TYPEOF(h.hcr_location))'',0,100));
    maxlength_hcr_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hcr_location)));
    avelength_hcr_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hcr_location)),h.hcr_location<>(typeof(h.hcr_location))'');
    populated_affil_type_cd_pcnt := AVE(GROUP,IF(h.affil_type_cd = (TYPEOF(h.affil_type_cd))'',0,100));
    maxlength_affil_type_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.affil_type_cd)));
    avelength_affil_type_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.affil_type_cd)),h.affil_type_cd<>(typeof(h.affil_type_cd))'');
    populated_genlink_pcnt := AVE(GROUP,IF(h.genlink = (TYPEOF(h.genlink))'',0,100));
    maxlength_genlink := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.genlink)));
    avelength_genlink := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.genlink)),h.genlink<>(typeof(h.genlink))'');
    populated_research_ind_pcnt := AVE(GROUP,IF(h.research_ind = (TYPEOF(h.research_ind))'',0,100));
    maxlength_research_ind := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.research_ind)));
    avelength_research_ind := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.research_ind)),h.research_ind<>(typeof(h.research_ind))'');
    populated_docket_id_pcnt := AVE(GROUP,IF(h.docket_id = (TYPEOF(h.docket_id))'',0,100));
    maxlength_docket_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.docket_id)));
    avelength_docket_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.docket_id)),h.docket_id<>(typeof(h.docket_id))'');
    populated_mltreckey_pcnt := AVE(GROUP,IF(h.mltreckey = (TYPEOF(h.mltreckey))'',0,100));
    maxlength_mltreckey := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mltreckey)));
    avelength_mltreckey := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mltreckey)),h.mltreckey<>(typeof(h.mltreckey))'');
    populated_cmc_slpk_pcnt := AVE(GROUP,IF(h.cmc_slpk = (TYPEOF(h.cmc_slpk))'',0,100));
    maxlength_cmc_slpk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cmc_slpk)));
    avelength_cmc_slpk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cmc_slpk)),h.cmc_slpk<>(typeof(h.cmc_slpk))'');
    populated_pcmc_slpk_pcnt := AVE(GROUP,IF(h.pcmc_slpk = (TYPEOF(h.pcmc_slpk))'',0,100));
    maxlength_pcmc_slpk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pcmc_slpk)));
    avelength_pcmc_slpk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pcmc_slpk)),h.pcmc_slpk<>(typeof(h.pcmc_slpk))'');
    populated_affil_key_pcnt := AVE(GROUP,IF(h.affil_key = (TYPEOF(h.affil_key))'',0,100));
    maxlength_affil_key := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.affil_key)));
    avelength_affil_key := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.affil_key)),h.affil_key<>(typeof(h.affil_key))'');
    populated_provnote_1_pcnt := AVE(GROUP,IF(h.provnote_1 = (TYPEOF(h.provnote_1))'',0,100));
    maxlength_provnote_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_1)));
    avelength_provnote_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_1)),h.provnote_1<>(typeof(h.provnote_1))'');
    populated_provnote_2_pcnt := AVE(GROUP,IF(h.provnote_2 = (TYPEOF(h.provnote_2))'',0,100));
    maxlength_provnote_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_2)));
    avelength_provnote_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_2)),h.provnote_2<>(typeof(h.provnote_2))'');
    populated_provnote_3_pcnt := AVE(GROUP,IF(h.provnote_3 = (TYPEOF(h.provnote_3))'',0,100));
    maxlength_provnote_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_3)));
    avelength_provnote_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provnote_3)),h.provnote_3<>(typeof(h.provnote_3))'');
    populated_action_taken_ind_pcnt := AVE(GROUP,IF(h.action_taken_ind = (TYPEOF(h.action_taken_ind))'',0,100));
    maxlength_action_taken_ind := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_taken_ind)));
    avelength_action_taken_ind := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_taken_ind)),h.action_taken_ind<>(typeof(h.action_taken_ind))'');
    populated_viol_type_pcnt := AVE(GROUP,IF(h.viol_type = (TYPEOF(h.viol_type))'',0,100));
    maxlength_viol_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_type)));
    avelength_viol_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_type)),h.viol_type<>(typeof(h.viol_type))'');
    populated_viol_cd_pcnt := AVE(GROUP,IF(h.viol_cd = (TYPEOF(h.viol_cd))'',0,100));
    maxlength_viol_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_cd)));
    avelength_viol_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_cd)),h.viol_cd<>(typeof(h.viol_cd))'');
    populated_viol_desc_pcnt := AVE(GROUP,IF(h.viol_desc = (TYPEOF(h.viol_desc))'',0,100));
    maxlength_viol_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_desc)));
    avelength_viol_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_desc)),h.viol_desc<>(typeof(h.viol_desc))'');
    populated_viol_dte_pcnt := AVE(GROUP,IF(h.viol_dte = (TYPEOF(h.viol_dte))'',0,100));
    maxlength_viol_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_dte)));
    avelength_viol_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_dte)),h.viol_dte<>(typeof(h.viol_dte))'');
    populated_viol_case_nbr_pcnt := AVE(GROUP,IF(h.viol_case_nbr = (TYPEOF(h.viol_case_nbr))'',0,100));
    maxlength_viol_case_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_case_nbr)));
    avelength_viol_case_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_case_nbr)),h.viol_case_nbr<>(typeof(h.viol_case_nbr))'');
    populated_viol_eff_dte_pcnt := AVE(GROUP,IF(h.viol_eff_dte = (TYPEOF(h.viol_eff_dte))'',0,100));
    maxlength_viol_eff_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_eff_dte)));
    avelength_viol_eff_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.viol_eff_dte)),h.viol_eff_dte<>(typeof(h.viol_eff_dte))'');
    populated_action_final_nbr_pcnt := AVE(GROUP,IF(h.action_final_nbr = (TYPEOF(h.action_final_nbr))'',0,100));
    maxlength_action_final_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_final_nbr)));
    avelength_action_final_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_final_nbr)),h.action_final_nbr<>(typeof(h.action_final_nbr))'');
    populated_action_status_pcnt := AVE(GROUP,IF(h.action_status = (TYPEOF(h.action_status))'',0,100));
    maxlength_action_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_status)));
    avelength_action_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_status)),h.action_status<>(typeof(h.action_status))'');
    populated_action_status_dte_pcnt := AVE(GROUP,IF(h.action_status_dte = (TYPEOF(h.action_status_dte))'',0,100));
    maxlength_action_status_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_status_dte)));
    avelength_action_status_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_status_dte)),h.action_status_dte<>(typeof(h.action_status_dte))'');
    populated_displinary_action_pcnt := AVE(GROUP,IF(h.displinary_action = (TYPEOF(h.displinary_action))'',0,100));
    maxlength_displinary_action := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.displinary_action)));
    avelength_displinary_action := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.displinary_action)),h.displinary_action<>(typeof(h.displinary_action))'');
    populated_action_file_name_pcnt := AVE(GROUP,IF(h.action_file_name = (TYPEOF(h.action_file_name))'',0,100));
    maxlength_action_file_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_file_name)));
    avelength_action_file_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_file_name)),h.action_file_name<>(typeof(h.action_file_name))'');
    populated_occupation_pcnt := AVE(GROUP,IF(h.occupation = (TYPEOF(h.occupation))'',0,100));
    maxlength_occupation := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.occupation)));
    avelength_occupation := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.occupation)),h.occupation<>(typeof(h.occupation))'');
    populated_practice_hrs_pcnt := AVE(GROUP,IF(h.practice_hrs = (TYPEOF(h.practice_hrs))'',0,100));
    maxlength_practice_hrs := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_hrs)));
    avelength_practice_hrs := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_hrs)),h.practice_hrs<>(typeof(h.practice_hrs))'');
    populated_practice_type_pcnt := AVE(GROUP,IF(h.practice_type = (TYPEOF(h.practice_type))'',0,100));
    maxlength_practice_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type)));
    avelength_practice_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type)),h.practice_type<>(typeof(h.practice_type))'');
    populated_misc_other_id_pcnt := AVE(GROUP,IF(h.misc_other_id = (TYPEOF(h.misc_other_id))'',0,100));
    maxlength_misc_other_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.misc_other_id)));
    avelength_misc_other_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.misc_other_id)),h.misc_other_id<>(typeof(h.misc_other_id))'');
    populated_misc_other_type_pcnt := AVE(GROUP,IF(h.misc_other_type = (TYPEOF(h.misc_other_type))'',0,100));
    maxlength_misc_other_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.misc_other_type)));
    avelength_misc_other_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.misc_other_type)),h.misc_other_type<>(typeof(h.misc_other_type))'');
    populated_cont_education_ernd_pcnt := AVE(GROUP,IF(h.cont_education_ernd = (TYPEOF(h.cont_education_ernd))'',0,100));
    maxlength_cont_education_ernd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_ernd)));
    avelength_cont_education_ernd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_ernd)),h.cont_education_ernd<>(typeof(h.cont_education_ernd))'');
    populated_cont_education_req_pcnt := AVE(GROUP,IF(h.cont_education_req = (TYPEOF(h.cont_education_req))'',0,100));
    maxlength_cont_education_req := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_req)));
    avelength_cont_education_req := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_req)),h.cont_education_req<>(typeof(h.cont_education_req))'');
    populated_cont_education_term_pcnt := AVE(GROUP,IF(h.cont_education_term = (TYPEOF(h.cont_education_term))'',0,100));
    maxlength_cont_education_term := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_term)));
    avelength_cont_education_term := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cont_education_term)),h.cont_education_term<>(typeof(h.cont_education_term))'');
    populated_schl_attend_1_pcnt := AVE(GROUP,IF(h.schl_attend_1 = (TYPEOF(h.schl_attend_1))'',0,100));
    maxlength_schl_attend_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_1)));
    avelength_schl_attend_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_1)),h.schl_attend_1<>(typeof(h.schl_attend_1))'');
    populated_schl_attend_dte_1_pcnt := AVE(GROUP,IF(h.schl_attend_dte_1 = (TYPEOF(h.schl_attend_dte_1))'',0,100));
    maxlength_schl_attend_dte_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_1)));
    avelength_schl_attend_dte_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_1)),h.schl_attend_dte_1<>(typeof(h.schl_attend_dte_1))'');
    populated_schl_curriculum_1_pcnt := AVE(GROUP,IF(h.schl_curriculum_1 = (TYPEOF(h.schl_curriculum_1))'',0,100));
    maxlength_schl_curriculum_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_1)));
    avelength_schl_curriculum_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_1)),h.schl_curriculum_1<>(typeof(h.schl_curriculum_1))'');
    populated_schl_degree_1_pcnt := AVE(GROUP,IF(h.schl_degree_1 = (TYPEOF(h.schl_degree_1))'',0,100));
    maxlength_schl_degree_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_1)));
    avelength_schl_degree_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_1)),h.schl_degree_1<>(typeof(h.schl_degree_1))'');
    populated_schl_attend_2_pcnt := AVE(GROUP,IF(h.schl_attend_2 = (TYPEOF(h.schl_attend_2))'',0,100));
    maxlength_schl_attend_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_2)));
    avelength_schl_attend_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_2)),h.schl_attend_2<>(typeof(h.schl_attend_2))'');
    populated_schl_attend_dte_2_pcnt := AVE(GROUP,IF(h.schl_attend_dte_2 = (TYPEOF(h.schl_attend_dte_2))'',0,100));
    maxlength_schl_attend_dte_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_2)));
    avelength_schl_attend_dte_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_2)),h.schl_attend_dte_2<>(typeof(h.schl_attend_dte_2))'');
    populated_schl_curriculum_2_pcnt := AVE(GROUP,IF(h.schl_curriculum_2 = (TYPEOF(h.schl_curriculum_2))'',0,100));
    maxlength_schl_curriculum_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_2)));
    avelength_schl_curriculum_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_2)),h.schl_curriculum_2<>(typeof(h.schl_curriculum_2))'');
    populated_schl_degree_2_pcnt := AVE(GROUP,IF(h.schl_degree_2 = (TYPEOF(h.schl_degree_2))'',0,100));
    maxlength_schl_degree_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_2)));
    avelength_schl_degree_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_2)),h.schl_degree_2<>(typeof(h.schl_degree_2))'');
    populated_schl_attend_3_pcnt := AVE(GROUP,IF(h.schl_attend_3 = (TYPEOF(h.schl_attend_3))'',0,100));
    maxlength_schl_attend_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_3)));
    avelength_schl_attend_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_3)),h.schl_attend_3<>(typeof(h.schl_attend_3))'');
    populated_schl_attend_dte_3_pcnt := AVE(GROUP,IF(h.schl_attend_dte_3 = (TYPEOF(h.schl_attend_dte_3))'',0,100));
    maxlength_schl_attend_dte_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_3)));
    avelength_schl_attend_dte_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_attend_dte_3)),h.schl_attend_dte_3<>(typeof(h.schl_attend_dte_3))'');
    populated_schl_curriculum_3_pcnt := AVE(GROUP,IF(h.schl_curriculum_3 = (TYPEOF(h.schl_curriculum_3))'',0,100));
    maxlength_schl_curriculum_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_3)));
    avelength_schl_curriculum_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_curriculum_3)),h.schl_curriculum_3<>(typeof(h.schl_curriculum_3))'');
    populated_schl_degree_3_pcnt := AVE(GROUP,IF(h.schl_degree_3 = (TYPEOF(h.schl_degree_3))'',0,100));
    maxlength_schl_degree_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_3)));
    avelength_schl_degree_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schl_degree_3)),h.schl_degree_3<>(typeof(h.schl_degree_3))'');
    populated_addl_license_spec_pcnt := AVE(GROUP,IF(h.addl_license_spec = (TYPEOF(h.addl_license_spec))'',0,100));
    maxlength_addl_license_spec := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addl_license_spec)));
    avelength_addl_license_spec := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addl_license_spec)),h.addl_license_spec<>(typeof(h.addl_license_spec))'');
    populated_place_birth_cd_pcnt := AVE(GROUP,IF(h.place_birth_cd = (TYPEOF(h.place_birth_cd))'',0,100));
    maxlength_place_birth_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_birth_cd)));
    avelength_place_birth_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_birth_cd)),h.place_birth_cd<>(typeof(h.place_birth_cd))'');
    populated_place_birth_desc_pcnt := AVE(GROUP,IF(h.place_birth_desc = (TYPEOF(h.place_birth_desc))'',0,100));
    maxlength_place_birth_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_birth_desc)));
    avelength_place_birth_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_birth_desc)),h.place_birth_desc<>(typeof(h.place_birth_desc))'');
    populated_race_cd_pcnt := AVE(GROUP,IF(h.race_cd = (TYPEOF(h.race_cd))'',0,100));
    maxlength_race_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.race_cd)));
    avelength_race_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.race_cd)),h.race_cd<>(typeof(h.race_cd))'');
    populated_std_race_cd_pcnt := AVE(GROUP,IF(h.std_race_cd = (TYPEOF(h.std_race_cd))'',0,100));
    maxlength_std_race_cd := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_race_cd)));
    avelength_std_race_cd := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.std_race_cd)),h.std_race_cd<>(typeof(h.std_race_cd))'');
    populated_race_desc_pcnt := AVE(GROUP,IF(h.race_desc = (TYPEOF(h.race_desc))'',0,100));
    maxlength_race_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.race_desc)));
    avelength_race_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.race_desc)),h.race_desc<>(typeof(h.race_desc))'');
    populated_status_effect_dte_pcnt := AVE(GROUP,IF(h.status_effect_dte = (TYPEOF(h.status_effect_dte))'',0,100));
    maxlength_status_effect_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.status_effect_dte)));
    avelength_status_effect_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.status_effect_dte)),h.status_effect_dte<>(typeof(h.status_effect_dte))'');
    populated_status_renew_desc_pcnt := AVE(GROUP,IF(h.status_renew_desc = (TYPEOF(h.status_renew_desc))'',0,100));
    maxlength_status_renew_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.status_renew_desc)));
    avelength_status_renew_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.status_renew_desc)),h.status_renew_desc<>(typeof(h.status_renew_desc))'');
    populated_agency_status_pcnt := AVE(GROUP,IF(h.agency_status = (TYPEOF(h.agency_status))'',0,100));
    maxlength_agency_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency_status)));
    avelength_agency_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency_status)),h.agency_status<>(typeof(h.agency_status))'');
    populated_prev_primary_key_pcnt := AVE(GROUP,IF(h.prev_primary_key = (TYPEOF(h.prev_primary_key))'',0,100));
    maxlength_prev_primary_key := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_primary_key)));
    avelength_prev_primary_key := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_primary_key)),h.prev_primary_key<>(typeof(h.prev_primary_key))'');
    populated_prev_mltreckey_pcnt := AVE(GROUP,IF(h.prev_mltreckey = (TYPEOF(h.prev_mltreckey))'',0,100));
    maxlength_prev_mltreckey := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_mltreckey)));
    avelength_prev_mltreckey := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_mltreckey)),h.prev_mltreckey<>(typeof(h.prev_mltreckey))'');
    populated_prev_cmc_slpk_pcnt := AVE(GROUP,IF(h.prev_cmc_slpk = (TYPEOF(h.prev_cmc_slpk))'',0,100));
    maxlength_prev_cmc_slpk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_cmc_slpk)));
    avelength_prev_cmc_slpk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_cmc_slpk)),h.prev_cmc_slpk<>(typeof(h.prev_cmc_slpk))'');
    populated_prev_pcmc_slpk_pcnt := AVE(GROUP,IF(h.prev_pcmc_slpk = (TYPEOF(h.prev_pcmc_slpk))'',0,100));
    maxlength_prev_pcmc_slpk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_pcmc_slpk)));
    avelength_prev_pcmc_slpk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_pcmc_slpk)),h.prev_pcmc_slpk<>(typeof(h.prev_pcmc_slpk))'');
    populated_license_id_pcnt := AVE(GROUP,IF(h.license_id = (TYPEOF(h.license_id))'',0,100));
    maxlength_license_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_id)));
    avelength_license_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_id)),h.license_id<>(typeof(h.license_id))'');
    populated_nmls_id_pcnt := AVE(GROUP,IF(h.nmls_id = (TYPEOF(h.nmls_id))'',0,100));
    maxlength_nmls_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nmls_id)));
    avelength_nmls_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nmls_id)),h.nmls_id<>(typeof(h.nmls_id))'');
    populated_foreign_nmls_id_pcnt := AVE(GROUP,IF(h.foreign_nmls_id = (TYPEOF(h.foreign_nmls_id))'',0,100));
    maxlength_foreign_nmls_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.foreign_nmls_id)));
    avelength_foreign_nmls_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.foreign_nmls_id)),h.foreign_nmls_id<>(typeof(h.foreign_nmls_id))'');
    populated_location_type_pcnt := AVE(GROUP,IF(h.location_type = (TYPEOF(h.location_type))'',0,100));
    maxlength_location_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.location_type)));
    avelength_location_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.location_type)),h.location_type<>(typeof(h.location_type))'');
    populated_off_license_nbr_type_pcnt := AVE(GROUP,IF(h.off_license_nbr_type = (TYPEOF(h.off_license_nbr_type))'',0,100));
    maxlength_off_license_nbr_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.off_license_nbr_type)));
    avelength_off_license_nbr_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.off_license_nbr_type)),h.off_license_nbr_type<>(typeof(h.off_license_nbr_type))'');
    populated_brkr_license_nbr_pcnt := AVE(GROUP,IF(h.brkr_license_nbr = (TYPEOF(h.brkr_license_nbr))'',0,100));
    maxlength_brkr_license_nbr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.brkr_license_nbr)));
    avelength_brkr_license_nbr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.brkr_license_nbr)),h.brkr_license_nbr<>(typeof(h.brkr_license_nbr))'');
    populated_brkr_license_nbr_type_pcnt := AVE(GROUP,IF(h.brkr_license_nbr_type = (TYPEOF(h.brkr_license_nbr_type))'',0,100));
    maxlength_brkr_license_nbr_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.brkr_license_nbr_type)));
    avelength_brkr_license_nbr_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.brkr_license_nbr_type)),h.brkr_license_nbr_type<>(typeof(h.brkr_license_nbr_type))'');
    populated_agency_id_pcnt := AVE(GROUP,IF(h.agency_id = (TYPEOF(h.agency_id))'',0,100));
    maxlength_agency_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency_id)));
    avelength_agency_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency_id)),h.agency_id<>(typeof(h.agency_id))'');
    populated_site_location_pcnt := AVE(GROUP,IF(h.site_location = (TYPEOF(h.site_location))'',0,100));
    maxlength_site_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.site_location)));
    avelength_site_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.site_location)),h.site_location<>(typeof(h.site_location))'');
    populated_business_type_pcnt := AVE(GROUP,IF(h.business_type = (TYPEOF(h.business_type))'',0,100));
    maxlength_business_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.business_type)));
    avelength_business_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.business_type)),h.business_type<>(typeof(h.business_type))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_start_dte_pcnt := AVE(GROUP,IF(h.start_dte = (TYPEOF(h.start_dte))'',0,100));
    maxlength_start_dte := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.start_dte)));
    avelength_start_dte := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.start_dte)),h.start_dte<>(typeof(h.start_dte))'');
    populated_is_authorized_license_pcnt := AVE(GROUP,IF(h.is_authorized_license = (TYPEOF(h.is_authorized_license))'',0,100));
    maxlength_is_authorized_license := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.is_authorized_license)));
    avelength_is_authorized_license := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.is_authorized_license)),h.is_authorized_license<>(typeof(h.is_authorized_license))'');
    populated_is_authorized_conduct_pcnt := AVE(GROUP,IF(h.is_authorized_conduct = (TYPEOF(h.is_authorized_conduct))'',0,100));
    maxlength_is_authorized_conduct := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.is_authorized_conduct)));
    avelength_is_authorized_conduct := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.is_authorized_conduct)),h.is_authorized_conduct<>(typeof(h.is_authorized_conduct))'');
    populated_federal_regulator_pcnt := AVE(GROUP,IF(h.federal_regulator = (TYPEOF(h.federal_regulator))'',0,100));
    maxlength_federal_regulator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.federal_regulator)));
    avelength_federal_regulator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.federal_regulator)),h.federal_regulator<>(typeof(h.federal_regulator))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,std_source_upd,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_primary_key_pcnt *   0.00 / 100 + T.Populated_create_dte_pcnt *   0.00 / 100 + T.Populated_last_upd_dte_pcnt *   0.00 / 100 + T.Populated_stamp_dte_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_gen_nbr_pcnt *   0.00 / 100 + T.Populated_std_prof_cd_pcnt *   0.00 / 100 + T.Populated_std_prof_desc_pcnt *   0.00 / 100 + T.Populated_std_source_upd_pcnt *   0.00 / 100 + T.Populated_std_source_desc_pcnt *   0.00 / 100 + T.Populated_type_cd_pcnt *   0.00 / 100 + T.Populated_name_org_prefx_pcnt *   0.00 / 100 + T.Populated_name_org_pcnt *   0.00 / 100 + T.Populated_name_org_sufx_pcnt *   0.00 / 100 + T.Populated_store_nbr_pcnt *   0.00 / 100 + T.Populated_name_dba_prefx_pcnt *   0.00 / 100 + T.Populated_name_dba_pcnt *   0.00 / 100 + T.Populated_name_dba_sufx_pcnt *   0.00 / 100 + T.Populated_store_nbr_dba_pcnt *   0.00 / 100 + T.Populated_dba_flag_pcnt *   0.00 / 100 + T.Populated_name_office_pcnt *   0.00 / 100 + T.Populated_office_parse_pcnt *   0.00 / 100 + T.Populated_name_prefx_pcnt *   0.00 / 100 + T.Populated_name_first_pcnt *   0.00 / 100 + T.Populated_name_mid_pcnt *   0.00 / 100 + T.Populated_name_last_pcnt *   0.00 / 100 + T.Populated_name_sufx_pcnt *   0.00 / 100 + T.Populated_name_nick_pcnt *   0.00 / 100 + T.Populated_birth_dte_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_prov_stat_pcnt *   0.00 / 100 + T.Populated_credential_pcnt *   0.00 / 100 + T.Populated_license_nbr_pcnt *   0.00 / 100 + T.Populated_off_license_nbr_pcnt *   0.00 / 100 + T.Populated_prev_license_nbr_pcnt *   0.00 / 100 + T.Populated_prev_license_type_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_raw_license_type_pcnt *   0.00 / 100 + T.Populated_std_license_type_pcnt *   0.00 / 100 + T.Populated_std_license_desc_pcnt *   0.00 / 100 + T.Populated_raw_license_status_pcnt *   0.00 / 100 + T.Populated_std_license_status_pcnt *   0.00 / 100 + T.Populated_std_status_desc_pcnt *   0.00 / 100 + T.Populated_curr_issue_dte_pcnt *   0.00 / 100 + T.Populated_orig_issue_dte_pcnt *   0.00 / 100 + T.Populated_expire_dte_pcnt *   0.00 / 100 + T.Populated_renewal_dte_pcnt *   0.00 / 100 + T.Populated_active_flag_pcnt *   0.00 / 100 + T.Populated_ssn_taxid_1_pcnt *   0.00 / 100 + T.Populated_tax_type_1_pcnt *   0.00 / 100 + T.Populated_ssn_taxid_2_pcnt *   0.00 / 100 + T.Populated_tax_type_2_pcnt *   0.00 / 100 + T.Populated_fed_rssd_pcnt *   0.00 / 100 + T.Populated_addr_bus_ind_pcnt *   0.00 / 100 + T.Populated_name_format_pcnt *   0.00 / 100 + T.Populated_name_org_orig_pcnt *   0.00 / 100 + T.Populated_name_dba_orig_pcnt *   0.00 / 100 + T.Populated_name_mari_org_pcnt *   0.00 / 100 + T.Populated_name_mari_dba_pcnt *   0.00 / 100 + T.Populated_phn_mari_1_pcnt *   0.00 / 100 + T.Populated_phn_mari_fax_1_pcnt *   0.00 / 100 + T.Populated_phn_mari_2_pcnt *   0.00 / 100 + T.Populated_phn_mari_fax_2_pcnt *   0.00 / 100 + T.Populated_addr_addr1_1_pcnt *   0.00 / 100 + T.Populated_addr_addr2_1_pcnt *   0.00 / 100 + T.Populated_addr_addr3_1_pcnt *   0.00 / 100 + T.Populated_addr_addr4_1_pcnt *   0.00 / 100 + T.Populated_addr_city_1_pcnt *   0.00 / 100 + T.Populated_addr_state_1_pcnt *   0.00 / 100 + T.Populated_addr_zip5_1_pcnt *   0.00 / 100 + T.Populated_addr_zip4_1_pcnt *   0.00 / 100 + T.Populated_phn_phone_1_pcnt *   0.00 / 100 + T.Populated_phn_fax_1_pcnt *   0.00 / 100 + T.Populated_addr_cnty_1_pcnt *   0.00 / 100 + T.Populated_addr_cntry_1_pcnt *   0.00 / 100 + T.Populated_sud_key_1_pcnt *   0.00 / 100 + T.Populated_ooc_ind_1_pcnt *   0.00 / 100 + T.Populated_addr_mail_ind_pcnt *   0.00 / 100 + T.Populated_addr_addr1_2_pcnt *   0.00 / 100 + T.Populated_addr_addr2_2_pcnt *   0.00 / 100 + T.Populated_addr_addr3_2_pcnt *   0.00 / 100 + T.Populated_addr_addr4_2_pcnt *   0.00 / 100 + T.Populated_addr_city_2_pcnt *   0.00 / 100 + T.Populated_addr_state_2_pcnt *   0.00 / 100 + T.Populated_addr_zip5_2_pcnt *   0.00 / 100 + T.Populated_addr_zip4_2_pcnt *   0.00 / 100 + T.Populated_addr_cnty_2_pcnt *   0.00 / 100 + T.Populated_addr_cntry_2_pcnt *   0.00 / 100 + T.Populated_phn_phone_2_pcnt *   0.00 / 100 + T.Populated_phn_fax_2_pcnt *   0.00 / 100 + T.Populated_sud_key_2_pcnt *   0.00 / 100 + T.Populated_ooc_ind_2_pcnt *   0.00 / 100 + T.Populated_license_nbr_contact_pcnt *   0.00 / 100 + T.Populated_name_contact_prefx_pcnt *   0.00 / 100 + T.Populated_name_contact_first_pcnt *   0.00 / 100 + T.Populated_name_contact_mid_pcnt *   0.00 / 100 + T.Populated_name_contact_last_pcnt *   0.00 / 100 + T.Populated_name_contact_sufx_pcnt *   0.00 / 100 + T.Populated_name_contact_nick_pcnt *   0.00 / 100 + T.Populated_name_contact_ttl_pcnt *   0.00 / 100 + T.Populated_phn_contact_pcnt *   0.00 / 100 + T.Populated_phn_contact_ext_pcnt *   0.00 / 100 + T.Populated_phn_contact_fax_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_bk_class_pcnt *   0.00 / 100 + T.Populated_bk_class_desc_pcnt *   0.00 / 100 + T.Populated_charter_pcnt *   0.00 / 100 + T.Populated_inst_beg_dte_pcnt *   0.00 / 100 + T.Populated_origin_cd_pcnt *   0.00 / 100 + T.Populated_origin_cd_desc_pcnt *   0.00 / 100 + T.Populated_disp_type_cd_pcnt *   0.00 / 100 + T.Populated_disp_type_desc_pcnt *   0.00 / 100 + T.Populated_reg_agent_pcnt *   0.00 / 100 + T.Populated_regulator_pcnt *   0.00 / 100 + T.Populated_hqtr_city_pcnt *   0.00 / 100 + T.Populated_hqtr_name_pcnt *   0.00 / 100 + T.Populated_domestic_off_nbr_pcnt *   0.00 / 100 + T.Populated_foreign_off_nbr_pcnt *   0.00 / 100 + T.Populated_hcr_rssd_pcnt *   0.00 / 100 + T.Populated_hcr_location_pcnt *   0.00 / 100 + T.Populated_affil_type_cd_pcnt *   0.00 / 100 + T.Populated_genlink_pcnt *   0.00 / 100 + T.Populated_research_ind_pcnt *   0.00 / 100 + T.Populated_docket_id_pcnt *   0.00 / 100 + T.Populated_mltreckey_pcnt *   0.00 / 100 + T.Populated_cmc_slpk_pcnt *   0.00 / 100 + T.Populated_pcmc_slpk_pcnt *   0.00 / 100 + T.Populated_affil_key_pcnt *   0.00 / 100 + T.Populated_provnote_1_pcnt *   0.00 / 100 + T.Populated_provnote_2_pcnt *   0.00 / 100 + T.Populated_provnote_3_pcnt *   0.00 / 100 + T.Populated_action_taken_ind_pcnt *   0.00 / 100 + T.Populated_viol_type_pcnt *   0.00 / 100 + T.Populated_viol_cd_pcnt *   0.00 / 100 + T.Populated_viol_desc_pcnt *   0.00 / 100 + T.Populated_viol_dte_pcnt *   0.00 / 100 + T.Populated_viol_case_nbr_pcnt *   0.00 / 100 + T.Populated_viol_eff_dte_pcnt *   0.00 / 100 + T.Populated_action_final_nbr_pcnt *   0.00 / 100 + T.Populated_action_status_pcnt *   0.00 / 100 + T.Populated_action_status_dte_pcnt *   0.00 / 100 + T.Populated_displinary_action_pcnt *   0.00 / 100 + T.Populated_action_file_name_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_practice_hrs_pcnt *   0.00 / 100 + T.Populated_practice_type_pcnt *   0.00 / 100 + T.Populated_misc_other_id_pcnt *   0.00 / 100 + T.Populated_misc_other_type_pcnt *   0.00 / 100 + T.Populated_cont_education_ernd_pcnt *   0.00 / 100 + T.Populated_cont_education_req_pcnt *   0.00 / 100 + T.Populated_cont_education_term_pcnt *   0.00 / 100 + T.Populated_schl_attend_1_pcnt *   0.00 / 100 + T.Populated_schl_attend_dte_1_pcnt *   0.00 / 100 + T.Populated_schl_curriculum_1_pcnt *   0.00 / 100 + T.Populated_schl_degree_1_pcnt *   0.00 / 100 + T.Populated_schl_attend_2_pcnt *   0.00 / 100 + T.Populated_schl_attend_dte_2_pcnt *   0.00 / 100 + T.Populated_schl_curriculum_2_pcnt *   0.00 / 100 + T.Populated_schl_degree_2_pcnt *   0.00 / 100 + T.Populated_schl_attend_3_pcnt *   0.00 / 100 + T.Populated_schl_attend_dte_3_pcnt *   0.00 / 100 + T.Populated_schl_curriculum_3_pcnt *   0.00 / 100 + T.Populated_schl_degree_3_pcnt *   0.00 / 100 + T.Populated_addl_license_spec_pcnt *   0.00 / 100 + T.Populated_place_birth_cd_pcnt *   0.00 / 100 + T.Populated_place_birth_desc_pcnt *   0.00 / 100 + T.Populated_race_cd_pcnt *   0.00 / 100 + T.Populated_std_race_cd_pcnt *   0.00 / 100 + T.Populated_race_desc_pcnt *   0.00 / 100 + T.Populated_status_effect_dte_pcnt *   0.00 / 100 + T.Populated_status_renew_desc_pcnt *   0.00 / 100 + T.Populated_agency_status_pcnt *   0.00 / 100 + T.Populated_prev_primary_key_pcnt *   0.00 / 100 + T.Populated_prev_mltreckey_pcnt *   0.00 / 100 + T.Populated_prev_cmc_slpk_pcnt *   0.00 / 100 + T.Populated_prev_pcmc_slpk_pcnt *   0.00 / 100 + T.Populated_license_id_pcnt *   0.00 / 100 + T.Populated_nmls_id_pcnt *   0.00 / 100 + T.Populated_foreign_nmls_id_pcnt *   0.00 / 100 + T.Populated_location_type_pcnt *   0.00 / 100 + T.Populated_off_license_nbr_type_pcnt *   0.00 / 100 + T.Populated_brkr_license_nbr_pcnt *   0.00 / 100 + T.Populated_brkr_license_nbr_type_pcnt *   0.00 / 100 + T.Populated_agency_id_pcnt *   0.00 / 100 + T.Populated_site_location_pcnt *   0.00 / 100 + T.Populated_business_type_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_start_dte_pcnt *   0.00 / 100 + T.Populated_is_authorized_license_pcnt *   0.00 / 100 + T.Populated_is_authorized_conduct_pcnt *   0.00 / 100 + T.Populated_federal_regulator_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING std_source_upd1;
    STRING std_source_upd2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.std_source_upd1 := le.Source;
    SELF.std_source_upd2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_primary_key_pcnt*ri.Populated_primary_key_pcnt *   0.00 / 10000 + le.Populated_create_dte_pcnt*ri.Populated_create_dte_pcnt *   0.00 / 10000 + le.Populated_last_upd_dte_pcnt*ri.Populated_last_upd_dte_pcnt *   0.00 / 10000 + le.Populated_stamp_dte_pcnt*ri.Populated_stamp_dte_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_gen_nbr_pcnt*ri.Populated_gen_nbr_pcnt *   0.00 / 10000 + le.Populated_std_prof_cd_pcnt*ri.Populated_std_prof_cd_pcnt *   0.00 / 10000 + le.Populated_std_prof_desc_pcnt*ri.Populated_std_prof_desc_pcnt *   0.00 / 10000 + le.Populated_std_source_upd_pcnt*ri.Populated_std_source_upd_pcnt *   0.00 / 10000 + le.Populated_std_source_desc_pcnt*ri.Populated_std_source_desc_pcnt *   0.00 / 10000 + le.Populated_type_cd_pcnt*ri.Populated_type_cd_pcnt *   0.00 / 10000 + le.Populated_name_org_prefx_pcnt*ri.Populated_name_org_prefx_pcnt *   0.00 / 10000 + le.Populated_name_org_pcnt*ri.Populated_name_org_pcnt *   0.00 / 10000 + le.Populated_name_org_sufx_pcnt*ri.Populated_name_org_sufx_pcnt *   0.00 / 10000 + le.Populated_store_nbr_pcnt*ri.Populated_store_nbr_pcnt *   0.00 / 10000 + le.Populated_name_dba_prefx_pcnt*ri.Populated_name_dba_prefx_pcnt *   0.00 / 10000 + le.Populated_name_dba_pcnt*ri.Populated_name_dba_pcnt *   0.00 / 10000 + le.Populated_name_dba_sufx_pcnt*ri.Populated_name_dba_sufx_pcnt *   0.00 / 10000 + le.Populated_store_nbr_dba_pcnt*ri.Populated_store_nbr_dba_pcnt *   0.00 / 10000 + le.Populated_dba_flag_pcnt*ri.Populated_dba_flag_pcnt *   0.00 / 10000 + le.Populated_name_office_pcnt*ri.Populated_name_office_pcnt *   0.00 / 10000 + le.Populated_office_parse_pcnt*ri.Populated_office_parse_pcnt *   0.00 / 10000 + le.Populated_name_prefx_pcnt*ri.Populated_name_prefx_pcnt *   0.00 / 10000 + le.Populated_name_first_pcnt*ri.Populated_name_first_pcnt *   0.00 / 10000 + le.Populated_name_mid_pcnt*ri.Populated_name_mid_pcnt *   0.00 / 10000 + le.Populated_name_last_pcnt*ri.Populated_name_last_pcnt *   0.00 / 10000 + le.Populated_name_sufx_pcnt*ri.Populated_name_sufx_pcnt *   0.00 / 10000 + le.Populated_name_nick_pcnt*ri.Populated_name_nick_pcnt *   0.00 / 10000 + le.Populated_birth_dte_pcnt*ri.Populated_birth_dte_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_prov_stat_pcnt*ri.Populated_prov_stat_pcnt *   0.00 / 10000 + le.Populated_credential_pcnt*ri.Populated_credential_pcnt *   0.00 / 10000 + le.Populated_license_nbr_pcnt*ri.Populated_license_nbr_pcnt *   0.00 / 10000 + le.Populated_off_license_nbr_pcnt*ri.Populated_off_license_nbr_pcnt *   0.00 / 10000 + le.Populated_prev_license_nbr_pcnt*ri.Populated_prev_license_nbr_pcnt *   0.00 / 10000 + le.Populated_prev_license_type_pcnt*ri.Populated_prev_license_type_pcnt *   0.00 / 10000 + le.Populated_license_state_pcnt*ri.Populated_license_state_pcnt *   0.00 / 10000 + le.Populated_raw_license_type_pcnt*ri.Populated_raw_license_type_pcnt *   0.00 / 10000 + le.Populated_std_license_type_pcnt*ri.Populated_std_license_type_pcnt *   0.00 / 10000 + le.Populated_std_license_desc_pcnt*ri.Populated_std_license_desc_pcnt *   0.00 / 10000 + le.Populated_raw_license_status_pcnt*ri.Populated_raw_license_status_pcnt *   0.00 / 10000 + le.Populated_std_license_status_pcnt*ri.Populated_std_license_status_pcnt *   0.00 / 10000 + le.Populated_std_status_desc_pcnt*ri.Populated_std_status_desc_pcnt *   0.00 / 10000 + le.Populated_curr_issue_dte_pcnt*ri.Populated_curr_issue_dte_pcnt *   0.00 / 10000 + le.Populated_orig_issue_dte_pcnt*ri.Populated_orig_issue_dte_pcnt *   0.00 / 10000 + le.Populated_expire_dte_pcnt*ri.Populated_expire_dte_pcnt *   0.00 / 10000 + le.Populated_renewal_dte_pcnt*ri.Populated_renewal_dte_pcnt *   0.00 / 10000 + le.Populated_active_flag_pcnt*ri.Populated_active_flag_pcnt *   0.00 / 10000 + le.Populated_ssn_taxid_1_pcnt*ri.Populated_ssn_taxid_1_pcnt *   0.00 / 10000 + le.Populated_tax_type_1_pcnt*ri.Populated_tax_type_1_pcnt *   0.00 / 10000 + le.Populated_ssn_taxid_2_pcnt*ri.Populated_ssn_taxid_2_pcnt *   0.00 / 10000 + le.Populated_tax_type_2_pcnt*ri.Populated_tax_type_2_pcnt *   0.00 / 10000 + le.Populated_fed_rssd_pcnt*ri.Populated_fed_rssd_pcnt *   0.00 / 10000 + le.Populated_addr_bus_ind_pcnt*ri.Populated_addr_bus_ind_pcnt *   0.00 / 10000 + le.Populated_name_format_pcnt*ri.Populated_name_format_pcnt *   0.00 / 10000 + le.Populated_name_org_orig_pcnt*ri.Populated_name_org_orig_pcnt *   0.00 / 10000 + le.Populated_name_dba_orig_pcnt*ri.Populated_name_dba_orig_pcnt *   0.00 / 10000 + le.Populated_name_mari_org_pcnt*ri.Populated_name_mari_org_pcnt *   0.00 / 10000 + le.Populated_name_mari_dba_pcnt*ri.Populated_name_mari_dba_pcnt *   0.00 / 10000 + le.Populated_phn_mari_1_pcnt*ri.Populated_phn_mari_1_pcnt *   0.00 / 10000 + le.Populated_phn_mari_fax_1_pcnt*ri.Populated_phn_mari_fax_1_pcnt *   0.00 / 10000 + le.Populated_phn_mari_2_pcnt*ri.Populated_phn_mari_2_pcnt *   0.00 / 10000 + le.Populated_phn_mari_fax_2_pcnt*ri.Populated_phn_mari_fax_2_pcnt *   0.00 / 10000 + le.Populated_addr_addr1_1_pcnt*ri.Populated_addr_addr1_1_pcnt *   0.00 / 10000 + le.Populated_addr_addr2_1_pcnt*ri.Populated_addr_addr2_1_pcnt *   0.00 / 10000 + le.Populated_addr_addr3_1_pcnt*ri.Populated_addr_addr3_1_pcnt *   0.00 / 10000 + le.Populated_addr_addr4_1_pcnt*ri.Populated_addr_addr4_1_pcnt *   0.00 / 10000 + le.Populated_addr_city_1_pcnt*ri.Populated_addr_city_1_pcnt *   0.00 / 10000 + le.Populated_addr_state_1_pcnt*ri.Populated_addr_state_1_pcnt *   0.00 / 10000 + le.Populated_addr_zip5_1_pcnt*ri.Populated_addr_zip5_1_pcnt *   0.00 / 10000 + le.Populated_addr_zip4_1_pcnt*ri.Populated_addr_zip4_1_pcnt *   0.00 / 10000 + le.Populated_phn_phone_1_pcnt*ri.Populated_phn_phone_1_pcnt *   0.00 / 10000 + le.Populated_phn_fax_1_pcnt*ri.Populated_phn_fax_1_pcnt *   0.00 / 10000 + le.Populated_addr_cnty_1_pcnt*ri.Populated_addr_cnty_1_pcnt *   0.00 / 10000 + le.Populated_addr_cntry_1_pcnt*ri.Populated_addr_cntry_1_pcnt *   0.00 / 10000 + le.Populated_sud_key_1_pcnt*ri.Populated_sud_key_1_pcnt *   0.00 / 10000 + le.Populated_ooc_ind_1_pcnt*ri.Populated_ooc_ind_1_pcnt *   0.00 / 10000 + le.Populated_addr_mail_ind_pcnt*ri.Populated_addr_mail_ind_pcnt *   0.00 / 10000 + le.Populated_addr_addr1_2_pcnt*ri.Populated_addr_addr1_2_pcnt *   0.00 / 10000 + le.Populated_addr_addr2_2_pcnt*ri.Populated_addr_addr2_2_pcnt *   0.00 / 10000 + le.Populated_addr_addr3_2_pcnt*ri.Populated_addr_addr3_2_pcnt *   0.00 / 10000 + le.Populated_addr_addr4_2_pcnt*ri.Populated_addr_addr4_2_pcnt *   0.00 / 10000 + le.Populated_addr_city_2_pcnt*ri.Populated_addr_city_2_pcnt *   0.00 / 10000 + le.Populated_addr_state_2_pcnt*ri.Populated_addr_state_2_pcnt *   0.00 / 10000 + le.Populated_addr_zip5_2_pcnt*ri.Populated_addr_zip5_2_pcnt *   0.00 / 10000 + le.Populated_addr_zip4_2_pcnt*ri.Populated_addr_zip4_2_pcnt *   0.00 / 10000 + le.Populated_addr_cnty_2_pcnt*ri.Populated_addr_cnty_2_pcnt *   0.00 / 10000 + le.Populated_addr_cntry_2_pcnt*ri.Populated_addr_cntry_2_pcnt *   0.00 / 10000 + le.Populated_phn_phone_2_pcnt*ri.Populated_phn_phone_2_pcnt *   0.00 / 10000 + le.Populated_phn_fax_2_pcnt*ri.Populated_phn_fax_2_pcnt *   0.00 / 10000 + le.Populated_sud_key_2_pcnt*ri.Populated_sud_key_2_pcnt *   0.00 / 10000 + le.Populated_ooc_ind_2_pcnt*ri.Populated_ooc_ind_2_pcnt *   0.00 / 10000 + le.Populated_license_nbr_contact_pcnt*ri.Populated_license_nbr_contact_pcnt *   0.00 / 10000 + le.Populated_name_contact_prefx_pcnt*ri.Populated_name_contact_prefx_pcnt *   0.00 / 10000 + le.Populated_name_contact_first_pcnt*ri.Populated_name_contact_first_pcnt *   0.00 / 10000 + le.Populated_name_contact_mid_pcnt*ri.Populated_name_contact_mid_pcnt *   0.00 / 10000 + le.Populated_name_contact_last_pcnt*ri.Populated_name_contact_last_pcnt *   0.00 / 10000 + le.Populated_name_contact_sufx_pcnt*ri.Populated_name_contact_sufx_pcnt *   0.00 / 10000 + le.Populated_name_contact_nick_pcnt*ri.Populated_name_contact_nick_pcnt *   0.00 / 10000 + le.Populated_name_contact_ttl_pcnt*ri.Populated_name_contact_ttl_pcnt *   0.00 / 10000 + le.Populated_phn_contact_pcnt*ri.Populated_phn_contact_pcnt *   0.00 / 10000 + le.Populated_phn_contact_ext_pcnt*ri.Populated_phn_contact_ext_pcnt *   0.00 / 10000 + le.Populated_phn_contact_fax_pcnt*ri.Populated_phn_contact_fax_pcnt *   0.00 / 10000 + le.Populated_email_pcnt*ri.Populated_email_pcnt *   0.00 / 10000 + le.Populated_url_pcnt*ri.Populated_url_pcnt *   0.00 / 10000 + le.Populated_bk_class_pcnt*ri.Populated_bk_class_pcnt *   0.00 / 10000 + le.Populated_bk_class_desc_pcnt*ri.Populated_bk_class_desc_pcnt *   0.00 / 10000 + le.Populated_charter_pcnt*ri.Populated_charter_pcnt *   0.00 / 10000 + le.Populated_inst_beg_dte_pcnt*ri.Populated_inst_beg_dte_pcnt *   0.00 / 10000 + le.Populated_origin_cd_pcnt*ri.Populated_origin_cd_pcnt *   0.00 / 10000 + le.Populated_origin_cd_desc_pcnt*ri.Populated_origin_cd_desc_pcnt *   0.00 / 10000 + le.Populated_disp_type_cd_pcnt*ri.Populated_disp_type_cd_pcnt *   0.00 / 10000 + le.Populated_disp_type_desc_pcnt*ri.Populated_disp_type_desc_pcnt *   0.00 / 10000 + le.Populated_reg_agent_pcnt*ri.Populated_reg_agent_pcnt *   0.00 / 10000 + le.Populated_regulator_pcnt*ri.Populated_regulator_pcnt *   0.00 / 10000 + le.Populated_hqtr_city_pcnt*ri.Populated_hqtr_city_pcnt *   0.00 / 10000 + le.Populated_hqtr_name_pcnt*ri.Populated_hqtr_name_pcnt *   0.00 / 10000 + le.Populated_domestic_off_nbr_pcnt*ri.Populated_domestic_off_nbr_pcnt *   0.00 / 10000 + le.Populated_foreign_off_nbr_pcnt*ri.Populated_foreign_off_nbr_pcnt *   0.00 / 10000 + le.Populated_hcr_rssd_pcnt*ri.Populated_hcr_rssd_pcnt *   0.00 / 10000 + le.Populated_hcr_location_pcnt*ri.Populated_hcr_location_pcnt *   0.00 / 10000 + le.Populated_affil_type_cd_pcnt*ri.Populated_affil_type_cd_pcnt *   0.00 / 10000 + le.Populated_genlink_pcnt*ri.Populated_genlink_pcnt *   0.00 / 10000 + le.Populated_research_ind_pcnt*ri.Populated_research_ind_pcnt *   0.00 / 10000 + le.Populated_docket_id_pcnt*ri.Populated_docket_id_pcnt *   0.00 / 10000 + le.Populated_mltreckey_pcnt*ri.Populated_mltreckey_pcnt *   0.00 / 10000 + le.Populated_cmc_slpk_pcnt*ri.Populated_cmc_slpk_pcnt *   0.00 / 10000 + le.Populated_pcmc_slpk_pcnt*ri.Populated_pcmc_slpk_pcnt *   0.00 / 10000 + le.Populated_affil_key_pcnt*ri.Populated_affil_key_pcnt *   0.00 / 10000 + le.Populated_provnote_1_pcnt*ri.Populated_provnote_1_pcnt *   0.00 / 10000 + le.Populated_provnote_2_pcnt*ri.Populated_provnote_2_pcnt *   0.00 / 10000 + le.Populated_provnote_3_pcnt*ri.Populated_provnote_3_pcnt *   0.00 / 10000 + le.Populated_action_taken_ind_pcnt*ri.Populated_action_taken_ind_pcnt *   0.00 / 10000 + le.Populated_viol_type_pcnt*ri.Populated_viol_type_pcnt *   0.00 / 10000 + le.Populated_viol_cd_pcnt*ri.Populated_viol_cd_pcnt *   0.00 / 10000 + le.Populated_viol_desc_pcnt*ri.Populated_viol_desc_pcnt *   0.00 / 10000 + le.Populated_viol_dte_pcnt*ri.Populated_viol_dte_pcnt *   0.00 / 10000 + le.Populated_viol_case_nbr_pcnt*ri.Populated_viol_case_nbr_pcnt *   0.00 / 10000 + le.Populated_viol_eff_dte_pcnt*ri.Populated_viol_eff_dte_pcnt *   0.00 / 10000 + le.Populated_action_final_nbr_pcnt*ri.Populated_action_final_nbr_pcnt *   0.00 / 10000 + le.Populated_action_status_pcnt*ri.Populated_action_status_pcnt *   0.00 / 10000 + le.Populated_action_status_dte_pcnt*ri.Populated_action_status_dte_pcnt *   0.00 / 10000 + le.Populated_displinary_action_pcnt*ri.Populated_displinary_action_pcnt *   0.00 / 10000 + le.Populated_action_file_name_pcnt*ri.Populated_action_file_name_pcnt *   0.00 / 10000 + le.Populated_occupation_pcnt*ri.Populated_occupation_pcnt *   0.00 / 10000 + le.Populated_practice_hrs_pcnt*ri.Populated_practice_hrs_pcnt *   0.00 / 10000 + le.Populated_practice_type_pcnt*ri.Populated_practice_type_pcnt *   0.00 / 10000 + le.Populated_misc_other_id_pcnt*ri.Populated_misc_other_id_pcnt *   0.00 / 10000 + le.Populated_misc_other_type_pcnt*ri.Populated_misc_other_type_pcnt *   0.00 / 10000 + le.Populated_cont_education_ernd_pcnt*ri.Populated_cont_education_ernd_pcnt *   0.00 / 10000 + le.Populated_cont_education_req_pcnt*ri.Populated_cont_education_req_pcnt *   0.00 / 10000 + le.Populated_cont_education_term_pcnt*ri.Populated_cont_education_term_pcnt *   0.00 / 10000 + le.Populated_schl_attend_1_pcnt*ri.Populated_schl_attend_1_pcnt *   0.00 / 10000 + le.Populated_schl_attend_dte_1_pcnt*ri.Populated_schl_attend_dte_1_pcnt *   0.00 / 10000 + le.Populated_schl_curriculum_1_pcnt*ri.Populated_schl_curriculum_1_pcnt *   0.00 / 10000 + le.Populated_schl_degree_1_pcnt*ri.Populated_schl_degree_1_pcnt *   0.00 / 10000 + le.Populated_schl_attend_2_pcnt*ri.Populated_schl_attend_2_pcnt *   0.00 / 10000 + le.Populated_schl_attend_dte_2_pcnt*ri.Populated_schl_attend_dte_2_pcnt *   0.00 / 10000 + le.Populated_schl_curriculum_2_pcnt*ri.Populated_schl_curriculum_2_pcnt *   0.00 / 10000 + le.Populated_schl_degree_2_pcnt*ri.Populated_schl_degree_2_pcnt *   0.00 / 10000 + le.Populated_schl_attend_3_pcnt*ri.Populated_schl_attend_3_pcnt *   0.00 / 10000 + le.Populated_schl_attend_dte_3_pcnt*ri.Populated_schl_attend_dte_3_pcnt *   0.00 / 10000 + le.Populated_schl_curriculum_3_pcnt*ri.Populated_schl_curriculum_3_pcnt *   0.00 / 10000 + le.Populated_schl_degree_3_pcnt*ri.Populated_schl_degree_3_pcnt *   0.00 / 10000 + le.Populated_addl_license_spec_pcnt*ri.Populated_addl_license_spec_pcnt *   0.00 / 10000 + le.Populated_place_birth_cd_pcnt*ri.Populated_place_birth_cd_pcnt *   0.00 / 10000 + le.Populated_place_birth_desc_pcnt*ri.Populated_place_birth_desc_pcnt *   0.00 / 10000 + le.Populated_race_cd_pcnt*ri.Populated_race_cd_pcnt *   0.00 / 10000 + le.Populated_std_race_cd_pcnt*ri.Populated_std_race_cd_pcnt *   0.00 / 10000 + le.Populated_race_desc_pcnt*ri.Populated_race_desc_pcnt *   0.00 / 10000 + le.Populated_status_effect_dte_pcnt*ri.Populated_status_effect_dte_pcnt *   0.00 / 10000 + le.Populated_status_renew_desc_pcnt*ri.Populated_status_renew_desc_pcnt *   0.00 / 10000 + le.Populated_agency_status_pcnt*ri.Populated_agency_status_pcnt *   0.00 / 10000 + le.Populated_prev_primary_key_pcnt*ri.Populated_prev_primary_key_pcnt *   0.00 / 10000 + le.Populated_prev_mltreckey_pcnt*ri.Populated_prev_mltreckey_pcnt *   0.00 / 10000 + le.Populated_prev_cmc_slpk_pcnt*ri.Populated_prev_cmc_slpk_pcnt *   0.00 / 10000 + le.Populated_prev_pcmc_slpk_pcnt*ri.Populated_prev_pcmc_slpk_pcnt *   0.00 / 10000 + le.Populated_license_id_pcnt*ri.Populated_license_id_pcnt *   0.00 / 10000 + le.Populated_nmls_id_pcnt*ri.Populated_nmls_id_pcnt *   0.00 / 10000 + le.Populated_foreign_nmls_id_pcnt*ri.Populated_foreign_nmls_id_pcnt *   0.00 / 10000 + le.Populated_location_type_pcnt*ri.Populated_location_type_pcnt *   0.00 / 10000 + le.Populated_off_license_nbr_type_pcnt*ri.Populated_off_license_nbr_type_pcnt *   0.00 / 10000 + le.Populated_brkr_license_nbr_pcnt*ri.Populated_brkr_license_nbr_pcnt *   0.00 / 10000 + le.Populated_brkr_license_nbr_type_pcnt*ri.Populated_brkr_license_nbr_type_pcnt *   0.00 / 10000 + le.Populated_agency_id_pcnt*ri.Populated_agency_id_pcnt *   0.00 / 10000 + le.Populated_site_location_pcnt*ri.Populated_site_location_pcnt *   0.00 / 10000 + le.Populated_business_type_pcnt*ri.Populated_business_type_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_start_dte_pcnt*ri.Populated_start_dte_pcnt *   0.00 / 10000 + le.Populated_is_authorized_license_pcnt*ri.Populated_is_authorized_license_pcnt *   0.00 / 10000 + le.Populated_is_authorized_conduct_pcnt*ri.Populated_is_authorized_conduct_pcnt *   0.00 / 10000 + le.Populated_federal_regulator_pcnt*ri.Populated_federal_regulator_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'primary_key','create_dte','last_upd_dte','stamp_dte','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','process_date','gen_nbr','std_prof_cd','std_prof_desc','std_source_upd','std_source_desc','type_cd','name_org_prefx','name_org','name_org_sufx','store_nbr','name_dba_prefx','name_dba','name_dba_sufx','store_nbr_dba','dba_flag','name_office','office_parse','name_prefx','name_first','name_mid','name_last','name_sufx','name_nick','birth_dte','gender','prov_stat','credential','license_nbr','off_license_nbr','prev_license_nbr','prev_license_type','license_state','raw_license_type','std_license_type','std_license_desc','raw_license_status','std_license_status','std_status_desc','curr_issue_dte','orig_issue_dte','expire_dte','renewal_dte','active_flag','ssn_taxid_1','tax_type_1','ssn_taxid_2','tax_type_2','fed_rssd','addr_bus_ind','name_format','name_org_orig','name_dba_orig','name_mari_org','name_mari_dba','phn_mari_1','phn_mari_fax_1','phn_mari_2','phn_mari_fax_2','addr_addr1_1','addr_addr2_1','addr_addr3_1','addr_addr4_1','addr_city_1','addr_state_1','addr_zip5_1','addr_zip4_1','phn_phone_1','phn_fax_1','addr_cnty_1','addr_cntry_1','sud_key_1','ooc_ind_1','addr_mail_ind','addr_addr1_2','addr_addr2_2','addr_addr3_2','addr_addr4_2','addr_city_2','addr_state_2','addr_zip5_2','addr_zip4_2','addr_cnty_2','addr_cntry_2','phn_phone_2','phn_fax_2','sud_key_2','ooc_ind_2','license_nbr_contact','name_contact_prefx','name_contact_first','name_contact_mid','name_contact_last','name_contact_sufx','name_contact_nick','name_contact_ttl','phn_contact','phn_contact_ext','phn_contact_fax','email','url','bk_class','bk_class_desc','charter','inst_beg_dte','origin_cd','origin_cd_desc','disp_type_cd','disp_type_desc','reg_agent','regulator','hqtr_city','hqtr_name','domestic_off_nbr','foreign_off_nbr','hcr_rssd','hcr_location','affil_type_cd','genlink','research_ind','docket_id','mltreckey','cmc_slpk','pcmc_slpk','affil_key','provnote_1','provnote_2','provnote_3','action_taken_ind','viol_type','viol_cd','viol_desc','viol_dte','viol_case_nbr','viol_eff_dte','action_final_nbr','action_status','action_status_dte','displinary_action','action_file_name','occupation','practice_hrs','practice_type','misc_other_id','misc_other_type','cont_education_ernd','cont_education_req','cont_education_term','schl_attend_1','schl_attend_dte_1','schl_curriculum_1','schl_degree_1','schl_attend_2','schl_attend_dte_2','schl_curriculum_2','schl_degree_2','schl_attend_3','schl_attend_dte_3','schl_curriculum_3','schl_degree_3','addl_license_spec','place_birth_cd','place_birth_desc','race_cd','std_race_cd','race_desc','status_effect_dte','status_renew_desc','agency_status','prev_primary_key','prev_mltreckey','prev_cmc_slpk','prev_pcmc_slpk','license_id','nmls_id','foreign_nmls_id','location_type','off_license_nbr_type','brkr_license_nbr','brkr_license_nbr_type','agency_id','site_location','business_type','name_type','start_dte','is_authorized_license','is_authorized_conduct','federal_regulator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_primary_key_pcnt,le.populated_create_dte_pcnt,le.populated_last_upd_dte_pcnt,le.populated_stamp_dte_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_gen_nbr_pcnt,le.populated_std_prof_cd_pcnt,le.populated_std_prof_desc_pcnt,le.populated_std_source_upd_pcnt,le.populated_std_source_desc_pcnt,le.populated_type_cd_pcnt,le.populated_name_org_prefx_pcnt,le.populated_name_org_pcnt,le.populated_name_org_sufx_pcnt,le.populated_store_nbr_pcnt,le.populated_name_dba_prefx_pcnt,le.populated_name_dba_pcnt,le.populated_name_dba_sufx_pcnt,le.populated_store_nbr_dba_pcnt,le.populated_dba_flag_pcnt,le.populated_name_office_pcnt,le.populated_office_parse_pcnt,le.populated_name_prefx_pcnt,le.populated_name_first_pcnt,le.populated_name_mid_pcnt,le.populated_name_last_pcnt,le.populated_name_sufx_pcnt,le.populated_name_nick_pcnt,le.populated_birth_dte_pcnt,le.populated_gender_pcnt,le.populated_prov_stat_pcnt,le.populated_credential_pcnt,le.populated_license_nbr_pcnt,le.populated_off_license_nbr_pcnt,le.populated_prev_license_nbr_pcnt,le.populated_prev_license_type_pcnt,le.populated_license_state_pcnt,le.populated_raw_license_type_pcnt,le.populated_std_license_type_pcnt,le.populated_std_license_desc_pcnt,le.populated_raw_license_status_pcnt,le.populated_std_license_status_pcnt,le.populated_std_status_desc_pcnt,le.populated_curr_issue_dte_pcnt,le.populated_orig_issue_dte_pcnt,le.populated_expire_dte_pcnt,le.populated_renewal_dte_pcnt,le.populated_active_flag_pcnt,le.populated_ssn_taxid_1_pcnt,le.populated_tax_type_1_pcnt,le.populated_ssn_taxid_2_pcnt,le.populated_tax_type_2_pcnt,le.populated_fed_rssd_pcnt,le.populated_addr_bus_ind_pcnt,le.populated_name_format_pcnt,le.populated_name_org_orig_pcnt,le.populated_name_dba_orig_pcnt,le.populated_name_mari_org_pcnt,le.populated_name_mari_dba_pcnt,le.populated_phn_mari_1_pcnt,le.populated_phn_mari_fax_1_pcnt,le.populated_phn_mari_2_pcnt,le.populated_phn_mari_fax_2_pcnt,le.populated_addr_addr1_1_pcnt,le.populated_addr_addr2_1_pcnt,le.populated_addr_addr3_1_pcnt,le.populated_addr_addr4_1_pcnt,le.populated_addr_city_1_pcnt,le.populated_addr_state_1_pcnt,le.populated_addr_zip5_1_pcnt,le.populated_addr_zip4_1_pcnt,le.populated_phn_phone_1_pcnt,le.populated_phn_fax_1_pcnt,le.populated_addr_cnty_1_pcnt,le.populated_addr_cntry_1_pcnt,le.populated_sud_key_1_pcnt,le.populated_ooc_ind_1_pcnt,le.populated_addr_mail_ind_pcnt,le.populated_addr_addr1_2_pcnt,le.populated_addr_addr2_2_pcnt,le.populated_addr_addr3_2_pcnt,le.populated_addr_addr4_2_pcnt,le.populated_addr_city_2_pcnt,le.populated_addr_state_2_pcnt,le.populated_addr_zip5_2_pcnt,le.populated_addr_zip4_2_pcnt,le.populated_addr_cnty_2_pcnt,le.populated_addr_cntry_2_pcnt,le.populated_phn_phone_2_pcnt,le.populated_phn_fax_2_pcnt,le.populated_sud_key_2_pcnt,le.populated_ooc_ind_2_pcnt,le.populated_license_nbr_contact_pcnt,le.populated_name_contact_prefx_pcnt,le.populated_name_contact_first_pcnt,le.populated_name_contact_mid_pcnt,le.populated_name_contact_last_pcnt,le.populated_name_contact_sufx_pcnt,le.populated_name_contact_nick_pcnt,le.populated_name_contact_ttl_pcnt,le.populated_phn_contact_pcnt,le.populated_phn_contact_ext_pcnt,le.populated_phn_contact_fax_pcnt,le.populated_email_pcnt,le.populated_url_pcnt,le.populated_bk_class_pcnt,le.populated_bk_class_desc_pcnt,le.populated_charter_pcnt,le.populated_inst_beg_dte_pcnt,le.populated_origin_cd_pcnt,le.populated_origin_cd_desc_pcnt,le.populated_disp_type_cd_pcnt,le.populated_disp_type_desc_pcnt,le.populated_reg_agent_pcnt,le.populated_regulator_pcnt,le.populated_hqtr_city_pcnt,le.populated_hqtr_name_pcnt,le.populated_domestic_off_nbr_pcnt,le.populated_foreign_off_nbr_pcnt,le.populated_hcr_rssd_pcnt,le.populated_hcr_location_pcnt,le.populated_affil_type_cd_pcnt,le.populated_genlink_pcnt,le.populated_research_ind_pcnt,le.populated_docket_id_pcnt,le.populated_mltreckey_pcnt,le.populated_cmc_slpk_pcnt,le.populated_pcmc_slpk_pcnt,le.populated_affil_key_pcnt,le.populated_provnote_1_pcnt,le.populated_provnote_2_pcnt,le.populated_provnote_3_pcnt,le.populated_action_taken_ind_pcnt,le.populated_viol_type_pcnt,le.populated_viol_cd_pcnt,le.populated_viol_desc_pcnt,le.populated_viol_dte_pcnt,le.populated_viol_case_nbr_pcnt,le.populated_viol_eff_dte_pcnt,le.populated_action_final_nbr_pcnt,le.populated_action_status_pcnt,le.populated_action_status_dte_pcnt,le.populated_displinary_action_pcnt,le.populated_action_file_name_pcnt,le.populated_occupation_pcnt,le.populated_practice_hrs_pcnt,le.populated_practice_type_pcnt,le.populated_misc_other_id_pcnt,le.populated_misc_other_type_pcnt,le.populated_cont_education_ernd_pcnt,le.populated_cont_education_req_pcnt,le.populated_cont_education_term_pcnt,le.populated_schl_attend_1_pcnt,le.populated_schl_attend_dte_1_pcnt,le.populated_schl_curriculum_1_pcnt,le.populated_schl_degree_1_pcnt,le.populated_schl_attend_2_pcnt,le.populated_schl_attend_dte_2_pcnt,le.populated_schl_curriculum_2_pcnt,le.populated_schl_degree_2_pcnt,le.populated_schl_attend_3_pcnt,le.populated_schl_attend_dte_3_pcnt,le.populated_schl_curriculum_3_pcnt,le.populated_schl_degree_3_pcnt,le.populated_addl_license_spec_pcnt,le.populated_place_birth_cd_pcnt,le.populated_place_birth_desc_pcnt,le.populated_race_cd_pcnt,le.populated_std_race_cd_pcnt,le.populated_race_desc_pcnt,le.populated_status_effect_dte_pcnt,le.populated_status_renew_desc_pcnt,le.populated_agency_status_pcnt,le.populated_prev_primary_key_pcnt,le.populated_prev_mltreckey_pcnt,le.populated_prev_cmc_slpk_pcnt,le.populated_prev_pcmc_slpk_pcnt,le.populated_license_id_pcnt,le.populated_nmls_id_pcnt,le.populated_foreign_nmls_id_pcnt,le.populated_location_type_pcnt,le.populated_off_license_nbr_type_pcnt,le.populated_brkr_license_nbr_pcnt,le.populated_brkr_license_nbr_type_pcnt,le.populated_agency_id_pcnt,le.populated_site_location_pcnt,le.populated_business_type_pcnt,le.populated_name_type_pcnt,le.populated_start_dte_pcnt,le.populated_is_authorized_license_pcnt,le.populated_is_authorized_conduct_pcnt,le.populated_federal_regulator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_primary_key,le.maxlength_create_dte,le.maxlength_last_upd_dte,le.maxlength_stamp_dte,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_process_date,le.maxlength_gen_nbr,le.maxlength_std_prof_cd,le.maxlength_std_prof_desc,le.maxlength_std_source_upd,le.maxlength_std_source_desc,le.maxlength_type_cd,le.maxlength_name_org_prefx,le.maxlength_name_org,le.maxlength_name_org_sufx,le.maxlength_store_nbr,le.maxlength_name_dba_prefx,le.maxlength_name_dba,le.maxlength_name_dba_sufx,le.maxlength_store_nbr_dba,le.maxlength_dba_flag,le.maxlength_name_office,le.maxlength_office_parse,le.maxlength_name_prefx,le.maxlength_name_first,le.maxlength_name_mid,le.maxlength_name_last,le.maxlength_name_sufx,le.maxlength_name_nick,le.maxlength_birth_dte,le.maxlength_gender,le.maxlength_prov_stat,le.maxlength_credential,le.maxlength_license_nbr,le.maxlength_off_license_nbr,le.maxlength_prev_license_nbr,le.maxlength_prev_license_type,le.maxlength_license_state,le.maxlength_raw_license_type,le.maxlength_std_license_type,le.maxlength_std_license_desc,le.maxlength_raw_license_status,le.maxlength_std_license_status,le.maxlength_std_status_desc,le.maxlength_curr_issue_dte,le.maxlength_orig_issue_dte,le.maxlength_expire_dte,le.maxlength_renewal_dte,le.maxlength_active_flag,le.maxlength_ssn_taxid_1,le.maxlength_tax_type_1,le.maxlength_ssn_taxid_2,le.maxlength_tax_type_2,le.maxlength_fed_rssd,le.maxlength_addr_bus_ind,le.maxlength_name_format,le.maxlength_name_org_orig,le.maxlength_name_dba_orig,le.maxlength_name_mari_org,le.maxlength_name_mari_dba,le.maxlength_phn_mari_1,le.maxlength_phn_mari_fax_1,le.maxlength_phn_mari_2,le.maxlength_phn_mari_fax_2,le.maxlength_addr_addr1_1,le.maxlength_addr_addr2_1,le.maxlength_addr_addr3_1,le.maxlength_addr_addr4_1,le.maxlength_addr_city_1,le.maxlength_addr_state_1,le.maxlength_addr_zip5_1,le.maxlength_addr_zip4_1,le.maxlength_phn_phone_1,le.maxlength_phn_fax_1,le.maxlength_addr_cnty_1,le.maxlength_addr_cntry_1,le.maxlength_sud_key_1,le.maxlength_ooc_ind_1,le.maxlength_addr_mail_ind,le.maxlength_addr_addr1_2,le.maxlength_addr_addr2_2,le.maxlength_addr_addr3_2,le.maxlength_addr_addr4_2,le.maxlength_addr_city_2,le.maxlength_addr_state_2,le.maxlength_addr_zip5_2,le.maxlength_addr_zip4_2,le.maxlength_addr_cnty_2,le.maxlength_addr_cntry_2,le.maxlength_phn_phone_2,le.maxlength_phn_fax_2,le.maxlength_sud_key_2,le.maxlength_ooc_ind_2,le.maxlength_license_nbr_contact,le.maxlength_name_contact_prefx,le.maxlength_name_contact_first,le.maxlength_name_contact_mid,le.maxlength_name_contact_last,le.maxlength_name_contact_sufx,le.maxlength_name_contact_nick,le.maxlength_name_contact_ttl,le.maxlength_phn_contact,le.maxlength_phn_contact_ext,le.maxlength_phn_contact_fax,le.maxlength_email,le.maxlength_url,le.maxlength_bk_class,le.maxlength_bk_class_desc,le.maxlength_charter,le.maxlength_inst_beg_dte,le.maxlength_origin_cd,le.maxlength_origin_cd_desc,le.maxlength_disp_type_cd,le.maxlength_disp_type_desc,le.maxlength_reg_agent,le.maxlength_regulator,le.maxlength_hqtr_city,le.maxlength_hqtr_name,le.maxlength_domestic_off_nbr,le.maxlength_foreign_off_nbr,le.maxlength_hcr_rssd,le.maxlength_hcr_location,le.maxlength_affil_type_cd,le.maxlength_genlink,le.maxlength_research_ind,le.maxlength_docket_id,le.maxlength_mltreckey,le.maxlength_cmc_slpk,le.maxlength_pcmc_slpk,le.maxlength_affil_key,le.maxlength_provnote_1,le.maxlength_provnote_2,le.maxlength_provnote_3,le.maxlength_action_taken_ind,le.maxlength_viol_type,le.maxlength_viol_cd,le.maxlength_viol_desc,le.maxlength_viol_dte,le.maxlength_viol_case_nbr,le.maxlength_viol_eff_dte,le.maxlength_action_final_nbr,le.maxlength_action_status,le.maxlength_action_status_dte,le.maxlength_displinary_action,le.maxlength_action_file_name,le.maxlength_occupation,le.maxlength_practice_hrs,le.maxlength_practice_type,le.maxlength_misc_other_id,le.maxlength_misc_other_type,le.maxlength_cont_education_ernd,le.maxlength_cont_education_req,le.maxlength_cont_education_term,le.maxlength_schl_attend_1,le.maxlength_schl_attend_dte_1,le.maxlength_schl_curriculum_1,le.maxlength_schl_degree_1,le.maxlength_schl_attend_2,le.maxlength_schl_attend_dte_2,le.maxlength_schl_curriculum_2,le.maxlength_schl_degree_2,le.maxlength_schl_attend_3,le.maxlength_schl_attend_dte_3,le.maxlength_schl_curriculum_3,le.maxlength_schl_degree_3,le.maxlength_addl_license_spec,le.maxlength_place_birth_cd,le.maxlength_place_birth_desc,le.maxlength_race_cd,le.maxlength_std_race_cd,le.maxlength_race_desc,le.maxlength_status_effect_dte,le.maxlength_status_renew_desc,le.maxlength_agency_status,le.maxlength_prev_primary_key,le.maxlength_prev_mltreckey,le.maxlength_prev_cmc_slpk,le.maxlength_prev_pcmc_slpk,le.maxlength_license_id,le.maxlength_nmls_id,le.maxlength_foreign_nmls_id,le.maxlength_location_type,le.maxlength_off_license_nbr_type,le.maxlength_brkr_license_nbr,le.maxlength_brkr_license_nbr_type,le.maxlength_agency_id,le.maxlength_site_location,le.maxlength_business_type,le.maxlength_name_type,le.maxlength_start_dte,le.maxlength_is_authorized_license,le.maxlength_is_authorized_conduct,le.maxlength_federal_regulator);
  SELF.avelength := CHOOSE(C,le.avelength_primary_key,le.avelength_create_dte,le.avelength_last_upd_dte,le.avelength_stamp_dte,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_process_date,le.avelength_gen_nbr,le.avelength_std_prof_cd,le.avelength_std_prof_desc,le.avelength_std_source_upd,le.avelength_std_source_desc,le.avelength_type_cd,le.avelength_name_org_prefx,le.avelength_name_org,le.avelength_name_org_sufx,le.avelength_store_nbr,le.avelength_name_dba_prefx,le.avelength_name_dba,le.avelength_name_dba_sufx,le.avelength_store_nbr_dba,le.avelength_dba_flag,le.avelength_name_office,le.avelength_office_parse,le.avelength_name_prefx,le.avelength_name_first,le.avelength_name_mid,le.avelength_name_last,le.avelength_name_sufx,le.avelength_name_nick,le.avelength_birth_dte,le.avelength_gender,le.avelength_prov_stat,le.avelength_credential,le.avelength_license_nbr,le.avelength_off_license_nbr,le.avelength_prev_license_nbr,le.avelength_prev_license_type,le.avelength_license_state,le.avelength_raw_license_type,le.avelength_std_license_type,le.avelength_std_license_desc,le.avelength_raw_license_status,le.avelength_std_license_status,le.avelength_std_status_desc,le.avelength_curr_issue_dte,le.avelength_orig_issue_dte,le.avelength_expire_dte,le.avelength_renewal_dte,le.avelength_active_flag,le.avelength_ssn_taxid_1,le.avelength_tax_type_1,le.avelength_ssn_taxid_2,le.avelength_tax_type_2,le.avelength_fed_rssd,le.avelength_addr_bus_ind,le.avelength_name_format,le.avelength_name_org_orig,le.avelength_name_dba_orig,le.avelength_name_mari_org,le.avelength_name_mari_dba,le.avelength_phn_mari_1,le.avelength_phn_mari_fax_1,le.avelength_phn_mari_2,le.avelength_phn_mari_fax_2,le.avelength_addr_addr1_1,le.avelength_addr_addr2_1,le.avelength_addr_addr3_1,le.avelength_addr_addr4_1,le.avelength_addr_city_1,le.avelength_addr_state_1,le.avelength_addr_zip5_1,le.avelength_addr_zip4_1,le.avelength_phn_phone_1,le.avelength_phn_fax_1,le.avelength_addr_cnty_1,le.avelength_addr_cntry_1,le.avelength_sud_key_1,le.avelength_ooc_ind_1,le.avelength_addr_mail_ind,le.avelength_addr_addr1_2,le.avelength_addr_addr2_2,le.avelength_addr_addr3_2,le.avelength_addr_addr4_2,le.avelength_addr_city_2,le.avelength_addr_state_2,le.avelength_addr_zip5_2,le.avelength_addr_zip4_2,le.avelength_addr_cnty_2,le.avelength_addr_cntry_2,le.avelength_phn_phone_2,le.avelength_phn_fax_2,le.avelength_sud_key_2,le.avelength_ooc_ind_2,le.avelength_license_nbr_contact,le.avelength_name_contact_prefx,le.avelength_name_contact_first,le.avelength_name_contact_mid,le.avelength_name_contact_last,le.avelength_name_contact_sufx,le.avelength_name_contact_nick,le.avelength_name_contact_ttl,le.avelength_phn_contact,le.avelength_phn_contact_ext,le.avelength_phn_contact_fax,le.avelength_email,le.avelength_url,le.avelength_bk_class,le.avelength_bk_class_desc,le.avelength_charter,le.avelength_inst_beg_dte,le.avelength_origin_cd,le.avelength_origin_cd_desc,le.avelength_disp_type_cd,le.avelength_disp_type_desc,le.avelength_reg_agent,le.avelength_regulator,le.avelength_hqtr_city,le.avelength_hqtr_name,le.avelength_domestic_off_nbr,le.avelength_foreign_off_nbr,le.avelength_hcr_rssd,le.avelength_hcr_location,le.avelength_affil_type_cd,le.avelength_genlink,le.avelength_research_ind,le.avelength_docket_id,le.avelength_mltreckey,le.avelength_cmc_slpk,le.avelength_pcmc_slpk,le.avelength_affil_key,le.avelength_provnote_1,le.avelength_provnote_2,le.avelength_provnote_3,le.avelength_action_taken_ind,le.avelength_viol_type,le.avelength_viol_cd,le.avelength_viol_desc,le.avelength_viol_dte,le.avelength_viol_case_nbr,le.avelength_viol_eff_dte,le.avelength_action_final_nbr,le.avelength_action_status,le.avelength_action_status_dte,le.avelength_displinary_action,le.avelength_action_file_name,le.avelength_occupation,le.avelength_practice_hrs,le.avelength_practice_type,le.avelength_misc_other_id,le.avelength_misc_other_type,le.avelength_cont_education_ernd,le.avelength_cont_education_req,le.avelength_cont_education_term,le.avelength_schl_attend_1,le.avelength_schl_attend_dte_1,le.avelength_schl_curriculum_1,le.avelength_schl_degree_1,le.avelength_schl_attend_2,le.avelength_schl_attend_dte_2,le.avelength_schl_curriculum_2,le.avelength_schl_degree_2,le.avelength_schl_attend_3,le.avelength_schl_attend_dte_3,le.avelength_schl_curriculum_3,le.avelength_schl_degree_3,le.avelength_addl_license_spec,le.avelength_place_birth_cd,le.avelength_place_birth_desc,le.avelength_race_cd,le.avelength_std_race_cd,le.avelength_race_desc,le.avelength_status_effect_dte,le.avelength_status_renew_desc,le.avelength_agency_status,le.avelength_prev_primary_key,le.avelength_prev_mltreckey,le.avelength_prev_cmc_slpk,le.avelength_prev_pcmc_slpk,le.avelength_license_id,le.avelength_nmls_id,le.avelength_foreign_nmls_id,le.avelength_location_type,le.avelength_off_license_nbr_type,le.avelength_brkr_license_nbr,le.avelength_brkr_license_nbr_type,le.avelength_agency_id,le.avelength_site_location,le.avelength_business_type,le.avelength_name_type,le.avelength_start_dte,le.avelength_is_authorized_license,le.avelength_is_authorized_conduct,le.avelength_federal_regulator);
END;
EXPORT invSummary := NORMALIZE(summary0, 196, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.std_source_upd;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.primary_key),TRIM((SALT31.StrType)le.create_dte),TRIM((SALT31.StrType)le.last_upd_dte),TRIM((SALT31.StrType)le.stamp_dte),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.process_date),TRIM((SALT31.StrType)le.gen_nbr),TRIM((SALT31.StrType)le.std_prof_cd),TRIM((SALT31.StrType)le.std_prof_desc),TRIM((SALT31.StrType)le.std_source_upd),TRIM((SALT31.StrType)le.std_source_desc),TRIM((SALT31.StrType)le.type_cd),TRIM((SALT31.StrType)le.name_org_prefx),TRIM((SALT31.StrType)le.name_org),TRIM((SALT31.StrType)le.name_org_sufx),TRIM((SALT31.StrType)le.store_nbr),TRIM((SALT31.StrType)le.name_dba_prefx),TRIM((SALT31.StrType)le.name_dba),TRIM((SALT31.StrType)le.name_dba_sufx),TRIM((SALT31.StrType)le.store_nbr_dba),TRIM((SALT31.StrType)le.dba_flag),TRIM((SALT31.StrType)le.name_office),TRIM((SALT31.StrType)le.office_parse),TRIM((SALT31.StrType)le.name_prefx),TRIM((SALT31.StrType)le.name_first),TRIM((SALT31.StrType)le.name_mid),TRIM((SALT31.StrType)le.name_last),TRIM((SALT31.StrType)le.name_sufx),TRIM((SALT31.StrType)le.name_nick),TRIM((SALT31.StrType)le.birth_dte),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.prov_stat),TRIM((SALT31.StrType)le.credential),TRIM((SALT31.StrType)le.license_nbr),TRIM((SALT31.StrType)le.off_license_nbr),TRIM((SALT31.StrType)le.prev_license_nbr),TRIM((SALT31.StrType)le.prev_license_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.raw_license_type),TRIM((SALT31.StrType)le.std_license_type),TRIM((SALT31.StrType)le.std_license_desc),TRIM((SALT31.StrType)le.raw_license_status),TRIM((SALT31.StrType)le.std_license_status),TRIM((SALT31.StrType)le.std_status_desc),TRIM((SALT31.StrType)le.curr_issue_dte),TRIM((SALT31.StrType)le.orig_issue_dte),TRIM((SALT31.StrType)le.expire_dte),TRIM((SALT31.StrType)le.renewal_dte),TRIM((SALT31.StrType)le.active_flag),TRIM((SALT31.StrType)le.ssn_taxid_1),TRIM((SALT31.StrType)le.tax_type_1),TRIM((SALT31.StrType)le.ssn_taxid_2),TRIM((SALT31.StrType)le.tax_type_2),TRIM((SALT31.StrType)le.fed_rssd),TRIM((SALT31.StrType)le.addr_bus_ind),TRIM((SALT31.StrType)le.name_format),TRIM((SALT31.StrType)le.name_org_orig),TRIM((SALT31.StrType)le.name_dba_orig),TRIM((SALT31.StrType)le.name_mari_org),TRIM((SALT31.StrType)le.name_mari_dba),TRIM((SALT31.StrType)le.phn_mari_1),TRIM((SALT31.StrType)le.phn_mari_fax_1),TRIM((SALT31.StrType)le.phn_mari_2),TRIM((SALT31.StrType)le.phn_mari_fax_2),TRIM((SALT31.StrType)le.addr_addr1_1),TRIM((SALT31.StrType)le.addr_addr2_1),TRIM((SALT31.StrType)le.addr_addr3_1),TRIM((SALT31.StrType)le.addr_addr4_1),TRIM((SALT31.StrType)le.addr_city_1),TRIM((SALT31.StrType)le.addr_state_1),TRIM((SALT31.StrType)le.addr_zip5_1),TRIM((SALT31.StrType)le.addr_zip4_1),TRIM((SALT31.StrType)le.phn_phone_1),TRIM((SALT31.StrType)le.phn_fax_1),TRIM((SALT31.StrType)le.addr_cnty_1),TRIM((SALT31.StrType)le.addr_cntry_1),TRIM((SALT31.StrType)le.sud_key_1),TRIM((SALT31.StrType)le.ooc_ind_1),TRIM((SALT31.StrType)le.addr_mail_ind),TRIM((SALT31.StrType)le.addr_addr1_2),TRIM((SALT31.StrType)le.addr_addr2_2),TRIM((SALT31.StrType)le.addr_addr3_2),TRIM((SALT31.StrType)le.addr_addr4_2),TRIM((SALT31.StrType)le.addr_city_2),TRIM((SALT31.StrType)le.addr_state_2),TRIM((SALT31.StrType)le.addr_zip5_2),TRIM((SALT31.StrType)le.addr_zip4_2),TRIM((SALT31.StrType)le.addr_cnty_2),TRIM((SALT31.StrType)le.addr_cntry_2),TRIM((SALT31.StrType)le.phn_phone_2),TRIM((SALT31.StrType)le.phn_fax_2),TRIM((SALT31.StrType)le.sud_key_2),TRIM((SALT31.StrType)le.ooc_ind_2),TRIM((SALT31.StrType)le.license_nbr_contact),TRIM((SALT31.StrType)le.name_contact_prefx),TRIM((SALT31.StrType)le.name_contact_first),TRIM((SALT31.StrType)le.name_contact_mid),TRIM((SALT31.StrType)le.name_contact_last),TRIM((SALT31.StrType)le.name_contact_sufx),TRIM((SALT31.StrType)le.name_contact_nick),TRIM((SALT31.StrType)le.name_contact_ttl),TRIM((SALT31.StrType)le.phn_contact),TRIM((SALT31.StrType)le.phn_contact_ext),TRIM((SALT31.StrType)le.phn_contact_fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.url),TRIM((SALT31.StrType)le.bk_class),TRIM((SALT31.StrType)le.bk_class_desc),TRIM((SALT31.StrType)le.charter),TRIM((SALT31.StrType)le.inst_beg_dte),TRIM((SALT31.StrType)le.origin_cd),TRIM((SALT31.StrType)le.origin_cd_desc),TRIM((SALT31.StrType)le.disp_type_cd),TRIM((SALT31.StrType)le.disp_type_desc),TRIM((SALT31.StrType)le.reg_agent),TRIM((SALT31.StrType)le.regulator),TRIM((SALT31.StrType)le.hqtr_city),TRIM((SALT31.StrType)le.hqtr_name),TRIM((SALT31.StrType)le.domestic_off_nbr),TRIM((SALT31.StrType)le.foreign_off_nbr),TRIM((SALT31.StrType)le.hcr_rssd),TRIM((SALT31.StrType)le.hcr_location),TRIM((SALT31.StrType)le.affil_type_cd),TRIM((SALT31.StrType)le.genlink),TRIM((SALT31.StrType)le.research_ind),TRIM((SALT31.StrType)le.docket_id),TRIM((SALT31.StrType)le.mltreckey),TRIM((SALT31.StrType)le.cmc_slpk),TRIM((SALT31.StrType)le.pcmc_slpk),TRIM((SALT31.StrType)le.affil_key),TRIM((SALT31.StrType)le.provnote_1),TRIM((SALT31.StrType)le.provnote_2),TRIM((SALT31.StrType)le.provnote_3),TRIM((SALT31.StrType)le.action_taken_ind),TRIM((SALT31.StrType)le.viol_type),TRIM((SALT31.StrType)le.viol_cd),TRIM((SALT31.StrType)le.viol_desc),TRIM((SALT31.StrType)le.viol_dte),TRIM((SALT31.StrType)le.viol_case_nbr),TRIM((SALT31.StrType)le.viol_eff_dte),TRIM((SALT31.StrType)le.action_final_nbr),TRIM((SALT31.StrType)le.action_status),TRIM((SALT31.StrType)le.action_status_dte),TRIM((SALT31.StrType)le.displinary_action),TRIM((SALT31.StrType)le.action_file_name),TRIM((SALT31.StrType)le.occupation),TRIM((SALT31.StrType)le.practice_hrs),TRIM((SALT31.StrType)le.practice_type),TRIM((SALT31.StrType)le.misc_other_id),TRIM((SALT31.StrType)le.misc_other_type),TRIM((SALT31.StrType)le.cont_education_ernd),TRIM((SALT31.StrType)le.cont_education_req),TRIM((SALT31.StrType)le.cont_education_term),TRIM((SALT31.StrType)le.schl_attend_1),TRIM((SALT31.StrType)le.schl_attend_dte_1),TRIM((SALT31.StrType)le.schl_curriculum_1),TRIM((SALT31.StrType)le.schl_degree_1),TRIM((SALT31.StrType)le.schl_attend_2),TRIM((SALT31.StrType)le.schl_attend_dte_2),TRIM((SALT31.StrType)le.schl_curriculum_2),TRIM((SALT31.StrType)le.schl_degree_2),TRIM((SALT31.StrType)le.schl_attend_3),TRIM((SALT31.StrType)le.schl_attend_dte_3),TRIM((SALT31.StrType)le.schl_curriculum_3),TRIM((SALT31.StrType)le.schl_degree_3),TRIM((SALT31.StrType)le.addl_license_spec),TRIM((SALT31.StrType)le.place_birth_cd),TRIM((SALT31.StrType)le.place_birth_desc),TRIM((SALT31.StrType)le.race_cd),TRIM((SALT31.StrType)le.std_race_cd),TRIM((SALT31.StrType)le.race_desc),TRIM((SALT31.StrType)le.status_effect_dte),TRIM((SALT31.StrType)le.status_renew_desc),TRIM((SALT31.StrType)le.agency_status),TRIM((SALT31.StrType)le.prev_primary_key),TRIM((SALT31.StrType)le.prev_mltreckey),TRIM((SALT31.StrType)le.prev_cmc_slpk),TRIM((SALT31.StrType)le.prev_pcmc_slpk),TRIM((SALT31.StrType)le.license_id),TRIM((SALT31.StrType)le.nmls_id),TRIM((SALT31.StrType)le.foreign_nmls_id),TRIM((SALT31.StrType)le.location_type),TRIM((SALT31.StrType)le.off_license_nbr_type),TRIM((SALT31.StrType)le.brkr_license_nbr),TRIM((SALT31.StrType)le.brkr_license_nbr_type),TRIM((SALT31.StrType)le.agency_id),TRIM((SALT31.StrType)le.site_location),TRIM((SALT31.StrType)le.business_type),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.start_dte),TRIM((SALT31.StrType)le.is_authorized_license),TRIM((SALT31.StrType)le.is_authorized_conduct),TRIM((SALT31.StrType)le.federal_regulator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,196,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 196);
  SELF.FldNo2 := 1 + (C % 196);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.primary_key),TRIM((SALT31.StrType)le.create_dte),TRIM((SALT31.StrType)le.last_upd_dte),TRIM((SALT31.StrType)le.stamp_dte),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.process_date),TRIM((SALT31.StrType)le.gen_nbr),TRIM((SALT31.StrType)le.std_prof_cd),TRIM((SALT31.StrType)le.std_prof_desc),TRIM((SALT31.StrType)le.std_source_upd),TRIM((SALT31.StrType)le.std_source_desc),TRIM((SALT31.StrType)le.type_cd),TRIM((SALT31.StrType)le.name_org_prefx),TRIM((SALT31.StrType)le.name_org),TRIM((SALT31.StrType)le.name_org_sufx),TRIM((SALT31.StrType)le.store_nbr),TRIM((SALT31.StrType)le.name_dba_prefx),TRIM((SALT31.StrType)le.name_dba),TRIM((SALT31.StrType)le.name_dba_sufx),TRIM((SALT31.StrType)le.store_nbr_dba),TRIM((SALT31.StrType)le.dba_flag),TRIM((SALT31.StrType)le.name_office),TRIM((SALT31.StrType)le.office_parse),TRIM((SALT31.StrType)le.name_prefx),TRIM((SALT31.StrType)le.name_first),TRIM((SALT31.StrType)le.name_mid),TRIM((SALT31.StrType)le.name_last),TRIM((SALT31.StrType)le.name_sufx),TRIM((SALT31.StrType)le.name_nick),TRIM((SALT31.StrType)le.birth_dte),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.prov_stat),TRIM((SALT31.StrType)le.credential),TRIM((SALT31.StrType)le.license_nbr),TRIM((SALT31.StrType)le.off_license_nbr),TRIM((SALT31.StrType)le.prev_license_nbr),TRIM((SALT31.StrType)le.prev_license_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.raw_license_type),TRIM((SALT31.StrType)le.std_license_type),TRIM((SALT31.StrType)le.std_license_desc),TRIM((SALT31.StrType)le.raw_license_status),TRIM((SALT31.StrType)le.std_license_status),TRIM((SALT31.StrType)le.std_status_desc),TRIM((SALT31.StrType)le.curr_issue_dte),TRIM((SALT31.StrType)le.orig_issue_dte),TRIM((SALT31.StrType)le.expire_dte),TRIM((SALT31.StrType)le.renewal_dte),TRIM((SALT31.StrType)le.active_flag),TRIM((SALT31.StrType)le.ssn_taxid_1),TRIM((SALT31.StrType)le.tax_type_1),TRIM((SALT31.StrType)le.ssn_taxid_2),TRIM((SALT31.StrType)le.tax_type_2),TRIM((SALT31.StrType)le.fed_rssd),TRIM((SALT31.StrType)le.addr_bus_ind),TRIM((SALT31.StrType)le.name_format),TRIM((SALT31.StrType)le.name_org_orig),TRIM((SALT31.StrType)le.name_dba_orig),TRIM((SALT31.StrType)le.name_mari_org),TRIM((SALT31.StrType)le.name_mari_dba),TRIM((SALT31.StrType)le.phn_mari_1),TRIM((SALT31.StrType)le.phn_mari_fax_1),TRIM((SALT31.StrType)le.phn_mari_2),TRIM((SALT31.StrType)le.phn_mari_fax_2),TRIM((SALT31.StrType)le.addr_addr1_1),TRIM((SALT31.StrType)le.addr_addr2_1),TRIM((SALT31.StrType)le.addr_addr3_1),TRIM((SALT31.StrType)le.addr_addr4_1),TRIM((SALT31.StrType)le.addr_city_1),TRIM((SALT31.StrType)le.addr_state_1),TRIM((SALT31.StrType)le.addr_zip5_1),TRIM((SALT31.StrType)le.addr_zip4_1),TRIM((SALT31.StrType)le.phn_phone_1),TRIM((SALT31.StrType)le.phn_fax_1),TRIM((SALT31.StrType)le.addr_cnty_1),TRIM((SALT31.StrType)le.addr_cntry_1),TRIM((SALT31.StrType)le.sud_key_1),TRIM((SALT31.StrType)le.ooc_ind_1),TRIM((SALT31.StrType)le.addr_mail_ind),TRIM((SALT31.StrType)le.addr_addr1_2),TRIM((SALT31.StrType)le.addr_addr2_2),TRIM((SALT31.StrType)le.addr_addr3_2),TRIM((SALT31.StrType)le.addr_addr4_2),TRIM((SALT31.StrType)le.addr_city_2),TRIM((SALT31.StrType)le.addr_state_2),TRIM((SALT31.StrType)le.addr_zip5_2),TRIM((SALT31.StrType)le.addr_zip4_2),TRIM((SALT31.StrType)le.addr_cnty_2),TRIM((SALT31.StrType)le.addr_cntry_2),TRIM((SALT31.StrType)le.phn_phone_2),TRIM((SALT31.StrType)le.phn_fax_2),TRIM((SALT31.StrType)le.sud_key_2),TRIM((SALT31.StrType)le.ooc_ind_2),TRIM((SALT31.StrType)le.license_nbr_contact),TRIM((SALT31.StrType)le.name_contact_prefx),TRIM((SALT31.StrType)le.name_contact_first),TRIM((SALT31.StrType)le.name_contact_mid),TRIM((SALT31.StrType)le.name_contact_last),TRIM((SALT31.StrType)le.name_contact_sufx),TRIM((SALT31.StrType)le.name_contact_nick),TRIM((SALT31.StrType)le.name_contact_ttl),TRIM((SALT31.StrType)le.phn_contact),TRIM((SALT31.StrType)le.phn_contact_ext),TRIM((SALT31.StrType)le.phn_contact_fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.url),TRIM((SALT31.StrType)le.bk_class),TRIM((SALT31.StrType)le.bk_class_desc),TRIM((SALT31.StrType)le.charter),TRIM((SALT31.StrType)le.inst_beg_dte),TRIM((SALT31.StrType)le.origin_cd),TRIM((SALT31.StrType)le.origin_cd_desc),TRIM((SALT31.StrType)le.disp_type_cd),TRIM((SALT31.StrType)le.disp_type_desc),TRIM((SALT31.StrType)le.reg_agent),TRIM((SALT31.StrType)le.regulator),TRIM((SALT31.StrType)le.hqtr_city),TRIM((SALT31.StrType)le.hqtr_name),TRIM((SALT31.StrType)le.domestic_off_nbr),TRIM((SALT31.StrType)le.foreign_off_nbr),TRIM((SALT31.StrType)le.hcr_rssd),TRIM((SALT31.StrType)le.hcr_location),TRIM((SALT31.StrType)le.affil_type_cd),TRIM((SALT31.StrType)le.genlink),TRIM((SALT31.StrType)le.research_ind),TRIM((SALT31.StrType)le.docket_id),TRIM((SALT31.StrType)le.mltreckey),TRIM((SALT31.StrType)le.cmc_slpk),TRIM((SALT31.StrType)le.pcmc_slpk),TRIM((SALT31.StrType)le.affil_key),TRIM((SALT31.StrType)le.provnote_1),TRIM((SALT31.StrType)le.provnote_2),TRIM((SALT31.StrType)le.provnote_3),TRIM((SALT31.StrType)le.action_taken_ind),TRIM((SALT31.StrType)le.viol_type),TRIM((SALT31.StrType)le.viol_cd),TRIM((SALT31.StrType)le.viol_desc),TRIM((SALT31.StrType)le.viol_dte),TRIM((SALT31.StrType)le.viol_case_nbr),TRIM((SALT31.StrType)le.viol_eff_dte),TRIM((SALT31.StrType)le.action_final_nbr),TRIM((SALT31.StrType)le.action_status),TRIM((SALT31.StrType)le.action_status_dte),TRIM((SALT31.StrType)le.displinary_action),TRIM((SALT31.StrType)le.action_file_name),TRIM((SALT31.StrType)le.occupation),TRIM((SALT31.StrType)le.practice_hrs),TRIM((SALT31.StrType)le.practice_type),TRIM((SALT31.StrType)le.misc_other_id),TRIM((SALT31.StrType)le.misc_other_type),TRIM((SALT31.StrType)le.cont_education_ernd),TRIM((SALT31.StrType)le.cont_education_req),TRIM((SALT31.StrType)le.cont_education_term),TRIM((SALT31.StrType)le.schl_attend_1),TRIM((SALT31.StrType)le.schl_attend_dte_1),TRIM((SALT31.StrType)le.schl_curriculum_1),TRIM((SALT31.StrType)le.schl_degree_1),TRIM((SALT31.StrType)le.schl_attend_2),TRIM((SALT31.StrType)le.schl_attend_dte_2),TRIM((SALT31.StrType)le.schl_curriculum_2),TRIM((SALT31.StrType)le.schl_degree_2),TRIM((SALT31.StrType)le.schl_attend_3),TRIM((SALT31.StrType)le.schl_attend_dte_3),TRIM((SALT31.StrType)le.schl_curriculum_3),TRIM((SALT31.StrType)le.schl_degree_3),TRIM((SALT31.StrType)le.addl_license_spec),TRIM((SALT31.StrType)le.place_birth_cd),TRIM((SALT31.StrType)le.place_birth_desc),TRIM((SALT31.StrType)le.race_cd),TRIM((SALT31.StrType)le.std_race_cd),TRIM((SALT31.StrType)le.race_desc),TRIM((SALT31.StrType)le.status_effect_dte),TRIM((SALT31.StrType)le.status_renew_desc),TRIM((SALT31.StrType)le.agency_status),TRIM((SALT31.StrType)le.prev_primary_key),TRIM((SALT31.StrType)le.prev_mltreckey),TRIM((SALT31.StrType)le.prev_cmc_slpk),TRIM((SALT31.StrType)le.prev_pcmc_slpk),TRIM((SALT31.StrType)le.license_id),TRIM((SALT31.StrType)le.nmls_id),TRIM((SALT31.StrType)le.foreign_nmls_id),TRIM((SALT31.StrType)le.location_type),TRIM((SALT31.StrType)le.off_license_nbr_type),TRIM((SALT31.StrType)le.brkr_license_nbr),TRIM((SALT31.StrType)le.brkr_license_nbr_type),TRIM((SALT31.StrType)le.agency_id),TRIM((SALT31.StrType)le.site_location),TRIM((SALT31.StrType)le.business_type),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.start_dte),TRIM((SALT31.StrType)le.is_authorized_license),TRIM((SALT31.StrType)le.is_authorized_conduct),TRIM((SALT31.StrType)le.federal_regulator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.primary_key),TRIM((SALT31.StrType)le.create_dte),TRIM((SALT31.StrType)le.last_upd_dte),TRIM((SALT31.StrType)le.stamp_dte),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.process_date),TRIM((SALT31.StrType)le.gen_nbr),TRIM((SALT31.StrType)le.std_prof_cd),TRIM((SALT31.StrType)le.std_prof_desc),TRIM((SALT31.StrType)le.std_source_upd),TRIM((SALT31.StrType)le.std_source_desc),TRIM((SALT31.StrType)le.type_cd),TRIM((SALT31.StrType)le.name_org_prefx),TRIM((SALT31.StrType)le.name_org),TRIM((SALT31.StrType)le.name_org_sufx),TRIM((SALT31.StrType)le.store_nbr),TRIM((SALT31.StrType)le.name_dba_prefx),TRIM((SALT31.StrType)le.name_dba),TRIM((SALT31.StrType)le.name_dba_sufx),TRIM((SALT31.StrType)le.store_nbr_dba),TRIM((SALT31.StrType)le.dba_flag),TRIM((SALT31.StrType)le.name_office),TRIM((SALT31.StrType)le.office_parse),TRIM((SALT31.StrType)le.name_prefx),TRIM((SALT31.StrType)le.name_first),TRIM((SALT31.StrType)le.name_mid),TRIM((SALT31.StrType)le.name_last),TRIM((SALT31.StrType)le.name_sufx),TRIM((SALT31.StrType)le.name_nick),TRIM((SALT31.StrType)le.birth_dte),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.prov_stat),TRIM((SALT31.StrType)le.credential),TRIM((SALT31.StrType)le.license_nbr),TRIM((SALT31.StrType)le.off_license_nbr),TRIM((SALT31.StrType)le.prev_license_nbr),TRIM((SALT31.StrType)le.prev_license_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.raw_license_type),TRIM((SALT31.StrType)le.std_license_type),TRIM((SALT31.StrType)le.std_license_desc),TRIM((SALT31.StrType)le.raw_license_status),TRIM((SALT31.StrType)le.std_license_status),TRIM((SALT31.StrType)le.std_status_desc),TRIM((SALT31.StrType)le.curr_issue_dte),TRIM((SALT31.StrType)le.orig_issue_dte),TRIM((SALT31.StrType)le.expire_dte),TRIM((SALT31.StrType)le.renewal_dte),TRIM((SALT31.StrType)le.active_flag),TRIM((SALT31.StrType)le.ssn_taxid_1),TRIM((SALT31.StrType)le.tax_type_1),TRIM((SALT31.StrType)le.ssn_taxid_2),TRIM((SALT31.StrType)le.tax_type_2),TRIM((SALT31.StrType)le.fed_rssd),TRIM((SALT31.StrType)le.addr_bus_ind),TRIM((SALT31.StrType)le.name_format),TRIM((SALT31.StrType)le.name_org_orig),TRIM((SALT31.StrType)le.name_dba_orig),TRIM((SALT31.StrType)le.name_mari_org),TRIM((SALT31.StrType)le.name_mari_dba),TRIM((SALT31.StrType)le.phn_mari_1),TRIM((SALT31.StrType)le.phn_mari_fax_1),TRIM((SALT31.StrType)le.phn_mari_2),TRIM((SALT31.StrType)le.phn_mari_fax_2),TRIM((SALT31.StrType)le.addr_addr1_1),TRIM((SALT31.StrType)le.addr_addr2_1),TRIM((SALT31.StrType)le.addr_addr3_1),TRIM((SALT31.StrType)le.addr_addr4_1),TRIM((SALT31.StrType)le.addr_city_1),TRIM((SALT31.StrType)le.addr_state_1),TRIM((SALT31.StrType)le.addr_zip5_1),TRIM((SALT31.StrType)le.addr_zip4_1),TRIM((SALT31.StrType)le.phn_phone_1),TRIM((SALT31.StrType)le.phn_fax_1),TRIM((SALT31.StrType)le.addr_cnty_1),TRIM((SALT31.StrType)le.addr_cntry_1),TRIM((SALT31.StrType)le.sud_key_1),TRIM((SALT31.StrType)le.ooc_ind_1),TRIM((SALT31.StrType)le.addr_mail_ind),TRIM((SALT31.StrType)le.addr_addr1_2),TRIM((SALT31.StrType)le.addr_addr2_2),TRIM((SALT31.StrType)le.addr_addr3_2),TRIM((SALT31.StrType)le.addr_addr4_2),TRIM((SALT31.StrType)le.addr_city_2),TRIM((SALT31.StrType)le.addr_state_2),TRIM((SALT31.StrType)le.addr_zip5_2),TRIM((SALT31.StrType)le.addr_zip4_2),TRIM((SALT31.StrType)le.addr_cnty_2),TRIM((SALT31.StrType)le.addr_cntry_2),TRIM((SALT31.StrType)le.phn_phone_2),TRIM((SALT31.StrType)le.phn_fax_2),TRIM((SALT31.StrType)le.sud_key_2),TRIM((SALT31.StrType)le.ooc_ind_2),TRIM((SALT31.StrType)le.license_nbr_contact),TRIM((SALT31.StrType)le.name_contact_prefx),TRIM((SALT31.StrType)le.name_contact_first),TRIM((SALT31.StrType)le.name_contact_mid),TRIM((SALT31.StrType)le.name_contact_last),TRIM((SALT31.StrType)le.name_contact_sufx),TRIM((SALT31.StrType)le.name_contact_nick),TRIM((SALT31.StrType)le.name_contact_ttl),TRIM((SALT31.StrType)le.phn_contact),TRIM((SALT31.StrType)le.phn_contact_ext),TRIM((SALT31.StrType)le.phn_contact_fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.url),TRIM((SALT31.StrType)le.bk_class),TRIM((SALT31.StrType)le.bk_class_desc),TRIM((SALT31.StrType)le.charter),TRIM((SALT31.StrType)le.inst_beg_dte),TRIM((SALT31.StrType)le.origin_cd),TRIM((SALT31.StrType)le.origin_cd_desc),TRIM((SALT31.StrType)le.disp_type_cd),TRIM((SALT31.StrType)le.disp_type_desc),TRIM((SALT31.StrType)le.reg_agent),TRIM((SALT31.StrType)le.regulator),TRIM((SALT31.StrType)le.hqtr_city),TRIM((SALT31.StrType)le.hqtr_name),TRIM((SALT31.StrType)le.domestic_off_nbr),TRIM((SALT31.StrType)le.foreign_off_nbr),TRIM((SALT31.StrType)le.hcr_rssd),TRIM((SALT31.StrType)le.hcr_location),TRIM((SALT31.StrType)le.affil_type_cd),TRIM((SALT31.StrType)le.genlink),TRIM((SALT31.StrType)le.research_ind),TRIM((SALT31.StrType)le.docket_id),TRIM((SALT31.StrType)le.mltreckey),TRIM((SALT31.StrType)le.cmc_slpk),TRIM((SALT31.StrType)le.pcmc_slpk),TRIM((SALT31.StrType)le.affil_key),TRIM((SALT31.StrType)le.provnote_1),TRIM((SALT31.StrType)le.provnote_2),TRIM((SALT31.StrType)le.provnote_3),TRIM((SALT31.StrType)le.action_taken_ind),TRIM((SALT31.StrType)le.viol_type),TRIM((SALT31.StrType)le.viol_cd),TRIM((SALT31.StrType)le.viol_desc),TRIM((SALT31.StrType)le.viol_dte),TRIM((SALT31.StrType)le.viol_case_nbr),TRIM((SALT31.StrType)le.viol_eff_dte),TRIM((SALT31.StrType)le.action_final_nbr),TRIM((SALT31.StrType)le.action_status),TRIM((SALT31.StrType)le.action_status_dte),TRIM((SALT31.StrType)le.displinary_action),TRIM((SALT31.StrType)le.action_file_name),TRIM((SALT31.StrType)le.occupation),TRIM((SALT31.StrType)le.practice_hrs),TRIM((SALT31.StrType)le.practice_type),TRIM((SALT31.StrType)le.misc_other_id),TRIM((SALT31.StrType)le.misc_other_type),TRIM((SALT31.StrType)le.cont_education_ernd),TRIM((SALT31.StrType)le.cont_education_req),TRIM((SALT31.StrType)le.cont_education_term),TRIM((SALT31.StrType)le.schl_attend_1),TRIM((SALT31.StrType)le.schl_attend_dte_1),TRIM((SALT31.StrType)le.schl_curriculum_1),TRIM((SALT31.StrType)le.schl_degree_1),TRIM((SALT31.StrType)le.schl_attend_2),TRIM((SALT31.StrType)le.schl_attend_dte_2),TRIM((SALT31.StrType)le.schl_curriculum_2),TRIM((SALT31.StrType)le.schl_degree_2),TRIM((SALT31.StrType)le.schl_attend_3),TRIM((SALT31.StrType)le.schl_attend_dte_3),TRIM((SALT31.StrType)le.schl_curriculum_3),TRIM((SALT31.StrType)le.schl_degree_3),TRIM((SALT31.StrType)le.addl_license_spec),TRIM((SALT31.StrType)le.place_birth_cd),TRIM((SALT31.StrType)le.place_birth_desc),TRIM((SALT31.StrType)le.race_cd),TRIM((SALT31.StrType)le.std_race_cd),TRIM((SALT31.StrType)le.race_desc),TRIM((SALT31.StrType)le.status_effect_dte),TRIM((SALT31.StrType)le.status_renew_desc),TRIM((SALT31.StrType)le.agency_status),TRIM((SALT31.StrType)le.prev_primary_key),TRIM((SALT31.StrType)le.prev_mltreckey),TRIM((SALT31.StrType)le.prev_cmc_slpk),TRIM((SALT31.StrType)le.prev_pcmc_slpk),TRIM((SALT31.StrType)le.license_id),TRIM((SALT31.StrType)le.nmls_id),TRIM((SALT31.StrType)le.foreign_nmls_id),TRIM((SALT31.StrType)le.location_type),TRIM((SALT31.StrType)le.off_license_nbr_type),TRIM((SALT31.StrType)le.brkr_license_nbr),TRIM((SALT31.StrType)le.brkr_license_nbr_type),TRIM((SALT31.StrType)le.agency_id),TRIM((SALT31.StrType)le.site_location),TRIM((SALT31.StrType)le.business_type),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.start_dte),TRIM((SALT31.StrType)le.is_authorized_license),TRIM((SALT31.StrType)le.is_authorized_conduct),TRIM((SALT31.StrType)le.federal_regulator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),196*196,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'primary_key'}
      ,{2,'create_dte'}
      ,{3,'last_upd_dte'}
      ,{4,'stamp_dte'}
      ,{5,'date_first_seen'}
      ,{6,'date_last_seen'}
      ,{7,'date_vendor_first_reported'}
      ,{8,'date_vendor_last_reported'}
      ,{9,'process_date'}
      ,{10,'gen_nbr'}
      ,{11,'std_prof_cd'}
      ,{12,'std_prof_desc'}
      ,{13,'std_source_upd'}
      ,{14,'std_source_desc'}
      ,{15,'type_cd'}
      ,{16,'name_org_prefx'}
      ,{17,'name_org'}
      ,{18,'name_org_sufx'}
      ,{19,'store_nbr'}
      ,{20,'name_dba_prefx'}
      ,{21,'name_dba'}
      ,{22,'name_dba_sufx'}
      ,{23,'store_nbr_dba'}
      ,{24,'dba_flag'}
      ,{25,'name_office'}
      ,{26,'office_parse'}
      ,{27,'name_prefx'}
      ,{28,'name_first'}
      ,{29,'name_mid'}
      ,{30,'name_last'}
      ,{31,'name_sufx'}
      ,{32,'name_nick'}
      ,{33,'birth_dte'}
      ,{34,'gender'}
      ,{35,'prov_stat'}
      ,{36,'credential'}
      ,{37,'license_nbr'}
      ,{38,'off_license_nbr'}
      ,{39,'prev_license_nbr'}
      ,{40,'prev_license_type'}
      ,{41,'license_state'}
      ,{42,'raw_license_type'}
      ,{43,'std_license_type'}
      ,{44,'std_license_desc'}
      ,{45,'raw_license_status'}
      ,{46,'std_license_status'}
      ,{47,'std_status_desc'}
      ,{48,'curr_issue_dte'}
      ,{49,'orig_issue_dte'}
      ,{50,'expire_dte'}
      ,{51,'renewal_dte'}
      ,{52,'active_flag'}
      ,{53,'ssn_taxid_1'}
      ,{54,'tax_type_1'}
      ,{55,'ssn_taxid_2'}
      ,{56,'tax_type_2'}
      ,{57,'fed_rssd'}
      ,{58,'addr_bus_ind'}
      ,{59,'name_format'}
      ,{60,'name_org_orig'}
      ,{61,'name_dba_orig'}
      ,{62,'name_mari_org'}
      ,{63,'name_mari_dba'}
      ,{64,'phn_mari_1'}
      ,{65,'phn_mari_fax_1'}
      ,{66,'phn_mari_2'}
      ,{67,'phn_mari_fax_2'}
      ,{68,'addr_addr1_1'}
      ,{69,'addr_addr2_1'}
      ,{70,'addr_addr3_1'}
      ,{71,'addr_addr4_1'}
      ,{72,'addr_city_1'}
      ,{73,'addr_state_1'}
      ,{74,'addr_zip5_1'}
      ,{75,'addr_zip4_1'}
      ,{76,'phn_phone_1'}
      ,{77,'phn_fax_1'}
      ,{78,'addr_cnty_1'}
      ,{79,'addr_cntry_1'}
      ,{80,'sud_key_1'}
      ,{81,'ooc_ind_1'}
      ,{82,'addr_mail_ind'}
      ,{83,'addr_addr1_2'}
      ,{84,'addr_addr2_2'}
      ,{85,'addr_addr3_2'}
      ,{86,'addr_addr4_2'}
      ,{87,'addr_city_2'}
      ,{88,'addr_state_2'}
      ,{89,'addr_zip5_2'}
      ,{90,'addr_zip4_2'}
      ,{91,'addr_cnty_2'}
      ,{92,'addr_cntry_2'}
      ,{93,'phn_phone_2'}
      ,{94,'phn_fax_2'}
      ,{95,'sud_key_2'}
      ,{96,'ooc_ind_2'}
      ,{97,'license_nbr_contact'}
      ,{98,'name_contact_prefx'}
      ,{99,'name_contact_first'}
      ,{100,'name_contact_mid'}
      ,{101,'name_contact_last'}
      ,{102,'name_contact_sufx'}
      ,{103,'name_contact_nick'}
      ,{104,'name_contact_ttl'}
      ,{105,'phn_contact'}
      ,{106,'phn_contact_ext'}
      ,{107,'phn_contact_fax'}
      ,{108,'email'}
      ,{109,'url'}
      ,{110,'bk_class'}
      ,{111,'bk_class_desc'}
      ,{112,'charter'}
      ,{113,'inst_beg_dte'}
      ,{114,'origin_cd'}
      ,{115,'origin_cd_desc'}
      ,{116,'disp_type_cd'}
      ,{117,'disp_type_desc'}
      ,{118,'reg_agent'}
      ,{119,'regulator'}
      ,{120,'hqtr_city'}
      ,{121,'hqtr_name'}
      ,{122,'domestic_off_nbr'}
      ,{123,'foreign_off_nbr'}
      ,{124,'hcr_rssd'}
      ,{125,'hcr_location'}
      ,{126,'affil_type_cd'}
      ,{127,'genlink'}
      ,{128,'research_ind'}
      ,{129,'docket_id'}
      ,{130,'mltreckey'}
      ,{131,'cmc_slpk'}
      ,{132,'pcmc_slpk'}
      ,{133,'affil_key'}
      ,{134,'provnote_1'}
      ,{135,'provnote_2'}
      ,{136,'provnote_3'}
      ,{137,'action_taken_ind'}
      ,{138,'viol_type'}
      ,{139,'viol_cd'}
      ,{140,'viol_desc'}
      ,{141,'viol_dte'}
      ,{142,'viol_case_nbr'}
      ,{143,'viol_eff_dte'}
      ,{144,'action_final_nbr'}
      ,{145,'action_status'}
      ,{146,'action_status_dte'}
      ,{147,'displinary_action'}
      ,{148,'action_file_name'}
      ,{149,'occupation'}
      ,{150,'practice_hrs'}
      ,{151,'practice_type'}
      ,{152,'misc_other_id'}
      ,{153,'misc_other_type'}
      ,{154,'cont_education_ernd'}
      ,{155,'cont_education_req'}
      ,{156,'cont_education_term'}
      ,{157,'schl_attend_1'}
      ,{158,'schl_attend_dte_1'}
      ,{159,'schl_curriculum_1'}
      ,{160,'schl_degree_1'}
      ,{161,'schl_attend_2'}
      ,{162,'schl_attend_dte_2'}
      ,{163,'schl_curriculum_2'}
      ,{164,'schl_degree_2'}
      ,{165,'schl_attend_3'}
      ,{166,'schl_attend_dte_3'}
      ,{167,'schl_curriculum_3'}
      ,{168,'schl_degree_3'}
      ,{169,'addl_license_spec'}
      ,{170,'place_birth_cd'}
      ,{171,'place_birth_desc'}
      ,{172,'race_cd'}
      ,{173,'std_race_cd'}
      ,{174,'race_desc'}
      ,{175,'status_effect_dte'}
      ,{176,'status_renew_desc'}
      ,{177,'agency_status'}
      ,{178,'prev_primary_key'}
      ,{179,'prev_mltreckey'}
      ,{180,'prev_cmc_slpk'}
      ,{181,'prev_pcmc_slpk'}
      ,{182,'license_id'}
      ,{183,'nmls_id'}
      ,{184,'foreign_nmls_id'}
      ,{185,'location_type'}
      ,{186,'off_license_nbr_type'}
      ,{187,'brkr_license_nbr'}
      ,{188,'brkr_license_nbr_type'}
      ,{189,'agency_id'}
      ,{190,'site_location'}
      ,{191,'business_type'}
      ,{192,'name_type'}
      ,{193,'start_dte'}
      ,{194,'is_authorized_license'}
      ,{195,'is_authorized_conduct'}
      ,{196,'federal_regulator'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.std_source_upd) std_source_upd; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_primary_key((SALT31.StrType)le.primary_key),
    Fields.InValid_create_dte((SALT31.StrType)le.create_dte),
    Fields.InValid_last_upd_dte((SALT31.StrType)le.last_upd_dte),
    Fields.InValid_stamp_dte((SALT31.StrType)le.stamp_dte),
    Fields.InValid_date_first_seen((SALT31.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT31.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT31.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT31.StrType)le.date_vendor_last_reported),
    Fields.InValid_process_date((SALT31.StrType)le.process_date),
    Fields.InValid_gen_nbr((SALT31.StrType)le.gen_nbr),
    Fields.InValid_std_prof_cd((SALT31.StrType)le.std_prof_cd),
    Fields.InValid_std_prof_desc((SALT31.StrType)le.std_prof_desc),
    Fields.InValid_std_source_upd((SALT31.StrType)le.std_source_upd),
    Fields.InValid_std_source_desc((SALT31.StrType)le.std_source_desc),
    Fields.InValid_type_cd((SALT31.StrType)le.type_cd),
    Fields.InValid_name_org_prefx((SALT31.StrType)le.name_org_prefx),
    Fields.InValid_name_org((SALT31.StrType)le.name_org),
    Fields.InValid_name_org_sufx((SALT31.StrType)le.name_org_sufx),
    Fields.InValid_store_nbr((SALT31.StrType)le.store_nbr),
    Fields.InValid_name_dba_prefx((SALT31.StrType)le.name_dba_prefx),
    Fields.InValid_name_dba((SALT31.StrType)le.name_dba),
    Fields.InValid_name_dba_sufx((SALT31.StrType)le.name_dba_sufx),
    Fields.InValid_store_nbr_dba((SALT31.StrType)le.store_nbr_dba),
    Fields.InValid_dba_flag((SALT31.StrType)le.dba_flag),
    Fields.InValid_name_office((SALT31.StrType)le.name_office),
    Fields.InValid_office_parse((SALT31.StrType)le.office_parse),
    Fields.InValid_name_prefx((SALT31.StrType)le.name_prefx),
    Fields.InValid_name_first((SALT31.StrType)le.name_first),
    Fields.InValid_name_mid((SALT31.StrType)le.name_mid),
    Fields.InValid_name_last((SALT31.StrType)le.name_last),
    Fields.InValid_name_sufx((SALT31.StrType)le.name_sufx),
    Fields.InValid_name_nick((SALT31.StrType)le.name_nick),
    Fields.InValid_birth_dte((SALT31.StrType)le.birth_dte),
    Fields.InValid_gender((SALT31.StrType)le.gender),
    Fields.InValid_prov_stat((SALT31.StrType)le.prov_stat),
    Fields.InValid_credential((SALT31.StrType)le.credential),
    Fields.InValid_license_nbr((SALT31.StrType)le.license_nbr),
    Fields.InValid_off_license_nbr((SALT31.StrType)le.off_license_nbr),
    Fields.InValid_prev_license_nbr((SALT31.StrType)le.prev_license_nbr),
    Fields.InValid_prev_license_type((SALT31.StrType)le.prev_license_type),
    Fields.InValid_license_state((SALT31.StrType)le.license_state),
    Fields.InValid_raw_license_type((SALT31.StrType)le.raw_license_type),
    Fields.InValid_std_license_type((SALT31.StrType)le.std_license_type),
    Fields.InValid_std_license_desc((SALT31.StrType)le.std_license_desc),
    Fields.InValid_raw_license_status((SALT31.StrType)le.raw_license_status),
    Fields.InValid_std_license_status((SALT31.StrType)le.std_license_status),
    Fields.InValid_std_status_desc((SALT31.StrType)le.std_status_desc),
    Fields.InValid_curr_issue_dte((SALT31.StrType)le.curr_issue_dte),
    Fields.InValid_orig_issue_dte((SALT31.StrType)le.orig_issue_dte),
    Fields.InValid_expire_dte((SALT31.StrType)le.expire_dte),
    Fields.InValid_renewal_dte((SALT31.StrType)le.renewal_dte),
    Fields.InValid_active_flag((SALT31.StrType)le.active_flag),
    Fields.InValid_ssn_taxid_1((SALT31.StrType)le.ssn_taxid_1),
    Fields.InValid_tax_type_1((SALT31.StrType)le.tax_type_1),
    Fields.InValid_ssn_taxid_2((SALT31.StrType)le.ssn_taxid_2),
    Fields.InValid_tax_type_2((SALT31.StrType)le.tax_type_2),
    Fields.InValid_fed_rssd((SALT31.StrType)le.fed_rssd),
    Fields.InValid_addr_bus_ind((SALT31.StrType)le.addr_bus_ind),
    Fields.InValid_name_format((SALT31.StrType)le.name_format),
    Fields.InValid_name_org_orig((SALT31.StrType)le.name_org_orig),
    Fields.InValid_name_dba_orig((SALT31.StrType)le.name_dba_orig),
    Fields.InValid_name_mari_org((SALT31.StrType)le.name_mari_org),
    Fields.InValid_name_mari_dba((SALT31.StrType)le.name_mari_dba),
    Fields.InValid_phn_mari_1((SALT31.StrType)le.phn_mari_1),
    Fields.InValid_phn_mari_fax_1((SALT31.StrType)le.phn_mari_fax_1),
    Fields.InValid_phn_mari_2((SALT31.StrType)le.phn_mari_2),
    Fields.InValid_phn_mari_fax_2((SALT31.StrType)le.phn_mari_fax_2),
    Fields.InValid_addr_addr1_1((SALT31.StrType)le.addr_addr1_1),
    Fields.InValid_addr_addr2_1((SALT31.StrType)le.addr_addr2_1),
    Fields.InValid_addr_addr3_1((SALT31.StrType)le.addr_addr3_1),
    Fields.InValid_addr_addr4_1((SALT31.StrType)le.addr_addr4_1),
    Fields.InValid_addr_city_1((SALT31.StrType)le.addr_city_1),
    Fields.InValid_addr_state_1((SALT31.StrType)le.addr_state_1),
    Fields.InValid_addr_zip5_1((SALT31.StrType)le.addr_zip5_1),
    Fields.InValid_addr_zip4_1((SALT31.StrType)le.addr_zip4_1),
    Fields.InValid_phn_phone_1((SALT31.StrType)le.phn_phone_1),
    Fields.InValid_phn_fax_1((SALT31.StrType)le.phn_fax_1),
    Fields.InValid_addr_cnty_1((SALT31.StrType)le.addr_cnty_1),
    Fields.InValid_addr_cntry_1((SALT31.StrType)le.addr_cntry_1),
    Fields.InValid_sud_key_1((SALT31.StrType)le.sud_key_1),
    Fields.InValid_ooc_ind_1((SALT31.StrType)le.ooc_ind_1),
    Fields.InValid_addr_mail_ind((SALT31.StrType)le.addr_mail_ind),
    Fields.InValid_addr_addr1_2((SALT31.StrType)le.addr_addr1_2),
    Fields.InValid_addr_addr2_2((SALT31.StrType)le.addr_addr2_2),
    Fields.InValid_addr_addr3_2((SALT31.StrType)le.addr_addr3_2),
    Fields.InValid_addr_addr4_2((SALT31.StrType)le.addr_addr4_2),
    Fields.InValid_addr_city_2((SALT31.StrType)le.addr_city_2),
    Fields.InValid_addr_state_2((SALT31.StrType)le.addr_state_2),
    Fields.InValid_addr_zip5_2((SALT31.StrType)le.addr_zip5_2),
    Fields.InValid_addr_zip4_2((SALT31.StrType)le.addr_zip4_2),
    Fields.InValid_addr_cnty_2((SALT31.StrType)le.addr_cnty_2),
    Fields.InValid_addr_cntry_2((SALT31.StrType)le.addr_cntry_2),
    Fields.InValid_phn_phone_2((SALT31.StrType)le.phn_phone_2),
    Fields.InValid_phn_fax_2((SALT31.StrType)le.phn_fax_2),
    Fields.InValid_sud_key_2((SALT31.StrType)le.sud_key_2),
    Fields.InValid_ooc_ind_2((SALT31.StrType)le.ooc_ind_2),
    Fields.InValid_license_nbr_contact((SALT31.StrType)le.license_nbr_contact),
    Fields.InValid_name_contact_prefx((SALT31.StrType)le.name_contact_prefx),
    Fields.InValid_name_contact_first((SALT31.StrType)le.name_contact_first),
    Fields.InValid_name_contact_mid((SALT31.StrType)le.name_contact_mid),
    Fields.InValid_name_contact_last((SALT31.StrType)le.name_contact_last),
    Fields.InValid_name_contact_sufx((SALT31.StrType)le.name_contact_sufx),
    Fields.InValid_name_contact_nick((SALT31.StrType)le.name_contact_nick),
    Fields.InValid_name_contact_ttl((SALT31.StrType)le.name_contact_ttl),
    Fields.InValid_phn_contact((SALT31.StrType)le.phn_contact),
    Fields.InValid_phn_contact_ext((SALT31.StrType)le.phn_contact_ext),
    Fields.InValid_phn_contact_fax((SALT31.StrType)le.phn_contact_fax),
    Fields.InValid_email((SALT31.StrType)le.email),
    Fields.InValid_url((SALT31.StrType)le.url),
    Fields.InValid_bk_class((SALT31.StrType)le.bk_class),
    Fields.InValid_bk_class_desc((SALT31.StrType)le.bk_class_desc),
    Fields.InValid_charter((SALT31.StrType)le.charter),
    Fields.InValid_inst_beg_dte((SALT31.StrType)le.inst_beg_dte),
    Fields.InValid_origin_cd((SALT31.StrType)le.origin_cd),
    Fields.InValid_origin_cd_desc((SALT31.StrType)le.origin_cd_desc),
    Fields.InValid_disp_type_cd((SALT31.StrType)le.disp_type_cd),
    Fields.InValid_disp_type_desc((SALT31.StrType)le.disp_type_desc),
    Fields.InValid_reg_agent((SALT31.StrType)le.reg_agent),
    Fields.InValid_regulator((SALT31.StrType)le.regulator),
    Fields.InValid_hqtr_city((SALT31.StrType)le.hqtr_city),
    Fields.InValid_hqtr_name((SALT31.StrType)le.hqtr_name),
    Fields.InValid_domestic_off_nbr((SALT31.StrType)le.domestic_off_nbr),
    Fields.InValid_foreign_off_nbr((SALT31.StrType)le.foreign_off_nbr),
    Fields.InValid_hcr_rssd((SALT31.StrType)le.hcr_rssd),
    Fields.InValid_hcr_location((SALT31.StrType)le.hcr_location),
    Fields.InValid_affil_type_cd((SALT31.StrType)le.affil_type_cd),
    Fields.InValid_genlink((SALT31.StrType)le.genlink),
    Fields.InValid_research_ind((SALT31.StrType)le.research_ind),
    Fields.InValid_docket_id((SALT31.StrType)le.docket_id),
    Fields.InValid_mltreckey((SALT31.StrType)le.mltreckey),
    Fields.InValid_cmc_slpk((SALT31.StrType)le.cmc_slpk),
    Fields.InValid_pcmc_slpk((SALT31.StrType)le.pcmc_slpk),
    Fields.InValid_affil_key((SALT31.StrType)le.affil_key),
    Fields.InValid_provnote_1((SALT31.StrType)le.provnote_1),
    Fields.InValid_provnote_2((SALT31.StrType)le.provnote_2),
    Fields.InValid_provnote_3((SALT31.StrType)le.provnote_3),
    Fields.InValid_action_taken_ind((SALT31.StrType)le.action_taken_ind),
    Fields.InValid_viol_type((SALT31.StrType)le.viol_type),
    Fields.InValid_viol_cd((SALT31.StrType)le.viol_cd),
    Fields.InValid_viol_desc((SALT31.StrType)le.viol_desc),
    Fields.InValid_viol_dte((SALT31.StrType)le.viol_dte),
    Fields.InValid_viol_case_nbr((SALT31.StrType)le.viol_case_nbr),
    Fields.InValid_viol_eff_dte((SALT31.StrType)le.viol_eff_dte),
    Fields.InValid_action_final_nbr((SALT31.StrType)le.action_final_nbr),
    Fields.InValid_action_status((SALT31.StrType)le.action_status),
    Fields.InValid_action_status_dte((SALT31.StrType)le.action_status_dte),
    Fields.InValid_displinary_action((SALT31.StrType)le.displinary_action),
    Fields.InValid_action_file_name((SALT31.StrType)le.action_file_name),
    Fields.InValid_occupation((SALT31.StrType)le.occupation),
    Fields.InValid_practice_hrs((SALT31.StrType)le.practice_hrs),
    Fields.InValid_practice_type((SALT31.StrType)le.practice_type),
    Fields.InValid_misc_other_id((SALT31.StrType)le.misc_other_id),
    Fields.InValid_misc_other_type((SALT31.StrType)le.misc_other_type),
    Fields.InValid_cont_education_ernd((SALT31.StrType)le.cont_education_ernd),
    Fields.InValid_cont_education_req((SALT31.StrType)le.cont_education_req),
    Fields.InValid_cont_education_term((SALT31.StrType)le.cont_education_term),
    Fields.InValid_schl_attend_1((SALT31.StrType)le.schl_attend_1),
    Fields.InValid_schl_attend_dte_1((SALT31.StrType)le.schl_attend_dte_1),
    Fields.InValid_schl_curriculum_1((SALT31.StrType)le.schl_curriculum_1),
    Fields.InValid_schl_degree_1((SALT31.StrType)le.schl_degree_1),
    Fields.InValid_schl_attend_2((SALT31.StrType)le.schl_attend_2),
    Fields.InValid_schl_attend_dte_2((SALT31.StrType)le.schl_attend_dte_2),
    Fields.InValid_schl_curriculum_2((SALT31.StrType)le.schl_curriculum_2),
    Fields.InValid_schl_degree_2((SALT31.StrType)le.schl_degree_2),
    Fields.InValid_schl_attend_3((SALT31.StrType)le.schl_attend_3),
    Fields.InValid_schl_attend_dte_3((SALT31.StrType)le.schl_attend_dte_3),
    Fields.InValid_schl_curriculum_3((SALT31.StrType)le.schl_curriculum_3),
    Fields.InValid_schl_degree_3((SALT31.StrType)le.schl_degree_3),
    Fields.InValid_addl_license_spec((SALT31.StrType)le.addl_license_spec),
    Fields.InValid_place_birth_cd((SALT31.StrType)le.place_birth_cd),
    Fields.InValid_place_birth_desc((SALT31.StrType)le.place_birth_desc),
    Fields.InValid_race_cd((SALT31.StrType)le.race_cd),
    Fields.InValid_std_race_cd((SALT31.StrType)le.std_race_cd),
    Fields.InValid_race_desc((SALT31.StrType)le.race_desc),
    Fields.InValid_status_effect_dte((SALT31.StrType)le.status_effect_dte),
    Fields.InValid_status_renew_desc((SALT31.StrType)le.status_renew_desc),
    Fields.InValid_agency_status((SALT31.StrType)le.agency_status),
    Fields.InValid_prev_primary_key((SALT31.StrType)le.prev_primary_key),
    Fields.InValid_prev_mltreckey((SALT31.StrType)le.prev_mltreckey),
    Fields.InValid_prev_cmc_slpk((SALT31.StrType)le.prev_cmc_slpk),
    Fields.InValid_prev_pcmc_slpk((SALT31.StrType)le.prev_pcmc_slpk),
    Fields.InValid_license_id((SALT31.StrType)le.license_id),
    Fields.InValid_nmls_id((SALT31.StrType)le.nmls_id),
    Fields.InValid_foreign_nmls_id((SALT31.StrType)le.foreign_nmls_id),
    Fields.InValid_location_type((SALT31.StrType)le.location_type),
    Fields.InValid_off_license_nbr_type((SALT31.StrType)le.off_license_nbr_type),
    Fields.InValid_brkr_license_nbr((SALT31.StrType)le.brkr_license_nbr),
    Fields.InValid_brkr_license_nbr_type((SALT31.StrType)le.brkr_license_nbr_type),
    Fields.InValid_agency_id((SALT31.StrType)le.agency_id),
    Fields.InValid_site_location((SALT31.StrType)le.site_location),
    Fields.InValid_business_type((SALT31.StrType)le.business_type),
    Fields.InValid_name_type((SALT31.StrType)le.name_type),
    Fields.InValid_start_dte((SALT31.StrType)le.start_dte),
    Fields.InValid_is_authorized_license((SALT31.StrType)le.is_authorized_license),
    Fields.InValid_is_authorized_conduct((SALT31.StrType)le.is_authorized_conduct),
    Fields.InValid_federal_regulator((SALT31.StrType)le.federal_regulator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.std_source_upd := le.std_source_upd;
END;
Errors := NORMALIZE(h,196,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.std_source_upd;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,std_source_upd,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.std_source_upd;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_primary_key','invalid_create_dte','invalid_last_upd_dte','invalid_stamp_dte','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_gen_nbr','Unknown','invalid_std_prof_desc','invalid_std_source_upd','invalid_std_source_desc','invalid_type_cd','invalid_name_org_prefx','invalid_name_org','invalid_name_org_sufx','invalid_store_nbr','invalid_name_dba_prefx','invalid_name_dba','invalid_name_dba_sufx','invalid_store_nbr_dba','invalid_dba_flag','invalid_name_office','invalid_office_parse','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_date','invalid_gender','invalid_prov_stat','invalid_credential','invalid_license_nbr','invalid_license_nbr','invalid_prev_license_nbr','invalid_prev_license_type','invalid_license_state','invalid_raw_license_type','Unknown','Unknown','invalid_raw_license_status','Unknown','invalid_std_status_desc','invalid_date','invalid_date','invalid_date','invalid_renewal_dte','invalid_active_flag','invalid_ssn_taxid_1','invalid_tax_type_1','invalid_ssn_taxid_2','invalid_tax_type_2','invalid_fed_rssd','invalid_addr_bus_ind','invalid_name_format','invalid_name_org_orig','invalid_name_dba_orig','invalid_name_mari_org','invalid_name_mari_dba','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_phone_number','invalid_phone_number','invalid_county','invalid_country','invalid_sud_key','invalid_ooc_ind','invalid_addr_mail_ind','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_county','invalid_country','invalid_phone_number','invalid_phone_number','invalid_sud_key','invalid_ooc_ind','invalid_license_nbr_contact','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_email','invalid_url','invalid_bk_class','invalid_bk_class_desc','invalid_charter','invalid_date','invalid_origin_cd','invalid_origin_cd_desc','invalid_disp_type_cd','invalid_disp_type_desc','invalid_reg_agent','invalid_regulator','invalid_city','invalid_hqtr_name','invalid_domestic_off_nbr','invalid_foreign_off_nbr','invalid_hcr_rssd','invalid_state','invalid_affil_type_cd','invalid_genlink','invalid_research_ind','invalid_docket_id','invalid_mltreckey','invalid_cmc_slpk','invalid_pcmc_slpk','invalid_affil_key','Unknown','Unknown','Unknown','invalid_blank','invalid_blank','invalid_blank','invalid_viol_desc','invalid_date','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','Unknown','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_misc_other_id','invalid_misc_other_type','invalid_cont_education_ernd','invalid_cont_education_req','invalid_cont_education_term','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_addl_license_spec','invalid_blank','invalid_blank','invalid_race_cd','invalid_std_race_cd','invalid_blank','invalid_date','invalid_blank','invalid_agency_status','invalid_prev_primary_key','invalid_prev_mltreckey','invalid_prev_cmc_slpk','invalid_prev_pcmc_slpk','invalid_license_id','invalid_nmls_id','invalid_foreign_nmls_id','invalid_location_type','invalid_off_license_nbr_type','invalid_brkr_license_nbr','invalid_brkr_license_nbr_type','invalid_agency_id','invalid_address','invalid_business_type','Unknown','invalid_date','invalid_is_authorized','invalid_is_authorized','invalid_federal_regulator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_primary_key(TotalErrors.ErrorNum),Fields.InValidMessage_create_dte(TotalErrors.ErrorNum),Fields.InValidMessage_last_upd_dte(TotalErrors.ErrorNum),Fields.InValidMessage_stamp_dte(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_gen_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_std_prof_cd(TotalErrors.ErrorNum),Fields.InValidMessage_std_prof_desc(TotalErrors.ErrorNum),Fields.InValidMessage_std_source_upd(TotalErrors.ErrorNum),Fields.InValidMessage_std_source_desc(TotalErrors.ErrorNum),Fields.InValidMessage_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_name_org_prefx(TotalErrors.ErrorNum),Fields.InValidMessage_name_org(TotalErrors.ErrorNum),Fields.InValidMessage_name_org_sufx(TotalErrors.ErrorNum),Fields.InValidMessage_store_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_name_dba_prefx(TotalErrors.ErrorNum),Fields.InValidMessage_name_dba(TotalErrors.ErrorNum),Fields.InValidMessage_name_dba_sufx(TotalErrors.ErrorNum),Fields.InValidMessage_store_nbr_dba(TotalErrors.ErrorNum),Fields.InValidMessage_dba_flag(TotalErrors.ErrorNum),Fields.InValidMessage_name_office(TotalErrors.ErrorNum),Fields.InValidMessage_office_parse(TotalErrors.ErrorNum),Fields.InValidMessage_name_prefx(TotalErrors.ErrorNum),Fields.InValidMessage_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_name_mid(TotalErrors.ErrorNum),Fields.InValidMessage_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_name_sufx(TotalErrors.ErrorNum),Fields.InValidMessage_name_nick(TotalErrors.ErrorNum),Fields.InValidMessage_birth_dte(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_prov_stat(TotalErrors.ErrorNum),Fields.InValidMessage_credential(TotalErrors.ErrorNum),Fields.InValidMessage_license_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_off_license_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_prev_license_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_prev_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_license_state(TotalErrors.ErrorNum),Fields.InValidMessage_raw_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_std_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_std_license_desc(TotalErrors.ErrorNum),Fields.InValidMessage_raw_license_status(TotalErrors.ErrorNum),Fields.InValidMessage_std_license_status(TotalErrors.ErrorNum),Fields.InValidMessage_std_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_curr_issue_dte(TotalErrors.ErrorNum),Fields.InValidMessage_orig_issue_dte(TotalErrors.ErrorNum),Fields.InValidMessage_expire_dte(TotalErrors.ErrorNum),Fields.InValidMessage_renewal_dte(TotalErrors.ErrorNum),Fields.InValidMessage_active_flag(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_taxid_1(TotalErrors.ErrorNum),Fields.InValidMessage_tax_type_1(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_taxid_2(TotalErrors.ErrorNum),Fields.InValidMessage_tax_type_2(TotalErrors.ErrorNum),Fields.InValidMessage_fed_rssd(TotalErrors.ErrorNum),Fields.InValidMessage_addr_bus_ind(TotalErrors.ErrorNum),Fields.InValidMessage_name_format(TotalErrors.ErrorNum),Fields.InValidMessage_name_org_orig(TotalErrors.ErrorNum),Fields.InValidMessage_name_dba_orig(TotalErrors.ErrorNum),Fields.InValidMessage_name_mari_org(TotalErrors.ErrorNum),Fields.InValidMessage_name_mari_dba(TotalErrors.ErrorNum),Fields.InValidMessage_phn_mari_1(TotalErrors.ErrorNum),Fields.InValidMessage_phn_mari_fax_1(TotalErrors.ErrorNum),Fields.InValidMessage_phn_mari_2(TotalErrors.ErrorNum),Fields.InValidMessage_phn_mari_fax_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr1_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr2_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr3_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr4_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_city_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_state_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip5_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip4_1(TotalErrors.ErrorNum),Fields.InValidMessage_phn_phone_1(TotalErrors.ErrorNum),Fields.InValidMessage_phn_fax_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_cnty_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_cntry_1(TotalErrors.ErrorNum),Fields.InValidMessage_sud_key_1(TotalErrors.ErrorNum),Fields.InValidMessage_ooc_ind_1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_mail_ind(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr1_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr2_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr3_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_addr4_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_city_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_state_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip5_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip4_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_cnty_2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_cntry_2(TotalErrors.ErrorNum),Fields.InValidMessage_phn_phone_2(TotalErrors.ErrorNum),Fields.InValidMessage_phn_fax_2(TotalErrors.ErrorNum),Fields.InValidMessage_sud_key_2(TotalErrors.ErrorNum),Fields.InValidMessage_ooc_ind_2(TotalErrors.ErrorNum),Fields.InValidMessage_license_nbr_contact(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_prefx(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_first(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_mid(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_last(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_sufx(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_nick(TotalErrors.ErrorNum),Fields.InValidMessage_name_contact_ttl(TotalErrors.ErrorNum),Fields.InValidMessage_phn_contact(TotalErrors.ErrorNum),Fields.InValidMessage_phn_contact_ext(TotalErrors.ErrorNum),Fields.InValidMessage_phn_contact_fax(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_bk_class(TotalErrors.ErrorNum),Fields.InValidMessage_bk_class_desc(TotalErrors.ErrorNum),Fields.InValidMessage_charter(TotalErrors.ErrorNum),Fields.InValidMessage_inst_beg_dte(TotalErrors.ErrorNum),Fields.InValidMessage_origin_cd(TotalErrors.ErrorNum),Fields.InValidMessage_origin_cd_desc(TotalErrors.ErrorNum),Fields.InValidMessage_disp_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_disp_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_reg_agent(TotalErrors.ErrorNum),Fields.InValidMessage_regulator(TotalErrors.ErrorNum),Fields.InValidMessage_hqtr_city(TotalErrors.ErrorNum),Fields.InValidMessage_hqtr_name(TotalErrors.ErrorNum),Fields.InValidMessage_domestic_off_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_off_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_hcr_rssd(TotalErrors.ErrorNum),Fields.InValidMessage_hcr_location(TotalErrors.ErrorNum),Fields.InValidMessage_affil_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_genlink(TotalErrors.ErrorNum),Fields.InValidMessage_research_ind(TotalErrors.ErrorNum),Fields.InValidMessage_docket_id(TotalErrors.ErrorNum),Fields.InValidMessage_mltreckey(TotalErrors.ErrorNum),Fields.InValidMessage_cmc_slpk(TotalErrors.ErrorNum),Fields.InValidMessage_pcmc_slpk(TotalErrors.ErrorNum),Fields.InValidMessage_affil_key(TotalErrors.ErrorNum),Fields.InValidMessage_provnote_1(TotalErrors.ErrorNum),Fields.InValidMessage_provnote_2(TotalErrors.ErrorNum),Fields.InValidMessage_provnote_3(TotalErrors.ErrorNum),Fields.InValidMessage_action_taken_ind(TotalErrors.ErrorNum),Fields.InValidMessage_viol_type(TotalErrors.ErrorNum),Fields.InValidMessage_viol_cd(TotalErrors.ErrorNum),Fields.InValidMessage_viol_desc(TotalErrors.ErrorNum),Fields.InValidMessage_viol_dte(TotalErrors.ErrorNum),Fields.InValidMessage_viol_case_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_viol_eff_dte(TotalErrors.ErrorNum),Fields.InValidMessage_action_final_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_action_status(TotalErrors.ErrorNum),Fields.InValidMessage_action_status_dte(TotalErrors.ErrorNum),Fields.InValidMessage_displinary_action(TotalErrors.ErrorNum),Fields.InValidMessage_action_file_name(TotalErrors.ErrorNum),Fields.InValidMessage_occupation(TotalErrors.ErrorNum),Fields.InValidMessage_practice_hrs(TotalErrors.ErrorNum),Fields.InValidMessage_practice_type(TotalErrors.ErrorNum),Fields.InValidMessage_misc_other_id(TotalErrors.ErrorNum),Fields.InValidMessage_misc_other_type(TotalErrors.ErrorNum),Fields.InValidMessage_cont_education_ernd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_education_req(TotalErrors.ErrorNum),Fields.InValidMessage_cont_education_term(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_1(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_dte_1(TotalErrors.ErrorNum),Fields.InValidMessage_schl_curriculum_1(TotalErrors.ErrorNum),Fields.InValidMessage_schl_degree_1(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_2(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_dte_2(TotalErrors.ErrorNum),Fields.InValidMessage_schl_curriculum_2(TotalErrors.ErrorNum),Fields.InValidMessage_schl_degree_2(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_3(TotalErrors.ErrorNum),Fields.InValidMessage_schl_attend_dte_3(TotalErrors.ErrorNum),Fields.InValidMessage_schl_curriculum_3(TotalErrors.ErrorNum),Fields.InValidMessage_schl_degree_3(TotalErrors.ErrorNum),Fields.InValidMessage_addl_license_spec(TotalErrors.ErrorNum),Fields.InValidMessage_place_birth_cd(TotalErrors.ErrorNum),Fields.InValidMessage_place_birth_desc(TotalErrors.ErrorNum),Fields.InValidMessage_race_cd(TotalErrors.ErrorNum),Fields.InValidMessage_std_race_cd(TotalErrors.ErrorNum),Fields.InValidMessage_race_desc(TotalErrors.ErrorNum),Fields.InValidMessage_status_effect_dte(TotalErrors.ErrorNum),Fields.InValidMessage_status_renew_desc(TotalErrors.ErrorNum),Fields.InValidMessage_agency_status(TotalErrors.ErrorNum),Fields.InValidMessage_prev_primary_key(TotalErrors.ErrorNum),Fields.InValidMessage_prev_mltreckey(TotalErrors.ErrorNum),Fields.InValidMessage_prev_cmc_slpk(TotalErrors.ErrorNum),Fields.InValidMessage_prev_pcmc_slpk(TotalErrors.ErrorNum),Fields.InValidMessage_license_id(TotalErrors.ErrorNum),Fields.InValidMessage_nmls_id(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_nmls_id(TotalErrors.ErrorNum),Fields.InValidMessage_location_type(TotalErrors.ErrorNum),Fields.InValidMessage_off_license_nbr_type(TotalErrors.ErrorNum),Fields.InValidMessage_brkr_license_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_brkr_license_nbr_type(TotalErrors.ErrorNum),Fields.InValidMessage_agency_id(TotalErrors.ErrorNum),Fields.InValidMessage_site_location(TotalErrors.ErrorNum),Fields.InValidMessage_business_type(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_start_dte(TotalErrors.ErrorNum),Fields.InValidMessage_is_authorized_license(TotalErrors.ErrorNum),Fields.InValidMessage_is_authorized_conduct(TotalErrors.ErrorNum),Fields.InValidMessage_federal_regulator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.std_source_upd=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
