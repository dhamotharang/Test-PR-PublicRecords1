IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_infutor_narb) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_ein_pcnt := AVE(GROUP,IF(h.ein = (TYPEOF(h.ein))'',0,100));
    maxlength_ein := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ein)));
    avelength_ein := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ein)),h.ein<>(typeof(h.ein))'');
    populated_busname_pcnt := AVE(GROUP,IF(h.busname = (TYPEOF(h.busname))'',0,100));
    maxlength_busname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.busname)));
    avelength_busname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.busname)),h.busname<>(typeof(h.busname))'');
    populated_tradename_pcnt := AVE(GROUP,IF(h.tradename = (TYPEOF(h.tradename))'',0,100));
    maxlength_tradename := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.tradename)));
    avelength_tradename := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.tradename)),h.tradename<>(typeof(h.tradename))'');
    populated_house_pcnt := AVE(GROUP,IF(h.house = (TYPEOF(h.house))'',0,100));
    maxlength_house := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.house)));
    avelength_house := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.house)),h.house<>(typeof(h.house))'');
    populated_predirection_pcnt := AVE(GROUP,IF(h.predirection = (TYPEOF(h.predirection))'',0,100));
    maxlength_predirection := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.predirection)));
    avelength_predirection := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.predirection)),h.predirection<>(typeof(h.predirection))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_strtype_pcnt := AVE(GROUP,IF(h.strtype = (TYPEOF(h.strtype))'',0,100));
    maxlength_strtype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.strtype)));
    avelength_strtype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.strtype)),h.strtype<>(typeof(h.strtype))'');
    populated_postdirection_pcnt := AVE(GROUP,IF(h.postdirection = (TYPEOF(h.postdirection))'',0,100));
    maxlength_postdirection := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdirection)));
    avelength_postdirection := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdirection)),h.postdirection<>(typeof(h.postdirection))'');
    populated_apttype_pcnt := AVE(GROUP,IF(h.apttype = (TYPEOF(h.apttype))'',0,100));
    maxlength_apttype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.apttype)));
    avelength_apttype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.apttype)),h.apttype<>(typeof(h.apttype))'');
    populated_aptnbr_pcnt := AVE(GROUP,IF(h.aptnbr = (TYPEOF(h.aptnbr))'',0,100));
    maxlength_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aptnbr)));
    avelength_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aptnbr)),h.aptnbr<>(typeof(h.aptnbr))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_ziplast4_pcnt := AVE(GROUP,IF(h.ziplast4 = (TYPEOF(h.ziplast4))'',0,100));
    maxlength_ziplast4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ziplast4)));
    avelength_ziplast4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ziplast4)),h.ziplast4<>(typeof(h.ziplast4))'');
    populated_dpc_pcnt := AVE(GROUP,IF(h.dpc = (TYPEOF(h.dpc))'',0,100));
    maxlength_dpc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpc)));
    avelength_dpc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpc)),h.dpc<>(typeof(h.dpc))'');
    populated_carrier_route_pcnt := AVE(GROUP,IF(h.carrier_route = (TYPEOF(h.carrier_route))'',0,100));
    maxlength_carrier_route := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.carrier_route)));
    avelength_carrier_route := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.carrier_route)),h.carrier_route<>(typeof(h.carrier_route))'');
    populated_address_type_code_pcnt := AVE(GROUP,IF(h.address_type_code = (TYPEOF(h.address_type_code))'',0,100));
    maxlength_address_type_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type_code)));
    avelength_address_type_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type_code)),h.address_type_code<>(typeof(h.address_type_code))'');
    populated_dpv_code_pcnt := AVE(GROUP,IF(h.dpv_code = (TYPEOF(h.dpv_code))'',0,100));
    maxlength_dpv_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpv_code)));
    avelength_dpv_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpv_code)),h.dpv_code<>(typeof(h.dpv_code))'');
    populated_mailable_pcnt := AVE(GROUP,IF(h.mailable = (TYPEOF(h.mailable))'',0,100));
    maxlength_mailable := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailable)));
    avelength_mailable := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailable)),h.mailable<>(typeof(h.mailable))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_censustract_pcnt := AVE(GROUP,IF(h.censustract = (TYPEOF(h.censustract))'',0,100));
    maxlength_censustract := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.censustract)));
    avelength_censustract := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.censustract)),h.censustract<>(typeof(h.censustract))'');
    populated_censusblockgroup_pcnt := AVE(GROUP,IF(h.censusblockgroup = (TYPEOF(h.censusblockgroup))'',0,100));
    maxlength_censusblockgroup := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.censusblockgroup)));
    avelength_censusblockgroup := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.censusblockgroup)),h.censusblockgroup<>(typeof(h.censusblockgroup))'');
    populated_censusblock_pcnt := AVE(GROUP,IF(h.censusblock = (TYPEOF(h.censusblock))'',0,100));
    maxlength_censusblock := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.censusblock)));
    avelength_censusblock := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.censusblock)),h.censusblock<>(typeof(h.censusblock))'');
    populated_congress_code_pcnt := AVE(GROUP,IF(h.congress_code = (TYPEOF(h.congress_code))'',0,100));
    maxlength_congress_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.congress_code)));
    avelength_congress_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.congress_code)),h.congress_code<>(typeof(h.congress_code))'');
    populated_msacode_pcnt := AVE(GROUP,IF(h.msacode = (TYPEOF(h.msacode))'',0,100));
    maxlength_msacode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msacode)));
    avelength_msacode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msacode)),h.msacode<>(typeof(h.msacode))'');
    populated_timezonecode_pcnt := AVE(GROUP,IF(h.timezonecode = (TYPEOF(h.timezonecode))'',0,100));
    maxlength_timezonecode := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.timezonecode)));
    avelength_timezonecode := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.timezonecode)),h.timezonecode<>(typeof(h.timezonecode))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_toll_free_number_pcnt := AVE(GROUP,IF(h.toll_free_number = (TYPEOF(h.toll_free_number))'',0,100));
    maxlength_toll_free_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.toll_free_number)));
    avelength_toll_free_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.toll_free_number)),h.toll_free_number<>(typeof(h.toll_free_number))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_sic1_pcnt := AVE(GROUP,IF(h.sic1 = (TYPEOF(h.sic1))'',0,100));
    maxlength_sic1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)));
    avelength_sic1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)),h.sic1<>(typeof(h.sic1))'');
    populated_sic2_pcnt := AVE(GROUP,IF(h.sic2 = (TYPEOF(h.sic2))'',0,100));
    maxlength_sic2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)));
    avelength_sic2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)),h.sic2<>(typeof(h.sic2))'');
    populated_sic3_pcnt := AVE(GROUP,IF(h.sic3 = (TYPEOF(h.sic3))'',0,100));
    maxlength_sic3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)));
    avelength_sic3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)),h.sic3<>(typeof(h.sic3))'');
    populated_sic4_pcnt := AVE(GROUP,IF(h.sic4 = (TYPEOF(h.sic4))'',0,100));
    maxlength_sic4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)));
    avelength_sic4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)),h.sic4<>(typeof(h.sic4))'');
    populated_sic5_pcnt := AVE(GROUP,IF(h.sic5 = (TYPEOF(h.sic5))'',0,100));
    maxlength_sic5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)));
    avelength_sic5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)),h.sic5<>(typeof(h.sic5))'');
    populated_stdclass_pcnt := AVE(GROUP,IF(h.stdclass = (TYPEOF(h.stdclass))'',0,100));
    maxlength_stdclass := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.stdclass)));
    avelength_stdclass := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.stdclass)),h.stdclass<>(typeof(h.stdclass))'');
    populated_heading1_pcnt := AVE(GROUP,IF(h.heading1 = (TYPEOF(h.heading1))'',0,100));
    maxlength_heading1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading1)));
    avelength_heading1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading1)),h.heading1<>(typeof(h.heading1))'');
    populated_heading2_pcnt := AVE(GROUP,IF(h.heading2 = (TYPEOF(h.heading2))'',0,100));
    maxlength_heading2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading2)));
    avelength_heading2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading2)),h.heading2<>(typeof(h.heading2))'');
    populated_heading3_pcnt := AVE(GROUP,IF(h.heading3 = (TYPEOF(h.heading3))'',0,100));
    maxlength_heading3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading3)));
    avelength_heading3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading3)),h.heading3<>(typeof(h.heading3))'');
    populated_heading4_pcnt := AVE(GROUP,IF(h.heading4 = (TYPEOF(h.heading4))'',0,100));
    maxlength_heading4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading4)));
    avelength_heading4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading4)),h.heading4<>(typeof(h.heading4))'');
    populated_heading5_pcnt := AVE(GROUP,IF(h.heading5 = (TYPEOF(h.heading5))'',0,100));
    maxlength_heading5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading5)));
    avelength_heading5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.heading5)),h.heading5<>(typeof(h.heading5))'');
    populated_business_specialty_pcnt := AVE(GROUP,IF(h.business_specialty = (TYPEOF(h.business_specialty))'',0,100));
    maxlength_business_specialty := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_specialty)));
    avelength_business_specialty := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_specialty)),h.business_specialty<>(typeof(h.business_specialty))'');
    populated_sales_code_pcnt := AVE(GROUP,IF(h.sales_code = (TYPEOF(h.sales_code))'',0,100));
    maxlength_sales_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sales_code)));
    avelength_sales_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sales_code)),h.sales_code<>(typeof(h.sales_code))'');
    populated_employee_code_pcnt := AVE(GROUP,IF(h.employee_code = (TYPEOF(h.employee_code))'',0,100));
    maxlength_employee_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.employee_code)));
    avelength_employee_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.employee_code)),h.employee_code<>(typeof(h.employee_code))'');
    populated_location_type_pcnt := AVE(GROUP,IF(h.location_type = (TYPEOF(h.location_type))'',0,100));
    maxlength_location_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.location_type)));
    avelength_location_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.location_type)),h.location_type<>(typeof(h.location_type))'');
    populated_parent_company_pcnt := AVE(GROUP,IF(h.parent_company = (TYPEOF(h.parent_company))'',0,100));
    maxlength_parent_company := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_company)));
    avelength_parent_company := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_company)),h.parent_company<>(typeof(h.parent_company))'');
    populated_parent_address_pcnt := AVE(GROUP,IF(h.parent_address = (TYPEOF(h.parent_address))'',0,100));
    maxlength_parent_address := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_address)));
    avelength_parent_address := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_address)),h.parent_address<>(typeof(h.parent_address))'');
    populated_parent_city_pcnt := AVE(GROUP,IF(h.parent_city = (TYPEOF(h.parent_city))'',0,100));
    maxlength_parent_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_city)));
    avelength_parent_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_city)),h.parent_city<>(typeof(h.parent_city))'');
    populated_parent_state_pcnt := AVE(GROUP,IF(h.parent_state = (TYPEOF(h.parent_state))'',0,100));
    maxlength_parent_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_state)));
    avelength_parent_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_state)),h.parent_state<>(typeof(h.parent_state))'');
    populated_parent_zip_pcnt := AVE(GROUP,IF(h.parent_zip = (TYPEOF(h.parent_zip))'',0,100));
    maxlength_parent_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_zip)));
    avelength_parent_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_zip)),h.parent_zip<>(typeof(h.parent_zip))'');
    populated_parent_phone_pcnt := AVE(GROUP,IF(h.parent_phone = (TYPEOF(h.parent_phone))'',0,100));
    maxlength_parent_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_phone)));
    avelength_parent_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_phone)),h.parent_phone<>(typeof(h.parent_phone))'');
    populated_stock_symbol_pcnt := AVE(GROUP,IF(h.stock_symbol = (TYPEOF(h.stock_symbol))'',0,100));
    maxlength_stock_symbol := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.stock_symbol)));
    avelength_stock_symbol := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.stock_symbol)),h.stock_symbol<>(typeof(h.stock_symbol))'');
    populated_stock_exchange_pcnt := AVE(GROUP,IF(h.stock_exchange = (TYPEOF(h.stock_exchange))'',0,100));
    maxlength_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.stock_exchange)));
    avelength_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.stock_exchange)),h.stock_exchange<>(typeof(h.stock_exchange))'');
    populated_public_pcnt := AVE(GROUP,IF(h.public = (TYPEOF(h.public))'',0,100));
    maxlength_public := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.public)));
    avelength_public := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.public)),h.public<>(typeof(h.public))'');
    populated_number_of_pcs_pcnt := AVE(GROUP,IF(h.number_of_pcs = (TYPEOF(h.number_of_pcs))'',0,100));
    maxlength_number_of_pcs := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.number_of_pcs)));
    avelength_number_of_pcs := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.number_of_pcs)),h.number_of_pcs<>(typeof(h.number_of_pcs))'');
    populated_square_footage_pcnt := AVE(GROUP,IF(h.square_footage = (TYPEOF(h.square_footage))'',0,100));
    maxlength_square_footage := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.square_footage)));
    avelength_square_footage := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.square_footage)),h.square_footage<>(typeof(h.square_footage))'');
    populated_business_type_pcnt := AVE(GROUP,IF(h.business_type = (TYPEOF(h.business_type))'',0,100));
    maxlength_business_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type)));
    avelength_business_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type)),h.business_type<>(typeof(h.business_type))'');
    populated_incorporation_state_pcnt := AVE(GROUP,IF(h.incorporation_state = (TYPEOF(h.incorporation_state))'',0,100));
    maxlength_incorporation_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.incorporation_state)));
    avelength_incorporation_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.incorporation_state)),h.incorporation_state<>(typeof(h.incorporation_state))'');
    populated_minority_pcnt := AVE(GROUP,IF(h.minority = (TYPEOF(h.minority))'',0,100));
    maxlength_minority := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.minority)));
    avelength_minority := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.minority)),h.minority<>(typeof(h.minority))'');
    populated_woman_pcnt := AVE(GROUP,IF(h.woman = (TYPEOF(h.woman))'',0,100));
    maxlength_woman := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.woman)));
    avelength_woman := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.woman)),h.woman<>(typeof(h.woman))'');
    populated_government_pcnt := AVE(GROUP,IF(h.government = (TYPEOF(h.government))'',0,100));
    maxlength_government := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.government)));
    avelength_government := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.government)),h.government<>(typeof(h.government))'');
    populated_small_pcnt := AVE(GROUP,IF(h.small = (TYPEOF(h.small))'',0,100));
    maxlength_small := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.small)));
    avelength_small := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.small)),h.small<>(typeof(h.small))'');
    populated_home_office_pcnt := AVE(GROUP,IF(h.home_office = (TYPEOF(h.home_office))'',0,100));
    maxlength_home_office := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.home_office)));
    avelength_home_office := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.home_office)),h.home_office<>(typeof(h.home_office))'');
    populated_soho_pcnt := AVE(GROUP,IF(h.soho = (TYPEOF(h.soho))'',0,100));
    maxlength_soho := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.soho)));
    avelength_soho := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.soho)),h.soho<>(typeof(h.soho))'');
    populated_franchise_pcnt := AVE(GROUP,IF(h.franchise = (TYPEOF(h.franchise))'',0,100));
    maxlength_franchise := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.franchise)));
    avelength_franchise := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.franchise)),h.franchise<>(typeof(h.franchise))'');
    populated_phoneable_pcnt := AVE(GROUP,IF(h.phoneable = (TYPEOF(h.phoneable))'',0,100));
    maxlength_phoneable := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.phoneable)));
    avelength_phoneable := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.phoneable)),h.phoneable<>(typeof(h.phoneable))'');
    populated_prefix_pcnt := AVE(GROUP,IF(h.prefix = (TYPEOF(h.prefix))'',0,100));
    maxlength_prefix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prefix)));
    avelength_prefix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prefix)),h.prefix<>(typeof(h.prefix))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_surname_pcnt := AVE(GROUP,IF(h.surname = (TYPEOF(h.surname))'',0,100));
    maxlength_surname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.surname)));
    avelength_surname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.surname)),h.surname<>(typeof(h.surname))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_birth_year_pcnt := AVE(GROUP,IF(h.birth_year = (TYPEOF(h.birth_year))'',0,100));
    maxlength_birth_year := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.birth_year)));
    avelength_birth_year := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.birth_year)),h.birth_year<>(typeof(h.birth_year))'');
    populated_ethnicity_pcnt := AVE(GROUP,IF(h.ethnicity = (TYPEOF(h.ethnicity))'',0,100));
    maxlength_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ethnicity)));
    avelength_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ethnicity)),h.ethnicity<>(typeof(h.ethnicity))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_contact_title_pcnt := AVE(GROUP,IF(h.contact_title = (TYPEOF(h.contact_title))'',0,100));
    maxlength_contact_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_title)));
    avelength_contact_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_title)),h.contact_title<>(typeof(h.contact_title))'');
    populated_year_started_pcnt := AVE(GROUP,IF(h.year_started = (TYPEOF(h.year_started))'',0,100));
    maxlength_year_started := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.year_started)));
    avelength_year_started := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.year_started)),h.year_started<>(typeof(h.year_started))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_validationdate_pcnt := AVE(GROUP,IF(h.validationdate = (TYPEOF(h.validationdate))'',0,100));
    maxlength_validationdate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.validationdate)));
    avelength_validationdate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.validationdate)),h.validationdate<>(typeof(h.validationdate))'');
    populated_internal1_pcnt := AVE(GROUP,IF(h.internal1 = (TYPEOF(h.internal1))'',0,100));
    maxlength_internal1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.internal1)));
    avelength_internal1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.internal1)),h.internal1<>(typeof(h.internal1))'');
    populated_dacd_pcnt := AVE(GROUP,IF(h.dacd = (TYPEOF(h.dacd))'',0,100));
    maxlength_dacd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dacd)));
    avelength_dacd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dacd)),h.dacd<>(typeof(h.dacd))'');
    populated_normcompany_type_pcnt := AVE(GROUP,IF(h.normcompany_type = (TYPEOF(h.normcompany_type))'',0,100));
    maxlength_normcompany_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_type)));
    avelength_normcompany_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_type)),h.normcompany_type<>(typeof(h.normcompany_type))'');
    populated_normcompany_name_pcnt := AVE(GROUP,IF(h.normcompany_name = (TYPEOF(h.normcompany_name))'',0,100));
    maxlength_normcompany_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_name)));
    avelength_normcompany_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_name)),h.normcompany_name<>(typeof(h.normcompany_name))'');
    populated_normcompany_street_pcnt := AVE(GROUP,IF(h.normcompany_street = (TYPEOF(h.normcompany_street))'',0,100));
    maxlength_normcompany_street := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_street)));
    avelength_normcompany_street := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_street)),h.normcompany_street<>(typeof(h.normcompany_street))'');
    populated_normcompany_city_pcnt := AVE(GROUP,IF(h.normcompany_city = (TYPEOF(h.normcompany_city))'',0,100));
    maxlength_normcompany_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_city)));
    avelength_normcompany_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_city)),h.normcompany_city<>(typeof(h.normcompany_city))'');
    populated_normcompany_state_pcnt := AVE(GROUP,IF(h.normcompany_state = (TYPEOF(h.normcompany_state))'',0,100));
    maxlength_normcompany_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_state)));
    avelength_normcompany_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_state)),h.normcompany_state<>(typeof(h.normcompany_state))'');
    populated_normcompany_zip_pcnt := AVE(GROUP,IF(h.normcompany_zip = (TYPEOF(h.normcompany_zip))'',0,100));
    maxlength_normcompany_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_zip)));
    avelength_normcompany_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_zip)),h.normcompany_zip<>(typeof(h.normcompany_zip))'');
    populated_normcompany_phone_pcnt := AVE(GROUP,IF(h.normcompany_phone = (TYPEOF(h.normcompany_phone))'',0,100));
    maxlength_normcompany_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_phone)));
    avelength_normcompany_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.normcompany_phone)),h.normcompany_phone<>(typeof(h.normcompany_phone))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_prep_address_line1_pcnt := AVE(GROUP,IF(h.prep_address_line1 = (TYPEOF(h.prep_address_line1))'',0,100));
    maxlength_prep_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line1)));
    avelength_prep_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line1)),h.prep_address_line1<>(typeof(h.prep_address_line1))'');
    populated_prep_address_line_last_pcnt := AVE(GROUP,IF(h.prep_address_line_last = (TYPEOF(h.prep_address_line_last))'',0,100));
    maxlength_prep_address_line_last := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line_last)));
    avelength_prep_address_line_last := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prep_address_line_last)),h.prep_address_line_last<>(typeof(h.prep_address_line_last))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_ein_pcnt *   0.00 / 100 + T.Populated_busname_pcnt *   0.00 / 100 + T.Populated_tradename_pcnt *   0.00 / 100 + T.Populated_house_pcnt *   0.00 / 100 + T.Populated_predirection_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_strtype_pcnt *   0.00 / 100 + T.Populated_postdirection_pcnt *   0.00 / 100 + T.Populated_apttype_pcnt *   0.00 / 100 + T.Populated_aptnbr_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_ziplast4_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_carrier_route_pcnt *   0.00 / 100 + T.Populated_address_type_code_pcnt *   0.00 / 100 + T.Populated_dpv_code_pcnt *   0.00 / 100 + T.Populated_mailable_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_censustract_pcnt *   0.00 / 100 + T.Populated_censusblockgroup_pcnt *   0.00 / 100 + T.Populated_censusblock_pcnt *   0.00 / 100 + T.Populated_congress_code_pcnt *   0.00 / 100 + T.Populated_msacode_pcnt *   0.00 / 100 + T.Populated_timezonecode_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_toll_free_number_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_sic1_pcnt *   0.00 / 100 + T.Populated_sic2_pcnt *   0.00 / 100 + T.Populated_sic3_pcnt *   0.00 / 100 + T.Populated_sic4_pcnt *   0.00 / 100 + T.Populated_sic5_pcnt *   0.00 / 100 + T.Populated_stdclass_pcnt *   0.00 / 100 + T.Populated_heading1_pcnt *   0.00 / 100 + T.Populated_heading2_pcnt *   0.00 / 100 + T.Populated_heading3_pcnt *   0.00 / 100 + T.Populated_heading4_pcnt *   0.00 / 100 + T.Populated_heading5_pcnt *   0.00 / 100 + T.Populated_business_specialty_pcnt *   0.00 / 100 + T.Populated_sales_code_pcnt *   0.00 / 100 + T.Populated_employee_code_pcnt *   0.00 / 100 + T.Populated_location_type_pcnt *   0.00 / 100 + T.Populated_parent_company_pcnt *   0.00 / 100 + T.Populated_parent_address_pcnt *   0.00 / 100 + T.Populated_parent_city_pcnt *   0.00 / 100 + T.Populated_parent_state_pcnt *   0.00 / 100 + T.Populated_parent_zip_pcnt *   0.00 / 100 + T.Populated_parent_phone_pcnt *   0.00 / 100 + T.Populated_stock_symbol_pcnt *   0.00 / 100 + T.Populated_stock_exchange_pcnt *   0.00 / 100 + T.Populated_public_pcnt *   0.00 / 100 + T.Populated_number_of_pcs_pcnt *   0.00 / 100 + T.Populated_square_footage_pcnt *   0.00 / 100 + T.Populated_business_type_pcnt *   0.00 / 100 + T.Populated_incorporation_state_pcnt *   0.00 / 100 + T.Populated_minority_pcnt *   0.00 / 100 + T.Populated_woman_pcnt *   0.00 / 100 + T.Populated_government_pcnt *   0.00 / 100 + T.Populated_small_pcnt *   0.00 / 100 + T.Populated_home_office_pcnt *   0.00 / 100 + T.Populated_soho_pcnt *   0.00 / 100 + T.Populated_franchise_pcnt *   0.00 / 100 + T.Populated_phoneable_pcnt *   0.00 / 100 + T.Populated_prefix_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_surname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_birth_year_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_contact_title_pcnt *   0.00 / 100 + T.Populated_year_started_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_validationdate_pcnt *   0.00 / 100 + T.Populated_internal1_pcnt *   0.00 / 100 + T.Populated_dacd_pcnt *   0.00 / 100 + T.Populated_normcompany_type_pcnt *   0.00 / 100 + T.Populated_normcompany_name_pcnt *   0.00 / 100 + T.Populated_normcompany_street_pcnt *   0.00 / 100 + T.Populated_normcompany_city_pcnt *   0.00 / 100 + T.Populated_normcompany_state_pcnt *   0.00 / 100 + T.Populated_normcompany_zip_pcnt *   0.00 / 100 + T.Populated_normcompany_phone_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_address_line1_pcnt *   0.00 / 100 + T.Populated_prep_address_line_last_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_pid_pcnt*ri.Populated_pid_pcnt *   0.00 / 10000 + le.Populated_record_id_pcnt*ri.Populated_record_id_pcnt *   0.00 / 10000 + le.Populated_ein_pcnt*ri.Populated_ein_pcnt *   0.00 / 10000 + le.Populated_busname_pcnt*ri.Populated_busname_pcnt *   0.00 / 10000 + le.Populated_tradename_pcnt*ri.Populated_tradename_pcnt *   0.00 / 10000 + le.Populated_house_pcnt*ri.Populated_house_pcnt *   0.00 / 10000 + le.Populated_predirection_pcnt*ri.Populated_predirection_pcnt *   0.00 / 10000 + le.Populated_street_pcnt*ri.Populated_street_pcnt *   0.00 / 10000 + le.Populated_strtype_pcnt*ri.Populated_strtype_pcnt *   0.00 / 10000 + le.Populated_postdirection_pcnt*ri.Populated_postdirection_pcnt *   0.00 / 10000 + le.Populated_apttype_pcnt*ri.Populated_apttype_pcnt *   0.00 / 10000 + le.Populated_aptnbr_pcnt*ri.Populated_aptnbr_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_ziplast4_pcnt*ri.Populated_ziplast4_pcnt *   0.00 / 10000 + le.Populated_dpc_pcnt*ri.Populated_dpc_pcnt *   0.00 / 10000 + le.Populated_carrier_route_pcnt*ri.Populated_carrier_route_pcnt *   0.00 / 10000 + le.Populated_address_type_code_pcnt*ri.Populated_address_type_code_pcnt *   0.00 / 10000 + le.Populated_dpv_code_pcnt*ri.Populated_dpv_code_pcnt *   0.00 / 10000 + le.Populated_mailable_pcnt*ri.Populated_mailable_pcnt *   0.00 / 10000 + le.Populated_county_code_pcnt*ri.Populated_county_code_pcnt *   0.00 / 10000 + le.Populated_censustract_pcnt*ri.Populated_censustract_pcnt *   0.00 / 10000 + le.Populated_censusblockgroup_pcnt*ri.Populated_censusblockgroup_pcnt *   0.00 / 10000 + le.Populated_censusblock_pcnt*ri.Populated_censusblock_pcnt *   0.00 / 10000 + le.Populated_congress_code_pcnt*ri.Populated_congress_code_pcnt *   0.00 / 10000 + le.Populated_msacode_pcnt*ri.Populated_msacode_pcnt *   0.00 / 10000 + le.Populated_timezonecode_pcnt*ri.Populated_timezonecode_pcnt *   0.00 / 10000 + le.Populated_latitude_pcnt*ri.Populated_latitude_pcnt *   0.00 / 10000 + le.Populated_longitude_pcnt*ri.Populated_longitude_pcnt *   0.00 / 10000 + le.Populated_url_pcnt*ri.Populated_url_pcnt *   0.00 / 10000 + le.Populated_telephone_pcnt*ri.Populated_telephone_pcnt *   0.00 / 10000 + le.Populated_toll_free_number_pcnt*ri.Populated_toll_free_number_pcnt *   0.00 / 10000 + le.Populated_fax_pcnt*ri.Populated_fax_pcnt *   0.00 / 10000 + le.Populated_sic1_pcnt*ri.Populated_sic1_pcnt *   0.00 / 10000 + le.Populated_sic2_pcnt*ri.Populated_sic2_pcnt *   0.00 / 10000 + le.Populated_sic3_pcnt*ri.Populated_sic3_pcnt *   0.00 / 10000 + le.Populated_sic4_pcnt*ri.Populated_sic4_pcnt *   0.00 / 10000 + le.Populated_sic5_pcnt*ri.Populated_sic5_pcnt *   0.00 / 10000 + le.Populated_stdclass_pcnt*ri.Populated_stdclass_pcnt *   0.00 / 10000 + le.Populated_heading1_pcnt*ri.Populated_heading1_pcnt *   0.00 / 10000 + le.Populated_heading2_pcnt*ri.Populated_heading2_pcnt *   0.00 / 10000 + le.Populated_heading3_pcnt*ri.Populated_heading3_pcnt *   0.00 / 10000 + le.Populated_heading4_pcnt*ri.Populated_heading4_pcnt *   0.00 / 10000 + le.Populated_heading5_pcnt*ri.Populated_heading5_pcnt *   0.00 / 10000 + le.Populated_business_specialty_pcnt*ri.Populated_business_specialty_pcnt *   0.00 / 10000 + le.Populated_sales_code_pcnt*ri.Populated_sales_code_pcnt *   0.00 / 10000 + le.Populated_employee_code_pcnt*ri.Populated_employee_code_pcnt *   0.00 / 10000 + le.Populated_location_type_pcnt*ri.Populated_location_type_pcnt *   0.00 / 10000 + le.Populated_parent_company_pcnt*ri.Populated_parent_company_pcnt *   0.00 / 10000 + le.Populated_parent_address_pcnt*ri.Populated_parent_address_pcnt *   0.00 / 10000 + le.Populated_parent_city_pcnt*ri.Populated_parent_city_pcnt *   0.00 / 10000 + le.Populated_parent_state_pcnt*ri.Populated_parent_state_pcnt *   0.00 / 10000 + le.Populated_parent_zip_pcnt*ri.Populated_parent_zip_pcnt *   0.00 / 10000 + le.Populated_parent_phone_pcnt*ri.Populated_parent_phone_pcnt *   0.00 / 10000 + le.Populated_stock_symbol_pcnt*ri.Populated_stock_symbol_pcnt *   0.00 / 10000 + le.Populated_stock_exchange_pcnt*ri.Populated_stock_exchange_pcnt *   0.00 / 10000 + le.Populated_public_pcnt*ri.Populated_public_pcnt *   0.00 / 10000 + le.Populated_number_of_pcs_pcnt*ri.Populated_number_of_pcs_pcnt *   0.00 / 10000 + le.Populated_square_footage_pcnt*ri.Populated_square_footage_pcnt *   0.00 / 10000 + le.Populated_business_type_pcnt*ri.Populated_business_type_pcnt *   0.00 / 10000 + le.Populated_incorporation_state_pcnt*ri.Populated_incorporation_state_pcnt *   0.00 / 10000 + le.Populated_minority_pcnt*ri.Populated_minority_pcnt *   0.00 / 10000 + le.Populated_woman_pcnt*ri.Populated_woman_pcnt *   0.00 / 10000 + le.Populated_government_pcnt*ri.Populated_government_pcnt *   0.00 / 10000 + le.Populated_small_pcnt*ri.Populated_small_pcnt *   0.00 / 10000 + le.Populated_home_office_pcnt*ri.Populated_home_office_pcnt *   0.00 / 10000 + le.Populated_soho_pcnt*ri.Populated_soho_pcnt *   0.00 / 10000 + le.Populated_franchise_pcnt*ri.Populated_franchise_pcnt *   0.00 / 10000 + le.Populated_phoneable_pcnt*ri.Populated_phoneable_pcnt *   0.00 / 10000 + le.Populated_prefix_pcnt*ri.Populated_prefix_pcnt *   0.00 / 10000 + le.Populated_first_name_pcnt*ri.Populated_first_name_pcnt *   0.00 / 10000 + le.Populated_middle_name_pcnt*ri.Populated_middle_name_pcnt *   0.00 / 10000 + le.Populated_surname_pcnt*ri.Populated_surname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_birth_year_pcnt*ri.Populated_birth_year_pcnt *   0.00 / 10000 + le.Populated_ethnicity_pcnt*ri.Populated_ethnicity_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_email_pcnt*ri.Populated_email_pcnt *   0.00 / 10000 + le.Populated_contact_title_pcnt*ri.Populated_contact_title_pcnt *   0.00 / 10000 + le.Populated_year_started_pcnt*ri.Populated_year_started_pcnt *   0.00 / 10000 + le.Populated_date_added_pcnt*ri.Populated_date_added_pcnt *   0.00 / 10000 + le.Populated_validationdate_pcnt*ri.Populated_validationdate_pcnt *   0.00 / 10000 + le.Populated_internal1_pcnt*ri.Populated_internal1_pcnt *   0.00 / 10000 + le.Populated_dacd_pcnt*ri.Populated_dacd_pcnt *   0.00 / 10000 + le.Populated_normcompany_type_pcnt*ri.Populated_normcompany_type_pcnt *   0.00 / 10000 + le.Populated_normcompany_name_pcnt*ri.Populated_normcompany_name_pcnt *   0.00 / 10000 + le.Populated_normcompany_street_pcnt*ri.Populated_normcompany_street_pcnt *   0.00 / 10000 + le.Populated_normcompany_city_pcnt*ri.Populated_normcompany_city_pcnt *   0.00 / 10000 + le.Populated_normcompany_state_pcnt*ri.Populated_normcompany_state_pcnt *   0.00 / 10000 + le.Populated_normcompany_zip_pcnt*ri.Populated_normcompany_zip_pcnt *   0.00 / 10000 + le.Populated_normcompany_phone_pcnt*ri.Populated_normcompany_phone_pcnt *   0.00 / 10000 + le.Populated_clean_company_name_pcnt*ri.Populated_clean_company_name_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_clean_phone_pcnt*ri.Populated_clean_phone_pcnt *   0.00 / 10000 + le.Populated_raw_aid_pcnt*ri.Populated_raw_aid_pcnt *   0.00 / 10000 + le.Populated_ace_aid_pcnt*ri.Populated_ace_aid_pcnt *   0.00 / 10000 + le.Populated_prep_address_line1_pcnt*ri.Populated_prep_address_line1_pcnt *   0.00 / 10000 + le.Populated_prep_address_line_last_pcnt*ri.Populated_prep_address_line_last_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','pid','record_id','ein','busname','tradename','house','predirection','street','strtype','postdirection','apttype','aptnbr','city','state','zip5','ziplast4','dpc','carrier_route','address_type_code','dpv_code','mailable','county_code','censustract','censusblockgroup','censusblock','congress_code','msacode','timezonecode','latitude','longitude','url','telephone','toll_free_number','fax','sic1','sic2','sic3','sic4','sic5','stdclass','heading1','heading2','heading3','heading4','heading5','business_specialty','sales_code','employee_code','location_type','parent_company','parent_address','parent_city','parent_state','parent_zip','parent_phone','stock_symbol','stock_exchange','public','number_of_pcs','square_footage','business_type','incorporation_state','minority','woman','government','small','home_office','soho','franchise','phoneable','prefix','first_name','middle_name','surname','suffix','birth_year','ethnicity','gender','email','contact_title','year_started','date_added','validationdate','internal1','dacd','normcompany_type','normcompany_name','normcompany_street','normcompany_city','normcompany_state','normcompany_zip','normcompany_phone','clean_company_name','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','clean_phone','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_pid_pcnt,le.populated_record_id_pcnt,le.populated_ein_pcnt,le.populated_busname_pcnt,le.populated_tradename_pcnt,le.populated_house_pcnt,le.populated_predirection_pcnt,le.populated_street_pcnt,le.populated_strtype_pcnt,le.populated_postdirection_pcnt,le.populated_apttype_pcnt,le.populated_aptnbr_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_ziplast4_pcnt,le.populated_dpc_pcnt,le.populated_carrier_route_pcnt,le.populated_address_type_code_pcnt,le.populated_dpv_code_pcnt,le.populated_mailable_pcnt,le.populated_county_code_pcnt,le.populated_censustract_pcnt,le.populated_censusblockgroup_pcnt,le.populated_censusblock_pcnt,le.populated_congress_code_pcnt,le.populated_msacode_pcnt,le.populated_timezonecode_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_url_pcnt,le.populated_telephone_pcnt,le.populated_toll_free_number_pcnt,le.populated_fax_pcnt,le.populated_sic1_pcnt,le.populated_sic2_pcnt,le.populated_sic3_pcnt,le.populated_sic4_pcnt,le.populated_sic5_pcnt,le.populated_stdclass_pcnt,le.populated_heading1_pcnt,le.populated_heading2_pcnt,le.populated_heading3_pcnt,le.populated_heading4_pcnt,le.populated_heading5_pcnt,le.populated_business_specialty_pcnt,le.populated_sales_code_pcnt,le.populated_employee_code_pcnt,le.populated_location_type_pcnt,le.populated_parent_company_pcnt,le.populated_parent_address_pcnt,le.populated_parent_city_pcnt,le.populated_parent_state_pcnt,le.populated_parent_zip_pcnt,le.populated_parent_phone_pcnt,le.populated_stock_symbol_pcnt,le.populated_stock_exchange_pcnt,le.populated_public_pcnt,le.populated_number_of_pcs_pcnt,le.populated_square_footage_pcnt,le.populated_business_type_pcnt,le.populated_incorporation_state_pcnt,le.populated_minority_pcnt,le.populated_woman_pcnt,le.populated_government_pcnt,le.populated_small_pcnt,le.populated_home_office_pcnt,le.populated_soho_pcnt,le.populated_franchise_pcnt,le.populated_phoneable_pcnt,le.populated_prefix_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_surname_pcnt,le.populated_suffix_pcnt,le.populated_birth_year_pcnt,le.populated_ethnicity_pcnt,le.populated_gender_pcnt,le.populated_email_pcnt,le.populated_contact_title_pcnt,le.populated_year_started_pcnt,le.populated_date_added_pcnt,le.populated_validationdate_pcnt,le.populated_internal1_pcnt,le.populated_dacd_pcnt,le.populated_normcompany_type_pcnt,le.populated_normcompany_name_pcnt,le.populated_normcompany_street_pcnt,le.populated_normcompany_city_pcnt,le.populated_normcompany_state_pcnt,le.populated_normcompany_zip_pcnt,le.populated_normcompany_phone_pcnt,le.populated_clean_company_name_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_clean_phone_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_address_line1_pcnt,le.populated_prep_address_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_did,le.maxlength_did_score,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_pid,le.maxlength_record_id,le.maxlength_ein,le.maxlength_busname,le.maxlength_tradename,le.maxlength_house,le.maxlength_predirection,le.maxlength_street,le.maxlength_strtype,le.maxlength_postdirection,le.maxlength_apttype,le.maxlength_aptnbr,le.maxlength_city,le.maxlength_state,le.maxlength_zip5,le.maxlength_ziplast4,le.maxlength_dpc,le.maxlength_carrier_route,le.maxlength_address_type_code,le.maxlength_dpv_code,le.maxlength_mailable,le.maxlength_county_code,le.maxlength_censustract,le.maxlength_censusblockgroup,le.maxlength_censusblock,le.maxlength_congress_code,le.maxlength_msacode,le.maxlength_timezonecode,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_url,le.maxlength_telephone,le.maxlength_toll_free_number,le.maxlength_fax,le.maxlength_sic1,le.maxlength_sic2,le.maxlength_sic3,le.maxlength_sic4,le.maxlength_sic5,le.maxlength_stdclass,le.maxlength_heading1,le.maxlength_heading2,le.maxlength_heading3,le.maxlength_heading4,le.maxlength_heading5,le.maxlength_business_specialty,le.maxlength_sales_code,le.maxlength_employee_code,le.maxlength_location_type,le.maxlength_parent_company,le.maxlength_parent_address,le.maxlength_parent_city,le.maxlength_parent_state,le.maxlength_parent_zip,le.maxlength_parent_phone,le.maxlength_stock_symbol,le.maxlength_stock_exchange,le.maxlength_public,le.maxlength_number_of_pcs,le.maxlength_square_footage,le.maxlength_business_type,le.maxlength_incorporation_state,le.maxlength_minority,le.maxlength_woman,le.maxlength_government,le.maxlength_small,le.maxlength_home_office,le.maxlength_soho,le.maxlength_franchise,le.maxlength_phoneable,le.maxlength_prefix,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_surname,le.maxlength_suffix,le.maxlength_birth_year,le.maxlength_ethnicity,le.maxlength_gender,le.maxlength_email,le.maxlength_contact_title,le.maxlength_year_started,le.maxlength_date_added,le.maxlength_validationdate,le.maxlength_internal1,le.maxlength_dacd,le.maxlength_normcompany_type,le.maxlength_normcompany_name,le.maxlength_normcompany_street,le.maxlength_normcompany_city,le.maxlength_normcompany_state,le.maxlength_normcompany_zip,le.maxlength_normcompany_phone,le.maxlength_clean_company_name,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_clean_phone,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_address_line1,le.maxlength_prep_address_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_did,le.avelength_did_score,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_pid,le.avelength_record_id,le.avelength_ein,le.avelength_busname,le.avelength_tradename,le.avelength_house,le.avelength_predirection,le.avelength_street,le.avelength_strtype,le.avelength_postdirection,le.avelength_apttype,le.avelength_aptnbr,le.avelength_city,le.avelength_state,le.avelength_zip5,le.avelength_ziplast4,le.avelength_dpc,le.avelength_carrier_route,le.avelength_address_type_code,le.avelength_dpv_code,le.avelength_mailable,le.avelength_county_code,le.avelength_censustract,le.avelength_censusblockgroup,le.avelength_censusblock,le.avelength_congress_code,le.avelength_msacode,le.avelength_timezonecode,le.avelength_latitude,le.avelength_longitude,le.avelength_url,le.avelength_telephone,le.avelength_toll_free_number,le.avelength_fax,le.avelength_sic1,le.avelength_sic2,le.avelength_sic3,le.avelength_sic4,le.avelength_sic5,le.avelength_stdclass,le.avelength_heading1,le.avelength_heading2,le.avelength_heading3,le.avelength_heading4,le.avelength_heading5,le.avelength_business_specialty,le.avelength_sales_code,le.avelength_employee_code,le.avelength_location_type,le.avelength_parent_company,le.avelength_parent_address,le.avelength_parent_city,le.avelength_parent_state,le.avelength_parent_zip,le.avelength_parent_phone,le.avelength_stock_symbol,le.avelength_stock_exchange,le.avelength_public,le.avelength_number_of_pcs,le.avelength_square_footage,le.avelength_business_type,le.avelength_incorporation_state,le.avelength_minority,le.avelength_woman,le.avelength_government,le.avelength_small,le.avelength_home_office,le.avelength_soho,le.avelength_franchise,le.avelength_phoneable,le.avelength_prefix,le.avelength_first_name,le.avelength_middle_name,le.avelength_surname,le.avelength_suffix,le.avelength_birth_year,le.avelength_ethnicity,le.avelength_gender,le.avelength_email,le.avelength_contact_title,le.avelength_year_started,le.avelength_date_added,le.avelength_validationdate,le.avelength_internal1,le.avelength_dacd,le.avelength_normcompany_type,le.avelength_normcompany_name,le.avelength_normcompany_street,le.avelength_normcompany_city,le.avelength_normcompany_state,le.avelength_normcompany_zip,le.avelength_normcompany_phone,le.avelength_clean_company_name,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_clean_phone,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_address_line1,le.avelength_prep_address_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 160, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.seleid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.dotid),TRIM((SALT34.StrType)le.dotscore),TRIM((SALT34.StrType)le.dotweight),TRIM((SALT34.StrType)le.empid),TRIM((SALT34.StrType)le.empscore),TRIM((SALT34.StrType)le.empweight),TRIM((SALT34.StrType)le.powid),TRIM((SALT34.StrType)le.powscore),TRIM((SALT34.StrType)le.powweight),TRIM((SALT34.StrType)le.proxid),TRIM((SALT34.StrType)le.proxscore),TRIM((SALT34.StrType)le.proxweight),TRIM((SALT34.StrType)le.seleid),TRIM((SALT34.StrType)le.selescore),TRIM((SALT34.StrType)le.seleweight),TRIM((SALT34.StrType)le.orgid),TRIM((SALT34.StrType)le.orgscore),TRIM((SALT34.StrType)le.orgweight),TRIM((SALT34.StrType)le.ultid),TRIM((SALT34.StrType)le.ultscore),TRIM((SALT34.StrType)le.ultweight),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.did_score),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.record_id),TRIM((SALT34.StrType)le.ein),TRIM((SALT34.StrType)le.busname),TRIM((SALT34.StrType)le.tradename),TRIM((SALT34.StrType)le.house),TRIM((SALT34.StrType)le.predirection),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.strtype),TRIM((SALT34.StrType)le.postdirection),TRIM((SALT34.StrType)le.apttype),TRIM((SALT34.StrType)le.aptnbr),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.ziplast4),TRIM((SALT34.StrType)le.dpc),TRIM((SALT34.StrType)le.carrier_route),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.dpv_code),TRIM((SALT34.StrType)le.mailable),TRIM((SALT34.StrType)le.county_code),TRIM((SALT34.StrType)le.censustract),TRIM((SALT34.StrType)le.censusblockgroup),TRIM((SALT34.StrType)le.censusblock),TRIM((SALT34.StrType)le.congress_code),TRIM((SALT34.StrType)le.msacode),TRIM((SALT34.StrType)le.timezonecode),TRIM((SALT34.StrType)le.latitude),TRIM((SALT34.StrType)le.longitude),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.telephone),TRIM((SALT34.StrType)le.toll_free_number),TRIM((SALT34.StrType)le.fax),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.stdclass),TRIM((SALT34.StrType)le.heading1),TRIM((SALT34.StrType)le.heading2),TRIM((SALT34.StrType)le.heading3),TRIM((SALT34.StrType)le.heading4),TRIM((SALT34.StrType)le.heading5),TRIM((SALT34.StrType)le.business_specialty),TRIM((SALT34.StrType)le.sales_code),TRIM((SALT34.StrType)le.employee_code),TRIM((SALT34.StrType)le.location_type),TRIM((SALT34.StrType)le.parent_company),TRIM((SALT34.StrType)le.parent_address),TRIM((SALT34.StrType)le.parent_city),TRIM((SALT34.StrType)le.parent_state),TRIM((SALT34.StrType)le.parent_zip),TRIM((SALT34.StrType)le.parent_phone),TRIM((SALT34.StrType)le.stock_symbol),TRIM((SALT34.StrType)le.stock_exchange),TRIM((SALT34.StrType)le.public),TRIM((SALT34.StrType)le.number_of_pcs),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.business_type),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.minority),TRIM((SALT34.StrType)le.woman),TRIM((SALT34.StrType)le.government),TRIM((SALT34.StrType)le.small),TRIM((SALT34.StrType)le.home_office),TRIM((SALT34.StrType)le.soho),TRIM((SALT34.StrType)le.franchise),TRIM((SALT34.StrType)le.phoneable),TRIM((SALT34.StrType)le.prefix),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.middle_name),TRIM((SALT34.StrType)le.surname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.birth_year),TRIM((SALT34.StrType)le.ethnicity),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_added),TRIM((SALT34.StrType)le.validationdate),TRIM((SALT34.StrType)le.internal1),TRIM((SALT34.StrType)le.dacd),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.normcompany_name),TRIM((SALT34.StrType)le.normcompany_street),TRIM((SALT34.StrType)le.normcompany_city),TRIM((SALT34.StrType)le.normcompany_state),TRIM((SALT34.StrType)le.normcompany_zip),TRIM((SALT34.StrType)le.normcompany_phone),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.fips_state),TRIM((SALT34.StrType)le.fips_county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.raw_aid),TRIM((SALT34.StrType)le.ace_aid),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,160,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 160);
  SELF.FldNo2 := 1 + (C % 160);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.dotid),TRIM((SALT34.StrType)le.dotscore),TRIM((SALT34.StrType)le.dotweight),TRIM((SALT34.StrType)le.empid),TRIM((SALT34.StrType)le.empscore),TRIM((SALT34.StrType)le.empweight),TRIM((SALT34.StrType)le.powid),TRIM((SALT34.StrType)le.powscore),TRIM((SALT34.StrType)le.powweight),TRIM((SALT34.StrType)le.proxid),TRIM((SALT34.StrType)le.proxscore),TRIM((SALT34.StrType)le.proxweight),TRIM((SALT34.StrType)le.seleid),TRIM((SALT34.StrType)le.selescore),TRIM((SALT34.StrType)le.seleweight),TRIM((SALT34.StrType)le.orgid),TRIM((SALT34.StrType)le.orgscore),TRIM((SALT34.StrType)le.orgweight),TRIM((SALT34.StrType)le.ultid),TRIM((SALT34.StrType)le.ultscore),TRIM((SALT34.StrType)le.ultweight),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.did_score),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.record_id),TRIM((SALT34.StrType)le.ein),TRIM((SALT34.StrType)le.busname),TRIM((SALT34.StrType)le.tradename),TRIM((SALT34.StrType)le.house),TRIM((SALT34.StrType)le.predirection),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.strtype),TRIM((SALT34.StrType)le.postdirection),TRIM((SALT34.StrType)le.apttype),TRIM((SALT34.StrType)le.aptnbr),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.ziplast4),TRIM((SALT34.StrType)le.dpc),TRIM((SALT34.StrType)le.carrier_route),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.dpv_code),TRIM((SALT34.StrType)le.mailable),TRIM((SALT34.StrType)le.county_code),TRIM((SALT34.StrType)le.censustract),TRIM((SALT34.StrType)le.censusblockgroup),TRIM((SALT34.StrType)le.censusblock),TRIM((SALT34.StrType)le.congress_code),TRIM((SALT34.StrType)le.msacode),TRIM((SALT34.StrType)le.timezonecode),TRIM((SALT34.StrType)le.latitude),TRIM((SALT34.StrType)le.longitude),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.telephone),TRIM((SALT34.StrType)le.toll_free_number),TRIM((SALT34.StrType)le.fax),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.stdclass),TRIM((SALT34.StrType)le.heading1),TRIM((SALT34.StrType)le.heading2),TRIM((SALT34.StrType)le.heading3),TRIM((SALT34.StrType)le.heading4),TRIM((SALT34.StrType)le.heading5),TRIM((SALT34.StrType)le.business_specialty),TRIM((SALT34.StrType)le.sales_code),TRIM((SALT34.StrType)le.employee_code),TRIM((SALT34.StrType)le.location_type),TRIM((SALT34.StrType)le.parent_company),TRIM((SALT34.StrType)le.parent_address),TRIM((SALT34.StrType)le.parent_city),TRIM((SALT34.StrType)le.parent_state),TRIM((SALT34.StrType)le.parent_zip),TRIM((SALT34.StrType)le.parent_phone),TRIM((SALT34.StrType)le.stock_symbol),TRIM((SALT34.StrType)le.stock_exchange),TRIM((SALT34.StrType)le.public),TRIM((SALT34.StrType)le.number_of_pcs),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.business_type),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.minority),TRIM((SALT34.StrType)le.woman),TRIM((SALT34.StrType)le.government),TRIM((SALT34.StrType)le.small),TRIM((SALT34.StrType)le.home_office),TRIM((SALT34.StrType)le.soho),TRIM((SALT34.StrType)le.franchise),TRIM((SALT34.StrType)le.phoneable),TRIM((SALT34.StrType)le.prefix),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.middle_name),TRIM((SALT34.StrType)le.surname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.birth_year),TRIM((SALT34.StrType)le.ethnicity),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_added),TRIM((SALT34.StrType)le.validationdate),TRIM((SALT34.StrType)le.internal1),TRIM((SALT34.StrType)le.dacd),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.normcompany_name),TRIM((SALT34.StrType)le.normcompany_street),TRIM((SALT34.StrType)le.normcompany_city),TRIM((SALT34.StrType)le.normcompany_state),TRIM((SALT34.StrType)le.normcompany_zip),TRIM((SALT34.StrType)le.normcompany_phone),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.fips_state),TRIM((SALT34.StrType)le.fips_county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.raw_aid),TRIM((SALT34.StrType)le.ace_aid),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.dotid),TRIM((SALT34.StrType)le.dotscore),TRIM((SALT34.StrType)le.dotweight),TRIM((SALT34.StrType)le.empid),TRIM((SALT34.StrType)le.empscore),TRIM((SALT34.StrType)le.empweight),TRIM((SALT34.StrType)le.powid),TRIM((SALT34.StrType)le.powscore),TRIM((SALT34.StrType)le.powweight),TRIM((SALT34.StrType)le.proxid),TRIM((SALT34.StrType)le.proxscore),TRIM((SALT34.StrType)le.proxweight),TRIM((SALT34.StrType)le.seleid),TRIM((SALT34.StrType)le.selescore),TRIM((SALT34.StrType)le.seleweight),TRIM((SALT34.StrType)le.orgid),TRIM((SALT34.StrType)le.orgscore),TRIM((SALT34.StrType)le.orgweight),TRIM((SALT34.StrType)le.ultid),TRIM((SALT34.StrType)le.ultscore),TRIM((SALT34.StrType)le.ultweight),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.did_score),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT34.StrType)le.record_type),TRIM((SALT34.StrType)le.pid),TRIM((SALT34.StrType)le.record_id),TRIM((SALT34.StrType)le.ein),TRIM((SALT34.StrType)le.busname),TRIM((SALT34.StrType)le.tradename),TRIM((SALT34.StrType)le.house),TRIM((SALT34.StrType)le.predirection),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.strtype),TRIM((SALT34.StrType)le.postdirection),TRIM((SALT34.StrType)le.apttype),TRIM((SALT34.StrType)le.aptnbr),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.ziplast4),TRIM((SALT34.StrType)le.dpc),TRIM((SALT34.StrType)le.carrier_route),TRIM((SALT34.StrType)le.address_type_code),TRIM((SALT34.StrType)le.dpv_code),TRIM((SALT34.StrType)le.mailable),TRIM((SALT34.StrType)le.county_code),TRIM((SALT34.StrType)le.censustract),TRIM((SALT34.StrType)le.censusblockgroup),TRIM((SALT34.StrType)le.censusblock),TRIM((SALT34.StrType)le.congress_code),TRIM((SALT34.StrType)le.msacode),TRIM((SALT34.StrType)le.timezonecode),TRIM((SALT34.StrType)le.latitude),TRIM((SALT34.StrType)le.longitude),TRIM((SALT34.StrType)le.url),TRIM((SALT34.StrType)le.telephone),TRIM((SALT34.StrType)le.toll_free_number),TRIM((SALT34.StrType)le.fax),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.stdclass),TRIM((SALT34.StrType)le.heading1),TRIM((SALT34.StrType)le.heading2),TRIM((SALT34.StrType)le.heading3),TRIM((SALT34.StrType)le.heading4),TRIM((SALT34.StrType)le.heading5),TRIM((SALT34.StrType)le.business_specialty),TRIM((SALT34.StrType)le.sales_code),TRIM((SALT34.StrType)le.employee_code),TRIM((SALT34.StrType)le.location_type),TRIM((SALT34.StrType)le.parent_company),TRIM((SALT34.StrType)le.parent_address),TRIM((SALT34.StrType)le.parent_city),TRIM((SALT34.StrType)le.parent_state),TRIM((SALT34.StrType)le.parent_zip),TRIM((SALT34.StrType)le.parent_phone),TRIM((SALT34.StrType)le.stock_symbol),TRIM((SALT34.StrType)le.stock_exchange),TRIM((SALT34.StrType)le.public),TRIM((SALT34.StrType)le.number_of_pcs),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.business_type),TRIM((SALT34.StrType)le.incorporation_state),TRIM((SALT34.StrType)le.minority),TRIM((SALT34.StrType)le.woman),TRIM((SALT34.StrType)le.government),TRIM((SALT34.StrType)le.small),TRIM((SALT34.StrType)le.home_office),TRIM((SALT34.StrType)le.soho),TRIM((SALT34.StrType)le.franchise),TRIM((SALT34.StrType)le.phoneable),TRIM((SALT34.StrType)le.prefix),TRIM((SALT34.StrType)le.first_name),TRIM((SALT34.StrType)le.middle_name),TRIM((SALT34.StrType)le.surname),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.birth_year),TRIM((SALT34.StrType)le.ethnicity),TRIM((SALT34.StrType)le.gender),TRIM((SALT34.StrType)le.email),TRIM((SALT34.StrType)le.contact_title),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_added),TRIM((SALT34.StrType)le.validationdate),TRIM((SALT34.StrType)le.internal1),TRIM((SALT34.StrType)le.dacd),TRIM((SALT34.StrType)le.normcompany_type),TRIM((SALT34.StrType)le.normcompany_name),TRIM((SALT34.StrType)le.normcompany_street),TRIM((SALT34.StrType)le.normcompany_city),TRIM((SALT34.StrType)le.normcompany_state),TRIM((SALT34.StrType)le.normcompany_zip),TRIM((SALT34.StrType)le.normcompany_phone),TRIM((SALT34.StrType)le.clean_company_name),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.name_score),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.addr_suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dbpc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.fips_state),TRIM((SALT34.StrType)le.fips_county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat),TRIM((SALT34.StrType)le.clean_phone),TRIM((SALT34.StrType)le.raw_aid),TRIM((SALT34.StrType)le.ace_aid),TRIM((SALT34.StrType)le.prep_address_line1),TRIM((SALT34.StrType)le.prep_address_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),160*160,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'dotid'}
      ,{3,'dotscore'}
      ,{4,'dotweight'}
      ,{5,'empid'}
      ,{6,'empscore'}
      ,{7,'empweight'}
      ,{8,'powid'}
      ,{9,'powscore'}
      ,{10,'powweight'}
      ,{11,'proxid'}
      ,{12,'proxscore'}
      ,{13,'proxweight'}
      ,{14,'seleid'}
      ,{15,'selescore'}
      ,{16,'seleweight'}
      ,{17,'orgid'}
      ,{18,'orgscore'}
      ,{19,'orgweight'}
      ,{20,'ultid'}
      ,{21,'ultscore'}
      ,{22,'ultweight'}
      ,{23,'did'}
      ,{24,'did_score'}
      ,{25,'dt_first_seen'}
      ,{26,'dt_last_seen'}
      ,{27,'dt_vendor_first_reported'}
      ,{28,'dt_vendor_last_reported'}
      ,{29,'record_type'}
      ,{30,'pid'}
      ,{31,'record_id'}
      ,{32,'ein'}
      ,{33,'busname'}
      ,{34,'tradename'}
      ,{35,'house'}
      ,{36,'predirection'}
      ,{37,'street'}
      ,{38,'strtype'}
      ,{39,'postdirection'}
      ,{40,'apttype'}
      ,{41,'aptnbr'}
      ,{42,'city'}
      ,{43,'state'}
      ,{44,'zip5'}
      ,{45,'ziplast4'}
      ,{46,'dpc'}
      ,{47,'carrier_route'}
      ,{48,'address_type_code'}
      ,{49,'dpv_code'}
      ,{50,'mailable'}
      ,{51,'county_code'}
      ,{52,'censustract'}
      ,{53,'censusblockgroup'}
      ,{54,'censusblock'}
      ,{55,'congress_code'}
      ,{56,'msacode'}
      ,{57,'timezonecode'}
      ,{58,'latitude'}
      ,{59,'longitude'}
      ,{60,'url'}
      ,{61,'telephone'}
      ,{62,'toll_free_number'}
      ,{63,'fax'}
      ,{64,'sic1'}
      ,{65,'sic2'}
      ,{66,'sic3'}
      ,{67,'sic4'}
      ,{68,'sic5'}
      ,{69,'stdclass'}
      ,{70,'heading1'}
      ,{71,'heading2'}
      ,{72,'heading3'}
      ,{73,'heading4'}
      ,{74,'heading5'}
      ,{75,'business_specialty'}
      ,{76,'sales_code'}
      ,{77,'employee_code'}
      ,{78,'location_type'}
      ,{79,'parent_company'}
      ,{80,'parent_address'}
      ,{81,'parent_city'}
      ,{82,'parent_state'}
      ,{83,'parent_zip'}
      ,{84,'parent_phone'}
      ,{85,'stock_symbol'}
      ,{86,'stock_exchange'}
      ,{87,'public'}
      ,{88,'number_of_pcs'}
      ,{89,'square_footage'}
      ,{90,'business_type'}
      ,{91,'incorporation_state'}
      ,{92,'minority'}
      ,{93,'woman'}
      ,{94,'government'}
      ,{95,'small'}
      ,{96,'home_office'}
      ,{97,'soho'}
      ,{98,'franchise'}
      ,{99,'phoneable'}
      ,{100,'prefix'}
      ,{101,'first_name'}
      ,{102,'middle_name'}
      ,{103,'surname'}
      ,{104,'suffix'}
      ,{105,'birth_year'}
      ,{106,'ethnicity'}
      ,{107,'gender'}
      ,{108,'email'}
      ,{109,'contact_title'}
      ,{110,'year_started'}
      ,{111,'date_added'}
      ,{112,'validationdate'}
      ,{113,'internal1'}
      ,{114,'dacd'}
      ,{115,'normcompany_type'}
      ,{116,'normcompany_name'}
      ,{117,'normcompany_street'}
      ,{118,'normcompany_city'}
      ,{119,'normcompany_state'}
      ,{120,'normcompany_zip'}
      ,{121,'normcompany_phone'}
      ,{122,'clean_company_name'}
      ,{123,'title'}
      ,{124,'fname'}
      ,{125,'mname'}
      ,{126,'lname'}
      ,{127,'name_suffix'}
      ,{128,'name_score'}
      ,{129,'prim_range'}
      ,{130,'predir'}
      ,{131,'prim_name'}
      ,{132,'addr_suffix'}
      ,{133,'postdir'}
      ,{134,'unit_desig'}
      ,{135,'sec_range'}
      ,{136,'p_city_name'}
      ,{137,'v_city_name'}
      ,{138,'st'}
      ,{139,'zip'}
      ,{140,'zip4'}
      ,{141,'cart'}
      ,{142,'cr_sort_sz'}
      ,{143,'lot'}
      ,{144,'lot_order'}
      ,{145,'dbpc'}
      ,{146,'chk_digit'}
      ,{147,'rec_type'}
      ,{148,'fips_state'}
      ,{149,'fips_county'}
      ,{150,'geo_lat'}
      ,{151,'geo_long'}
      ,{152,'msa'}
      ,{153,'geo_blk'}
      ,{154,'geo_match'}
      ,{155,'err_stat'}
      ,{156,'clean_phone'}
      ,{157,'raw_aid'}
      ,{158,'ace_aid'}
      ,{159,'prep_address_line1'}
      ,{160,'prep_address_line_last'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT34.StrType)le.process_date),
    Fields.InValid_dotid((SALT34.StrType)le.dotid),
    Fields.InValid_dotscore((SALT34.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT34.StrType)le.dotweight),
    Fields.InValid_empid((SALT34.StrType)le.empid),
    Fields.InValid_empscore((SALT34.StrType)le.empscore),
    Fields.InValid_empweight((SALT34.StrType)le.empweight),
    Fields.InValid_powid((SALT34.StrType)le.powid),
    Fields.InValid_powscore((SALT34.StrType)le.powscore),
    Fields.InValid_powweight((SALT34.StrType)le.powweight),
    Fields.InValid_proxid((SALT34.StrType)le.proxid),
    Fields.InValid_proxscore((SALT34.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT34.StrType)le.proxweight),
    Fields.InValid_seleid((SALT34.StrType)le.seleid),
    Fields.InValid_selescore((SALT34.StrType)le.selescore),
    Fields.InValid_seleweight((SALT34.StrType)le.seleweight),
    Fields.InValid_orgid((SALT34.StrType)le.orgid),
    Fields.InValid_orgscore((SALT34.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT34.StrType)le.orgweight),
    Fields.InValid_ultid((SALT34.StrType)le.ultid),
    Fields.InValid_ultscore((SALT34.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT34.StrType)le.ultweight),
    Fields.InValid_did((SALT34.StrType)le.did),
    Fields.InValid_did_score((SALT34.StrType)le.did_score),
    Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Fields.InValid_pid((SALT34.StrType)le.pid),
    Fields.InValid_record_id((SALT34.StrType)le.record_id),
    Fields.InValid_ein((SALT34.StrType)le.ein),
    Fields.InValid_busname((SALT34.StrType)le.busname),
    Fields.InValid_tradename((SALT34.StrType)le.tradename),
    Fields.InValid_house((SALT34.StrType)le.house),
    Fields.InValid_predirection((SALT34.StrType)le.predirection),
    Fields.InValid_street((SALT34.StrType)le.street),
    Fields.InValid_strtype((SALT34.StrType)le.strtype),
    Fields.InValid_postdirection((SALT34.StrType)le.postdirection),
    Fields.InValid_apttype((SALT34.StrType)le.apttype),
    Fields.InValid_aptnbr((SALT34.StrType)le.aptnbr),
    Fields.InValid_city((SALT34.StrType)le.city),
    Fields.InValid_state((SALT34.StrType)le.state),
    Fields.InValid_zip5((SALT34.StrType)le.zip5),
    Fields.InValid_ziplast4((SALT34.StrType)le.ziplast4),
    Fields.InValid_dpc((SALT34.StrType)le.dpc),
    Fields.InValid_carrier_route((SALT34.StrType)le.carrier_route),
    Fields.InValid_address_type_code((SALT34.StrType)le.address_type_code),
    Fields.InValid_dpv_code((SALT34.StrType)le.dpv_code),
    Fields.InValid_mailable((SALT34.StrType)le.mailable),
    Fields.InValid_county_code((SALT34.StrType)le.county_code),
    Fields.InValid_censustract((SALT34.StrType)le.censustract),
    Fields.InValid_censusblockgroup((SALT34.StrType)le.censusblockgroup),
    Fields.InValid_censusblock((SALT34.StrType)le.censusblock),
    Fields.InValid_congress_code((SALT34.StrType)le.congress_code),
    Fields.InValid_msacode((SALT34.StrType)le.msacode),
    Fields.InValid_timezonecode((SALT34.StrType)le.timezonecode),
    Fields.InValid_latitude((SALT34.StrType)le.latitude),
    Fields.InValid_longitude((SALT34.StrType)le.longitude),
    Fields.InValid_url((SALT34.StrType)le.url),
    Fields.InValid_telephone((SALT34.StrType)le.telephone),
    Fields.InValid_toll_free_number((SALT34.StrType)le.toll_free_number),
    Fields.InValid_fax((SALT34.StrType)le.fax),
    Fields.InValid_sic1((SALT34.StrType)le.sic1),
    Fields.InValid_sic2((SALT34.StrType)le.sic2),
    Fields.InValid_sic3((SALT34.StrType)le.sic3),
    Fields.InValid_sic4((SALT34.StrType)le.sic4),
    Fields.InValid_sic5((SALT34.StrType)le.sic5),
    Fields.InValid_stdclass((SALT34.StrType)le.stdclass),
    Fields.InValid_heading1((SALT34.StrType)le.heading1),
    Fields.InValid_heading2((SALT34.StrType)le.heading2),
    Fields.InValid_heading3((SALT34.StrType)le.heading3),
    Fields.InValid_heading4((SALT34.StrType)le.heading4),
    Fields.InValid_heading5((SALT34.StrType)le.heading5),
    Fields.InValid_business_specialty((SALT34.StrType)le.business_specialty),
    Fields.InValid_sales_code((SALT34.StrType)le.sales_code),
    Fields.InValid_employee_code((SALT34.StrType)le.employee_code),
    Fields.InValid_location_type((SALT34.StrType)le.location_type),
    Fields.InValid_parent_company((SALT34.StrType)le.parent_company),
    Fields.InValid_parent_address((SALT34.StrType)le.parent_address),
    Fields.InValid_parent_city((SALT34.StrType)le.parent_city),
    Fields.InValid_parent_state((SALT34.StrType)le.parent_state),
    Fields.InValid_parent_zip((SALT34.StrType)le.parent_zip),
    Fields.InValid_parent_phone((SALT34.StrType)le.parent_phone),
    Fields.InValid_stock_symbol((SALT34.StrType)le.stock_symbol),
    Fields.InValid_stock_exchange((SALT34.StrType)le.stock_exchange),
    Fields.InValid_public((SALT34.StrType)le.public),
    Fields.InValid_number_of_pcs((SALT34.StrType)le.number_of_pcs),
    Fields.InValid_square_footage((SALT34.StrType)le.square_footage),
    Fields.InValid_business_type((SALT34.StrType)le.business_type),
    Fields.InValid_incorporation_state((SALT34.StrType)le.incorporation_state),
    Fields.InValid_minority((SALT34.StrType)le.minority),
    Fields.InValid_woman((SALT34.StrType)le.woman),
    Fields.InValid_government((SALT34.StrType)le.government),
    Fields.InValid_small((SALT34.StrType)le.small),
    Fields.InValid_home_office((SALT34.StrType)le.home_office),
    Fields.InValid_soho((SALT34.StrType)le.soho),
    Fields.InValid_franchise((SALT34.StrType)le.franchise),
    Fields.InValid_phoneable((SALT34.StrType)le.phoneable),
    Fields.InValid_prefix((SALT34.StrType)le.prefix),
    Fields.InValid_first_name((SALT34.StrType)le.first_name),
    Fields.InValid_middle_name((SALT34.StrType)le.middle_name),
    Fields.InValid_surname((SALT34.StrType)le.surname),
    Fields.InValid_suffix((SALT34.StrType)le.suffix),
    Fields.InValid_birth_year((SALT34.StrType)le.birth_year),
    Fields.InValid_ethnicity((SALT34.StrType)le.ethnicity),
    Fields.InValid_gender((SALT34.StrType)le.gender),
    Fields.InValid_email((SALT34.StrType)le.email),
    Fields.InValid_contact_title((SALT34.StrType)le.contact_title),
    Fields.InValid_year_started((SALT34.StrType)le.year_started),
    Fields.InValid_date_added((SALT34.StrType)le.date_added),
    Fields.InValid_validationdate((SALT34.StrType)le.validationdate),
    Fields.InValid_internal1((SALT34.StrType)le.internal1),
    Fields.InValid_dacd((SALT34.StrType)le.dacd),
    Fields.InValid_normcompany_type((SALT34.StrType)le.normcompany_type),
    Fields.InValid_normcompany_name((SALT34.StrType)le.normcompany_name),
    Fields.InValid_normcompany_street((SALT34.StrType)le.normcompany_street),
    Fields.InValid_normcompany_city((SALT34.StrType)le.normcompany_city),
    Fields.InValid_normcompany_state((SALT34.StrType)le.normcompany_state),
    Fields.InValid_normcompany_zip((SALT34.StrType)le.normcompany_zip),
    Fields.InValid_normcompany_phone((SALT34.StrType)le.normcompany_phone),
    Fields.InValid_clean_company_name((SALT34.StrType)le.clean_company_name),
    Fields.InValid_title((SALT34.StrType)le.title),
    Fields.InValid_fname((SALT34.StrType)le.fname),
    Fields.InValid_mname((SALT34.StrType)le.mname),
    Fields.InValid_lname((SALT34.StrType)le.lname),
    Fields.InValid_name_suffix((SALT34.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT34.StrType)le.name_score),
    Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Fields.InValid_predir((SALT34.StrType)le.predir),
    Fields.InValid_prim_name((SALT34.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT34.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT34.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT34.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name),
    Fields.InValid_st((SALT34.StrType)le.st),
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_zip4((SALT34.StrType)le.zip4),
    Fields.InValid_cart((SALT34.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT34.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT34.StrType)le.lot),
    Fields.InValid_lot_order((SALT34.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT34.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT34.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT34.StrType)le.rec_type),
    Fields.InValid_fips_state((SALT34.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT34.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT34.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT34.StrType)le.geo_long),
    Fields.InValid_msa((SALT34.StrType)le.msa),
    Fields.InValid_geo_blk((SALT34.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT34.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT34.StrType)le.err_stat),
    Fields.InValid_clean_phone((SALT34.StrType)le.clean_phone),
    Fields.InValid_raw_aid((SALT34.StrType)le.raw_aid),
    Fields.InValid_ace_aid((SALT34.StrType)le.ace_aid),
    Fields.InValid_prep_address_line1((SALT34.StrType)le.prep_address_line1),
    Fields.InValid_prep_address_line_last((SALT34.StrType)le.prep_address_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,160,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_pid(TotalErrors.ErrorNum),Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_ein(TotalErrors.ErrorNum),Fields.InValidMessage_busname(TotalErrors.ErrorNum),Fields.InValidMessage_tradename(TotalErrors.ErrorNum),Fields.InValidMessage_house(TotalErrors.ErrorNum),Fields.InValidMessage_predirection(TotalErrors.ErrorNum),Fields.InValidMessage_street(TotalErrors.ErrorNum),Fields.InValidMessage_strtype(TotalErrors.ErrorNum),Fields.InValidMessage_postdirection(TotalErrors.ErrorNum),Fields.InValidMessage_apttype(TotalErrors.ErrorNum),Fields.InValidMessage_aptnbr(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_ziplast4(TotalErrors.ErrorNum),Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_route(TotalErrors.ErrorNum),Fields.InValidMessage_address_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_dpv_code(TotalErrors.ErrorNum),Fields.InValidMessage_mailable(TotalErrors.ErrorNum),Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Fields.InValidMessage_censustract(TotalErrors.ErrorNum),Fields.InValidMessage_censusblockgroup(TotalErrors.ErrorNum),Fields.InValidMessage_censusblock(TotalErrors.ErrorNum),Fields.InValidMessage_congress_code(TotalErrors.ErrorNum),Fields.InValidMessage_msacode(TotalErrors.ErrorNum),Fields.InValidMessage_timezonecode(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_toll_free_number(TotalErrors.ErrorNum),Fields.InValidMessage_fax(TotalErrors.ErrorNum),Fields.InValidMessage_sic1(TotalErrors.ErrorNum),Fields.InValidMessage_sic2(TotalErrors.ErrorNum),Fields.InValidMessage_sic3(TotalErrors.ErrorNum),Fields.InValidMessage_sic4(TotalErrors.ErrorNum),Fields.InValidMessage_sic5(TotalErrors.ErrorNum),Fields.InValidMessage_stdclass(TotalErrors.ErrorNum),Fields.InValidMessage_heading1(TotalErrors.ErrorNum),Fields.InValidMessage_heading2(TotalErrors.ErrorNum),Fields.InValidMessage_heading3(TotalErrors.ErrorNum),Fields.InValidMessage_heading4(TotalErrors.ErrorNum),Fields.InValidMessage_heading5(TotalErrors.ErrorNum),Fields.InValidMessage_business_specialty(TotalErrors.ErrorNum),Fields.InValidMessage_sales_code(TotalErrors.ErrorNum),Fields.InValidMessage_employee_code(TotalErrors.ErrorNum),Fields.InValidMessage_location_type(TotalErrors.ErrorNum),Fields.InValidMessage_parent_company(TotalErrors.ErrorNum),Fields.InValidMessage_parent_address(TotalErrors.ErrorNum),Fields.InValidMessage_parent_city(TotalErrors.ErrorNum),Fields.InValidMessage_parent_state(TotalErrors.ErrorNum),Fields.InValidMessage_parent_zip(TotalErrors.ErrorNum),Fields.InValidMessage_parent_phone(TotalErrors.ErrorNum),Fields.InValidMessage_stock_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_public(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_pcs(TotalErrors.ErrorNum),Fields.InValidMessage_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_business_type(TotalErrors.ErrorNum),Fields.InValidMessage_incorporation_state(TotalErrors.ErrorNum),Fields.InValidMessage_minority(TotalErrors.ErrorNum),Fields.InValidMessage_woman(TotalErrors.ErrorNum),Fields.InValidMessage_government(TotalErrors.ErrorNum),Fields.InValidMessage_small(TotalErrors.ErrorNum),Fields.InValidMessage_home_office(TotalErrors.ErrorNum),Fields.InValidMessage_soho(TotalErrors.ErrorNum),Fields.InValidMessage_franchise(TotalErrors.ErrorNum),Fields.InValidMessage_phoneable(TotalErrors.ErrorNum),Fields.InValidMessage_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_surname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_birth_year(TotalErrors.ErrorNum),Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_contact_title(TotalErrors.ErrorNum),Fields.InValidMessage_year_started(TotalErrors.ErrorNum),Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_validationdate(TotalErrors.ErrorNum),Fields.InValidMessage_internal1(TotalErrors.ErrorNum),Fields.InValidMessage_dacd(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_type(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_name(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_street(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_city(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_state(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_zip(TotalErrors.ErrorNum),Fields.InValidMessage_normcompany_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Fields.InValidMessage_prep_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_prep_address_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have seleid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT34.MOD_ClusterStats.Counts(h,seleid);
EXPORT ClusterSrc := SALT34.MOD_ClusterStats.Sources(h,seleid,source);
END;
