IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_SalesChannel) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_rid_cnt := COUNT(GROUP,h.rid <> (TYPEOF(h.rid))'');
    populated_rid_pcnt := AVE(GROUP,IF(h.rid = (TYPEOF(h.rid))'',0,100));
    maxlength_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rid)));
    avelength_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rid)),h.rid<>(typeof(h.rid))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
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
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
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
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_cnt := COUNT(GROUP,h.aceaid <> (TYPEOF(h.aceaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_rawfields_row_id_cnt := COUNT(GROUP,h.rawfields_row_id <> (TYPEOF(h.rawfields_row_id))'');
    populated_rawfields_row_id_pcnt := AVE(GROUP,IF(h.rawfields_row_id = (TYPEOF(h.rawfields_row_id))'',0,100));
    maxlength_rawfields_row_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_row_id)));
    avelength_rawfields_row_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_row_id)),h.rawfields_row_id<>(typeof(h.rawfields_row_id))'');
    populated_rawfields_company_name_cnt := COUNT(GROUP,h.rawfields_company_name <> (TYPEOF(h.rawfields_company_name))'');
    populated_rawfields_company_name_pcnt := AVE(GROUP,IF(h.rawfields_company_name = (TYPEOF(h.rawfields_company_name))'',0,100));
    maxlength_rawfields_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_company_name)));
    avelength_rawfields_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_company_name)),h.rawfields_company_name<>(typeof(h.rawfields_company_name))'');
    populated_rawfields_web_address_cnt := COUNT(GROUP,h.rawfields_web_address <> (TYPEOF(h.rawfields_web_address))'');
    populated_rawfields_web_address_pcnt := AVE(GROUP,IF(h.rawfields_web_address = (TYPEOF(h.rawfields_web_address))'',0,100));
    maxlength_rawfields_web_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_web_address)));
    avelength_rawfields_web_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_web_address)),h.rawfields_web_address<>(typeof(h.rawfields_web_address))'');
    populated_rawfields_prefix_cnt := COUNT(GROUP,h.rawfields_prefix <> (TYPEOF(h.rawfields_prefix))'');
    populated_rawfields_prefix_pcnt := AVE(GROUP,IF(h.rawfields_prefix = (TYPEOF(h.rawfields_prefix))'',0,100));
    maxlength_rawfields_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_prefix)));
    avelength_rawfields_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_prefix)),h.rawfields_prefix<>(typeof(h.rawfields_prefix))'');
    populated_rawfields_contact_name_cnt := COUNT(GROUP,h.rawfields_contact_name <> (TYPEOF(h.rawfields_contact_name))'');
    populated_rawfields_contact_name_pcnt := AVE(GROUP,IF(h.rawfields_contact_name = (TYPEOF(h.rawfields_contact_name))'',0,100));
    maxlength_rawfields_contact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_contact_name)));
    avelength_rawfields_contact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_contact_name)),h.rawfields_contact_name<>(typeof(h.rawfields_contact_name))'');
    populated_rawfields_first_name_cnt := COUNT(GROUP,h.rawfields_first_name <> (TYPEOF(h.rawfields_first_name))'');
    populated_rawfields_first_name_pcnt := AVE(GROUP,IF(h.rawfields_first_name = (TYPEOF(h.rawfields_first_name))'',0,100));
    maxlength_rawfields_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_first_name)));
    avelength_rawfields_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_first_name)),h.rawfields_first_name<>(typeof(h.rawfields_first_name))'');
    populated_rawfields_middle_name_cnt := COUNT(GROUP,h.rawfields_middle_name <> (TYPEOF(h.rawfields_middle_name))'');
    populated_rawfields_middle_name_pcnt := AVE(GROUP,IF(h.rawfields_middle_name = (TYPEOF(h.rawfields_middle_name))'',0,100));
    maxlength_rawfields_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_middle_name)));
    avelength_rawfields_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_middle_name)),h.rawfields_middle_name<>(typeof(h.rawfields_middle_name))'');
    populated_rawfields_last_name_cnt := COUNT(GROUP,h.rawfields_last_name <> (TYPEOF(h.rawfields_last_name))'');
    populated_rawfields_last_name_pcnt := AVE(GROUP,IF(h.rawfields_last_name = (TYPEOF(h.rawfields_last_name))'',0,100));
    maxlength_rawfields_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_last_name)));
    avelength_rawfields_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_last_name)),h.rawfields_last_name<>(typeof(h.rawfields_last_name))'');
    populated_rawfields_title_cnt := COUNT(GROUP,h.rawfields_title <> (TYPEOF(h.rawfields_title))'');
    populated_rawfields_title_pcnt := AVE(GROUP,IF(h.rawfields_title = (TYPEOF(h.rawfields_title))'',0,100));
    maxlength_rawfields_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_title)));
    avelength_rawfields_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_title)),h.rawfields_title<>(typeof(h.rawfields_title))'');
    populated_rawfields_address_cnt := COUNT(GROUP,h.rawfields_address <> (TYPEOF(h.rawfields_address))'');
    populated_rawfields_address_pcnt := AVE(GROUP,IF(h.rawfields_address = (TYPEOF(h.rawfields_address))'',0,100));
    maxlength_rawfields_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address)));
    avelength_rawfields_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address)),h.rawfields_address<>(typeof(h.rawfields_address))'');
    populated_rawfields_address1_cnt := COUNT(GROUP,h.rawfields_address1 <> (TYPEOF(h.rawfields_address1))'');
    populated_rawfields_address1_pcnt := AVE(GROUP,IF(h.rawfields_address1 = (TYPEOF(h.rawfields_address1))'',0,100));
    maxlength_rawfields_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address1)));
    avelength_rawfields_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address1)),h.rawfields_address1<>(typeof(h.rawfields_address1))'');
    populated_rawfields_city_cnt := COUNT(GROUP,h.rawfields_city <> (TYPEOF(h.rawfields_city))'');
    populated_rawfields_city_pcnt := AVE(GROUP,IF(h.rawfields_city = (TYPEOF(h.rawfields_city))'',0,100));
    maxlength_rawfields_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_city)));
    avelength_rawfields_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_city)),h.rawfields_city<>(typeof(h.rawfields_city))'');
    populated_rawfields_state_cnt := COUNT(GROUP,h.rawfields_state <> (TYPEOF(h.rawfields_state))'');
    populated_rawfields_state_pcnt := AVE(GROUP,IF(h.rawfields_state = (TYPEOF(h.rawfields_state))'',0,100));
    maxlength_rawfields_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_state)));
    avelength_rawfields_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_state)),h.rawfields_state<>(typeof(h.rawfields_state))'');
    populated_rawfields_zip_code_cnt := COUNT(GROUP,h.rawfields_zip_code <> (TYPEOF(h.rawfields_zip_code))'');
    populated_rawfields_zip_code_pcnt := AVE(GROUP,IF(h.rawfields_zip_code = (TYPEOF(h.rawfields_zip_code))'',0,100));
    maxlength_rawfields_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_zip_code)));
    avelength_rawfields_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_zip_code)),h.rawfields_zip_code<>(typeof(h.rawfields_zip_code))'');
    populated_rawfields_country_cnt := COUNT(GROUP,h.rawfields_country <> (TYPEOF(h.rawfields_country))'');
    populated_rawfields_country_pcnt := AVE(GROUP,IF(h.rawfields_country = (TYPEOF(h.rawfields_country))'',0,100));
    maxlength_rawfields_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)));
    avelength_rawfields_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)),h.rawfields_country<>(typeof(h.rawfields_country))'');
    populated_rawfields_phone_number_cnt := COUNT(GROUP,h.rawfields_phone_number <> (TYPEOF(h.rawfields_phone_number))'');
    populated_rawfields_phone_number_pcnt := AVE(GROUP,IF(h.rawfields_phone_number = (TYPEOF(h.rawfields_phone_number))'',0,100));
    maxlength_rawfields_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_phone_number)));
    avelength_rawfields_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_phone_number)),h.rawfields_phone_number<>(typeof(h.rawfields_phone_number))'');
    populated_rawfields_email_cnt := COUNT(GROUP,h.rawfields_email <> (TYPEOF(h.rawfields_email))'');
    populated_rawfields_email_pcnt := AVE(GROUP,IF(h.rawfields_email = (TYPEOF(h.rawfields_email))'',0,100));
    maxlength_rawfields_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_email)));
    avelength_rawfields_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_email)),h.rawfields_email<>(typeof(h.rawfields_email))'');
    populated_clean_name_title_cnt := COUNT(GROUP,h.clean_name_title <> (TYPEOF(h.clean_name_title))'');
    populated_clean_name_title_pcnt := AVE(GROUP,IF(h.clean_name_title = (TYPEOF(h.clean_name_title))'',0,100));
    maxlength_clean_name_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_title)));
    avelength_clean_name_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_title)),h.clean_name_title<>(typeof(h.clean_name_title))'');
    populated_clean_name_fname_cnt := COUNT(GROUP,h.clean_name_fname <> (TYPEOF(h.clean_name_fname))'');
    populated_clean_name_fname_pcnt := AVE(GROUP,IF(h.clean_name_fname = (TYPEOF(h.clean_name_fname))'',0,100));
    maxlength_clean_name_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_fname)));
    avelength_clean_name_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_fname)),h.clean_name_fname<>(typeof(h.clean_name_fname))'');
    populated_clean_name_mname_cnt := COUNT(GROUP,h.clean_name_mname <> (TYPEOF(h.clean_name_mname))'');
    populated_clean_name_mname_pcnt := AVE(GROUP,IF(h.clean_name_mname = (TYPEOF(h.clean_name_mname))'',0,100));
    maxlength_clean_name_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_mname)));
    avelength_clean_name_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_mname)),h.clean_name_mname<>(typeof(h.clean_name_mname))'');
    populated_clean_name_lname_cnt := COUNT(GROUP,h.clean_name_lname <> (TYPEOF(h.clean_name_lname))'');
    populated_clean_name_lname_pcnt := AVE(GROUP,IF(h.clean_name_lname = (TYPEOF(h.clean_name_lname))'',0,100));
    maxlength_clean_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_lname)));
    avelength_clean_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_lname)),h.clean_name_lname<>(typeof(h.clean_name_lname))'');
    populated_clean_name_name_suffix_cnt := COUNT(GROUP,h.clean_name_name_suffix <> (TYPEOF(h.clean_name_name_suffix))'');
    populated_clean_name_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_name_suffix = (TYPEOF(h.clean_name_name_suffix))'',0,100));
    maxlength_clean_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_name_suffix)));
    avelength_clean_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_name_suffix)),h.clean_name_name_suffix<>(typeof(h.clean_name_name_suffix))'');
    populated_clean_name_name_score_cnt := COUNT(GROUP,h.clean_name_name_score <> (TYPEOF(h.clean_name_name_score))'');
    populated_clean_name_name_score_pcnt := AVE(GROUP,IF(h.clean_name_name_score = (TYPEOF(h.clean_name_name_score))'',0,100));
    maxlength_clean_name_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_name_score)));
    avelength_clean_name_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_name_score)),h.clean_name_name_score<>(typeof(h.clean_name_name_score))'');
    populated_clean_address_prim_range_cnt := COUNT(GROUP,h.clean_address_prim_range <> (TYPEOF(h.clean_address_prim_range))'');
    populated_clean_address_prim_range_pcnt := AVE(GROUP,IF(h.clean_address_prim_range = (TYPEOF(h.clean_address_prim_range))'',0,100));
    maxlength_clean_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_range)));
    avelength_clean_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_range)),h.clean_address_prim_range<>(typeof(h.clean_address_prim_range))'');
    populated_clean_address_predir_cnt := COUNT(GROUP,h.clean_address_predir <> (TYPEOF(h.clean_address_predir))'');
    populated_clean_address_predir_pcnt := AVE(GROUP,IF(h.clean_address_predir = (TYPEOF(h.clean_address_predir))'',0,100));
    maxlength_clean_address_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_predir)));
    avelength_clean_address_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_predir)),h.clean_address_predir<>(typeof(h.clean_address_predir))'');
    populated_clean_address_prim_name_cnt := COUNT(GROUP,h.clean_address_prim_name <> (TYPEOF(h.clean_address_prim_name))'');
    populated_clean_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_address_prim_name = (TYPEOF(h.clean_address_prim_name))'',0,100));
    maxlength_clean_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)));
    avelength_clean_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)),h.clean_address_prim_name<>(typeof(h.clean_address_prim_name))'');
    populated_clean_address_addr_suffix_cnt := COUNT(GROUP,h.clean_address_addr_suffix <> (TYPEOF(h.clean_address_addr_suffix))'');
    populated_clean_address_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_address_addr_suffix = (TYPEOF(h.clean_address_addr_suffix))'',0,100));
    maxlength_clean_address_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_addr_suffix)));
    avelength_clean_address_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_addr_suffix)),h.clean_address_addr_suffix<>(typeof(h.clean_address_addr_suffix))'');
    populated_clean_address_postdir_cnt := COUNT(GROUP,h.clean_address_postdir <> (TYPEOF(h.clean_address_postdir))'');
    populated_clean_address_postdir_pcnt := AVE(GROUP,IF(h.clean_address_postdir = (TYPEOF(h.clean_address_postdir))'',0,100));
    maxlength_clean_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_postdir)));
    avelength_clean_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_postdir)),h.clean_address_postdir<>(typeof(h.clean_address_postdir))'');
    populated_clean_address_unit_desig_cnt := COUNT(GROUP,h.clean_address_unit_desig <> (TYPEOF(h.clean_address_unit_desig))'');
    populated_clean_address_unit_desig_pcnt := AVE(GROUP,IF(h.clean_address_unit_desig = (TYPEOF(h.clean_address_unit_desig))'',0,100));
    maxlength_clean_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_unit_desig)));
    avelength_clean_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_unit_desig)),h.clean_address_unit_desig<>(typeof(h.clean_address_unit_desig))'');
    populated_clean_address_sec_range_cnt := COUNT(GROUP,h.clean_address_sec_range <> (TYPEOF(h.clean_address_sec_range))'');
    populated_clean_address_sec_range_pcnt := AVE(GROUP,IF(h.clean_address_sec_range = (TYPEOF(h.clean_address_sec_range))'',0,100));
    maxlength_clean_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_sec_range)));
    avelength_clean_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_sec_range)),h.clean_address_sec_range<>(typeof(h.clean_address_sec_range))'');
    populated_clean_address_p_city_name_cnt := COUNT(GROUP,h.clean_address_p_city_name <> (TYPEOF(h.clean_address_p_city_name))'');
    populated_clean_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_address_p_city_name = (TYPEOF(h.clean_address_p_city_name))'',0,100));
    maxlength_clean_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)));
    avelength_clean_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)),h.clean_address_p_city_name<>(typeof(h.clean_address_p_city_name))'');
    populated_clean_address_v_city_name_cnt := COUNT(GROUP,h.clean_address_v_city_name <> (TYPEOF(h.clean_address_v_city_name))'');
    populated_clean_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_address_v_city_name = (TYPEOF(h.clean_address_v_city_name))'',0,100));
    maxlength_clean_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)));
    avelength_clean_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)),h.clean_address_v_city_name<>(typeof(h.clean_address_v_city_name))'');
    populated_clean_address_st_cnt := COUNT(GROUP,h.clean_address_st <> (TYPEOF(h.clean_address_st))'');
    populated_clean_address_st_pcnt := AVE(GROUP,IF(h.clean_address_st = (TYPEOF(h.clean_address_st))'',0,100));
    maxlength_clean_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)));
    avelength_clean_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)),h.clean_address_st<>(typeof(h.clean_address_st))'');
    populated_clean_address_zip_cnt := COUNT(GROUP,h.clean_address_zip <> (TYPEOF(h.clean_address_zip))'');
    populated_clean_address_zip_pcnt := AVE(GROUP,IF(h.clean_address_zip = (TYPEOF(h.clean_address_zip))'',0,100));
    maxlength_clean_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)));
    avelength_clean_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)),h.clean_address_zip<>(typeof(h.clean_address_zip))'');
    populated_clean_address_zip4_cnt := COUNT(GROUP,h.clean_address_zip4 <> (TYPEOF(h.clean_address_zip4))'');
    populated_clean_address_zip4_pcnt := AVE(GROUP,IF(h.clean_address_zip4 = (TYPEOF(h.clean_address_zip4))'',0,100));
    maxlength_clean_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip4)));
    avelength_clean_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip4)),h.clean_address_zip4<>(typeof(h.clean_address_zip4))'');
    populated_clean_address_cart_cnt := COUNT(GROUP,h.clean_address_cart <> (TYPEOF(h.clean_address_cart))'');
    populated_clean_address_cart_pcnt := AVE(GROUP,IF(h.clean_address_cart = (TYPEOF(h.clean_address_cart))'',0,100));
    maxlength_clean_address_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_cart)));
    avelength_clean_address_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_cart)),h.clean_address_cart<>(typeof(h.clean_address_cart))'');
    populated_clean_address_cr_sort_sz_cnt := COUNT(GROUP,h.clean_address_cr_sort_sz <> (TYPEOF(h.clean_address_cr_sort_sz))'');
    populated_clean_address_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_address_cr_sort_sz = (TYPEOF(h.clean_address_cr_sort_sz))'',0,100));
    maxlength_clean_address_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_cr_sort_sz)));
    avelength_clean_address_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_cr_sort_sz)),h.clean_address_cr_sort_sz<>(typeof(h.clean_address_cr_sort_sz))'');
    populated_clean_address_lot_cnt := COUNT(GROUP,h.clean_address_lot <> (TYPEOF(h.clean_address_lot))'');
    populated_clean_address_lot_pcnt := AVE(GROUP,IF(h.clean_address_lot = (TYPEOF(h.clean_address_lot))'',0,100));
    maxlength_clean_address_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_lot)));
    avelength_clean_address_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_lot)),h.clean_address_lot<>(typeof(h.clean_address_lot))'');
    populated_clean_address_lot_order_cnt := COUNT(GROUP,h.clean_address_lot_order <> (TYPEOF(h.clean_address_lot_order))'');
    populated_clean_address_lot_order_pcnt := AVE(GROUP,IF(h.clean_address_lot_order = (TYPEOF(h.clean_address_lot_order))'',0,100));
    maxlength_clean_address_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_lot_order)));
    avelength_clean_address_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_lot_order)),h.clean_address_lot_order<>(typeof(h.clean_address_lot_order))'');
    populated_clean_address_dbpc_cnt := COUNT(GROUP,h.clean_address_dbpc <> (TYPEOF(h.clean_address_dbpc))'');
    populated_clean_address_dbpc_pcnt := AVE(GROUP,IF(h.clean_address_dbpc = (TYPEOF(h.clean_address_dbpc))'',0,100));
    maxlength_clean_address_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_dbpc)));
    avelength_clean_address_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_dbpc)),h.clean_address_dbpc<>(typeof(h.clean_address_dbpc))'');
    populated_clean_address_chk_digit_cnt := COUNT(GROUP,h.clean_address_chk_digit <> (TYPEOF(h.clean_address_chk_digit))'');
    populated_clean_address_chk_digit_pcnt := AVE(GROUP,IF(h.clean_address_chk_digit = (TYPEOF(h.clean_address_chk_digit))'',0,100));
    maxlength_clean_address_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_chk_digit)));
    avelength_clean_address_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_chk_digit)),h.clean_address_chk_digit<>(typeof(h.clean_address_chk_digit))'');
    populated_clean_address_rec_type_cnt := COUNT(GROUP,h.clean_address_rec_type <> (TYPEOF(h.clean_address_rec_type))'');
    populated_clean_address_rec_type_pcnt := AVE(GROUP,IF(h.clean_address_rec_type = (TYPEOF(h.clean_address_rec_type))'',0,100));
    maxlength_clean_address_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_rec_type)));
    avelength_clean_address_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_rec_type)),h.clean_address_rec_type<>(typeof(h.clean_address_rec_type))'');
    populated_clean_address_fips_state_cnt := COUNT(GROUP,h.clean_address_fips_state <> (TYPEOF(h.clean_address_fips_state))'');
    populated_clean_address_fips_state_pcnt := AVE(GROUP,IF(h.clean_address_fips_state = (TYPEOF(h.clean_address_fips_state))'',0,100));
    maxlength_clean_address_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_fips_state)));
    avelength_clean_address_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_fips_state)),h.clean_address_fips_state<>(typeof(h.clean_address_fips_state))'');
    populated_clean_address_fips_county_cnt := COUNT(GROUP,h.clean_address_fips_county <> (TYPEOF(h.clean_address_fips_county))'');
    populated_clean_address_fips_county_pcnt := AVE(GROUP,IF(h.clean_address_fips_county = (TYPEOF(h.clean_address_fips_county))'',0,100));
    maxlength_clean_address_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_fips_county)));
    avelength_clean_address_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_fips_county)),h.clean_address_fips_county<>(typeof(h.clean_address_fips_county))'');
    populated_clean_address_geo_lat_cnt := COUNT(GROUP,h.clean_address_geo_lat <> (TYPEOF(h.clean_address_geo_lat))'');
    populated_clean_address_geo_lat_pcnt := AVE(GROUP,IF(h.clean_address_geo_lat = (TYPEOF(h.clean_address_geo_lat))'',0,100));
    maxlength_clean_address_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_lat)));
    avelength_clean_address_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_lat)),h.clean_address_geo_lat<>(typeof(h.clean_address_geo_lat))'');
    populated_clean_address_geo_long_cnt := COUNT(GROUP,h.clean_address_geo_long <> (TYPEOF(h.clean_address_geo_long))'');
    populated_clean_address_geo_long_pcnt := AVE(GROUP,IF(h.clean_address_geo_long = (TYPEOF(h.clean_address_geo_long))'',0,100));
    maxlength_clean_address_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_long)));
    avelength_clean_address_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_long)),h.clean_address_geo_long<>(typeof(h.clean_address_geo_long))'');
    populated_clean_address_msa_cnt := COUNT(GROUP,h.clean_address_msa <> (TYPEOF(h.clean_address_msa))'');
    populated_clean_address_msa_pcnt := AVE(GROUP,IF(h.clean_address_msa = (TYPEOF(h.clean_address_msa))'',0,100));
    maxlength_clean_address_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_msa)));
    avelength_clean_address_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_msa)),h.clean_address_msa<>(typeof(h.clean_address_msa))'');
    populated_clean_address_geo_blk_cnt := COUNT(GROUP,h.clean_address_geo_blk <> (TYPEOF(h.clean_address_geo_blk))'');
    populated_clean_address_geo_blk_pcnt := AVE(GROUP,IF(h.clean_address_geo_blk = (TYPEOF(h.clean_address_geo_blk))'',0,100));
    maxlength_clean_address_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_blk)));
    avelength_clean_address_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_blk)),h.clean_address_geo_blk<>(typeof(h.clean_address_geo_blk))'');
    populated_clean_address_geo_match_cnt := COUNT(GROUP,h.clean_address_geo_match <> (TYPEOF(h.clean_address_geo_match))'');
    populated_clean_address_geo_match_pcnt := AVE(GROUP,IF(h.clean_address_geo_match = (TYPEOF(h.clean_address_geo_match))'',0,100));
    maxlength_clean_address_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_match)));
    avelength_clean_address_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_geo_match)),h.clean_address_geo_match<>(typeof(h.clean_address_geo_match))'');
    populated_clean_address_err_stat_cnt := COUNT(GROUP,h.clean_address_err_stat <> (TYPEOF(h.clean_address_err_stat))'');
    populated_clean_address_err_stat_pcnt := AVE(GROUP,IF(h.clean_address_err_stat = (TYPEOF(h.clean_address_err_stat))'',0,100));
    maxlength_clean_address_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_err_stat)));
    avelength_clean_address_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_err_stat)),h.clean_address_err_stat<>(typeof(h.clean_address_err_stat))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
    populated_current_rec_cnt := COUNT(GROUP,h.current_rec <> (TYPEOF(h.current_rec))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_rid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_rawfields_row_id_pcnt *   0.00 / 100 + T.Populated_rawfields_company_name_pcnt *   0.00 / 100 + T.Populated_rawfields_web_address_pcnt *   0.00 / 100 + T.Populated_rawfields_prefix_pcnt *   0.00 / 100 + T.Populated_rawfields_contact_name_pcnt *   0.00 / 100 + T.Populated_rawfields_first_name_pcnt *   0.00 / 100 + T.Populated_rawfields_middle_name_pcnt *   0.00 / 100 + T.Populated_rawfields_last_name_pcnt *   0.00 / 100 + T.Populated_rawfields_title_pcnt *   0.00 / 100 + T.Populated_rawfields_address_pcnt *   0.00 / 100 + T.Populated_rawfields_address1_pcnt *   0.00 / 100 + T.Populated_rawfields_city_pcnt *   0.00 / 100 + T.Populated_rawfields_state_pcnt *   0.00 / 100 + T.Populated_rawfields_zip_code_pcnt *   0.00 / 100 + T.Populated_rawfields_country_pcnt *   0.00 / 100 + T.Populated_rawfields_phone_number_pcnt *   0.00 / 100 + T.Populated_rawfields_email_pcnt *   0.00 / 100 + T.Populated_clean_name_title_pcnt *   0.00 / 100 + T.Populated_clean_name_fname_pcnt *   0.00 / 100 + T.Populated_clean_name_mname_pcnt *   0.00 / 100 + T.Populated_clean_name_lname_pcnt *   0.00 / 100 + T.Populated_clean_name_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_name_score_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_address_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_address_zip4_pcnt *   0.00 / 100 + T.Populated_clean_address_cart_pcnt *   0.00 / 100 + T.Populated_clean_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_address_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_address_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_state_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_county_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_address_msa_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_address_err_stat_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'rid','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rawaid','aceaid','record_type','rawfields_row_id','rawfields_company_name','rawfields_web_address','rawfields_prefix','rawfields_contact_name','rawfields_first_name','rawfields_middle_name','rawfields_last_name','rawfields_title','rawfields_address','rawfields_address1','rawfields_city','rawfields_state','rawfields_zip_code','rawfields_country','rawfields_phone_number','rawfields_email','clean_name_title','clean_name_fname','clean_name_mname','clean_name_lname','clean_name_name_suffix','clean_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','global_sid','record_sid','current_rec');
  SELF.populated_pcnt := CHOOSE(C,le.populated_rid_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_record_type_pcnt,le.populated_rawfields_row_id_pcnt,le.populated_rawfields_company_name_pcnt,le.populated_rawfields_web_address_pcnt,le.populated_rawfields_prefix_pcnt,le.populated_rawfields_contact_name_pcnt,le.populated_rawfields_first_name_pcnt,le.populated_rawfields_middle_name_pcnt,le.populated_rawfields_last_name_pcnt,le.populated_rawfields_title_pcnt,le.populated_rawfields_address_pcnt,le.populated_rawfields_address1_pcnt,le.populated_rawfields_city_pcnt,le.populated_rawfields_state_pcnt,le.populated_rawfields_zip_code_pcnt,le.populated_rawfields_country_pcnt,le.populated_rawfields_phone_number_pcnt,le.populated_rawfields_email_pcnt,le.populated_clean_name_title_pcnt,le.populated_clean_name_fname_pcnt,le.populated_clean_name_mname_pcnt,le.populated_clean_name_lname_pcnt,le.populated_clean_name_name_suffix_pcnt,le.populated_clean_name_name_score_pcnt,le.populated_clean_address_prim_range_pcnt,le.populated_clean_address_predir_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_addr_suffix_pcnt,le.populated_clean_address_postdir_pcnt,le.populated_clean_address_unit_desig_pcnt,le.populated_clean_address_sec_range_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt,le.populated_clean_address_zip4_pcnt,le.populated_clean_address_cart_pcnt,le.populated_clean_address_cr_sort_sz_pcnt,le.populated_clean_address_lot_pcnt,le.populated_clean_address_lot_order_pcnt,le.populated_clean_address_dbpc_pcnt,le.populated_clean_address_chk_digit_pcnt,le.populated_clean_address_rec_type_pcnt,le.populated_clean_address_fips_state_pcnt,le.populated_clean_address_fips_county_pcnt,le.populated_clean_address_geo_lat_pcnt,le.populated_clean_address_geo_long_pcnt,le.populated_clean_address_msa_pcnt,le.populated_clean_address_geo_blk_pcnt,le.populated_clean_address_geo_match_pcnt,le.populated_clean_address_err_stat_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt,le.populated_current_rec_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_rid,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_did,le.maxlength_did_score,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_record_type,le.maxlength_rawfields_row_id,le.maxlength_rawfields_company_name,le.maxlength_rawfields_web_address,le.maxlength_rawfields_prefix,le.maxlength_rawfields_contact_name,le.maxlength_rawfields_first_name,le.maxlength_rawfields_middle_name,le.maxlength_rawfields_last_name,le.maxlength_rawfields_title,le.maxlength_rawfields_address,le.maxlength_rawfields_address1,le.maxlength_rawfields_city,le.maxlength_rawfields_state,le.maxlength_rawfields_zip_code,le.maxlength_rawfields_country,le.maxlength_rawfields_phone_number,le.maxlength_rawfields_email,le.maxlength_clean_name_title,le.maxlength_clean_name_fname,le.maxlength_clean_name_mname,le.maxlength_clean_name_lname,le.maxlength_clean_name_name_suffix,le.maxlength_clean_name_name_score,le.maxlength_clean_address_prim_range,le.maxlength_clean_address_predir,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_addr_suffix,le.maxlength_clean_address_postdir,le.maxlength_clean_address_unit_desig,le.maxlength_clean_address_sec_range,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip,le.maxlength_clean_address_zip4,le.maxlength_clean_address_cart,le.maxlength_clean_address_cr_sort_sz,le.maxlength_clean_address_lot,le.maxlength_clean_address_lot_order,le.maxlength_clean_address_dbpc,le.maxlength_clean_address_chk_digit,le.maxlength_clean_address_rec_type,le.maxlength_clean_address_fips_state,le.maxlength_clean_address_fips_county,le.maxlength_clean_address_geo_lat,le.maxlength_clean_address_geo_long,le.maxlength_clean_address_msa,le.maxlength_clean_address_geo_blk,le.maxlength_clean_address_geo_match,le.maxlength_clean_address_err_stat,le.maxlength_global_sid,le.maxlength_record_sid,le.maxlength_current_rec);
  SELF.avelength := CHOOSE(C,le.avelength_rid,le.avelength_bdid,le.avelength_bdid_score,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_did,le.avelength_did_score,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_rawaid,le.avelength_aceaid,le.avelength_record_type,le.avelength_rawfields_row_id,le.avelength_rawfields_company_name,le.avelength_rawfields_web_address,le.avelength_rawfields_prefix,le.avelength_rawfields_contact_name,le.avelength_rawfields_first_name,le.avelength_rawfields_middle_name,le.avelength_rawfields_last_name,le.avelength_rawfields_title,le.avelength_rawfields_address,le.avelength_rawfields_address1,le.avelength_rawfields_city,le.avelength_rawfields_state,le.avelength_rawfields_zip_code,le.avelength_rawfields_country,le.avelength_rawfields_phone_number,le.avelength_rawfields_email,le.avelength_clean_name_title,le.avelength_clean_name_fname,le.avelength_clean_name_mname,le.avelength_clean_name_lname,le.avelength_clean_name_name_suffix,le.avelength_clean_name_name_score,le.avelength_clean_address_prim_range,le.avelength_clean_address_predir,le.avelength_clean_address_prim_name,le.avelength_clean_address_addr_suffix,le.avelength_clean_address_postdir,le.avelength_clean_address_unit_desig,le.avelength_clean_address_sec_range,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip,le.avelength_clean_address_zip4,le.avelength_clean_address_cart,le.avelength_clean_address_cr_sort_sz,le.avelength_clean_address_lot,le.avelength_clean_address_lot_order,le.avelength_clean_address_dbpc,le.avelength_clean_address_chk_digit,le.avelength_clean_address_rec_type,le.avelength_clean_address_fips_state,le.avelength_clean_address_fips_county,le.avelength_clean_address_geo_lat,le.avelength_clean_address_geo_long,le.avelength_clean_address_msa,le.avelength_clean_address_geo_blk,le.avelength_clean_address_geo_match,le.avelength_clean_address_err_stat,le.avelength_global_sid,le.avelength_record_sid,le.avelength_current_rec);
END;
EXPORT invSummary := NORMALIZE(summary0, 86, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),IF (le.record_type <> 0,TRIM((SALT311.StrType)le.record_type), ''),TRIM((SALT311.StrType)le.rawfields_row_id),TRIM((SALT311.StrType)le.rawfields_company_name),TRIM((SALT311.StrType)le.rawfields_web_address),TRIM((SALT311.StrType)le.rawfields_prefix),TRIM((SALT311.StrType)le.rawfields_contact_name),TRIM((SALT311.StrType)le.rawfields_first_name),TRIM((SALT311.StrType)le.rawfields_middle_name),TRIM((SALT311.StrType)le.rawfields_last_name),TRIM((SALT311.StrType)le.rawfields_title),TRIM((SALT311.StrType)le.rawfields_address),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip_code),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_phone_number),TRIM((SALT311.StrType)le.rawfields_email),TRIM((SALT311.StrType)le.clean_name_title),TRIM((SALT311.StrType)le.clean_name_fname),TRIM((SALT311.StrType)le.clean_name_mname),TRIM((SALT311.StrType)le.clean_name_lname),TRIM((SALT311.StrType)le.clean_name_name_suffix),TRIM((SALT311.StrType)le.clean_name_name_score),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),TRIM((SALT311.StrType)le.current_rec)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,86,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 86);
  SELF.FldNo2 := 1 + (C % 86);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),IF (le.record_type <> 0,TRIM((SALT311.StrType)le.record_type), ''),TRIM((SALT311.StrType)le.rawfields_row_id),TRIM((SALT311.StrType)le.rawfields_company_name),TRIM((SALT311.StrType)le.rawfields_web_address),TRIM((SALT311.StrType)le.rawfields_prefix),TRIM((SALT311.StrType)le.rawfields_contact_name),TRIM((SALT311.StrType)le.rawfields_first_name),TRIM((SALT311.StrType)le.rawfields_middle_name),TRIM((SALT311.StrType)le.rawfields_last_name),TRIM((SALT311.StrType)le.rawfields_title),TRIM((SALT311.StrType)le.rawfields_address),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip_code),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_phone_number),TRIM((SALT311.StrType)le.rawfields_email),TRIM((SALT311.StrType)le.clean_name_title),TRIM((SALT311.StrType)le.clean_name_fname),TRIM((SALT311.StrType)le.clean_name_mname),TRIM((SALT311.StrType)le.clean_name_lname),TRIM((SALT311.StrType)le.clean_name_name_suffix),TRIM((SALT311.StrType)le.clean_name_name_score),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),TRIM((SALT311.StrType)le.current_rec)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),IF (le.record_type <> 0,TRIM((SALT311.StrType)le.record_type), ''),TRIM((SALT311.StrType)le.rawfields_row_id),TRIM((SALT311.StrType)le.rawfields_company_name),TRIM((SALT311.StrType)le.rawfields_web_address),TRIM((SALT311.StrType)le.rawfields_prefix),TRIM((SALT311.StrType)le.rawfields_contact_name),TRIM((SALT311.StrType)le.rawfields_first_name),TRIM((SALT311.StrType)le.rawfields_middle_name),TRIM((SALT311.StrType)le.rawfields_last_name),TRIM((SALT311.StrType)le.rawfields_title),TRIM((SALT311.StrType)le.rawfields_address),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip_code),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_phone_number),TRIM((SALT311.StrType)le.rawfields_email),TRIM((SALT311.StrType)le.clean_name_title),TRIM((SALT311.StrType)le.clean_name_fname),TRIM((SALT311.StrType)le.clean_name_mname),TRIM((SALT311.StrType)le.clean_name_lname),TRIM((SALT311.StrType)le.clean_name_name_suffix),TRIM((SALT311.StrType)le.clean_name_name_score),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),TRIM((SALT311.StrType)le.current_rec)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),86*86,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'rid'}
      ,{2,'bdid'}
      ,{3,'bdid_score'}
      ,{4,'dotid'}
      ,{5,'dotscore'}
      ,{6,'dotweight'}
      ,{7,'empid'}
      ,{8,'empscore'}
      ,{9,'empweight'}
      ,{10,'powid'}
      ,{11,'powscore'}
      ,{12,'powweight'}
      ,{13,'proxid'}
      ,{14,'proxscore'}
      ,{15,'proxweight'}
      ,{16,'seleid'}
      ,{17,'selescore'}
      ,{18,'seleweight'}
      ,{19,'orgid'}
      ,{20,'orgscore'}
      ,{21,'orgweight'}
      ,{22,'ultid'}
      ,{23,'ultscore'}
      ,{24,'ultweight'}
      ,{25,'did'}
      ,{26,'did_score'}
      ,{27,'date_first_seen'}
      ,{28,'date_last_seen'}
      ,{29,'date_vendor_first_reported'}
      ,{30,'date_vendor_last_reported'}
      ,{31,'rawaid'}
      ,{32,'aceaid'}
      ,{33,'record_type'}
      ,{34,'rawfields_row_id'}
      ,{35,'rawfields_company_name'}
      ,{36,'rawfields_web_address'}
      ,{37,'rawfields_prefix'}
      ,{38,'rawfields_contact_name'}
      ,{39,'rawfields_first_name'}
      ,{40,'rawfields_middle_name'}
      ,{41,'rawfields_last_name'}
      ,{42,'rawfields_title'}
      ,{43,'rawfields_address'}
      ,{44,'rawfields_address1'}
      ,{45,'rawfields_city'}
      ,{46,'rawfields_state'}
      ,{47,'rawfields_zip_code'}
      ,{48,'rawfields_country'}
      ,{49,'rawfields_phone_number'}
      ,{50,'rawfields_email'}
      ,{51,'clean_name_title'}
      ,{52,'clean_name_fname'}
      ,{53,'clean_name_mname'}
      ,{54,'clean_name_lname'}
      ,{55,'clean_name_name_suffix'}
      ,{56,'clean_name_name_score'}
      ,{57,'clean_address_prim_range'}
      ,{58,'clean_address_predir'}
      ,{59,'clean_address_prim_name'}
      ,{60,'clean_address_addr_suffix'}
      ,{61,'clean_address_postdir'}
      ,{62,'clean_address_unit_desig'}
      ,{63,'clean_address_sec_range'}
      ,{64,'clean_address_p_city_name'}
      ,{65,'clean_address_v_city_name'}
      ,{66,'clean_address_st'}
      ,{67,'clean_address_zip'}
      ,{68,'clean_address_zip4'}
      ,{69,'clean_address_cart'}
      ,{70,'clean_address_cr_sort_sz'}
      ,{71,'clean_address_lot'}
      ,{72,'clean_address_lot_order'}
      ,{73,'clean_address_dbpc'}
      ,{74,'clean_address_chk_digit'}
      ,{75,'clean_address_rec_type'}
      ,{76,'clean_address_fips_state'}
      ,{77,'clean_address_fips_county'}
      ,{78,'clean_address_geo_lat'}
      ,{79,'clean_address_geo_long'}
      ,{80,'clean_address_msa'}
      ,{81,'clean_address_geo_blk'}
      ,{82,'clean_address_geo_match'}
      ,{83,'clean_address_err_stat'}
      ,{84,'global_sid'}
      ,{85,'record_sid'}
      ,{86,'current_rec'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_rid((SALT311.StrType)le.rid),
    Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Fields.InValid_bdid_score((SALT311.StrType)le.bdid_score),
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
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_aceaid((SALT311.StrType)le.aceaid),
    Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Fields.InValid_rawfields_row_id((SALT311.StrType)le.rawfields_row_id),
    Fields.InValid_rawfields_company_name((SALT311.StrType)le.rawfields_company_name),
    Fields.InValid_rawfields_web_address((SALT311.StrType)le.rawfields_web_address),
    Fields.InValid_rawfields_prefix((SALT311.StrType)le.rawfields_prefix),
    Fields.InValid_rawfields_contact_name((SALT311.StrType)le.rawfields_contact_name),
    Fields.InValid_rawfields_first_name((SALT311.StrType)le.rawfields_first_name),
    Fields.InValid_rawfields_middle_name((SALT311.StrType)le.rawfields_middle_name),
    Fields.InValid_rawfields_last_name((SALT311.StrType)le.rawfields_last_name),
    Fields.InValid_rawfields_title((SALT311.StrType)le.rawfields_title),
    Fields.InValid_rawfields_address((SALT311.StrType)le.rawfields_address),
    Fields.InValid_rawfields_address1((SALT311.StrType)le.rawfields_address1),
    Fields.InValid_rawfields_city((SALT311.StrType)le.rawfields_city),
    Fields.InValid_rawfields_state((SALT311.StrType)le.rawfields_state),
    Fields.InValid_rawfields_zip_code((SALT311.StrType)le.rawfields_zip_code),
    Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country),
    Fields.InValid_rawfields_phone_number((SALT311.StrType)le.rawfields_phone_number),
    Fields.InValid_rawfields_email((SALT311.StrType)le.rawfields_email),
    Fields.InValid_clean_name_title((SALT311.StrType)le.clean_name_title),
    Fields.InValid_clean_name_fname((SALT311.StrType)le.clean_name_fname),
    Fields.InValid_clean_name_mname((SALT311.StrType)le.clean_name_mname),
    Fields.InValid_clean_name_lname((SALT311.StrType)le.clean_name_lname),
    Fields.InValid_clean_name_name_suffix((SALT311.StrType)le.clean_name_name_suffix),
    Fields.InValid_clean_name_name_score((SALT311.StrType)le.clean_name_name_score),
    Fields.InValid_clean_address_prim_range((SALT311.StrType)le.clean_address_prim_range),
    Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir),
    Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name),
    Fields.InValid_clean_address_addr_suffix((SALT311.StrType)le.clean_address_addr_suffix),
    Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir),
    Fields.InValid_clean_address_unit_desig((SALT311.StrType)le.clean_address_unit_desig),
    Fields.InValid_clean_address_sec_range((SALT311.StrType)le.clean_address_sec_range),
    Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name),
    Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name),
    Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st),
    Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip),
    Fields.InValid_clean_address_zip4((SALT311.StrType)le.clean_address_zip4),
    Fields.InValid_clean_address_cart((SALT311.StrType)le.clean_address_cart),
    Fields.InValid_clean_address_cr_sort_sz((SALT311.StrType)le.clean_address_cr_sort_sz),
    Fields.InValid_clean_address_lot((SALT311.StrType)le.clean_address_lot),
    Fields.InValid_clean_address_lot_order((SALT311.StrType)le.clean_address_lot_order),
    Fields.InValid_clean_address_dbpc((SALT311.StrType)le.clean_address_dbpc),
    Fields.InValid_clean_address_chk_digit((SALT311.StrType)le.clean_address_chk_digit),
    Fields.InValid_clean_address_rec_type((SALT311.StrType)le.clean_address_rec_type),
    Fields.InValid_clean_address_fips_state((SALT311.StrType)le.clean_address_fips_state),
    Fields.InValid_clean_address_fips_county((SALT311.StrType)le.clean_address_fips_county),
    Fields.InValid_clean_address_geo_lat((SALT311.StrType)le.clean_address_geo_lat),
    Fields.InValid_clean_address_geo_long((SALT311.StrType)le.clean_address_geo_long),
    Fields.InValid_clean_address_msa((SALT311.StrType)le.clean_address_msa),
    Fields.InValid_clean_address_geo_blk((SALT311.StrType)le.clean_address_geo_blk),
    Fields.InValid_clean_address_geo_match((SALT311.StrType)le.clean_address_geo_match),
    Fields.InValid_clean_address_err_stat((SALT311.StrType)le.clean_address_err_stat),
    Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    Fields.InValid_current_rec((SALT311.StrType)le.current_rec),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,86,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_AlphaChars','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_Float','Invalid_PrintableChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_PrintableChar','Invalid_Alpha','Invalid_PrintableChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChars','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Zip','Invalid_No','Invalid_No');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_rid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_row_id(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_contact_name(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_title(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_address(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_address1(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_city(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_state(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_country(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_rawfields_email(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_title(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_lname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_record_sid(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SalesChannel, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
