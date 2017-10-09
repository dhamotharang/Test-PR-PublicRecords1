IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_Frandx) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_franchisee_id_cnt := COUNT(GROUP,h.franchisee_id <> (TYPEOF(h.franchisee_id))'');
    populated_franchisee_id_pcnt := AVE(GROUP,IF(h.franchisee_id = (TYPEOF(h.franchisee_id))'',0,100));
    maxlength_franchisee_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.franchisee_id)));
    avelength_franchisee_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.franchisee_id)),h.franchisee_id<>(typeof(h.franchisee_id))'');
    populated_brand_name_cnt := COUNT(GROUP,h.brand_name <> (TYPEOF(h.brand_name))'');
    populated_brand_name_pcnt := AVE(GROUP,IF(h.brand_name = (TYPEOF(h.brand_name))'',0,100));
    maxlength_brand_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.brand_name)));
    avelength_brand_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.brand_name)),h.brand_name<>(typeof(h.brand_name))'');
    populated_fruns_cnt := COUNT(GROUP,h.fruns <> (TYPEOF(h.fruns))'');
    populated_fruns_pcnt := AVE(GROUP,IF(h.fruns = (TYPEOF(h.fruns))'',0,100));
    maxlength_fruns := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fruns)));
    avelength_fruns := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fruns)),h.fruns<>(typeof(h.fruns))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_exec_full_name_cnt := COUNT(GROUP,h.exec_full_name <> (TYPEOF(h.exec_full_name))'');
    populated_exec_full_name_pcnt := AVE(GROUP,IF(h.exec_full_name = (TYPEOF(h.exec_full_name))'',0,100));
    maxlength_exec_full_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.exec_full_name)));
    avelength_exec_full_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.exec_full_name)),h.exec_full_name<>(typeof(h.exec_full_name))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_zip_code4_cnt := COUNT(GROUP,h.zip_code4 <> (TYPEOF(h.zip_code4))'');
    populated_zip_code4_pcnt := AVE(GROUP,IF(h.zip_code4 = (TYPEOF(h.zip_code4))'',0,100));
    maxlength_zip_code4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code4)));
    avelength_zip_code4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code4)),h.zip_code4<>(typeof(h.zip_code4))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_extension_cnt := COUNT(GROUP,h.phone_extension <> (TYPEOF(h.phone_extension))'');
    populated_phone_extension_pcnt := AVE(GROUP,IF(h.phone_extension = (TYPEOF(h.phone_extension))'',0,100));
    maxlength_phone_extension := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_extension)));
    avelength_phone_extension := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_extension)),h.phone_extension<>(typeof(h.phone_extension))'');
    populated_secondary_phone_cnt := COUNT(GROUP,h.secondary_phone <> (TYPEOF(h.secondary_phone))'');
    populated_secondary_phone_pcnt := AVE(GROUP,IF(h.secondary_phone = (TYPEOF(h.secondary_phone))'',0,100));
    maxlength_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.secondary_phone)));
    avelength_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.secondary_phone)),h.secondary_phone<>(typeof(h.secondary_phone))'');
    populated_unit_flag_cnt := COUNT(GROUP,h.unit_flag <> (TYPEOF(h.unit_flag))'');
    populated_unit_flag_pcnt := AVE(GROUP,IF(h.unit_flag = (TYPEOF(h.unit_flag))'',0,100));
    maxlength_unit_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_flag)));
    avelength_unit_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_flag)),h.unit_flag<>(typeof(h.unit_flag))'');
    populated_relationship_code_cnt := COUNT(GROUP,h.relationship_code <> (TYPEOF(h.relationship_code))'');
    populated_relationship_code_pcnt := AVE(GROUP,IF(h.relationship_code = (TYPEOF(h.relationship_code))'',0,100));
    maxlength_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.relationship_code)));
    avelength_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.relationship_code)),h.relationship_code<>(typeof(h.relationship_code))'');
    populated_f_units_cnt := COUNT(GROUP,h.f_units <> (TYPEOF(h.f_units))'');
    populated_f_units_pcnt := AVE(GROUP,IF(h.f_units = (TYPEOF(h.f_units))'',0,100));
    maxlength_f_units := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.f_units)));
    avelength_f_units := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.f_units)),h.f_units<>(typeof(h.f_units))'');
    populated_website_url_cnt := COUNT(GROUP,h.website_url <> (TYPEOF(h.website_url))'');
    populated_website_url_pcnt := AVE(GROUP,IF(h.website_url = (TYPEOF(h.website_url))'',0,100));
    maxlength_website_url := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.website_url)));
    avelength_website_url := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.website_url)),h.website_url<>(typeof(h.website_url))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_industry_cnt := COUNT(GROUP,h.industry <> (TYPEOF(h.industry))'');
    populated_industry_pcnt := AVE(GROUP,IF(h.industry = (TYPEOF(h.industry))'',0,100));
    maxlength_industry := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.industry)));
    avelength_industry := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.industry)),h.industry<>(typeof(h.industry))'');
    populated_sector_cnt := COUNT(GROUP,h.sector <> (TYPEOF(h.sector))'');
    populated_sector_pcnt := AVE(GROUP,IF(h.sector = (TYPEOF(h.sector))'',0,100));
    maxlength_sector := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sector)));
    avelength_sector := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sector)),h.sector<>(typeof(h.sector))'');
    populated_industry_type_cnt := COUNT(GROUP,h.industry_type <> (TYPEOF(h.industry_type))'');
    populated_industry_type_pcnt := AVE(GROUP,IF(h.industry_type = (TYPEOF(h.industry_type))'',0,100));
    maxlength_industry_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.industry_type)));
    avelength_industry_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.industry_type)),h.industry_type<>(typeof(h.industry_type))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_frn_start_date_cnt := COUNT(GROUP,h.frn_start_date <> (TYPEOF(h.frn_start_date))'');
    populated_frn_start_date_pcnt := AVE(GROUP,IF(h.frn_start_date = (TYPEOF(h.frn_start_date))'',0,100));
    maxlength_frn_start_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.frn_start_date)));
    avelength_frn_start_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.frn_start_date)),h.frn_start_date<>(typeof(h.frn_start_date))'');
    populated_record_id_cnt := COUNT(GROUP,h.record_id <> (TYPEOF(h.record_id))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_unit_flag_exp_cnt := COUNT(GROUP,h.unit_flag_exp <> (TYPEOF(h.unit_flag_exp))'');
    populated_unit_flag_exp_pcnt := AVE(GROUP,IF(h.unit_flag_exp = (TYPEOF(h.unit_flag_exp))'',0,100));
    maxlength_unit_flag_exp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_flag_exp)));
    avelength_unit_flag_exp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_flag_exp)),h.unit_flag_exp<>(typeof(h.unit_flag_exp))'');
    populated_relationship_code_exp_cnt := COUNT(GROUP,h.relationship_code_exp <> (TYPEOF(h.relationship_code_exp))'');
    populated_relationship_code_exp_pcnt := AVE(GROUP,IF(h.relationship_code_exp = (TYPEOF(h.relationship_code_exp))'',0,100));
    maxlength_relationship_code_exp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.relationship_code_exp)));
    avelength_relationship_code_exp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.relationship_code_exp)),h.relationship_code_exp<>(typeof(h.relationship_code_exp))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_secondary_phone_cnt := COUNT(GROUP,h.clean_secondary_phone <> (TYPEOF(h.clean_secondary_phone))'');
    populated_clean_secondary_phone_pcnt := AVE(GROUP,IF(h.clean_secondary_phone = (TYPEOF(h.clean_secondary_phone))'',0,100));
    maxlength_clean_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_secondary_phone)));
    avelength_clean_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_secondary_phone)),h.clean_secondary_phone<>(typeof(h.clean_secondary_phone))'');
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
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
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
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_franchisee_id_pcnt *   0.00 / 100 + T.Populated_brand_name_pcnt *   0.00 / 100 + T.Populated_fruns_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_exec_full_name_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zip_code4_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_extension_pcnt *   0.00 / 100 + T.Populated_secondary_phone_pcnt *   0.00 / 100 + T.Populated_unit_flag_pcnt *   0.00 / 100 + T.Populated_relationship_code_pcnt *   0.00 / 100 + T.Populated_f_units_pcnt *   0.00 / 100 + T.Populated_website_url_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_industry_pcnt *   0.00 / 100 + T.Populated_sector_pcnt *   0.00 / 100 + T.Populated_industry_type_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_frn_start_date_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_unit_flag_exp_pcnt *   0.00 / 100 + T.Populated_relationship_code_exp_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_secondary_phone_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','franchisee_id','brand_name','fruns','company_name','exec_full_name','address1','address2','city','state','zip_code','zip_code4','phone','phone_extension','secondary_phone','unit_flag','relationship_code','f_units','website_url','email','industry','sector','industry_type','sic_code','frn_start_date','record_id','unit_flag_exp','relationship_code_exp','clean_phone','clean_secondary_phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_franchisee_id_pcnt,le.populated_brand_name_pcnt,le.populated_fruns_pcnt,le.populated_company_name_pcnt,le.populated_exec_full_name_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_zip_code4_pcnt,le.populated_phone_pcnt,le.populated_phone_extension_pcnt,le.populated_secondary_phone_pcnt,le.populated_unit_flag_pcnt,le.populated_relationship_code_pcnt,le.populated_f_units_pcnt,le.populated_website_url_pcnt,le.populated_email_pcnt,le.populated_industry_pcnt,le.populated_sector_pcnt,le.populated_industry_type_pcnt,le.populated_sic_code_pcnt,le.populated_frn_start_date_pcnt,le.populated_record_id_pcnt,le.populated_unit_flag_exp_pcnt,le.populated_relationship_code_exp_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_secondary_phone_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_source_rec_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_did,le.maxlength_did_score,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_franchisee_id,le.maxlength_brand_name,le.maxlength_fruns,le.maxlength_company_name,le.maxlength_exec_full_name,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_zip_code4,le.maxlength_phone,le.maxlength_phone_extension,le.maxlength_secondary_phone,le.maxlength_unit_flag,le.maxlength_relationship_code,le.maxlength_f_units,le.maxlength_website_url,le.maxlength_email,le.maxlength_industry,le.maxlength_sector,le.maxlength_industry_type,le.maxlength_sic_code,le.maxlength_frn_start_date,le.maxlength_record_id,le.maxlength_unit_flag_exp,le.maxlength_relationship_code_exp,le.maxlength_clean_phone,le.maxlength_clean_secondary_phone,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_source_rec_id);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_bdid,le.avelength_bdid_score,le.avelength_did,le.avelength_did_score,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_franchisee_id,le.avelength_brand_name,le.avelength_fruns,le.avelength_company_name,le.avelength_exec_full_name,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_zip_code4,le.avelength_phone,le.avelength_phone_extension,le.avelength_secondary_phone,le.avelength_unit_flag,le.avelength_relationship_code,le.avelength_f_units,le.avelength_website_url,le.avelength_email,le.avelength_industry,le.avelength_sector,le.avelength_industry_type,le.avelength_sic_code,le.avelength_frn_start_date,le.avelength_record_id,le.avelength_unit_flag_exp,le.avelength_relationship_code_exp,le.avelength_clean_phone,le.avelength_clean_secondary_phone,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_source_rec_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 97, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.franchisee_id),TRIM((SALT38.StrType)le.brand_name),TRIM((SALT38.StrType)le.fruns),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.exec_full_name),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_code4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_extension),TRIM((SALT38.StrType)le.secondary_phone),TRIM((SALT38.StrType)le.unit_flag),TRIM((SALT38.StrType)le.relationship_code),TRIM((SALT38.StrType)le.f_units),TRIM((SALT38.StrType)le.website_url),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.industry),TRIM((SALT38.StrType)le.sector),TRIM((SALT38.StrType)le.industry_type),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.frn_start_date),TRIM((SALT38.StrType)le.record_id),TRIM((SALT38.StrType)le.unit_flag_exp),TRIM((SALT38.StrType)le.relationship_code_exp),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_secondary_phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,97,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 97);
  SELF.FldNo2 := 1 + (C % 97);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.franchisee_id),TRIM((SALT38.StrType)le.brand_name),TRIM((SALT38.StrType)le.fruns),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.exec_full_name),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_code4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_extension),TRIM((SALT38.StrType)le.secondary_phone),TRIM((SALT38.StrType)le.unit_flag),TRIM((SALT38.StrType)le.relationship_code),TRIM((SALT38.StrType)le.f_units),TRIM((SALT38.StrType)le.website_url),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.industry),TRIM((SALT38.StrType)le.sector),TRIM((SALT38.StrType)le.industry_type),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.frn_start_date),TRIM((SALT38.StrType)le.record_id),TRIM((SALT38.StrType)le.unit_flag_exp),TRIM((SALT38.StrType)le.relationship_code_exp),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_secondary_phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.franchisee_id),TRIM((SALT38.StrType)le.brand_name),TRIM((SALT38.StrType)le.fruns),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.exec_full_name),TRIM((SALT38.StrType)le.address1),TRIM((SALT38.StrType)le.address2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_code4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_extension),TRIM((SALT38.StrType)le.secondary_phone),TRIM((SALT38.StrType)le.unit_flag),TRIM((SALT38.StrType)le.relationship_code),TRIM((SALT38.StrType)le.f_units),TRIM((SALT38.StrType)le.website_url),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.industry),TRIM((SALT38.StrType)le.sector),TRIM((SALT38.StrType)le.industry_type),TRIM((SALT38.StrType)le.sic_code),TRIM((SALT38.StrType)le.frn_start_date),TRIM((SALT38.StrType)le.record_id),TRIM((SALT38.StrType)le.unit_flag_exp),TRIM((SALT38.StrType)le.relationship_code_exp),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_secondary_phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),97*97,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{22,'bdid'}
      ,{23,'bdid_score'}
      ,{24,'did'}
      ,{25,'did_score'}
      ,{26,'dt_first_seen'}
      ,{27,'dt_last_seen'}
      ,{28,'dt_vendor_first_reported'}
      ,{29,'dt_vendor_last_reported'}
      ,{30,'record_type'}
      ,{31,'franchisee_id'}
      ,{32,'brand_name'}
      ,{33,'fruns'}
      ,{34,'company_name'}
      ,{35,'exec_full_name'}
      ,{36,'address1'}
      ,{37,'address2'}
      ,{38,'city'}
      ,{39,'state'}
      ,{40,'zip_code'}
      ,{41,'zip_code4'}
      ,{42,'phone'}
      ,{43,'phone_extension'}
      ,{44,'secondary_phone'}
      ,{45,'unit_flag'}
      ,{46,'relationship_code'}
      ,{47,'f_units'}
      ,{48,'website_url'}
      ,{49,'email'}
      ,{50,'industry'}
      ,{51,'sector'}
      ,{52,'industry_type'}
      ,{53,'sic_code'}
      ,{54,'frn_start_date'}
      ,{55,'record_id'}
      ,{56,'unit_flag_exp'}
      ,{57,'relationship_code_exp'}
      ,{58,'clean_phone'}
      ,{59,'clean_secondary_phone'}
      ,{60,'title'}
      ,{61,'fname'}
      ,{62,'mname'}
      ,{63,'lname'}
      ,{64,'name_suffix'}
      ,{65,'name_score'}
      ,{66,'prim_range'}
      ,{67,'predir'}
      ,{68,'prim_name'}
      ,{69,'addr_suffix'}
      ,{70,'postdir'}
      ,{71,'unit_desig'}
      ,{72,'sec_range'}
      ,{73,'p_city_name'}
      ,{74,'v_city_name'}
      ,{75,'st'}
      ,{76,'zip'}
      ,{77,'zip4'}
      ,{78,'cart'}
      ,{79,'cr_sort_sz'}
      ,{80,'lot'}
      ,{81,'lot_order'}
      ,{82,'dbpc'}
      ,{83,'chk_digit'}
      ,{84,'rec_type'}
      ,{85,'fips_state'}
      ,{86,'fips_county'}
      ,{87,'geo_lat'}
      ,{88,'geo_long'}
      ,{89,'msa'}
      ,{90,'geo_blk'}
      ,{91,'geo_match'}
      ,{92,'err_stat'}
      ,{93,'raw_aid'}
      ,{94,'ace_aid'}
      ,{95,'prep_addr_line1'}
      ,{96,'prep_addr_line_last'}
      ,{97,'source_rec_id'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
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
    Base_Fields.InValid_bdid((SALT38.StrType)le.bdid),
    Base_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score),
    Base_Fields.InValid_did((SALT38.StrType)le.did),
    Base_Fields.InValid_did_score((SALT38.StrType)le.did_score),
    Base_Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    Base_Fields.InValid_franchisee_id((SALT38.StrType)le.franchisee_id),
    Base_Fields.InValid_brand_name((SALT38.StrType)le.brand_name),
    Base_Fields.InValid_fruns((SALT38.StrType)le.fruns),
    Base_Fields.InValid_company_name((SALT38.StrType)le.company_name,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname),
    Base_Fields.InValid_exec_full_name((SALT38.StrType)le.exec_full_name),
    Base_Fields.InValid_address1((SALT38.StrType)le.address1),
    Base_Fields.InValid_address2((SALT38.StrType)le.address2),
    Base_Fields.InValid_city((SALT38.StrType)le.city),
    Base_Fields.InValid_state((SALT38.StrType)le.state),
    Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Base_Fields.InValid_zip_code4((SALT38.StrType)le.zip_code4),
    Base_Fields.InValid_phone((SALT38.StrType)le.phone),
    Base_Fields.InValid_phone_extension((SALT38.StrType)le.phone_extension),
    Base_Fields.InValid_secondary_phone((SALT38.StrType)le.secondary_phone),
    Base_Fields.InValid_unit_flag((SALT38.StrType)le.unit_flag),
    Base_Fields.InValid_relationship_code((SALT38.StrType)le.relationship_code),
    Base_Fields.InValid_f_units((SALT38.StrType)le.f_units),
    Base_Fields.InValid_website_url((SALT38.StrType)le.website_url),
    Base_Fields.InValid_email((SALT38.StrType)le.email),
    Base_Fields.InValid_industry((SALT38.StrType)le.industry),
    Base_Fields.InValid_sector((SALT38.StrType)le.sector),
    Base_Fields.InValid_industry_type((SALT38.StrType)le.industry_type),
    Base_Fields.InValid_sic_code((SALT38.StrType)le.sic_code),
    Base_Fields.InValid_frn_start_date((SALT38.StrType)le.frn_start_date),
    Base_Fields.InValid_record_id((SALT38.StrType)le.record_id),
    Base_Fields.InValid_unit_flag_exp((SALT38.StrType)le.unit_flag_exp),
    Base_Fields.InValid_relationship_code_exp((SALT38.StrType)le.relationship_code_exp),
    Base_Fields.InValid_clean_phone((SALT38.StrType)le.clean_phone),
    Base_Fields.InValid_clean_secondary_phone((SALT38.StrType)le.clean_secondary_phone),
    Base_Fields.InValid_title((SALT38.StrType)le.title),
    Base_Fields.InValid_fname((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name),
    Base_Fields.InValid_mname((SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name),
    Base_Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.company_name),
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
    Base_Fields.InValid_fips_state((SALT38.StrType)le.fips_state),
    Base_Fields.InValid_fips_county((SALT38.StrType)le.fips_county),
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
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,97,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_zero_integer','invalid_zero_integer','invalid_pastdate08','invalid_pastdate08','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_franchisee_id','invalid_mandatory','invalid_fruns','invalid_company_name','Unknown','invalid_mandatory','Unknown','invalid_mandatory','invalid_state','invalid_zip_code','invalid_zip_code4','invalid_phone','invalid_numeric','invalid_secondary_phone','invalid_unit_flag','invalid_relationship_code','invalid_nonempty_number','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_industry_type','invalid_sic_code','Unknown','invalid_nonempty_number','invalid_unit_flag_exp','invalid_relationship_code_exp','invalid_phone','invalid_secondary_phone','Unknown','invalid_fname','invalid_mname','invalid_lname','Unknown','Unknown','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip_code','invalid_zip_code4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_mandatory','invalid_mandatory','invalid_source_rec_id');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_franchisee_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_brand_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fruns(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_exec_full_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone_extension(TotalErrors.ErrorNum),Base_Fields.InValidMessage_secondary_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_relationship_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_f_units(TotalErrors.ErrorNum),Base_Fields.InValidMessage_website_url(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_industry(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sector(TotalErrors.ErrorNum),Base_Fields.InValidMessage_industry_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_frn_start_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_flag_exp(TotalErrors.ErrorNum),Base_Fields.InValidMessage_relationship_code_exp(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_secondary_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
