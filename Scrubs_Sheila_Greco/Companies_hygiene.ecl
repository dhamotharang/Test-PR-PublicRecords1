IMPORT SALT311,STD;
EXPORT Companies_hygiene(dataset(Companies_layout_Sheila_Greco) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_rawfields_maincompanyid_cnt := COUNT(GROUP,h.rawfields_maincompanyid <> (TYPEOF(h.rawfields_maincompanyid))'');
    populated_rawfields_maincompanyid_pcnt := AVE(GROUP,IF(h.rawfields_maincompanyid = (TYPEOF(h.rawfields_maincompanyid))'',0,100));
    maxlength_rawfields_maincompanyid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincompanyid)));
    avelength_rawfields_maincompanyid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincompanyid)),h.rawfields_maincompanyid<>(typeof(h.rawfields_maincompanyid))'');
    populated_rawfields_companyname_cnt := COUNT(GROUP,h.rawfields_companyname <> (TYPEOF(h.rawfields_companyname))'');
    populated_rawfields_companyname_pcnt := AVE(GROUP,IF(h.rawfields_companyname = (TYPEOF(h.rawfields_companyname))'',0,100));
    maxlength_rawfields_companyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_companyname)));
    avelength_rawfields_companyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_companyname)),h.rawfields_companyname<>(typeof(h.rawfields_companyname))'');
    populated_rawfields_ticker_cnt := COUNT(GROUP,h.rawfields_ticker <> (TYPEOF(h.rawfields_ticker))'');
    populated_rawfields_ticker_pcnt := AVE(GROUP,IF(h.rawfields_ticker = (TYPEOF(h.rawfields_ticker))'',0,100));
    maxlength_rawfields_ticker := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_ticker)));
    avelength_rawfields_ticker := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_ticker)),h.rawfields_ticker<>(typeof(h.rawfields_ticker))'');
    populated_rawfields_fortunerank_cnt := COUNT(GROUP,h.rawfields_fortunerank <> (TYPEOF(h.rawfields_fortunerank))'');
    populated_rawfields_fortunerank_pcnt := AVE(GROUP,IF(h.rawfields_fortunerank = (TYPEOF(h.rawfields_fortunerank))'',0,100));
    maxlength_rawfields_fortunerank := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_fortunerank)));
    avelength_rawfields_fortunerank := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_fortunerank)),h.rawfields_fortunerank<>(typeof(h.rawfields_fortunerank))'');
    populated_rawfields_primaryindustry_cnt := COUNT(GROUP,h.rawfields_primaryindustry <> (TYPEOF(h.rawfields_primaryindustry))'');
    populated_rawfields_primaryindustry_pcnt := AVE(GROUP,IF(h.rawfields_primaryindustry = (TYPEOF(h.rawfields_primaryindustry))'',0,100));
    maxlength_rawfields_primaryindustry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primaryindustry)));
    avelength_rawfields_primaryindustry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primaryindustry)),h.rawfields_primaryindustry<>(typeof(h.rawfields_primaryindustry))'');
    populated_rawfields_address1_cnt := COUNT(GROUP,h.rawfields_address1 <> (TYPEOF(h.rawfields_address1))'');
    populated_rawfields_address1_pcnt := AVE(GROUP,IF(h.rawfields_address1 = (TYPEOF(h.rawfields_address1))'',0,100));
    maxlength_rawfields_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address1)));
    avelength_rawfields_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address1)),h.rawfields_address1<>(typeof(h.rawfields_address1))'');
    populated_rawfields_address2_cnt := COUNT(GROUP,h.rawfields_address2 <> (TYPEOF(h.rawfields_address2))'');
    populated_rawfields_address2_pcnt := AVE(GROUP,IF(h.rawfields_address2 = (TYPEOF(h.rawfields_address2))'',0,100));
    maxlength_rawfields_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address2)));
    avelength_rawfields_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_address2)),h.rawfields_address2<>(typeof(h.rawfields_address2))'');
    populated_rawfields_city_cnt := COUNT(GROUP,h.rawfields_city <> (TYPEOF(h.rawfields_city))'');
    populated_rawfields_city_pcnt := AVE(GROUP,IF(h.rawfields_city = (TYPEOF(h.rawfields_city))'',0,100));
    maxlength_rawfields_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_city)));
    avelength_rawfields_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_city)),h.rawfields_city<>(typeof(h.rawfields_city))'');
    populated_rawfields_state_cnt := COUNT(GROUP,h.rawfields_state <> (TYPEOF(h.rawfields_state))'');
    populated_rawfields_state_pcnt := AVE(GROUP,IF(h.rawfields_state = (TYPEOF(h.rawfields_state))'',0,100));
    maxlength_rawfields_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_state)));
    avelength_rawfields_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_state)),h.rawfields_state<>(typeof(h.rawfields_state))'');
    populated_rawfields_zip_cnt := COUNT(GROUP,h.rawfields_zip <> (TYPEOF(h.rawfields_zip))'');
    populated_rawfields_zip_pcnt := AVE(GROUP,IF(h.rawfields_zip = (TYPEOF(h.rawfields_zip))'',0,100));
    maxlength_rawfields_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_zip)));
    avelength_rawfields_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_zip)),h.rawfields_zip<>(typeof(h.rawfields_zip))'');
    populated_rawfields_country_cnt := COUNT(GROUP,h.rawfields_country <> (TYPEOF(h.rawfields_country))'');
    populated_rawfields_country_pcnt := AVE(GROUP,IF(h.rawfields_country = (TYPEOF(h.rawfields_country))'',0,100));
    maxlength_rawfields_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)));
    avelength_rawfields_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)),h.rawfields_country<>(typeof(h.rawfields_country))'');
    populated_rawfields_region_cnt := COUNT(GROUP,h.rawfields_region <> (TYPEOF(h.rawfields_region))'');
    populated_rawfields_region_pcnt := AVE(GROUP,IF(h.rawfields_region = (TYPEOF(h.rawfields_region))'',0,100));
    maxlength_rawfields_region := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_region)));
    avelength_rawfields_region := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_region)),h.rawfields_region<>(typeof(h.rawfields_region))'');
    populated_rawfields_phone_cnt := COUNT(GROUP,h.rawfields_phone <> (TYPEOF(h.rawfields_phone))'');
    populated_rawfields_phone_pcnt := AVE(GROUP,IF(h.rawfields_phone = (TYPEOF(h.rawfields_phone))'',0,100));
    maxlength_rawfields_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_phone)));
    avelength_rawfields_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_phone)),h.rawfields_phone<>(typeof(h.rawfields_phone))'');
    populated_rawfields_extension_cnt := COUNT(GROUP,h.rawfields_extension <> (TYPEOF(h.rawfields_extension))'');
    populated_rawfields_extension_pcnt := AVE(GROUP,IF(h.rawfields_extension = (TYPEOF(h.rawfields_extension))'',0,100));
    maxlength_rawfields_extension := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_extension)));
    avelength_rawfields_extension := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_extension)),h.rawfields_extension<>(typeof(h.rawfields_extension))'');
    populated_rawfields_weburl_cnt := COUNT(GROUP,h.rawfields_weburl <> (TYPEOF(h.rawfields_weburl))'');
    populated_rawfields_weburl_pcnt := AVE(GROUP,IF(h.rawfields_weburl = (TYPEOF(h.rawfields_weburl))'',0,100));
    maxlength_rawfields_weburl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_weburl)));
    avelength_rawfields_weburl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_weburl)),h.rawfields_weburl<>(typeof(h.rawfields_weburl))'');
    populated_rawfields_sales_cnt := COUNT(GROUP,h.rawfields_sales <> (TYPEOF(h.rawfields_sales))'');
    populated_rawfields_sales_pcnt := AVE(GROUP,IF(h.rawfields_sales = (TYPEOF(h.rawfields_sales))'',0,100));
    maxlength_rawfields_sales := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_sales)));
    avelength_rawfields_sales := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_sales)),h.rawfields_sales<>(typeof(h.rawfields_sales))'');
    populated_rawfields_employees_cnt := COUNT(GROUP,h.rawfields_employees <> (TYPEOF(h.rawfields_employees))'');
    populated_rawfields_employees_pcnt := AVE(GROUP,IF(h.rawfields_employees = (TYPEOF(h.rawfields_employees))'',0,100));
    maxlength_rawfields_employees := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_employees)));
    avelength_rawfields_employees := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_employees)),h.rawfields_employees<>(typeof(h.rawfields_employees))'');
    populated_rawfields_competitors_cnt := COUNT(GROUP,h.rawfields_competitors <> (TYPEOF(h.rawfields_competitors))'');
    populated_rawfields_competitors_pcnt := AVE(GROUP,IF(h.rawfields_competitors = (TYPEOF(h.rawfields_competitors))'',0,100));
    maxlength_rawfields_competitors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_competitors)));
    avelength_rawfields_competitors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_competitors)),h.rawfields_competitors<>(typeof(h.rawfields_competitors))'');
    populated_rawfields_divisionname_cnt := COUNT(GROUP,h.rawfields_divisionname <> (TYPEOF(h.rawfields_divisionname))'');
    populated_rawfields_divisionname_pcnt := AVE(GROUP,IF(h.rawfields_divisionname = (TYPEOF(h.rawfields_divisionname))'',0,100));
    maxlength_rawfields_divisionname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_divisionname)));
    avelength_rawfields_divisionname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_divisionname)),h.rawfields_divisionname<>(typeof(h.rawfields_divisionname))'');
    populated_rawfields_siccode_cnt := COUNT(GROUP,h.rawfields_siccode <> (TYPEOF(h.rawfields_siccode))'');
    populated_rawfields_siccode_pcnt := AVE(GROUP,IF(h.rawfields_siccode = (TYPEOF(h.rawfields_siccode))'',0,100));
    maxlength_rawfields_siccode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_siccode)));
    avelength_rawfields_siccode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_siccode)),h.rawfields_siccode<>(typeof(h.rawfields_siccode))'');
    populated_rawfields_auditor_cnt := COUNT(GROUP,h.rawfields_auditor <> (TYPEOF(h.rawfields_auditor))'');
    populated_rawfields_auditor_pcnt := AVE(GROUP,IF(h.rawfields_auditor = (TYPEOF(h.rawfields_auditor))'',0,100));
    maxlength_rawfields_auditor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_auditor)));
    avelength_rawfields_auditor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_auditor)),h.rawfields_auditor<>(typeof(h.rawfields_auditor))'');
    populated_rawfields_entrydate_cnt := COUNT(GROUP,h.rawfields_entrydate <> (TYPEOF(h.rawfields_entrydate))'');
    populated_rawfields_entrydate_pcnt := AVE(GROUP,IF(h.rawfields_entrydate = (TYPEOF(h.rawfields_entrydate))'',0,100));
    maxlength_rawfields_entrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrydate)));
    avelength_rawfields_entrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrydate)),h.rawfields_entrydate<>(typeof(h.rawfields_entrydate))'');
    populated_rawfields_lastupdate_cnt := COUNT(GROUP,h.rawfields_lastupdate <> (TYPEOF(h.rawfields_lastupdate))'');
    populated_rawfields_lastupdate_pcnt := AVE(GROUP,IF(h.rawfields_lastupdate = (TYPEOF(h.rawfields_lastupdate))'',0,100));
    maxlength_rawfields_lastupdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastupdate)));
    avelength_rawfields_lastupdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastupdate)),h.rawfields_lastupdate<>(typeof(h.rawfields_lastupdate))'');
    populated_rawfields_entrystaffid_cnt := COUNT(GROUP,h.rawfields_entrystaffid <> (TYPEOF(h.rawfields_entrystaffid))'');
    populated_rawfields_entrystaffid_pcnt := AVE(GROUP,IF(h.rawfields_entrystaffid = (TYPEOF(h.rawfields_entrystaffid))'',0,100));
    maxlength_rawfields_entrystaffid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrystaffid)));
    avelength_rawfields_entrystaffid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrystaffid)),h.rawfields_entrystaffid<>(typeof(h.rawfields_entrystaffid))'');
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
    populated_clean_dates_entrydate_cnt := COUNT(GROUP,h.clean_dates_entrydate <> (TYPEOF(h.clean_dates_entrydate))'');
    populated_clean_dates_entrydate_pcnt := AVE(GROUP,IF(h.clean_dates_entrydate = (TYPEOF(h.clean_dates_entrydate))'',0,100));
    maxlength_clean_dates_entrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_entrydate)));
    avelength_clean_dates_entrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_entrydate)),h.clean_dates_entrydate<>(typeof(h.clean_dates_entrydate))'');
    populated_clean_dates_lastupdate_cnt := COUNT(GROUP,h.clean_dates_lastupdate <> (TYPEOF(h.clean_dates_lastupdate))'');
    populated_clean_dates_lastupdate_pcnt := AVE(GROUP,IF(h.clean_dates_lastupdate = (TYPEOF(h.clean_dates_lastupdate))'',0,100));
    maxlength_clean_dates_lastupdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_lastupdate)));
    avelength_clean_dates_lastupdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_lastupdate)),h.clean_dates_lastupdate<>(typeof(h.clean_dates_lastupdate))'');
    populated_clean_phones_phone_cnt := COUNT(GROUP,h.clean_phones_phone <> (TYPEOF(h.clean_phones_phone))'');
    populated_clean_phones_phone_pcnt := AVE(GROUP,IF(h.clean_phones_phone = (TYPEOF(h.clean_phones_phone))'',0,100));
    maxlength_clean_phones_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_phone)));
    avelength_clean_phones_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_phone)),h.clean_phones_phone<>(typeof(h.clean_phones_phone))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_rawfields_maincompanyid_pcnt *   0.00 / 100 + T.Populated_rawfields_companyname_pcnt *   0.00 / 100 + T.Populated_rawfields_ticker_pcnt *   0.00 / 100 + T.Populated_rawfields_fortunerank_pcnt *   0.00 / 100 + T.Populated_rawfields_primaryindustry_pcnt *   0.00 / 100 + T.Populated_rawfields_address1_pcnt *   0.00 / 100 + T.Populated_rawfields_address2_pcnt *   0.00 / 100 + T.Populated_rawfields_city_pcnt *   0.00 / 100 + T.Populated_rawfields_state_pcnt *   0.00 / 100 + T.Populated_rawfields_zip_pcnt *   0.00 / 100 + T.Populated_rawfields_country_pcnt *   0.00 / 100 + T.Populated_rawfields_region_pcnt *   0.00 / 100 + T.Populated_rawfields_phone_pcnt *   0.00 / 100 + T.Populated_rawfields_extension_pcnt *   0.00 / 100 + T.Populated_rawfields_weburl_pcnt *   0.00 / 100 + T.Populated_rawfields_sales_pcnt *   0.00 / 100 + T.Populated_rawfields_employees_pcnt *   0.00 / 100 + T.Populated_rawfields_competitors_pcnt *   0.00 / 100 + T.Populated_rawfields_divisionname_pcnt *   0.00 / 100 + T.Populated_rawfields_siccode_pcnt *   0.00 / 100 + T.Populated_rawfields_auditor_pcnt *   0.00 / 100 + T.Populated_rawfields_entrydate_pcnt *   0.00 / 100 + T.Populated_rawfields_lastupdate_pcnt *   0.00 / 100 + T.Populated_rawfields_entrystaffid_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_address_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_address_zip4_pcnt *   0.00 / 100 + T.Populated_clean_address_cart_pcnt *   0.00 / 100 + T.Populated_clean_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_address_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_address_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_state_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_county_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_address_msa_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_address_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_dates_entrydate_pcnt *   0.00 / 100 + T.Populated_clean_dates_lastupdate_pcnt *   0.00 / 100 + T.Populated_clean_phones_phone_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincompanyid','rawfields_companyname','rawfields_ticker','rawfields_fortunerank','rawfields_primaryindustry','rawfields_address1','rawfields_address2','rawfields_city','rawfields_state','rawfields_zip','rawfields_country','rawfields_region','rawfields_phone','rawfields_extension','rawfields_weburl','rawfields_sales','rawfields_employees','rawfields_competitors','rawfields_divisionname','rawfields_siccode','rawfields_auditor','rawfields_entrydate','rawfields_lastupdate','rawfields_entrystaffid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_phone','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_rawfields_maincompanyid_pcnt,le.populated_rawfields_companyname_pcnt,le.populated_rawfields_ticker_pcnt,le.populated_rawfields_fortunerank_pcnt,le.populated_rawfields_primaryindustry_pcnt,le.populated_rawfields_address1_pcnt,le.populated_rawfields_address2_pcnt,le.populated_rawfields_city_pcnt,le.populated_rawfields_state_pcnt,le.populated_rawfields_zip_pcnt,le.populated_rawfields_country_pcnt,le.populated_rawfields_region_pcnt,le.populated_rawfields_phone_pcnt,le.populated_rawfields_extension_pcnt,le.populated_rawfields_weburl_pcnt,le.populated_rawfields_sales_pcnt,le.populated_rawfields_employees_pcnt,le.populated_rawfields_competitors_pcnt,le.populated_rawfields_divisionname_pcnt,le.populated_rawfields_siccode_pcnt,le.populated_rawfields_auditor_pcnt,le.populated_rawfields_entrydate_pcnt,le.populated_rawfields_lastupdate_pcnt,le.populated_rawfields_entrystaffid_pcnt,le.populated_clean_address_prim_range_pcnt,le.populated_clean_address_predir_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_addr_suffix_pcnt,le.populated_clean_address_postdir_pcnt,le.populated_clean_address_unit_desig_pcnt,le.populated_clean_address_sec_range_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt,le.populated_clean_address_zip4_pcnt,le.populated_clean_address_cart_pcnt,le.populated_clean_address_cr_sort_sz_pcnt,le.populated_clean_address_lot_pcnt,le.populated_clean_address_lot_order_pcnt,le.populated_clean_address_dbpc_pcnt,le.populated_clean_address_chk_digit_pcnt,le.populated_clean_address_rec_type_pcnt,le.populated_clean_address_fips_state_pcnt,le.populated_clean_address_fips_county_pcnt,le.populated_clean_address_geo_lat_pcnt,le.populated_clean_address_geo_long_pcnt,le.populated_clean_address_msa_pcnt,le.populated_clean_address_geo_blk_pcnt,le.populated_clean_address_geo_match_pcnt,le.populated_clean_address_err_stat_pcnt,le.populated_clean_dates_entrydate_pcnt,le.populated_clean_dates_lastupdate_pcnt,le.populated_clean_phones_phone_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_rawfields_maincompanyid,le.maxlength_rawfields_companyname,le.maxlength_rawfields_ticker,le.maxlength_rawfields_fortunerank,le.maxlength_rawfields_primaryindustry,le.maxlength_rawfields_address1,le.maxlength_rawfields_address2,le.maxlength_rawfields_city,le.maxlength_rawfields_state,le.maxlength_rawfields_zip,le.maxlength_rawfields_country,le.maxlength_rawfields_region,le.maxlength_rawfields_phone,le.maxlength_rawfields_extension,le.maxlength_rawfields_weburl,le.maxlength_rawfields_sales,le.maxlength_rawfields_employees,le.maxlength_rawfields_competitors,le.maxlength_rawfields_divisionname,le.maxlength_rawfields_siccode,le.maxlength_rawfields_auditor,le.maxlength_rawfields_entrydate,le.maxlength_rawfields_lastupdate,le.maxlength_rawfields_entrystaffid,le.maxlength_clean_address_prim_range,le.maxlength_clean_address_predir,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_addr_suffix,le.maxlength_clean_address_postdir,le.maxlength_clean_address_unit_desig,le.maxlength_clean_address_sec_range,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip,le.maxlength_clean_address_zip4,le.maxlength_clean_address_cart,le.maxlength_clean_address_cr_sort_sz,le.maxlength_clean_address_lot,le.maxlength_clean_address_lot_order,le.maxlength_clean_address_dbpc,le.maxlength_clean_address_chk_digit,le.maxlength_clean_address_rec_type,le.maxlength_clean_address_fips_state,le.maxlength_clean_address_fips_county,le.maxlength_clean_address_geo_lat,le.maxlength_clean_address_geo_long,le.maxlength_clean_address_msa,le.maxlength_clean_address_geo_blk,le.maxlength_clean_address_geo_match,le.maxlength_clean_address_err_stat,le.maxlength_clean_dates_entrydate,le.maxlength_clean_dates_lastupdate,le.maxlength_clean_phones_phone,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id,le.avelength_bdid,le.avelength_bdid_score,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_rawfields_maincompanyid,le.avelength_rawfields_companyname,le.avelength_rawfields_ticker,le.avelength_rawfields_fortunerank,le.avelength_rawfields_primaryindustry,le.avelength_rawfields_address1,le.avelength_rawfields_address2,le.avelength_rawfields_city,le.avelength_rawfields_state,le.avelength_rawfields_zip,le.avelength_rawfields_country,le.avelength_rawfields_region,le.avelength_rawfields_phone,le.avelength_rawfields_extension,le.avelength_rawfields_weburl,le.avelength_rawfields_sales,le.avelength_rawfields_employees,le.avelength_rawfields_competitors,le.avelength_rawfields_divisionname,le.avelength_rawfields_siccode,le.avelength_rawfields_auditor,le.avelength_rawfields_entrydate,le.avelength_rawfields_lastupdate,le.avelength_rawfields_entrystaffid,le.avelength_clean_address_prim_range,le.avelength_clean_address_predir,le.avelength_clean_address_prim_name,le.avelength_clean_address_addr_suffix,le.avelength_clean_address_postdir,le.avelength_clean_address_unit_desig,le.avelength_clean_address_sec_range,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip,le.avelength_clean_address_zip4,le.avelength_clean_address_cart,le.avelength_clean_address_cr_sort_sz,le.avelength_clean_address_lot,le.avelength_clean_address_lot_order,le.avelength_clean_address_dbpc,le.avelength_clean_address_chk_digit,le.avelength_clean_address_rec_type,le.avelength_clean_address_fips_state,le.avelength_clean_address_fips_county,le.avelength_clean_address_geo_lat,le.avelength_clean_address_geo_long,le.avelength_clean_address_msa,le.avelength_clean_address_geo_blk,le.avelength_clean_address_geo_match,le.avelength_clean_address_err_stat,le.avelength_clean_dates_entrydate,le.avelength_clean_dates_lastupdate,le.avelength_clean_phones_phone,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 87, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_companyname),TRIM((SALT311.StrType)le.rawfields_ticker),TRIM((SALT311.StrType)le.rawfields_fortunerank),TRIM((SALT311.StrType)le.rawfields_primaryindustry),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_address2),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_region),TRIM((SALT311.StrType)le.rawfields_phone),TRIM((SALT311.StrType)le.rawfields_extension),TRIM((SALT311.StrType)le.rawfields_weburl),TRIM((SALT311.StrType)le.rawfields_sales),TRIM((SALT311.StrType)le.rawfields_employees),TRIM((SALT311.StrType)le.rawfields_competitors),TRIM((SALT311.StrType)le.rawfields_divisionname),TRIM((SALT311.StrType)le.rawfields_siccode),TRIM((SALT311.StrType)le.rawfields_auditor),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.rawfields_entrystaffid),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_phone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,87,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 87);
  SELF.FldNo2 := 1 + (C % 87);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_companyname),TRIM((SALT311.StrType)le.rawfields_ticker),TRIM((SALT311.StrType)le.rawfields_fortunerank),TRIM((SALT311.StrType)le.rawfields_primaryindustry),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_address2),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_region),TRIM((SALT311.StrType)le.rawfields_phone),TRIM((SALT311.StrType)le.rawfields_extension),TRIM((SALT311.StrType)le.rawfields_weburl),TRIM((SALT311.StrType)le.rawfields_sales),TRIM((SALT311.StrType)le.rawfields_employees),TRIM((SALT311.StrType)le.rawfields_competitors),TRIM((SALT311.StrType)le.rawfields_divisionname),TRIM((SALT311.StrType)le.rawfields_siccode),TRIM((SALT311.StrType)le.rawfields_auditor),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.rawfields_entrystaffid),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_phone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_companyname),TRIM((SALT311.StrType)le.rawfields_ticker),TRIM((SALT311.StrType)le.rawfields_fortunerank),TRIM((SALT311.StrType)le.rawfields_primaryindustry),TRIM((SALT311.StrType)le.rawfields_address1),TRIM((SALT311.StrType)le.rawfields_address2),TRIM((SALT311.StrType)le.rawfields_city),TRIM((SALT311.StrType)le.rawfields_state),TRIM((SALT311.StrType)le.rawfields_zip),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_region),TRIM((SALT311.StrType)le.rawfields_phone),TRIM((SALT311.StrType)le.rawfields_extension),TRIM((SALT311.StrType)le.rawfields_weburl),TRIM((SALT311.StrType)le.rawfields_sales),TRIM((SALT311.StrType)le.rawfields_employees),TRIM((SALT311.StrType)le.rawfields_competitors),TRIM((SALT311.StrType)le.rawfields_divisionname),TRIM((SALT311.StrType)le.rawfields_siccode),TRIM((SALT311.StrType)le.rawfields_auditor),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.rawfields_entrystaffid),TRIM((SALT311.StrType)le.clean_address_prim_range),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_addr_suffix),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_unit_desig),TRIM((SALT311.StrType)le.clean_address_sec_range),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip),TRIM((SALT311.StrType)le.clean_address_zip4),TRIM((SALT311.StrType)le.clean_address_cart),TRIM((SALT311.StrType)le.clean_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_address_lot),TRIM((SALT311.StrType)le.clean_address_lot_order),TRIM((SALT311.StrType)le.clean_address_dbpc),TRIM((SALT311.StrType)le.clean_address_chk_digit),TRIM((SALT311.StrType)le.clean_address_rec_type),TRIM((SALT311.StrType)le.clean_address_fips_state),TRIM((SALT311.StrType)le.clean_address_fips_county),TRIM((SALT311.StrType)le.clean_address_geo_lat),TRIM((SALT311.StrType)le.clean_address_geo_long),TRIM((SALT311.StrType)le.clean_address_msa),TRIM((SALT311.StrType)le.clean_address_geo_blk),TRIM((SALT311.StrType)le.clean_address_geo_match),TRIM((SALT311.StrType)le.clean_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_phone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
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
      ,{23,'bdid'}
      ,{24,'bdid_score'}
      ,{25,'raw_aid'}
      ,{26,'ace_aid'}
      ,{27,'dt_first_seen'}
      ,{28,'dt_last_seen'}
      ,{29,'dt_vendor_first_reported'}
      ,{30,'dt_vendor_last_reported'}
      ,{31,'record_type'}
      ,{32,'rawfields_maincompanyid'}
      ,{33,'rawfields_companyname'}
      ,{34,'rawfields_ticker'}
      ,{35,'rawfields_fortunerank'}
      ,{36,'rawfields_primaryindustry'}
      ,{37,'rawfields_address1'}
      ,{38,'rawfields_address2'}
      ,{39,'rawfields_city'}
      ,{40,'rawfields_state'}
      ,{41,'rawfields_zip'}
      ,{42,'rawfields_country'}
      ,{43,'rawfields_region'}
      ,{44,'rawfields_phone'}
      ,{45,'rawfields_extension'}
      ,{46,'rawfields_weburl'}
      ,{47,'rawfields_sales'}
      ,{48,'rawfields_employees'}
      ,{49,'rawfields_competitors'}
      ,{50,'rawfields_divisionname'}
      ,{51,'rawfields_siccode'}
      ,{52,'rawfields_auditor'}
      ,{53,'rawfields_entrydate'}
      ,{54,'rawfields_lastupdate'}
      ,{55,'rawfields_entrystaffid'}
      ,{56,'clean_address_prim_range'}
      ,{57,'clean_address_predir'}
      ,{58,'clean_address_prim_name'}
      ,{59,'clean_address_addr_suffix'}
      ,{60,'clean_address_postdir'}
      ,{61,'clean_address_unit_desig'}
      ,{62,'clean_address_sec_range'}
      ,{63,'clean_address_p_city_name'}
      ,{64,'clean_address_v_city_name'}
      ,{65,'clean_address_st'}
      ,{66,'clean_address_zip'}
      ,{67,'clean_address_zip4'}
      ,{68,'clean_address_cart'}
      ,{69,'clean_address_cr_sort_sz'}
      ,{70,'clean_address_lot'}
      ,{71,'clean_address_lot_order'}
      ,{72,'clean_address_dbpc'}
      ,{73,'clean_address_chk_digit'}
      ,{74,'clean_address_rec_type'}
      ,{75,'clean_address_fips_state'}
      ,{76,'clean_address_fips_county'}
      ,{77,'clean_address_geo_lat'}
      ,{78,'clean_address_geo_long'}
      ,{79,'clean_address_msa'}
      ,{80,'clean_address_geo_blk'}
      ,{81,'clean_address_geo_match'}
      ,{82,'clean_address_err_stat'}
      ,{83,'clean_dates_entrydate'}
      ,{84,'clean_dates_lastupdate'}
      ,{85,'clean_phones_phone'}
      ,{86,'global_sid'}
      ,{87,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Companies_Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Companies_Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Companies_Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Companies_Fields.InValid_empid((SALT311.StrType)le.empid),
    Companies_Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Companies_Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Companies_Fields.InValid_powid((SALT311.StrType)le.powid),
    Companies_Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Companies_Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Companies_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Companies_Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Companies_Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Companies_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Companies_Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Companies_Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Companies_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Companies_Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Companies_Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Companies_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Companies_Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Companies_Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    Companies_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    Companies_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Companies_Fields.InValid_bdid_score((SALT311.StrType)le.bdid_score),
    Companies_Fields.InValid_raw_aid((SALT311.StrType)le.raw_aid),
    Companies_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Companies_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Companies_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Companies_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Companies_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Companies_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Companies_Fields.InValid_rawfields_maincompanyid((SALT311.StrType)le.rawfields_maincompanyid),
    Companies_Fields.InValid_rawfields_companyname((SALT311.StrType)le.rawfields_companyname),
    Companies_Fields.InValid_rawfields_ticker((SALT311.StrType)le.rawfields_ticker),
    Companies_Fields.InValid_rawfields_fortunerank((SALT311.StrType)le.rawfields_fortunerank),
    Companies_Fields.InValid_rawfields_primaryindustry((SALT311.StrType)le.rawfields_primaryindustry),
    Companies_Fields.InValid_rawfields_address1((SALT311.StrType)le.rawfields_address1),
    Companies_Fields.InValid_rawfields_address2((SALT311.StrType)le.rawfields_address2),
    Companies_Fields.InValid_rawfields_city((SALT311.StrType)le.rawfields_city),
    Companies_Fields.InValid_rawfields_state((SALT311.StrType)le.rawfields_state),
    Companies_Fields.InValid_rawfields_zip((SALT311.StrType)le.rawfields_zip),
    Companies_Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country),
    Companies_Fields.InValid_rawfields_region((SALT311.StrType)le.rawfields_region),
    Companies_Fields.InValid_rawfields_phone((SALT311.StrType)le.rawfields_phone),
    Companies_Fields.InValid_rawfields_extension((SALT311.StrType)le.rawfields_extension),
    Companies_Fields.InValid_rawfields_weburl((SALT311.StrType)le.rawfields_weburl),
    Companies_Fields.InValid_rawfields_sales((SALT311.StrType)le.rawfields_sales),
    Companies_Fields.InValid_rawfields_employees((SALT311.StrType)le.rawfields_employees),
    Companies_Fields.InValid_rawfields_competitors((SALT311.StrType)le.rawfields_competitors),
    Companies_Fields.InValid_rawfields_divisionname((SALT311.StrType)le.rawfields_divisionname),
    Companies_Fields.InValid_rawfields_siccode((SALT311.StrType)le.rawfields_siccode),
    Companies_Fields.InValid_rawfields_auditor((SALT311.StrType)le.rawfields_auditor),
    Companies_Fields.InValid_rawfields_entrydate((SALT311.StrType)le.rawfields_entrydate),
    Companies_Fields.InValid_rawfields_lastupdate((SALT311.StrType)le.rawfields_lastupdate),
    Companies_Fields.InValid_rawfields_entrystaffid((SALT311.StrType)le.rawfields_entrystaffid),
    Companies_Fields.InValid_clean_address_prim_range((SALT311.StrType)le.clean_address_prim_range),
    Companies_Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir),
    Companies_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name),
    Companies_Fields.InValid_clean_address_addr_suffix((SALT311.StrType)le.clean_address_addr_suffix),
    Companies_Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir),
    Companies_Fields.InValid_clean_address_unit_desig((SALT311.StrType)le.clean_address_unit_desig),
    Companies_Fields.InValid_clean_address_sec_range((SALT311.StrType)le.clean_address_sec_range),
    Companies_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name),
    Companies_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name),
    Companies_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st),
    Companies_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip),
    Companies_Fields.InValid_clean_address_zip4((SALT311.StrType)le.clean_address_zip4),
    Companies_Fields.InValid_clean_address_cart((SALT311.StrType)le.clean_address_cart),
    Companies_Fields.InValid_clean_address_cr_sort_sz((SALT311.StrType)le.clean_address_cr_sort_sz),
    Companies_Fields.InValid_clean_address_lot((SALT311.StrType)le.clean_address_lot),
    Companies_Fields.InValid_clean_address_lot_order((SALT311.StrType)le.clean_address_lot_order),
    Companies_Fields.InValid_clean_address_dbpc((SALT311.StrType)le.clean_address_dbpc),
    Companies_Fields.InValid_clean_address_chk_digit((SALT311.StrType)le.clean_address_chk_digit),
    Companies_Fields.InValid_clean_address_rec_type((SALT311.StrType)le.clean_address_rec_type),
    Companies_Fields.InValid_clean_address_fips_state((SALT311.StrType)le.clean_address_fips_state),
    Companies_Fields.InValid_clean_address_fips_county((SALT311.StrType)le.clean_address_fips_county),
    Companies_Fields.InValid_clean_address_geo_lat((SALT311.StrType)le.clean_address_geo_lat),
    Companies_Fields.InValid_clean_address_geo_long((SALT311.StrType)le.clean_address_geo_long),
    Companies_Fields.InValid_clean_address_msa((SALT311.StrType)le.clean_address_msa),
    Companies_Fields.InValid_clean_address_geo_blk((SALT311.StrType)le.clean_address_geo_blk),
    Companies_Fields.InValid_clean_address_geo_match((SALT311.StrType)le.clean_address_geo_match),
    Companies_Fields.InValid_clean_address_err_stat((SALT311.StrType)le.clean_address_err_stat),
    Companies_Fields.InValid_clean_dates_entrydate((SALT311.StrType)le.clean_dates_entrydate),
    Companies_Fields.InValid_clean_dates_lastupdate((SALT311.StrType)le.clean_dates_lastupdate),
    Companies_Fields.InValid_clean_phones_phone((SALT311.StrType)le.clean_phones_phone),
    Companies_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Companies_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
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
  FieldNme := Companies_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaChar','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_AlphaCaps','Invalid_Float','Invalid_Float','Invalid_AlphaChar','Invalid_Float','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaNumChar','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Date','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Companies_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_maincompanyid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_companyname(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_ticker(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_fortunerank(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_primaryindustry(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_address1(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_address2(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_city(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_state(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_zip(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_country(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_region(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_phone(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_extension(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_weburl(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_sales(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_employees(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_competitors(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_divisionname(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_siccode(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_auditor(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_entrydate(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_lastupdate(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_rawfields_entrystaffid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_prim_range(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_predir(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_addr_suffix(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_postdir(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_unit_desig(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_sec_range(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_zip4(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_cart(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_cr_sort_sz(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_lot(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_lot_order(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_dbpc(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_chk_digit(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_rec_type(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_fips_state(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_fips_county(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_geo_lat(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_geo_long(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_msa(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_geo_blk(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_geo_match(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_address_err_stat(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_dates_entrydate(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_dates_lastupdate(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_clean_phones_phone(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Companies_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Sheila_Greco, Companies_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
