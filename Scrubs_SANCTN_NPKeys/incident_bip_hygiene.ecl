IMPORT ut,SALT33;
EXPORT incident_bip_hygiene(dataset(incident_bip_layout_SANCTN_NPKeys) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.dbcode);    NumberOfRecords := COUNT(GROUP);
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
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_batch_pcnt := AVE(GROUP,IF(h.batch = (TYPEOF(h.batch))'',0,100));
    maxlength_batch := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch)));
    avelength_batch := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch)),h.batch<>(typeof(h.batch))'');
    populated_batch_date_pcnt := AVE(GROUP,IF(h.batch_date = (TYPEOF(h.batch_date))'',0,100));
    maxlength_batch_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch_date)));
    avelength_batch_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch_date)),h.batch_date<>(typeof(h.batch_date))'');
    populated_dbcode_pcnt := AVE(GROUP,IF(h.dbcode = (TYPEOF(h.dbcode))'',0,100));
    maxlength_dbcode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)));
    avelength_dbcode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)),h.dbcode<>(typeof(h.dbcode))'');
    populated_incident_num_pcnt := AVE(GROUP,IF(h.incident_num = (TYPEOF(h.incident_num))'',0,100));
    maxlength_incident_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)));
    avelength_incident_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)),h.incident_num<>(typeof(h.incident_num))'');
    populated_incident_date_pcnt := AVE(GROUP,IF(h.incident_date = (TYPEOF(h.incident_date))'',0,100));
    maxlength_incident_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_date)));
    avelength_incident_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_date)),h.incident_date<>(typeof(h.incident_date))'');
    populated_int_key_pcnt := AVE(GROUP,IF(h.int_key = (TYPEOF(h.int_key))'',0,100));
    maxlength_int_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.int_key)));
    avelength_int_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.int_key)),h.int_key<>(typeof(h.int_key))'');
    populated_srce_cd_pcnt := AVE(GROUP,IF(h.srce_cd = (TYPEOF(h.srce_cd))'',0,100));
    maxlength_srce_cd := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.srce_cd)));
    avelength_srce_cd := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.srce_cd)),h.srce_cd<>(typeof(h.srce_cd))'');
    populated_billing_code_pcnt := AVE(GROUP,IF(h.billing_code = (TYPEOF(h.billing_code))'',0,100));
    maxlength_billing_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.billing_code)));
    avelength_billing_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.billing_code)),h.billing_code<>(typeof(h.billing_code))'');
    populated_case_num_pcnt := AVE(GROUP,IF(h.case_num = (TYPEOF(h.case_num))'',0,100));
    maxlength_case_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_num)));
    avelength_case_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_num)),h.case_num<>(typeof(h.case_num))'');
    populated_jurisdiction_pcnt := AVE(GROUP,IF(h.jurisdiction = (TYPEOF(h.jurisdiction))'',0,100));
    maxlength_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.jurisdiction)));
    avelength_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.jurisdiction)),h.jurisdiction<>(typeof(h.jurisdiction))'');
    populated_agency_pcnt := AVE(GROUP,IF(h.agency = (TYPEOF(h.agency))'',0,100));
    maxlength_agency := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency)));
    avelength_agency := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency)),h.agency<>(typeof(h.agency))'');
    populated_source_doc_pcnt := AVE(GROUP,IF(h.source_doc = (TYPEOF(h.source_doc))'',0,100));
    maxlength_source_doc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_doc)));
    avelength_source_doc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_doc)),h.source_doc<>(typeof(h.source_doc))'');
    populated_source_ref_pcnt := AVE(GROUP,IF(h.source_ref = (TYPEOF(h.source_ref))'',0,100));
    maxlength_source_ref := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_ref)));
    avelength_source_ref := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_ref)),h.source_ref<>(typeof(h.source_ref))'');
    populated_additional_info_pcnt := AVE(GROUP,IF(h.additional_info = (TYPEOF(h.additional_info))'',0,100));
    maxlength_additional_info := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.additional_info)));
    avelength_additional_info := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.additional_info)),h.additional_info<>(typeof(h.additional_info))'');
    populated_modified_date_pcnt := AVE(GROUP,IF(h.modified_date = (TYPEOF(h.modified_date))'',0,100));
    maxlength_modified_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.modified_date)));
    avelength_modified_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.modified_date)),h.modified_date<>(typeof(h.modified_date))'');
    populated_entry_date_pcnt := AVE(GROUP,IF(h.entry_date = (TYPEOF(h.entry_date))'',0,100));
    maxlength_entry_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.entry_date)));
    avelength_entry_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.entry_date)),h.entry_date<>(typeof(h.entry_date))'');
    populated_member_name_pcnt := AVE(GROUP,IF(h.member_name = (TYPEOF(h.member_name))'',0,100));
    maxlength_member_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.member_name)));
    avelength_member_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.member_name)),h.member_name<>(typeof(h.member_name))'');
    populated_submitter_name_pcnt := AVE(GROUP,IF(h.submitter_name = (TYPEOF(h.submitter_name))'',0,100));
    maxlength_submitter_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_name)));
    avelength_submitter_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_name)),h.submitter_name<>(typeof(h.submitter_name))'');
    populated_submitter_nickname_pcnt := AVE(GROUP,IF(h.submitter_nickname = (TYPEOF(h.submitter_nickname))'',0,100));
    maxlength_submitter_nickname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_nickname)));
    avelength_submitter_nickname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_nickname)),h.submitter_nickname<>(typeof(h.submitter_nickname))'');
    populated_submitter_phone_pcnt := AVE(GROUP,IF(h.submitter_phone = (TYPEOF(h.submitter_phone))'',0,100));
    maxlength_submitter_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_phone)));
    avelength_submitter_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_phone)),h.submitter_phone<>(typeof(h.submitter_phone))'');
    populated_submitter_fax_pcnt := AVE(GROUP,IF(h.submitter_fax = (TYPEOF(h.submitter_fax))'',0,100));
    maxlength_submitter_fax := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_fax)));
    avelength_submitter_fax := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_fax)),h.submitter_fax<>(typeof(h.submitter_fax))'');
    populated_submitter_email_pcnt := AVE(GROUP,IF(h.submitter_email = (TYPEOF(h.submitter_email))'',0,100));
    maxlength_submitter_email := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_email)));
    avelength_submitter_email := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.submitter_email)),h.submitter_email<>(typeof(h.submitter_email))'');
    populated_prop_addr_pcnt := AVE(GROUP,IF(h.prop_addr = (TYPEOF(h.prop_addr))'',0,100));
    maxlength_prop_addr := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_addr)));
    avelength_prop_addr := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_addr)),h.prop_addr<>(typeof(h.prop_addr))'');
    populated_prop_city_pcnt := AVE(GROUP,IF(h.prop_city = (TYPEOF(h.prop_city))'',0,100));
    maxlength_prop_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_city)));
    avelength_prop_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_city)),h.prop_city<>(typeof(h.prop_city))'');
    populated_prop_state_pcnt := AVE(GROUP,IF(h.prop_state = (TYPEOF(h.prop_state))'',0,100));
    maxlength_prop_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_state)));
    avelength_prop_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_state)),h.prop_state<>(typeof(h.prop_state))'');
    populated_prop_zip_pcnt := AVE(GROUP,IF(h.prop_zip = (TYPEOF(h.prop_zip))'',0,100));
    maxlength_prop_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_zip)));
    avelength_prop_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prop_zip)),h.prop_zip<>(typeof(h.prop_zip))'');
    populated_aid_pcnt := AVE(GROUP,IF(h.aid = (TYPEOF(h.aid))'',0,100));
    maxlength_aid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.aid)));
    avelength_aid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.aid)),h.aid<>(typeof(h.aid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
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
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_addr_rec_type_pcnt := AVE(GROUP,IF(h.addr_rec_type = (TYPEOF(h.addr_rec_type))'',0,100));
    maxlength_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_rec_type)));
    avelength_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_rec_type)),h.addr_rec_type<>(typeof(h.addr_rec_type))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
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
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,dbcode,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_batch_pcnt *   0.00 / 100 + T.Populated_batch_date_pcnt *   0.00 / 100 + T.Populated_dbcode_pcnt *   0.00 / 100 + T.Populated_incident_num_pcnt *   0.00 / 100 + T.Populated_incident_date_pcnt *   0.00 / 100 + T.Populated_int_key_pcnt *   0.00 / 100 + T.Populated_srce_cd_pcnt *   0.00 / 100 + T.Populated_billing_code_pcnt *   0.00 / 100 + T.Populated_case_num_pcnt *   0.00 / 100 + T.Populated_jurisdiction_pcnt *   0.00 / 100 + T.Populated_agency_pcnt *   0.00 / 100 + T.Populated_source_doc_pcnt *   0.00 / 100 + T.Populated_source_ref_pcnt *   0.00 / 100 + T.Populated_additional_info_pcnt *   0.00 / 100 + T.Populated_modified_date_pcnt *   0.00 / 100 + T.Populated_entry_date_pcnt *   0.00 / 100 + T.Populated_member_name_pcnt *   0.00 / 100 + T.Populated_submitter_name_pcnt *   0.00 / 100 + T.Populated_submitter_nickname_pcnt *   0.00 / 100 + T.Populated_submitter_phone_pcnt *   0.00 / 100 + T.Populated_submitter_fax_pcnt *   0.00 / 100 + T.Populated_submitter_email_pcnt *   0.00 / 100 + T.Populated_prop_addr_pcnt *   0.00 / 100 + T.Populated_prop_city_pcnt *   0.00 / 100 + T.Populated_prop_state_pcnt *   0.00 / 100 + T.Populated_prop_zip_pcnt *   0.00 / 100 + T.Populated_aid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_addr_rec_type_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING dbcode1;
    STRING dbcode2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.dbcode1 := le.Source;
    SELF.dbcode2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_source_rec_id_pcnt*ri.Populated_source_rec_id_pcnt *   0.00 / 10000 + le.Populated_batch_pcnt*ri.Populated_batch_pcnt *   0.00 / 10000 + le.Populated_batch_date_pcnt*ri.Populated_batch_date_pcnt *   0.00 / 10000 + le.Populated_dbcode_pcnt*ri.Populated_dbcode_pcnt *   0.00 / 10000 + le.Populated_incident_num_pcnt*ri.Populated_incident_num_pcnt *   0.00 / 10000 + le.Populated_incident_date_pcnt*ri.Populated_incident_date_pcnt *   0.00 / 10000 + le.Populated_int_key_pcnt*ri.Populated_int_key_pcnt *   0.00 / 10000 + le.Populated_srce_cd_pcnt*ri.Populated_srce_cd_pcnt *   0.00 / 10000 + le.Populated_billing_code_pcnt*ri.Populated_billing_code_pcnt *   0.00 / 10000 + le.Populated_case_num_pcnt*ri.Populated_case_num_pcnt *   0.00 / 10000 + le.Populated_jurisdiction_pcnt*ri.Populated_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_agency_pcnt*ri.Populated_agency_pcnt *   0.00 / 10000 + le.Populated_source_doc_pcnt*ri.Populated_source_doc_pcnt *   0.00 / 10000 + le.Populated_source_ref_pcnt*ri.Populated_source_ref_pcnt *   0.00 / 10000 + le.Populated_additional_info_pcnt*ri.Populated_additional_info_pcnt *   0.00 / 10000 + le.Populated_modified_date_pcnt*ri.Populated_modified_date_pcnt *   0.00 / 10000 + le.Populated_entry_date_pcnt*ri.Populated_entry_date_pcnt *   0.00 / 10000 + le.Populated_member_name_pcnt*ri.Populated_member_name_pcnt *   0.00 / 10000 + le.Populated_submitter_name_pcnt*ri.Populated_submitter_name_pcnt *   0.00 / 10000 + le.Populated_submitter_nickname_pcnt*ri.Populated_submitter_nickname_pcnt *   0.00 / 10000 + le.Populated_submitter_phone_pcnt*ri.Populated_submitter_phone_pcnt *   0.00 / 10000 + le.Populated_submitter_fax_pcnt*ri.Populated_submitter_fax_pcnt *   0.00 / 10000 + le.Populated_submitter_email_pcnt*ri.Populated_submitter_email_pcnt *   0.00 / 10000 + le.Populated_prop_addr_pcnt*ri.Populated_prop_addr_pcnt *   0.00 / 10000 + le.Populated_prop_city_pcnt*ri.Populated_prop_city_pcnt *   0.00 / 10000 + le.Populated_prop_state_pcnt*ri.Populated_prop_state_pcnt *   0.00 / 10000 + le.Populated_prop_zip_pcnt*ri.Populated_prop_zip_pcnt *   0.00 / 10000 + le.Populated_aid_pcnt*ri.Populated_aid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_bdid_score_pcnt*ri.Populated_bdid_score_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_addr_rec_type_pcnt*ri.Populated_addr_rec_type_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_cbsa_pcnt*ri.Populated_cbsa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','batch','batch_date','dbcode','incident_num','incident_date','int_key','srce_cd','billing_code','case_num','jurisdiction','agency','source_doc','source_ref','additional_info','modified_date','entry_date','member_name','submitter_name','submitter_nickname','submitter_phone','submitter_fax','submitter_email','prop_addr','prop_city','prop_state','prop_zip','aid','did','did_score','bdid','bdid_score','title','fname','mname','lname','name_suffix','name_score','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt,le.populated_batch_pcnt,le.populated_batch_date_pcnt,le.populated_dbcode_pcnt,le.populated_incident_num_pcnt,le.populated_incident_date_pcnt,le.populated_int_key_pcnt,le.populated_srce_cd_pcnt,le.populated_billing_code_pcnt,le.populated_case_num_pcnt,le.populated_jurisdiction_pcnt,le.populated_agency_pcnt,le.populated_source_doc_pcnt,le.populated_source_ref_pcnt,le.populated_additional_info_pcnt,le.populated_modified_date_pcnt,le.populated_entry_date_pcnt,le.populated_member_name_pcnt,le.populated_submitter_name_pcnt,le.populated_submitter_nickname_pcnt,le.populated_submitter_phone_pcnt,le.populated_submitter_fax_pcnt,le.populated_submitter_email_pcnt,le.populated_prop_addr_pcnt,le.populated_prop_city_pcnt,le.populated_prop_state_pcnt,le.populated_prop_zip_pcnt,le.populated_aid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_cname_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_addr_rec_type_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_cbsa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id,le.maxlength_batch,le.maxlength_batch_date,le.maxlength_dbcode,le.maxlength_incident_num,le.maxlength_incident_date,le.maxlength_int_key,le.maxlength_srce_cd,le.maxlength_billing_code,le.maxlength_case_num,le.maxlength_jurisdiction,le.maxlength_agency,le.maxlength_source_doc,le.maxlength_source_ref,le.maxlength_additional_info,le.maxlength_modified_date,le.maxlength_entry_date,le.maxlength_member_name,le.maxlength_submitter_name,le.maxlength_submitter_nickname,le.maxlength_submitter_phone,le.maxlength_submitter_fax,le.maxlength_submitter_email,le.maxlength_prop_addr,le.maxlength_prop_city,le.maxlength_prop_state,le.maxlength_prop_zip,le.maxlength_aid,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_cname,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_addr_rec_type,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_cbsa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id,le.avelength_batch,le.avelength_batch_date,le.avelength_dbcode,le.avelength_incident_num,le.avelength_incident_date,le.avelength_int_key,le.avelength_srce_cd,le.avelength_billing_code,le.avelength_case_num,le.avelength_jurisdiction,le.avelength_agency,le.avelength_source_doc,le.avelength_source_ref,le.avelength_additional_info,le.avelength_modified_date,le.avelength_entry_date,le.avelength_member_name,le.avelength_submitter_name,le.avelength_submitter_nickname,le.avelength_submitter_phone,le.avelength_submitter_fax,le.avelength_submitter_email,le.avelength_prop_addr,le.avelength_prop_city,le.avelength_prop_state,le.avelength_prop_zip,le.avelength_aid,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_cname,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_fips_state,le.avelength_fips_county,le.avelength_addr_rec_type,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_cbsa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 87, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.dbcode;
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.batch_date),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.incident_date),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.srce_cd),TRIM((SALT33.StrType)le.billing_code),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.jurisdiction),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.source_doc),TRIM((SALT33.StrType)le.source_ref),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.modified_date),TRIM((SALT33.StrType)le.entry_date),TRIM((SALT33.StrType)le.member_name),TRIM((SALT33.StrType)le.submitter_name),TRIM((SALT33.StrType)le.submitter_nickname),TRIM((SALT33.StrType)le.submitter_phone),TRIM((SALT33.StrType)le.submitter_fax),TRIM((SALT33.StrType)le.submitter_email),TRIM((SALT33.StrType)le.prop_addr),TRIM((SALT33.StrType)le.prop_city),TRIM((SALT33.StrType)le.prop_state),TRIM((SALT33.StrType)le.prop_zip),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,87,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 87);
  SELF.FldNo2 := 1 + (C % 87);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.batch_date),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.incident_date),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.srce_cd),TRIM((SALT33.StrType)le.billing_code),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.jurisdiction),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.source_doc),TRIM((SALT33.StrType)le.source_ref),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.modified_date),TRIM((SALT33.StrType)le.entry_date),TRIM((SALT33.StrType)le.member_name),TRIM((SALT33.StrType)le.submitter_name),TRIM((SALT33.StrType)le.submitter_nickname),TRIM((SALT33.StrType)le.submitter_phone),TRIM((SALT33.StrType)le.submitter_fax),TRIM((SALT33.StrType)le.submitter_email),TRIM((SALT33.StrType)le.prop_addr),TRIM((SALT33.StrType)le.prop_city),TRIM((SALT33.StrType)le.prop_state),TRIM((SALT33.StrType)le.prop_zip),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.batch_date),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.incident_date),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.srce_cd),TRIM((SALT33.StrType)le.billing_code),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.jurisdiction),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.source_doc),TRIM((SALT33.StrType)le.source_ref),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.modified_date),TRIM((SALT33.StrType)le.entry_date),TRIM((SALT33.StrType)le.member_name),TRIM((SALT33.StrType)le.submitter_name),TRIM((SALT33.StrType)le.submitter_nickname),TRIM((SALT33.StrType)le.submitter_phone),TRIM((SALT33.StrType)le.submitter_fax),TRIM((SALT33.StrType)le.submitter_email),TRIM((SALT33.StrType)le.prop_addr),TRIM((SALT33.StrType)le.prop_city),TRIM((SALT33.StrType)le.prop_state),TRIM((SALT33.StrType)le.prop_zip),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),87*87,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dotid'}
      ,{2,'dotscore'}
      ,{3,'dotweight'}
      ,{4,'empid'}
      ,{5,'empscore'}
      ,{6,'empweight'}
      ,{7,'powid'}
      ,{8,'powscore'}
      ,{9,'powweight'}
      ,{10,'proxid'}
      ,{11,'proxscore'}
      ,{12,'proxweight'}
      ,{13,'seleid'}
      ,{14,'selescore'}
      ,{15,'seleweight'}
      ,{16,'orgid'}
      ,{17,'orgscore'}
      ,{18,'orgweight'}
      ,{19,'ultid'}
      ,{20,'ultscore'}
      ,{21,'ultweight'}
      ,{22,'source_rec_id'}
      ,{23,'batch'}
      ,{24,'batch_date'}
      ,{25,'dbcode'}
      ,{26,'incident_num'}
      ,{27,'incident_date'}
      ,{28,'int_key'}
      ,{29,'srce_cd'}
      ,{30,'billing_code'}
      ,{31,'case_num'}
      ,{32,'jurisdiction'}
      ,{33,'agency'}
      ,{34,'source_doc'}
      ,{35,'source_ref'}
      ,{36,'additional_info'}
      ,{37,'modified_date'}
      ,{38,'entry_date'}
      ,{39,'member_name'}
      ,{40,'submitter_name'}
      ,{41,'submitter_nickname'}
      ,{42,'submitter_phone'}
      ,{43,'submitter_fax'}
      ,{44,'submitter_email'}
      ,{45,'prop_addr'}
      ,{46,'prop_city'}
      ,{47,'prop_state'}
      ,{48,'prop_zip'}
      ,{49,'aid'}
      ,{50,'did'}
      ,{51,'did_score'}
      ,{52,'bdid'}
      ,{53,'bdid_score'}
      ,{54,'title'}
      ,{55,'fname'}
      ,{56,'mname'}
      ,{57,'lname'}
      ,{58,'name_suffix'}
      ,{59,'name_score'}
      ,{60,'cname'}
      ,{61,'prim_range'}
      ,{62,'predir'}
      ,{63,'prim_name'}
      ,{64,'addr_suffix'}
      ,{65,'postdir'}
      ,{66,'unit_desig'}
      ,{67,'sec_range'}
      ,{68,'p_city_name'}
      ,{69,'v_city_name'}
      ,{70,'st'}
      ,{71,'zip5'}
      ,{72,'zip4'}
      ,{73,'fips_state'}
      ,{74,'fips_county'}
      ,{75,'addr_rec_type'}
      ,{76,'geo_lat'}
      ,{77,'geo_long'}
      ,{78,'cbsa'}
      ,{79,'geo_blk'}
      ,{80,'geo_match'}
      ,{81,'cart'}
      ,{82,'cr_sort_sz'}
      ,{83,'lot'}
      ,{84,'lot_order'}
      ,{85,'dpbc'}
      ,{86,'chk_digit'}
      ,{87,'err_stat'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.dbcode) dbcode; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    incident_bip_Fields.InValid_dotid((SALT33.StrType)le.dotid),
    incident_bip_Fields.InValid_dotscore((SALT33.StrType)le.dotscore),
    incident_bip_Fields.InValid_dotweight((SALT33.StrType)le.dotweight),
    incident_bip_Fields.InValid_empid((SALT33.StrType)le.empid),
    incident_bip_Fields.InValid_empscore((SALT33.StrType)le.empscore),
    incident_bip_Fields.InValid_empweight((SALT33.StrType)le.empweight),
    incident_bip_Fields.InValid_powid((SALT33.StrType)le.powid),
    incident_bip_Fields.InValid_powscore((SALT33.StrType)le.powscore),
    incident_bip_Fields.InValid_powweight((SALT33.StrType)le.powweight),
    incident_bip_Fields.InValid_proxid((SALT33.StrType)le.proxid),
    incident_bip_Fields.InValid_proxscore((SALT33.StrType)le.proxscore),
    incident_bip_Fields.InValid_proxweight((SALT33.StrType)le.proxweight),
    incident_bip_Fields.InValid_seleid((SALT33.StrType)le.seleid),
    incident_bip_Fields.InValid_selescore((SALT33.StrType)le.selescore),
    incident_bip_Fields.InValid_seleweight((SALT33.StrType)le.seleweight),
    incident_bip_Fields.InValid_orgid((SALT33.StrType)le.orgid),
    incident_bip_Fields.InValid_orgscore((SALT33.StrType)le.orgscore),
    incident_bip_Fields.InValid_orgweight((SALT33.StrType)le.orgweight),
    incident_bip_Fields.InValid_ultid((SALT33.StrType)le.ultid),
    incident_bip_Fields.InValid_ultscore((SALT33.StrType)le.ultscore),
    incident_bip_Fields.InValid_ultweight((SALT33.StrType)le.ultweight),
    incident_bip_Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id),
    incident_bip_Fields.InValid_batch((SALT33.StrType)le.batch),
    incident_bip_Fields.InValid_batch_date((SALT33.StrType)le.batch_date),
    incident_bip_Fields.InValid_dbcode((SALT33.StrType)le.dbcode),
    incident_bip_Fields.InValid_incident_num((SALT33.StrType)le.incident_num),
    incident_bip_Fields.InValid_incident_date((SALT33.StrType)le.incident_date),
    incident_bip_Fields.InValid_int_key((SALT33.StrType)le.int_key),
    incident_bip_Fields.InValid_srce_cd((SALT33.StrType)le.srce_cd),
    incident_bip_Fields.InValid_billing_code((SALT33.StrType)le.billing_code),
    incident_bip_Fields.InValid_case_num((SALT33.StrType)le.case_num),
    incident_bip_Fields.InValid_jurisdiction((SALT33.StrType)le.jurisdiction),
    incident_bip_Fields.InValid_agency((SALT33.StrType)le.agency),
    incident_bip_Fields.InValid_source_doc((SALT33.StrType)le.source_doc),
    incident_bip_Fields.InValid_source_ref((SALT33.StrType)le.source_ref),
    incident_bip_Fields.InValid_additional_info((SALT33.StrType)le.additional_info),
    incident_bip_Fields.InValid_modified_date((SALT33.StrType)le.modified_date),
    incident_bip_Fields.InValid_entry_date((SALT33.StrType)le.entry_date),
    incident_bip_Fields.InValid_member_name((SALT33.StrType)le.member_name),
    incident_bip_Fields.InValid_submitter_name((SALT33.StrType)le.submitter_name),
    incident_bip_Fields.InValid_submitter_nickname((SALT33.StrType)le.submitter_nickname),
    incident_bip_Fields.InValid_submitter_phone((SALT33.StrType)le.submitter_phone),
    incident_bip_Fields.InValid_submitter_fax((SALT33.StrType)le.submitter_fax),
    incident_bip_Fields.InValid_submitter_email((SALT33.StrType)le.submitter_email),
    incident_bip_Fields.InValid_prop_addr((SALT33.StrType)le.prop_addr),
    incident_bip_Fields.InValid_prop_city((SALT33.StrType)le.prop_city),
    incident_bip_Fields.InValid_prop_state((SALT33.StrType)le.prop_state),
    incident_bip_Fields.InValid_prop_zip((SALT33.StrType)le.prop_zip),
    incident_bip_Fields.InValid_aid((SALT33.StrType)le.aid),
    incident_bip_Fields.InValid_did((SALT33.StrType)le.did),
    incident_bip_Fields.InValid_did_score((SALT33.StrType)le.did_score),
    incident_bip_Fields.InValid_bdid((SALT33.StrType)le.bdid),
    incident_bip_Fields.InValid_bdid_score((SALT33.StrType)le.bdid_score),
    incident_bip_Fields.InValid_title((SALT33.StrType)le.title),
    incident_bip_Fields.InValid_fname((SALT33.StrType)le.fname),
    incident_bip_Fields.InValid_mname((SALT33.StrType)le.mname),
    incident_bip_Fields.InValid_lname((SALT33.StrType)le.lname),
    incident_bip_Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix),
    incident_bip_Fields.InValid_name_score((SALT33.StrType)le.name_score),
    incident_bip_Fields.InValid_cname((SALT33.StrType)le.cname),
    incident_bip_Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    incident_bip_Fields.InValid_predir((SALT33.StrType)le.predir),
    incident_bip_Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    incident_bip_Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    incident_bip_Fields.InValid_postdir((SALT33.StrType)le.postdir),
    incident_bip_Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    incident_bip_Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    incident_bip_Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    incident_bip_Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    incident_bip_Fields.InValid_st((SALT33.StrType)le.st),
    incident_bip_Fields.InValid_zip5((SALT33.StrType)le.zip5),
    incident_bip_Fields.InValid_zip4((SALT33.StrType)le.zip4),
    incident_bip_Fields.InValid_fips_state((SALT33.StrType)le.fips_state),
    incident_bip_Fields.InValid_fips_county((SALT33.StrType)le.fips_county),
    incident_bip_Fields.InValid_addr_rec_type((SALT33.StrType)le.addr_rec_type),
    incident_bip_Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    incident_bip_Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    incident_bip_Fields.InValid_cbsa((SALT33.StrType)le.cbsa),
    incident_bip_Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    incident_bip_Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    incident_bip_Fields.InValid_cart((SALT33.StrType)le.cart),
    incident_bip_Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    incident_bip_Fields.InValid_lot((SALT33.StrType)le.lot),
    incident_bip_Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    incident_bip_Fields.InValid_dpbc((SALT33.StrType)le.dpbc),
    incident_bip_Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    incident_bip_Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.dbcode := le.dbcode;
END;
Errors := NORMALIZE(h,87,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.dbcode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,dbcode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.dbcode;
  FieldNme := incident_bip_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Batch','Invalid_CurrentDate','Invalid_DBCode','Invalid_Num','Invalid_CurrentDate','Invalid_Num','Invalid_Srce_Cd','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_CurrentDate','Invalid_CurrentDate','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Invalid_State','Invalid_Zip','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Invalid_Suffix','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,incident_bip_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_empid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_powid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_batch(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_batch_date(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_dbcode(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_incident_num(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_incident_date(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_int_key(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_srce_cd(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_billing_code(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_case_num(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_jurisdiction(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_agency(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_source_doc(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_source_ref(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_additional_info(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_modified_date(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_entry_date(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_member_name(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_submitter_name(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_submitter_nickname(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_submitter_phone(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_submitter_fax(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_submitter_email(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prop_addr(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prop_city(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prop_state(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prop_zip(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_aid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_did(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_title(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_fname(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_mname(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_lname(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_cname(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_predir(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_st(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_addr_rec_type(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_cart(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_lot(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),incident_bip_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.dbcode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
