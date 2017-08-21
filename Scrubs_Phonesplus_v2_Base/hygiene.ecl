IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_File_phonesplus_Base) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.vendor);    NumberOfRecords := COUNT(GROUP);
    populated_in_flag_pcnt := AVE(GROUP,IF(h.in_flag = (TYPEOF(h.in_flag))'',0,100));
    maxlength_in_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.in_flag)));
    avelength_in_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.in_flag)),h.in_flag<>(typeof(h.in_flag))'');
    populated_confidencescore_pcnt := AVE(GROUP,IF(h.confidencescore = (TYPEOF(h.confidencescore))'',0,100));
    maxlength_confidencescore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.confidencescore)));
    avelength_confidencescore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.confidencescore)),h.confidencescore<>(typeof(h.confidencescore))'');
    populated_rules_pcnt := AVE(GROUP,IF(h.rules = (TYPEOF(h.rules))'',0,100));
    maxlength_rules := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rules)));
    avelength_rules := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rules)),h.rules<>(typeof(h.rules))'');
    populated_npa_pcnt := AVE(GROUP,IF(h.npa = (TYPEOF(h.npa))'',0,100));
    maxlength_npa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.npa)));
    avelength_npa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.npa)),h.npa<>(typeof(h.npa))'');
    populated_phone7_pcnt := AVE(GROUP,IF(h.phone7 = (TYPEOF(h.phone7))'',0,100));
    maxlength_phone7 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7)));
    avelength_phone7 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7)),h.phone7<>(typeof(h.phone7))'');
    populated_cellphone_pcnt := AVE(GROUP,IF(h.cellphone = (TYPEOF(h.cellphone))'',0,100));
    maxlength_cellphone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cellphone)));
    avelength_cellphone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cellphone)),h.cellphone<>(typeof(h.cellphone))'');
    populated_cellphoneidkey_pcnt := AVE(GROUP,IF(h.cellphoneidkey = (TYPEOF(h.cellphoneidkey))'',0,100));
    maxlength_cellphoneidkey := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cellphoneidkey)));
    avelength_cellphoneidkey := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cellphoneidkey)),h.cellphoneidkey<>(typeof(h.cellphoneidkey))'');
    populated_phone7_did_key_pcnt := AVE(GROUP,IF(h.phone7_did_key = (TYPEOF(h.phone7_did_key))'',0,100));
    maxlength_phone7_did_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7_did_key)));
    avelength_phone7_did_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7_did_key)),h.phone7_did_key<>(typeof(h.phone7_did_key))'');
    populated_pdid_pcnt := AVE(GROUP,IF(h.pdid = (TYPEOF(h.pdid))'',0,100));
    maxlength_pdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pdid)));
    avelength_pdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pdid)),h.pdid<>(typeof(h.pdid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_datefirstseen_pcnt := AVE(GROUP,IF(h.datefirstseen = (TYPEOF(h.datefirstseen))'',0,100));
    maxlength_datefirstseen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datefirstseen)));
    avelength_datefirstseen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datefirstseen)),h.datefirstseen<>(typeof(h.datefirstseen))'');
    populated_datelastseen_pcnt := AVE(GROUP,IF(h.datelastseen = (TYPEOF(h.datelastseen))'',0,100));
    maxlength_datelastseen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datelastseen)));
    avelength_datelastseen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datelastseen)),h.datelastseen<>(typeof(h.datelastseen))'');
    populated_datevendorlastreported_pcnt := AVE(GROUP,IF(h.datevendorlastreported = (TYPEOF(h.datevendorlastreported))'',0,100));
    maxlength_datevendorlastreported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datevendorlastreported)));
    avelength_datevendorlastreported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datevendorlastreported)),h.datevendorlastreported<>(typeof(h.datevendorlastreported))'');
    populated_datevendorfirstreported_pcnt := AVE(GROUP,IF(h.datevendorfirstreported = (TYPEOF(h.datevendorfirstreported))'',0,100));
    maxlength_datevendorfirstreported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datevendorfirstreported)));
    avelength_datevendorfirstreported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datevendorfirstreported)),h.datevendorfirstreported<>(typeof(h.datevendorfirstreported))'');
    populated_dt_nonglb_last_seen_pcnt := AVE(GROUP,IF(h.dt_nonglb_last_seen = (TYPEOF(h.dt_nonglb_last_seen))'',0,100));
    maxlength_dt_nonglb_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_nonglb_last_seen)));
    avelength_dt_nonglb_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_nonglb_last_seen)),h.dt_nonglb_last_seen<>(typeof(h.dt_nonglb_last_seen))'');
    populated_glb_dppa_flag_pcnt := AVE(GROUP,IF(h.glb_dppa_flag = (TYPEOF(h.glb_dppa_flag))'',0,100));
    maxlength_glb_dppa_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.glb_dppa_flag)));
    avelength_glb_dppa_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.glb_dppa_flag)),h.glb_dppa_flag<>(typeof(h.glb_dppa_flag))'');
    populated_glb_dppa_all_pcnt := AVE(GROUP,IF(h.glb_dppa_all = (TYPEOF(h.glb_dppa_all))'',0,100));
    maxlength_glb_dppa_all := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.glb_dppa_all)));
    avelength_glb_dppa_all := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.glb_dppa_all)),h.glb_dppa_all<>(typeof(h.glb_dppa_all))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_src_all_pcnt := AVE(GROUP,IF(h.src_all = (TYPEOF(h.src_all))'',0,100));
    maxlength_src_all := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_all)));
    avelength_src_all := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_all)),h.src_all<>(typeof(h.src_all))'');
    populated_src_cnt_pcnt := AVE(GROUP,IF(h.src_cnt = (TYPEOF(h.src_cnt))'',0,100));
    maxlength_src_cnt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_cnt)));
    avelength_src_cnt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_cnt)),h.src_cnt<>(typeof(h.src_cnt))'');
    populated_src_rule_pcnt := AVE(GROUP,IF(h.src_rule = (TYPEOF(h.src_rule))'',0,100));
    maxlength_src_rule := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_rule)));
    avelength_src_rule := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.src_rule)),h.src_rule<>(typeof(h.src_rule))'');
    populated_append_avg_source_conf_pcnt := AVE(GROUP,IF(h.append_avg_source_conf = (TYPEOF(h.append_avg_source_conf))'',0,100));
    maxlength_append_avg_source_conf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_avg_source_conf)));
    avelength_append_avg_source_conf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_avg_source_conf)),h.append_avg_source_conf<>(typeof(h.append_avg_source_conf))'');
    populated_append_max_source_conf_pcnt := AVE(GROUP,IF(h.append_max_source_conf = (TYPEOF(h.append_max_source_conf))'',0,100));
    maxlength_append_max_source_conf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_max_source_conf)));
    avelength_append_max_source_conf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_max_source_conf)),h.append_max_source_conf<>(typeof(h.append_max_source_conf))'');
    populated_append_min_source_conf_pcnt := AVE(GROUP,IF(h.append_min_source_conf = (TYPEOF(h.append_min_source_conf))'',0,100));
    maxlength_append_min_source_conf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_min_source_conf)));
    avelength_append_min_source_conf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_min_source_conf)),h.append_min_source_conf<>(typeof(h.append_min_source_conf))'');
    populated_append_total_source_conf_pcnt := AVE(GROUP,IF(h.append_total_source_conf = (TYPEOF(h.append_total_source_conf))'',0,100));
    maxlength_append_total_source_conf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_total_source_conf)));
    avelength_append_total_source_conf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_total_source_conf)),h.append_total_source_conf<>(typeof(h.append_total_source_conf))'');
    populated_orig_dt_last_seen_pcnt := AVE(GROUP,IF(h.orig_dt_last_seen = (TYPEOF(h.orig_dt_last_seen))'',0,100));
    maxlength_orig_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dt_last_seen)));
    avelength_orig_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_dt_last_seen)),h.orig_dt_last_seen<>(typeof(h.orig_dt_last_seen))'');
    populated_did_type_pcnt := AVE(GROUP,IF(h.did_type = (TYPEOF(h.did_type))'',0,100));
    maxlength_did_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_type)));
    avelength_did_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_type)),h.did_type<>(typeof(h.did_type))'');
    populated_origname_pcnt := AVE(GROUP,IF(h.origname = (TYPEOF(h.origname))'',0,100));
    maxlength_origname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.origname)));
    avelength_origname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.origname)),h.origname<>(typeof(h.origname))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_address3_pcnt := AVE(GROUP,IF(h.address3 = (TYPEOF(h.address3))'',0,100));
    maxlength_address3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address3)));
    avelength_address3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address3)),h.address3<>(typeof(h.address3))'');
    populated_origcity_pcnt := AVE(GROUP,IF(h.origcity = (TYPEOF(h.origcity))'',0,100));
    maxlength_origcity := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.origcity)));
    avelength_origcity := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.origcity)),h.origcity<>(typeof(h.origcity))'');
    populated_origstate_pcnt := AVE(GROUP,IF(h.origstate = (TYPEOF(h.origstate))'',0,100));
    maxlength_origstate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.origstate)));
    avelength_origstate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.origstate)),h.origstate<>(typeof(h.origstate))'');
    populated_origzip_pcnt := AVE(GROUP,IF(h.origzip = (TYPEOF(h.origzip))'',0,100));
    maxlength_origzip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.origzip)));
    avelength_origzip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.origzip)),h.origzip<>(typeof(h.origzip))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_agegroup_pcnt := AVE(GROUP,IF(h.agegroup = (TYPEOF(h.agegroup))'',0,100));
    maxlength_agegroup := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agegroup)));
    avelength_agegroup := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agegroup)),h.agegroup<>(typeof(h.agegroup))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_orig_listing_type_pcnt := AVE(GROUP,IF(h.orig_listing_type = (TYPEOF(h.orig_listing_type))'',0,100));
    maxlength_orig_listing_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_listing_type)));
    avelength_orig_listing_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_listing_type)),h.orig_listing_type<>(typeof(h.orig_listing_type))'');
    populated_listingtype_pcnt := AVE(GROUP,IF(h.listingtype = (TYPEOF(h.listingtype))'',0,100));
    maxlength_listingtype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.listingtype)));
    avelength_listingtype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.listingtype)),h.listingtype<>(typeof(h.listingtype))'');
    populated_orig_publish_code_pcnt := AVE(GROUP,IF(h.orig_publish_code = (TYPEOF(h.orig_publish_code))'',0,100));
    maxlength_orig_publish_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_publish_code)));
    avelength_orig_publish_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_publish_code)),h.orig_publish_code<>(typeof(h.orig_publish_code))'');
    populated_orig_phone_type_pcnt := AVE(GROUP,IF(h.orig_phone_type = (TYPEOF(h.orig_phone_type))'',0,100));
    maxlength_orig_phone_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_type)));
    avelength_orig_phone_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_type)),h.orig_phone_type<>(typeof(h.orig_phone_type))'');
    populated_orig_phone_usage_pcnt := AVE(GROUP,IF(h.orig_phone_usage = (TYPEOF(h.orig_phone_usage))'',0,100));
    maxlength_orig_phone_usage := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_usage)));
    avelength_orig_phone_usage := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_usage)),h.orig_phone_usage<>(typeof(h.orig_phone_usage))'');
    populated_company_pcnt := AVE(GROUP,IF(h.company = (TYPEOF(h.company))'',0,100));
    maxlength_company := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company)));
    avelength_company := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company)),h.company<>(typeof(h.company))'');
    populated_orig_phone_reg_dt_pcnt := AVE(GROUP,IF(h.orig_phone_reg_dt = (TYPEOF(h.orig_phone_reg_dt))'',0,100));
    maxlength_orig_phone_reg_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_reg_dt)));
    avelength_orig_phone_reg_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_phone_reg_dt)),h.orig_phone_reg_dt<>(typeof(h.orig_phone_reg_dt))'');
    populated_orig_carrier_code_pcnt := AVE(GROUP,IF(h.orig_carrier_code = (TYPEOF(h.orig_carrier_code))'',0,100));
    maxlength_orig_carrier_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_carrier_code)));
    avelength_orig_carrier_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_carrier_code)),h.orig_carrier_code<>(typeof(h.orig_carrier_code))'');
    populated_orig_carrier_name_pcnt := AVE(GROUP,IF(h.orig_carrier_name = (TYPEOF(h.orig_carrier_name))'',0,100));
    maxlength_orig_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_carrier_name)));
    avelength_orig_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_carrier_name)),h.orig_carrier_name<>(typeof(h.orig_carrier_name))'');
    populated_orig_conf_score_pcnt := AVE(GROUP,IF(h.orig_conf_score = (TYPEOF(h.orig_conf_score))'',0,100));
    maxlength_orig_conf_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_conf_score)));
    avelength_orig_conf_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_conf_score)),h.orig_conf_score<>(typeof(h.orig_conf_score))'');
    populated_orig_rec_type_pcnt := AVE(GROUP,IF(h.orig_rec_type = (TYPEOF(h.orig_rec_type))'',0,100));
    maxlength_orig_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_rec_type)));
    avelength_orig_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_rec_type)),h.orig_rec_type<>(typeof(h.orig_rec_type))'');
    populated_clean_company_pcnt := AVE(GROUP,IF(h.clean_company = (TYPEOF(h.clean_company))'',0,100));
    maxlength_clean_company := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_company)));
    avelength_clean_company := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_company)),h.clean_company<>(typeof(h.clean_company))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_append_npa_effective_dt_pcnt := AVE(GROUP,IF(h.append_npa_effective_dt = (TYPEOF(h.append_npa_effective_dt))'',0,100));
    maxlength_append_npa_effective_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_npa_effective_dt)));
    avelength_append_npa_effective_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_npa_effective_dt)),h.append_npa_effective_dt<>(typeof(h.append_npa_effective_dt))'');
    populated_append_npa_last_change_dt_pcnt := AVE(GROUP,IF(h.append_npa_last_change_dt = (TYPEOF(h.append_npa_last_change_dt))'',0,100));
    maxlength_append_npa_last_change_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_npa_last_change_dt)));
    avelength_append_npa_last_change_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_npa_last_change_dt)),h.append_npa_last_change_dt<>(typeof(h.append_npa_last_change_dt))'');
    populated_append_dialable_ind_pcnt := AVE(GROUP,IF(h.append_dialable_ind = (TYPEOF(h.append_dialable_ind))'',0,100));
    maxlength_append_dialable_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_dialable_ind)));
    avelength_append_dialable_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_dialable_ind)),h.append_dialable_ind<>(typeof(h.append_dialable_ind))'');
    populated_append_place_name_pcnt := AVE(GROUP,IF(h.append_place_name = (TYPEOF(h.append_place_name))'',0,100));
    maxlength_append_place_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_place_name)));
    avelength_append_place_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_place_name)),h.append_place_name<>(typeof(h.append_place_name))'');
    populated_append_portability_indicator_pcnt := AVE(GROUP,IF(h.append_portability_indicator = (TYPEOF(h.append_portability_indicator))'',0,100));
    maxlength_append_portability_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_portability_indicator)));
    avelength_append_portability_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_portability_indicator)),h.append_portability_indicator<>(typeof(h.append_portability_indicator))'');
    populated_append_prior_area_code_pcnt := AVE(GROUP,IF(h.append_prior_area_code = (TYPEOF(h.append_prior_area_code))'',0,100));
    maxlength_append_prior_area_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prior_area_code)));
    avelength_append_prior_area_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prior_area_code)),h.append_prior_area_code<>(typeof(h.append_prior_area_code))'');
    populated_append_nonpublished_match_pcnt := AVE(GROUP,IF(h.append_nonpublished_match = (TYPEOF(h.append_nonpublished_match))'',0,100));
    maxlength_append_nonpublished_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_nonpublished_match)));
    avelength_append_nonpublished_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_nonpublished_match)),h.append_nonpublished_match<>(typeof(h.append_nonpublished_match))'');
    populated_append_ocn_pcnt := AVE(GROUP,IF(h.append_ocn = (TYPEOF(h.append_ocn))'',0,100));
    maxlength_append_ocn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ocn)));
    avelength_append_ocn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ocn)),h.append_ocn<>(typeof(h.append_ocn))'');
    populated_append_time_zone_pcnt := AVE(GROUP,IF(h.append_time_zone = (TYPEOF(h.append_time_zone))'',0,100));
    maxlength_append_time_zone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_time_zone)));
    avelength_append_time_zone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_time_zone)),h.append_time_zone<>(typeof(h.append_time_zone))'');
    populated_append_nxx_type_pcnt := AVE(GROUP,IF(h.append_nxx_type = (TYPEOF(h.append_nxx_type))'',0,100));
    maxlength_append_nxx_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_nxx_type)));
    avelength_append_nxx_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_nxx_type)),h.append_nxx_type<>(typeof(h.append_nxx_type))'');
    populated_append_coctype_pcnt := AVE(GROUP,IF(h.append_coctype = (TYPEOF(h.append_coctype))'',0,100));
    maxlength_append_coctype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_coctype)));
    avelength_append_coctype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_coctype)),h.append_coctype<>(typeof(h.append_coctype))'');
    populated_append_scc_pcnt := AVE(GROUP,IF(h.append_scc = (TYPEOF(h.append_scc))'',0,100));
    maxlength_append_scc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_scc)));
    avelength_append_scc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_scc)),h.append_scc<>(typeof(h.append_scc))'');
    populated_append_phone_type_pcnt := AVE(GROUP,IF(h.append_phone_type = (TYPEOF(h.append_phone_type))'',0,100));
    maxlength_append_phone_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_phone_type)));
    avelength_append_phone_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_phone_type)),h.append_phone_type<>(typeof(h.append_phone_type))'');
    populated_append_company_type_pcnt := AVE(GROUP,IF(h.append_company_type = (TYPEOF(h.append_company_type))'',0,100));
    maxlength_append_company_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_company_type)));
    avelength_append_company_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_company_type)),h.append_company_type<>(typeof(h.append_company_type))'');
    populated_append_phone_use_pcnt := AVE(GROUP,IF(h.append_phone_use = (TYPEOF(h.append_phone_use))'',0,100));
    maxlength_append_phone_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_phone_use)));
    avelength_append_phone_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_phone_use)),h.append_phone_use<>(typeof(h.append_phone_use))'');
    populated_agreg_listing_type_pcnt := AVE(GROUP,IF(h.agreg_listing_type = (TYPEOF(h.agreg_listing_type))'',0,100));
    maxlength_agreg_listing_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agreg_listing_type)));
    avelength_agreg_listing_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agreg_listing_type)),h.agreg_listing_type<>(typeof(h.agreg_listing_type))'');
    populated_max_orig_conf_score_pcnt := AVE(GROUP,IF(h.max_orig_conf_score = (TYPEOF(h.max_orig_conf_score))'',0,100));
    maxlength_max_orig_conf_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.max_orig_conf_score)));
    avelength_max_orig_conf_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.max_orig_conf_score)),h.max_orig_conf_score<>(typeof(h.max_orig_conf_score))'');
    populated_min_orig_conf_score_pcnt := AVE(GROUP,IF(h.min_orig_conf_score = (TYPEOF(h.min_orig_conf_score))'',0,100));
    maxlength_min_orig_conf_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.min_orig_conf_score)));
    avelength_min_orig_conf_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.min_orig_conf_score)),h.min_orig_conf_score<>(typeof(h.min_orig_conf_score))'');
    populated_cur_orig_conf_score_pcnt := AVE(GROUP,IF(h.cur_orig_conf_score = (TYPEOF(h.cur_orig_conf_score))'',0,100));
    maxlength_cur_orig_conf_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cur_orig_conf_score)));
    avelength_cur_orig_conf_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cur_orig_conf_score)),h.cur_orig_conf_score<>(typeof(h.cur_orig_conf_score))'');
    populated_activeflag_pcnt := AVE(GROUP,IF(h.activeflag = (TYPEOF(h.activeflag))'',0,100));
    maxlength_activeflag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.activeflag)));
    avelength_activeflag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.activeflag)),h.activeflag<>(typeof(h.activeflag))'');
    populated_eda_active_flag_pcnt := AVE(GROUP,IF(h.eda_active_flag = (TYPEOF(h.eda_active_flag))'',0,100));
    maxlength_eda_active_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_active_flag)));
    avelength_eda_active_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_active_flag)),h.eda_active_flag<>(typeof(h.eda_active_flag))'');
    populated_eda_match_pcnt := AVE(GROUP,IF(h.eda_match = (TYPEOF(h.eda_match))'',0,100));
    maxlength_eda_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_match)));
    avelength_eda_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_match)),h.eda_match<>(typeof(h.eda_match))'');
    populated_eda_phone_dt_pcnt := AVE(GROUP,IF(h.eda_phone_dt = (TYPEOF(h.eda_phone_dt))'',0,100));
    maxlength_eda_phone_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_phone_dt)));
    avelength_eda_phone_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_phone_dt)),h.eda_phone_dt<>(typeof(h.eda_phone_dt))'');
    populated_eda_did_dt_pcnt := AVE(GROUP,IF(h.eda_did_dt = (TYPEOF(h.eda_did_dt))'',0,100));
    maxlength_eda_did_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_did_dt)));
    avelength_eda_did_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_did_dt)),h.eda_did_dt<>(typeof(h.eda_did_dt))'');
    populated_eda_nm_addr_dt_pcnt := AVE(GROUP,IF(h.eda_nm_addr_dt = (TYPEOF(h.eda_nm_addr_dt))'',0,100));
    maxlength_eda_nm_addr_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_nm_addr_dt)));
    avelength_eda_nm_addr_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_nm_addr_dt)),h.eda_nm_addr_dt<>(typeof(h.eda_nm_addr_dt))'');
    populated_eda_hist_match_pcnt := AVE(GROUP,IF(h.eda_hist_match = (TYPEOF(h.eda_hist_match))'',0,100));
    maxlength_eda_hist_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_match)));
    avelength_eda_hist_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_match)),h.eda_hist_match<>(typeof(h.eda_hist_match))'');
    populated_eda_hist_phone_dt_pcnt := AVE(GROUP,IF(h.eda_hist_phone_dt = (TYPEOF(h.eda_hist_phone_dt))'',0,100));
    maxlength_eda_hist_phone_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_phone_dt)));
    avelength_eda_hist_phone_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_phone_dt)),h.eda_hist_phone_dt<>(typeof(h.eda_hist_phone_dt))'');
    populated_eda_hist_did_dt_pcnt := AVE(GROUP,IF(h.eda_hist_did_dt = (TYPEOF(h.eda_hist_did_dt))'',0,100));
    maxlength_eda_hist_did_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_did_dt)));
    avelength_eda_hist_did_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_did_dt)),h.eda_hist_did_dt<>(typeof(h.eda_hist_did_dt))'');
    populated_eda_hist_nm_addr_dt_pcnt := AVE(GROUP,IF(h.eda_hist_nm_addr_dt = (TYPEOF(h.eda_hist_nm_addr_dt))'',0,100));
    maxlength_eda_hist_nm_addr_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_nm_addr_dt)));
    avelength_eda_hist_nm_addr_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eda_hist_nm_addr_dt)),h.eda_hist_nm_addr_dt<>(typeof(h.eda_hist_nm_addr_dt))'');
    populated_append_feedback_phone_pcnt := AVE(GROUP,IF(h.append_feedback_phone = (TYPEOF(h.append_feedback_phone))'',0,100));
    maxlength_append_feedback_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone)));
    avelength_append_feedback_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone)),h.append_feedback_phone<>(typeof(h.append_feedback_phone))'');
    populated_append_feedback_phone_dt_pcnt := AVE(GROUP,IF(h.append_feedback_phone_dt = (TYPEOF(h.append_feedback_phone_dt))'',0,100));
    maxlength_append_feedback_phone_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone_dt)));
    avelength_append_feedback_phone_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone_dt)),h.append_feedback_phone_dt<>(typeof(h.append_feedback_phone_dt))'');
    populated_append_feedback_phone7_did_pcnt := AVE(GROUP,IF(h.append_feedback_phone7_did = (TYPEOF(h.append_feedback_phone7_did))'',0,100));
    maxlength_append_feedback_phone7_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_did)));
    avelength_append_feedback_phone7_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_did)),h.append_feedback_phone7_did<>(typeof(h.append_feedback_phone7_did))'');
    populated_append_feedback_phone7_did_dt_pcnt := AVE(GROUP,IF(h.append_feedback_phone7_did_dt = (TYPEOF(h.append_feedback_phone7_did_dt))'',0,100));
    maxlength_append_feedback_phone7_did_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_did_dt)));
    avelength_append_feedback_phone7_did_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_did_dt)),h.append_feedback_phone7_did_dt<>(typeof(h.append_feedback_phone7_did_dt))'');
    populated_append_feedback_phone7_nm_addr_pcnt := AVE(GROUP,IF(h.append_feedback_phone7_nm_addr = (TYPEOF(h.append_feedback_phone7_nm_addr))'',0,100));
    maxlength_append_feedback_phone7_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_nm_addr)));
    avelength_append_feedback_phone7_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_nm_addr)),h.append_feedback_phone7_nm_addr<>(typeof(h.append_feedback_phone7_nm_addr))'');
    populated_append_feedback_phone7_nm_addr_dt_pcnt := AVE(GROUP,IF(h.append_feedback_phone7_nm_addr_dt = (TYPEOF(h.append_feedback_phone7_nm_addr_dt))'',0,100));
    maxlength_append_feedback_phone7_nm_addr_dt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_nm_addr_dt)));
    avelength_append_feedback_phone7_nm_addr_dt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_feedback_phone7_nm_addr_dt)),h.append_feedback_phone7_nm_addr_dt<>(typeof(h.append_feedback_phone7_nm_addr_dt))'');
    populated_append_ported_match_pcnt := AVE(GROUP,IF(h.append_ported_match = (TYPEOF(h.append_ported_match))'',0,100));
    maxlength_append_ported_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ported_match)));
    avelength_append_ported_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ported_match)),h.append_ported_match<>(typeof(h.append_ported_match))'');
    populated_append_seen_once_ind_pcnt := AVE(GROUP,IF(h.append_seen_once_ind = (TYPEOF(h.append_seen_once_ind))'',0,100));
    maxlength_append_seen_once_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_seen_once_ind)));
    avelength_append_seen_once_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_seen_once_ind)),h.append_seen_once_ind<>(typeof(h.append_seen_once_ind))'');
    populated_append_indiv_phone_cnt_pcnt := AVE(GROUP,IF(h.append_indiv_phone_cnt = (TYPEOF(h.append_indiv_phone_cnt))'',0,100));
    maxlength_append_indiv_phone_cnt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_indiv_phone_cnt)));
    avelength_append_indiv_phone_cnt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_indiv_phone_cnt)),h.append_indiv_phone_cnt<>(typeof(h.append_indiv_phone_cnt))'');
    populated_append_indiv_has_active_eda_phone_flag_pcnt := AVE(GROUP,IF(h.append_indiv_has_active_eda_phone_flag = (TYPEOF(h.append_indiv_has_active_eda_phone_flag))'',0,100));
    maxlength_append_indiv_has_active_eda_phone_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_indiv_has_active_eda_phone_flag)));
    avelength_append_indiv_has_active_eda_phone_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_indiv_has_active_eda_phone_flag)),h.append_indiv_has_active_eda_phone_flag<>(typeof(h.append_indiv_has_active_eda_phone_flag))'');
    populated_append_latest_phone_owner_flag_pcnt := AVE(GROUP,IF(h.append_latest_phone_owner_flag = (TYPEOF(h.append_latest_phone_owner_flag))'',0,100));
    maxlength_append_latest_phone_owner_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_latest_phone_owner_flag)));
    avelength_append_latest_phone_owner_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_latest_phone_owner_flag)),h.append_latest_phone_owner_flag<>(typeof(h.append_latest_phone_owner_flag))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_hhid_score_pcnt := AVE(GROUP,IF(h.hhid_score = (TYPEOF(h.hhid_score))'',0,100));
    maxlength_hhid_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid_score)));
    avelength_hhid_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid_score)),h.hhid_score<>(typeof(h.hhid_score))'');
    populated_phone7_hhid_key_pcnt := AVE(GROUP,IF(h.phone7_hhid_key = (TYPEOF(h.phone7_hhid_key))'',0,100));
    maxlength_phone7_hhid_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7_hhid_key)));
    avelength_phone7_hhid_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone7_hhid_key)),h.phone7_hhid_key<>(typeof(h.phone7_hhid_key))'');
    populated_append_best_addr_match_flag_pcnt := AVE(GROUP,IF(h.append_best_addr_match_flag = (TYPEOF(h.append_best_addr_match_flag))'',0,100));
    maxlength_append_best_addr_match_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_best_addr_match_flag)));
    avelength_append_best_addr_match_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_best_addr_match_flag)),h.append_best_addr_match_flag<>(typeof(h.append_best_addr_match_flag))'');
    populated_append_best_nm_match_flag_pcnt := AVE(GROUP,IF(h.append_best_nm_match_flag = (TYPEOF(h.append_best_nm_match_flag))'',0,100));
    maxlength_append_best_nm_match_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_best_nm_match_flag)));
    avelength_append_best_nm_match_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_best_nm_match_flag)),h.append_best_nm_match_flag<>(typeof(h.append_best_nm_match_flag))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_cleanaid_pcnt := AVE(GROUP,IF(h.cleanaid = (TYPEOF(h.cleanaid))'',0,100));
    maxlength_cleanaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanaid)));
    avelength_cleanaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanaid)),h.cleanaid<>(typeof(h.cleanaid))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
    populated_first_build_date_pcnt := AVE(GROUP,IF(h.first_build_date = (TYPEOF(h.first_build_date))'',0,100));
    maxlength_first_build_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_build_date)));
    avelength_first_build_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_build_date)),h.first_build_date<>(typeof(h.first_build_date))'');
    populated_last_build_date_pcnt := AVE(GROUP,IF(h.last_build_date = (TYPEOF(h.last_build_date))'',0,100));
    maxlength_last_build_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_build_date)));
    avelength_last_build_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_build_date)),h.last_build_date<>(typeof(h.last_build_date))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_in_flag_pcnt *   0.00 / 100 + T.Populated_confidencescore_pcnt *   0.00 / 100 + T.Populated_rules_pcnt *   0.00 / 100 + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_phone7_pcnt *   0.00 / 100 + T.Populated_cellphone_pcnt *   0.00 / 100 + T.Populated_cellphoneidkey_pcnt *   0.00 / 100 + T.Populated_phone7_did_key_pcnt *   0.00 / 100 + T.Populated_pdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_datefirstseen_pcnt *   0.00 / 100 + T.Populated_datelastseen_pcnt *   0.00 / 100 + T.Populated_datevendorlastreported_pcnt *   0.00 / 100 + T.Populated_datevendorfirstreported_pcnt *   0.00 / 100 + T.Populated_dt_nonglb_last_seen_pcnt *   0.00 / 100 + T.Populated_glb_dppa_flag_pcnt *   0.00 / 100 + T.Populated_glb_dppa_all_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_src_all_pcnt *   0.00 / 100 + T.Populated_src_cnt_pcnt *   0.00 / 100 + T.Populated_src_rule_pcnt *   0.00 / 100 + T.Populated_append_avg_source_conf_pcnt *   0.00 / 100 + T.Populated_append_max_source_conf_pcnt *   0.00 / 100 + T.Populated_append_min_source_conf_pcnt *   0.00 / 100 + T.Populated_append_total_source_conf_pcnt *   0.00 / 100 + T.Populated_orig_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_did_type_pcnt *   0.00 / 100 + T.Populated_origname_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_address3_pcnt *   0.00 / 100 + T.Populated_origcity_pcnt *   0.00 / 100 + T.Populated_origstate_pcnt *   0.00 / 100 + T.Populated_origzip_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_agegroup_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_orig_listing_type_pcnt *   0.00 / 100 + T.Populated_listingtype_pcnt *   0.00 / 100 + T.Populated_orig_publish_code_pcnt *   0.00 / 100 + T.Populated_orig_phone_type_pcnt *   0.00 / 100 + T.Populated_orig_phone_usage_pcnt *   0.00 / 100 + T.Populated_company_pcnt *   0.00 / 100 + T.Populated_orig_phone_reg_dt_pcnt *   0.00 / 100 + T.Populated_orig_carrier_code_pcnt *   0.00 / 100 + T.Populated_orig_carrier_name_pcnt *   0.00 / 100 + T.Populated_orig_conf_score_pcnt *   0.00 / 100 + T.Populated_orig_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_company_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_append_npa_effective_dt_pcnt *   0.00 / 100 + T.Populated_append_npa_last_change_dt_pcnt *   0.00 / 100 + T.Populated_append_dialable_ind_pcnt *   0.00 / 100 + T.Populated_append_place_name_pcnt *   0.00 / 100 + T.Populated_append_portability_indicator_pcnt *   0.00 / 100 + T.Populated_append_prior_area_code_pcnt *   0.00 / 100 + T.Populated_append_nonpublished_match_pcnt *   0.00 / 100 + T.Populated_append_ocn_pcnt *   0.00 / 100 + T.Populated_append_time_zone_pcnt *   0.00 / 100 + T.Populated_append_nxx_type_pcnt *   0.00 / 100 + T.Populated_append_coctype_pcnt *   0.00 / 100 + T.Populated_append_scc_pcnt *   0.00 / 100 + T.Populated_append_phone_type_pcnt *   0.00 / 100 + T.Populated_append_company_type_pcnt *   0.00 / 100 + T.Populated_append_phone_use_pcnt *   0.00 / 100 + T.Populated_agreg_listing_type_pcnt *   0.00 / 100 + T.Populated_max_orig_conf_score_pcnt *   0.00 / 100 + T.Populated_min_orig_conf_score_pcnt *   0.00 / 100 + T.Populated_cur_orig_conf_score_pcnt *   0.00 / 100 + T.Populated_activeflag_pcnt *   0.00 / 100 + T.Populated_eda_active_flag_pcnt *   0.00 / 100 + T.Populated_eda_match_pcnt *   0.00 / 100 + T.Populated_eda_phone_dt_pcnt *   0.00 / 100 + T.Populated_eda_did_dt_pcnt *   0.00 / 100 + T.Populated_eda_nm_addr_dt_pcnt *   0.00 / 100 + T.Populated_eda_hist_match_pcnt *   0.00 / 100 + T.Populated_eda_hist_phone_dt_pcnt *   0.00 / 100 + T.Populated_eda_hist_did_dt_pcnt *   0.00 / 100 + T.Populated_eda_hist_nm_addr_dt_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone_dt_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone7_did_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone7_did_dt_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone7_nm_addr_pcnt *   0.00 / 100 + T.Populated_append_feedback_phone7_nm_addr_dt_pcnt *   0.00 / 100 + T.Populated_append_ported_match_pcnt *   0.00 / 100 + T.Populated_append_seen_once_ind_pcnt *   0.00 / 100 + T.Populated_append_indiv_phone_cnt_pcnt *   0.00 / 100 + T.Populated_append_indiv_has_active_eda_phone_flag_pcnt *   0.00 / 100 + T.Populated_append_latest_phone_owner_flag_pcnt *   0.00 / 100 + T.Populated_hhid_pcnt *   0.00 / 100 + T.Populated_hhid_score_pcnt *   0.00 / 100 + T.Populated_phone7_hhid_key_pcnt *   0.00 / 100 + T.Populated_append_best_addr_match_flag_pcnt *   0.00 / 100 + T.Populated_append_best_nm_match_flag_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_cleanaid_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100 + T.Populated_first_build_date_pcnt *   0.00 / 100 + T.Populated_last_build_date_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_in_flag_pcnt*ri.Populated_in_flag_pcnt *   0.00 / 10000 + le.Populated_confidencescore_pcnt*ri.Populated_confidencescore_pcnt *   0.00 / 10000 + le.Populated_rules_pcnt*ri.Populated_rules_pcnt *   0.00 / 10000 + le.Populated_npa_pcnt*ri.Populated_npa_pcnt *   0.00 / 10000 + le.Populated_phone7_pcnt*ri.Populated_phone7_pcnt *   0.00 / 10000 + le.Populated_cellphone_pcnt*ri.Populated_cellphone_pcnt *   0.00 / 10000 + le.Populated_cellphoneidkey_pcnt*ri.Populated_cellphoneidkey_pcnt *   0.00 / 10000 + le.Populated_phone7_did_key_pcnt*ri.Populated_phone7_did_key_pcnt *   0.00 / 10000 + le.Populated_pdid_pcnt*ri.Populated_pdid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_datefirstseen_pcnt*ri.Populated_datefirstseen_pcnt *   0.00 / 10000 + le.Populated_datelastseen_pcnt*ri.Populated_datelastseen_pcnt *   0.00 / 10000 + le.Populated_datevendorlastreported_pcnt*ri.Populated_datevendorlastreported_pcnt *   0.00 / 10000 + le.Populated_datevendorfirstreported_pcnt*ri.Populated_datevendorfirstreported_pcnt *   0.00 / 10000 + le.Populated_dt_nonglb_last_seen_pcnt*ri.Populated_dt_nonglb_last_seen_pcnt *   0.00 / 10000 + le.Populated_glb_dppa_flag_pcnt*ri.Populated_glb_dppa_flag_pcnt *   0.00 / 10000 + le.Populated_glb_dppa_all_pcnt*ri.Populated_glb_dppa_all_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000 + le.Populated_src_pcnt*ri.Populated_src_pcnt *   0.00 / 10000 + le.Populated_src_all_pcnt*ri.Populated_src_all_pcnt *   0.00 / 10000 + le.Populated_src_cnt_pcnt*ri.Populated_src_cnt_pcnt *   0.00 / 10000 + le.Populated_src_rule_pcnt*ri.Populated_src_rule_pcnt *   0.00 / 10000 + le.Populated_append_avg_source_conf_pcnt*ri.Populated_append_avg_source_conf_pcnt *   0.00 / 10000 + le.Populated_append_max_source_conf_pcnt*ri.Populated_append_max_source_conf_pcnt *   0.00 / 10000 + le.Populated_append_min_source_conf_pcnt*ri.Populated_append_min_source_conf_pcnt *   0.00 / 10000 + le.Populated_append_total_source_conf_pcnt*ri.Populated_append_total_source_conf_pcnt *   0.00 / 10000 + le.Populated_orig_dt_last_seen_pcnt*ri.Populated_orig_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_did_type_pcnt*ri.Populated_did_type_pcnt *   0.00 / 10000 + le.Populated_origname_pcnt*ri.Populated_origname_pcnt *   0.00 / 10000 + le.Populated_address1_pcnt*ri.Populated_address1_pcnt *   0.00 / 10000 + le.Populated_address2_pcnt*ri.Populated_address2_pcnt *   0.00 / 10000 + le.Populated_address3_pcnt*ri.Populated_address3_pcnt *   0.00 / 10000 + le.Populated_origcity_pcnt*ri.Populated_origcity_pcnt *   0.00 / 10000 + le.Populated_origstate_pcnt*ri.Populated_origstate_pcnt *   0.00 / 10000 + le.Populated_origzip_pcnt*ri.Populated_origzip_pcnt *   0.00 / 10000 + le.Populated_orig_phone_pcnt*ri.Populated_orig_phone_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_agegroup_pcnt*ri.Populated_agegroup_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_email_pcnt*ri.Populated_email_pcnt *   0.00 / 10000 + le.Populated_orig_listing_type_pcnt*ri.Populated_orig_listing_type_pcnt *   0.00 / 10000 + le.Populated_listingtype_pcnt*ri.Populated_listingtype_pcnt *   0.00 / 10000 + le.Populated_orig_publish_code_pcnt*ri.Populated_orig_publish_code_pcnt *   0.00 / 10000 + le.Populated_orig_phone_type_pcnt*ri.Populated_orig_phone_type_pcnt *   0.00 / 10000 + le.Populated_orig_phone_usage_pcnt*ri.Populated_orig_phone_usage_pcnt *   0.00 / 10000 + le.Populated_company_pcnt*ri.Populated_company_pcnt *   0.00 / 10000 + le.Populated_orig_phone_reg_dt_pcnt*ri.Populated_orig_phone_reg_dt_pcnt *   0.00 / 10000 + le.Populated_orig_carrier_code_pcnt*ri.Populated_orig_carrier_code_pcnt *   0.00 / 10000 + le.Populated_orig_carrier_name_pcnt*ri.Populated_orig_carrier_name_pcnt *   0.00 / 10000 + le.Populated_orig_conf_score_pcnt*ri.Populated_orig_conf_score_pcnt *   0.00 / 10000 + le.Populated_orig_rec_type_pcnt*ri.Populated_orig_rec_type_pcnt *   0.00 / 10000 + le.Populated_clean_company_pcnt*ri.Populated_clean_company_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_ace_fips_county_pcnt*ri.Populated_ace_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_bdid_score_pcnt*ri.Populated_bdid_score_pcnt *   0.00 / 10000 + le.Populated_append_npa_effective_dt_pcnt*ri.Populated_append_npa_effective_dt_pcnt *   0.00 / 10000 + le.Populated_append_npa_last_change_dt_pcnt*ri.Populated_append_npa_last_change_dt_pcnt *   0.00 / 10000 + le.Populated_append_dialable_ind_pcnt*ri.Populated_append_dialable_ind_pcnt *   0.00 / 10000 + le.Populated_append_place_name_pcnt*ri.Populated_append_place_name_pcnt *   0.00 / 10000 + le.Populated_append_portability_indicator_pcnt*ri.Populated_append_portability_indicator_pcnt *   0.00 / 10000 + le.Populated_append_prior_area_code_pcnt*ri.Populated_append_prior_area_code_pcnt *   0.00 / 10000 + le.Populated_append_nonpublished_match_pcnt*ri.Populated_append_nonpublished_match_pcnt *   0.00 / 10000 + le.Populated_append_ocn_pcnt*ri.Populated_append_ocn_pcnt *   0.00 / 10000 + le.Populated_append_time_zone_pcnt*ri.Populated_append_time_zone_pcnt *   0.00 / 10000 + le.Populated_append_nxx_type_pcnt*ri.Populated_append_nxx_type_pcnt *   0.00 / 10000 + le.Populated_append_coctype_pcnt*ri.Populated_append_coctype_pcnt *   0.00 / 10000 + le.Populated_append_scc_pcnt*ri.Populated_append_scc_pcnt *   0.00 / 10000 + le.Populated_append_phone_type_pcnt*ri.Populated_append_phone_type_pcnt *   0.00 / 10000 + le.Populated_append_company_type_pcnt*ri.Populated_append_company_type_pcnt *   0.00 / 10000 + le.Populated_append_phone_use_pcnt*ri.Populated_append_phone_use_pcnt *   0.00 / 10000 + le.Populated_agreg_listing_type_pcnt*ri.Populated_agreg_listing_type_pcnt *   0.00 / 10000 + le.Populated_max_orig_conf_score_pcnt*ri.Populated_max_orig_conf_score_pcnt *   0.00 / 10000 + le.Populated_min_orig_conf_score_pcnt*ri.Populated_min_orig_conf_score_pcnt *   0.00 / 10000 + le.Populated_cur_orig_conf_score_pcnt*ri.Populated_cur_orig_conf_score_pcnt *   0.00 / 10000 + le.Populated_activeflag_pcnt*ri.Populated_activeflag_pcnt *   0.00 / 10000 + le.Populated_eda_active_flag_pcnt*ri.Populated_eda_active_flag_pcnt *   0.00 / 10000 + le.Populated_eda_match_pcnt*ri.Populated_eda_match_pcnt *   0.00 / 10000 + le.Populated_eda_phone_dt_pcnt*ri.Populated_eda_phone_dt_pcnt *   0.00 / 10000 + le.Populated_eda_did_dt_pcnt*ri.Populated_eda_did_dt_pcnt *   0.00 / 10000 + le.Populated_eda_nm_addr_dt_pcnt*ri.Populated_eda_nm_addr_dt_pcnt *   0.00 / 10000 + le.Populated_eda_hist_match_pcnt*ri.Populated_eda_hist_match_pcnt *   0.00 / 10000 + le.Populated_eda_hist_phone_dt_pcnt*ri.Populated_eda_hist_phone_dt_pcnt *   0.00 / 10000 + le.Populated_eda_hist_did_dt_pcnt*ri.Populated_eda_hist_did_dt_pcnt *   0.00 / 10000 + le.Populated_eda_hist_nm_addr_dt_pcnt*ri.Populated_eda_hist_nm_addr_dt_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone_pcnt*ri.Populated_append_feedback_phone_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone_dt_pcnt*ri.Populated_append_feedback_phone_dt_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone7_did_pcnt*ri.Populated_append_feedback_phone7_did_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone7_did_dt_pcnt*ri.Populated_append_feedback_phone7_did_dt_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone7_nm_addr_pcnt*ri.Populated_append_feedback_phone7_nm_addr_pcnt *   0.00 / 10000 + le.Populated_append_feedback_phone7_nm_addr_dt_pcnt*ri.Populated_append_feedback_phone7_nm_addr_dt_pcnt *   0.00 / 10000 + le.Populated_append_ported_match_pcnt*ri.Populated_append_ported_match_pcnt *   0.00 / 10000 + le.Populated_append_seen_once_ind_pcnt*ri.Populated_append_seen_once_ind_pcnt *   0.00 / 10000 + le.Populated_append_indiv_phone_cnt_pcnt*ri.Populated_append_indiv_phone_cnt_pcnt *   0.00 / 10000 + le.Populated_append_indiv_has_active_eda_phone_flag_pcnt*ri.Populated_append_indiv_has_active_eda_phone_flag_pcnt *   0.00 / 10000 + le.Populated_append_latest_phone_owner_flag_pcnt*ri.Populated_append_latest_phone_owner_flag_pcnt *   0.00 / 10000 + le.Populated_hhid_pcnt*ri.Populated_hhid_pcnt *   0.00 / 10000 + le.Populated_hhid_score_pcnt*ri.Populated_hhid_score_pcnt *   0.00 / 10000 + le.Populated_phone7_hhid_key_pcnt*ri.Populated_phone7_hhid_key_pcnt *   0.00 / 10000 + le.Populated_append_best_addr_match_flag_pcnt*ri.Populated_append_best_addr_match_flag_pcnt *   0.00 / 10000 + le.Populated_append_best_nm_match_flag_pcnt*ri.Populated_append_best_nm_match_flag_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_cleanaid_pcnt*ri.Populated_cleanaid_pcnt *   0.00 / 10000 + le.Populated_current_rec_pcnt*ri.Populated_current_rec_pcnt *   0.00 / 10000 + le.Populated_first_build_date_pcnt*ri.Populated_first_build_date_pcnt *   0.00 / 10000 + le.Populated_last_build_date_pcnt*ri.Populated_last_build_date_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'in_flag','confidencescore','rules','npa','phone7','cellphone','cellphoneidkey','phone7_did_key','pdid','did','did_score','datefirstseen','datelastseen','datevendorlastreported','datevendorfirstreported','dt_nonglb_last_seen','glb_dppa_flag','glb_dppa_all','vendor','src','src_all','src_cnt','src_rule','append_avg_source_conf','append_max_source_conf','append_min_source_conf','append_total_source_conf','orig_dt_last_seen','did_type','origname','address1','address2','address3','origcity','origstate','origzip','orig_phone','dob','agegroup','gender','email','orig_listing_type','listingtype','orig_publish_code','orig_phone_type','orig_phone_usage','company','orig_phone_reg_dt','orig_carrier_code','orig_carrier_name','orig_conf_score','orig_rec_type','clean_company','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','bdid','bdid_score','append_npa_effective_dt','append_npa_last_change_dt','append_dialable_ind','append_place_name','append_portability_indicator','append_prior_area_code','append_nonpublished_match','append_ocn','append_time_zone','append_nxx_type','append_coctype','append_scc','append_phone_type','append_company_type','append_phone_use','agreg_listing_type','max_orig_conf_score','min_orig_conf_score','cur_orig_conf_score','activeflag','eda_active_flag','eda_match','eda_phone_dt','eda_did_dt','eda_nm_addr_dt','eda_hist_match','eda_hist_phone_dt','eda_hist_did_dt','eda_hist_nm_addr_dt','append_feedback_phone','append_feedback_phone_dt','append_feedback_phone7_did','append_feedback_phone7_did_dt','append_feedback_phone7_nm_addr','append_feedback_phone7_nm_addr_dt','append_ported_match','append_seen_once_ind','append_indiv_phone_cnt','append_indiv_has_active_eda_phone_flag','append_latest_phone_owner_flag','hhid','hhid_score','phone7_hhid_key','append_best_addr_match_flag','append_best_nm_match_flag','rawaid','cleanaid','current_rec','first_build_date','last_build_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_in_flag_pcnt,le.populated_confidencescore_pcnt,le.populated_rules_pcnt,le.populated_npa_pcnt,le.populated_phone7_pcnt,le.populated_cellphone_pcnt,le.populated_cellphoneidkey_pcnt,le.populated_phone7_did_key_pcnt,le.populated_pdid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_datefirstseen_pcnt,le.populated_datelastseen_pcnt,le.populated_datevendorlastreported_pcnt,le.populated_datevendorfirstreported_pcnt,le.populated_dt_nonglb_last_seen_pcnt,le.populated_glb_dppa_flag_pcnt,le.populated_glb_dppa_all_pcnt,le.populated_vendor_pcnt,le.populated_src_pcnt,le.populated_src_all_pcnt,le.populated_src_cnt_pcnt,le.populated_src_rule_pcnt,le.populated_append_avg_source_conf_pcnt,le.populated_append_max_source_conf_pcnt,le.populated_append_min_source_conf_pcnt,le.populated_append_total_source_conf_pcnt,le.populated_orig_dt_last_seen_pcnt,le.populated_did_type_pcnt,le.populated_origname_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_address3_pcnt,le.populated_origcity_pcnt,le.populated_origstate_pcnt,le.populated_origzip_pcnt,le.populated_orig_phone_pcnt,le.populated_dob_pcnt,le.populated_agegroup_pcnt,le.populated_gender_pcnt,le.populated_email_pcnt,le.populated_orig_listing_type_pcnt,le.populated_listingtype_pcnt,le.populated_orig_publish_code_pcnt,le.populated_orig_phone_type_pcnt,le.populated_orig_phone_usage_pcnt,le.populated_company_pcnt,le.populated_orig_phone_reg_dt_pcnt,le.populated_orig_carrier_code_pcnt,le.populated_orig_carrier_name_pcnt,le.populated_orig_conf_score_pcnt,le.populated_orig_rec_type_pcnt,le.populated_clean_company_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_append_npa_effective_dt_pcnt,le.populated_append_npa_last_change_dt_pcnt,le.populated_append_dialable_ind_pcnt,le.populated_append_place_name_pcnt,le.populated_append_portability_indicator_pcnt,le.populated_append_prior_area_code_pcnt,le.populated_append_nonpublished_match_pcnt,le.populated_append_ocn_pcnt,le.populated_append_time_zone_pcnt,le.populated_append_nxx_type_pcnt,le.populated_append_coctype_pcnt,le.populated_append_scc_pcnt,le.populated_append_phone_type_pcnt,le.populated_append_company_type_pcnt,le.populated_append_phone_use_pcnt,le.populated_agreg_listing_type_pcnt,le.populated_max_orig_conf_score_pcnt,le.populated_min_orig_conf_score_pcnt,le.populated_cur_orig_conf_score_pcnt,le.populated_activeflag_pcnt,le.populated_eda_active_flag_pcnt,le.populated_eda_match_pcnt,le.populated_eda_phone_dt_pcnt,le.populated_eda_did_dt_pcnt,le.populated_eda_nm_addr_dt_pcnt,le.populated_eda_hist_match_pcnt,le.populated_eda_hist_phone_dt_pcnt,le.populated_eda_hist_did_dt_pcnt,le.populated_eda_hist_nm_addr_dt_pcnt,le.populated_append_feedback_phone_pcnt,le.populated_append_feedback_phone_dt_pcnt,le.populated_append_feedback_phone7_did_pcnt,le.populated_append_feedback_phone7_did_dt_pcnt,le.populated_append_feedback_phone7_nm_addr_pcnt,le.populated_append_feedback_phone7_nm_addr_dt_pcnt,le.populated_append_ported_match_pcnt,le.populated_append_seen_once_ind_pcnt,le.populated_append_indiv_phone_cnt_pcnt,le.populated_append_indiv_has_active_eda_phone_flag_pcnt,le.populated_append_latest_phone_owner_flag_pcnt,le.populated_hhid_pcnt,le.populated_hhid_score_pcnt,le.populated_phone7_hhid_key_pcnt,le.populated_append_best_addr_match_flag_pcnt,le.populated_append_best_nm_match_flag_pcnt,le.populated_rawaid_pcnt,le.populated_cleanaid_pcnt,le.populated_current_rec_pcnt,le.populated_first_build_date_pcnt,le.populated_last_build_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_in_flag,le.maxlength_confidencescore,le.maxlength_rules,le.maxlength_npa,le.maxlength_phone7,le.maxlength_cellphone,le.maxlength_cellphoneidkey,le.maxlength_phone7_did_key,le.maxlength_pdid,le.maxlength_did,le.maxlength_did_score,le.maxlength_datefirstseen,le.maxlength_datelastseen,le.maxlength_datevendorlastreported,le.maxlength_datevendorfirstreported,le.maxlength_dt_nonglb_last_seen,le.maxlength_glb_dppa_flag,le.maxlength_glb_dppa_all,le.maxlength_vendor,le.maxlength_src,le.maxlength_src_all,le.maxlength_src_cnt,le.maxlength_src_rule,le.maxlength_append_avg_source_conf,le.maxlength_append_max_source_conf,le.maxlength_append_min_source_conf,le.maxlength_append_total_source_conf,le.maxlength_orig_dt_last_seen,le.maxlength_did_type,le.maxlength_origname,le.maxlength_address1,le.maxlength_address2,le.maxlength_address3,le.maxlength_origcity,le.maxlength_origstate,le.maxlength_origzip,le.maxlength_orig_phone,le.maxlength_dob,le.maxlength_agegroup,le.maxlength_gender,le.maxlength_email,le.maxlength_orig_listing_type,le.maxlength_listingtype,le.maxlength_orig_publish_code,le.maxlength_orig_phone_type,le.maxlength_orig_phone_usage,le.maxlength_company,le.maxlength_orig_phone_reg_dt,le.maxlength_orig_carrier_code,le.maxlength_orig_carrier_name,le.maxlength_orig_conf_score,le.maxlength_orig_rec_type,le.maxlength_clean_company,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_append_npa_effective_dt,le.maxlength_append_npa_last_change_dt,le.maxlength_append_dialable_ind,le.maxlength_append_place_name,le.maxlength_append_portability_indicator,le.maxlength_append_prior_area_code,le.maxlength_append_nonpublished_match,le.maxlength_append_ocn,le.maxlength_append_time_zone,le.maxlength_append_nxx_type,le.maxlength_append_coctype,le.maxlength_append_scc,le.maxlength_append_phone_type,le.maxlength_append_company_type,le.maxlength_append_phone_use,le.maxlength_agreg_listing_type,le.maxlength_max_orig_conf_score,le.maxlength_min_orig_conf_score,le.maxlength_cur_orig_conf_score,le.maxlength_activeflag,le.maxlength_eda_active_flag,le.maxlength_eda_match,le.maxlength_eda_phone_dt,le.maxlength_eda_did_dt,le.maxlength_eda_nm_addr_dt,le.maxlength_eda_hist_match,le.maxlength_eda_hist_phone_dt,le.maxlength_eda_hist_did_dt,le.maxlength_eda_hist_nm_addr_dt,le.maxlength_append_feedback_phone,le.maxlength_append_feedback_phone_dt,le.maxlength_append_feedback_phone7_did,le.maxlength_append_feedback_phone7_did_dt,le.maxlength_append_feedback_phone7_nm_addr,le.maxlength_append_feedback_phone7_nm_addr_dt,le.maxlength_append_ported_match,le.maxlength_append_seen_once_ind,le.maxlength_append_indiv_phone_cnt,le.maxlength_append_indiv_has_active_eda_phone_flag,le.maxlength_append_latest_phone_owner_flag,le.maxlength_hhid,le.maxlength_hhid_score,le.maxlength_phone7_hhid_key,le.maxlength_append_best_addr_match_flag,le.maxlength_append_best_nm_match_flag,le.maxlength_rawaid,le.maxlength_cleanaid,le.maxlength_current_rec,le.maxlength_first_build_date,le.maxlength_last_build_date);
  SELF.avelength := CHOOSE(C,le.avelength_in_flag,le.avelength_confidencescore,le.avelength_rules,le.avelength_npa,le.avelength_phone7,le.avelength_cellphone,le.avelength_cellphoneidkey,le.avelength_phone7_did_key,le.avelength_pdid,le.avelength_did,le.avelength_did_score,le.avelength_datefirstseen,le.avelength_datelastseen,le.avelength_datevendorlastreported,le.avelength_datevendorfirstreported,le.avelength_dt_nonglb_last_seen,le.avelength_glb_dppa_flag,le.avelength_glb_dppa_all,le.avelength_vendor,le.avelength_src,le.avelength_src_all,le.avelength_src_cnt,le.avelength_src_rule,le.avelength_append_avg_source_conf,le.avelength_append_max_source_conf,le.avelength_append_min_source_conf,le.avelength_append_total_source_conf,le.avelength_orig_dt_last_seen,le.avelength_did_type,le.avelength_origname,le.avelength_address1,le.avelength_address2,le.avelength_address3,le.avelength_origcity,le.avelength_origstate,le.avelength_origzip,le.avelength_orig_phone,le.avelength_dob,le.avelength_agegroup,le.avelength_gender,le.avelength_email,le.avelength_orig_listing_type,le.avelength_listingtype,le.avelength_orig_publish_code,le.avelength_orig_phone_type,le.avelength_orig_phone_usage,le.avelength_company,le.avelength_orig_phone_reg_dt,le.avelength_orig_carrier_code,le.avelength_orig_carrier_name,le.avelength_orig_conf_score,le.avelength_orig_rec_type,le.avelength_clean_company,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_append_npa_effective_dt,le.avelength_append_npa_last_change_dt,le.avelength_append_dialable_ind,le.avelength_append_place_name,le.avelength_append_portability_indicator,le.avelength_append_prior_area_code,le.avelength_append_nonpublished_match,le.avelength_append_ocn,le.avelength_append_time_zone,le.avelength_append_nxx_type,le.avelength_append_coctype,le.avelength_append_scc,le.avelength_append_phone_type,le.avelength_append_company_type,le.avelength_append_phone_use,le.avelength_agreg_listing_type,le.avelength_max_orig_conf_score,le.avelength_min_orig_conf_score,le.avelength_cur_orig_conf_score,le.avelength_activeflag,le.avelength_eda_active_flag,le.avelength_eda_match,le.avelength_eda_phone_dt,le.avelength_eda_did_dt,le.avelength_eda_nm_addr_dt,le.avelength_eda_hist_match,le.avelength_eda_hist_phone_dt,le.avelength_eda_hist_did_dt,le.avelength_eda_hist_nm_addr_dt,le.avelength_append_feedback_phone,le.avelength_append_feedback_phone_dt,le.avelength_append_feedback_phone7_did,le.avelength_append_feedback_phone7_did_dt,le.avelength_append_feedback_phone7_nm_addr,le.avelength_append_feedback_phone7_nm_addr_dt,le.avelength_append_ported_match,le.avelength_append_seen_once_ind,le.avelength_append_indiv_phone_cnt,le.avelength_append_indiv_has_active_eda_phone_flag,le.avelength_append_latest_phone_owner_flag,le.avelength_hhid,le.avelength_hhid_score,le.avelength_phone7_hhid_key,le.avelength_append_best_addr_match_flag,le.avelength_append_best_nm_match_flag,le.avelength_rawaid,le.avelength_cleanaid,le.avelength_current_rec,le.avelength_first_build_date,le.avelength_last_build_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 138, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.in_flag),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.rules),TRIM((SALT30.StrType)le.npa),TRIM((SALT30.StrType)le.phone7),TRIM((SALT30.StrType)le.cellphone),TRIM((SALT30.StrType)le.cellphoneidkey),TRIM((SALT30.StrType)le.phone7_did_key),TRIM((SALT30.StrType)le.pdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.datevendorlastreported),TRIM((SALT30.StrType)le.datevendorfirstreported),TRIM((SALT30.StrType)le.dt_nonglb_last_seen),TRIM((SALT30.StrType)le.glb_dppa_flag),TRIM((SALT30.StrType)le.glb_dppa_all),TRIM((SALT30.StrType)le.vendor),TRIM((SALT30.StrType)le.src),TRIM((SALT30.StrType)le.src_all),TRIM((SALT30.StrType)le.src_cnt),TRIM((SALT30.StrType)le.src_rule),TRIM((SALT30.StrType)le.append_avg_source_conf),TRIM((SALT30.StrType)le.append_max_source_conf),TRIM((SALT30.StrType)le.append_min_source_conf),TRIM((SALT30.StrType)le.append_total_source_conf),TRIM((SALT30.StrType)le.orig_dt_last_seen),TRIM((SALT30.StrType)le.did_type),TRIM((SALT30.StrType)le.origname),TRIM((SALT30.StrType)le.address1),TRIM((SALT30.StrType)le.address2),TRIM((SALT30.StrType)le.address3),TRIM((SALT30.StrType)le.origcity),TRIM((SALT30.StrType)le.origstate),TRIM((SALT30.StrType)le.origzip),TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.agegroup),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.orig_listing_type),TRIM((SALT30.StrType)le.listingtype),TRIM((SALT30.StrType)le.orig_publish_code),TRIM((SALT30.StrType)le.orig_phone_type),TRIM((SALT30.StrType)le.orig_phone_usage),TRIM((SALT30.StrType)le.company),TRIM((SALT30.StrType)le.orig_phone_reg_dt),TRIM((SALT30.StrType)le.orig_carrier_code),TRIM((SALT30.StrType)le.orig_carrier_name),TRIM((SALT30.StrType)le.orig_conf_score),TRIM((SALT30.StrType)le.orig_rec_type),TRIM((SALT30.StrType)le.clean_company),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.ace_fips_st),TRIM((SALT30.StrType)le.ace_fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.append_npa_effective_dt),TRIM((SALT30.StrType)le.append_npa_last_change_dt),TRIM((SALT30.StrType)le.append_dialable_ind),TRIM((SALT30.StrType)le.append_place_name),TRIM((SALT30.StrType)le.append_portability_indicator),TRIM((SALT30.StrType)le.append_prior_area_code),TRIM((SALT30.StrType)le.append_nonpublished_match),TRIM((SALT30.StrType)le.append_ocn),TRIM((SALT30.StrType)le.append_time_zone),TRIM((SALT30.StrType)le.append_nxx_type),TRIM((SALT30.StrType)le.append_coctype),TRIM((SALT30.StrType)le.append_scc),TRIM((SALT30.StrType)le.append_phone_type),TRIM((SALT30.StrType)le.append_company_type),TRIM((SALT30.StrType)le.append_phone_use),TRIM((SALT30.StrType)le.agreg_listing_type),TRIM((SALT30.StrType)le.max_orig_conf_score),TRIM((SALT30.StrType)le.min_orig_conf_score),TRIM((SALT30.StrType)le.cur_orig_conf_score),TRIM((SALT30.StrType)le.activeflag),TRIM((SALT30.StrType)le.eda_active_flag),TRIM((SALT30.StrType)le.eda_match),TRIM((SALT30.StrType)le.eda_phone_dt),TRIM((SALT30.StrType)le.eda_did_dt),TRIM((SALT30.StrType)le.eda_nm_addr_dt),TRIM((SALT30.StrType)le.eda_hist_match),TRIM((SALT30.StrType)le.eda_hist_phone_dt),TRIM((SALT30.StrType)le.eda_hist_did_dt),TRIM((SALT30.StrType)le.eda_hist_nm_addr_dt),TRIM((SALT30.StrType)le.append_feedback_phone),TRIM((SALT30.StrType)le.append_feedback_phone_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_did),TRIM((SALT30.StrType)le.append_feedback_phone7_did_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr_dt),TRIM((SALT30.StrType)le.append_ported_match),TRIM((SALT30.StrType)le.append_seen_once_ind),TRIM((SALT30.StrType)le.append_indiv_phone_cnt),TRIM((SALT30.StrType)le.append_indiv_has_active_eda_phone_flag),TRIM((SALT30.StrType)le.append_latest_phone_owner_flag),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.hhid_score),TRIM((SALT30.StrType)le.phone7_hhid_key),TRIM((SALT30.StrType)le.append_best_addr_match_flag),TRIM((SALT30.StrType)le.append_best_nm_match_flag),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.cleanaid),TRIM((SALT30.StrType)le.current_rec),TRIM((SALT30.StrType)le.first_build_date),TRIM((SALT30.StrType)le.last_build_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,138,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 138);
  SELF.FldNo2 := 1 + (C % 138);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.in_flag),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.rules),TRIM((SALT30.StrType)le.npa),TRIM((SALT30.StrType)le.phone7),TRIM((SALT30.StrType)le.cellphone),TRIM((SALT30.StrType)le.cellphoneidkey),TRIM((SALT30.StrType)le.phone7_did_key),TRIM((SALT30.StrType)le.pdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.datevendorlastreported),TRIM((SALT30.StrType)le.datevendorfirstreported),TRIM((SALT30.StrType)le.dt_nonglb_last_seen),TRIM((SALT30.StrType)le.glb_dppa_flag),TRIM((SALT30.StrType)le.glb_dppa_all),TRIM((SALT30.StrType)le.vendor),TRIM((SALT30.StrType)le.src),TRIM((SALT30.StrType)le.src_all),TRIM((SALT30.StrType)le.src_cnt),TRIM((SALT30.StrType)le.src_rule),TRIM((SALT30.StrType)le.append_avg_source_conf),TRIM((SALT30.StrType)le.append_max_source_conf),TRIM((SALT30.StrType)le.append_min_source_conf),TRIM((SALT30.StrType)le.append_total_source_conf),TRIM((SALT30.StrType)le.orig_dt_last_seen),TRIM((SALT30.StrType)le.did_type),TRIM((SALT30.StrType)le.origname),TRIM((SALT30.StrType)le.address1),TRIM((SALT30.StrType)le.address2),TRIM((SALT30.StrType)le.address3),TRIM((SALT30.StrType)le.origcity),TRIM((SALT30.StrType)le.origstate),TRIM((SALT30.StrType)le.origzip),TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.agegroup),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.orig_listing_type),TRIM((SALT30.StrType)le.listingtype),TRIM((SALT30.StrType)le.orig_publish_code),TRIM((SALT30.StrType)le.orig_phone_type),TRIM((SALT30.StrType)le.orig_phone_usage),TRIM((SALT30.StrType)le.company),TRIM((SALT30.StrType)le.orig_phone_reg_dt),TRIM((SALT30.StrType)le.orig_carrier_code),TRIM((SALT30.StrType)le.orig_carrier_name),TRIM((SALT30.StrType)le.orig_conf_score),TRIM((SALT30.StrType)le.orig_rec_type),TRIM((SALT30.StrType)le.clean_company),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.ace_fips_st),TRIM((SALT30.StrType)le.ace_fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.append_npa_effective_dt),TRIM((SALT30.StrType)le.append_npa_last_change_dt),TRIM((SALT30.StrType)le.append_dialable_ind),TRIM((SALT30.StrType)le.append_place_name),TRIM((SALT30.StrType)le.append_portability_indicator),TRIM((SALT30.StrType)le.append_prior_area_code),TRIM((SALT30.StrType)le.append_nonpublished_match),TRIM((SALT30.StrType)le.append_ocn),TRIM((SALT30.StrType)le.append_time_zone),TRIM((SALT30.StrType)le.append_nxx_type),TRIM((SALT30.StrType)le.append_coctype),TRIM((SALT30.StrType)le.append_scc),TRIM((SALT30.StrType)le.append_phone_type),TRIM((SALT30.StrType)le.append_company_type),TRIM((SALT30.StrType)le.append_phone_use),TRIM((SALT30.StrType)le.agreg_listing_type),TRIM((SALT30.StrType)le.max_orig_conf_score),TRIM((SALT30.StrType)le.min_orig_conf_score),TRIM((SALT30.StrType)le.cur_orig_conf_score),TRIM((SALT30.StrType)le.activeflag),TRIM((SALT30.StrType)le.eda_active_flag),TRIM((SALT30.StrType)le.eda_match),TRIM((SALT30.StrType)le.eda_phone_dt),TRIM((SALT30.StrType)le.eda_did_dt),TRIM((SALT30.StrType)le.eda_nm_addr_dt),TRIM((SALT30.StrType)le.eda_hist_match),TRIM((SALT30.StrType)le.eda_hist_phone_dt),TRIM((SALT30.StrType)le.eda_hist_did_dt),TRIM((SALT30.StrType)le.eda_hist_nm_addr_dt),TRIM((SALT30.StrType)le.append_feedback_phone),TRIM((SALT30.StrType)le.append_feedback_phone_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_did),TRIM((SALT30.StrType)le.append_feedback_phone7_did_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr_dt),TRIM((SALT30.StrType)le.append_ported_match),TRIM((SALT30.StrType)le.append_seen_once_ind),TRIM((SALT30.StrType)le.append_indiv_phone_cnt),TRIM((SALT30.StrType)le.append_indiv_has_active_eda_phone_flag),TRIM((SALT30.StrType)le.append_latest_phone_owner_flag),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.hhid_score),TRIM((SALT30.StrType)le.phone7_hhid_key),TRIM((SALT30.StrType)le.append_best_addr_match_flag),TRIM((SALT30.StrType)le.append_best_nm_match_flag),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.cleanaid),TRIM((SALT30.StrType)le.current_rec),TRIM((SALT30.StrType)le.first_build_date),TRIM((SALT30.StrType)le.last_build_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.in_flag),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.rules),TRIM((SALT30.StrType)le.npa),TRIM((SALT30.StrType)le.phone7),TRIM((SALT30.StrType)le.cellphone),TRIM((SALT30.StrType)le.cellphoneidkey),TRIM((SALT30.StrType)le.phone7_did_key),TRIM((SALT30.StrType)le.pdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.datevendorlastreported),TRIM((SALT30.StrType)le.datevendorfirstreported),TRIM((SALT30.StrType)le.dt_nonglb_last_seen),TRIM((SALT30.StrType)le.glb_dppa_flag),TRIM((SALT30.StrType)le.glb_dppa_all),TRIM((SALT30.StrType)le.vendor),TRIM((SALT30.StrType)le.src),TRIM((SALT30.StrType)le.src_all),TRIM((SALT30.StrType)le.src_cnt),TRIM((SALT30.StrType)le.src_rule),TRIM((SALT30.StrType)le.append_avg_source_conf),TRIM((SALT30.StrType)le.append_max_source_conf),TRIM((SALT30.StrType)le.append_min_source_conf),TRIM((SALT30.StrType)le.append_total_source_conf),TRIM((SALT30.StrType)le.orig_dt_last_seen),TRIM((SALT30.StrType)le.did_type),TRIM((SALT30.StrType)le.origname),TRIM((SALT30.StrType)le.address1),TRIM((SALT30.StrType)le.address2),TRIM((SALT30.StrType)le.address3),TRIM((SALT30.StrType)le.origcity),TRIM((SALT30.StrType)le.origstate),TRIM((SALT30.StrType)le.origzip),TRIM((SALT30.StrType)le.orig_phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.agegroup),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.orig_listing_type),TRIM((SALT30.StrType)le.listingtype),TRIM((SALT30.StrType)le.orig_publish_code),TRIM((SALT30.StrType)le.orig_phone_type),TRIM((SALT30.StrType)le.orig_phone_usage),TRIM((SALT30.StrType)le.company),TRIM((SALT30.StrType)le.orig_phone_reg_dt),TRIM((SALT30.StrType)le.orig_carrier_code),TRIM((SALT30.StrType)le.orig_carrier_name),TRIM((SALT30.StrType)le.orig_conf_score),TRIM((SALT30.StrType)le.orig_rec_type),TRIM((SALT30.StrType)le.clean_company),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.ace_fips_st),TRIM((SALT30.StrType)le.ace_fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.append_npa_effective_dt),TRIM((SALT30.StrType)le.append_npa_last_change_dt),TRIM((SALT30.StrType)le.append_dialable_ind),TRIM((SALT30.StrType)le.append_place_name),TRIM((SALT30.StrType)le.append_portability_indicator),TRIM((SALT30.StrType)le.append_prior_area_code),TRIM((SALT30.StrType)le.append_nonpublished_match),TRIM((SALT30.StrType)le.append_ocn),TRIM((SALT30.StrType)le.append_time_zone),TRIM((SALT30.StrType)le.append_nxx_type),TRIM((SALT30.StrType)le.append_coctype),TRIM((SALT30.StrType)le.append_scc),TRIM((SALT30.StrType)le.append_phone_type),TRIM((SALT30.StrType)le.append_company_type),TRIM((SALT30.StrType)le.append_phone_use),TRIM((SALT30.StrType)le.agreg_listing_type),TRIM((SALT30.StrType)le.max_orig_conf_score),TRIM((SALT30.StrType)le.min_orig_conf_score),TRIM((SALT30.StrType)le.cur_orig_conf_score),TRIM((SALT30.StrType)le.activeflag),TRIM((SALT30.StrType)le.eda_active_flag),TRIM((SALT30.StrType)le.eda_match),TRIM((SALT30.StrType)le.eda_phone_dt),TRIM((SALT30.StrType)le.eda_did_dt),TRIM((SALT30.StrType)le.eda_nm_addr_dt),TRIM((SALT30.StrType)le.eda_hist_match),TRIM((SALT30.StrType)le.eda_hist_phone_dt),TRIM((SALT30.StrType)le.eda_hist_did_dt),TRIM((SALT30.StrType)le.eda_hist_nm_addr_dt),TRIM((SALT30.StrType)le.append_feedback_phone),TRIM((SALT30.StrType)le.append_feedback_phone_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_did),TRIM((SALT30.StrType)le.append_feedback_phone7_did_dt),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr),TRIM((SALT30.StrType)le.append_feedback_phone7_nm_addr_dt),TRIM((SALT30.StrType)le.append_ported_match),TRIM((SALT30.StrType)le.append_seen_once_ind),TRIM((SALT30.StrType)le.append_indiv_phone_cnt),TRIM((SALT30.StrType)le.append_indiv_has_active_eda_phone_flag),TRIM((SALT30.StrType)le.append_latest_phone_owner_flag),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.hhid_score),TRIM((SALT30.StrType)le.phone7_hhid_key),TRIM((SALT30.StrType)le.append_best_addr_match_flag),TRIM((SALT30.StrType)le.append_best_nm_match_flag),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.cleanaid),TRIM((SALT30.StrType)le.current_rec),TRIM((SALT30.StrType)le.first_build_date),TRIM((SALT30.StrType)le.last_build_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),138*138,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'in_flag'}
      ,{2,'confidencescore'}
      ,{3,'rules'}
      ,{4,'npa'}
      ,{5,'phone7'}
      ,{6,'cellphone'}
      ,{7,'cellphoneidkey'}
      ,{8,'phone7_did_key'}
      ,{9,'pdid'}
      ,{10,'did'}
      ,{11,'did_score'}
      ,{12,'datefirstseen'}
      ,{13,'datelastseen'}
      ,{14,'datevendorlastreported'}
      ,{15,'datevendorfirstreported'}
      ,{16,'dt_nonglb_last_seen'}
      ,{17,'glb_dppa_flag'}
      ,{18,'glb_dppa_all'}
      ,{19,'vendor'}
      ,{20,'src'}
      ,{21,'src_all'}
      ,{22,'src_cnt'}
      ,{23,'src_rule'}
      ,{24,'append_avg_source_conf'}
      ,{25,'append_max_source_conf'}
      ,{26,'append_min_source_conf'}
      ,{27,'append_total_source_conf'}
      ,{28,'orig_dt_last_seen'}
      ,{29,'did_type'}
      ,{30,'origname'}
      ,{31,'address1'}
      ,{32,'address2'}
      ,{33,'address3'}
      ,{34,'origcity'}
      ,{35,'origstate'}
      ,{36,'origzip'}
      ,{37,'orig_phone'}
      ,{38,'dob'}
      ,{39,'agegroup'}
      ,{40,'gender'}
      ,{41,'email'}
      ,{42,'orig_listing_type'}
      ,{43,'listingtype'}
      ,{44,'orig_publish_code'}
      ,{45,'orig_phone_type'}
      ,{46,'orig_phone_usage'}
      ,{47,'company'}
      ,{48,'orig_phone_reg_dt'}
      ,{49,'orig_carrier_code'}
      ,{50,'orig_carrier_name'}
      ,{51,'orig_conf_score'}
      ,{52,'orig_rec_type'}
      ,{53,'clean_company'}
      ,{54,'prim_range'}
      ,{55,'predir'}
      ,{56,'prim_name'}
      ,{57,'addr_suffix'}
      ,{58,'postdir'}
      ,{59,'unit_desig'}
      ,{60,'sec_range'}
      ,{61,'p_city_name'}
      ,{62,'v_city_name'}
      ,{63,'state'}
      ,{64,'zip5'}
      ,{65,'zip4'}
      ,{66,'cart'}
      ,{67,'cr_sort_sz'}
      ,{68,'lot'}
      ,{69,'lot_order'}
      ,{70,'dpbc'}
      ,{71,'chk_digit'}
      ,{72,'rec_type'}
      ,{73,'ace_fips_st'}
      ,{74,'ace_fips_county'}
      ,{75,'geo_lat'}
      ,{76,'geo_long'}
      ,{77,'msa'}
      ,{78,'geo_blk'}
      ,{79,'geo_match'}
      ,{80,'err_stat'}
      ,{81,'title'}
      ,{82,'fname'}
      ,{83,'mname'}
      ,{84,'lname'}
      ,{85,'name_suffix'}
      ,{86,'name_score'}
      ,{87,'bdid'}
      ,{88,'bdid_score'}
      ,{89,'append_npa_effective_dt'}
      ,{90,'append_npa_last_change_dt'}
      ,{91,'append_dialable_ind'}
      ,{92,'append_place_name'}
      ,{93,'append_portability_indicator'}
      ,{94,'append_prior_area_code'}
      ,{95,'append_nonpublished_match'}
      ,{96,'append_ocn'}
      ,{97,'append_time_zone'}
      ,{98,'append_nxx_type'}
      ,{99,'append_coctype'}
      ,{100,'append_scc'}
      ,{101,'append_phone_type'}
      ,{102,'append_company_type'}
      ,{103,'append_phone_use'}
      ,{104,'agreg_listing_type'}
      ,{105,'max_orig_conf_score'}
      ,{106,'min_orig_conf_score'}
      ,{107,'cur_orig_conf_score'}
      ,{108,'activeflag'}
      ,{109,'eda_active_flag'}
      ,{110,'eda_match'}
      ,{111,'eda_phone_dt'}
      ,{112,'eda_did_dt'}
      ,{113,'eda_nm_addr_dt'}
      ,{114,'eda_hist_match'}
      ,{115,'eda_hist_phone_dt'}
      ,{116,'eda_hist_did_dt'}
      ,{117,'eda_hist_nm_addr_dt'}
      ,{118,'append_feedback_phone'}
      ,{119,'append_feedback_phone_dt'}
      ,{120,'append_feedback_phone7_did'}
      ,{121,'append_feedback_phone7_did_dt'}
      ,{122,'append_feedback_phone7_nm_addr'}
      ,{123,'append_feedback_phone7_nm_addr_dt'}
      ,{124,'append_ported_match'}
      ,{125,'append_seen_once_ind'}
      ,{126,'append_indiv_phone_cnt'}
      ,{127,'append_indiv_has_active_eda_phone_flag'}
      ,{128,'append_latest_phone_owner_flag'}
      ,{129,'hhid'}
      ,{130,'hhid_score'}
      ,{131,'phone7_hhid_key'}
      ,{132,'append_best_addr_match_flag'}
      ,{133,'append_best_nm_match_flag'}
      ,{134,'rawaid'}
      ,{135,'cleanaid'}
      ,{136,'current_rec'}
      ,{137,'first_build_date'}
      ,{138,'last_build_date'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_in_flag((SALT30.StrType)le.in_flag),
    Fields.InValid_confidencescore((SALT30.StrType)le.confidencescore),
    Fields.InValid_rules((SALT30.StrType)le.rules),
    Fields.InValid_npa((SALT30.StrType)le.npa),
    Fields.InValid_phone7((SALT30.StrType)le.phone7),
    Fields.InValid_cellphone((SALT30.StrType)le.cellphone),
    Fields.InValid_cellphoneidkey((SALT30.StrType)le.cellphoneidkey),
    Fields.InValid_phone7_did_key((SALT30.StrType)le.phone7_did_key),
    Fields.InValid_pdid((SALT30.StrType)le.pdid),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_did_score((SALT30.StrType)le.did_score),
    Fields.InValid_datefirstseen((SALT30.StrType)le.datefirstseen),
    Fields.InValid_datelastseen((SALT30.StrType)le.datelastseen),
    Fields.InValid_datevendorlastreported((SALT30.StrType)le.datevendorlastreported),
    Fields.InValid_datevendorfirstreported((SALT30.StrType)le.datevendorfirstreported),
    Fields.InValid_dt_nonglb_last_seen((SALT30.StrType)le.dt_nonglb_last_seen),
    Fields.InValid_glb_dppa_flag((SALT30.StrType)le.glb_dppa_flag),
    Fields.InValid_glb_dppa_all((SALT30.StrType)le.glb_dppa_all),
    Fields.InValid_vendor((SALT30.StrType)le.vendor),
    Fields.InValid_src((SALT30.StrType)le.src),
    Fields.InValid_src_all((SALT30.StrType)le.src_all),
    Fields.InValid_src_cnt((SALT30.StrType)le.src_cnt),
    Fields.InValid_src_rule((SALT30.StrType)le.src_rule),
    Fields.InValid_append_avg_source_conf((SALT30.StrType)le.append_avg_source_conf),
    Fields.InValid_append_max_source_conf((SALT30.StrType)le.append_max_source_conf),
    Fields.InValid_append_min_source_conf((SALT30.StrType)le.append_min_source_conf),
    Fields.InValid_append_total_source_conf((SALT30.StrType)le.append_total_source_conf),
    Fields.InValid_orig_dt_last_seen((SALT30.StrType)le.orig_dt_last_seen),
    Fields.InValid_did_type((SALT30.StrType)le.did_type),
    Fields.InValid_origname((SALT30.StrType)le.origname),
    Fields.InValid_address1((SALT30.StrType)le.address1),
    Fields.InValid_address2((SALT30.StrType)le.address2),
    Fields.InValid_address3((SALT30.StrType)le.address3),
    Fields.InValid_origcity((SALT30.StrType)le.origcity),
    Fields.InValid_origstate((SALT30.StrType)le.origstate),
    Fields.InValid_origzip((SALT30.StrType)le.origzip),
    Fields.InValid_orig_phone((SALT30.StrType)le.orig_phone),
    Fields.InValid_dob((SALT30.StrType)le.dob),
    Fields.InValid_agegroup((SALT30.StrType)le.agegroup),
    Fields.InValid_gender((SALT30.StrType)le.gender),
    Fields.InValid_email((SALT30.StrType)le.email),
    Fields.InValid_orig_listing_type((SALT30.StrType)le.orig_listing_type),
    Fields.InValid_listingtype((SALT30.StrType)le.listingtype),
    Fields.InValid_orig_publish_code((SALT30.StrType)le.orig_publish_code),
    Fields.InValid_orig_phone_type((SALT30.StrType)le.orig_phone_type),
    Fields.InValid_orig_phone_usage((SALT30.StrType)le.orig_phone_usage),
    Fields.InValid_company((SALT30.StrType)le.company),
    Fields.InValid_orig_phone_reg_dt((SALT30.StrType)le.orig_phone_reg_dt),
    Fields.InValid_orig_carrier_code((SALT30.StrType)le.orig_carrier_code),
    Fields.InValid_orig_carrier_name((SALT30.StrType)le.orig_carrier_name),
    Fields.InValid_orig_conf_score((SALT30.StrType)le.orig_conf_score),
    Fields.InValid_orig_rec_type((SALT30.StrType)le.orig_rec_type),
    Fields.InValid_clean_company((SALT30.StrType)le.clean_company),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_zip5((SALT30.StrType)le.zip5),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT30.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT30.StrType)le.ace_fips_st),
    Fields.InValid_ace_fips_county((SALT30.StrType)le.ace_fips_county),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_bdid_score((SALT30.StrType)le.bdid_score),
    Fields.InValid_append_npa_effective_dt((SALT30.StrType)le.append_npa_effective_dt),
    Fields.InValid_append_npa_last_change_dt((SALT30.StrType)le.append_npa_last_change_dt),
    Fields.InValid_append_dialable_ind((SALT30.StrType)le.append_dialable_ind),
    Fields.InValid_append_place_name((SALT30.StrType)le.append_place_name),
    Fields.InValid_append_portability_indicator((SALT30.StrType)le.append_portability_indicator),
    Fields.InValid_append_prior_area_code((SALT30.StrType)le.append_prior_area_code),
    Fields.InValid_append_nonpublished_match((SALT30.StrType)le.append_nonpublished_match),
    Fields.InValid_append_ocn((SALT30.StrType)le.append_ocn),
    Fields.InValid_append_time_zone((SALT30.StrType)le.append_time_zone),
    Fields.InValid_append_nxx_type((SALT30.StrType)le.append_nxx_type),
    Fields.InValid_append_coctype((SALT30.StrType)le.append_coctype),
    Fields.InValid_append_scc((SALT30.StrType)le.append_scc),
    Fields.InValid_append_phone_type((SALT30.StrType)le.append_phone_type),
    Fields.InValid_append_company_type((SALT30.StrType)le.append_company_type),
    Fields.InValid_append_phone_use((SALT30.StrType)le.append_phone_use),
    Fields.InValid_agreg_listing_type((SALT30.StrType)le.agreg_listing_type),
    Fields.InValid_max_orig_conf_score((SALT30.StrType)le.max_orig_conf_score),
    Fields.InValid_min_orig_conf_score((SALT30.StrType)le.min_orig_conf_score),
    Fields.InValid_cur_orig_conf_score((SALT30.StrType)le.cur_orig_conf_score),
    Fields.InValid_activeflag((SALT30.StrType)le.activeflag),
    Fields.InValid_eda_active_flag((SALT30.StrType)le.eda_active_flag),
    Fields.InValid_eda_match((SALT30.StrType)le.eda_match),
    Fields.InValid_eda_phone_dt((SALT30.StrType)le.eda_phone_dt),
    Fields.InValid_eda_did_dt((SALT30.StrType)le.eda_did_dt),
    Fields.InValid_eda_nm_addr_dt((SALT30.StrType)le.eda_nm_addr_dt),
    Fields.InValid_eda_hist_match((SALT30.StrType)le.eda_hist_match),
    Fields.InValid_eda_hist_phone_dt((SALT30.StrType)le.eda_hist_phone_dt),
    Fields.InValid_eda_hist_did_dt((SALT30.StrType)le.eda_hist_did_dt),
    Fields.InValid_eda_hist_nm_addr_dt((SALT30.StrType)le.eda_hist_nm_addr_dt),
    Fields.InValid_append_feedback_phone((SALT30.StrType)le.append_feedback_phone),
    Fields.InValid_append_feedback_phone_dt((SALT30.StrType)le.append_feedback_phone_dt),
    Fields.InValid_append_feedback_phone7_did((SALT30.StrType)le.append_feedback_phone7_did),
    Fields.InValid_append_feedback_phone7_did_dt((SALT30.StrType)le.append_feedback_phone7_did_dt),
    Fields.InValid_append_feedback_phone7_nm_addr((SALT30.StrType)le.append_feedback_phone7_nm_addr),
    Fields.InValid_append_feedback_phone7_nm_addr_dt((SALT30.StrType)le.append_feedback_phone7_nm_addr_dt),
    Fields.InValid_append_ported_match((SALT30.StrType)le.append_ported_match),
    Fields.InValid_append_seen_once_ind((SALT30.StrType)le.append_seen_once_ind),
    Fields.InValid_append_indiv_phone_cnt((SALT30.StrType)le.append_indiv_phone_cnt),
    Fields.InValid_append_indiv_has_active_eda_phone_flag((SALT30.StrType)le.append_indiv_has_active_eda_phone_flag),
    Fields.InValid_append_latest_phone_owner_flag((SALT30.StrType)le.append_latest_phone_owner_flag),
    Fields.InValid_hhid((SALT30.StrType)le.hhid),
    Fields.InValid_hhid_score((SALT30.StrType)le.hhid_score),
    Fields.InValid_phone7_hhid_key((SALT30.StrType)le.phone7_hhid_key),
    Fields.InValid_append_best_addr_match_flag((SALT30.StrType)le.append_best_addr_match_flag),
    Fields.InValid_append_best_nm_match_flag((SALT30.StrType)le.append_best_nm_match_flag),
    Fields.InValid_rawaid((SALT30.StrType)le.rawaid),
    Fields.InValid_cleanaid((SALT30.StrType)le.cleanaid),
    Fields.InValid_current_rec((SALT30.StrType)le.current_rec),
    Fields.InValid_first_build_date((SALT30.StrType)le.first_build_date),
    Fields.InValid_last_build_date((SALT30.StrType)le.last_build_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,138,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','npa','phone','phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','alpha','Unknown','Unknown','Unknown','Unknown','Unknown','zip','phone','date','Unknown','sex','Unknown','Listing_type','Unknown','Unknown','phone_type','phone_Usage','Comp_name','date_alt','Unknown','Comp_name','conf_score','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','date','date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_in_flag(TotalErrors.ErrorNum),Fields.InValidMessage_confidencescore(TotalErrors.ErrorNum),Fields.InValidMessage_rules(TotalErrors.ErrorNum),Fields.InValidMessage_npa(TotalErrors.ErrorNum),Fields.InValidMessage_phone7(TotalErrors.ErrorNum),Fields.InValidMessage_cellphone(TotalErrors.ErrorNum),Fields.InValidMessage_cellphoneidkey(TotalErrors.ErrorNum),Fields.InValidMessage_phone7_did_key(TotalErrors.ErrorNum),Fields.InValidMessage_pdid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_datefirstseen(TotalErrors.ErrorNum),Fields.InValidMessage_datelastseen(TotalErrors.ErrorNum),Fields.InValidMessage_datevendorlastreported(TotalErrors.ErrorNum),Fields.InValidMessage_datevendorfirstreported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_nonglb_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_glb_dppa_flag(TotalErrors.ErrorNum),Fields.InValidMessage_glb_dppa_all(TotalErrors.ErrorNum),Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_src_all(TotalErrors.ErrorNum),Fields.InValidMessage_src_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_src_rule(TotalErrors.ErrorNum),Fields.InValidMessage_append_avg_source_conf(TotalErrors.ErrorNum),Fields.InValidMessage_append_max_source_conf(TotalErrors.ErrorNum),Fields.InValidMessage_append_min_source_conf(TotalErrors.ErrorNum),Fields.InValidMessage_append_total_source_conf(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_did_type(TotalErrors.ErrorNum),Fields.InValidMessage_origname(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_address3(TotalErrors.ErrorNum),Fields.InValidMessage_origcity(TotalErrors.ErrorNum),Fields.InValidMessage_origstate(TotalErrors.ErrorNum),Fields.InValidMessage_origzip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_agegroup(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_listing_type(TotalErrors.ErrorNum),Fields.InValidMessage_listingtype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_publish_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone_usage(TotalErrors.ErrorNum),Fields.InValidMessage_company(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone_reg_dt(TotalErrors.ErrorNum),Fields.InValidMessage_orig_carrier_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_carrier_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_conf_score(TotalErrors.ErrorNum),Fields.InValidMessage_orig_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_company(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Fields.InValidMessage_append_npa_effective_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_npa_last_change_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_dialable_ind(TotalErrors.ErrorNum),Fields.InValidMessage_append_place_name(TotalErrors.ErrorNum),Fields.InValidMessage_append_portability_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_append_prior_area_code(TotalErrors.ErrorNum),Fields.InValidMessage_append_nonpublished_match(TotalErrors.ErrorNum),Fields.InValidMessage_append_ocn(TotalErrors.ErrorNum),Fields.InValidMessage_append_time_zone(TotalErrors.ErrorNum),Fields.InValidMessage_append_nxx_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_coctype(TotalErrors.ErrorNum),Fields.InValidMessage_append_scc(TotalErrors.ErrorNum),Fields.InValidMessage_append_phone_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_company_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_phone_use(TotalErrors.ErrorNum),Fields.InValidMessage_agreg_listing_type(TotalErrors.ErrorNum),Fields.InValidMessage_max_orig_conf_score(TotalErrors.ErrorNum),Fields.InValidMessage_min_orig_conf_score(TotalErrors.ErrorNum),Fields.InValidMessage_cur_orig_conf_score(TotalErrors.ErrorNum),Fields.InValidMessage_activeflag(TotalErrors.ErrorNum),Fields.InValidMessage_eda_active_flag(TotalErrors.ErrorNum),Fields.InValidMessage_eda_match(TotalErrors.ErrorNum),Fields.InValidMessage_eda_phone_dt(TotalErrors.ErrorNum),Fields.InValidMessage_eda_did_dt(TotalErrors.ErrorNum),Fields.InValidMessage_eda_nm_addr_dt(TotalErrors.ErrorNum),Fields.InValidMessage_eda_hist_match(TotalErrors.ErrorNum),Fields.InValidMessage_eda_hist_phone_dt(TotalErrors.ErrorNum),Fields.InValidMessage_eda_hist_did_dt(TotalErrors.ErrorNum),Fields.InValidMessage_eda_hist_nm_addr_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone7_did(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone7_did_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone7_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_append_feedback_phone7_nm_addr_dt(TotalErrors.ErrorNum),Fields.InValidMessage_append_ported_match(TotalErrors.ErrorNum),Fields.InValidMessage_append_seen_once_ind(TotalErrors.ErrorNum),Fields.InValidMessage_append_indiv_phone_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_append_indiv_has_active_eda_phone_flag(TotalErrors.ErrorNum),Fields.InValidMessage_append_latest_phone_owner_flag(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_hhid_score(TotalErrors.ErrorNum),Fields.InValidMessage_phone7_hhid_key(TotalErrors.ErrorNum),Fields.InValidMessage_append_best_addr_match_flag(TotalErrors.ErrorNum),Fields.InValidMessage_append_best_nm_match_flag(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_cleanaid(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum),Fields.InValidMessage_first_build_date(TotalErrors.ErrorNum),Fields.InValidMessage_last_build_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
