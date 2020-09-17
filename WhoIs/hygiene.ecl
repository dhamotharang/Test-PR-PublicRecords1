IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_WhoIs) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
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
    populated_clean_cname_cnt := COUNT(GROUP,h.clean_cname <> (TYPEOF(h.clean_cname))'');
    populated_clean_cname_pcnt := AVE(GROUP,IF(h.clean_cname = (TYPEOF(h.clean_cname))'',0,100));
    maxlength_clean_cname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_cname)));
    avelength_clean_cname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_cname)),h.clean_cname<>(typeof(h.clean_cname))'');
    populated_current_rec_cnt := COUNT(GROUP,h.current_rec <> (TYPEOF(h.current_rec))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
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
    populated_clean_title_cnt := COUNT(GROUP,h.clean_title <> (TYPEOF(h.clean_title))'');
    populated_clean_title_pcnt := AVE(GROUP,IF(h.clean_title = (TYPEOF(h.clean_title))'',0,100));
    maxlength_clean_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_title)));
    avelength_clean_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_title)),h.clean_title<>(typeof(h.clean_title))'');
    populated_clean_fname_cnt := COUNT(GROUP,h.clean_fname <> (TYPEOF(h.clean_fname))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_cnt := COUNT(GROUP,h.clean_mname <> (TYPEOF(h.clean_mname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_cnt := COUNT(GROUP,h.clean_lname <> (TYPEOF(h.clean_lname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
    populated_clean_name_suffix_cnt := COUNT(GROUP,h.clean_name_suffix <> (TYPEOF(h.clean_name_suffix))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_cnt := COUNT(GROUP,h.clean_name_score <> (TYPEOF(h.clean_name_score))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_append_prep_address_situs_cnt := COUNT(GROUP,h.append_prep_address_situs <> (TYPEOF(h.append_prep_address_situs))'');
    populated_append_prep_address_situs_pcnt := AVE(GROUP,IF(h.append_prep_address_situs = (TYPEOF(h.append_prep_address_situs))'',0,100));
    maxlength_append_prep_address_situs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_situs)));
    avelength_append_prep_address_situs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_situs)),h.append_prep_address_situs<>(typeof(h.append_prep_address_situs))'');
    populated_append_prep_address_last_situs_cnt := COUNT(GROUP,h.append_prep_address_last_situs <> (TYPEOF(h.append_prep_address_last_situs))'');
    populated_append_prep_address_last_situs_pcnt := AVE(GROUP,IF(h.append_prep_address_last_situs = (TYPEOF(h.append_prep_address_last_situs))'',0,100));
    maxlength_append_prep_address_last_situs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_last_situs)));
    avelength_append_prep_address_last_situs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_last_situs)),h.append_prep_address_last_situs<>(typeof(h.append_prep_address_last_situs))'');
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
    populated_emailtype_cnt := COUNT(GROUP,h.emailtype <> (TYPEOF(h.emailtype))'');
    populated_emailtype_pcnt := AVE(GROUP,IF(h.emailtype = (TYPEOF(h.emailtype))'',0,100));
    maxlength_emailtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailtype)));
    avelength_emailtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailtype)),h.emailtype<>(typeof(h.emailtype))'');
    populated_rawtext_cnt := COUNT(GROUP,h.rawtext <> (TYPEOF(h.rawtext))'');
    populated_rawtext_pcnt := AVE(GROUP,IF(h.rawtext = (TYPEOF(h.rawtext))'',0,100));
    maxlength_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawtext)));
    avelength_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawtext)),h.rawtext<>(typeof(h.rawtext))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_organization_cnt := COUNT(GROUP,h.organization <> (TYPEOF(h.organization))'');
    populated_organization_pcnt := AVE(GROUP,IF(h.organization = (TYPEOF(h.organization))'',0,100));
    maxlength_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.organization)));
    avelength_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.organization)),h.organization<>(typeof(h.organization))'');
    populated_street1_cnt := COUNT(GROUP,h.street1 <> (TYPEOF(h.street1))'');
    populated_street1_pcnt := AVE(GROUP,IF(h.street1 = (TYPEOF(h.street1))'',0,100));
    maxlength_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street1)));
    avelength_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street1)),h.street1<>(typeof(h.street1))'');
    populated_street2_cnt := COUNT(GROUP,h.street2 <> (TYPEOF(h.street2))'');
    populated_street2_pcnt := AVE(GROUP,IF(h.street2 = (TYPEOF(h.street2))'',0,100));
    maxlength_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street2)));
    avelength_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street2)),h.street2<>(typeof(h.street2))'');
    populated_street3_cnt := COUNT(GROUP,h.street3 <> (TYPEOF(h.street3))'');
    populated_street3_pcnt := AVE(GROUP,IF(h.street3 = (TYPEOF(h.street3))'',0,100));
    maxlength_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street3)));
    avelength_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street3)),h.street3<>(typeof(h.street3))'');
    populated_street4_cnt := COUNT(GROUP,h.street4 <> (TYPEOF(h.street4))'');
    populated_street4_pcnt := AVE(GROUP,IF(h.street4 = (TYPEOF(h.street4))'',0,100));
    maxlength_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street4)));
    avelength_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street4)),h.street4<>(typeof(h.street4))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_postalcode_cnt := COUNT(GROUP,h.postalcode <> (TYPEOF(h.postalcode))'');
    populated_postalcode_pcnt := AVE(GROUP,IF(h.postalcode = (TYPEOF(h.postalcode))'',0,100));
    maxlength_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postalcode)));
    avelength_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postalcode)),h.postalcode<>(typeof(h.postalcode))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_fax_cnt := COUNT(GROUP,h.fax <> (TYPEOF(h.fax))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_faxext_cnt := COUNT(GROUP,h.faxext <> (TYPEOF(h.faxext))'');
    populated_faxext_pcnt := AVE(GROUP,IF(h.faxext = (TYPEOF(h.faxext))'',0,100));
    maxlength_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxext)));
    avelength_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.faxext)),h.faxext<>(typeof(h.faxext))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phoneext_cnt := COUNT(GROUP,h.phoneext <> (TYPEOF(h.phoneext))'');
    populated_phoneext_pcnt := AVE(GROUP,IF(h.phoneext = (TYPEOF(h.phoneext))'',0,100));
    maxlength_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phoneext)));
    avelength_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phoneext)),h.phoneext<>(typeof(h.phoneext))'');
    populated_domainname_cnt := COUNT(GROUP,h.domainname <> (TYPEOF(h.domainname))'');
    populated_domainname_pcnt := AVE(GROUP,IF(h.domainname = (TYPEOF(h.domainname))'',0,100));
    maxlength_domainname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.domainname)));
    avelength_domainname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.domainname)),h.domainname<>(typeof(h.domainname))'');
    populated_registrarname_cnt := COUNT(GROUP,h.registrarname <> (TYPEOF(h.registrarname))'');
    populated_registrarname_pcnt := AVE(GROUP,IF(h.registrarname = (TYPEOF(h.registrarname))'',0,100));
    maxlength_registrarname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrarname)));
    avelength_registrarname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrarname)),h.registrarname<>(typeof(h.registrarname))'');
    populated_contactemail_cnt := COUNT(GROUP,h.contactemail <> (TYPEOF(h.contactemail))'');
    populated_contactemail_pcnt := AVE(GROUP,IF(h.contactemail = (TYPEOF(h.contactemail))'',0,100));
    maxlength_contactemail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactemail)));
    avelength_contactemail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contactemail)),h.contactemail<>(typeof(h.contactemail))'');
    populated_whoisserver_cnt := COUNT(GROUP,h.whoisserver <> (TYPEOF(h.whoisserver))'');
    populated_whoisserver_pcnt := AVE(GROUP,IF(h.whoisserver = (TYPEOF(h.whoisserver))'',0,100));
    maxlength_whoisserver := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.whoisserver)));
    avelength_whoisserver := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.whoisserver)),h.whoisserver<>(typeof(h.whoisserver))'');
    populated_nameservers_cnt := COUNT(GROUP,h.nameservers <> (TYPEOF(h.nameservers))'');
    populated_nameservers_pcnt := AVE(GROUP,IF(h.nameservers = (TYPEOF(h.nameservers))'',0,100));
    maxlength_nameservers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nameservers)));
    avelength_nameservers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nameservers)),h.nameservers<>(typeof(h.nameservers))'');
    populated_createddate_cnt := COUNT(GROUP,h.createddate <> (TYPEOF(h.createddate))'');
    populated_createddate_pcnt := AVE(GROUP,IF(h.createddate = (TYPEOF(h.createddate))'',0,100));
    maxlength_createddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.createddate)));
    avelength_createddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.createddate)),h.createddate<>(typeof(h.createddate))'');
    populated_updateddate_cnt := COUNT(GROUP,h.updateddate <> (TYPEOF(h.updateddate))'');
    populated_updateddate_pcnt := AVE(GROUP,IF(h.updateddate = (TYPEOF(h.updateddate))'',0,100));
    maxlength_updateddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.updateddate)));
    avelength_updateddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.updateddate)),h.updateddate<>(typeof(h.updateddate))'');
    populated_expiresdate_cnt := COUNT(GROUP,h.expiresdate <> (TYPEOF(h.expiresdate))'');
    populated_expiresdate_pcnt := AVE(GROUP,IF(h.expiresdate = (TYPEOF(h.expiresdate))'',0,100));
    maxlength_expiresdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expiresdate)));
    avelength_expiresdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expiresdate)),h.expiresdate<>(typeof(h.expiresdate))'');
    populated_standardregcreateddate_cnt := COUNT(GROUP,h.standardregcreateddate <> (TYPEOF(h.standardregcreateddate))'');
    populated_standardregcreateddate_pcnt := AVE(GROUP,IF(h.standardregcreateddate = (TYPEOF(h.standardregcreateddate))'',0,100));
    maxlength_standardregcreateddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregcreateddate)));
    avelength_standardregcreateddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregcreateddate)),h.standardregcreateddate<>(typeof(h.standardregcreateddate))'');
    populated_standardregupdateddate_cnt := COUNT(GROUP,h.standardregupdateddate <> (TYPEOF(h.standardregupdateddate))'');
    populated_standardregupdateddate_pcnt := AVE(GROUP,IF(h.standardregupdateddate = (TYPEOF(h.standardregupdateddate))'',0,100));
    maxlength_standardregupdateddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregupdateddate)));
    avelength_standardregupdateddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregupdateddate)),h.standardregupdateddate<>(typeof(h.standardregupdateddate))'');
    populated_standardregexpiresdate_cnt := COUNT(GROUP,h.standardregexpiresdate <> (TYPEOF(h.standardregexpiresdate))'');
    populated_standardregexpiresdate_pcnt := AVE(GROUP,IF(h.standardregexpiresdate = (TYPEOF(h.standardregexpiresdate))'',0,100));
    maxlength_standardregexpiresdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregexpiresdate)));
    avelength_standardregexpiresdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardregexpiresdate)),h.standardregexpiresdate<>(typeof(h.standardregexpiresdate))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_audit_auditupdateddate_cnt := COUNT(GROUP,h.audit_auditupdateddate <> (TYPEOF(h.audit_auditupdateddate))'');
    populated_audit_auditupdateddate_pcnt := AVE(GROUP,IF(h.audit_auditupdateddate = (TYPEOF(h.audit_auditupdateddate))'',0,100));
    maxlength_audit_auditupdateddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.audit_auditupdateddate)));
    avelength_audit_auditupdateddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.audit_auditupdateddate)),h.audit_auditupdateddate<>(typeof(h.audit_auditupdateddate))'');
    populated_registrant_rawtext_cnt := COUNT(GROUP,h.registrant_rawtext <> (TYPEOF(h.registrant_rawtext))'');
    populated_registrant_rawtext_pcnt := AVE(GROUP,IF(h.registrant_rawtext = (TYPEOF(h.registrant_rawtext))'',0,100));
    maxlength_registrant_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_rawtext)));
    avelength_registrant_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_rawtext)),h.registrant_rawtext<>(typeof(h.registrant_rawtext))'');
    populated_registrant_email_cnt := COUNT(GROUP,h.registrant_email <> (TYPEOF(h.registrant_email))'');
    populated_registrant_email_pcnt := AVE(GROUP,IF(h.registrant_email = (TYPEOF(h.registrant_email))'',0,100));
    maxlength_registrant_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_email)));
    avelength_registrant_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_email)),h.registrant_email<>(typeof(h.registrant_email))'');
    populated_registrant_name_cnt := COUNT(GROUP,h.registrant_name <> (TYPEOF(h.registrant_name))'');
    populated_registrant_name_pcnt := AVE(GROUP,IF(h.registrant_name = (TYPEOF(h.registrant_name))'',0,100));
    maxlength_registrant_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_name)));
    avelength_registrant_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_name)),h.registrant_name<>(typeof(h.registrant_name))'');
    populated_registrant_organization_cnt := COUNT(GROUP,h.registrant_organization <> (TYPEOF(h.registrant_organization))'');
    populated_registrant_organization_pcnt := AVE(GROUP,IF(h.registrant_organization = (TYPEOF(h.registrant_organization))'',0,100));
    maxlength_registrant_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_organization)));
    avelength_registrant_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_organization)),h.registrant_organization<>(typeof(h.registrant_organization))'');
    populated_registrant_street1_cnt := COUNT(GROUP,h.registrant_street1 <> (TYPEOF(h.registrant_street1))'');
    populated_registrant_street1_pcnt := AVE(GROUP,IF(h.registrant_street1 = (TYPEOF(h.registrant_street1))'',0,100));
    maxlength_registrant_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street1)));
    avelength_registrant_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street1)),h.registrant_street1<>(typeof(h.registrant_street1))'');
    populated_registrant_street2_cnt := COUNT(GROUP,h.registrant_street2 <> (TYPEOF(h.registrant_street2))'');
    populated_registrant_street2_pcnt := AVE(GROUP,IF(h.registrant_street2 = (TYPEOF(h.registrant_street2))'',0,100));
    maxlength_registrant_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street2)));
    avelength_registrant_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street2)),h.registrant_street2<>(typeof(h.registrant_street2))'');
    populated_registrant_street3_cnt := COUNT(GROUP,h.registrant_street3 <> (TYPEOF(h.registrant_street3))'');
    populated_registrant_street3_pcnt := AVE(GROUP,IF(h.registrant_street3 = (TYPEOF(h.registrant_street3))'',0,100));
    maxlength_registrant_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street3)));
    avelength_registrant_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street3)),h.registrant_street3<>(typeof(h.registrant_street3))'');
    populated_registrant_street4_cnt := COUNT(GROUP,h.registrant_street4 <> (TYPEOF(h.registrant_street4))'');
    populated_registrant_street4_pcnt := AVE(GROUP,IF(h.registrant_street4 = (TYPEOF(h.registrant_street4))'',0,100));
    maxlength_registrant_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street4)));
    avelength_registrant_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_street4)),h.registrant_street4<>(typeof(h.registrant_street4))'');
    populated_registrant_city_cnt := COUNT(GROUP,h.registrant_city <> (TYPEOF(h.registrant_city))'');
    populated_registrant_city_pcnt := AVE(GROUP,IF(h.registrant_city = (TYPEOF(h.registrant_city))'',0,100));
    maxlength_registrant_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_city)));
    avelength_registrant_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_city)),h.registrant_city<>(typeof(h.registrant_city))'');
    populated_registrant_state_cnt := COUNT(GROUP,h.registrant_state <> (TYPEOF(h.registrant_state))'');
    populated_registrant_state_pcnt := AVE(GROUP,IF(h.registrant_state = (TYPEOF(h.registrant_state))'',0,100));
    maxlength_registrant_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_state)));
    avelength_registrant_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_state)),h.registrant_state<>(typeof(h.registrant_state))'');
    populated_registrant_postalcode_cnt := COUNT(GROUP,h.registrant_postalcode <> (TYPEOF(h.registrant_postalcode))'');
    populated_registrant_postalcode_pcnt := AVE(GROUP,IF(h.registrant_postalcode = (TYPEOF(h.registrant_postalcode))'',0,100));
    maxlength_registrant_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_postalcode)));
    avelength_registrant_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_postalcode)),h.registrant_postalcode<>(typeof(h.registrant_postalcode))'');
    populated_registrant_country_cnt := COUNT(GROUP,h.registrant_country <> (TYPEOF(h.registrant_country))'');
    populated_registrant_country_pcnt := AVE(GROUP,IF(h.registrant_country = (TYPEOF(h.registrant_country))'',0,100));
    maxlength_registrant_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_country)));
    avelength_registrant_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_country)),h.registrant_country<>(typeof(h.registrant_country))'');
    populated_registrant_fax_cnt := COUNT(GROUP,h.registrant_fax <> (TYPEOF(h.registrant_fax))'');
    populated_registrant_fax_pcnt := AVE(GROUP,IF(h.registrant_fax = (TYPEOF(h.registrant_fax))'',0,100));
    maxlength_registrant_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_fax)));
    avelength_registrant_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_fax)),h.registrant_fax<>(typeof(h.registrant_fax))'');
    populated_registrant_faxext_cnt := COUNT(GROUP,h.registrant_faxext <> (TYPEOF(h.registrant_faxext))'');
    populated_registrant_faxext_pcnt := AVE(GROUP,IF(h.registrant_faxext = (TYPEOF(h.registrant_faxext))'',0,100));
    maxlength_registrant_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_faxext)));
    avelength_registrant_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_faxext)),h.registrant_faxext<>(typeof(h.registrant_faxext))'');
    populated_registrant_phone_cnt := COUNT(GROUP,h.registrant_phone <> (TYPEOF(h.registrant_phone))'');
    populated_registrant_phone_pcnt := AVE(GROUP,IF(h.registrant_phone = (TYPEOF(h.registrant_phone))'',0,100));
    maxlength_registrant_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_phone)));
    avelength_registrant_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_phone)),h.registrant_phone<>(typeof(h.registrant_phone))'');
    populated_registrant_phoneext_cnt := COUNT(GROUP,h.registrant_phoneext <> (TYPEOF(h.registrant_phoneext))'');
    populated_registrant_phoneext_pcnt := AVE(GROUP,IF(h.registrant_phoneext = (TYPEOF(h.registrant_phoneext))'',0,100));
    maxlength_registrant_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_phoneext)));
    avelength_registrant_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrant_phoneext)),h.registrant_phoneext<>(typeof(h.registrant_phoneext))'');
    populated_administrativecontact_rawtext_cnt := COUNT(GROUP,h.administrativecontact_rawtext <> (TYPEOF(h.administrativecontact_rawtext))'');
    populated_administrativecontact_rawtext_pcnt := AVE(GROUP,IF(h.administrativecontact_rawtext = (TYPEOF(h.administrativecontact_rawtext))'',0,100));
    maxlength_administrativecontact_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_rawtext)));
    avelength_administrativecontact_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_rawtext)),h.administrativecontact_rawtext<>(typeof(h.administrativecontact_rawtext))'');
    populated_administrativecontact_email_cnt := COUNT(GROUP,h.administrativecontact_email <> (TYPEOF(h.administrativecontact_email))'');
    populated_administrativecontact_email_pcnt := AVE(GROUP,IF(h.administrativecontact_email = (TYPEOF(h.administrativecontact_email))'',0,100));
    maxlength_administrativecontact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_email)));
    avelength_administrativecontact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_email)),h.administrativecontact_email<>(typeof(h.administrativecontact_email))'');
    populated_administrativecontact_name_cnt := COUNT(GROUP,h.administrativecontact_name <> (TYPEOF(h.administrativecontact_name))'');
    populated_administrativecontact_name_pcnt := AVE(GROUP,IF(h.administrativecontact_name = (TYPEOF(h.administrativecontact_name))'',0,100));
    maxlength_administrativecontact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_name)));
    avelength_administrativecontact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_name)),h.administrativecontact_name<>(typeof(h.administrativecontact_name))'');
    populated_administrativecontact_organization_cnt := COUNT(GROUP,h.administrativecontact_organization <> (TYPEOF(h.administrativecontact_organization))'');
    populated_administrativecontact_organization_pcnt := AVE(GROUP,IF(h.administrativecontact_organization = (TYPEOF(h.administrativecontact_organization))'',0,100));
    maxlength_administrativecontact_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_organization)));
    avelength_administrativecontact_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_organization)),h.administrativecontact_organization<>(typeof(h.administrativecontact_organization))'');
    populated_administrativecontact_street1_cnt := COUNT(GROUP,h.administrativecontact_street1 <> (TYPEOF(h.administrativecontact_street1))'');
    populated_administrativecontact_street1_pcnt := AVE(GROUP,IF(h.administrativecontact_street1 = (TYPEOF(h.administrativecontact_street1))'',0,100));
    maxlength_administrativecontact_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street1)));
    avelength_administrativecontact_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street1)),h.administrativecontact_street1<>(typeof(h.administrativecontact_street1))'');
    populated_administrativecontact_street2_cnt := COUNT(GROUP,h.administrativecontact_street2 <> (TYPEOF(h.administrativecontact_street2))'');
    populated_administrativecontact_street2_pcnt := AVE(GROUP,IF(h.administrativecontact_street2 = (TYPEOF(h.administrativecontact_street2))'',0,100));
    maxlength_administrativecontact_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street2)));
    avelength_administrativecontact_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street2)),h.administrativecontact_street2<>(typeof(h.administrativecontact_street2))'');
    populated_administrativecontact_street3_cnt := COUNT(GROUP,h.administrativecontact_street3 <> (TYPEOF(h.administrativecontact_street3))'');
    populated_administrativecontact_street3_pcnt := AVE(GROUP,IF(h.administrativecontact_street3 = (TYPEOF(h.administrativecontact_street3))'',0,100));
    maxlength_administrativecontact_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street3)));
    avelength_administrativecontact_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street3)),h.administrativecontact_street3<>(typeof(h.administrativecontact_street3))'');
    populated_administrativecontact_street4_cnt := COUNT(GROUP,h.administrativecontact_street4 <> (TYPEOF(h.administrativecontact_street4))'');
    populated_administrativecontact_street4_pcnt := AVE(GROUP,IF(h.administrativecontact_street4 = (TYPEOF(h.administrativecontact_street4))'',0,100));
    maxlength_administrativecontact_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street4)));
    avelength_administrativecontact_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_street4)),h.administrativecontact_street4<>(typeof(h.administrativecontact_street4))'');
    populated_administrativecontact_city_cnt := COUNT(GROUP,h.administrativecontact_city <> (TYPEOF(h.administrativecontact_city))'');
    populated_administrativecontact_city_pcnt := AVE(GROUP,IF(h.administrativecontact_city = (TYPEOF(h.administrativecontact_city))'',0,100));
    maxlength_administrativecontact_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_city)));
    avelength_administrativecontact_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_city)),h.administrativecontact_city<>(typeof(h.administrativecontact_city))'');
    populated_administrativecontact_state_cnt := COUNT(GROUP,h.administrativecontact_state <> (TYPEOF(h.administrativecontact_state))'');
    populated_administrativecontact_state_pcnt := AVE(GROUP,IF(h.administrativecontact_state = (TYPEOF(h.administrativecontact_state))'',0,100));
    maxlength_administrativecontact_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_state)));
    avelength_administrativecontact_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_state)),h.administrativecontact_state<>(typeof(h.administrativecontact_state))'');
    populated_administrativecontact_postalcode_cnt := COUNT(GROUP,h.administrativecontact_postalcode <> (TYPEOF(h.administrativecontact_postalcode))'');
    populated_administrativecontact_postalcode_pcnt := AVE(GROUP,IF(h.administrativecontact_postalcode = (TYPEOF(h.administrativecontact_postalcode))'',0,100));
    maxlength_administrativecontact_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_postalcode)));
    avelength_administrativecontact_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_postalcode)),h.administrativecontact_postalcode<>(typeof(h.administrativecontact_postalcode))'');
    populated_administrativecontact_country_cnt := COUNT(GROUP,h.administrativecontact_country <> (TYPEOF(h.administrativecontact_country))'');
    populated_administrativecontact_country_pcnt := AVE(GROUP,IF(h.administrativecontact_country = (TYPEOF(h.administrativecontact_country))'',0,100));
    maxlength_administrativecontact_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_country)));
    avelength_administrativecontact_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_country)),h.administrativecontact_country<>(typeof(h.administrativecontact_country))'');
    populated_administrativecontact_fax_cnt := COUNT(GROUP,h.administrativecontact_fax <> (TYPEOF(h.administrativecontact_fax))'');
    populated_administrativecontact_fax_pcnt := AVE(GROUP,IF(h.administrativecontact_fax = (TYPEOF(h.administrativecontact_fax))'',0,100));
    maxlength_administrativecontact_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_fax)));
    avelength_administrativecontact_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_fax)),h.administrativecontact_fax<>(typeof(h.administrativecontact_fax))'');
    populated_administrativecontact_faxext_cnt := COUNT(GROUP,h.administrativecontact_faxext <> (TYPEOF(h.administrativecontact_faxext))'');
    populated_administrativecontact_faxext_pcnt := AVE(GROUP,IF(h.administrativecontact_faxext = (TYPEOF(h.administrativecontact_faxext))'',0,100));
    maxlength_administrativecontact_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_faxext)));
    avelength_administrativecontact_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_faxext)),h.administrativecontact_faxext<>(typeof(h.administrativecontact_faxext))'');
    populated_administrativecontact_phone_cnt := COUNT(GROUP,h.administrativecontact_phone <> (TYPEOF(h.administrativecontact_phone))'');
    populated_administrativecontact_phone_pcnt := AVE(GROUP,IF(h.administrativecontact_phone = (TYPEOF(h.administrativecontact_phone))'',0,100));
    maxlength_administrativecontact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_phone)));
    avelength_administrativecontact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_phone)),h.administrativecontact_phone<>(typeof(h.administrativecontact_phone))'');
    populated_administrativecontact_phoneext_cnt := COUNT(GROUP,h.administrativecontact_phoneext <> (TYPEOF(h.administrativecontact_phoneext))'');
    populated_administrativecontact_phoneext_pcnt := AVE(GROUP,IF(h.administrativecontact_phoneext = (TYPEOF(h.administrativecontact_phoneext))'',0,100));
    maxlength_administrativecontact_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_phoneext)));
    avelength_administrativecontact_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.administrativecontact_phoneext)),h.administrativecontact_phoneext<>(typeof(h.administrativecontact_phoneext))'');
    populated_billingcontact_rawtext_cnt := COUNT(GROUP,h.billingcontact_rawtext <> (TYPEOF(h.billingcontact_rawtext))'');
    populated_billingcontact_rawtext_pcnt := AVE(GROUP,IF(h.billingcontact_rawtext = (TYPEOF(h.billingcontact_rawtext))'',0,100));
    maxlength_billingcontact_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_rawtext)));
    avelength_billingcontact_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_rawtext)),h.billingcontact_rawtext<>(typeof(h.billingcontact_rawtext))'');
    populated_billingcontact_email_cnt := COUNT(GROUP,h.billingcontact_email <> (TYPEOF(h.billingcontact_email))'');
    populated_billingcontact_email_pcnt := AVE(GROUP,IF(h.billingcontact_email = (TYPEOF(h.billingcontact_email))'',0,100));
    maxlength_billingcontact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_email)));
    avelength_billingcontact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_email)),h.billingcontact_email<>(typeof(h.billingcontact_email))'');
    populated_billingcontact_name_cnt := COUNT(GROUP,h.billingcontact_name <> (TYPEOF(h.billingcontact_name))'');
    populated_billingcontact_name_pcnt := AVE(GROUP,IF(h.billingcontact_name = (TYPEOF(h.billingcontact_name))'',0,100));
    maxlength_billingcontact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_name)));
    avelength_billingcontact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_name)),h.billingcontact_name<>(typeof(h.billingcontact_name))'');
    populated_billingcontact_organization_cnt := COUNT(GROUP,h.billingcontact_organization <> (TYPEOF(h.billingcontact_organization))'');
    populated_billingcontact_organization_pcnt := AVE(GROUP,IF(h.billingcontact_organization = (TYPEOF(h.billingcontact_organization))'',0,100));
    maxlength_billingcontact_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_organization)));
    avelength_billingcontact_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_organization)),h.billingcontact_organization<>(typeof(h.billingcontact_organization))'');
    populated_billingcontact_street1_cnt := COUNT(GROUP,h.billingcontact_street1 <> (TYPEOF(h.billingcontact_street1))'');
    populated_billingcontact_street1_pcnt := AVE(GROUP,IF(h.billingcontact_street1 = (TYPEOF(h.billingcontact_street1))'',0,100));
    maxlength_billingcontact_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street1)));
    avelength_billingcontact_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street1)),h.billingcontact_street1<>(typeof(h.billingcontact_street1))'');
    populated_billingcontact_street2_cnt := COUNT(GROUP,h.billingcontact_street2 <> (TYPEOF(h.billingcontact_street2))'');
    populated_billingcontact_street2_pcnt := AVE(GROUP,IF(h.billingcontact_street2 = (TYPEOF(h.billingcontact_street2))'',0,100));
    maxlength_billingcontact_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street2)));
    avelength_billingcontact_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street2)),h.billingcontact_street2<>(typeof(h.billingcontact_street2))'');
    populated_billingcontact_street3_cnt := COUNT(GROUP,h.billingcontact_street3 <> (TYPEOF(h.billingcontact_street3))'');
    populated_billingcontact_street3_pcnt := AVE(GROUP,IF(h.billingcontact_street3 = (TYPEOF(h.billingcontact_street3))'',0,100));
    maxlength_billingcontact_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street3)));
    avelength_billingcontact_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street3)),h.billingcontact_street3<>(typeof(h.billingcontact_street3))'');
    populated_billingcontact_street4_cnt := COUNT(GROUP,h.billingcontact_street4 <> (TYPEOF(h.billingcontact_street4))'');
    populated_billingcontact_street4_pcnt := AVE(GROUP,IF(h.billingcontact_street4 = (TYPEOF(h.billingcontact_street4))'',0,100));
    maxlength_billingcontact_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street4)));
    avelength_billingcontact_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_street4)),h.billingcontact_street4<>(typeof(h.billingcontact_street4))'');
    populated_billingcontact_city_cnt := COUNT(GROUP,h.billingcontact_city <> (TYPEOF(h.billingcontact_city))'');
    populated_billingcontact_city_pcnt := AVE(GROUP,IF(h.billingcontact_city = (TYPEOF(h.billingcontact_city))'',0,100));
    maxlength_billingcontact_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_city)));
    avelength_billingcontact_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_city)),h.billingcontact_city<>(typeof(h.billingcontact_city))'');
    populated_billingcontact_state_cnt := COUNT(GROUP,h.billingcontact_state <> (TYPEOF(h.billingcontact_state))'');
    populated_billingcontact_state_pcnt := AVE(GROUP,IF(h.billingcontact_state = (TYPEOF(h.billingcontact_state))'',0,100));
    maxlength_billingcontact_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_state)));
    avelength_billingcontact_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_state)),h.billingcontact_state<>(typeof(h.billingcontact_state))'');
    populated_billingcontact_postalcode_cnt := COUNT(GROUP,h.billingcontact_postalcode <> (TYPEOF(h.billingcontact_postalcode))'');
    populated_billingcontact_postalcode_pcnt := AVE(GROUP,IF(h.billingcontact_postalcode = (TYPEOF(h.billingcontact_postalcode))'',0,100));
    maxlength_billingcontact_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_postalcode)));
    avelength_billingcontact_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_postalcode)),h.billingcontact_postalcode<>(typeof(h.billingcontact_postalcode))'');
    populated_billingcontact_country_cnt := COUNT(GROUP,h.billingcontact_country <> (TYPEOF(h.billingcontact_country))'');
    populated_billingcontact_country_pcnt := AVE(GROUP,IF(h.billingcontact_country = (TYPEOF(h.billingcontact_country))'',0,100));
    maxlength_billingcontact_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_country)));
    avelength_billingcontact_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_country)),h.billingcontact_country<>(typeof(h.billingcontact_country))'');
    populated_billingcontact_fax_cnt := COUNT(GROUP,h.billingcontact_fax <> (TYPEOF(h.billingcontact_fax))'');
    populated_billingcontact_fax_pcnt := AVE(GROUP,IF(h.billingcontact_fax = (TYPEOF(h.billingcontact_fax))'',0,100));
    maxlength_billingcontact_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_fax)));
    avelength_billingcontact_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_fax)),h.billingcontact_fax<>(typeof(h.billingcontact_fax))'');
    populated_billingcontact_faxext_cnt := COUNT(GROUP,h.billingcontact_faxext <> (TYPEOF(h.billingcontact_faxext))'');
    populated_billingcontact_faxext_pcnt := AVE(GROUP,IF(h.billingcontact_faxext = (TYPEOF(h.billingcontact_faxext))'',0,100));
    maxlength_billingcontact_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_faxext)));
    avelength_billingcontact_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_faxext)),h.billingcontact_faxext<>(typeof(h.billingcontact_faxext))'');
    populated_billingcontact_phone_cnt := COUNT(GROUP,h.billingcontact_phone <> (TYPEOF(h.billingcontact_phone))'');
    populated_billingcontact_phone_pcnt := AVE(GROUP,IF(h.billingcontact_phone = (TYPEOF(h.billingcontact_phone))'',0,100));
    maxlength_billingcontact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_phone)));
    avelength_billingcontact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_phone)),h.billingcontact_phone<>(typeof(h.billingcontact_phone))'');
    populated_billingcontact_phoneext_cnt := COUNT(GROUP,h.billingcontact_phoneext <> (TYPEOF(h.billingcontact_phoneext))'');
    populated_billingcontact_phoneext_pcnt := AVE(GROUP,IF(h.billingcontact_phoneext = (TYPEOF(h.billingcontact_phoneext))'',0,100));
    maxlength_billingcontact_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_phoneext)));
    avelength_billingcontact_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.billingcontact_phoneext)),h.billingcontact_phoneext<>(typeof(h.billingcontact_phoneext))'');
    populated_technicalcontact_rawtext_cnt := COUNT(GROUP,h.technicalcontact_rawtext <> (TYPEOF(h.technicalcontact_rawtext))'');
    populated_technicalcontact_rawtext_pcnt := AVE(GROUP,IF(h.technicalcontact_rawtext = (TYPEOF(h.technicalcontact_rawtext))'',0,100));
    maxlength_technicalcontact_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_rawtext)));
    avelength_technicalcontact_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_rawtext)),h.technicalcontact_rawtext<>(typeof(h.technicalcontact_rawtext))'');
    populated_technicalcontact_email_cnt := COUNT(GROUP,h.technicalcontact_email <> (TYPEOF(h.technicalcontact_email))'');
    populated_technicalcontact_email_pcnt := AVE(GROUP,IF(h.technicalcontact_email = (TYPEOF(h.technicalcontact_email))'',0,100));
    maxlength_technicalcontact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_email)));
    avelength_technicalcontact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_email)),h.technicalcontact_email<>(typeof(h.technicalcontact_email))'');
    populated_technicalcontact_name_cnt := COUNT(GROUP,h.technicalcontact_name <> (TYPEOF(h.technicalcontact_name))'');
    populated_technicalcontact_name_pcnt := AVE(GROUP,IF(h.technicalcontact_name = (TYPEOF(h.technicalcontact_name))'',0,100));
    maxlength_technicalcontact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_name)));
    avelength_technicalcontact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_name)),h.technicalcontact_name<>(typeof(h.technicalcontact_name))'');
    populated_technicalcontact_organization_cnt := COUNT(GROUP,h.technicalcontact_organization <> (TYPEOF(h.technicalcontact_organization))'');
    populated_technicalcontact_organization_pcnt := AVE(GROUP,IF(h.technicalcontact_organization = (TYPEOF(h.technicalcontact_organization))'',0,100));
    maxlength_technicalcontact_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_organization)));
    avelength_technicalcontact_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_organization)),h.technicalcontact_organization<>(typeof(h.technicalcontact_organization))'');
    populated_technicalcontact_street1_cnt := COUNT(GROUP,h.technicalcontact_street1 <> (TYPEOF(h.technicalcontact_street1))'');
    populated_technicalcontact_street1_pcnt := AVE(GROUP,IF(h.technicalcontact_street1 = (TYPEOF(h.technicalcontact_street1))'',0,100));
    maxlength_technicalcontact_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street1)));
    avelength_technicalcontact_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street1)),h.technicalcontact_street1<>(typeof(h.technicalcontact_street1))'');
    populated_technicalcontact_street2_cnt := COUNT(GROUP,h.technicalcontact_street2 <> (TYPEOF(h.technicalcontact_street2))'');
    populated_technicalcontact_street2_pcnt := AVE(GROUP,IF(h.technicalcontact_street2 = (TYPEOF(h.technicalcontact_street2))'',0,100));
    maxlength_technicalcontact_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street2)));
    avelength_technicalcontact_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street2)),h.technicalcontact_street2<>(typeof(h.technicalcontact_street2))'');
    populated_technicalcontact_street3_cnt := COUNT(GROUP,h.technicalcontact_street3 <> (TYPEOF(h.technicalcontact_street3))'');
    populated_technicalcontact_street3_pcnt := AVE(GROUP,IF(h.technicalcontact_street3 = (TYPEOF(h.technicalcontact_street3))'',0,100));
    maxlength_technicalcontact_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street3)));
    avelength_technicalcontact_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street3)),h.technicalcontact_street3<>(typeof(h.technicalcontact_street3))'');
    populated_technicalcontact_street4_cnt := COUNT(GROUP,h.technicalcontact_street4 <> (TYPEOF(h.technicalcontact_street4))'');
    populated_technicalcontact_street4_pcnt := AVE(GROUP,IF(h.technicalcontact_street4 = (TYPEOF(h.technicalcontact_street4))'',0,100));
    maxlength_technicalcontact_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street4)));
    avelength_technicalcontact_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_street4)),h.technicalcontact_street4<>(typeof(h.technicalcontact_street4))'');
    populated_technicalcontact_city_cnt := COUNT(GROUP,h.technicalcontact_city <> (TYPEOF(h.technicalcontact_city))'');
    populated_technicalcontact_city_pcnt := AVE(GROUP,IF(h.technicalcontact_city = (TYPEOF(h.technicalcontact_city))'',0,100));
    maxlength_technicalcontact_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_city)));
    avelength_technicalcontact_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_city)),h.technicalcontact_city<>(typeof(h.technicalcontact_city))'');
    populated_technicalcontact_state_cnt := COUNT(GROUP,h.technicalcontact_state <> (TYPEOF(h.technicalcontact_state))'');
    populated_technicalcontact_state_pcnt := AVE(GROUP,IF(h.technicalcontact_state = (TYPEOF(h.technicalcontact_state))'',0,100));
    maxlength_technicalcontact_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_state)));
    avelength_technicalcontact_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_state)),h.technicalcontact_state<>(typeof(h.technicalcontact_state))'');
    populated_technicalcontact_postalcode_cnt := COUNT(GROUP,h.technicalcontact_postalcode <> (TYPEOF(h.technicalcontact_postalcode))'');
    populated_technicalcontact_postalcode_pcnt := AVE(GROUP,IF(h.technicalcontact_postalcode = (TYPEOF(h.technicalcontact_postalcode))'',0,100));
    maxlength_technicalcontact_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_postalcode)));
    avelength_technicalcontact_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_postalcode)),h.technicalcontact_postalcode<>(typeof(h.technicalcontact_postalcode))'');
    populated_technicalcontact_country_cnt := COUNT(GROUP,h.technicalcontact_country <> (TYPEOF(h.technicalcontact_country))'');
    populated_technicalcontact_country_pcnt := AVE(GROUP,IF(h.technicalcontact_country = (TYPEOF(h.technicalcontact_country))'',0,100));
    maxlength_technicalcontact_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_country)));
    avelength_technicalcontact_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_country)),h.technicalcontact_country<>(typeof(h.technicalcontact_country))'');
    populated_technicalcontact_fax_cnt := COUNT(GROUP,h.technicalcontact_fax <> (TYPEOF(h.technicalcontact_fax))'');
    populated_technicalcontact_fax_pcnt := AVE(GROUP,IF(h.technicalcontact_fax = (TYPEOF(h.technicalcontact_fax))'',0,100));
    maxlength_technicalcontact_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_fax)));
    avelength_technicalcontact_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_fax)),h.technicalcontact_fax<>(typeof(h.technicalcontact_fax))'');
    populated_technicalcontact_faxext_cnt := COUNT(GROUP,h.technicalcontact_faxext <> (TYPEOF(h.technicalcontact_faxext))'');
    populated_technicalcontact_faxext_pcnt := AVE(GROUP,IF(h.technicalcontact_faxext = (TYPEOF(h.technicalcontact_faxext))'',0,100));
    maxlength_technicalcontact_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_faxext)));
    avelength_technicalcontact_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_faxext)),h.technicalcontact_faxext<>(typeof(h.technicalcontact_faxext))'');
    populated_technicalcontact_phone_cnt := COUNT(GROUP,h.technicalcontact_phone <> (TYPEOF(h.technicalcontact_phone))'');
    populated_technicalcontact_phone_pcnt := AVE(GROUP,IF(h.technicalcontact_phone = (TYPEOF(h.technicalcontact_phone))'',0,100));
    maxlength_technicalcontact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_phone)));
    avelength_technicalcontact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_phone)),h.technicalcontact_phone<>(typeof(h.technicalcontact_phone))'');
    populated_technicalcontact_phoneext_cnt := COUNT(GROUP,h.technicalcontact_phoneext <> (TYPEOF(h.technicalcontact_phoneext))'');
    populated_technicalcontact_phoneext_pcnt := AVE(GROUP,IF(h.technicalcontact_phoneext = (TYPEOF(h.technicalcontact_phoneext))'',0,100));
    maxlength_technicalcontact_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_phoneext)));
    avelength_technicalcontact_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technicalcontact_phoneext)),h.technicalcontact_phoneext<>(typeof(h.technicalcontact_phoneext))'');
    populated_zonecontact_rawtext_cnt := COUNT(GROUP,h.zonecontact_rawtext <> (TYPEOF(h.zonecontact_rawtext))'');
    populated_zonecontact_rawtext_pcnt := AVE(GROUP,IF(h.zonecontact_rawtext = (TYPEOF(h.zonecontact_rawtext))'',0,100));
    maxlength_zonecontact_rawtext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_rawtext)));
    avelength_zonecontact_rawtext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_rawtext)),h.zonecontact_rawtext<>(typeof(h.zonecontact_rawtext))'');
    populated_zonecontact_email_cnt := COUNT(GROUP,h.zonecontact_email <> (TYPEOF(h.zonecontact_email))'');
    populated_zonecontact_email_pcnt := AVE(GROUP,IF(h.zonecontact_email = (TYPEOF(h.zonecontact_email))'',0,100));
    maxlength_zonecontact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_email)));
    avelength_zonecontact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_email)),h.zonecontact_email<>(typeof(h.zonecontact_email))'');
    populated_zonecontact_name_cnt := COUNT(GROUP,h.zonecontact_name <> (TYPEOF(h.zonecontact_name))'');
    populated_zonecontact_name_pcnt := AVE(GROUP,IF(h.zonecontact_name = (TYPEOF(h.zonecontact_name))'',0,100));
    maxlength_zonecontact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_name)));
    avelength_zonecontact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_name)),h.zonecontact_name<>(typeof(h.zonecontact_name))'');
    populated_zonecontact_organization_cnt := COUNT(GROUP,h.zonecontact_organization <> (TYPEOF(h.zonecontact_organization))'');
    populated_zonecontact_organization_pcnt := AVE(GROUP,IF(h.zonecontact_organization = (TYPEOF(h.zonecontact_organization))'',0,100));
    maxlength_zonecontact_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_organization)));
    avelength_zonecontact_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_organization)),h.zonecontact_organization<>(typeof(h.zonecontact_organization))'');
    populated_zonecontact_street1_cnt := COUNT(GROUP,h.zonecontact_street1 <> (TYPEOF(h.zonecontact_street1))'');
    populated_zonecontact_street1_pcnt := AVE(GROUP,IF(h.zonecontact_street1 = (TYPEOF(h.zonecontact_street1))'',0,100));
    maxlength_zonecontact_street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street1)));
    avelength_zonecontact_street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street1)),h.zonecontact_street1<>(typeof(h.zonecontact_street1))'');
    populated_zonecontact_street2_cnt := COUNT(GROUP,h.zonecontact_street2 <> (TYPEOF(h.zonecontact_street2))'');
    populated_zonecontact_street2_pcnt := AVE(GROUP,IF(h.zonecontact_street2 = (TYPEOF(h.zonecontact_street2))'',0,100));
    maxlength_zonecontact_street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street2)));
    avelength_zonecontact_street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street2)),h.zonecontact_street2<>(typeof(h.zonecontact_street2))'');
    populated_zonecontact_street3_cnt := COUNT(GROUP,h.zonecontact_street3 <> (TYPEOF(h.zonecontact_street3))'');
    populated_zonecontact_street3_pcnt := AVE(GROUP,IF(h.zonecontact_street3 = (TYPEOF(h.zonecontact_street3))'',0,100));
    maxlength_zonecontact_street3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street3)));
    avelength_zonecontact_street3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street3)),h.zonecontact_street3<>(typeof(h.zonecontact_street3))'');
    populated_zonecontact_street4_cnt := COUNT(GROUP,h.zonecontact_street4 <> (TYPEOF(h.zonecontact_street4))'');
    populated_zonecontact_street4_pcnt := AVE(GROUP,IF(h.zonecontact_street4 = (TYPEOF(h.zonecontact_street4))'',0,100));
    maxlength_zonecontact_street4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street4)));
    avelength_zonecontact_street4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_street4)),h.zonecontact_street4<>(typeof(h.zonecontact_street4))'');
    populated_zonecontact_city_cnt := COUNT(GROUP,h.zonecontact_city <> (TYPEOF(h.zonecontact_city))'');
    populated_zonecontact_city_pcnt := AVE(GROUP,IF(h.zonecontact_city = (TYPEOF(h.zonecontact_city))'',0,100));
    maxlength_zonecontact_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_city)));
    avelength_zonecontact_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_city)),h.zonecontact_city<>(typeof(h.zonecontact_city))'');
    populated_zonecontact_state_cnt := COUNT(GROUP,h.zonecontact_state <> (TYPEOF(h.zonecontact_state))'');
    populated_zonecontact_state_pcnt := AVE(GROUP,IF(h.zonecontact_state = (TYPEOF(h.zonecontact_state))'',0,100));
    maxlength_zonecontact_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_state)));
    avelength_zonecontact_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_state)),h.zonecontact_state<>(typeof(h.zonecontact_state))'');
    populated_zonecontact_postalcode_cnt := COUNT(GROUP,h.zonecontact_postalcode <> (TYPEOF(h.zonecontact_postalcode))'');
    populated_zonecontact_postalcode_pcnt := AVE(GROUP,IF(h.zonecontact_postalcode = (TYPEOF(h.zonecontact_postalcode))'',0,100));
    maxlength_zonecontact_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_postalcode)));
    avelength_zonecontact_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_postalcode)),h.zonecontact_postalcode<>(typeof(h.zonecontact_postalcode))'');
    populated_zonecontact_country_cnt := COUNT(GROUP,h.zonecontact_country <> (TYPEOF(h.zonecontact_country))'');
    populated_zonecontact_country_pcnt := AVE(GROUP,IF(h.zonecontact_country = (TYPEOF(h.zonecontact_country))'',0,100));
    maxlength_zonecontact_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_country)));
    avelength_zonecontact_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_country)),h.zonecontact_country<>(typeof(h.zonecontact_country))'');
    populated_zonecontact_fax_cnt := COUNT(GROUP,h.zonecontact_fax <> (TYPEOF(h.zonecontact_fax))'');
    populated_zonecontact_fax_pcnt := AVE(GROUP,IF(h.zonecontact_fax = (TYPEOF(h.zonecontact_fax))'',0,100));
    maxlength_zonecontact_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_fax)));
    avelength_zonecontact_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_fax)),h.zonecontact_fax<>(typeof(h.zonecontact_fax))'');
    populated_zonecontact_faxext_cnt := COUNT(GROUP,h.zonecontact_faxext <> (TYPEOF(h.zonecontact_faxext))'');
    populated_zonecontact_faxext_pcnt := AVE(GROUP,IF(h.zonecontact_faxext = (TYPEOF(h.zonecontact_faxext))'',0,100));
    maxlength_zonecontact_faxext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_faxext)));
    avelength_zonecontact_faxext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_faxext)),h.zonecontact_faxext<>(typeof(h.zonecontact_faxext))'');
    populated_zonecontact_phone_cnt := COUNT(GROUP,h.zonecontact_phone <> (TYPEOF(h.zonecontact_phone))'');
    populated_zonecontact_phone_pcnt := AVE(GROUP,IF(h.zonecontact_phone = (TYPEOF(h.zonecontact_phone))'',0,100));
    maxlength_zonecontact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_phone)));
    avelength_zonecontact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_phone)),h.zonecontact_phone<>(typeof(h.zonecontact_phone))'');
    populated_zonecontact_phoneext_cnt := COUNT(GROUP,h.zonecontact_phoneext <> (TYPEOF(h.zonecontact_phoneext))'');
    populated_zonecontact_phoneext_pcnt := AVE(GROUP,IF(h.zonecontact_phoneext = (TYPEOF(h.zonecontact_phoneext))'',0,100));
    maxlength_zonecontact_phoneext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_phoneext)));
    avelength_zonecontact_phoneext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zonecontact_phoneext)),h.zonecontact_phoneext<>(typeof(h.zonecontact_phoneext))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_clean_cname_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_clean_title_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_append_prep_address_situs_pcnt *   0.00 / 100 + T.Populated_append_prep_address_last_situs_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_emailtype_pcnt *   0.00 / 100 + T.Populated_rawtext_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_organization_pcnt *   0.00 / 100 + T.Populated_street1_pcnt *   0.00 / 100 + T.Populated_street2_pcnt *   0.00 / 100 + T.Populated_street3_pcnt *   0.00 / 100 + T.Populated_street4_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_postalcode_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_faxext_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phoneext_pcnt *   0.00 / 100 + T.Populated_domainname_pcnt *   0.00 / 100 + T.Populated_registrarname_pcnt *   0.00 / 100 + T.Populated_contactemail_pcnt *   0.00 / 100 + T.Populated_whoisserver_pcnt *   0.00 / 100 + T.Populated_nameservers_pcnt *   0.00 / 100 + T.Populated_createddate_pcnt *   0.00 / 100 + T.Populated_updateddate_pcnt *   0.00 / 100 + T.Populated_expiresdate_pcnt *   0.00 / 100 + T.Populated_standardregcreateddate_pcnt *   0.00 / 100 + T.Populated_standardregupdateddate_pcnt *   0.00 / 100 + T.Populated_standardregexpiresdate_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_audit_auditupdateddate_pcnt *   0.00 / 100 + T.Populated_registrant_rawtext_pcnt *   0.00 / 100 + T.Populated_registrant_email_pcnt *   0.00 / 100 + T.Populated_registrant_name_pcnt *   0.00 / 100 + T.Populated_registrant_organization_pcnt *   0.00 / 100 + T.Populated_registrant_street1_pcnt *   0.00 / 100 + T.Populated_registrant_street2_pcnt *   0.00 / 100 + T.Populated_registrant_street3_pcnt *   0.00 / 100 + T.Populated_registrant_street4_pcnt *   0.00 / 100 + T.Populated_registrant_city_pcnt *   0.00 / 100 + T.Populated_registrant_state_pcnt *   0.00 / 100 + T.Populated_registrant_postalcode_pcnt *   0.00 / 100 + T.Populated_registrant_country_pcnt *   0.00 / 100 + T.Populated_registrant_fax_pcnt *   0.00 / 100 + T.Populated_registrant_faxext_pcnt *   0.00 / 100 + T.Populated_registrant_phone_pcnt *   0.00 / 100 + T.Populated_registrant_phoneext_pcnt *   0.00 / 100 + T.Populated_administrativecontact_rawtext_pcnt *   0.00 / 100 + T.Populated_administrativecontact_email_pcnt *   0.00 / 100 + T.Populated_administrativecontact_name_pcnt *   0.00 / 100 + T.Populated_administrativecontact_organization_pcnt *   0.00 / 100 + T.Populated_administrativecontact_street1_pcnt *   0.00 / 100 + T.Populated_administrativecontact_street2_pcnt *   0.00 / 100 + T.Populated_administrativecontact_street3_pcnt *   0.00 / 100 + T.Populated_administrativecontact_street4_pcnt *   0.00 / 100 + T.Populated_administrativecontact_city_pcnt *   0.00 / 100 + T.Populated_administrativecontact_state_pcnt *   0.00 / 100 + T.Populated_administrativecontact_postalcode_pcnt *   0.00 / 100 + T.Populated_administrativecontact_country_pcnt *   0.00 / 100 + T.Populated_administrativecontact_fax_pcnt *   0.00 / 100 + T.Populated_administrativecontact_faxext_pcnt *   0.00 / 100 + T.Populated_administrativecontact_phone_pcnt *   0.00 / 100 + T.Populated_administrativecontact_phoneext_pcnt *   0.00 / 100 + T.Populated_billingcontact_rawtext_pcnt *   0.00 / 100 + T.Populated_billingcontact_email_pcnt *   0.00 / 100 + T.Populated_billingcontact_name_pcnt *   0.00 / 100 + T.Populated_billingcontact_organization_pcnt *   0.00 / 100 + T.Populated_billingcontact_street1_pcnt *   0.00 / 100 + T.Populated_billingcontact_street2_pcnt *   0.00 / 100 + T.Populated_billingcontact_street3_pcnt *   0.00 / 100 + T.Populated_billingcontact_street4_pcnt *   0.00 / 100 + T.Populated_billingcontact_city_pcnt *   0.00 / 100 + T.Populated_billingcontact_state_pcnt *   0.00 / 100 + T.Populated_billingcontact_postalcode_pcnt *   0.00 / 100 + T.Populated_billingcontact_country_pcnt *   0.00 / 100 + T.Populated_billingcontact_fax_pcnt *   0.00 / 100 + T.Populated_billingcontact_faxext_pcnt *   0.00 / 100 + T.Populated_billingcontact_phone_pcnt *   0.00 / 100 + T.Populated_billingcontact_phoneext_pcnt *   0.00 / 100 + T.Populated_technicalcontact_rawtext_pcnt *   0.00 / 100 + T.Populated_technicalcontact_email_pcnt *   0.00 / 100 + T.Populated_technicalcontact_name_pcnt *   0.00 / 100 + T.Populated_technicalcontact_organization_pcnt *   0.00 / 100 + T.Populated_technicalcontact_street1_pcnt *   0.00 / 100 + T.Populated_technicalcontact_street2_pcnt *   0.00 / 100 + T.Populated_technicalcontact_street3_pcnt *   0.00 / 100 + T.Populated_technicalcontact_street4_pcnt *   0.00 / 100 + T.Populated_technicalcontact_city_pcnt *   0.00 / 100 + T.Populated_technicalcontact_state_pcnt *   0.00 / 100 + T.Populated_technicalcontact_postalcode_pcnt *   0.00 / 100 + T.Populated_technicalcontact_country_pcnt *   0.00 / 100 + T.Populated_technicalcontact_fax_pcnt *   0.00 / 100 + T.Populated_technicalcontact_faxext_pcnt *   0.00 / 100 + T.Populated_technicalcontact_phone_pcnt *   0.00 / 100 + T.Populated_technicalcontact_phoneext_pcnt *   0.00 / 100 + T.Populated_zonecontact_rawtext_pcnt *   0.00 / 100 + T.Populated_zonecontact_email_pcnt *   0.00 / 100 + T.Populated_zonecontact_name_pcnt *   0.00 / 100 + T.Populated_zonecontact_organization_pcnt *   0.00 / 100 + T.Populated_zonecontact_street1_pcnt *   0.00 / 100 + T.Populated_zonecontact_street2_pcnt *   0.00 / 100 + T.Populated_zonecontact_street3_pcnt *   0.00 / 100 + T.Populated_zonecontact_street4_pcnt *   0.00 / 100 + T.Populated_zonecontact_city_pcnt *   0.00 / 100 + T.Populated_zonecontact_state_pcnt *   0.00 / 100 + T.Populated_zonecontact_postalcode_pcnt *   0.00 / 100 + T.Populated_zonecontact_country_pcnt *   0.00 / 100 + T.Populated_zonecontact_fax_pcnt *   0.00 / 100 + T.Populated_zonecontact_faxext_pcnt *   0.00 / 100 + T.Populated_zonecontact_phone_pcnt *   0.00 / 100 + T.Populated_zonecontact_phoneext_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
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
  SELF.FieldName := CHOOSE(C,'did','did_score','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','clean_cname','current_rec','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','rawaid','append_prep_address_situs','append_prep_address_last_situs','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','emailtype','rawtext','email','name','organization','street1','street2','street3','street4','city','state','postalcode','country','fax','faxext','phone','phoneext','domainname','registrarname','contactemail','whoisserver','nameservers','createddate','updateddate','expiresdate','standardregcreateddate','standardregupdateddate','standardregexpiresdate','status','audit_auditupdateddate','registrant_rawtext','registrant_email','registrant_name','registrant_organization','registrant_street1','registrant_street2','registrant_street3','registrant_street4','registrant_city','registrant_state','registrant_postalcode','registrant_country','registrant_fax','registrant_faxext','registrant_phone','registrant_phoneext','administrativecontact_rawtext','administrativecontact_email','administrativecontact_name','administrativecontact_organization','administrativecontact_street1','administrativecontact_street2','administrativecontact_street3','administrativecontact_street4','administrativecontact_city','administrativecontact_state','administrativecontact_postalcode','administrativecontact_country','administrativecontact_fax','administrativecontact_faxext','administrativecontact_phone','administrativecontact_phoneext','billingcontact_rawtext','billingcontact_email','billingcontact_name','billingcontact_organization','billingcontact_street1','billingcontact_street2','billingcontact_street3','billingcontact_street4','billingcontact_city','billingcontact_state','billingcontact_postalcode','billingcontact_country','billingcontact_fax','billingcontact_faxext','billingcontact_phone','billingcontact_phoneext','technicalcontact_rawtext','technicalcontact_email','technicalcontact_name','technicalcontact_organization','technicalcontact_street1','technicalcontact_street2','technicalcontact_street3','technicalcontact_street4','technicalcontact_city','technicalcontact_state','technicalcontact_postalcode','technicalcontact_country','technicalcontact_fax','technicalcontact_faxext','technicalcontact_phone','technicalcontact_phoneext','zonecontact_rawtext','zonecontact_email','zonecontact_name','zonecontact_organization','zonecontact_street1','zonecontact_street2','zonecontact_street3','zonecontact_street4','zonecontact_city','zonecontact_state','zonecontact_postalcode','zonecontact_country','zonecontact_fax','zonecontact_faxext','zonecontact_phone','zonecontact_phoneext');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_clean_cname_pcnt,le.populated_current_rec_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_clean_title_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_rawaid_pcnt,le.populated_append_prep_address_situs_pcnt,le.populated_append_prep_address_last_situs_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_emailtype_pcnt,le.populated_rawtext_pcnt,le.populated_email_pcnt,le.populated_name_pcnt,le.populated_organization_pcnt,le.populated_street1_pcnt,le.populated_street2_pcnt,le.populated_street3_pcnt,le.populated_street4_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_postalcode_pcnt,le.populated_country_pcnt,le.populated_fax_pcnt,le.populated_faxext_pcnt,le.populated_phone_pcnt,le.populated_phoneext_pcnt,le.populated_domainname_pcnt,le.populated_registrarname_pcnt,le.populated_contactemail_pcnt,le.populated_whoisserver_pcnt,le.populated_nameservers_pcnt,le.populated_createddate_pcnt,le.populated_updateddate_pcnt,le.populated_expiresdate_pcnt,le.populated_standardregcreateddate_pcnt,le.populated_standardregupdateddate_pcnt,le.populated_standardregexpiresdate_pcnt,le.populated_status_pcnt,le.populated_audit_auditupdateddate_pcnt,le.populated_registrant_rawtext_pcnt,le.populated_registrant_email_pcnt,le.populated_registrant_name_pcnt,le.populated_registrant_organization_pcnt,le.populated_registrant_street1_pcnt,le.populated_registrant_street2_pcnt,le.populated_registrant_street3_pcnt,le.populated_registrant_street4_pcnt,le.populated_registrant_city_pcnt,le.populated_registrant_state_pcnt,le.populated_registrant_postalcode_pcnt,le.populated_registrant_country_pcnt,le.populated_registrant_fax_pcnt,le.populated_registrant_faxext_pcnt,le.populated_registrant_phone_pcnt,le.populated_registrant_phoneext_pcnt,le.populated_administrativecontact_rawtext_pcnt,le.populated_administrativecontact_email_pcnt,le.populated_administrativecontact_name_pcnt,le.populated_administrativecontact_organization_pcnt,le.populated_administrativecontact_street1_pcnt,le.populated_administrativecontact_street2_pcnt,le.populated_administrativecontact_street3_pcnt,le.populated_administrativecontact_street4_pcnt,le.populated_administrativecontact_city_pcnt,le.populated_administrativecontact_state_pcnt,le.populated_administrativecontact_postalcode_pcnt,le.populated_administrativecontact_country_pcnt,le.populated_administrativecontact_fax_pcnt,le.populated_administrativecontact_faxext_pcnt,le.populated_administrativecontact_phone_pcnt,le.populated_administrativecontact_phoneext_pcnt,le.populated_billingcontact_rawtext_pcnt,le.populated_billingcontact_email_pcnt,le.populated_billingcontact_name_pcnt,le.populated_billingcontact_organization_pcnt,le.populated_billingcontact_street1_pcnt,le.populated_billingcontact_street2_pcnt,le.populated_billingcontact_street3_pcnt,le.populated_billingcontact_street4_pcnt,le.populated_billingcontact_city_pcnt,le.populated_billingcontact_state_pcnt,le.populated_billingcontact_postalcode_pcnt,le.populated_billingcontact_country_pcnt,le.populated_billingcontact_fax_pcnt,le.populated_billingcontact_faxext_pcnt,le.populated_billingcontact_phone_pcnt,le.populated_billingcontact_phoneext_pcnt,le.populated_technicalcontact_rawtext_pcnt,le.populated_technicalcontact_email_pcnt,le.populated_technicalcontact_name_pcnt,le.populated_technicalcontact_organization_pcnt,le.populated_technicalcontact_street1_pcnt,le.populated_technicalcontact_street2_pcnt,le.populated_technicalcontact_street3_pcnt,le.populated_technicalcontact_street4_pcnt,le.populated_technicalcontact_city_pcnt,le.populated_technicalcontact_state_pcnt,le.populated_technicalcontact_postalcode_pcnt,le.populated_technicalcontact_country_pcnt,le.populated_technicalcontact_fax_pcnt,le.populated_technicalcontact_faxext_pcnt,le.populated_technicalcontact_phone_pcnt,le.populated_technicalcontact_phoneext_pcnt,le.populated_zonecontact_rawtext_pcnt,le.populated_zonecontact_email_pcnt,le.populated_zonecontact_name_pcnt,le.populated_zonecontact_organization_pcnt,le.populated_zonecontact_street1_pcnt,le.populated_zonecontact_street2_pcnt,le.populated_zonecontact_street3_pcnt,le.populated_zonecontact_street4_pcnt,le.populated_zonecontact_city_pcnt,le.populated_zonecontact_state_pcnt,le.populated_zonecontact_postalcode_pcnt,le.populated_zonecontact_country_pcnt,le.populated_zonecontact_fax_pcnt,le.populated_zonecontact_faxext_pcnt,le.populated_zonecontact_phone_pcnt,le.populated_zonecontact_phoneext_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_did_score,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_clean_cname,le.maxlength_current_rec,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_clean_title,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_rawaid,le.maxlength_append_prep_address_situs,le.maxlength_append_prep_address_last_situs,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_emailtype,le.maxlength_rawtext,le.maxlength_email,le.maxlength_name,le.maxlength_organization,le.maxlength_street1,le.maxlength_street2,le.maxlength_street3,le.maxlength_street4,le.maxlength_city,le.maxlength_state,le.maxlength_postalcode,le.maxlength_country,le.maxlength_fax,le.maxlength_faxext,le.maxlength_phone,le.maxlength_phoneext,le.maxlength_domainname,le.maxlength_registrarname,le.maxlength_contactemail,le.maxlength_whoisserver,le.maxlength_nameservers,le.maxlength_createddate,le.maxlength_updateddate,le.maxlength_expiresdate,le.maxlength_standardregcreateddate,le.maxlength_standardregupdateddate,le.maxlength_standardregexpiresdate,le.maxlength_status,le.maxlength_audit_auditupdateddate,le.maxlength_registrant_rawtext,le.maxlength_registrant_email,le.maxlength_registrant_name,le.maxlength_registrant_organization,le.maxlength_registrant_street1,le.maxlength_registrant_street2,le.maxlength_registrant_street3,le.maxlength_registrant_street4,le.maxlength_registrant_city,le.maxlength_registrant_state,le.maxlength_registrant_postalcode,le.maxlength_registrant_country,le.maxlength_registrant_fax,le.maxlength_registrant_faxext,le.maxlength_registrant_phone,le.maxlength_registrant_phoneext,le.maxlength_administrativecontact_rawtext,le.maxlength_administrativecontact_email,le.maxlength_administrativecontact_name,le.maxlength_administrativecontact_organization,le.maxlength_administrativecontact_street1,le.maxlength_administrativecontact_street2,le.maxlength_administrativecontact_street3,le.maxlength_administrativecontact_street4,le.maxlength_administrativecontact_city,le.maxlength_administrativecontact_state,le.maxlength_administrativecontact_postalcode,le.maxlength_administrativecontact_country,le.maxlength_administrativecontact_fax,le.maxlength_administrativecontact_faxext,le.maxlength_administrativecontact_phone,le.maxlength_administrativecontact_phoneext,le.maxlength_billingcontact_rawtext,le.maxlength_billingcontact_email,le.maxlength_billingcontact_name,le.maxlength_billingcontact_organization,le.maxlength_billingcontact_street1,le.maxlength_billingcontact_street2,le.maxlength_billingcontact_street3,le.maxlength_billingcontact_street4,le.maxlength_billingcontact_city,le.maxlength_billingcontact_state,le.maxlength_billingcontact_postalcode,le.maxlength_billingcontact_country,le.maxlength_billingcontact_fax,le.maxlength_billingcontact_faxext,le.maxlength_billingcontact_phone,le.maxlength_billingcontact_phoneext,le.maxlength_technicalcontact_rawtext,le.maxlength_technicalcontact_email,le.maxlength_technicalcontact_name,le.maxlength_technicalcontact_organization,le.maxlength_technicalcontact_street1,le.maxlength_technicalcontact_street2,le.maxlength_technicalcontact_street3,le.maxlength_technicalcontact_street4,le.maxlength_technicalcontact_city,le.maxlength_technicalcontact_state,le.maxlength_technicalcontact_postalcode,le.maxlength_technicalcontact_country,le.maxlength_technicalcontact_fax,le.maxlength_technicalcontact_faxext,le.maxlength_technicalcontact_phone,le.maxlength_technicalcontact_phoneext,le.maxlength_zonecontact_rawtext,le.maxlength_zonecontact_email,le.maxlength_zonecontact_name,le.maxlength_zonecontact_organization,le.maxlength_zonecontact_street1,le.maxlength_zonecontact_street2,le.maxlength_zonecontact_street3,le.maxlength_zonecontact_street4,le.maxlength_zonecontact_city,le.maxlength_zonecontact_state,le.maxlength_zonecontact_postalcode,le.maxlength_zonecontact_country,le.maxlength_zonecontact_fax,le.maxlength_zonecontact_faxext,le.maxlength_zonecontact_phone,le.maxlength_zonecontact_phoneext);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_did_score,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_clean_cname,le.avelength_current_rec,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_clean_title,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_rawaid,le.avelength_append_prep_address_situs,le.avelength_append_prep_address_last_situs,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_emailtype,le.avelength_rawtext,le.avelength_email,le.avelength_name,le.avelength_organization,le.avelength_street1,le.avelength_street2,le.avelength_street3,le.avelength_street4,le.avelength_city,le.avelength_state,le.avelength_postalcode,le.avelength_country,le.avelength_fax,le.avelength_faxext,le.avelength_phone,le.avelength_phoneext,le.avelength_domainname,le.avelength_registrarname,le.avelength_contactemail,le.avelength_whoisserver,le.avelength_nameservers,le.avelength_createddate,le.avelength_updateddate,le.avelength_expiresdate,le.avelength_standardregcreateddate,le.avelength_standardregupdateddate,le.avelength_standardregexpiresdate,le.avelength_status,le.avelength_audit_auditupdateddate,le.avelength_registrant_rawtext,le.avelength_registrant_email,le.avelength_registrant_name,le.avelength_registrant_organization,le.avelength_registrant_street1,le.avelength_registrant_street2,le.avelength_registrant_street3,le.avelength_registrant_street4,le.avelength_registrant_city,le.avelength_registrant_state,le.avelength_registrant_postalcode,le.avelength_registrant_country,le.avelength_registrant_fax,le.avelength_registrant_faxext,le.avelength_registrant_phone,le.avelength_registrant_phoneext,le.avelength_administrativecontact_rawtext,le.avelength_administrativecontact_email,le.avelength_administrativecontact_name,le.avelength_administrativecontact_organization,le.avelength_administrativecontact_street1,le.avelength_administrativecontact_street2,le.avelength_administrativecontact_street3,le.avelength_administrativecontact_street4,le.avelength_administrativecontact_city,le.avelength_administrativecontact_state,le.avelength_administrativecontact_postalcode,le.avelength_administrativecontact_country,le.avelength_administrativecontact_fax,le.avelength_administrativecontact_faxext,le.avelength_administrativecontact_phone,le.avelength_administrativecontact_phoneext,le.avelength_billingcontact_rawtext,le.avelength_billingcontact_email,le.avelength_billingcontact_name,le.avelength_billingcontact_organization,le.avelength_billingcontact_street1,le.avelength_billingcontact_street2,le.avelength_billingcontact_street3,le.avelength_billingcontact_street4,le.avelength_billingcontact_city,le.avelength_billingcontact_state,le.avelength_billingcontact_postalcode,le.avelength_billingcontact_country,le.avelength_billingcontact_fax,le.avelength_billingcontact_faxext,le.avelength_billingcontact_phone,le.avelength_billingcontact_phoneext,le.avelength_technicalcontact_rawtext,le.avelength_technicalcontact_email,le.avelength_technicalcontact_name,le.avelength_technicalcontact_organization,le.avelength_technicalcontact_street1,le.avelength_technicalcontact_street2,le.avelength_technicalcontact_street3,le.avelength_technicalcontact_street4,le.avelength_technicalcontact_city,le.avelength_technicalcontact_state,le.avelength_technicalcontact_postalcode,le.avelength_technicalcontact_country,le.avelength_technicalcontact_fax,le.avelength_technicalcontact_faxext,le.avelength_technicalcontact_phone,le.avelength_technicalcontact_phoneext,le.avelength_zonecontact_rawtext,le.avelength_zonecontact_email,le.avelength_zonecontact_name,le.avelength_zonecontact_organization,le.avelength_zonecontact_street1,le.avelength_zonecontact_street2,le.avelength_zonecontact_street3,le.avelength_zonecontact_street4,le.avelength_zonecontact_city,le.avelength_zonecontact_state,le.avelength_zonecontact_postalcode,le.avelength_zonecontact_country,le.avelength_zonecontact_fax,le.avelength_zonecontact_faxext,le.avelength_zonecontact_phone,le.avelength_zonecontact_phoneext);
END;
EXPORT invSummary := NORMALIZE(summary0, 175, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.clean_cname),TRIM((SALT311.StrType)le.current_rec),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),TRIM((SALT311.StrType)le.clean_title),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.append_prep_address_situs),TRIM((SALT311.StrType)le.append_prep_address_last_situs),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.emailtype),TRIM((SALT311.StrType)le.rawtext),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.organization),TRIM((SALT311.StrType)le.street1),TRIM((SALT311.StrType)le.street2),TRIM((SALT311.StrType)le.street3),TRIM((SALT311.StrType)le.street4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.faxext),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phoneext),TRIM((SALT311.StrType)le.domainname),TRIM((SALT311.StrType)le.registrarname),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.whoisserver),TRIM((SALT311.StrType)le.nameservers),TRIM((SALT311.StrType)le.createddate),TRIM((SALT311.StrType)le.updateddate),TRIM((SALT311.StrType)le.expiresdate),TRIM((SALT311.StrType)le.standardregcreateddate),TRIM((SALT311.StrType)le.standardregupdateddate),TRIM((SALT311.StrType)le.standardregexpiresdate),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.audit_auditupdateddate),TRIM((SALT311.StrType)le.registrant_rawtext),TRIM((SALT311.StrType)le.registrant_email),TRIM((SALT311.StrType)le.registrant_name),TRIM((SALT311.StrType)le.registrant_organization),TRIM((SALT311.StrType)le.registrant_street1),TRIM((SALT311.StrType)le.registrant_street2),TRIM((SALT311.StrType)le.registrant_street3),TRIM((SALT311.StrType)le.registrant_street4),TRIM((SALT311.StrType)le.registrant_city),TRIM((SALT311.StrType)le.registrant_state),TRIM((SALT311.StrType)le.registrant_postalcode),TRIM((SALT311.StrType)le.registrant_country),TRIM((SALT311.StrType)le.registrant_fax),TRIM((SALT311.StrType)le.registrant_faxext),TRIM((SALT311.StrType)le.registrant_phone),TRIM((SALT311.StrType)le.registrant_phoneext),TRIM((SALT311.StrType)le.administrativecontact_rawtext),TRIM((SALT311.StrType)le.administrativecontact_email),TRIM((SALT311.StrType)le.administrativecontact_name),TRIM((SALT311.StrType)le.administrativecontact_organization),TRIM((SALT311.StrType)le.administrativecontact_street1),TRIM((SALT311.StrType)le.administrativecontact_street2),TRIM((SALT311.StrType)le.administrativecontact_street3),TRIM((SALT311.StrType)le.administrativecontact_street4),TRIM((SALT311.StrType)le.administrativecontact_city),TRIM((SALT311.StrType)le.administrativecontact_state),TRIM((SALT311.StrType)le.administrativecontact_postalcode),TRIM((SALT311.StrType)le.administrativecontact_country),TRIM((SALT311.StrType)le.administrativecontact_fax),TRIM((SALT311.StrType)le.administrativecontact_faxext),TRIM((SALT311.StrType)le.administrativecontact_phone),TRIM((SALT311.StrType)le.administrativecontact_phoneext),TRIM((SALT311.StrType)le.billingcontact_rawtext),TRIM((SALT311.StrType)le.billingcontact_email),TRIM((SALT311.StrType)le.billingcontact_name),TRIM((SALT311.StrType)le.billingcontact_organization),TRIM((SALT311.StrType)le.billingcontact_street1),TRIM((SALT311.StrType)le.billingcontact_street2),TRIM((SALT311.StrType)le.billingcontact_street3),TRIM((SALT311.StrType)le.billingcontact_street4),TRIM((SALT311.StrType)le.billingcontact_city),TRIM((SALT311.StrType)le.billingcontact_state),TRIM((SALT311.StrType)le.billingcontact_postalcode),TRIM((SALT311.StrType)le.billingcontact_country),TRIM((SALT311.StrType)le.billingcontact_fax),TRIM((SALT311.StrType)le.billingcontact_faxext),TRIM((SALT311.StrType)le.billingcontact_phone),TRIM((SALT311.StrType)le.billingcontact_phoneext),TRIM((SALT311.StrType)le.technicalcontact_rawtext),TRIM((SALT311.StrType)le.technicalcontact_email),TRIM((SALT311.StrType)le.technicalcontact_name),TRIM((SALT311.StrType)le.technicalcontact_organization),TRIM((SALT311.StrType)le.technicalcontact_street1),TRIM((SALT311.StrType)le.technicalcontact_street2),TRIM((SALT311.StrType)le.technicalcontact_street3),TRIM((SALT311.StrType)le.technicalcontact_street4),TRIM((SALT311.StrType)le.technicalcontact_city),TRIM((SALT311.StrType)le.technicalcontact_state),TRIM((SALT311.StrType)le.technicalcontact_postalcode),TRIM((SALT311.StrType)le.technicalcontact_country),TRIM((SALT311.StrType)le.technicalcontact_fax),TRIM((SALT311.StrType)le.technicalcontact_faxext),TRIM((SALT311.StrType)le.technicalcontact_phone),TRIM((SALT311.StrType)le.technicalcontact_phoneext),TRIM((SALT311.StrType)le.zonecontact_rawtext),TRIM((SALT311.StrType)le.zonecontact_email),TRIM((SALT311.StrType)le.zonecontact_name),TRIM((SALT311.StrType)le.zonecontact_organization),TRIM((SALT311.StrType)le.zonecontact_street1),TRIM((SALT311.StrType)le.zonecontact_street2),TRIM((SALT311.StrType)le.zonecontact_street3),TRIM((SALT311.StrType)le.zonecontact_street4),TRIM((SALT311.StrType)le.zonecontact_city),TRIM((SALT311.StrType)le.zonecontact_state),TRIM((SALT311.StrType)le.zonecontact_postalcode),TRIM((SALT311.StrType)le.zonecontact_country),TRIM((SALT311.StrType)le.zonecontact_fax),TRIM((SALT311.StrType)le.zonecontact_faxext),TRIM((SALT311.StrType)le.zonecontact_phone),TRIM((SALT311.StrType)le.zonecontact_phoneext)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,175,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 175);
  SELF.FldNo2 := 1 + (C % 175);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.clean_cname),TRIM((SALT311.StrType)le.current_rec),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),TRIM((SALT311.StrType)le.clean_title),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.append_prep_address_situs),TRIM((SALT311.StrType)le.append_prep_address_last_situs),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.emailtype),TRIM((SALT311.StrType)le.rawtext),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.organization),TRIM((SALT311.StrType)le.street1),TRIM((SALT311.StrType)le.street2),TRIM((SALT311.StrType)le.street3),TRIM((SALT311.StrType)le.street4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.faxext),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phoneext),TRIM((SALT311.StrType)le.domainname),TRIM((SALT311.StrType)le.registrarname),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.whoisserver),TRIM((SALT311.StrType)le.nameservers),TRIM((SALT311.StrType)le.createddate),TRIM((SALT311.StrType)le.updateddate),TRIM((SALT311.StrType)le.expiresdate),TRIM((SALT311.StrType)le.standardregcreateddate),TRIM((SALT311.StrType)le.standardregupdateddate),TRIM((SALT311.StrType)le.standardregexpiresdate),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.audit_auditupdateddate),TRIM((SALT311.StrType)le.registrant_rawtext),TRIM((SALT311.StrType)le.registrant_email),TRIM((SALT311.StrType)le.registrant_name),TRIM((SALT311.StrType)le.registrant_organization),TRIM((SALT311.StrType)le.registrant_street1),TRIM((SALT311.StrType)le.registrant_street2),TRIM((SALT311.StrType)le.registrant_street3),TRIM((SALT311.StrType)le.registrant_street4),TRIM((SALT311.StrType)le.registrant_city),TRIM((SALT311.StrType)le.registrant_state),TRIM((SALT311.StrType)le.registrant_postalcode),TRIM((SALT311.StrType)le.registrant_country),TRIM((SALT311.StrType)le.registrant_fax),TRIM((SALT311.StrType)le.registrant_faxext),TRIM((SALT311.StrType)le.registrant_phone),TRIM((SALT311.StrType)le.registrant_phoneext),TRIM((SALT311.StrType)le.administrativecontact_rawtext),TRIM((SALT311.StrType)le.administrativecontact_email),TRIM((SALT311.StrType)le.administrativecontact_name),TRIM((SALT311.StrType)le.administrativecontact_organization),TRIM((SALT311.StrType)le.administrativecontact_street1),TRIM((SALT311.StrType)le.administrativecontact_street2),TRIM((SALT311.StrType)le.administrativecontact_street3),TRIM((SALT311.StrType)le.administrativecontact_street4),TRIM((SALT311.StrType)le.administrativecontact_city),TRIM((SALT311.StrType)le.administrativecontact_state),TRIM((SALT311.StrType)le.administrativecontact_postalcode),TRIM((SALT311.StrType)le.administrativecontact_country),TRIM((SALT311.StrType)le.administrativecontact_fax),TRIM((SALT311.StrType)le.administrativecontact_faxext),TRIM((SALT311.StrType)le.administrativecontact_phone),TRIM((SALT311.StrType)le.administrativecontact_phoneext),TRIM((SALT311.StrType)le.billingcontact_rawtext),TRIM((SALT311.StrType)le.billingcontact_email),TRIM((SALT311.StrType)le.billingcontact_name),TRIM((SALT311.StrType)le.billingcontact_organization),TRIM((SALT311.StrType)le.billingcontact_street1),TRIM((SALT311.StrType)le.billingcontact_street2),TRIM((SALT311.StrType)le.billingcontact_street3),TRIM((SALT311.StrType)le.billingcontact_street4),TRIM((SALT311.StrType)le.billingcontact_city),TRIM((SALT311.StrType)le.billingcontact_state),TRIM((SALT311.StrType)le.billingcontact_postalcode),TRIM((SALT311.StrType)le.billingcontact_country),TRIM((SALT311.StrType)le.billingcontact_fax),TRIM((SALT311.StrType)le.billingcontact_faxext),TRIM((SALT311.StrType)le.billingcontact_phone),TRIM((SALT311.StrType)le.billingcontact_phoneext),TRIM((SALT311.StrType)le.technicalcontact_rawtext),TRIM((SALT311.StrType)le.technicalcontact_email),TRIM((SALT311.StrType)le.technicalcontact_name),TRIM((SALT311.StrType)le.technicalcontact_organization),TRIM((SALT311.StrType)le.technicalcontact_street1),TRIM((SALT311.StrType)le.technicalcontact_street2),TRIM((SALT311.StrType)le.technicalcontact_street3),TRIM((SALT311.StrType)le.technicalcontact_street4),TRIM((SALT311.StrType)le.technicalcontact_city),TRIM((SALT311.StrType)le.technicalcontact_state),TRIM((SALT311.StrType)le.technicalcontact_postalcode),TRIM((SALT311.StrType)le.technicalcontact_country),TRIM((SALT311.StrType)le.technicalcontact_fax),TRIM((SALT311.StrType)le.technicalcontact_faxext),TRIM((SALT311.StrType)le.technicalcontact_phone),TRIM((SALT311.StrType)le.technicalcontact_phoneext),TRIM((SALT311.StrType)le.zonecontact_rawtext),TRIM((SALT311.StrType)le.zonecontact_email),TRIM((SALT311.StrType)le.zonecontact_name),TRIM((SALT311.StrType)le.zonecontact_organization),TRIM((SALT311.StrType)le.zonecontact_street1),TRIM((SALT311.StrType)le.zonecontact_street2),TRIM((SALT311.StrType)le.zonecontact_street3),TRIM((SALT311.StrType)le.zonecontact_street4),TRIM((SALT311.StrType)le.zonecontact_city),TRIM((SALT311.StrType)le.zonecontact_state),TRIM((SALT311.StrType)le.zonecontact_postalcode),TRIM((SALT311.StrType)le.zonecontact_country),TRIM((SALT311.StrType)le.zonecontact_fax),TRIM((SALT311.StrType)le.zonecontact_faxext),TRIM((SALT311.StrType)le.zonecontact_phone),TRIM((SALT311.StrType)le.zonecontact_phoneext)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.clean_cname),TRIM((SALT311.StrType)le.current_rec),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),TRIM((SALT311.StrType)le.clean_title),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname),TRIM((SALT311.StrType)le.clean_name_suffix),TRIM((SALT311.StrType)le.clean_name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.append_prep_address_situs),TRIM((SALT311.StrType)le.append_prep_address_last_situs),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.emailtype),TRIM((SALT311.StrType)le.rawtext),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.organization),TRIM((SALT311.StrType)le.street1),TRIM((SALT311.StrType)le.street2),TRIM((SALT311.StrType)le.street3),TRIM((SALT311.StrType)le.street4),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.faxext),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phoneext),TRIM((SALT311.StrType)le.domainname),TRIM((SALT311.StrType)le.registrarname),TRIM((SALT311.StrType)le.contactemail),TRIM((SALT311.StrType)le.whoisserver),TRIM((SALT311.StrType)le.nameservers),TRIM((SALT311.StrType)le.createddate),TRIM((SALT311.StrType)le.updateddate),TRIM((SALT311.StrType)le.expiresdate),TRIM((SALT311.StrType)le.standardregcreateddate),TRIM((SALT311.StrType)le.standardregupdateddate),TRIM((SALT311.StrType)le.standardregexpiresdate),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.audit_auditupdateddate),TRIM((SALT311.StrType)le.registrant_rawtext),TRIM((SALT311.StrType)le.registrant_email),TRIM((SALT311.StrType)le.registrant_name),TRIM((SALT311.StrType)le.registrant_organization),TRIM((SALT311.StrType)le.registrant_street1),TRIM((SALT311.StrType)le.registrant_street2),TRIM((SALT311.StrType)le.registrant_street3),TRIM((SALT311.StrType)le.registrant_street4),TRIM((SALT311.StrType)le.registrant_city),TRIM((SALT311.StrType)le.registrant_state),TRIM((SALT311.StrType)le.registrant_postalcode),TRIM((SALT311.StrType)le.registrant_country),TRIM((SALT311.StrType)le.registrant_fax),TRIM((SALT311.StrType)le.registrant_faxext),TRIM((SALT311.StrType)le.registrant_phone),TRIM((SALT311.StrType)le.registrant_phoneext),TRIM((SALT311.StrType)le.administrativecontact_rawtext),TRIM((SALT311.StrType)le.administrativecontact_email),TRIM((SALT311.StrType)le.administrativecontact_name),TRIM((SALT311.StrType)le.administrativecontact_organization),TRIM((SALT311.StrType)le.administrativecontact_street1),TRIM((SALT311.StrType)le.administrativecontact_street2),TRIM((SALT311.StrType)le.administrativecontact_street3),TRIM((SALT311.StrType)le.administrativecontact_street4),TRIM((SALT311.StrType)le.administrativecontact_city),TRIM((SALT311.StrType)le.administrativecontact_state),TRIM((SALT311.StrType)le.administrativecontact_postalcode),TRIM((SALT311.StrType)le.administrativecontact_country),TRIM((SALT311.StrType)le.administrativecontact_fax),TRIM((SALT311.StrType)le.administrativecontact_faxext),TRIM((SALT311.StrType)le.administrativecontact_phone),TRIM((SALT311.StrType)le.administrativecontact_phoneext),TRIM((SALT311.StrType)le.billingcontact_rawtext),TRIM((SALT311.StrType)le.billingcontact_email),TRIM((SALT311.StrType)le.billingcontact_name),TRIM((SALT311.StrType)le.billingcontact_organization),TRIM((SALT311.StrType)le.billingcontact_street1),TRIM((SALT311.StrType)le.billingcontact_street2),TRIM((SALT311.StrType)le.billingcontact_street3),TRIM((SALT311.StrType)le.billingcontact_street4),TRIM((SALT311.StrType)le.billingcontact_city),TRIM((SALT311.StrType)le.billingcontact_state),TRIM((SALT311.StrType)le.billingcontact_postalcode),TRIM((SALT311.StrType)le.billingcontact_country),TRIM((SALT311.StrType)le.billingcontact_fax),TRIM((SALT311.StrType)le.billingcontact_faxext),TRIM((SALT311.StrType)le.billingcontact_phone),TRIM((SALT311.StrType)le.billingcontact_phoneext),TRIM((SALT311.StrType)le.technicalcontact_rawtext),TRIM((SALT311.StrType)le.technicalcontact_email),TRIM((SALT311.StrType)le.technicalcontact_name),TRIM((SALT311.StrType)le.technicalcontact_organization),TRIM((SALT311.StrType)le.technicalcontact_street1),TRIM((SALT311.StrType)le.technicalcontact_street2),TRIM((SALT311.StrType)le.technicalcontact_street3),TRIM((SALT311.StrType)le.technicalcontact_street4),TRIM((SALT311.StrType)le.technicalcontact_city),TRIM((SALT311.StrType)le.technicalcontact_state),TRIM((SALT311.StrType)le.technicalcontact_postalcode),TRIM((SALT311.StrType)le.technicalcontact_country),TRIM((SALT311.StrType)le.technicalcontact_fax),TRIM((SALT311.StrType)le.technicalcontact_faxext),TRIM((SALT311.StrType)le.technicalcontact_phone),TRIM((SALT311.StrType)le.technicalcontact_phoneext),TRIM((SALT311.StrType)le.zonecontact_rawtext),TRIM((SALT311.StrType)le.zonecontact_email),TRIM((SALT311.StrType)le.zonecontact_name),TRIM((SALT311.StrType)le.zonecontact_organization),TRIM((SALT311.StrType)le.zonecontact_street1),TRIM((SALT311.StrType)le.zonecontact_street2),TRIM((SALT311.StrType)le.zonecontact_street3),TRIM((SALT311.StrType)le.zonecontact_street4),TRIM((SALT311.StrType)le.zonecontact_city),TRIM((SALT311.StrType)le.zonecontact_state),TRIM((SALT311.StrType)le.zonecontact_postalcode),TRIM((SALT311.StrType)le.zonecontact_country),TRIM((SALT311.StrType)le.zonecontact_fax),TRIM((SALT311.StrType)le.zonecontact_faxext),TRIM((SALT311.StrType)le.zonecontact_phone),TRIM((SALT311.StrType)le.zonecontact_phoneext)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),175*175,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'did_score'}
      ,{3,'process_date'}
      ,{4,'date_first_seen'}
      ,{5,'date_last_seen'}
      ,{6,'date_vendor_first_reported'}
      ,{7,'date_vendor_last_reported'}
      ,{8,'clean_cname'}
      ,{9,'current_rec'}
      ,{10,'dotid'}
      ,{11,'dotscore'}
      ,{12,'dotweight'}
      ,{13,'empid'}
      ,{14,'empscore'}
      ,{15,'empweight'}
      ,{16,'powid'}
      ,{17,'powscore'}
      ,{18,'powweight'}
      ,{19,'proxid'}
      ,{20,'proxscore'}
      ,{21,'proxweight'}
      ,{22,'seleid'}
      ,{23,'selescore'}
      ,{24,'seleweight'}
      ,{25,'orgid'}
      ,{26,'orgscore'}
      ,{27,'orgweight'}
      ,{28,'ultid'}
      ,{29,'ultscore'}
      ,{30,'ultweight'}
      ,{31,'clean_title'}
      ,{32,'clean_fname'}
      ,{33,'clean_mname'}
      ,{34,'clean_lname'}
      ,{35,'clean_name_suffix'}
      ,{36,'clean_name_score'}
      ,{37,'rawaid'}
      ,{38,'append_prep_address_situs'}
      ,{39,'append_prep_address_last_situs'}
      ,{40,'prim_range'}
      ,{41,'predir'}
      ,{42,'prim_name'}
      ,{43,'addr_suffix'}
      ,{44,'postdir'}
      ,{45,'unit_desig'}
      ,{46,'sec_range'}
      ,{47,'p_city_name'}
      ,{48,'v_city_name'}
      ,{49,'st'}
      ,{50,'zip'}
      ,{51,'zip4'}
      ,{52,'cart'}
      ,{53,'cr_sort_sz'}
      ,{54,'lot'}
      ,{55,'lot_order'}
      ,{56,'dbpc'}
      ,{57,'chk_digit'}
      ,{58,'rec_type'}
      ,{59,'county'}
      ,{60,'geo_lat'}
      ,{61,'geo_long'}
      ,{62,'msa'}
      ,{63,'geo_blk'}
      ,{64,'geo_match'}
      ,{65,'err_stat'}
      ,{66,'emailtype'}
      ,{67,'rawtext'}
      ,{68,'email'}
      ,{69,'name'}
      ,{70,'organization'}
      ,{71,'street1'}
      ,{72,'street2'}
      ,{73,'street3'}
      ,{74,'street4'}
      ,{75,'city'}
      ,{76,'state'}
      ,{77,'postalcode'}
      ,{78,'country'}
      ,{79,'fax'}
      ,{80,'faxext'}
      ,{81,'phone'}
      ,{82,'phoneext'}
      ,{83,'domainname'}
      ,{84,'registrarname'}
      ,{85,'contactemail'}
      ,{86,'whoisserver'}
      ,{87,'nameservers'}
      ,{88,'createddate'}
      ,{89,'updateddate'}
      ,{90,'expiresdate'}
      ,{91,'standardregcreateddate'}
      ,{92,'standardregupdateddate'}
      ,{93,'standardregexpiresdate'}
      ,{94,'status'}
      ,{95,'audit_auditupdateddate'}
      ,{96,'registrant_rawtext'}
      ,{97,'registrant_email'}
      ,{98,'registrant_name'}
      ,{99,'registrant_organization'}
      ,{100,'registrant_street1'}
      ,{101,'registrant_street2'}
      ,{102,'registrant_street3'}
      ,{103,'registrant_street4'}
      ,{104,'registrant_city'}
      ,{105,'registrant_state'}
      ,{106,'registrant_postalcode'}
      ,{107,'registrant_country'}
      ,{108,'registrant_fax'}
      ,{109,'registrant_faxext'}
      ,{110,'registrant_phone'}
      ,{111,'registrant_phoneext'}
      ,{112,'administrativecontact_rawtext'}
      ,{113,'administrativecontact_email'}
      ,{114,'administrativecontact_name'}
      ,{115,'administrativecontact_organization'}
      ,{116,'administrativecontact_street1'}
      ,{117,'administrativecontact_street2'}
      ,{118,'administrativecontact_street3'}
      ,{119,'administrativecontact_street4'}
      ,{120,'administrativecontact_city'}
      ,{121,'administrativecontact_state'}
      ,{122,'administrativecontact_postalcode'}
      ,{123,'administrativecontact_country'}
      ,{124,'administrativecontact_fax'}
      ,{125,'administrativecontact_faxext'}
      ,{126,'administrativecontact_phone'}
      ,{127,'administrativecontact_phoneext'}
      ,{128,'billingcontact_rawtext'}
      ,{129,'billingcontact_email'}
      ,{130,'billingcontact_name'}
      ,{131,'billingcontact_organization'}
      ,{132,'billingcontact_street1'}
      ,{133,'billingcontact_street2'}
      ,{134,'billingcontact_street3'}
      ,{135,'billingcontact_street4'}
      ,{136,'billingcontact_city'}
      ,{137,'billingcontact_state'}
      ,{138,'billingcontact_postalcode'}
      ,{139,'billingcontact_country'}
      ,{140,'billingcontact_fax'}
      ,{141,'billingcontact_faxext'}
      ,{142,'billingcontact_phone'}
      ,{143,'billingcontact_phoneext'}
      ,{144,'technicalcontact_rawtext'}
      ,{145,'technicalcontact_email'}
      ,{146,'technicalcontact_name'}
      ,{147,'technicalcontact_organization'}
      ,{148,'technicalcontact_street1'}
      ,{149,'technicalcontact_street2'}
      ,{150,'technicalcontact_street3'}
      ,{151,'technicalcontact_street4'}
      ,{152,'technicalcontact_city'}
      ,{153,'technicalcontact_state'}
      ,{154,'technicalcontact_postalcode'}
      ,{155,'technicalcontact_country'}
      ,{156,'technicalcontact_fax'}
      ,{157,'technicalcontact_faxext'}
      ,{158,'technicalcontact_phone'}
      ,{159,'technicalcontact_phoneext'}
      ,{160,'zonecontact_rawtext'}
      ,{161,'zonecontact_email'}
      ,{162,'zonecontact_name'}
      ,{163,'zonecontact_organization'}
      ,{164,'zonecontact_street1'}
      ,{165,'zonecontact_street2'}
      ,{166,'zonecontact_street3'}
      ,{167,'zonecontact_street4'}
      ,{168,'zonecontact_city'}
      ,{169,'zonecontact_state'}
      ,{170,'zonecontact_postalcode'}
      ,{171,'zonecontact_country'}
      ,{172,'zonecontact_fax'}
      ,{173,'zonecontact_faxext'}
      ,{174,'zonecontact_phone'}
      ,{175,'zonecontact_phoneext'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_clean_cname((SALT311.StrType)le.clean_cname),
    Fields.InValid_current_rec((SALT311.StrType)le.current_rec),
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
    Fields.InValid_clean_title((SALT311.StrType)le.clean_title),
    Fields.InValid_clean_fname((SALT311.StrType)le.clean_fname),
    Fields.InValid_clean_mname((SALT311.StrType)le.clean_mname),
    Fields.InValid_clean_lname((SALT311.StrType)le.clean_lname),
    Fields.InValid_clean_name_suffix((SALT311.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT311.StrType)le.clean_name_score),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_append_prep_address_situs((SALT311.StrType)le.append_prep_address_situs),
    Fields.InValid_append_prep_address_last_situs((SALT311.StrType)le.append_prep_address_last_situs),
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
    Fields.InValid_emailtype((SALT311.StrType)le.emailtype),
    Fields.InValid_rawtext((SALT311.StrType)le.rawtext),
    Fields.InValid_email((SALT311.StrType)le.email),
    Fields.InValid_name((SALT311.StrType)le.name),
    Fields.InValid_organization((SALT311.StrType)le.organization),
    Fields.InValid_street1((SALT311.StrType)le.street1),
    Fields.InValid_street2((SALT311.StrType)le.street2),
    Fields.InValid_street3((SALT311.StrType)le.street3),
    Fields.InValid_street4((SALT311.StrType)le.street4),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_postalcode((SALT311.StrType)le.postalcode),
    Fields.InValid_country((SALT311.StrType)le.country),
    Fields.InValid_fax((SALT311.StrType)le.fax),
    Fields.InValid_faxext((SALT311.StrType)le.faxext),
    Fields.InValid_phone((SALT311.StrType)le.phone),
    Fields.InValid_phoneext((SALT311.StrType)le.phoneext),
    Fields.InValid_domainname((SALT311.StrType)le.domainname),
    Fields.InValid_registrarname((SALT311.StrType)le.registrarname),
    Fields.InValid_contactemail((SALT311.StrType)le.contactemail),
    Fields.InValid_whoisserver((SALT311.StrType)le.whoisserver),
    Fields.InValid_nameservers((SALT311.StrType)le.nameservers),
    Fields.InValid_createddate((SALT311.StrType)le.createddate),
    Fields.InValid_updateddate((SALT311.StrType)le.updateddate),
    Fields.InValid_expiresdate((SALT311.StrType)le.expiresdate),
    Fields.InValid_standardregcreateddate((SALT311.StrType)le.standardregcreateddate),
    Fields.InValid_standardregupdateddate((SALT311.StrType)le.standardregupdateddate),
    Fields.InValid_standardregexpiresdate((SALT311.StrType)le.standardregexpiresdate),
    Fields.InValid_status((SALT311.StrType)le.status),
    Fields.InValid_audit_auditupdateddate((SALT311.StrType)le.audit_auditupdateddate),
    Fields.InValid_registrant_rawtext((SALT311.StrType)le.registrant_rawtext),
    Fields.InValid_registrant_email((SALT311.StrType)le.registrant_email),
    Fields.InValid_registrant_name((SALT311.StrType)le.registrant_name),
    Fields.InValid_registrant_organization((SALT311.StrType)le.registrant_organization),
    Fields.InValid_registrant_street1((SALT311.StrType)le.registrant_street1),
    Fields.InValid_registrant_street2((SALT311.StrType)le.registrant_street2),
    Fields.InValid_registrant_street3((SALT311.StrType)le.registrant_street3),
    Fields.InValid_registrant_street4((SALT311.StrType)le.registrant_street4),
    Fields.InValid_registrant_city((SALT311.StrType)le.registrant_city),
    Fields.InValid_registrant_state((SALT311.StrType)le.registrant_state),
    Fields.InValid_registrant_postalcode((SALT311.StrType)le.registrant_postalcode),
    Fields.InValid_registrant_country((SALT311.StrType)le.registrant_country),
    Fields.InValid_registrant_fax((SALT311.StrType)le.registrant_fax),
    Fields.InValid_registrant_faxext((SALT311.StrType)le.registrant_faxext),
    Fields.InValid_registrant_phone((SALT311.StrType)le.registrant_phone),
    Fields.InValid_registrant_phoneext((SALT311.StrType)le.registrant_phoneext),
    Fields.InValid_administrativecontact_rawtext((SALT311.StrType)le.administrativecontact_rawtext),
    Fields.InValid_administrativecontact_email((SALT311.StrType)le.administrativecontact_email),
    Fields.InValid_administrativecontact_name((SALT311.StrType)le.administrativecontact_name),
    Fields.InValid_administrativecontact_organization((SALT311.StrType)le.administrativecontact_organization),
    Fields.InValid_administrativecontact_street1((SALT311.StrType)le.administrativecontact_street1),
    Fields.InValid_administrativecontact_street2((SALT311.StrType)le.administrativecontact_street2),
    Fields.InValid_administrativecontact_street3((SALT311.StrType)le.administrativecontact_street3),
    Fields.InValid_administrativecontact_street4((SALT311.StrType)le.administrativecontact_street4),
    Fields.InValid_administrativecontact_city((SALT311.StrType)le.administrativecontact_city),
    Fields.InValid_administrativecontact_state((SALT311.StrType)le.administrativecontact_state),
    Fields.InValid_administrativecontact_postalcode((SALT311.StrType)le.administrativecontact_postalcode),
    Fields.InValid_administrativecontact_country((SALT311.StrType)le.administrativecontact_country),
    Fields.InValid_administrativecontact_fax((SALT311.StrType)le.administrativecontact_fax),
    Fields.InValid_administrativecontact_faxext((SALT311.StrType)le.administrativecontact_faxext),
    Fields.InValid_administrativecontact_phone((SALT311.StrType)le.administrativecontact_phone),
    Fields.InValid_administrativecontact_phoneext((SALT311.StrType)le.administrativecontact_phoneext),
    Fields.InValid_billingcontact_rawtext((SALT311.StrType)le.billingcontact_rawtext),
    Fields.InValid_billingcontact_email((SALT311.StrType)le.billingcontact_email),
    Fields.InValid_billingcontact_name((SALT311.StrType)le.billingcontact_name),
    Fields.InValid_billingcontact_organization((SALT311.StrType)le.billingcontact_organization),
    Fields.InValid_billingcontact_street1((SALT311.StrType)le.billingcontact_street1),
    Fields.InValid_billingcontact_street2((SALT311.StrType)le.billingcontact_street2),
    Fields.InValid_billingcontact_street3((SALT311.StrType)le.billingcontact_street3),
    Fields.InValid_billingcontact_street4((SALT311.StrType)le.billingcontact_street4),
    Fields.InValid_billingcontact_city((SALT311.StrType)le.billingcontact_city),
    Fields.InValid_billingcontact_state((SALT311.StrType)le.billingcontact_state),
    Fields.InValid_billingcontact_postalcode((SALT311.StrType)le.billingcontact_postalcode),
    Fields.InValid_billingcontact_country((SALT311.StrType)le.billingcontact_country),
    Fields.InValid_billingcontact_fax((SALT311.StrType)le.billingcontact_fax),
    Fields.InValid_billingcontact_faxext((SALT311.StrType)le.billingcontact_faxext),
    Fields.InValid_billingcontact_phone((SALT311.StrType)le.billingcontact_phone),
    Fields.InValid_billingcontact_phoneext((SALT311.StrType)le.billingcontact_phoneext),
    Fields.InValid_technicalcontact_rawtext((SALT311.StrType)le.technicalcontact_rawtext),
    Fields.InValid_technicalcontact_email((SALT311.StrType)le.technicalcontact_email),
    Fields.InValid_technicalcontact_name((SALT311.StrType)le.technicalcontact_name),
    Fields.InValid_technicalcontact_organization((SALT311.StrType)le.technicalcontact_organization),
    Fields.InValid_technicalcontact_street1((SALT311.StrType)le.technicalcontact_street1),
    Fields.InValid_technicalcontact_street2((SALT311.StrType)le.technicalcontact_street2),
    Fields.InValid_technicalcontact_street3((SALT311.StrType)le.technicalcontact_street3),
    Fields.InValid_technicalcontact_street4((SALT311.StrType)le.technicalcontact_street4),
    Fields.InValid_technicalcontact_city((SALT311.StrType)le.technicalcontact_city),
    Fields.InValid_technicalcontact_state((SALT311.StrType)le.technicalcontact_state),
    Fields.InValid_technicalcontact_postalcode((SALT311.StrType)le.technicalcontact_postalcode),
    Fields.InValid_technicalcontact_country((SALT311.StrType)le.technicalcontact_country),
    Fields.InValid_technicalcontact_fax((SALT311.StrType)le.technicalcontact_fax),
    Fields.InValid_technicalcontact_faxext((SALT311.StrType)le.technicalcontact_faxext),
    Fields.InValid_technicalcontact_phone((SALT311.StrType)le.technicalcontact_phone),
    Fields.InValid_technicalcontact_phoneext((SALT311.StrType)le.technicalcontact_phoneext),
    Fields.InValid_zonecontact_rawtext((SALT311.StrType)le.zonecontact_rawtext),
    Fields.InValid_zonecontact_email((SALT311.StrType)le.zonecontact_email),
    Fields.InValid_zonecontact_name((SALT311.StrType)le.zonecontact_name),
    Fields.InValid_zonecontact_organization((SALT311.StrType)le.zonecontact_organization),
    Fields.InValid_zonecontact_street1((SALT311.StrType)le.zonecontact_street1),
    Fields.InValid_zonecontact_street2((SALT311.StrType)le.zonecontact_street2),
    Fields.InValid_zonecontact_street3((SALT311.StrType)le.zonecontact_street3),
    Fields.InValid_zonecontact_street4((SALT311.StrType)le.zonecontact_street4),
    Fields.InValid_zonecontact_city((SALT311.StrType)le.zonecontact_city),
    Fields.InValid_zonecontact_state((SALT311.StrType)le.zonecontact_state),
    Fields.InValid_zonecontact_postalcode((SALT311.StrType)le.zonecontact_postalcode),
    Fields.InValid_zonecontact_country((SALT311.StrType)le.zonecontact_country),
    Fields.InValid_zonecontact_fax((SALT311.StrType)le.zonecontact_fax),
    Fields.InValid_zonecontact_faxext((SALT311.StrType)le.zonecontact_faxext),
    Fields.InValid_zonecontact_phone((SALT311.StrType)le.zonecontact_phone),
    Fields.InValid_zonecontact_phoneext((SALT311.StrType)le.zonecontact_phoneext),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,175,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cname(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_clean_title(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_situs(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_last_situs(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_emailtype(TotalErrors.ErrorNum),Fields.InValidMessage_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_organization(TotalErrors.ErrorNum),Fields.InValidMessage_street1(TotalErrors.ErrorNum),Fields.InValidMessage_street2(TotalErrors.ErrorNum),Fields.InValidMessage_street3(TotalErrors.ErrorNum),Fields.InValidMessage_street4(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_fax(TotalErrors.ErrorNum),Fields.InValidMessage_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phoneext(TotalErrors.ErrorNum),Fields.InValidMessage_domainname(TotalErrors.ErrorNum),Fields.InValidMessage_registrarname(TotalErrors.ErrorNum),Fields.InValidMessage_contactemail(TotalErrors.ErrorNum),Fields.InValidMessage_whoisserver(TotalErrors.ErrorNum),Fields.InValidMessage_nameservers(TotalErrors.ErrorNum),Fields.InValidMessage_createddate(TotalErrors.ErrorNum),Fields.InValidMessage_updateddate(TotalErrors.ErrorNum),Fields.InValidMessage_expiresdate(TotalErrors.ErrorNum),Fields.InValidMessage_standardregcreateddate(TotalErrors.ErrorNum),Fields.InValidMessage_standardregupdateddate(TotalErrors.ErrorNum),Fields.InValidMessage_standardregexpiresdate(TotalErrors.ErrorNum),Fields.InValidMessage_status(TotalErrors.ErrorNum),Fields.InValidMessage_audit_auditupdateddate(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_email(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_name(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_organization(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_street1(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_street2(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_street3(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_street4(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_city(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_state(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_country(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_fax(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_phone(TotalErrors.ErrorNum),Fields.InValidMessage_registrant_phoneext(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_email(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_name(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_organization(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_street1(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_street2(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_street3(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_street4(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_city(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_state(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_country(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_fax(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_administrativecontact_phoneext(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_email(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_name(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_organization(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_street1(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_street2(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_street3(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_street4(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_city(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_state(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_country(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_fax(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_billingcontact_phoneext(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_email(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_name(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_organization(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_street1(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_street2(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_street3(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_street4(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_city(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_state(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_country(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_fax(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_technicalcontact_phoneext(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_rawtext(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_email(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_name(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_organization(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_street1(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_street2(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_street3(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_street4(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_city(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_state(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_country(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_fax(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_faxext(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_zonecontact_phoneext(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(WhoIs, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
