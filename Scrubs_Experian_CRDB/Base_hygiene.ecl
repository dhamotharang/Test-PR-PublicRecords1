IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_Experian_CRDB) h) := MODULE
 
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
    populated_experian_bus_id_cnt := COUNT(GROUP,h.experian_bus_id <> (TYPEOF(h.experian_bus_id))'');
    populated_experian_bus_id_pcnt := AVE(GROUP,IF(h.experian_bus_id = (TYPEOF(h.experian_bus_id))'',0,100));
    maxlength_experian_bus_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_bus_id)));
    avelength_experian_bus_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_bus_id)),h.experian_bus_id<>(typeof(h.experian_bus_id))'');
    populated_business_name_cnt := COUNT(GROUP,h.business_name <> (TYPEOF(h.business_name))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)),h.address<>(typeof(h.address))'');
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
    populated_zip_plus_4_cnt := COUNT(GROUP,h.zip_plus_4 <> (TYPEOF(h.zip_plus_4))'');
    populated_zip_plus_4_pcnt := AVE(GROUP,IF(h.zip_plus_4 = (TYPEOF(h.zip_plus_4))'',0,100));
    maxlength_zip_plus_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_plus_4)));
    avelength_zip_plus_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_plus_4)),h.zip_plus_4<>(typeof(h.zip_plus_4))'');
    populated_carrier_route_cnt := COUNT(GROUP,h.carrier_route <> (TYPEOF(h.carrier_route))'');
    populated_carrier_route_pcnt := AVE(GROUP,IF(h.carrier_route = (TYPEOF(h.carrier_route))'',0,100));
    maxlength_carrier_route := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.carrier_route)));
    avelength_carrier_route := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.carrier_route)),h.carrier_route<>(typeof(h.carrier_route))'');
    populated_county_code_cnt := COUNT(GROUP,h.county_code <> (TYPEOF(h.county_code))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_msa_code_cnt := COUNT(GROUP,h.msa_code <> (TYPEOF(h.msa_code))'');
    populated_msa_code_pcnt := AVE(GROUP,IF(h.msa_code = (TYPEOF(h.msa_code))'',0,100));
    maxlength_msa_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa_code)));
    avelength_msa_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa_code)),h.msa_code<>(typeof(h.msa_code))'');
    populated_msa_description_cnt := COUNT(GROUP,h.msa_description <> (TYPEOF(h.msa_description))'');
    populated_msa_description_pcnt := AVE(GROUP,IF(h.msa_description = (TYPEOF(h.msa_description))'',0,100));
    maxlength_msa_description := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa_description)));
    avelength_msa_description := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa_description)),h.msa_description<>(typeof(h.msa_description))'');
    populated_establish_date_cnt := COUNT(GROUP,h.establish_date <> (TYPEOF(h.establish_date))'');
    populated_establish_date_pcnt := AVE(GROUP,IF(h.establish_date = (TYPEOF(h.establish_date))'',0,100));
    maxlength_establish_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.establish_date)));
    avelength_establish_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.establish_date)),h.establish_date<>(typeof(h.establish_date))'');
    populated_latest_reported_date_cnt := COUNT(GROUP,h.latest_reported_date <> (TYPEOF(h.latest_reported_date))'');
    populated_latest_reported_date_pcnt := AVE(GROUP,IF(h.latest_reported_date = (TYPEOF(h.latest_reported_date))'',0,100));
    maxlength_latest_reported_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.latest_reported_date)));
    avelength_latest_reported_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.latest_reported_date)),h.latest_reported_date<>(typeof(h.latest_reported_date))'');
    populated_years_in_file_cnt := COUNT(GROUP,h.years_in_file <> (TYPEOF(h.years_in_file))'');
    populated_years_in_file_pcnt := AVE(GROUP,IF(h.years_in_file = (TYPEOF(h.years_in_file))'',0,100));
    maxlength_years_in_file := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_file)));
    avelength_years_in_file := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_file)),h.years_in_file<>(typeof(h.years_in_file))'');
    populated_geo_code_latitude_cnt := COUNT(GROUP,h.geo_code_latitude <> (TYPEOF(h.geo_code_latitude))'');
    populated_geo_code_latitude_pcnt := AVE(GROUP,IF(h.geo_code_latitude = (TYPEOF(h.geo_code_latitude))'',0,100));
    maxlength_geo_code_latitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_latitude)));
    avelength_geo_code_latitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_latitude)),h.geo_code_latitude<>(typeof(h.geo_code_latitude))'');
    populated_geo_code_latitude_direction_cnt := COUNT(GROUP,h.geo_code_latitude_direction <> (TYPEOF(h.geo_code_latitude_direction))'');
    populated_geo_code_latitude_direction_pcnt := AVE(GROUP,IF(h.geo_code_latitude_direction = (TYPEOF(h.geo_code_latitude_direction))'',0,100));
    maxlength_geo_code_latitude_direction := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_latitude_direction)));
    avelength_geo_code_latitude_direction := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_latitude_direction)),h.geo_code_latitude_direction<>(typeof(h.geo_code_latitude_direction))'');
    populated_geo_code_longitude_cnt := COUNT(GROUP,h.geo_code_longitude <> (TYPEOF(h.geo_code_longitude))'');
    populated_geo_code_longitude_pcnt := AVE(GROUP,IF(h.geo_code_longitude = (TYPEOF(h.geo_code_longitude))'',0,100));
    maxlength_geo_code_longitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_longitude)));
    avelength_geo_code_longitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_longitude)),h.geo_code_longitude<>(typeof(h.geo_code_longitude))'');
    populated_geo_code_longitude_direction_cnt := COUNT(GROUP,h.geo_code_longitude_direction <> (TYPEOF(h.geo_code_longitude_direction))'');
    populated_geo_code_longitude_direction_pcnt := AVE(GROUP,IF(h.geo_code_longitude_direction = (TYPEOF(h.geo_code_longitude_direction))'',0,100));
    maxlength_geo_code_longitude_direction := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_longitude_direction)));
    avelength_geo_code_longitude_direction := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_code_longitude_direction)),h.geo_code_longitude_direction<>(typeof(h.geo_code_longitude_direction))'');
    populated_recent_update_code_cnt := COUNT(GROUP,h.recent_update_code <> (TYPEOF(h.recent_update_code))'');
    populated_recent_update_code_pcnt := AVE(GROUP,IF(h.recent_update_code = (TYPEOF(h.recent_update_code))'',0,100));
    maxlength_recent_update_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_update_code)));
    avelength_recent_update_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_update_code)),h.recent_update_code<>(typeof(h.recent_update_code))'');
    populated_years_in_business_code_cnt := COUNT(GROUP,h.years_in_business_code <> (TYPEOF(h.years_in_business_code))'');
    populated_years_in_business_code_pcnt := AVE(GROUP,IF(h.years_in_business_code = (TYPEOF(h.years_in_business_code))'',0,100));
    maxlength_years_in_business_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_business_code)));
    avelength_years_in_business_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_business_code)),h.years_in_business_code<>(typeof(h.years_in_business_code))'');
    populated_year_business_started_cnt := COUNT(GROUP,h.year_business_started <> (TYPEOF(h.year_business_started))'');
    populated_year_business_started_pcnt := AVE(GROUP,IF(h.year_business_started = (TYPEOF(h.year_business_started))'',0,100));
    maxlength_year_business_started := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_business_started)));
    avelength_year_business_started := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_business_started)),h.year_business_started<>(typeof(h.year_business_started))'');
    populated_months_in_file_cnt := COUNT(GROUP,h.months_in_file <> (TYPEOF(h.months_in_file))'');
    populated_months_in_file_pcnt := AVE(GROUP,IF(h.months_in_file = (TYPEOF(h.months_in_file))'',0,100));
    maxlength_months_in_file := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.months_in_file)));
    avelength_months_in_file := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.months_in_file)),h.months_in_file<>(typeof(h.months_in_file))'');
    populated_address_type_code_cnt := COUNT(GROUP,h.address_type_code <> (TYPEOF(h.address_type_code))'');
    populated_address_type_code_pcnt := AVE(GROUP,IF(h.address_type_code = (TYPEOF(h.address_type_code))'',0,100));
    maxlength_address_type_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type_code)));
    avelength_address_type_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type_code)),h.address_type_code<>(typeof(h.address_type_code))'');
    populated_estimated_number_of_employees_cnt := COUNT(GROUP,h.estimated_number_of_employees <> (TYPEOF(h.estimated_number_of_employees))'');
    populated_estimated_number_of_employees_pcnt := AVE(GROUP,IF(h.estimated_number_of_employees = (TYPEOF(h.estimated_number_of_employees))'',0,100));
    maxlength_estimated_number_of_employees := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_number_of_employees)));
    avelength_estimated_number_of_employees := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_number_of_employees)),h.estimated_number_of_employees<>(typeof(h.estimated_number_of_employees))'');
    populated_employee_size_code_cnt := COUNT(GROUP,h.employee_size_code <> (TYPEOF(h.employee_size_code))'');
    populated_employee_size_code_pcnt := AVE(GROUP,IF(h.employee_size_code = (TYPEOF(h.employee_size_code))'',0,100));
    maxlength_employee_size_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.employee_size_code)));
    avelength_employee_size_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.employee_size_code)),h.employee_size_code<>(typeof(h.employee_size_code))'');
    populated_estimated_annual_sales_amount_sign_cnt := COUNT(GROUP,h.estimated_annual_sales_amount_sign <> (TYPEOF(h.estimated_annual_sales_amount_sign))'');
    populated_estimated_annual_sales_amount_sign_pcnt := AVE(GROUP,IF(h.estimated_annual_sales_amount_sign = (TYPEOF(h.estimated_annual_sales_amount_sign))'',0,100));
    maxlength_estimated_annual_sales_amount_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_annual_sales_amount_sign)));
    avelength_estimated_annual_sales_amount_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_annual_sales_amount_sign)),h.estimated_annual_sales_amount_sign<>(typeof(h.estimated_annual_sales_amount_sign))'');
    populated_estimated_annual_sales_amount_cnt := COUNT(GROUP,h.estimated_annual_sales_amount <> (TYPEOF(h.estimated_annual_sales_amount))'');
    populated_estimated_annual_sales_amount_pcnt := AVE(GROUP,IF(h.estimated_annual_sales_amount = (TYPEOF(h.estimated_annual_sales_amount))'',0,100));
    maxlength_estimated_annual_sales_amount := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_annual_sales_amount)));
    avelength_estimated_annual_sales_amount := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_annual_sales_amount)),h.estimated_annual_sales_amount<>(typeof(h.estimated_annual_sales_amount))'');
    populated_annual_sales_size_code_cnt := COUNT(GROUP,h.annual_sales_size_code <> (TYPEOF(h.annual_sales_size_code))'');
    populated_annual_sales_size_code_pcnt := AVE(GROUP,IF(h.annual_sales_size_code = (TYPEOF(h.annual_sales_size_code))'',0,100));
    maxlength_annual_sales_size_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.annual_sales_size_code)));
    avelength_annual_sales_size_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.annual_sales_size_code)),h.annual_sales_size_code<>(typeof(h.annual_sales_size_code))'');
    populated_location_code_cnt := COUNT(GROUP,h.location_code <> (TYPEOF(h.location_code))'');
    populated_location_code_pcnt := AVE(GROUP,IF(h.location_code = (TYPEOF(h.location_code))'',0,100));
    maxlength_location_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.location_code)));
    avelength_location_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.location_code)),h.location_code<>(typeof(h.location_code))'');
    populated_primary_sic_code_industry_classification_cnt := COUNT(GROUP,h.primary_sic_code_industry_classification <> (TYPEOF(h.primary_sic_code_industry_classification))'');
    populated_primary_sic_code_industry_classification_pcnt := AVE(GROUP,IF(h.primary_sic_code_industry_classification = (TYPEOF(h.primary_sic_code_industry_classification))'',0,100));
    maxlength_primary_sic_code_industry_classification := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_industry_classification)));
    avelength_primary_sic_code_industry_classification := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_industry_classification)),h.primary_sic_code_industry_classification<>(typeof(h.primary_sic_code_industry_classification))'');
    populated_primary_sic_code_4_digit_cnt := COUNT(GROUP,h.primary_sic_code_4_digit <> (TYPEOF(h.primary_sic_code_4_digit))'');
    populated_primary_sic_code_4_digit_pcnt := AVE(GROUP,IF(h.primary_sic_code_4_digit = (TYPEOF(h.primary_sic_code_4_digit))'',0,100));
    maxlength_primary_sic_code_4_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_4_digit)));
    avelength_primary_sic_code_4_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_4_digit)),h.primary_sic_code_4_digit<>(typeof(h.primary_sic_code_4_digit))'');
    populated_primary_sic_code_cnt := COUNT(GROUP,h.primary_sic_code <> (TYPEOF(h.primary_sic_code))'');
    populated_primary_sic_code_pcnt := AVE(GROUP,IF(h.primary_sic_code = (TYPEOF(h.primary_sic_code))'',0,100));
    maxlength_primary_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code)));
    avelength_primary_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code)),h.primary_sic_code<>(typeof(h.primary_sic_code))'');
    populated_second_sic_code_cnt := COUNT(GROUP,h.second_sic_code <> (TYPEOF(h.second_sic_code))'');
    populated_second_sic_code_pcnt := AVE(GROUP,IF(h.second_sic_code = (TYPEOF(h.second_sic_code))'',0,100));
    maxlength_second_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.second_sic_code)));
    avelength_second_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.second_sic_code)),h.second_sic_code<>(typeof(h.second_sic_code))'');
    populated_third_sic_code_cnt := COUNT(GROUP,h.third_sic_code <> (TYPEOF(h.third_sic_code))'');
    populated_third_sic_code_pcnt := AVE(GROUP,IF(h.third_sic_code = (TYPEOF(h.third_sic_code))'',0,100));
    maxlength_third_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.third_sic_code)));
    avelength_third_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.third_sic_code)),h.third_sic_code<>(typeof(h.third_sic_code))'');
    populated_fourth_sic_code_cnt := COUNT(GROUP,h.fourth_sic_code <> (TYPEOF(h.fourth_sic_code))'');
    populated_fourth_sic_code_pcnt := AVE(GROUP,IF(h.fourth_sic_code = (TYPEOF(h.fourth_sic_code))'',0,100));
    maxlength_fourth_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fourth_sic_code)));
    avelength_fourth_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fourth_sic_code)),h.fourth_sic_code<>(typeof(h.fourth_sic_code))'');
    populated_fifth_sic_code_cnt := COUNT(GROUP,h.fifth_sic_code <> (TYPEOF(h.fifth_sic_code))'');
    populated_fifth_sic_code_pcnt := AVE(GROUP,IF(h.fifth_sic_code = (TYPEOF(h.fifth_sic_code))'',0,100));
    maxlength_fifth_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fifth_sic_code)));
    avelength_fifth_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fifth_sic_code)),h.fifth_sic_code<>(typeof(h.fifth_sic_code))'');
    populated_sixth_sic_code_cnt := COUNT(GROUP,h.sixth_sic_code <> (TYPEOF(h.sixth_sic_code))'');
    populated_sixth_sic_code_pcnt := AVE(GROUP,IF(h.sixth_sic_code = (TYPEOF(h.sixth_sic_code))'',0,100));
    maxlength_sixth_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sixth_sic_code)));
    avelength_sixth_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sixth_sic_code)),h.sixth_sic_code<>(typeof(h.sixth_sic_code))'');
    populated_primary_naics_code_cnt := COUNT(GROUP,h.primary_naics_code <> (TYPEOF(h.primary_naics_code))'');
    populated_primary_naics_code_pcnt := AVE(GROUP,IF(h.primary_naics_code = (TYPEOF(h.primary_naics_code))'',0,100));
    maxlength_primary_naics_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_naics_code)));
    avelength_primary_naics_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_naics_code)),h.primary_naics_code<>(typeof(h.primary_naics_code))'');
    populated_second_naics_code_cnt := COUNT(GROUP,h.second_naics_code <> (TYPEOF(h.second_naics_code))'');
    populated_second_naics_code_pcnt := AVE(GROUP,IF(h.second_naics_code = (TYPEOF(h.second_naics_code))'',0,100));
    maxlength_second_naics_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.second_naics_code)));
    avelength_second_naics_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.second_naics_code)),h.second_naics_code<>(typeof(h.second_naics_code))'');
    populated_third_naics_code_cnt := COUNT(GROUP,h.third_naics_code <> (TYPEOF(h.third_naics_code))'');
    populated_third_naics_code_pcnt := AVE(GROUP,IF(h.third_naics_code = (TYPEOF(h.third_naics_code))'',0,100));
    maxlength_third_naics_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.third_naics_code)));
    avelength_third_naics_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.third_naics_code)),h.third_naics_code<>(typeof(h.third_naics_code))'');
    populated_fourth_naics_code_cnt := COUNT(GROUP,h.fourth_naics_code <> (TYPEOF(h.fourth_naics_code))'');
    populated_fourth_naics_code_pcnt := AVE(GROUP,IF(h.fourth_naics_code = (TYPEOF(h.fourth_naics_code))'',0,100));
    maxlength_fourth_naics_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fourth_naics_code)));
    avelength_fourth_naics_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fourth_naics_code)),h.fourth_naics_code<>(typeof(h.fourth_naics_code))'');
    populated_executive_count_cnt := COUNT(GROUP,h.executive_count <> (TYPEOF(h.executive_count))'');
    populated_executive_count_pcnt := AVE(GROUP,IF(h.executive_count = (TYPEOF(h.executive_count))'',0,100));
    maxlength_executive_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_count)));
    avelength_executive_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_count)),h.executive_count<>(typeof(h.executive_count))'');
    populated_executive_last_name_cnt := COUNT(GROUP,h.executive_last_name <> (TYPEOF(h.executive_last_name))'');
    populated_executive_last_name_pcnt := AVE(GROUP,IF(h.executive_last_name = (TYPEOF(h.executive_last_name))'',0,100));
    maxlength_executive_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_last_name)));
    avelength_executive_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_last_name)),h.executive_last_name<>(typeof(h.executive_last_name))'');
    populated_executive_first_name_cnt := COUNT(GROUP,h.executive_first_name <> (TYPEOF(h.executive_first_name))'');
    populated_executive_first_name_pcnt := AVE(GROUP,IF(h.executive_first_name = (TYPEOF(h.executive_first_name))'',0,100));
    maxlength_executive_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_first_name)));
    avelength_executive_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_first_name)),h.executive_first_name<>(typeof(h.executive_first_name))'');
    populated_executive_middle_initial_cnt := COUNT(GROUP,h.executive_middle_initial <> (TYPEOF(h.executive_middle_initial))'');
    populated_executive_middle_initial_pcnt := AVE(GROUP,IF(h.executive_middle_initial = (TYPEOF(h.executive_middle_initial))'',0,100));
    maxlength_executive_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_middle_initial)));
    avelength_executive_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_middle_initial)),h.executive_middle_initial<>(typeof(h.executive_middle_initial))'');
    populated_executive_title_cnt := COUNT(GROUP,h.executive_title <> (TYPEOF(h.executive_title))'');
    populated_executive_title_pcnt := AVE(GROUP,IF(h.executive_title = (TYPEOF(h.executive_title))'',0,100));
    maxlength_executive_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_title)));
    avelength_executive_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.executive_title)),h.executive_title<>(typeof(h.executive_title))'');
    populated_business_type_cnt := COUNT(GROUP,h.business_type <> (TYPEOF(h.business_type))'');
    populated_business_type_pcnt := AVE(GROUP,IF(h.business_type = (TYPEOF(h.business_type))'',0,100));
    maxlength_business_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_type)));
    avelength_business_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_type)),h.business_type<>(typeof(h.business_type))'');
    populated_ownership_code_cnt := COUNT(GROUP,h.ownership_code <> (TYPEOF(h.ownership_code))'');
    populated_ownership_code_pcnt := AVE(GROUP,IF(h.ownership_code = (TYPEOF(h.ownership_code))'',0,100));
    maxlength_ownership_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code)));
    avelength_ownership_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code)),h.ownership_code<>(typeof(h.ownership_code))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_derogatory_indicator_cnt := COUNT(GROUP,h.derogatory_indicator <> (TYPEOF(h.derogatory_indicator))'');
    populated_derogatory_indicator_pcnt := AVE(GROUP,IF(h.derogatory_indicator = (TYPEOF(h.derogatory_indicator))'',0,100));
    maxlength_derogatory_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_indicator)));
    avelength_derogatory_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_indicator)),h.derogatory_indicator<>(typeof(h.derogatory_indicator))'');
    populated_recent_derogatory_filed_date_cnt := COUNT(GROUP,h.recent_derogatory_filed_date <> (TYPEOF(h.recent_derogatory_filed_date))'');
    populated_recent_derogatory_filed_date_pcnt := AVE(GROUP,IF(h.recent_derogatory_filed_date = (TYPEOF(h.recent_derogatory_filed_date))'',0,100));
    maxlength_recent_derogatory_filed_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_derogatory_filed_date)));
    avelength_recent_derogatory_filed_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_derogatory_filed_date)),h.recent_derogatory_filed_date<>(typeof(h.recent_derogatory_filed_date))'');
    populated_derogatory_liability_amount_sign_cnt := COUNT(GROUP,h.derogatory_liability_amount_sign <> (TYPEOF(h.derogatory_liability_amount_sign))'');
    populated_derogatory_liability_amount_sign_pcnt := AVE(GROUP,IF(h.derogatory_liability_amount_sign = (TYPEOF(h.derogatory_liability_amount_sign))'',0,100));
    maxlength_derogatory_liability_amount_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_liability_amount_sign)));
    avelength_derogatory_liability_amount_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_liability_amount_sign)),h.derogatory_liability_amount_sign<>(typeof(h.derogatory_liability_amount_sign))'');
    populated_derogatory_liability_amount_cnt := COUNT(GROUP,h.derogatory_liability_amount <> (TYPEOF(h.derogatory_liability_amount))'');
    populated_derogatory_liability_amount_pcnt := AVE(GROUP,IF(h.derogatory_liability_amount = (TYPEOF(h.derogatory_liability_amount))'',0,100));
    maxlength_derogatory_liability_amount := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_liability_amount)));
    avelength_derogatory_liability_amount := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.derogatory_liability_amount)),h.derogatory_liability_amount<>(typeof(h.derogatory_liability_amount))'');
    populated_ucc_data_indicator_cnt := COUNT(GROUP,h.ucc_data_indicator <> (TYPEOF(h.ucc_data_indicator))'');
    populated_ucc_data_indicator_pcnt := AVE(GROUP,IF(h.ucc_data_indicator = (TYPEOF(h.ucc_data_indicator))'',0,100));
    maxlength_ucc_data_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_data_indicator)));
    avelength_ucc_data_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_data_indicator)),h.ucc_data_indicator<>(typeof(h.ucc_data_indicator))'');
    populated_ucc_count_cnt := COUNT(GROUP,h.ucc_count <> (TYPEOF(h.ucc_count))'');
    populated_ucc_count_pcnt := AVE(GROUP,IF(h.ucc_count = (TYPEOF(h.ucc_count))'',0,100));
    maxlength_ucc_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_count)));
    avelength_ucc_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_count)),h.ucc_count<>(typeof(h.ucc_count))'');
    populated_number_of_legal_items_cnt := COUNT(GROUP,h.number_of_legal_items <> (TYPEOF(h.number_of_legal_items))'');
    populated_number_of_legal_items_pcnt := AVE(GROUP,IF(h.number_of_legal_items = (TYPEOF(h.number_of_legal_items))'',0,100));
    maxlength_number_of_legal_items := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.number_of_legal_items)));
    avelength_number_of_legal_items := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.number_of_legal_items)),h.number_of_legal_items<>(typeof(h.number_of_legal_items))'');
    populated_legal_balance_sign_cnt := COUNT(GROUP,h.legal_balance_sign <> (TYPEOF(h.legal_balance_sign))'');
    populated_legal_balance_sign_pcnt := AVE(GROUP,IF(h.legal_balance_sign = (TYPEOF(h.legal_balance_sign))'',0,100));
    maxlength_legal_balance_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.legal_balance_sign)));
    avelength_legal_balance_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.legal_balance_sign)),h.legal_balance_sign<>(typeof(h.legal_balance_sign))'');
    populated_legal_balance_amount_cnt := COUNT(GROUP,h.legal_balance_amount <> (TYPEOF(h.legal_balance_amount))'');
    populated_legal_balance_amount_pcnt := AVE(GROUP,IF(h.legal_balance_amount = (TYPEOF(h.legal_balance_amount))'',0,100));
    maxlength_legal_balance_amount := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.legal_balance_amount)));
    avelength_legal_balance_amount := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.legal_balance_amount)),h.legal_balance_amount<>(typeof(h.legal_balance_amount))'');
    populated_pmtkbankruptcy_cnt := COUNT(GROUP,h.pmtkbankruptcy <> (TYPEOF(h.pmtkbankruptcy))'');
    populated_pmtkbankruptcy_pcnt := AVE(GROUP,IF(h.pmtkbankruptcy = (TYPEOF(h.pmtkbankruptcy))'',0,100));
    maxlength_pmtkbankruptcy := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkbankruptcy)));
    avelength_pmtkbankruptcy := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkbankruptcy)),h.pmtkbankruptcy<>(typeof(h.pmtkbankruptcy))'');
    populated_pmtkjudgment_cnt := COUNT(GROUP,h.pmtkjudgment <> (TYPEOF(h.pmtkjudgment))'');
    populated_pmtkjudgment_pcnt := AVE(GROUP,IF(h.pmtkjudgment = (TYPEOF(h.pmtkjudgment))'',0,100));
    maxlength_pmtkjudgment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkjudgment)));
    avelength_pmtkjudgment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkjudgment)),h.pmtkjudgment<>(typeof(h.pmtkjudgment))'');
    populated_pmtktaxlien_cnt := COUNT(GROUP,h.pmtktaxlien <> (TYPEOF(h.pmtktaxlien))'');
    populated_pmtktaxlien_pcnt := AVE(GROUP,IF(h.pmtktaxlien = (TYPEOF(h.pmtktaxlien))'',0,100));
    maxlength_pmtktaxlien := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtktaxlien)));
    avelength_pmtktaxlien := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtktaxlien)),h.pmtktaxlien<>(typeof(h.pmtktaxlien))'');
    populated_pmtkpayment_cnt := COUNT(GROUP,h.pmtkpayment <> (TYPEOF(h.pmtkpayment))'');
    populated_pmtkpayment_pcnt := AVE(GROUP,IF(h.pmtkpayment = (TYPEOF(h.pmtkpayment))'',0,100));
    maxlength_pmtkpayment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkpayment)));
    avelength_pmtkpayment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pmtkpayment)),h.pmtkpayment<>(typeof(h.pmtkpayment))'');
    populated_bankruptcy_filed_cnt := COUNT(GROUP,h.bankruptcy_filed <> (TYPEOF(h.bankruptcy_filed))'');
    populated_bankruptcy_filed_pcnt := AVE(GROUP,IF(h.bankruptcy_filed = (TYPEOF(h.bankruptcy_filed))'',0,100));
    maxlength_bankruptcy_filed := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bankruptcy_filed)));
    avelength_bankruptcy_filed := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bankruptcy_filed)),h.bankruptcy_filed<>(typeof(h.bankruptcy_filed))'');
    populated_number_of_derogatory_legal_items_cnt := COUNT(GROUP,h.number_of_derogatory_legal_items <> (TYPEOF(h.number_of_derogatory_legal_items))'');
    populated_number_of_derogatory_legal_items_pcnt := AVE(GROUP,IF(h.number_of_derogatory_legal_items = (TYPEOF(h.number_of_derogatory_legal_items))'',0,100));
    maxlength_number_of_derogatory_legal_items := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.number_of_derogatory_legal_items)));
    avelength_number_of_derogatory_legal_items := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.number_of_derogatory_legal_items)),h.number_of_derogatory_legal_items<>(typeof(h.number_of_derogatory_legal_items))'');
    populated_lien_count_cnt := COUNT(GROUP,h.lien_count <> (TYPEOF(h.lien_count))'');
    populated_lien_count_pcnt := AVE(GROUP,IF(h.lien_count = (TYPEOF(h.lien_count))'',0,100));
    maxlength_lien_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lien_count)));
    avelength_lien_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lien_count)),h.lien_count<>(typeof(h.lien_count))'');
    populated_judgment_count_cnt := COUNT(GROUP,h.judgment_count <> (TYPEOF(h.judgment_count))'');
    populated_judgment_count_pcnt := AVE(GROUP,IF(h.judgment_count = (TYPEOF(h.judgment_count))'',0,100));
    maxlength_judgment_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.judgment_count)));
    avelength_judgment_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.judgment_count)),h.judgment_count<>(typeof(h.judgment_count))'');
    populated_bkc006_cnt := COUNT(GROUP,h.bkc006 <> (TYPEOF(h.bkc006))'');
    populated_bkc006_pcnt := AVE(GROUP,IF(h.bkc006 = (TYPEOF(h.bkc006))'',0,100));
    maxlength_bkc006 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc006)));
    avelength_bkc006 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc006)),h.bkc006<>(typeof(h.bkc006))'');
    populated_bkc007_cnt := COUNT(GROUP,h.bkc007 <> (TYPEOF(h.bkc007))'');
    populated_bkc007_pcnt := AVE(GROUP,IF(h.bkc007 = (TYPEOF(h.bkc007))'',0,100));
    maxlength_bkc007 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc007)));
    avelength_bkc007 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc007)),h.bkc007<>(typeof(h.bkc007))'');
    populated_bkc008_cnt := COUNT(GROUP,h.bkc008 <> (TYPEOF(h.bkc008))'');
    populated_bkc008_pcnt := AVE(GROUP,IF(h.bkc008 = (TYPEOF(h.bkc008))'',0,100));
    maxlength_bkc008 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc008)));
    avelength_bkc008 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkc008)),h.bkc008<>(typeof(h.bkc008))'');
    populated_bko009_cnt := COUNT(GROUP,h.bko009 <> (TYPEOF(h.bko009))'');
    populated_bko009_pcnt := AVE(GROUP,IF(h.bko009 = (TYPEOF(h.bko009))'',0,100));
    maxlength_bko009 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko009)));
    avelength_bko009 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko009)),h.bko009<>(typeof(h.bko009))'');
    populated_bkb001_sign_cnt := COUNT(GROUP,h.bkb001_sign <> (TYPEOF(h.bkb001_sign))'');
    populated_bkb001_sign_pcnt := AVE(GROUP,IF(h.bkb001_sign = (TYPEOF(h.bkb001_sign))'',0,100));
    maxlength_bkb001_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb001_sign)));
    avelength_bkb001_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb001_sign)),h.bkb001_sign<>(typeof(h.bkb001_sign))'');
    populated_bkb001_cnt := COUNT(GROUP,h.bkb001 <> (TYPEOF(h.bkb001))'');
    populated_bkb001_pcnt := AVE(GROUP,IF(h.bkb001 = (TYPEOF(h.bkb001))'',0,100));
    maxlength_bkb001 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb001)));
    avelength_bkb001 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb001)),h.bkb001<>(typeof(h.bkb001))'');
    populated_bkb003_sign_cnt := COUNT(GROUP,h.bkb003_sign <> (TYPEOF(h.bkb003_sign))'');
    populated_bkb003_sign_pcnt := AVE(GROUP,IF(h.bkb003_sign = (TYPEOF(h.bkb003_sign))'',0,100));
    maxlength_bkb003_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb003_sign)));
    avelength_bkb003_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb003_sign)),h.bkb003_sign<>(typeof(h.bkb003_sign))'');
    populated_bkb003_cnt := COUNT(GROUP,h.bkb003 <> (TYPEOF(h.bkb003))'');
    populated_bkb003_pcnt := AVE(GROUP,IF(h.bkb003 = (TYPEOF(h.bkb003))'',0,100));
    maxlength_bkb003 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb003)));
    avelength_bkb003 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bkb003)),h.bkb003<>(typeof(h.bkb003))'');
    populated_bko010_cnt := COUNT(GROUP,h.bko010 <> (TYPEOF(h.bko010))'');
    populated_bko010_pcnt := AVE(GROUP,IF(h.bko010 = (TYPEOF(h.bko010))'',0,100));
    maxlength_bko010 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko010)));
    avelength_bko010 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko010)),h.bko010<>(typeof(h.bko010))'');
    populated_bko011_cnt := COUNT(GROUP,h.bko011 <> (TYPEOF(h.bko011))'');
    populated_bko011_pcnt := AVE(GROUP,IF(h.bko011 = (TYPEOF(h.bko011))'',0,100));
    maxlength_bko011 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko011)));
    avelength_bko011 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bko011)),h.bko011<>(typeof(h.bko011))'');
    populated_jdc010_cnt := COUNT(GROUP,h.jdc010 <> (TYPEOF(h.jdc010))'');
    populated_jdc010_pcnt := AVE(GROUP,IF(h.jdc010 = (TYPEOF(h.jdc010))'',0,100));
    maxlength_jdc010 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc010)));
    avelength_jdc010 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc010)),h.jdc010<>(typeof(h.jdc010))'');
    populated_jdc011_cnt := COUNT(GROUP,h.jdc011 <> (TYPEOF(h.jdc011))'');
    populated_jdc011_pcnt := AVE(GROUP,IF(h.jdc011 = (TYPEOF(h.jdc011))'',0,100));
    maxlength_jdc011 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc011)));
    avelength_jdc011 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc011)),h.jdc011<>(typeof(h.jdc011))'');
    populated_jdc012_cnt := COUNT(GROUP,h.jdc012 <> (TYPEOF(h.jdc012))'');
    populated_jdc012_pcnt := AVE(GROUP,IF(h.jdc012 = (TYPEOF(h.jdc012))'',0,100));
    maxlength_jdc012 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc012)));
    avelength_jdc012 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdc012)),h.jdc012<>(typeof(h.jdc012))'');
    populated_jdb004_cnt := COUNT(GROUP,h.jdb004 <> (TYPEOF(h.jdb004))'');
    populated_jdb004_pcnt := AVE(GROUP,IF(h.jdb004 = (TYPEOF(h.jdb004))'',0,100));
    maxlength_jdb004 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb004)));
    avelength_jdb004 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb004)),h.jdb004<>(typeof(h.jdb004))'');
    populated_jdb005_cnt := COUNT(GROUP,h.jdb005 <> (TYPEOF(h.jdb005))'');
    populated_jdb005_pcnt := AVE(GROUP,IF(h.jdb005 = (TYPEOF(h.jdb005))'',0,100));
    maxlength_jdb005 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb005)));
    avelength_jdb005 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb005)),h.jdb005<>(typeof(h.jdb005))'');
    populated_jdb006_cnt := COUNT(GROUP,h.jdb006 <> (TYPEOF(h.jdb006))'');
    populated_jdb006_pcnt := AVE(GROUP,IF(h.jdb006 = (TYPEOF(h.jdb006))'',0,100));
    maxlength_jdb006 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb006)));
    avelength_jdb006 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb006)),h.jdb006<>(typeof(h.jdb006))'');
    populated_jDO013_cnt := COUNT(GROUP,h.jDO013 <> (TYPEOF(h.jDO013))'');
    populated_jDO013_pcnt := AVE(GROUP,IF(h.jDO013 = (TYPEOF(h.jDO013))'',0,100));
    maxlength_jDO013 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jDO013)));
    avelength_jDO013 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jDO013)),h.jDO013<>(typeof(h.jDO013))'');
    populated_jDO014_cnt := COUNT(GROUP,h.jDO014 <> (TYPEOF(h.jDO014))'');
    populated_jDO014_pcnt := AVE(GROUP,IF(h.jDO014 = (TYPEOF(h.jDO014))'',0,100));
    maxlength_jDO014 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jDO014)));
    avelength_jDO014 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jDO014)),h.jDO014<>(typeof(h.jDO014))'');
    populated_jdb002_cnt := COUNT(GROUP,h.jdb002 <> (TYPEOF(h.jdb002))'');
    populated_jdb002_pcnt := AVE(GROUP,IF(h.jdb002 = (TYPEOF(h.jdb002))'',0,100));
    maxlength_jdb002 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb002)));
    avelength_jdb002 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdb002)),h.jdb002<>(typeof(h.jdb002))'');
    populated_jdp016_cnt := COUNT(GROUP,h.jdp016 <> (TYPEOF(h.jdp016))'');
    populated_jdp016_pcnt := AVE(GROUP,IF(h.jdp016 = (TYPEOF(h.jdp016))'',0,100));
    maxlength_jdp016 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdp016)));
    avelength_jdp016 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jdp016)),h.jdp016<>(typeof(h.jdp016))'');
    populated_lgc004_cnt := COUNT(GROUP,h.lgc004 <> (TYPEOF(h.lgc004))'');
    populated_lgc004_pcnt := AVE(GROUP,IF(h.lgc004 = (TYPEOF(h.lgc004))'',0,100));
    maxlength_lgc004 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lgc004)));
    avelength_lgc004 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lgc004)),h.lgc004<>(typeof(h.lgc004))'');
    populated_pro001_cnt := COUNT(GROUP,h.pro001 <> (TYPEOF(h.pro001))'');
    populated_pro001_pcnt := AVE(GROUP,IF(h.pro001 = (TYPEOF(h.pro001))'',0,100));
    maxlength_pro001 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pro001)));
    avelength_pro001 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pro001)),h.pro001<>(typeof(h.pro001))'');
    populated_pro003_cnt := COUNT(GROUP,h.pro003 <> (TYPEOF(h.pro003))'');
    populated_pro003_pcnt := AVE(GROUP,IF(h.pro003 = (TYPEOF(h.pro003))'',0,100));
    maxlength_pro003 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pro003)));
    avelength_pro003 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pro003)),h.pro003<>(typeof(h.pro003))'');
    populated_txc010_cnt := COUNT(GROUP,h.txc010 <> (TYPEOF(h.txc010))'');
    populated_txc010_pcnt := AVE(GROUP,IF(h.txc010 = (TYPEOF(h.txc010))'',0,100));
    maxlength_txc010 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txc010)));
    avelength_txc010 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txc010)),h.txc010<>(typeof(h.txc010))'');
    populated_txc011_cnt := COUNT(GROUP,h.txc011 <> (TYPEOF(h.txc011))'');
    populated_txc011_pcnt := AVE(GROUP,IF(h.txc011 = (TYPEOF(h.txc011))'',0,100));
    maxlength_txc011 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txc011)));
    avelength_txc011 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txc011)),h.txc011<>(typeof(h.txc011))'');
    populated_txb004_sign_cnt := COUNT(GROUP,h.txb004_sign <> (TYPEOF(h.txb004_sign))'');
    populated_txb004_sign_pcnt := AVE(GROUP,IF(h.txb004_sign = (TYPEOF(h.txb004_sign))'',0,100));
    maxlength_txb004_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb004_sign)));
    avelength_txb004_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb004_sign)),h.txb004_sign<>(typeof(h.txb004_sign))'');
    populated_txb004_cnt := COUNT(GROUP,h.txb004 <> (TYPEOF(h.txb004))'');
    populated_txb004_pcnt := AVE(GROUP,IF(h.txb004 = (TYPEOF(h.txb004))'',0,100));
    maxlength_txb004 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb004)));
    avelength_txb004 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb004)),h.txb004<>(typeof(h.txb004))'');
    populated_txo013_cnt := COUNT(GROUP,h.txo013 <> (TYPEOF(h.txo013))'');
    populated_txo013_pcnt := AVE(GROUP,IF(h.txo013 = (TYPEOF(h.txo013))'',0,100));
    maxlength_txo013 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txo013)));
    avelength_txo013 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txo013)),h.txo013<>(typeof(h.txo013))'');
    populated_txb002_sign_cnt := COUNT(GROUP,h.txb002_sign <> (TYPEOF(h.txb002_sign))'');
    populated_txb002_sign_pcnt := AVE(GROUP,IF(h.txb002_sign = (TYPEOF(h.txb002_sign))'',0,100));
    maxlength_txb002_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb002_sign)));
    avelength_txb002_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb002_sign)),h.txb002_sign<>(typeof(h.txb002_sign))'');
    populated_txb002_cnt := COUNT(GROUP,h.txb002 <> (TYPEOF(h.txb002))'');
    populated_txb002_pcnt := AVE(GROUP,IF(h.txb002 = (TYPEOF(h.txb002))'',0,100));
    maxlength_txb002 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb002)));
    avelength_txb002 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txb002)),h.txb002<>(typeof(h.txb002))'');
    populated_txp016_cnt := COUNT(GROUP,h.txp016 <> (TYPEOF(h.txp016))'');
    populated_txp016_pcnt := AVE(GROUP,IF(h.txp016 = (TYPEOF(h.txp016))'',0,100));
    maxlength_txp016 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.txp016)));
    avelength_txp016 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.txp016)),h.txp016<>(typeof(h.txp016))'');
    populated_ucc001_cnt := COUNT(GROUP,h.ucc001 <> (TYPEOF(h.ucc001))'');
    populated_ucc001_pcnt := AVE(GROUP,IF(h.ucc001 = (TYPEOF(h.ucc001))'',0,100));
    maxlength_ucc001 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc001)));
    avelength_ucc001 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc001)),h.ucc001<>(typeof(h.ucc001))'');
    populated_ucc002_cnt := COUNT(GROUP,h.ucc002 <> (TYPEOF(h.ucc002))'');
    populated_ucc002_pcnt := AVE(GROUP,IF(h.ucc002 = (TYPEOF(h.ucc002))'',0,100));
    maxlength_ucc002 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc002)));
    avelength_ucc002 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc002)),h.ucc002<>(typeof(h.ucc002))'');
    populated_ucc003_cnt := COUNT(GROUP,h.ucc003 <> (TYPEOF(h.ucc003))'');
    populated_ucc003_pcnt := AVE(GROUP,IF(h.ucc003 = (TYPEOF(h.ucc003))'',0,100));
    maxlength_ucc003 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc003)));
    avelength_ucc003 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc003)),h.ucc003<>(typeof(h.ucc003))'');
    populated_intelliscore_plus_cnt := COUNT(GROUP,h.intelliscore_plus <> (TYPEOF(h.intelliscore_plus))'');
    populated_intelliscore_plus_pcnt := AVE(GROUP,IF(h.intelliscore_plus = (TYPEOF(h.intelliscore_plus))'',0,100));
    maxlength_intelliscore_plus := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.intelliscore_plus)));
    avelength_intelliscore_plus := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.intelliscore_plus)),h.intelliscore_plus<>(typeof(h.intelliscore_plus))'');
    populated_percentile_model_cnt := COUNT(GROUP,h.percentile_model <> (TYPEOF(h.percentile_model))'');
    populated_percentile_model_pcnt := AVE(GROUP,IF(h.percentile_model = (TYPEOF(h.percentile_model))'',0,100));
    maxlength_percentile_model := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.percentile_model)));
    avelength_percentile_model := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.percentile_model)),h.percentile_model<>(typeof(h.percentile_model))'');
    populated_model_action_cnt := COUNT(GROUP,h.model_action <> (TYPEOF(h.model_action))'');
    populated_model_action_pcnt := AVE(GROUP,IF(h.model_action = (TYPEOF(h.model_action))'',0,100));
    maxlength_model_action := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_action)));
    avelength_model_action := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_action)),h.model_action<>(typeof(h.model_action))'');
    populated_score_factor_1_cnt := COUNT(GROUP,h.score_factor_1 <> (TYPEOF(h.score_factor_1))'');
    populated_score_factor_1_pcnt := AVE(GROUP,IF(h.score_factor_1 = (TYPEOF(h.score_factor_1))'',0,100));
    maxlength_score_factor_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_1)));
    avelength_score_factor_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_1)),h.score_factor_1<>(typeof(h.score_factor_1))'');
    populated_score_factor_2_cnt := COUNT(GROUP,h.score_factor_2 <> (TYPEOF(h.score_factor_2))'');
    populated_score_factor_2_pcnt := AVE(GROUP,IF(h.score_factor_2 = (TYPEOF(h.score_factor_2))'',0,100));
    maxlength_score_factor_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_2)));
    avelength_score_factor_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_2)),h.score_factor_2<>(typeof(h.score_factor_2))'');
    populated_score_factor_3_cnt := COUNT(GROUP,h.score_factor_3 <> (TYPEOF(h.score_factor_3))'');
    populated_score_factor_3_pcnt := AVE(GROUP,IF(h.score_factor_3 = (TYPEOF(h.score_factor_3))'',0,100));
    maxlength_score_factor_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_3)));
    avelength_score_factor_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_3)),h.score_factor_3<>(typeof(h.score_factor_3))'');
    populated_score_factor_4_cnt := COUNT(GROUP,h.score_factor_4 <> (TYPEOF(h.score_factor_4))'');
    populated_score_factor_4_pcnt := AVE(GROUP,IF(h.score_factor_4 = (TYPEOF(h.score_factor_4))'',0,100));
    maxlength_score_factor_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_4)));
    avelength_score_factor_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.score_factor_4)),h.score_factor_4<>(typeof(h.score_factor_4))'');
    populated_model_code_cnt := COUNT(GROUP,h.model_code <> (TYPEOF(h.model_code))'');
    populated_model_code_pcnt := AVE(GROUP,IF(h.model_code = (TYPEOF(h.model_code))'',0,100));
    maxlength_model_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_code)));
    avelength_model_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_code)),h.model_code<>(typeof(h.model_code))'');
    populated_model_type_cnt := COUNT(GROUP,h.model_type <> (TYPEOF(h.model_type))'');
    populated_model_type_pcnt := AVE(GROUP,IF(h.model_type = (TYPEOF(h.model_type))'',0,100));
    maxlength_model_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_type)));
    avelength_model_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_type)),h.model_type<>(typeof(h.model_type))'');
    populated_last_experian_inquiry_date_cnt := COUNT(GROUP,h.last_experian_inquiry_date <> (TYPEOF(h.last_experian_inquiry_date))'');
    populated_last_experian_inquiry_date_pcnt := AVE(GROUP,IF(h.last_experian_inquiry_date = (TYPEOF(h.last_experian_inquiry_date))'',0,100));
    maxlength_last_experian_inquiry_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_experian_inquiry_date)));
    avelength_last_experian_inquiry_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_experian_inquiry_date)),h.last_experian_inquiry_date<>(typeof(h.last_experian_inquiry_date))'');
    populated_recent_high_credit_sign_cnt := COUNT(GROUP,h.recent_high_credit_sign <> (TYPEOF(h.recent_high_credit_sign))'');
    populated_recent_high_credit_sign_pcnt := AVE(GROUP,IF(h.recent_high_credit_sign = (TYPEOF(h.recent_high_credit_sign))'',0,100));
    maxlength_recent_high_credit_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_high_credit_sign)));
    avelength_recent_high_credit_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_high_credit_sign)),h.recent_high_credit_sign<>(typeof(h.recent_high_credit_sign))'');
    populated_recent_high_credit_cnt := COUNT(GROUP,h.recent_high_credit <> (TYPEOF(h.recent_high_credit))'');
    populated_recent_high_credit_pcnt := AVE(GROUP,IF(h.recent_high_credit = (TYPEOF(h.recent_high_credit))'',0,100));
    maxlength_recent_high_credit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_high_credit)));
    avelength_recent_high_credit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_high_credit)),h.recent_high_credit<>(typeof(h.recent_high_credit))'');
    populated_median_credit_amount_sign_cnt := COUNT(GROUP,h.median_credit_amount_sign <> (TYPEOF(h.median_credit_amount_sign))'');
    populated_median_credit_amount_sign_pcnt := AVE(GROUP,IF(h.median_credit_amount_sign = (TYPEOF(h.median_credit_amount_sign))'',0,100));
    maxlength_median_credit_amount_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_credit_amount_sign)));
    avelength_median_credit_amount_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_credit_amount_sign)),h.median_credit_amount_sign<>(typeof(h.median_credit_amount_sign))'');
    populated_median_credit_amount_cnt := COUNT(GROUP,h.median_credit_amount <> (TYPEOF(h.median_credit_amount))'');
    populated_median_credit_amount_pcnt := AVE(GROUP,IF(h.median_credit_amount = (TYPEOF(h.median_credit_amount))'',0,100));
    maxlength_median_credit_amount := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_credit_amount)));
    avelength_median_credit_amount := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_credit_amount)),h.median_credit_amount<>(typeof(h.median_credit_amount))'');
    populated_total_combined_trade_lines_count_cnt := COUNT(GROUP,h.total_combined_trade_lines_count <> (TYPEOF(h.total_combined_trade_lines_count))'');
    populated_total_combined_trade_lines_count_pcnt := AVE(GROUP,IF(h.total_combined_trade_lines_count = (TYPEOF(h.total_combined_trade_lines_count))'',0,100));
    maxlength_total_combined_trade_lines_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_combined_trade_lines_count)));
    avelength_total_combined_trade_lines_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_combined_trade_lines_count)),h.total_combined_trade_lines_count<>(typeof(h.total_combined_trade_lines_count))'');
    populated_dbt_of_combined_trade_totals_cnt := COUNT(GROUP,h.dbt_of_combined_trade_totals <> (TYPEOF(h.dbt_of_combined_trade_totals))'');
    populated_dbt_of_combined_trade_totals_pcnt := AVE(GROUP,IF(h.dbt_of_combined_trade_totals = (TYPEOF(h.dbt_of_combined_trade_totals))'',0,100));
    maxlength_dbt_of_combined_trade_totals := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbt_of_combined_trade_totals)));
    avelength_dbt_of_combined_trade_totals := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbt_of_combined_trade_totals)),h.dbt_of_combined_trade_totals<>(typeof(h.dbt_of_combined_trade_totals))'');
    populated_combined_trade_balance_cnt := COUNT(GROUP,h.combined_trade_balance <> (TYPEOF(h.combined_trade_balance))'');
    populated_combined_trade_balance_pcnt := AVE(GROUP,IF(h.combined_trade_balance = (TYPEOF(h.combined_trade_balance))'',0,100));
    maxlength_combined_trade_balance := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_trade_balance)));
    avelength_combined_trade_balance := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_trade_balance)),h.combined_trade_balance<>(typeof(h.combined_trade_balance))'');
    populated_aged_trade_lines_cnt := COUNT(GROUP,h.aged_trade_lines <> (TYPEOF(h.aged_trade_lines))'');
    populated_aged_trade_lines_pcnt := AVE(GROUP,IF(h.aged_trade_lines = (TYPEOF(h.aged_trade_lines))'',0,100));
    maxlength_aged_trade_lines := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.aged_trade_lines)));
    avelength_aged_trade_lines := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.aged_trade_lines)),h.aged_trade_lines<>(typeof(h.aged_trade_lines))'');
    populated_experian_credit_rating_cnt := COUNT(GROUP,h.experian_credit_rating <> (TYPEOF(h.experian_credit_rating))'');
    populated_experian_credit_rating_pcnt := AVE(GROUP,IF(h.experian_credit_rating = (TYPEOF(h.experian_credit_rating))'',0,100));
    maxlength_experian_credit_rating := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_credit_rating)));
    avelength_experian_credit_rating := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_credit_rating)),h.experian_credit_rating<>(typeof(h.experian_credit_rating))'');
    populated_quarter_1_average_dbt_cnt := COUNT(GROUP,h.quarter_1_average_dbt <> (TYPEOF(h.quarter_1_average_dbt))'');
    populated_quarter_1_average_dbt_pcnt := AVE(GROUP,IF(h.quarter_1_average_dbt = (TYPEOF(h.quarter_1_average_dbt))'',0,100));
    maxlength_quarter_1_average_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_1_average_dbt)));
    avelength_quarter_1_average_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_1_average_dbt)),h.quarter_1_average_dbt<>(typeof(h.quarter_1_average_dbt))'');
    populated_quarter_2_average_dbt_cnt := COUNT(GROUP,h.quarter_2_average_dbt <> (TYPEOF(h.quarter_2_average_dbt))'');
    populated_quarter_2_average_dbt_pcnt := AVE(GROUP,IF(h.quarter_2_average_dbt = (TYPEOF(h.quarter_2_average_dbt))'',0,100));
    maxlength_quarter_2_average_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_2_average_dbt)));
    avelength_quarter_2_average_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_2_average_dbt)),h.quarter_2_average_dbt<>(typeof(h.quarter_2_average_dbt))'');
    populated_quarter_3_average_dbt_cnt := COUNT(GROUP,h.quarter_3_average_dbt <> (TYPEOF(h.quarter_3_average_dbt))'');
    populated_quarter_3_average_dbt_pcnt := AVE(GROUP,IF(h.quarter_3_average_dbt = (TYPEOF(h.quarter_3_average_dbt))'',0,100));
    maxlength_quarter_3_average_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_3_average_dbt)));
    avelength_quarter_3_average_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_3_average_dbt)),h.quarter_3_average_dbt<>(typeof(h.quarter_3_average_dbt))'');
    populated_quarter_4_average_dbt_cnt := COUNT(GROUP,h.quarter_4_average_dbt <> (TYPEOF(h.quarter_4_average_dbt))'');
    populated_quarter_4_average_dbt_pcnt := AVE(GROUP,IF(h.quarter_4_average_dbt = (TYPEOF(h.quarter_4_average_dbt))'',0,100));
    maxlength_quarter_4_average_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_4_average_dbt)));
    avelength_quarter_4_average_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_4_average_dbt)),h.quarter_4_average_dbt<>(typeof(h.quarter_4_average_dbt))'');
    populated_quarter_5_average_dbt_cnt := COUNT(GROUP,h.quarter_5_average_dbt <> (TYPEOF(h.quarter_5_average_dbt))'');
    populated_quarter_5_average_dbt_pcnt := AVE(GROUP,IF(h.quarter_5_average_dbt = (TYPEOF(h.quarter_5_average_dbt))'',0,100));
    maxlength_quarter_5_average_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_5_average_dbt)));
    avelength_quarter_5_average_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.quarter_5_average_dbt)),h.quarter_5_average_dbt<>(typeof(h.quarter_5_average_dbt))'');
    populated_combined_dbt_cnt := COUNT(GROUP,h.combined_dbt <> (TYPEOF(h.combined_dbt))'');
    populated_combined_dbt_pcnt := AVE(GROUP,IF(h.combined_dbt = (TYPEOF(h.combined_dbt))'',0,100));
    maxlength_combined_dbt := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_dbt)));
    avelength_combined_dbt := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_dbt)),h.combined_dbt<>(typeof(h.combined_dbt))'');
    populated_total_account_balance_sign_cnt := COUNT(GROUP,h.total_account_balance_sign <> (TYPEOF(h.total_account_balance_sign))'');
    populated_total_account_balance_sign_pcnt := AVE(GROUP,IF(h.total_account_balance_sign = (TYPEOF(h.total_account_balance_sign))'',0,100));
    maxlength_total_account_balance_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_account_balance_sign)));
    avelength_total_account_balance_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_account_balance_sign)),h.total_account_balance_sign<>(typeof(h.total_account_balance_sign))'');
    populated_total_account_balance_cnt := COUNT(GROUP,h.total_account_balance <> (TYPEOF(h.total_account_balance))'');
    populated_total_account_balance_pcnt := AVE(GROUP,IF(h.total_account_balance = (TYPEOF(h.total_account_balance))'',0,100));
    maxlength_total_account_balance := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_account_balance)));
    avelength_total_account_balance := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.total_account_balance)),h.total_account_balance<>(typeof(h.total_account_balance))'');
    populated_combined_account_balance_sign_cnt := COUNT(GROUP,h.combined_account_balance_sign <> (TYPEOF(h.combined_account_balance_sign))'');
    populated_combined_account_balance_sign_pcnt := AVE(GROUP,IF(h.combined_account_balance_sign = (TYPEOF(h.combined_account_balance_sign))'',0,100));
    maxlength_combined_account_balance_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_account_balance_sign)));
    avelength_combined_account_balance_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_account_balance_sign)),h.combined_account_balance_sign<>(typeof(h.combined_account_balance_sign))'');
    populated_combined_account_balance_cnt := COUNT(GROUP,h.combined_account_balance <> (TYPEOF(h.combined_account_balance))'');
    populated_combined_account_balance_pcnt := AVE(GROUP,IF(h.combined_account_balance = (TYPEOF(h.combined_account_balance))'',0,100));
    maxlength_combined_account_balance := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_account_balance)));
    avelength_combined_account_balance := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.combined_account_balance)),h.combined_account_balance<>(typeof(h.combined_account_balance))'');
    populated_collection_count_cnt := COUNT(GROUP,h.collection_count <> (TYPEOF(h.collection_count))'');
    populated_collection_count_pcnt := AVE(GROUP,IF(h.collection_count = (TYPEOF(h.collection_count))'',0,100));
    maxlength_collection_count := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.collection_count)));
    avelength_collection_count := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.collection_count)),h.collection_count<>(typeof(h.collection_count))'');
    populated_atc021_cnt := COUNT(GROUP,h.atc021 <> (TYPEOF(h.atc021))'');
    populated_atc021_pcnt := AVE(GROUP,IF(h.atc021 = (TYPEOF(h.atc021))'',0,100));
    maxlength_atc021 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc021)));
    avelength_atc021 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc021)),h.atc021<>(typeof(h.atc021))'');
    populated_atc022_cnt := COUNT(GROUP,h.atc022 <> (TYPEOF(h.atc022))'');
    populated_atc022_pcnt := AVE(GROUP,IF(h.atc022 = (TYPEOF(h.atc022))'',0,100));
    maxlength_atc022 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc022)));
    avelength_atc022 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc022)),h.atc022<>(typeof(h.atc022))'');
    populated_atc023_cnt := COUNT(GROUP,h.atc023 <> (TYPEOF(h.atc023))'');
    populated_atc023_pcnt := AVE(GROUP,IF(h.atc023 = (TYPEOF(h.atc023))'',0,100));
    maxlength_atc023 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc023)));
    avelength_atc023 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc023)),h.atc023<>(typeof(h.atc023))'');
    populated_atc024_cnt := COUNT(GROUP,h.atc024 <> (TYPEOF(h.atc024))'');
    populated_atc024_pcnt := AVE(GROUP,IF(h.atc024 = (TYPEOF(h.atc024))'',0,100));
    maxlength_atc024 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc024)));
    avelength_atc024 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc024)),h.atc024<>(typeof(h.atc024))'');
    populated_atc025_cnt := COUNT(GROUP,h.atc025 <> (TYPEOF(h.atc025))'');
    populated_atc025_pcnt := AVE(GROUP,IF(h.atc025 = (TYPEOF(h.atc025))'',0,100));
    maxlength_atc025 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc025)));
    avelength_atc025 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.atc025)),h.atc025<>(typeof(h.atc025))'');
    populated_last_activity_age_code_cnt := COUNT(GROUP,h.last_activity_age_code <> (TYPEOF(h.last_activity_age_code))'');
    populated_last_activity_age_code_pcnt := AVE(GROUP,IF(h.last_activity_age_code = (TYPEOF(h.last_activity_age_code))'',0,100));
    maxlength_last_activity_age_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_activity_age_code)));
    avelength_last_activity_age_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_activity_age_code)),h.last_activity_age_code<>(typeof(h.last_activity_age_code))'');
    populated_cottage_indicator_cnt := COUNT(GROUP,h.cottage_indicator <> (TYPEOF(h.cottage_indicator))'');
    populated_cottage_indicator_pcnt := AVE(GROUP,IF(h.cottage_indicator = (TYPEOF(h.cottage_indicator))'',0,100));
    maxlength_cottage_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cottage_indicator)));
    avelength_cottage_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cottage_indicator)),h.cottage_indicator<>(typeof(h.cottage_indicator))'');
    populated_nonprofit_indicator_cnt := COUNT(GROUP,h.nonprofit_indicator <> (TYPEOF(h.nonprofit_indicator))'');
    populated_nonprofit_indicator_pcnt := AVE(GROUP,IF(h.nonprofit_indicator = (TYPEOF(h.nonprofit_indicator))'',0,100));
    maxlength_nonprofit_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nonprofit_indicator)));
    avelength_nonprofit_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nonprofit_indicator)),h.nonprofit_indicator<>(typeof(h.nonprofit_indicator))'');
    populated_financial_stability_risk_score_cnt := COUNT(GROUP,h.financial_stability_risk_score <> (TYPEOF(h.financial_stability_risk_score))'');
    populated_financial_stability_risk_score_pcnt := AVE(GROUP,IF(h.financial_stability_risk_score = (TYPEOF(h.financial_stability_risk_score))'',0,100));
    maxlength_financial_stability_risk_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.financial_stability_risk_score)));
    avelength_financial_stability_risk_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.financial_stability_risk_score)),h.financial_stability_risk_score<>(typeof(h.financial_stability_risk_score))'');
    populated_fsr_risk_class_cnt := COUNT(GROUP,h.fsr_risk_class <> (TYPEOF(h.fsr_risk_class))'');
    populated_fsr_risk_class_pcnt := AVE(GROUP,IF(h.fsr_risk_class = (TYPEOF(h.fsr_risk_class))'',0,100));
    maxlength_fsr_risk_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_risk_class)));
    avelength_fsr_risk_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_risk_class)),h.fsr_risk_class<>(typeof(h.fsr_risk_class))'');
    populated_fsr_score_factor_1_cnt := COUNT(GROUP,h.fsr_score_factor_1 <> (TYPEOF(h.fsr_score_factor_1))'');
    populated_fsr_score_factor_1_pcnt := AVE(GROUP,IF(h.fsr_score_factor_1 = (TYPEOF(h.fsr_score_factor_1))'',0,100));
    maxlength_fsr_score_factor_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_1)));
    avelength_fsr_score_factor_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_1)),h.fsr_score_factor_1<>(typeof(h.fsr_score_factor_1))'');
    populated_fsr_score_factor_2_cnt := COUNT(GROUP,h.fsr_score_factor_2 <> (TYPEOF(h.fsr_score_factor_2))'');
    populated_fsr_score_factor_2_pcnt := AVE(GROUP,IF(h.fsr_score_factor_2 = (TYPEOF(h.fsr_score_factor_2))'',0,100));
    maxlength_fsr_score_factor_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_2)));
    avelength_fsr_score_factor_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_2)),h.fsr_score_factor_2<>(typeof(h.fsr_score_factor_2))'');
    populated_fsr_score_factor_3_cnt := COUNT(GROUP,h.fsr_score_factor_3 <> (TYPEOF(h.fsr_score_factor_3))'');
    populated_fsr_score_factor_3_pcnt := AVE(GROUP,IF(h.fsr_score_factor_3 = (TYPEOF(h.fsr_score_factor_3))'',0,100));
    maxlength_fsr_score_factor_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_3)));
    avelength_fsr_score_factor_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_3)),h.fsr_score_factor_3<>(typeof(h.fsr_score_factor_3))'');
    populated_fsr_score_factor_4_cnt := COUNT(GROUP,h.fsr_score_factor_4 <> (TYPEOF(h.fsr_score_factor_4))'');
    populated_fsr_score_factor_4_pcnt := AVE(GROUP,IF(h.fsr_score_factor_4 = (TYPEOF(h.fsr_score_factor_4))'',0,100));
    maxlength_fsr_score_factor_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_4)));
    avelength_fsr_score_factor_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_factor_4)),h.fsr_score_factor_4<>(typeof(h.fsr_score_factor_4))'');
    populated_ip_score_change_sign_cnt := COUNT(GROUP,h.ip_score_change_sign <> (TYPEOF(h.ip_score_change_sign))'');
    populated_ip_score_change_sign_pcnt := AVE(GROUP,IF(h.ip_score_change_sign = (TYPEOF(h.ip_score_change_sign))'',0,100));
    maxlength_ip_score_change_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ip_score_change_sign)));
    avelength_ip_score_change_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ip_score_change_sign)),h.ip_score_change_sign<>(typeof(h.ip_score_change_sign))'');
    populated_ip_score_change_cnt := COUNT(GROUP,h.ip_score_change <> (TYPEOF(h.ip_score_change))'');
    populated_ip_score_change_pcnt := AVE(GROUP,IF(h.ip_score_change = (TYPEOF(h.ip_score_change))'',0,100));
    maxlength_ip_score_change := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ip_score_change)));
    avelength_ip_score_change := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ip_score_change)),h.ip_score_change<>(typeof(h.ip_score_change))'');
    populated_fsr_score_change_sign_cnt := COUNT(GROUP,h.fsr_score_change_sign <> (TYPEOF(h.fsr_score_change_sign))'');
    populated_fsr_score_change_sign_pcnt := AVE(GROUP,IF(h.fsr_score_change_sign = (TYPEOF(h.fsr_score_change_sign))'',0,100));
    maxlength_fsr_score_change_sign := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_change_sign)));
    avelength_fsr_score_change_sign := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_change_sign)),h.fsr_score_change_sign<>(typeof(h.fsr_score_change_sign))'');
    populated_fsr_score_change_cnt := COUNT(GROUP,h.fsr_score_change <> (TYPEOF(h.fsr_score_change))'');
    populated_fsr_score_change_pcnt := AVE(GROUP,IF(h.fsr_score_change = (TYPEOF(h.fsr_score_change))'',0,100));
    maxlength_fsr_score_change := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_change)));
    avelength_fsr_score_change := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fsr_score_change)),h.fsr_score_change<>(typeof(h.fsr_score_change))'');
    populated_dba_name_cnt := COUNT(GROUP,h.dba_name <> (TYPEOF(h.dba_name))'');
    populated_dba_name_pcnt := AVE(GROUP,IF(h.dba_name = (TYPEOF(h.dba_name))'',0,100));
    maxlength_dba_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dba_name)));
    avelength_dba_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dba_name)),h.dba_name<>(typeof(h.dba_name))'');
    populated_clean_dba_name_cnt := COUNT(GROUP,h.clean_dba_name <> (TYPEOF(h.clean_dba_name))'');
    populated_clean_dba_name_pcnt := AVE(GROUP,IF(h.clean_dba_name = (TYPEOF(h.clean_dba_name))'',0,100));
    maxlength_clean_dba_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dba_name)));
    avelength_clean_dba_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dba_name)),h.clean_dba_name<>(typeof(h.clean_dba_name))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
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
    populated_recent_update_desc_cnt := COUNT(GROUP,h.recent_update_desc <> (TYPEOF(h.recent_update_desc))'');
    populated_recent_update_desc_pcnt := AVE(GROUP,IF(h.recent_update_desc = (TYPEOF(h.recent_update_desc))'',0,100));
    maxlength_recent_update_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_update_desc)));
    avelength_recent_update_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recent_update_desc)),h.recent_update_desc<>(typeof(h.recent_update_desc))'');
    populated_years_in_business_desc_cnt := COUNT(GROUP,h.years_in_business_desc <> (TYPEOF(h.years_in_business_desc))'');
    populated_years_in_business_desc_pcnt := AVE(GROUP,IF(h.years_in_business_desc = (TYPEOF(h.years_in_business_desc))'',0,100));
    maxlength_years_in_business_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_business_desc)));
    avelength_years_in_business_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.years_in_business_desc)),h.years_in_business_desc<>(typeof(h.years_in_business_desc))'');
    populated_address_type_desc_cnt := COUNT(GROUP,h.address_type_desc <> (TYPEOF(h.address_type_desc))'');
    populated_address_type_desc_pcnt := AVE(GROUP,IF(h.address_type_desc = (TYPEOF(h.address_type_desc))'',0,100));
    maxlength_address_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type_desc)));
    avelength_address_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type_desc)),h.address_type_desc<>(typeof(h.address_type_desc))'');
    populated_employee_size_desc_cnt := COUNT(GROUP,h.employee_size_desc <> (TYPEOF(h.employee_size_desc))'');
    populated_employee_size_desc_pcnt := AVE(GROUP,IF(h.employee_size_desc = (TYPEOF(h.employee_size_desc))'',0,100));
    maxlength_employee_size_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.employee_size_desc)));
    avelength_employee_size_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.employee_size_desc)),h.employee_size_desc<>(typeof(h.employee_size_desc))'');
    populated_annual_sales_size_desc_cnt := COUNT(GROUP,h.annual_sales_size_desc <> (TYPEOF(h.annual_sales_size_desc))'');
    populated_annual_sales_size_desc_pcnt := AVE(GROUP,IF(h.annual_sales_size_desc = (TYPEOF(h.annual_sales_size_desc))'',0,100));
    maxlength_annual_sales_size_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.annual_sales_size_desc)));
    avelength_annual_sales_size_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.annual_sales_size_desc)),h.annual_sales_size_desc<>(typeof(h.annual_sales_size_desc))'');
    populated_location_desc_cnt := COUNT(GROUP,h.location_desc <> (TYPEOF(h.location_desc))'');
    populated_location_desc_pcnt := AVE(GROUP,IF(h.location_desc = (TYPEOF(h.location_desc))'',0,100));
    maxlength_location_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.location_desc)));
    avelength_location_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.location_desc)),h.location_desc<>(typeof(h.location_desc))'');
    populated_primary_sic_code_industry_class_desc_cnt := COUNT(GROUP,h.primary_sic_code_industry_class_desc <> (TYPEOF(h.primary_sic_code_industry_class_desc))'');
    populated_primary_sic_code_industry_class_desc_pcnt := AVE(GROUP,IF(h.primary_sic_code_industry_class_desc = (TYPEOF(h.primary_sic_code_industry_class_desc))'',0,100));
    maxlength_primary_sic_code_industry_class_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_industry_class_desc)));
    avelength_primary_sic_code_industry_class_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.primary_sic_code_industry_class_desc)),h.primary_sic_code_industry_class_desc<>(typeof(h.primary_sic_code_industry_class_desc))'');
    populated_business_type_desc_cnt := COUNT(GROUP,h.business_type_desc <> (TYPEOF(h.business_type_desc))'');
    populated_business_type_desc_pcnt := AVE(GROUP,IF(h.business_type_desc = (TYPEOF(h.business_type_desc))'',0,100));
    maxlength_business_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_type_desc)));
    avelength_business_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_type_desc)),h.business_type_desc<>(typeof(h.business_type_desc))'');
    populated_ownership_code_desc_cnt := COUNT(GROUP,h.ownership_code_desc <> (TYPEOF(h.ownership_code_desc))'');
    populated_ownership_code_desc_pcnt := AVE(GROUP,IF(h.ownership_code_desc = (TYPEOF(h.ownership_code_desc))'',0,100));
    maxlength_ownership_code_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code_desc)));
    avelength_ownership_code_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code_desc)),h.ownership_code_desc<>(typeof(h.ownership_code_desc))'');
    populated_ucc_data_indicator_desc_cnt := COUNT(GROUP,h.ucc_data_indicator_desc <> (TYPEOF(h.ucc_data_indicator_desc))'');
    populated_ucc_data_indicator_desc_pcnt := AVE(GROUP,IF(h.ucc_data_indicator_desc = (TYPEOF(h.ucc_data_indicator_desc))'',0,100));
    maxlength_ucc_data_indicator_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_data_indicator_desc)));
    avelength_ucc_data_indicator_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ucc_data_indicator_desc)),h.ucc_data_indicator_desc<>(typeof(h.ucc_data_indicator_desc))'');
    populated_experian_credit_rating_desc_cnt := COUNT(GROUP,h.experian_credit_rating_desc <> (TYPEOF(h.experian_credit_rating_desc))'');
    populated_experian_credit_rating_desc_pcnt := AVE(GROUP,IF(h.experian_credit_rating_desc = (TYPEOF(h.experian_credit_rating_desc))'',0,100));
    maxlength_experian_credit_rating_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_credit_rating_desc)));
    avelength_experian_credit_rating_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.experian_credit_rating_desc)),h.experian_credit_rating_desc<>(typeof(h.experian_credit_rating_desc))'');
    populated_last_activity_age_desc_cnt := COUNT(GROUP,h.last_activity_age_desc <> (TYPEOF(h.last_activity_age_desc))'');
    populated_last_activity_age_desc_pcnt := AVE(GROUP,IF(h.last_activity_age_desc = (TYPEOF(h.last_activity_age_desc))'',0,100));
    maxlength_last_activity_age_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_activity_age_desc)));
    avelength_last_activity_age_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_activity_age_desc)),h.last_activity_age_desc<>(typeof(h.last_activity_age_desc))'');
    populated_cottage_indicator_desc_cnt := COUNT(GROUP,h.cottage_indicator_desc <> (TYPEOF(h.cottage_indicator_desc))'');
    populated_cottage_indicator_desc_pcnt := AVE(GROUP,IF(h.cottage_indicator_desc = (TYPEOF(h.cottage_indicator_desc))'',0,100));
    maxlength_cottage_indicator_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cottage_indicator_desc)));
    avelength_cottage_indicator_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cottage_indicator_desc)),h.cottage_indicator_desc<>(typeof(h.cottage_indicator_desc))'');
    populated_nonprofit_indicator_desc_cnt := COUNT(GROUP,h.nonprofit_indicator_desc <> (TYPEOF(h.nonprofit_indicator_desc))'');
    populated_nonprofit_indicator_desc_pcnt := AVE(GROUP,IF(h.nonprofit_indicator_desc = (TYPEOF(h.nonprofit_indicator_desc))'',0,100));
    maxlength_nonprofit_indicator_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nonprofit_indicator_desc)));
    avelength_nonprofit_indicator_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nonprofit_indicator_desc)),h.nonprofit_indicator_desc<>(typeof(h.nonprofit_indicator_desc))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_p_title_cnt := COUNT(GROUP,h.p_title <> (TYPEOF(h.p_title))'');
    populated_p_title_pcnt := AVE(GROUP,IF(h.p_title = (TYPEOF(h.p_title))'',0,100));
    maxlength_p_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_title)));
    avelength_p_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_title)),h.p_title<>(typeof(h.p_title))'');
    populated_p_fname_cnt := COUNT(GROUP,h.p_fname <> (TYPEOF(h.p_fname))'');
    populated_p_fname_pcnt := AVE(GROUP,IF(h.p_fname = (TYPEOF(h.p_fname))'',0,100));
    maxlength_p_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_fname)));
    avelength_p_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_fname)),h.p_fname<>(typeof(h.p_fname))'');
    populated_p_mname_cnt := COUNT(GROUP,h.p_mname <> (TYPEOF(h.p_mname))'');
    populated_p_mname_pcnt := AVE(GROUP,IF(h.p_mname = (TYPEOF(h.p_mname))'',0,100));
    maxlength_p_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_mname)));
    avelength_p_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_mname)),h.p_mname<>(typeof(h.p_mname))'');
    populated_p_lname_cnt := COUNT(GROUP,h.p_lname <> (TYPEOF(h.p_lname))'');
    populated_p_lname_pcnt := AVE(GROUP,IF(h.p_lname = (TYPEOF(h.p_lname))'',0,100));
    maxlength_p_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_lname)));
    avelength_p_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_lname)),h.p_lname<>(typeof(h.p_lname))'');
    populated_p_name_suffix_cnt := COUNT(GROUP,h.p_name_suffix <> (TYPEOF(h.p_name_suffix))'');
    populated_p_name_suffix_pcnt := AVE(GROUP,IF(h.p_name_suffix = (TYPEOF(h.p_name_suffix))'',0,100));
    maxlength_p_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_name_suffix)));
    avelength_p_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_name_suffix)),h.p_name_suffix<>(typeof(h.p_name_suffix))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_experian_bus_id_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zip_plus_4_pcnt *   0.00 / 100 + T.Populated_carrier_route_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_msa_code_pcnt *   0.00 / 100 + T.Populated_msa_description_pcnt *   0.00 / 100 + T.Populated_establish_date_pcnt *   0.00 / 100 + T.Populated_latest_reported_date_pcnt *   0.00 / 100 + T.Populated_years_in_file_pcnt *   0.00 / 100 + T.Populated_geo_code_latitude_pcnt *   0.00 / 100 + T.Populated_geo_code_latitude_direction_pcnt *   0.00 / 100 + T.Populated_geo_code_longitude_pcnt *   0.00 / 100 + T.Populated_geo_code_longitude_direction_pcnt *   0.00 / 100 + T.Populated_recent_update_code_pcnt *   0.00 / 100 + T.Populated_years_in_business_code_pcnt *   0.00 / 100 + T.Populated_year_business_started_pcnt *   0.00 / 100 + T.Populated_months_in_file_pcnt *   0.00 / 100 + T.Populated_address_type_code_pcnt *   0.00 / 100 + T.Populated_estimated_number_of_employees_pcnt *   0.00 / 100 + T.Populated_employee_size_code_pcnt *   0.00 / 100 + T.Populated_estimated_annual_sales_amount_sign_pcnt *   0.00 / 100 + T.Populated_estimated_annual_sales_amount_pcnt *   0.00 / 100 + T.Populated_annual_sales_size_code_pcnt *   0.00 / 100 + T.Populated_location_code_pcnt *   0.00 / 100 + T.Populated_primary_sic_code_industry_classification_pcnt *   0.00 / 100 + T.Populated_primary_sic_code_4_digit_pcnt *   0.00 / 100 + T.Populated_primary_sic_code_pcnt *   0.00 / 100 + T.Populated_second_sic_code_pcnt *   0.00 / 100 + T.Populated_third_sic_code_pcnt *   0.00 / 100 + T.Populated_fourth_sic_code_pcnt *   0.00 / 100 + T.Populated_fifth_sic_code_pcnt *   0.00 / 100 + T.Populated_sixth_sic_code_pcnt *   0.00 / 100 + T.Populated_primary_naics_code_pcnt *   0.00 / 100 + T.Populated_second_naics_code_pcnt *   0.00 / 100 + T.Populated_third_naics_code_pcnt *   0.00 / 100 + T.Populated_fourth_naics_code_pcnt *   0.00 / 100 + T.Populated_executive_count_pcnt *   0.00 / 100 + T.Populated_executive_last_name_pcnt *   0.00 / 100 + T.Populated_executive_first_name_pcnt *   0.00 / 100 + T.Populated_executive_middle_initial_pcnt *   0.00 / 100 + T.Populated_executive_title_pcnt *   0.00 / 100 + T.Populated_business_type_pcnt *   0.00 / 100 + T.Populated_ownership_code_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_derogatory_indicator_pcnt *   0.00 / 100 + T.Populated_recent_derogatory_filed_date_pcnt *   0.00 / 100 + T.Populated_derogatory_liability_amount_sign_pcnt *   0.00 / 100 + T.Populated_derogatory_liability_amount_pcnt *   0.00 / 100 + T.Populated_ucc_data_indicator_pcnt *   0.00 / 100 + T.Populated_ucc_count_pcnt *   0.00 / 100 + T.Populated_number_of_legal_items_pcnt *   0.00 / 100 + T.Populated_legal_balance_sign_pcnt *   0.00 / 100 + T.Populated_legal_balance_amount_pcnt *   0.00 / 100 + T.Populated_pmtkbankruptcy_pcnt *   0.00 / 100 + T.Populated_pmtkjudgment_pcnt *   0.00 / 100 + T.Populated_pmtktaxlien_pcnt *   0.00 / 100 + T.Populated_pmtkpayment_pcnt *   0.00 / 100 + T.Populated_bankruptcy_filed_pcnt *   0.00 / 100 + T.Populated_number_of_derogatory_legal_items_pcnt *   0.00 / 100 + T.Populated_lien_count_pcnt *   0.00 / 100 + T.Populated_judgment_count_pcnt *   0.00 / 100 + T.Populated_bkc006_pcnt *   0.00 / 100 + T.Populated_bkc007_pcnt *   0.00 / 100 + T.Populated_bkc008_pcnt *   0.00 / 100 + T.Populated_bko009_pcnt *   0.00 / 100 + T.Populated_bkb001_sign_pcnt *   0.00 / 100 + T.Populated_bkb001_pcnt *   0.00 / 100 + T.Populated_bkb003_sign_pcnt *   0.00 / 100 + T.Populated_bkb003_pcnt *   0.00 / 100 + T.Populated_bko010_pcnt *   0.00 / 100 + T.Populated_bko011_pcnt *   0.00 / 100 + T.Populated_jdc010_pcnt *   0.00 / 100 + T.Populated_jdc011_pcnt *   0.00 / 100 + T.Populated_jdc012_pcnt *   0.00 / 100 + T.Populated_jdb004_pcnt *   0.00 / 100 + T.Populated_jdb005_pcnt *   0.00 / 100 + T.Populated_jdb006_pcnt *   0.00 / 100 + T.Populated_jDO013_pcnt *   0.00 / 100 + T.Populated_jDO014_pcnt *   0.00 / 100 + T.Populated_jdb002_pcnt *   0.00 / 100 + T.Populated_jdp016_pcnt *   0.00 / 100 + T.Populated_lgc004_pcnt *   0.00 / 100 + T.Populated_pro001_pcnt *   0.00 / 100 + T.Populated_pro003_pcnt *   0.00 / 100 + T.Populated_txc010_pcnt *   0.00 / 100 + T.Populated_txc011_pcnt *   0.00 / 100 + T.Populated_txb004_sign_pcnt *   0.00 / 100 + T.Populated_txb004_pcnt *   0.00 / 100 + T.Populated_txo013_pcnt *   0.00 / 100 + T.Populated_txb002_sign_pcnt *   0.00 / 100 + T.Populated_txb002_pcnt *   0.00 / 100 + T.Populated_txp016_pcnt *   0.00 / 100 + T.Populated_ucc001_pcnt *   0.00 / 100 + T.Populated_ucc002_pcnt *   0.00 / 100 + T.Populated_ucc003_pcnt *   0.00 / 100 + T.Populated_intelliscore_plus_pcnt *   0.00 / 100 + T.Populated_percentile_model_pcnt *   0.00 / 100 + T.Populated_model_action_pcnt *   0.00 / 100 + T.Populated_score_factor_1_pcnt *   0.00 / 100 + T.Populated_score_factor_2_pcnt *   0.00 / 100 + T.Populated_score_factor_3_pcnt *   0.00 / 100 + T.Populated_score_factor_4_pcnt *   0.00 / 100 + T.Populated_model_code_pcnt *   0.00 / 100 + T.Populated_model_type_pcnt *   0.00 / 100 + T.Populated_last_experian_inquiry_date_pcnt *   0.00 / 100 + T.Populated_recent_high_credit_sign_pcnt *   0.00 / 100 + T.Populated_recent_high_credit_pcnt *   0.00 / 100 + T.Populated_median_credit_amount_sign_pcnt *   0.00 / 100 + T.Populated_median_credit_amount_pcnt *   0.00 / 100 + T.Populated_total_combined_trade_lines_count_pcnt *   0.00 / 100 + T.Populated_dbt_of_combined_trade_totals_pcnt *   0.00 / 100 + T.Populated_combined_trade_balance_pcnt *   0.00 / 100 + T.Populated_aged_trade_lines_pcnt *   0.00 / 100 + T.Populated_experian_credit_rating_pcnt *   0.00 / 100 + T.Populated_quarter_1_average_dbt_pcnt *   0.00 / 100 + T.Populated_quarter_2_average_dbt_pcnt *   0.00 / 100 + T.Populated_quarter_3_average_dbt_pcnt *   0.00 / 100 + T.Populated_quarter_4_average_dbt_pcnt *   0.00 / 100 + T.Populated_quarter_5_average_dbt_pcnt *   0.00 / 100 + T.Populated_combined_dbt_pcnt *   0.00 / 100 + T.Populated_total_account_balance_sign_pcnt *   0.00 / 100 + T.Populated_total_account_balance_pcnt *   0.00 / 100 + T.Populated_combined_account_balance_sign_pcnt *   0.00 / 100 + T.Populated_combined_account_balance_pcnt *   0.00 / 100 + T.Populated_collection_count_pcnt *   0.00 / 100 + T.Populated_atc021_pcnt *   0.00 / 100 + T.Populated_atc022_pcnt *   0.00 / 100 + T.Populated_atc023_pcnt *   0.00 / 100 + T.Populated_atc024_pcnt *   0.00 / 100 + T.Populated_atc025_pcnt *   0.00 / 100 + T.Populated_last_activity_age_code_pcnt *   0.00 / 100 + T.Populated_cottage_indicator_pcnt *   0.00 / 100 + T.Populated_nonprofit_indicator_pcnt *   0.00 / 100 + T.Populated_financial_stability_risk_score_pcnt *   0.00 / 100 + T.Populated_fsr_risk_class_pcnt *   0.00 / 100 + T.Populated_fsr_score_factor_1_pcnt *   0.00 / 100 + T.Populated_fsr_score_factor_2_pcnt *   0.00 / 100 + T.Populated_fsr_score_factor_3_pcnt *   0.00 / 100 + T.Populated_fsr_score_factor_4_pcnt *   0.00 / 100 + T.Populated_ip_score_change_sign_pcnt *   0.00 / 100 + T.Populated_ip_score_change_pcnt *   0.00 / 100 + T.Populated_fsr_score_change_sign_pcnt *   0.00 / 100 + T.Populated_fsr_score_change_pcnt *   0.00 / 100 + T.Populated_dba_name_pcnt *   0.00 / 100 + T.Populated_clean_dba_name_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_recent_update_desc_pcnt *   0.00 / 100 + T.Populated_years_in_business_desc_pcnt *   0.00 / 100 + T.Populated_address_type_desc_pcnt *   0.00 / 100 + T.Populated_employee_size_desc_pcnt *   0.00 / 100 + T.Populated_annual_sales_size_desc_pcnt *   0.00 / 100 + T.Populated_location_desc_pcnt *   0.00 / 100 + T.Populated_primary_sic_code_industry_class_desc_pcnt *   0.00 / 100 + T.Populated_business_type_desc_pcnt *   0.00 / 100 + T.Populated_ownership_code_desc_pcnt *   0.00 / 100 + T.Populated_ucc_data_indicator_desc_pcnt *   0.00 / 100 + T.Populated_experian_credit_rating_desc_pcnt *   0.00 / 100 + T.Populated_last_activity_age_desc_pcnt *   0.00 / 100 + T.Populated_cottage_indicator_desc_pcnt *   0.00 / 100 + T.Populated_nonprofit_indicator_desc_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_p_title_pcnt *   0.00 / 100 + T.Populated_p_fname_pcnt *   0.00 / 100 + T.Populated_p_mname_pcnt *   0.00 / 100 + T.Populated_p_lname_pcnt *   0.00 / 100 + T.Populated_p_name_suffix_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','experian_bus_id','business_name','address','city','state','zip_code','zip_plus_4','carrier_route','county_code','county_name','phone_number','msa_code','msa_description','establish_date','latest_reported_date','years_in_file','geo_code_latitude','geo_code_latitude_direction','geo_code_longitude','geo_code_longitude_direction','recent_update_code','years_in_business_code','year_business_started','months_in_file','address_type_code','estimated_number_of_employees','employee_size_code','estimated_annual_sales_amount_sign','estimated_annual_sales_amount','annual_sales_size_code','location_code','primary_sic_code_industry_classification','primary_sic_code_4_digit','primary_sic_code','second_sic_code','third_sic_code','fourth_sic_code','fifth_sic_code','sixth_sic_code','primary_naics_code','second_naics_code','third_naics_code','fourth_naics_code','executive_count','executive_last_name','executive_first_name','executive_middle_initial','executive_title','business_type','ownership_code','url','derogatory_indicator','recent_derogatory_filed_date','derogatory_liability_amount_sign','derogatory_liability_amount','ucc_data_indicator','ucc_count','number_of_legal_items','legal_balance_sign','legal_balance_amount','pmtkbankruptcy','pmtkjudgment','pmtktaxlien','pmtkpayment','bankruptcy_filed','number_of_derogatory_legal_items','lien_count','judgment_count','bkc006','bkc007','bkc008','bko009','bkb001_sign','bkb001','bkb003_sign','bkb003','bko010','bko011','jdc010','jdc011','jdc012','jdb004','jdb005','jdb006','jDO013','jDO014','jdb002','jdp016','lgc004','pro001','pro003','txc010','txc011','txb004_sign','txb004','txo013','txb002_sign','txb002','txp016','ucc001','ucc002','ucc003','intelliscore_plus','percentile_model','model_action','score_factor_1','score_factor_2','score_factor_3','score_factor_4','model_code','model_type','last_experian_inquiry_date','recent_high_credit_sign','recent_high_credit','median_credit_amount_sign','median_credit_amount','total_combined_trade_lines_count','dbt_of_combined_trade_totals','combined_trade_balance','aged_trade_lines','experian_credit_rating','quarter_1_average_dbt','quarter_2_average_dbt','quarter_3_average_dbt','quarter_4_average_dbt','quarter_5_average_dbt','combined_dbt','total_account_balance_sign','total_account_balance','combined_account_balance_sign','combined_account_balance','collection_count','atc021','atc022','atc023','atc024','atc025','last_activity_age_code','cottage_indicator','nonprofit_indicator','financial_stability_risk_score','fsr_risk_class','fsr_score_factor_1','fsr_score_factor_2','fsr_score_factor_3','fsr_score_factor_4','ip_score_change_sign','ip_score_change','fsr_score_change_sign','fsr_score_change','dba_name','clean_dba_name','clean_phone','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','recent_update_desc','years_in_business_desc','address_type_desc','employee_size_desc','annual_sales_size_desc','location_desc','primary_sic_code_industry_class_desc','business_type_desc','ownership_code_desc','ucc_data_indicator_desc','experian_credit_rating_desc','last_activity_age_desc','cottage_indicator_desc','nonprofit_indicator_desc','company_name','p_title','p_fname','p_mname','p_lname','p_name_suffix','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_did_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_experian_bus_id_pcnt,le.populated_business_name_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_zip_plus_4_pcnt,le.populated_carrier_route_pcnt,le.populated_county_code_pcnt,le.populated_county_name_pcnt,le.populated_phone_number_pcnt,le.populated_msa_code_pcnt,le.populated_msa_description_pcnt,le.populated_establish_date_pcnt,le.populated_latest_reported_date_pcnt,le.populated_years_in_file_pcnt,le.populated_geo_code_latitude_pcnt,le.populated_geo_code_latitude_direction_pcnt,le.populated_geo_code_longitude_pcnt,le.populated_geo_code_longitude_direction_pcnt,le.populated_recent_update_code_pcnt,le.populated_years_in_business_code_pcnt,le.populated_year_business_started_pcnt,le.populated_months_in_file_pcnt,le.populated_address_type_code_pcnt,le.populated_estimated_number_of_employees_pcnt,le.populated_employee_size_code_pcnt,le.populated_estimated_annual_sales_amount_sign_pcnt,le.populated_estimated_annual_sales_amount_pcnt,le.populated_annual_sales_size_code_pcnt,le.populated_location_code_pcnt,le.populated_primary_sic_code_industry_classification_pcnt,le.populated_primary_sic_code_4_digit_pcnt,le.populated_primary_sic_code_pcnt,le.populated_second_sic_code_pcnt,le.populated_third_sic_code_pcnt,le.populated_fourth_sic_code_pcnt,le.populated_fifth_sic_code_pcnt,le.populated_sixth_sic_code_pcnt,le.populated_primary_naics_code_pcnt,le.populated_second_naics_code_pcnt,le.populated_third_naics_code_pcnt,le.populated_fourth_naics_code_pcnt,le.populated_executive_count_pcnt,le.populated_executive_last_name_pcnt,le.populated_executive_first_name_pcnt,le.populated_executive_middle_initial_pcnt,le.populated_executive_title_pcnt,le.populated_business_type_pcnt,le.populated_ownership_code_pcnt,le.populated_url_pcnt,le.populated_derogatory_indicator_pcnt,le.populated_recent_derogatory_filed_date_pcnt,le.populated_derogatory_liability_amount_sign_pcnt,le.populated_derogatory_liability_amount_pcnt,le.populated_ucc_data_indicator_pcnt,le.populated_ucc_count_pcnt,le.populated_number_of_legal_items_pcnt,le.populated_legal_balance_sign_pcnt,le.populated_legal_balance_amount_pcnt,le.populated_pmtkbankruptcy_pcnt,le.populated_pmtkjudgment_pcnt,le.populated_pmtktaxlien_pcnt,le.populated_pmtkpayment_pcnt,le.populated_bankruptcy_filed_pcnt,le.populated_number_of_derogatory_legal_items_pcnt,le.populated_lien_count_pcnt,le.populated_judgment_count_pcnt,le.populated_bkc006_pcnt,le.populated_bkc007_pcnt,le.populated_bkc008_pcnt,le.populated_bko009_pcnt,le.populated_bkb001_sign_pcnt,le.populated_bkb001_pcnt,le.populated_bkb003_sign_pcnt,le.populated_bkb003_pcnt,le.populated_bko010_pcnt,le.populated_bko011_pcnt,le.populated_jdc010_pcnt,le.populated_jdc011_pcnt,le.populated_jdc012_pcnt,le.populated_jdb004_pcnt,le.populated_jdb005_pcnt,le.populated_jdb006_pcnt,le.populated_jDO013_pcnt,le.populated_jDO014_pcnt,le.populated_jdb002_pcnt,le.populated_jdp016_pcnt,le.populated_lgc004_pcnt,le.populated_pro001_pcnt,le.populated_pro003_pcnt,le.populated_txc010_pcnt,le.populated_txc011_pcnt,le.populated_txb004_sign_pcnt,le.populated_txb004_pcnt,le.populated_txo013_pcnt,le.populated_txb002_sign_pcnt,le.populated_txb002_pcnt,le.populated_txp016_pcnt,le.populated_ucc001_pcnt,le.populated_ucc002_pcnt,le.populated_ucc003_pcnt,le.populated_intelliscore_plus_pcnt,le.populated_percentile_model_pcnt,le.populated_model_action_pcnt,le.populated_score_factor_1_pcnt,le.populated_score_factor_2_pcnt,le.populated_score_factor_3_pcnt,le.populated_score_factor_4_pcnt,le.populated_model_code_pcnt,le.populated_model_type_pcnt,le.populated_last_experian_inquiry_date_pcnt,le.populated_recent_high_credit_sign_pcnt,le.populated_recent_high_credit_pcnt,le.populated_median_credit_amount_sign_pcnt,le.populated_median_credit_amount_pcnt,le.populated_total_combined_trade_lines_count_pcnt,le.populated_dbt_of_combined_trade_totals_pcnt,le.populated_combined_trade_balance_pcnt,le.populated_aged_trade_lines_pcnt,le.populated_experian_credit_rating_pcnt,le.populated_quarter_1_average_dbt_pcnt,le.populated_quarter_2_average_dbt_pcnt,le.populated_quarter_3_average_dbt_pcnt,le.populated_quarter_4_average_dbt_pcnt,le.populated_quarter_5_average_dbt_pcnt,le.populated_combined_dbt_pcnt,le.populated_total_account_balance_sign_pcnt,le.populated_total_account_balance_pcnt,le.populated_combined_account_balance_sign_pcnt,le.populated_combined_account_balance_pcnt,le.populated_collection_count_pcnt,le.populated_atc021_pcnt,le.populated_atc022_pcnt,le.populated_atc023_pcnt,le.populated_atc024_pcnt,le.populated_atc025_pcnt,le.populated_last_activity_age_code_pcnt,le.populated_cottage_indicator_pcnt,le.populated_nonprofit_indicator_pcnt,le.populated_financial_stability_risk_score_pcnt,le.populated_fsr_risk_class_pcnt,le.populated_fsr_score_factor_1_pcnt,le.populated_fsr_score_factor_2_pcnt,le.populated_fsr_score_factor_3_pcnt,le.populated_fsr_score_factor_4_pcnt,le.populated_ip_score_change_sign_pcnt,le.populated_ip_score_change_pcnt,le.populated_fsr_score_change_sign_pcnt,le.populated_fsr_score_change_pcnt,le.populated_dba_name_pcnt,le.populated_clean_dba_name_pcnt,le.populated_clean_phone_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_recent_update_desc_pcnt,le.populated_years_in_business_desc_pcnt,le.populated_address_type_desc_pcnt,le.populated_employee_size_desc_pcnt,le.populated_annual_sales_size_desc_pcnt,le.populated_location_desc_pcnt,le.populated_primary_sic_code_industry_class_desc_pcnt,le.populated_business_type_desc_pcnt,le.populated_ownership_code_desc_pcnt,le.populated_ucc_data_indicator_desc_pcnt,le.populated_experian_credit_rating_desc_pcnt,le.populated_last_activity_age_desc_pcnt,le.populated_cottage_indicator_desc_pcnt,le.populated_nonprofit_indicator_desc_pcnt,le.populated_company_name_pcnt,le.populated_p_title_pcnt,le.populated_p_fname_pcnt,le.populated_p_mname_pcnt,le.populated_p_lname_pcnt,le.populated_p_name_suffix_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_source_rec_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_did,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_experian_bus_id,le.maxlength_business_name,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_zip_plus_4,le.maxlength_carrier_route,le.maxlength_county_code,le.maxlength_county_name,le.maxlength_phone_number,le.maxlength_msa_code,le.maxlength_msa_description,le.maxlength_establish_date,le.maxlength_latest_reported_date,le.maxlength_years_in_file,le.maxlength_geo_code_latitude,le.maxlength_geo_code_latitude_direction,le.maxlength_geo_code_longitude,le.maxlength_geo_code_longitude_direction,le.maxlength_recent_update_code,le.maxlength_years_in_business_code,le.maxlength_year_business_started,le.maxlength_months_in_file,le.maxlength_address_type_code,le.maxlength_estimated_number_of_employees,le.maxlength_employee_size_code,le.maxlength_estimated_annual_sales_amount_sign,le.maxlength_estimated_annual_sales_amount,le.maxlength_annual_sales_size_code,le.maxlength_location_code,le.maxlength_primary_sic_code_industry_classification,le.maxlength_primary_sic_code_4_digit,le.maxlength_primary_sic_code,le.maxlength_second_sic_code,le.maxlength_third_sic_code,le.maxlength_fourth_sic_code,le.maxlength_fifth_sic_code,le.maxlength_sixth_sic_code,le.maxlength_primary_naics_code,le.maxlength_second_naics_code,le.maxlength_third_naics_code,le.maxlength_fourth_naics_code,le.maxlength_executive_count,le.maxlength_executive_last_name,le.maxlength_executive_first_name,le.maxlength_executive_middle_initial,le.maxlength_executive_title,le.maxlength_business_type,le.maxlength_ownership_code,le.maxlength_url,le.maxlength_derogatory_indicator,le.maxlength_recent_derogatory_filed_date,le.maxlength_derogatory_liability_amount_sign,le.maxlength_derogatory_liability_amount,le.maxlength_ucc_data_indicator,le.maxlength_ucc_count,le.maxlength_number_of_legal_items,le.maxlength_legal_balance_sign,le.maxlength_legal_balance_amount,le.maxlength_pmtkbankruptcy,le.maxlength_pmtkjudgment,le.maxlength_pmtktaxlien,le.maxlength_pmtkpayment,le.maxlength_bankruptcy_filed,le.maxlength_number_of_derogatory_legal_items,le.maxlength_lien_count,le.maxlength_judgment_count,le.maxlength_bkc006,le.maxlength_bkc007,le.maxlength_bkc008,le.maxlength_bko009,le.maxlength_bkb001_sign,le.maxlength_bkb001,le.maxlength_bkb003_sign,le.maxlength_bkb003,le.maxlength_bko010,le.maxlength_bko011,le.maxlength_jdc010,le.maxlength_jdc011,le.maxlength_jdc012,le.maxlength_jdb004,le.maxlength_jdb005,le.maxlength_jdb006,le.maxlength_jDO013,le.maxlength_jDO014,le.maxlength_jdb002,le.maxlength_jdp016,le.maxlength_lgc004,le.maxlength_pro001,le.maxlength_pro003,le.maxlength_txc010,le.maxlength_txc011,le.maxlength_txb004_sign,le.maxlength_txb004,le.maxlength_txo013,le.maxlength_txb002_sign,le.maxlength_txb002,le.maxlength_txp016,le.maxlength_ucc001,le.maxlength_ucc002,le.maxlength_ucc003,le.maxlength_intelliscore_plus,le.maxlength_percentile_model,le.maxlength_model_action,le.maxlength_score_factor_1,le.maxlength_score_factor_2,le.maxlength_score_factor_3,le.maxlength_score_factor_4,le.maxlength_model_code,le.maxlength_model_type,le.maxlength_last_experian_inquiry_date,le.maxlength_recent_high_credit_sign,le.maxlength_recent_high_credit,le.maxlength_median_credit_amount_sign,le.maxlength_median_credit_amount,le.maxlength_total_combined_trade_lines_count,le.maxlength_dbt_of_combined_trade_totals,le.maxlength_combined_trade_balance,le.maxlength_aged_trade_lines,le.maxlength_experian_credit_rating,le.maxlength_quarter_1_average_dbt,le.maxlength_quarter_2_average_dbt,le.maxlength_quarter_3_average_dbt,le.maxlength_quarter_4_average_dbt,le.maxlength_quarter_5_average_dbt,le.maxlength_combined_dbt,le.maxlength_total_account_balance_sign,le.maxlength_total_account_balance,le.maxlength_combined_account_balance_sign,le.maxlength_combined_account_balance,le.maxlength_collection_count,le.maxlength_atc021,le.maxlength_atc022,le.maxlength_atc023,le.maxlength_atc024,le.maxlength_atc025,le.maxlength_last_activity_age_code,le.maxlength_cottage_indicator,le.maxlength_nonprofit_indicator,le.maxlength_financial_stability_risk_score,le.maxlength_fsr_risk_class,le.maxlength_fsr_score_factor_1,le.maxlength_fsr_score_factor_2,le.maxlength_fsr_score_factor_3,le.maxlength_fsr_score_factor_4,le.maxlength_ip_score_change_sign,le.maxlength_ip_score_change,le.maxlength_fsr_score_change_sign,le.maxlength_fsr_score_change,le.maxlength_dba_name,le.maxlength_clean_dba_name,le.maxlength_clean_phone,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_recent_update_desc,le.maxlength_years_in_business_desc,le.maxlength_address_type_desc,le.maxlength_employee_size_desc,le.maxlength_annual_sales_size_desc,le.maxlength_location_desc,le.maxlength_primary_sic_code_industry_class_desc,le.maxlength_business_type_desc,le.maxlength_ownership_code_desc,le.maxlength_ucc_data_indicator_desc,le.maxlength_experian_credit_rating_desc,le.maxlength_last_activity_age_desc,le.maxlength_cottage_indicator_desc,le.maxlength_nonprofit_indicator_desc,le.maxlength_company_name,le.maxlength_p_title,le.maxlength_p_fname,le.maxlength_p_mname,le.maxlength_p_lname,le.maxlength_p_name_suffix,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_source_rec_id);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_bdid,le.avelength_bdid_score,le.avelength_did,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_experian_bus_id,le.avelength_business_name,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_zip_plus_4,le.avelength_carrier_route,le.avelength_county_code,le.avelength_county_name,le.avelength_phone_number,le.avelength_msa_code,le.avelength_msa_description,le.avelength_establish_date,le.avelength_latest_reported_date,le.avelength_years_in_file,le.avelength_geo_code_latitude,le.avelength_geo_code_latitude_direction,le.avelength_geo_code_longitude,le.avelength_geo_code_longitude_direction,le.avelength_recent_update_code,le.avelength_years_in_business_code,le.avelength_year_business_started,le.avelength_months_in_file,le.avelength_address_type_code,le.avelength_estimated_number_of_employees,le.avelength_employee_size_code,le.avelength_estimated_annual_sales_amount_sign,le.avelength_estimated_annual_sales_amount,le.avelength_annual_sales_size_code,le.avelength_location_code,le.avelength_primary_sic_code_industry_classification,le.avelength_primary_sic_code_4_digit,le.avelength_primary_sic_code,le.avelength_second_sic_code,le.avelength_third_sic_code,le.avelength_fourth_sic_code,le.avelength_fifth_sic_code,le.avelength_sixth_sic_code,le.avelength_primary_naics_code,le.avelength_second_naics_code,le.avelength_third_naics_code,le.avelength_fourth_naics_code,le.avelength_executive_count,le.avelength_executive_last_name,le.avelength_executive_first_name,le.avelength_executive_middle_initial,le.avelength_executive_title,le.avelength_business_type,le.avelength_ownership_code,le.avelength_url,le.avelength_derogatory_indicator,le.avelength_recent_derogatory_filed_date,le.avelength_derogatory_liability_amount_sign,le.avelength_derogatory_liability_amount,le.avelength_ucc_data_indicator,le.avelength_ucc_count,le.avelength_number_of_legal_items,le.avelength_legal_balance_sign,le.avelength_legal_balance_amount,le.avelength_pmtkbankruptcy,le.avelength_pmtkjudgment,le.avelength_pmtktaxlien,le.avelength_pmtkpayment,le.avelength_bankruptcy_filed,le.avelength_number_of_derogatory_legal_items,le.avelength_lien_count,le.avelength_judgment_count,le.avelength_bkc006,le.avelength_bkc007,le.avelength_bkc008,le.avelength_bko009,le.avelength_bkb001_sign,le.avelength_bkb001,le.avelength_bkb003_sign,le.avelength_bkb003,le.avelength_bko010,le.avelength_bko011,le.avelength_jdc010,le.avelength_jdc011,le.avelength_jdc012,le.avelength_jdb004,le.avelength_jdb005,le.avelength_jdb006,le.avelength_jDO013,le.avelength_jDO014,le.avelength_jdb002,le.avelength_jdp016,le.avelength_lgc004,le.avelength_pro001,le.avelength_pro003,le.avelength_txc010,le.avelength_txc011,le.avelength_txb004_sign,le.avelength_txb004,le.avelength_txo013,le.avelength_txb002_sign,le.avelength_txb002,le.avelength_txp016,le.avelength_ucc001,le.avelength_ucc002,le.avelength_ucc003,le.avelength_intelliscore_plus,le.avelength_percentile_model,le.avelength_model_action,le.avelength_score_factor_1,le.avelength_score_factor_2,le.avelength_score_factor_3,le.avelength_score_factor_4,le.avelength_model_code,le.avelength_model_type,le.avelength_last_experian_inquiry_date,le.avelength_recent_high_credit_sign,le.avelength_recent_high_credit,le.avelength_median_credit_amount_sign,le.avelength_median_credit_amount,le.avelength_total_combined_trade_lines_count,le.avelength_dbt_of_combined_trade_totals,le.avelength_combined_trade_balance,le.avelength_aged_trade_lines,le.avelength_experian_credit_rating,le.avelength_quarter_1_average_dbt,le.avelength_quarter_2_average_dbt,le.avelength_quarter_3_average_dbt,le.avelength_quarter_4_average_dbt,le.avelength_quarter_5_average_dbt,le.avelength_combined_dbt,le.avelength_total_account_balance_sign,le.avelength_total_account_balance,le.avelength_combined_account_balance_sign,le.avelength_combined_account_balance,le.avelength_collection_count,le.avelength_atc021,le.avelength_atc022,le.avelength_atc023,le.avelength_atc024,le.avelength_atc025,le.avelength_last_activity_age_code,le.avelength_cottage_indicator,le.avelength_nonprofit_indicator,le.avelength_financial_stability_risk_score,le.avelength_fsr_risk_class,le.avelength_fsr_score_factor_1,le.avelength_fsr_score_factor_2,le.avelength_fsr_score_factor_3,le.avelength_fsr_score_factor_4,le.avelength_ip_score_change_sign,le.avelength_ip_score_change,le.avelength_fsr_score_change_sign,le.avelength_fsr_score_change,le.avelength_dba_name,le.avelength_clean_dba_name,le.avelength_clean_phone,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_recent_update_desc,le.avelength_years_in_business_desc,le.avelength_address_type_desc,le.avelength_employee_size_desc,le.avelength_annual_sales_size_desc,le.avelength_location_desc,le.avelength_primary_sic_code_industry_class_desc,le.avelength_business_type_desc,le.avelength_ownership_code_desc,le.avelength_ucc_data_indicator_desc,le.avelength_experian_credit_rating_desc,le.avelength_last_activity_age_desc,le.avelength_cottage_indicator_desc,le.avelength_nonprofit_indicator_desc,le.avelength_company_name,le.avelength_p_title,le.avelength_p_fname,le.avelength_p_mname,le.avelength_p_lname,le.avelength_p_name_suffix,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_source_rec_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 233, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.experian_bus_id),TRIM((SALT38.StrType)le.business_name),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_plus_4),TRIM((SALT38.StrType)le.carrier_route),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.msa_code),TRIM((SALT38.StrType)le.msa_description),TRIM((SALT38.StrType)le.establish_date),TRIM((SALT38.StrType)le.latest_reported_date),TRIM((SALT38.StrType)le.years_in_file),TRIM((SALT38.StrType)le.geo_code_latitude),TRIM((SALT38.StrType)le.geo_code_latitude_direction),TRIM((SALT38.StrType)le.geo_code_longitude),TRIM((SALT38.StrType)le.geo_code_longitude_direction),TRIM((SALT38.StrType)le.recent_update_code),TRIM((SALT38.StrType)le.years_in_business_code),TRIM((SALT38.StrType)le.year_business_started),TRIM((SALT38.StrType)le.months_in_file),TRIM((SALT38.StrType)le.address_type_code),TRIM((SALT38.StrType)le.estimated_number_of_employees),TRIM((SALT38.StrType)le.employee_size_code),TRIM((SALT38.StrType)le.estimated_annual_sales_amount_sign),TRIM((SALT38.StrType)le.estimated_annual_sales_amount),TRIM((SALT38.StrType)le.annual_sales_size_code),TRIM((SALT38.StrType)le.location_code),TRIM((SALT38.StrType)le.primary_sic_code_industry_classification),TRIM((SALT38.StrType)le.primary_sic_code_4_digit),TRIM((SALT38.StrType)le.primary_sic_code),TRIM((SALT38.StrType)le.second_sic_code),TRIM((SALT38.StrType)le.third_sic_code),TRIM((SALT38.StrType)le.fourth_sic_code),TRIM((SALT38.StrType)le.fifth_sic_code),TRIM((SALT38.StrType)le.sixth_sic_code),TRIM((SALT38.StrType)le.primary_naics_code),TRIM((SALT38.StrType)le.second_naics_code),TRIM((SALT38.StrType)le.third_naics_code),TRIM((SALT38.StrType)le.fourth_naics_code),TRIM((SALT38.StrType)le.executive_count),TRIM((SALT38.StrType)le.executive_last_name),TRIM((SALT38.StrType)le.executive_first_name),TRIM((SALT38.StrType)le.executive_middle_initial),TRIM((SALT38.StrType)le.executive_title),TRIM((SALT38.StrType)le.business_type),TRIM((SALT38.StrType)le.ownership_code),TRIM((SALT38.StrType)le.url),TRIM((SALT38.StrType)le.derogatory_indicator),TRIM((SALT38.StrType)le.recent_derogatory_filed_date),TRIM((SALT38.StrType)le.derogatory_liability_amount_sign),TRIM((SALT38.StrType)le.derogatory_liability_amount),TRIM((SALT38.StrType)le.ucc_data_indicator),TRIM((SALT38.StrType)le.ucc_count),TRIM((SALT38.StrType)le.number_of_legal_items),TRIM((SALT38.StrType)le.legal_balance_sign),TRIM((SALT38.StrType)le.legal_balance_amount),TRIM((SALT38.StrType)le.pmtkbankruptcy),TRIM((SALT38.StrType)le.pmtkjudgment),TRIM((SALT38.StrType)le.pmtktaxlien),TRIM((SALT38.StrType)le.pmtkpayment),TRIM((SALT38.StrType)le.bankruptcy_filed),TRIM((SALT38.StrType)le.number_of_derogatory_legal_items),TRIM((SALT38.StrType)le.lien_count),TRIM((SALT38.StrType)le.judgment_count),TRIM((SALT38.StrType)le.bkc006),TRIM((SALT38.StrType)le.bkc007),TRIM((SALT38.StrType)le.bkc008),TRIM((SALT38.StrType)le.bko009),TRIM((SALT38.StrType)le.bkb001_sign),TRIM((SALT38.StrType)le.bkb001),TRIM((SALT38.StrType)le.bkb003_sign),TRIM((SALT38.StrType)le.bkb003),TRIM((SALT38.StrType)le.bko010),TRIM((SALT38.StrType)le.bko011),TRIM((SALT38.StrType)le.jdc010),TRIM((SALT38.StrType)le.jdc011),TRIM((SALT38.StrType)le.jdc012),TRIM((SALT38.StrType)le.jdb004),TRIM((SALT38.StrType)le.jdb005),TRIM((SALT38.StrType)le.jdb006),TRIM((SALT38.StrType)le.jDO013),TRIM((SALT38.StrType)le.jDO014),TRIM((SALT38.StrType)le.jdb002),TRIM((SALT38.StrType)le.jdp016),TRIM((SALT38.StrType)le.lgc004),TRIM((SALT38.StrType)le.pro001),TRIM((SALT38.StrType)le.pro003),TRIM((SALT38.StrType)le.txc010),TRIM((SALT38.StrType)le.txc011),TRIM((SALT38.StrType)le.txb004_sign),TRIM((SALT38.StrType)le.txb004),TRIM((SALT38.StrType)le.txo013),TRIM((SALT38.StrType)le.txb002_sign),TRIM((SALT38.StrType)le.txb002),TRIM((SALT38.StrType)le.txp016),TRIM((SALT38.StrType)le.ucc001),TRIM((SALT38.StrType)le.ucc002),TRIM((SALT38.StrType)le.ucc003),TRIM((SALT38.StrType)le.intelliscore_plus),TRIM((SALT38.StrType)le.percentile_model),TRIM((SALT38.StrType)le.model_action),TRIM((SALT38.StrType)le.score_factor_1),TRIM((SALT38.StrType)le.score_factor_2),TRIM((SALT38.StrType)le.score_factor_3),TRIM((SALT38.StrType)le.score_factor_4),TRIM((SALT38.StrType)le.model_code),TRIM((SALT38.StrType)le.model_type),TRIM((SALT38.StrType)le.last_experian_inquiry_date),TRIM((SALT38.StrType)le.recent_high_credit_sign),TRIM((SALT38.StrType)le.recent_high_credit),TRIM((SALT38.StrType)le.median_credit_amount_sign),TRIM((SALT38.StrType)le.median_credit_amount),TRIM((SALT38.StrType)le.total_combined_trade_lines_count),TRIM((SALT38.StrType)le.dbt_of_combined_trade_totals),TRIM((SALT38.StrType)le.combined_trade_balance),TRIM((SALT38.StrType)le.aged_trade_lines),TRIM((SALT38.StrType)le.experian_credit_rating),TRIM((SALT38.StrType)le.quarter_1_average_dbt),TRIM((SALT38.StrType)le.quarter_2_average_dbt),TRIM((SALT38.StrType)le.quarter_3_average_dbt),TRIM((SALT38.StrType)le.quarter_4_average_dbt),TRIM((SALT38.StrType)le.quarter_5_average_dbt),TRIM((SALT38.StrType)le.combined_dbt),TRIM((SALT38.StrType)le.total_account_balance_sign),TRIM((SALT38.StrType)le.total_account_balance),TRIM((SALT38.StrType)le.combined_account_balance_sign),TRIM((SALT38.StrType)le.combined_account_balance),TRIM((SALT38.StrType)le.collection_count),TRIM((SALT38.StrType)le.atc021),TRIM((SALT38.StrType)le.atc022),TRIM((SALT38.StrType)le.atc023),TRIM((SALT38.StrType)le.atc024),TRIM((SALT38.StrType)le.atc025),TRIM((SALT38.StrType)le.last_activity_age_code),TRIM((SALT38.StrType)le.cottage_indicator),TRIM((SALT38.StrType)le.nonprofit_indicator),TRIM((SALT38.StrType)le.financial_stability_risk_score),TRIM((SALT38.StrType)le.fsr_risk_class),TRIM((SALT38.StrType)le.fsr_score_factor_1),TRIM((SALT38.StrType)le.fsr_score_factor_2),TRIM((SALT38.StrType)le.fsr_score_factor_3),TRIM((SALT38.StrType)le.fsr_score_factor_4),TRIM((SALT38.StrType)le.ip_score_change_sign),TRIM((SALT38.StrType)le.ip_score_change),TRIM((SALT38.StrType)le.fsr_score_change_sign),TRIM((SALT38.StrType)le.fsr_score_change),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.clean_dba_name),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.recent_update_desc),TRIM((SALT38.StrType)le.years_in_business_desc),TRIM((SALT38.StrType)le.address_type_desc),TRIM((SALT38.StrType)le.employee_size_desc),TRIM((SALT38.StrType)le.annual_sales_size_desc),TRIM((SALT38.StrType)le.location_desc),TRIM((SALT38.StrType)le.primary_sic_code_industry_class_desc),TRIM((SALT38.StrType)le.business_type_desc),TRIM((SALT38.StrType)le.ownership_code_desc),TRIM((SALT38.StrType)le.ucc_data_indicator_desc),TRIM((SALT38.StrType)le.experian_credit_rating_desc),TRIM((SALT38.StrType)le.last_activity_age_desc),TRIM((SALT38.StrType)le.cottage_indicator_desc),TRIM((SALT38.StrType)le.nonprofit_indicator_desc),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.p_title),TRIM((SALT38.StrType)le.p_fname),TRIM((SALT38.StrType)le.p_mname),TRIM((SALT38.StrType)le.p_lname),TRIM((SALT38.StrType)le.p_name_suffix),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,233,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 233);
  SELF.FldNo2 := 1 + (C % 233);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.experian_bus_id),TRIM((SALT38.StrType)le.business_name),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_plus_4),TRIM((SALT38.StrType)le.carrier_route),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.msa_code),TRIM((SALT38.StrType)le.msa_description),TRIM((SALT38.StrType)le.establish_date),TRIM((SALT38.StrType)le.latest_reported_date),TRIM((SALT38.StrType)le.years_in_file),TRIM((SALT38.StrType)le.geo_code_latitude),TRIM((SALT38.StrType)le.geo_code_latitude_direction),TRIM((SALT38.StrType)le.geo_code_longitude),TRIM((SALT38.StrType)le.geo_code_longitude_direction),TRIM((SALT38.StrType)le.recent_update_code),TRIM((SALT38.StrType)le.years_in_business_code),TRIM((SALT38.StrType)le.year_business_started),TRIM((SALT38.StrType)le.months_in_file),TRIM((SALT38.StrType)le.address_type_code),TRIM((SALT38.StrType)le.estimated_number_of_employees),TRIM((SALT38.StrType)le.employee_size_code),TRIM((SALT38.StrType)le.estimated_annual_sales_amount_sign),TRIM((SALT38.StrType)le.estimated_annual_sales_amount),TRIM((SALT38.StrType)le.annual_sales_size_code),TRIM((SALT38.StrType)le.location_code),TRIM((SALT38.StrType)le.primary_sic_code_industry_classification),TRIM((SALT38.StrType)le.primary_sic_code_4_digit),TRIM((SALT38.StrType)le.primary_sic_code),TRIM((SALT38.StrType)le.second_sic_code),TRIM((SALT38.StrType)le.third_sic_code),TRIM((SALT38.StrType)le.fourth_sic_code),TRIM((SALT38.StrType)le.fifth_sic_code),TRIM((SALT38.StrType)le.sixth_sic_code),TRIM((SALT38.StrType)le.primary_naics_code),TRIM((SALT38.StrType)le.second_naics_code),TRIM((SALT38.StrType)le.third_naics_code),TRIM((SALT38.StrType)le.fourth_naics_code),TRIM((SALT38.StrType)le.executive_count),TRIM((SALT38.StrType)le.executive_last_name),TRIM((SALT38.StrType)le.executive_first_name),TRIM((SALT38.StrType)le.executive_middle_initial),TRIM((SALT38.StrType)le.executive_title),TRIM((SALT38.StrType)le.business_type),TRIM((SALT38.StrType)le.ownership_code),TRIM((SALT38.StrType)le.url),TRIM((SALT38.StrType)le.derogatory_indicator),TRIM((SALT38.StrType)le.recent_derogatory_filed_date),TRIM((SALT38.StrType)le.derogatory_liability_amount_sign),TRIM((SALT38.StrType)le.derogatory_liability_amount),TRIM((SALT38.StrType)le.ucc_data_indicator),TRIM((SALT38.StrType)le.ucc_count),TRIM((SALT38.StrType)le.number_of_legal_items),TRIM((SALT38.StrType)le.legal_balance_sign),TRIM((SALT38.StrType)le.legal_balance_amount),TRIM((SALT38.StrType)le.pmtkbankruptcy),TRIM((SALT38.StrType)le.pmtkjudgment),TRIM((SALT38.StrType)le.pmtktaxlien),TRIM((SALT38.StrType)le.pmtkpayment),TRIM((SALT38.StrType)le.bankruptcy_filed),TRIM((SALT38.StrType)le.number_of_derogatory_legal_items),TRIM((SALT38.StrType)le.lien_count),TRIM((SALT38.StrType)le.judgment_count),TRIM((SALT38.StrType)le.bkc006),TRIM((SALT38.StrType)le.bkc007),TRIM((SALT38.StrType)le.bkc008),TRIM((SALT38.StrType)le.bko009),TRIM((SALT38.StrType)le.bkb001_sign),TRIM((SALT38.StrType)le.bkb001),TRIM((SALT38.StrType)le.bkb003_sign),TRIM((SALT38.StrType)le.bkb003),TRIM((SALT38.StrType)le.bko010),TRIM((SALT38.StrType)le.bko011),TRIM((SALT38.StrType)le.jdc010),TRIM((SALT38.StrType)le.jdc011),TRIM((SALT38.StrType)le.jdc012),TRIM((SALT38.StrType)le.jdb004),TRIM((SALT38.StrType)le.jdb005),TRIM((SALT38.StrType)le.jdb006),TRIM((SALT38.StrType)le.jDO013),TRIM((SALT38.StrType)le.jDO014),TRIM((SALT38.StrType)le.jdb002),TRIM((SALT38.StrType)le.jdp016),TRIM((SALT38.StrType)le.lgc004),TRIM((SALT38.StrType)le.pro001),TRIM((SALT38.StrType)le.pro003),TRIM((SALT38.StrType)le.txc010),TRIM((SALT38.StrType)le.txc011),TRIM((SALT38.StrType)le.txb004_sign),TRIM((SALT38.StrType)le.txb004),TRIM((SALT38.StrType)le.txo013),TRIM((SALT38.StrType)le.txb002_sign),TRIM((SALT38.StrType)le.txb002),TRIM((SALT38.StrType)le.txp016),TRIM((SALT38.StrType)le.ucc001),TRIM((SALT38.StrType)le.ucc002),TRIM((SALT38.StrType)le.ucc003),TRIM((SALT38.StrType)le.intelliscore_plus),TRIM((SALT38.StrType)le.percentile_model),TRIM((SALT38.StrType)le.model_action),TRIM((SALT38.StrType)le.score_factor_1),TRIM((SALT38.StrType)le.score_factor_2),TRIM((SALT38.StrType)le.score_factor_3),TRIM((SALT38.StrType)le.score_factor_4),TRIM((SALT38.StrType)le.model_code),TRIM((SALT38.StrType)le.model_type),TRIM((SALT38.StrType)le.last_experian_inquiry_date),TRIM((SALT38.StrType)le.recent_high_credit_sign),TRIM((SALT38.StrType)le.recent_high_credit),TRIM((SALT38.StrType)le.median_credit_amount_sign),TRIM((SALT38.StrType)le.median_credit_amount),TRIM((SALT38.StrType)le.total_combined_trade_lines_count),TRIM((SALT38.StrType)le.dbt_of_combined_trade_totals),TRIM((SALT38.StrType)le.combined_trade_balance),TRIM((SALT38.StrType)le.aged_trade_lines),TRIM((SALT38.StrType)le.experian_credit_rating),TRIM((SALT38.StrType)le.quarter_1_average_dbt),TRIM((SALT38.StrType)le.quarter_2_average_dbt),TRIM((SALT38.StrType)le.quarter_3_average_dbt),TRIM((SALT38.StrType)le.quarter_4_average_dbt),TRIM((SALT38.StrType)le.quarter_5_average_dbt),TRIM((SALT38.StrType)le.combined_dbt),TRIM((SALT38.StrType)le.total_account_balance_sign),TRIM((SALT38.StrType)le.total_account_balance),TRIM((SALT38.StrType)le.combined_account_balance_sign),TRIM((SALT38.StrType)le.combined_account_balance),TRIM((SALT38.StrType)le.collection_count),TRIM((SALT38.StrType)le.atc021),TRIM((SALT38.StrType)le.atc022),TRIM((SALT38.StrType)le.atc023),TRIM((SALT38.StrType)le.atc024),TRIM((SALT38.StrType)le.atc025),TRIM((SALT38.StrType)le.last_activity_age_code),TRIM((SALT38.StrType)le.cottage_indicator),TRIM((SALT38.StrType)le.nonprofit_indicator),TRIM((SALT38.StrType)le.financial_stability_risk_score),TRIM((SALT38.StrType)le.fsr_risk_class),TRIM((SALT38.StrType)le.fsr_score_factor_1),TRIM((SALT38.StrType)le.fsr_score_factor_2),TRIM((SALT38.StrType)le.fsr_score_factor_3),TRIM((SALT38.StrType)le.fsr_score_factor_4),TRIM((SALT38.StrType)le.ip_score_change_sign),TRIM((SALT38.StrType)le.ip_score_change),TRIM((SALT38.StrType)le.fsr_score_change_sign),TRIM((SALT38.StrType)le.fsr_score_change),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.clean_dba_name),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.recent_update_desc),TRIM((SALT38.StrType)le.years_in_business_desc),TRIM((SALT38.StrType)le.address_type_desc),TRIM((SALT38.StrType)le.employee_size_desc),TRIM((SALT38.StrType)le.annual_sales_size_desc),TRIM((SALT38.StrType)le.location_desc),TRIM((SALT38.StrType)le.primary_sic_code_industry_class_desc),TRIM((SALT38.StrType)le.business_type_desc),TRIM((SALT38.StrType)le.ownership_code_desc),TRIM((SALT38.StrType)le.ucc_data_indicator_desc),TRIM((SALT38.StrType)le.experian_credit_rating_desc),TRIM((SALT38.StrType)le.last_activity_age_desc),TRIM((SALT38.StrType)le.cottage_indicator_desc),TRIM((SALT38.StrType)le.nonprofit_indicator_desc),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.p_title),TRIM((SALT38.StrType)le.p_fname),TRIM((SALT38.StrType)le.p_mname),TRIM((SALT38.StrType)le.p_lname),TRIM((SALT38.StrType)le.p_name_suffix),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.experian_bus_id),TRIM((SALT38.StrType)le.business_name),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_plus_4),TRIM((SALT38.StrType)le.carrier_route),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.msa_code),TRIM((SALT38.StrType)le.msa_description),TRIM((SALT38.StrType)le.establish_date),TRIM((SALT38.StrType)le.latest_reported_date),TRIM((SALT38.StrType)le.years_in_file),TRIM((SALT38.StrType)le.geo_code_latitude),TRIM((SALT38.StrType)le.geo_code_latitude_direction),TRIM((SALT38.StrType)le.geo_code_longitude),TRIM((SALT38.StrType)le.geo_code_longitude_direction),TRIM((SALT38.StrType)le.recent_update_code),TRIM((SALT38.StrType)le.years_in_business_code),TRIM((SALT38.StrType)le.year_business_started),TRIM((SALT38.StrType)le.months_in_file),TRIM((SALT38.StrType)le.address_type_code),TRIM((SALT38.StrType)le.estimated_number_of_employees),TRIM((SALT38.StrType)le.employee_size_code),TRIM((SALT38.StrType)le.estimated_annual_sales_amount_sign),TRIM((SALT38.StrType)le.estimated_annual_sales_amount),TRIM((SALT38.StrType)le.annual_sales_size_code),TRIM((SALT38.StrType)le.location_code),TRIM((SALT38.StrType)le.primary_sic_code_industry_classification),TRIM((SALT38.StrType)le.primary_sic_code_4_digit),TRIM((SALT38.StrType)le.primary_sic_code),TRIM((SALT38.StrType)le.second_sic_code),TRIM((SALT38.StrType)le.third_sic_code),TRIM((SALT38.StrType)le.fourth_sic_code),TRIM((SALT38.StrType)le.fifth_sic_code),TRIM((SALT38.StrType)le.sixth_sic_code),TRIM((SALT38.StrType)le.primary_naics_code),TRIM((SALT38.StrType)le.second_naics_code),TRIM((SALT38.StrType)le.third_naics_code),TRIM((SALT38.StrType)le.fourth_naics_code),TRIM((SALT38.StrType)le.executive_count),TRIM((SALT38.StrType)le.executive_last_name),TRIM((SALT38.StrType)le.executive_first_name),TRIM((SALT38.StrType)le.executive_middle_initial),TRIM((SALT38.StrType)le.executive_title),TRIM((SALT38.StrType)le.business_type),TRIM((SALT38.StrType)le.ownership_code),TRIM((SALT38.StrType)le.url),TRIM((SALT38.StrType)le.derogatory_indicator),TRIM((SALT38.StrType)le.recent_derogatory_filed_date),TRIM((SALT38.StrType)le.derogatory_liability_amount_sign),TRIM((SALT38.StrType)le.derogatory_liability_amount),TRIM((SALT38.StrType)le.ucc_data_indicator),TRIM((SALT38.StrType)le.ucc_count),TRIM((SALT38.StrType)le.number_of_legal_items),TRIM((SALT38.StrType)le.legal_balance_sign),TRIM((SALT38.StrType)le.legal_balance_amount),TRIM((SALT38.StrType)le.pmtkbankruptcy),TRIM((SALT38.StrType)le.pmtkjudgment),TRIM((SALT38.StrType)le.pmtktaxlien),TRIM((SALT38.StrType)le.pmtkpayment),TRIM((SALT38.StrType)le.bankruptcy_filed),TRIM((SALT38.StrType)le.number_of_derogatory_legal_items),TRIM((SALT38.StrType)le.lien_count),TRIM((SALT38.StrType)le.judgment_count),TRIM((SALT38.StrType)le.bkc006),TRIM((SALT38.StrType)le.bkc007),TRIM((SALT38.StrType)le.bkc008),TRIM((SALT38.StrType)le.bko009),TRIM((SALT38.StrType)le.bkb001_sign),TRIM((SALT38.StrType)le.bkb001),TRIM((SALT38.StrType)le.bkb003_sign),TRIM((SALT38.StrType)le.bkb003),TRIM((SALT38.StrType)le.bko010),TRIM((SALT38.StrType)le.bko011),TRIM((SALT38.StrType)le.jdc010),TRIM((SALT38.StrType)le.jdc011),TRIM((SALT38.StrType)le.jdc012),TRIM((SALT38.StrType)le.jdb004),TRIM((SALT38.StrType)le.jdb005),TRIM((SALT38.StrType)le.jdb006),TRIM((SALT38.StrType)le.jDO013),TRIM((SALT38.StrType)le.jDO014),TRIM((SALT38.StrType)le.jdb002),TRIM((SALT38.StrType)le.jdp016),TRIM((SALT38.StrType)le.lgc004),TRIM((SALT38.StrType)le.pro001),TRIM((SALT38.StrType)le.pro003),TRIM((SALT38.StrType)le.txc010),TRIM((SALT38.StrType)le.txc011),TRIM((SALT38.StrType)le.txb004_sign),TRIM((SALT38.StrType)le.txb004),TRIM((SALT38.StrType)le.txo013),TRIM((SALT38.StrType)le.txb002_sign),TRIM((SALT38.StrType)le.txb002),TRIM((SALT38.StrType)le.txp016),TRIM((SALT38.StrType)le.ucc001),TRIM((SALT38.StrType)le.ucc002),TRIM((SALT38.StrType)le.ucc003),TRIM((SALT38.StrType)le.intelliscore_plus),TRIM((SALT38.StrType)le.percentile_model),TRIM((SALT38.StrType)le.model_action),TRIM((SALT38.StrType)le.score_factor_1),TRIM((SALT38.StrType)le.score_factor_2),TRIM((SALT38.StrType)le.score_factor_3),TRIM((SALT38.StrType)le.score_factor_4),TRIM((SALT38.StrType)le.model_code),TRIM((SALT38.StrType)le.model_type),TRIM((SALT38.StrType)le.last_experian_inquiry_date),TRIM((SALT38.StrType)le.recent_high_credit_sign),TRIM((SALT38.StrType)le.recent_high_credit),TRIM((SALT38.StrType)le.median_credit_amount_sign),TRIM((SALT38.StrType)le.median_credit_amount),TRIM((SALT38.StrType)le.total_combined_trade_lines_count),TRIM((SALT38.StrType)le.dbt_of_combined_trade_totals),TRIM((SALT38.StrType)le.combined_trade_balance),TRIM((SALT38.StrType)le.aged_trade_lines),TRIM((SALT38.StrType)le.experian_credit_rating),TRIM((SALT38.StrType)le.quarter_1_average_dbt),TRIM((SALT38.StrType)le.quarter_2_average_dbt),TRIM((SALT38.StrType)le.quarter_3_average_dbt),TRIM((SALT38.StrType)le.quarter_4_average_dbt),TRIM((SALT38.StrType)le.quarter_5_average_dbt),TRIM((SALT38.StrType)le.combined_dbt),TRIM((SALT38.StrType)le.total_account_balance_sign),TRIM((SALT38.StrType)le.total_account_balance),TRIM((SALT38.StrType)le.combined_account_balance_sign),TRIM((SALT38.StrType)le.combined_account_balance),TRIM((SALT38.StrType)le.collection_count),TRIM((SALT38.StrType)le.atc021),TRIM((SALT38.StrType)le.atc022),TRIM((SALT38.StrType)le.atc023),TRIM((SALT38.StrType)le.atc024),TRIM((SALT38.StrType)le.atc025),TRIM((SALT38.StrType)le.last_activity_age_code),TRIM((SALT38.StrType)le.cottage_indicator),TRIM((SALT38.StrType)le.nonprofit_indicator),TRIM((SALT38.StrType)le.financial_stability_risk_score),TRIM((SALT38.StrType)le.fsr_risk_class),TRIM((SALT38.StrType)le.fsr_score_factor_1),TRIM((SALT38.StrType)le.fsr_score_factor_2),TRIM((SALT38.StrType)le.fsr_score_factor_3),TRIM((SALT38.StrType)le.fsr_score_factor_4),TRIM((SALT38.StrType)le.ip_score_change_sign),TRIM((SALT38.StrType)le.ip_score_change),TRIM((SALT38.StrType)le.fsr_score_change_sign),TRIM((SALT38.StrType)le.fsr_score_change),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.clean_dba_name),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.recent_update_desc),TRIM((SALT38.StrType)le.years_in_business_desc),TRIM((SALT38.StrType)le.address_type_desc),TRIM((SALT38.StrType)le.employee_size_desc),TRIM((SALT38.StrType)le.annual_sales_size_desc),TRIM((SALT38.StrType)le.location_desc),TRIM((SALT38.StrType)le.primary_sic_code_industry_class_desc),TRIM((SALT38.StrType)le.business_type_desc),TRIM((SALT38.StrType)le.ownership_code_desc),TRIM((SALT38.StrType)le.ucc_data_indicator_desc),TRIM((SALT38.StrType)le.experian_credit_rating_desc),TRIM((SALT38.StrType)le.last_activity_age_desc),TRIM((SALT38.StrType)le.cottage_indicator_desc),TRIM((SALT38.StrType)le.nonprofit_indicator_desc),TRIM((SALT38.StrType)le.company_name),TRIM((SALT38.StrType)le.p_title),TRIM((SALT38.StrType)le.p_fname),TRIM((SALT38.StrType)le.p_mname),TRIM((SALT38.StrType)le.p_lname),TRIM((SALT38.StrType)le.p_name_suffix),IF (le.raw_aid <> 0,TRIM((SALT38.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT38.StrType)le.ace_aid), ''),TRIM((SALT38.StrType)le.prep_addr_line1),TRIM((SALT38.StrType)le.prep_addr_line_last),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),233*233,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{25,'dt_first_seen'}
      ,{26,'dt_last_seen'}
      ,{27,'dt_vendor_first_reported'}
      ,{28,'dt_vendor_last_reported'}
      ,{29,'experian_bus_id'}
      ,{30,'business_name'}
      ,{31,'address'}
      ,{32,'city'}
      ,{33,'state'}
      ,{34,'zip_code'}
      ,{35,'zip_plus_4'}
      ,{36,'carrier_route'}
      ,{37,'county_code'}
      ,{38,'county_name'}
      ,{39,'phone_number'}
      ,{40,'msa_code'}
      ,{41,'msa_description'}
      ,{42,'establish_date'}
      ,{43,'latest_reported_date'}
      ,{44,'years_in_file'}
      ,{45,'geo_code_latitude'}
      ,{46,'geo_code_latitude_direction'}
      ,{47,'geo_code_longitude'}
      ,{48,'geo_code_longitude_direction'}
      ,{49,'recent_update_code'}
      ,{50,'years_in_business_code'}
      ,{51,'year_business_started'}
      ,{52,'months_in_file'}
      ,{53,'address_type_code'}
      ,{54,'estimated_number_of_employees'}
      ,{55,'employee_size_code'}
      ,{56,'estimated_annual_sales_amount_sign'}
      ,{57,'estimated_annual_sales_amount'}
      ,{58,'annual_sales_size_code'}
      ,{59,'location_code'}
      ,{60,'primary_sic_code_industry_classification'}
      ,{61,'primary_sic_code_4_digit'}
      ,{62,'primary_sic_code'}
      ,{63,'second_sic_code'}
      ,{64,'third_sic_code'}
      ,{65,'fourth_sic_code'}
      ,{66,'fifth_sic_code'}
      ,{67,'sixth_sic_code'}
      ,{68,'primary_naics_code'}
      ,{69,'second_naics_code'}
      ,{70,'third_naics_code'}
      ,{71,'fourth_naics_code'}
      ,{72,'executive_count'}
      ,{73,'executive_last_name'}
      ,{74,'executive_first_name'}
      ,{75,'executive_middle_initial'}
      ,{76,'executive_title'}
      ,{77,'business_type'}
      ,{78,'ownership_code'}
      ,{79,'url'}
      ,{80,'derogatory_indicator'}
      ,{81,'recent_derogatory_filed_date'}
      ,{82,'derogatory_liability_amount_sign'}
      ,{83,'derogatory_liability_amount'}
      ,{84,'ucc_data_indicator'}
      ,{85,'ucc_count'}
      ,{86,'number_of_legal_items'}
      ,{87,'legal_balance_sign'}
      ,{88,'legal_balance_amount'}
      ,{89,'pmtkbankruptcy'}
      ,{90,'pmtkjudgment'}
      ,{91,'pmtktaxlien'}
      ,{92,'pmtkpayment'}
      ,{93,'bankruptcy_filed'}
      ,{94,'number_of_derogatory_legal_items'}
      ,{95,'lien_count'}
      ,{96,'judgment_count'}
      ,{97,'bkc006'}
      ,{98,'bkc007'}
      ,{99,'bkc008'}
      ,{100,'bko009'}
      ,{101,'bkb001_sign'}
      ,{102,'bkb001'}
      ,{103,'bkb003_sign'}
      ,{104,'bkb003'}
      ,{105,'bko010'}
      ,{106,'bko011'}
      ,{107,'jdc010'}
      ,{108,'jdc011'}
      ,{109,'jdc012'}
      ,{110,'jdb004'}
      ,{111,'jdb005'}
      ,{112,'jdb006'}
      ,{113,'jDO013'}
      ,{114,'jDO014'}
      ,{115,'jdb002'}
      ,{116,'jdp016'}
      ,{117,'lgc004'}
      ,{118,'pro001'}
      ,{119,'pro003'}
      ,{120,'txc010'}
      ,{121,'txc011'}
      ,{122,'txb004_sign'}
      ,{123,'txb004'}
      ,{124,'txo013'}
      ,{125,'txb002_sign'}
      ,{126,'txb002'}
      ,{127,'txp016'}
      ,{128,'ucc001'}
      ,{129,'ucc002'}
      ,{130,'ucc003'}
      ,{131,'intelliscore_plus'}
      ,{132,'percentile_model'}
      ,{133,'model_action'}
      ,{134,'score_factor_1'}
      ,{135,'score_factor_2'}
      ,{136,'score_factor_3'}
      ,{137,'score_factor_4'}
      ,{138,'model_code'}
      ,{139,'model_type'}
      ,{140,'last_experian_inquiry_date'}
      ,{141,'recent_high_credit_sign'}
      ,{142,'recent_high_credit'}
      ,{143,'median_credit_amount_sign'}
      ,{144,'median_credit_amount'}
      ,{145,'total_combined_trade_lines_count'}
      ,{146,'dbt_of_combined_trade_totals'}
      ,{147,'combined_trade_balance'}
      ,{148,'aged_trade_lines'}
      ,{149,'experian_credit_rating'}
      ,{150,'quarter_1_average_dbt'}
      ,{151,'quarter_2_average_dbt'}
      ,{152,'quarter_3_average_dbt'}
      ,{153,'quarter_4_average_dbt'}
      ,{154,'quarter_5_average_dbt'}
      ,{155,'combined_dbt'}
      ,{156,'total_account_balance_sign'}
      ,{157,'total_account_balance'}
      ,{158,'combined_account_balance_sign'}
      ,{159,'combined_account_balance'}
      ,{160,'collection_count'}
      ,{161,'atc021'}
      ,{162,'atc022'}
      ,{163,'atc023'}
      ,{164,'atc024'}
      ,{165,'atc025'}
      ,{166,'last_activity_age_code'}
      ,{167,'cottage_indicator'}
      ,{168,'nonprofit_indicator'}
      ,{169,'financial_stability_risk_score'}
      ,{170,'fsr_risk_class'}
      ,{171,'fsr_score_factor_1'}
      ,{172,'fsr_score_factor_2'}
      ,{173,'fsr_score_factor_3'}
      ,{174,'fsr_score_factor_4'}
      ,{175,'ip_score_change_sign'}
      ,{176,'ip_score_change'}
      ,{177,'fsr_score_change_sign'}
      ,{178,'fsr_score_change'}
      ,{179,'dba_name'}
      ,{180,'clean_dba_name'}
      ,{181,'clean_phone'}
      ,{182,'prim_range'}
      ,{183,'predir'}
      ,{184,'prim_name'}
      ,{185,'addr_suffix'}
      ,{186,'postdir'}
      ,{187,'unit_desig'}
      ,{188,'sec_range'}
      ,{189,'p_city_name'}
      ,{190,'v_city_name'}
      ,{191,'st'}
      ,{192,'zip'}
      ,{193,'zip4'}
      ,{194,'cart'}
      ,{195,'cr_sort_sz'}
      ,{196,'lot'}
      ,{197,'lot_order'}
      ,{198,'dbpc'}
      ,{199,'chk_digit'}
      ,{200,'rec_type'}
      ,{201,'fips_state'}
      ,{202,'fips_county'}
      ,{203,'geo_lat'}
      ,{204,'geo_long'}
      ,{205,'msa'}
      ,{206,'geo_blk'}
      ,{207,'geo_match'}
      ,{208,'err_stat'}
      ,{209,'recent_update_desc'}
      ,{210,'years_in_business_desc'}
      ,{211,'address_type_desc'}
      ,{212,'employee_size_desc'}
      ,{213,'annual_sales_size_desc'}
      ,{214,'location_desc'}
      ,{215,'primary_sic_code_industry_class_desc'}
      ,{216,'business_type_desc'}
      ,{217,'ownership_code_desc'}
      ,{218,'ucc_data_indicator_desc'}
      ,{219,'experian_credit_rating_desc'}
      ,{220,'last_activity_age_desc'}
      ,{221,'cottage_indicator_desc'}
      ,{222,'nonprofit_indicator_desc'}
      ,{223,'company_name'}
      ,{224,'p_title'}
      ,{225,'p_fname'}
      ,{226,'p_mname'}
      ,{227,'p_lname'}
      ,{228,'p_name_suffix'}
      ,{229,'raw_aid'}
      ,{230,'ace_aid'}
      ,{231,'prep_addr_line1'}
      ,{232,'prep_addr_line_last'}
      ,{233,'source_rec_id'}],SALT38.MAC_Character_Counts.Field_Identification);
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
    Base_Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_experian_bus_id((SALT38.StrType)le.experian_bus_id),
    Base_Fields.InValid_business_name((SALT38.StrType)le.business_name),
    Base_Fields.InValid_address((SALT38.StrType)le.address),
    Base_Fields.InValid_city((SALT38.StrType)le.city),
    Base_Fields.InValid_state((SALT38.StrType)le.state),
    Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Base_Fields.InValid_zip_plus_4((SALT38.StrType)le.zip_plus_4),
    Base_Fields.InValid_carrier_route((SALT38.StrType)le.carrier_route),
    Base_Fields.InValid_county_code((SALT38.StrType)le.county_code),
    Base_Fields.InValid_county_name((SALT38.StrType)le.county_name),
    Base_Fields.InValid_phone_number((SALT38.StrType)le.phone_number),
    Base_Fields.InValid_msa_code((SALT38.StrType)le.msa_code),
    Base_Fields.InValid_msa_description((SALT38.StrType)le.msa_description),
    Base_Fields.InValid_establish_date((SALT38.StrType)le.establish_date),
    Base_Fields.InValid_latest_reported_date((SALT38.StrType)le.latest_reported_date),
    Base_Fields.InValid_years_in_file((SALT38.StrType)le.years_in_file),
    Base_Fields.InValid_geo_code_latitude((SALT38.StrType)le.geo_code_latitude),
    Base_Fields.InValid_geo_code_latitude_direction((SALT38.StrType)le.geo_code_latitude_direction),
    Base_Fields.InValid_geo_code_longitude((SALT38.StrType)le.geo_code_longitude),
    Base_Fields.InValid_geo_code_longitude_direction((SALT38.StrType)le.geo_code_longitude_direction),
    Base_Fields.InValid_recent_update_code((SALT38.StrType)le.recent_update_code),
    Base_Fields.InValid_years_in_business_code((SALT38.StrType)le.years_in_business_code),
    Base_Fields.InValid_year_business_started((SALT38.StrType)le.year_business_started),
    Base_Fields.InValid_months_in_file((SALT38.StrType)le.months_in_file),
    Base_Fields.InValid_address_type_code((SALT38.StrType)le.address_type_code),
    Base_Fields.InValid_estimated_number_of_employees((SALT38.StrType)le.estimated_number_of_employees),
    Base_Fields.InValid_employee_size_code((SALT38.StrType)le.employee_size_code),
    Base_Fields.InValid_estimated_annual_sales_amount_sign((SALT38.StrType)le.estimated_annual_sales_amount_sign),
    Base_Fields.InValid_estimated_annual_sales_amount((SALT38.StrType)le.estimated_annual_sales_amount),
    Base_Fields.InValid_annual_sales_size_code((SALT38.StrType)le.annual_sales_size_code),
    Base_Fields.InValid_location_code((SALT38.StrType)le.location_code),
    Base_Fields.InValid_primary_sic_code_industry_classification((SALT38.StrType)le.primary_sic_code_industry_classification),
    Base_Fields.InValid_primary_sic_code_4_digit((SALT38.StrType)le.primary_sic_code_4_digit),
    Base_Fields.InValid_primary_sic_code((SALT38.StrType)le.primary_sic_code),
    Base_Fields.InValid_second_sic_code((SALT38.StrType)le.second_sic_code),
    Base_Fields.InValid_third_sic_code((SALT38.StrType)le.third_sic_code),
    Base_Fields.InValid_fourth_sic_code((SALT38.StrType)le.fourth_sic_code),
    Base_Fields.InValid_fifth_sic_code((SALT38.StrType)le.fifth_sic_code),
    Base_Fields.InValid_sixth_sic_code((SALT38.StrType)le.sixth_sic_code),
    Base_Fields.InValid_primary_naics_code((SALT38.StrType)le.primary_naics_code),
    Base_Fields.InValid_second_naics_code((SALT38.StrType)le.second_naics_code),
    Base_Fields.InValid_third_naics_code((SALT38.StrType)le.third_naics_code),
    Base_Fields.InValid_fourth_naics_code((SALT38.StrType)le.fourth_naics_code),
    Base_Fields.InValid_executive_count((SALT38.StrType)le.executive_count),
    Base_Fields.InValid_executive_last_name((SALT38.StrType)le.executive_last_name),
    Base_Fields.InValid_executive_first_name((SALT38.StrType)le.executive_first_name),
    Base_Fields.InValid_executive_middle_initial((SALT38.StrType)le.executive_middle_initial),
    Base_Fields.InValid_executive_title((SALT38.StrType)le.executive_title),
    Base_Fields.InValid_business_type((SALT38.StrType)le.business_type),
    Base_Fields.InValid_ownership_code((SALT38.StrType)le.ownership_code),
    Base_Fields.InValid_url((SALT38.StrType)le.url),
    Base_Fields.InValid_derogatory_indicator((SALT38.StrType)le.derogatory_indicator),
    Base_Fields.InValid_recent_derogatory_filed_date((SALT38.StrType)le.recent_derogatory_filed_date),
    Base_Fields.InValid_derogatory_liability_amount_sign((SALT38.StrType)le.derogatory_liability_amount_sign),
    Base_Fields.InValid_derogatory_liability_amount((SALT38.StrType)le.derogatory_liability_amount),
    Base_Fields.InValid_ucc_data_indicator((SALT38.StrType)le.ucc_data_indicator),
    Base_Fields.InValid_ucc_count((SALT38.StrType)le.ucc_count),
    Base_Fields.InValid_number_of_legal_items((SALT38.StrType)le.number_of_legal_items),
    Base_Fields.InValid_legal_balance_sign((SALT38.StrType)le.legal_balance_sign),
    Base_Fields.InValid_legal_balance_amount((SALT38.StrType)le.legal_balance_amount),
    Base_Fields.InValid_pmtkbankruptcy((SALT38.StrType)le.pmtkbankruptcy),
    Base_Fields.InValid_pmtkjudgment((SALT38.StrType)le.pmtkjudgment),
    Base_Fields.InValid_pmtktaxlien((SALT38.StrType)le.pmtktaxlien),
    Base_Fields.InValid_pmtkpayment((SALT38.StrType)le.pmtkpayment),
    Base_Fields.InValid_bankruptcy_filed((SALT38.StrType)le.bankruptcy_filed),
    Base_Fields.InValid_number_of_derogatory_legal_items((SALT38.StrType)le.number_of_derogatory_legal_items),
    Base_Fields.InValid_lien_count((SALT38.StrType)le.lien_count),
    Base_Fields.InValid_judgment_count((SALT38.StrType)le.judgment_count),
    Base_Fields.InValid_bkc006((SALT38.StrType)le.bkc006),
    Base_Fields.InValid_bkc007((SALT38.StrType)le.bkc007),
    Base_Fields.InValid_bkc008((SALT38.StrType)le.bkc008),
    Base_Fields.InValid_bko009((SALT38.StrType)le.bko009),
    Base_Fields.InValid_bkb001_sign((SALT38.StrType)le.bkb001_sign),
    Base_Fields.InValid_bkb001((SALT38.StrType)le.bkb001),
    Base_Fields.InValid_bkb003_sign((SALT38.StrType)le.bkb003_sign),
    Base_Fields.InValid_bkb003((SALT38.StrType)le.bkb003),
    Base_Fields.InValid_bko010((SALT38.StrType)le.bko010),
    Base_Fields.InValid_bko011((SALT38.StrType)le.bko011),
    Base_Fields.InValid_jdc010((SALT38.StrType)le.jdc010),
    Base_Fields.InValid_jdc011((SALT38.StrType)le.jdc011),
    Base_Fields.InValid_jdc012((SALT38.StrType)le.jdc012),
    Base_Fields.InValid_jdb004((SALT38.StrType)le.jdb004),
    Base_Fields.InValid_jdb005((SALT38.StrType)le.jdb005),
    Base_Fields.InValid_jdb006((SALT38.StrType)le.jdb006),
    Base_Fields.InValid_jDO013((SALT38.StrType)le.jDO013),
    Base_Fields.InValid_jDO014((SALT38.StrType)le.jDO014),
    Base_Fields.InValid_jdb002((SALT38.StrType)le.jdb002),
    Base_Fields.InValid_jdp016((SALT38.StrType)le.jdp016),
    Base_Fields.InValid_lgc004((SALT38.StrType)le.lgc004),
    Base_Fields.InValid_pro001((SALT38.StrType)le.pro001),
    Base_Fields.InValid_pro003((SALT38.StrType)le.pro003),
    Base_Fields.InValid_txc010((SALT38.StrType)le.txc010),
    Base_Fields.InValid_txc011((SALT38.StrType)le.txc011),
    Base_Fields.InValid_txb004_sign((SALT38.StrType)le.txb004_sign),
    Base_Fields.InValid_txb004((SALT38.StrType)le.txb004),
    Base_Fields.InValid_txo013((SALT38.StrType)le.txo013),
    Base_Fields.InValid_txb002_sign((SALT38.StrType)le.txb002_sign),
    Base_Fields.InValid_txb002((SALT38.StrType)le.txb002),
    Base_Fields.InValid_txp016((SALT38.StrType)le.txp016),
    Base_Fields.InValid_ucc001((SALT38.StrType)le.ucc001),
    Base_Fields.InValid_ucc002((SALT38.StrType)le.ucc002),
    Base_Fields.InValid_ucc003((SALT38.StrType)le.ucc003),
    Base_Fields.InValid_intelliscore_plus((SALT38.StrType)le.intelliscore_plus),
    Base_Fields.InValid_percentile_model((SALT38.StrType)le.percentile_model),
    Base_Fields.InValid_model_action((SALT38.StrType)le.model_action),
    Base_Fields.InValid_score_factor_1((SALT38.StrType)le.score_factor_1),
    Base_Fields.InValid_score_factor_2((SALT38.StrType)le.score_factor_2),
    Base_Fields.InValid_score_factor_3((SALT38.StrType)le.score_factor_3),
    Base_Fields.InValid_score_factor_4((SALT38.StrType)le.score_factor_4),
    Base_Fields.InValid_model_code((SALT38.StrType)le.model_code),
    Base_Fields.InValid_model_type((SALT38.StrType)le.model_type),
    Base_Fields.InValid_last_experian_inquiry_date((SALT38.StrType)le.last_experian_inquiry_date),
    Base_Fields.InValid_recent_high_credit_sign((SALT38.StrType)le.recent_high_credit_sign),
    Base_Fields.InValid_recent_high_credit((SALT38.StrType)le.recent_high_credit),
    Base_Fields.InValid_median_credit_amount_sign((SALT38.StrType)le.median_credit_amount_sign),
    Base_Fields.InValid_median_credit_amount((SALT38.StrType)le.median_credit_amount),
    Base_Fields.InValid_total_combined_trade_lines_count((SALT38.StrType)le.total_combined_trade_lines_count),
    Base_Fields.InValid_dbt_of_combined_trade_totals((SALT38.StrType)le.dbt_of_combined_trade_totals),
    Base_Fields.InValid_combined_trade_balance((SALT38.StrType)le.combined_trade_balance),
    Base_Fields.InValid_aged_trade_lines((SALT38.StrType)le.aged_trade_lines),
    Base_Fields.InValid_experian_credit_rating((SALT38.StrType)le.experian_credit_rating),
    Base_Fields.InValid_quarter_1_average_dbt((SALT38.StrType)le.quarter_1_average_dbt),
    Base_Fields.InValid_quarter_2_average_dbt((SALT38.StrType)le.quarter_2_average_dbt),
    Base_Fields.InValid_quarter_3_average_dbt((SALT38.StrType)le.quarter_3_average_dbt),
    Base_Fields.InValid_quarter_4_average_dbt((SALT38.StrType)le.quarter_4_average_dbt),
    Base_Fields.InValid_quarter_5_average_dbt((SALT38.StrType)le.quarter_5_average_dbt),
    Base_Fields.InValid_combined_dbt((SALT38.StrType)le.combined_dbt),
    Base_Fields.InValid_total_account_balance_sign((SALT38.StrType)le.total_account_balance_sign),
    Base_Fields.InValid_total_account_balance((SALT38.StrType)le.total_account_balance),
    Base_Fields.InValid_combined_account_balance_sign((SALT38.StrType)le.combined_account_balance_sign),
    Base_Fields.InValid_combined_account_balance((SALT38.StrType)le.combined_account_balance),
    Base_Fields.InValid_collection_count((SALT38.StrType)le.collection_count),
    Base_Fields.InValid_atc021((SALT38.StrType)le.atc021),
    Base_Fields.InValid_atc022((SALT38.StrType)le.atc022),
    Base_Fields.InValid_atc023((SALT38.StrType)le.atc023),
    Base_Fields.InValid_atc024((SALT38.StrType)le.atc024),
    Base_Fields.InValid_atc025((SALT38.StrType)le.atc025),
    Base_Fields.InValid_last_activity_age_code((SALT38.StrType)le.last_activity_age_code),
    Base_Fields.InValid_cottage_indicator((SALT38.StrType)le.cottage_indicator),
    Base_Fields.InValid_nonprofit_indicator((SALT38.StrType)le.nonprofit_indicator),
    Base_Fields.InValid_financial_stability_risk_score((SALT38.StrType)le.financial_stability_risk_score),
    Base_Fields.InValid_fsr_risk_class((SALT38.StrType)le.fsr_risk_class),
    Base_Fields.InValid_fsr_score_factor_1((SALT38.StrType)le.fsr_score_factor_1),
    Base_Fields.InValid_fsr_score_factor_2((SALT38.StrType)le.fsr_score_factor_2),
    Base_Fields.InValid_fsr_score_factor_3((SALT38.StrType)le.fsr_score_factor_3),
    Base_Fields.InValid_fsr_score_factor_4((SALT38.StrType)le.fsr_score_factor_4),
    Base_Fields.InValid_ip_score_change_sign((SALT38.StrType)le.ip_score_change_sign),
    Base_Fields.InValid_ip_score_change((SALT38.StrType)le.ip_score_change),
    Base_Fields.InValid_fsr_score_change_sign((SALT38.StrType)le.fsr_score_change_sign),
    Base_Fields.InValid_fsr_score_change((SALT38.StrType)le.fsr_score_change),
    Base_Fields.InValid_dba_name((SALT38.StrType)le.dba_name),
    Base_Fields.InValid_clean_dba_name((SALT38.StrType)le.clean_dba_name,(SALT38.StrType)le.dba_name),
    Base_Fields.InValid_clean_phone((SALT38.StrType)le.clean_phone),
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
    Base_Fields.InValid_recent_update_desc((SALT38.StrType)le.recent_update_desc),
    Base_Fields.InValid_years_in_business_desc((SALT38.StrType)le.years_in_business_desc),
    Base_Fields.InValid_address_type_desc((SALT38.StrType)le.address_type_desc),
    Base_Fields.InValid_employee_size_desc((SALT38.StrType)le.employee_size_desc),
    Base_Fields.InValid_annual_sales_size_desc((SALT38.StrType)le.annual_sales_size_desc),
    Base_Fields.InValid_location_desc((SALT38.StrType)le.location_desc),
    Base_Fields.InValid_primary_sic_code_industry_class_desc((SALT38.StrType)le.primary_sic_code_industry_class_desc),
    Base_Fields.InValid_business_type_desc((SALT38.StrType)le.business_type_desc),
    Base_Fields.InValid_ownership_code_desc((SALT38.StrType)le.ownership_code_desc),
    Base_Fields.InValid_ucc_data_indicator_desc((SALT38.StrType)le.ucc_data_indicator_desc),
    Base_Fields.InValid_experian_credit_rating_desc((SALT38.StrType)le.experian_credit_rating_desc),
    Base_Fields.InValid_last_activity_age_desc((SALT38.StrType)le.last_activity_age_desc),
    Base_Fields.InValid_cottage_indicator_desc((SALT38.StrType)le.cottage_indicator_desc),
    Base_Fields.InValid_nonprofit_indicator_desc((SALT38.StrType)le.nonprofit_indicator_desc),
    Base_Fields.InValid_company_name((SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_mname,(SALT38.StrType)le.p_lname),
    Base_Fields.InValid_p_title((SALT38.StrType)le.p_title),
    Base_Fields.InValid_p_fname((SALT38.StrType)le.p_fname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_mname,(SALT38.StrType)le.p_lname),
    Base_Fields.InValid_p_mname((SALT38.StrType)le.p_mname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_lname),
    Base_Fields.InValid_p_lname((SALT38.StrType)le.p_lname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_mname),
    Base_Fields.InValid_p_name_suffix((SALT38.StrType)le.p_name_suffix),
    Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid),
    Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last),
    Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,233,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_experian_bus_id','invalid_business_name','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_carrier_route','invalid_numeric','invalid_alphaHyphen','invalid_phone','invalid_numeric','Unknown','invalid_pastdate','invalid_pastdate','invalid_numeric','invalid_numericPeriod','invalid_geo_code_latitude_direction','invalid_numericPeriod','invalid_geo_code_longitude_direction','invalid_recent_update_code','invalid_years_in_business_code','invalid_year','invalid_numeric','invalid_address_type_code','invalid_numeric','invalid_employee_size_code','invalid_sign','invalid_numeric','invalid_annual_Sales_Size_Code','invalid_location_code','invalid_primary_sic_code_industry_classification','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_naics_codes','invalid_naics_codes','invalid_naics_codes','invalid_naics_codes','invalid_numeric','Unknown','Unknown','Unknown','Unknown','invalid_business_type','invalid_ownership_code','Unknown','invalid_derogatory_indicator','invalid_pastdate','invalid_sign','invalid_numeric','invalid_ucc_data_indicator','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_boolean','invalid_boolean','invalid_boolean','invalid_boolean','invalid_boolean','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_model_action','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','invalid_model_type','invalid_pastdate','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_aged_trade_lines','invalid_Experian_Credit_Rating','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_last_activity_age_code','invalid_boolean','invalid_nonprofit_indicator','invalid_numeric','invalid_fsr_risk_class','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','Unknown','invalid_clean_dba_name','Unknown','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','Unknown','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','Unknown','invalid_geo_match','invalid_err_stat','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_bName_pName','Unknown','invalid_bName_fName','invalid_bName_mName','invalid_bName_lName','Unknown','invalid_raw_aid','invalid_ace_aid','invalid_mandatory','invalid_mandatory','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_experian_bus_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_plus_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_carrier_route(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa_description(TotalErrors.ErrorNum),Base_Fields.InValidMessage_establish_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_latest_reported_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_years_in_file(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_code_latitude(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_code_latitude_direction(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_code_longitude(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_code_longitude_direction(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recent_update_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_years_in_business_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_year_business_started(TotalErrors.ErrorNum),Base_Fields.InValidMessage_months_in_file(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address_type_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_estimated_number_of_employees(TotalErrors.ErrorNum),Base_Fields.InValidMessage_employee_size_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_estimated_annual_sales_amount_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_estimated_annual_sales_amount(TotalErrors.ErrorNum),Base_Fields.InValidMessage_annual_sales_size_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_location_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_sic_code_industry_classification(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_sic_code_4_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_second_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_third_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fourth_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fifth_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sixth_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_naics_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_second_naics_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_third_naics_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fourth_naics_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_executive_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_executive_last_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_executive_first_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_executive_middle_initial(TotalErrors.ErrorNum),Base_Fields.InValidMessage_executive_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_business_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ownership_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_url(TotalErrors.ErrorNum),Base_Fields.InValidMessage_derogatory_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recent_derogatory_filed_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_derogatory_liability_amount_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_derogatory_liability_amount(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc_data_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_number_of_legal_items(TotalErrors.ErrorNum),Base_Fields.InValidMessage_legal_balance_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_legal_balance_amount(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pmtkbankruptcy(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pmtkjudgment(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pmtktaxlien(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pmtkpayment(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bankruptcy_filed(TotalErrors.ErrorNum),Base_Fields.InValidMessage_number_of_derogatory_legal_items(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lien_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_judgment_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkc006(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkc007(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkc008(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bko009(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkb001_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkb001(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkb003_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bkb003(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bko010(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bko011(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdc010(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdc011(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdc012(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdb004(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdb005(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdb006(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jDO013(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jDO014(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdb002(TotalErrors.ErrorNum),Base_Fields.InValidMessage_jdp016(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lgc004(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pro001(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pro003(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txc010(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txc011(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txb004_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txb004(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txo013(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txb002_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txb002(TotalErrors.ErrorNum),Base_Fields.InValidMessage_txp016(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc001(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc002(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc003(TotalErrors.ErrorNum),Base_Fields.InValidMessage_intelliscore_plus(TotalErrors.ErrorNum),Base_Fields.InValidMessage_percentile_model(TotalErrors.ErrorNum),Base_Fields.InValidMessage_model_action(TotalErrors.ErrorNum),Base_Fields.InValidMessage_score_factor_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_score_factor_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_score_factor_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_score_factor_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_model_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_model_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_last_experian_inquiry_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recent_high_credit_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recent_high_credit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_median_credit_amount_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_median_credit_amount(TotalErrors.ErrorNum),Base_Fields.InValidMessage_total_combined_trade_lines_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbt_of_combined_trade_totals(TotalErrors.ErrorNum),Base_Fields.InValidMessage_combined_trade_balance(TotalErrors.ErrorNum),Base_Fields.InValidMessage_aged_trade_lines(TotalErrors.ErrorNum),Base_Fields.InValidMessage_experian_credit_rating(TotalErrors.ErrorNum),Base_Fields.InValidMessage_quarter_1_average_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_quarter_2_average_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_quarter_3_average_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_quarter_4_average_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_quarter_5_average_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_combined_dbt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_total_account_balance_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_total_account_balance(TotalErrors.ErrorNum),Base_Fields.InValidMessage_combined_account_balance_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_combined_account_balance(TotalErrors.ErrorNum),Base_Fields.InValidMessage_collection_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_atc021(TotalErrors.ErrorNum),Base_Fields.InValidMessage_atc022(TotalErrors.ErrorNum),Base_Fields.InValidMessage_atc023(TotalErrors.ErrorNum),Base_Fields.InValidMessage_atc024(TotalErrors.ErrorNum),Base_Fields.InValidMessage_atc025(TotalErrors.ErrorNum),Base_Fields.InValidMessage_last_activity_age_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cottage_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nonprofit_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_financial_stability_risk_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_risk_class(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_factor_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_factor_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_factor_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_factor_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ip_score_change_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ip_score_change(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_change_sign(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fsr_score_change(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dba_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_dba_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recent_update_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_years_in_business_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address_type_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_employee_size_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_annual_sales_size_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_location_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_sic_code_industry_class_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_business_type_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ownership_code_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ucc_data_indicator_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_experian_credit_rating_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_last_activity_age_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cottage_indicator_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nonprofit_indicator_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Experian_CRDB, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
