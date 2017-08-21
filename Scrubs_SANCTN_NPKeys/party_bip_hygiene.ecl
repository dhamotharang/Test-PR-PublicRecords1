IMPORT ut,SALT33;
EXPORT party_bip_hygiene(dataset(party_bip_layout_SANCTN_NPKeys) h) := MODULE
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
    populated_dbcode_pcnt := AVE(GROUP,IF(h.dbcode = (TYPEOF(h.dbcode))'',0,100));
    maxlength_dbcode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)));
    avelength_dbcode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)),h.dbcode<>(typeof(h.dbcode))'');
    populated_incident_num_pcnt := AVE(GROUP,IF(h.incident_num = (TYPEOF(h.incident_num))'',0,100));
    maxlength_incident_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)));
    avelength_incident_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)),h.incident_num<>(typeof(h.incident_num))'');
    populated_party_num_pcnt := AVE(GROUP,IF(h.party_num = (TYPEOF(h.party_num))'',0,100));
    maxlength_party_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_num)));
    avelength_party_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_num)),h.party_num<>(typeof(h.party_num))'');
    populated_sanctions_pcnt := AVE(GROUP,IF(h.sanctions = (TYPEOF(h.sanctions))'',0,100));
    maxlength_sanctions := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sanctions)));
    avelength_sanctions := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sanctions)),h.sanctions<>(typeof(h.sanctions))'');
    populated_additional_info_pcnt := AVE(GROUP,IF(h.additional_info = (TYPEOF(h.additional_info))'',0,100));
    maxlength_additional_info := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.additional_info)));
    avelength_additional_info := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.additional_info)),h.additional_info<>(typeof(h.additional_info))'');
    populated_party_firm_pcnt := AVE(GROUP,IF(h.party_firm = (TYPEOF(h.party_firm))'',0,100));
    maxlength_party_firm := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_firm)));
    avelength_party_firm := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_firm)),h.party_firm<>(typeof(h.party_firm))'');
    populated_tin_pcnt := AVE(GROUP,IF(h.tin = (TYPEOF(h.tin))'',0,100));
    maxlength_tin := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tin)));
    avelength_tin := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tin)),h.tin<>(typeof(h.tin))'');
    populated_name_first_pcnt := AVE(GROUP,IF(h.name_first = (TYPEOF(h.name_first))'',0,100));
    maxlength_name_first := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_first)));
    avelength_name_first := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_first)),h.name_first<>(typeof(h.name_first))'');
    populated_name_last_pcnt := AVE(GROUP,IF(h.name_last = (TYPEOF(h.name_last))'',0,100));
    maxlength_name_last := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_last)));
    avelength_name_last := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_last)),h.name_last<>(typeof(h.name_last))'');
    populated_name_middle_pcnt := AVE(GROUP,IF(h.name_middle = (TYPEOF(h.name_middle))'',0,100));
    maxlength_name_middle := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_middle)));
    avelength_name_middle := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_middle)),h.name_middle<>(typeof(h.name_middle))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_nickname_pcnt := AVE(GROUP,IF(h.nickname = (TYPEOF(h.nickname))'',0,100));
    maxlength_nickname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nickname)));
    avelength_nickname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nickname)),h.nickname<>(typeof(h.nickname))'');
    populated_party_position_pcnt := AVE(GROUP,IF(h.party_position = (TYPEOF(h.party_position))'',0,100));
    maxlength_party_position := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_position)));
    avelength_party_position := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_position)),h.party_position<>(typeof(h.party_position))'');
    populated_party_employer_pcnt := AVE(GROUP,IF(h.party_employer = (TYPEOF(h.party_employer))'',0,100));
    maxlength_party_employer := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_employer)));
    avelength_party_employer := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_employer)),h.party_employer<>(typeof(h.party_employer))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_party_type_pcnt := AVE(GROUP,IF(h.party_type = (TYPEOF(h.party_type))'',0,100));
    maxlength_party_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_type)));
    avelength_party_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_type)),h.party_type<>(typeof(h.party_type))'');
    populated_party_key_pcnt := AVE(GROUP,IF(h.party_key = (TYPEOF(h.party_key))'',0,100));
    maxlength_party_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_key)));
    avelength_party_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_key)),h.party_key<>(typeof(h.party_key))'');
    populated_int_key_pcnt := AVE(GROUP,IF(h.int_key = (TYPEOF(h.int_key))'',0,100));
    maxlength_int_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.int_key)));
    avelength_int_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.int_key)),h.int_key<>(typeof(h.int_key))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_akaname_pcnt := AVE(GROUP,IF(h.akaname = (TYPEOF(h.akaname))'',0,100));
    maxlength_akaname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akaname)));
    avelength_akaname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akaname)),h.akaname<>(typeof(h.akaname))'');
    populated_dbaname_pcnt := AVE(GROUP,IF(h.dbaname = (TYPEOF(h.dbaname))'',0,100));
    maxlength_dbaname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbaname)));
    avelength_dbaname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbaname)),h.dbaname<>(typeof(h.dbaname))'');
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
    populated_enh_did_src_pcnt := AVE(GROUP,IF(h.enh_did_src = (TYPEOF(h.enh_did_src))'',0,100));
    maxlength_enh_did_src := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.enh_did_src)));
    avelength_enh_did_src := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.enh_did_src)),h.enh_did_src<>(typeof(h.enh_did_src))'');
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
    populated_ename_pcnt := AVE(GROUP,IF(h.ename = (TYPEOF(h.ename))'',0,100));
    maxlength_ename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ename)));
    avelength_ename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ename)),h.ename<>(typeof(h.ename))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_batch_pcnt *   0.00 / 100 + T.Populated_dbcode_pcnt *   0.00 / 100 + T.Populated_incident_num_pcnt *   0.00 / 100 + T.Populated_party_num_pcnt *   0.00 / 100 + T.Populated_sanctions_pcnt *   0.00 / 100 + T.Populated_additional_info_pcnt *   0.00 / 100 + T.Populated_party_firm_pcnt *   0.00 / 100 + T.Populated_tin_pcnt *   0.00 / 100 + T.Populated_name_first_pcnt *   0.00 / 100 + T.Populated_name_last_pcnt *   0.00 / 100 + T.Populated_name_middle_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_nickname_pcnt *   0.00 / 100 + T.Populated_party_position_pcnt *   0.00 / 100 + T.Populated_party_employer_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_party_type_pcnt *   0.00 / 100 + T.Populated_party_key_pcnt *   0.00 / 100 + T.Populated_int_key_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_akaname_pcnt *   0.00 / 100 + T.Populated_dbaname_pcnt *   0.00 / 100 + T.Populated_aid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_enh_did_src_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_ename_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_addr_rec_type_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_source_rec_id_pcnt*ri.Populated_source_rec_id_pcnt *   0.00 / 10000 + le.Populated_batch_pcnt*ri.Populated_batch_pcnt *   0.00 / 10000 + le.Populated_dbcode_pcnt*ri.Populated_dbcode_pcnt *   0.00 / 10000 + le.Populated_incident_num_pcnt*ri.Populated_incident_num_pcnt *   0.00 / 10000 + le.Populated_party_num_pcnt*ri.Populated_party_num_pcnt *   0.00 / 10000 + le.Populated_sanctions_pcnt*ri.Populated_sanctions_pcnt *   0.00 / 10000 + le.Populated_additional_info_pcnt*ri.Populated_additional_info_pcnt *   0.00 / 10000 + le.Populated_party_firm_pcnt*ri.Populated_party_firm_pcnt *   0.00 / 10000 + le.Populated_tin_pcnt*ri.Populated_tin_pcnt *   0.00 / 10000 + le.Populated_name_first_pcnt*ri.Populated_name_first_pcnt *   0.00 / 10000 + le.Populated_name_last_pcnt*ri.Populated_name_last_pcnt *   0.00 / 10000 + le.Populated_name_middle_pcnt*ri.Populated_name_middle_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_nickname_pcnt*ri.Populated_nickname_pcnt *   0.00 / 10000 + le.Populated_party_position_pcnt*ri.Populated_party_position_pcnt *   0.00 / 10000 + le.Populated_party_employer_pcnt*ri.Populated_party_employer_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_address_pcnt*ri.Populated_address_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_party_type_pcnt*ri.Populated_party_type_pcnt *   0.00 / 10000 + le.Populated_party_key_pcnt*ri.Populated_party_key_pcnt *   0.00 / 10000 + le.Populated_int_key_pcnt*ri.Populated_int_key_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_akaname_pcnt*ri.Populated_akaname_pcnt *   0.00 / 10000 + le.Populated_dbaname_pcnt*ri.Populated_dbaname_pcnt *   0.00 / 10000 + le.Populated_aid_pcnt*ri.Populated_aid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_bdid_score_pcnt*ri.Populated_bdid_score_pcnt *   0.00 / 10000 + le.Populated_enh_did_src_pcnt*ri.Populated_enh_did_src_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_ename_pcnt*ri.Populated_ename_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_addr_rec_type_pcnt*ri.Populated_addr_rec_type_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_cbsa_pcnt*ri.Populated_cbsa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','batch','dbcode','incident_num','party_num','sanctions','additional_info','party_firm','tin','name_first','name_last','name_middle','suffix','nickname','party_position','party_employer','ssn','dob','address','city','state','zip','party_type','party_key','int_key','phone','akaname','dbaname','aid','did','did_score','bdid','bdid_score','enh_did_src','title','fname','mname','lname','name_suffix','name_score','ename','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt,le.populated_batch_pcnt,le.populated_dbcode_pcnt,le.populated_incident_num_pcnt,le.populated_party_num_pcnt,le.populated_sanctions_pcnt,le.populated_additional_info_pcnt,le.populated_party_firm_pcnt,le.populated_tin_pcnt,le.populated_name_first_pcnt,le.populated_name_last_pcnt,le.populated_name_middle_pcnt,le.populated_suffix_pcnt,le.populated_nickname_pcnt,le.populated_party_position_pcnt,le.populated_party_employer_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_party_type_pcnt,le.populated_party_key_pcnt,le.populated_int_key_pcnt,le.populated_phone_pcnt,le.populated_akaname_pcnt,le.populated_dbaname_pcnt,le.populated_aid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_enh_did_src_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_ename_pcnt,le.populated_cname_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_addr_rec_type_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_cbsa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id,le.maxlength_batch,le.maxlength_dbcode,le.maxlength_incident_num,le.maxlength_party_num,le.maxlength_sanctions,le.maxlength_additional_info,le.maxlength_party_firm,le.maxlength_tin,le.maxlength_name_first,le.maxlength_name_last,le.maxlength_name_middle,le.maxlength_suffix,le.maxlength_nickname,le.maxlength_party_position,le.maxlength_party_employer,le.maxlength_ssn,le.maxlength_dob,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_party_type,le.maxlength_party_key,le.maxlength_int_key,le.maxlength_phone,le.maxlength_akaname,le.maxlength_dbaname,le.maxlength_aid,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_enh_did_src,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_ename,le.maxlength_cname,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_addr_rec_type,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_cbsa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id,le.avelength_batch,le.avelength_dbcode,le.avelength_incident_num,le.avelength_party_num,le.avelength_sanctions,le.avelength_additional_info,le.avelength_party_firm,le.avelength_tin,le.avelength_name_first,le.avelength_name_last,le.avelength_name_middle,le.avelength_suffix,le.avelength_nickname,le.avelength_party_position,le.avelength_party_employer,le.avelength_ssn,le.avelength_dob,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_party_type,le.avelength_party_key,le.avelength_int_key,le.avelength_phone,le.avelength_akaname,le.avelength_dbaname,le.avelength_aid,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_enh_did_src,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_ename,le.avelength_cname,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_fips_state,le.avelength_fips_county,le.avelength_addr_rec_type,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_cbsa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.dbcode;
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.sanctions),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.party_firm),TRIM((SALT33.StrType)le.tin),TRIM((SALT33.StrType)le.name_first),TRIM((SALT33.StrType)le.name_last),TRIM((SALT33.StrType)le.name_middle),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.nickname),TRIM((SALT33.StrType)le.party_position),TRIM((SALT33.StrType)le.party_employer),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.address),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.party_type),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), ''),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.dbaname),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.enh_did_src),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.ename),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.sanctions),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.party_firm),TRIM((SALT33.StrType)le.tin),TRIM((SALT33.StrType)le.name_first),TRIM((SALT33.StrType)le.name_last),TRIM((SALT33.StrType)le.name_middle),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.nickname),TRIM((SALT33.StrType)le.party_position),TRIM((SALT33.StrType)le.party_employer),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.address),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.party_type),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), ''),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.dbaname),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.enh_did_src),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.ename),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT33.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT33.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT33.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT33.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT33.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT33.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT33.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT33.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT33.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT33.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT33.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT33.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT33.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT33.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT33.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT33.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT33.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT33.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT33.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT33.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT33.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT33.StrType)le.source_rec_id), ''),TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.sanctions),TRIM((SALT33.StrType)le.additional_info),TRIM((SALT33.StrType)le.party_firm),TRIM((SALT33.StrType)le.tin),TRIM((SALT33.StrType)le.name_first),TRIM((SALT33.StrType)le.name_last),TRIM((SALT33.StrType)le.name_middle),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.nickname),TRIM((SALT33.StrType)le.party_position),TRIM((SALT33.StrType)le.party_employer),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.address),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.party_type),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), ''),IF (le.int_key <> 0,TRIM((SALT33.StrType)le.int_key), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.dbaname),IF (le.aid <> 0,TRIM((SALT33.StrType)le.aid), ''),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT33.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT33.StrType)le.bdid_score), ''),TRIM((SALT33.StrType)le.enh_did_src),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.ename),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.fips_state),TRIM((SALT33.StrType)le.fips_county),TRIM((SALT33.StrType)le.addr_rec_type),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.cbsa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{24,'dbcode'}
      ,{25,'incident_num'}
      ,{26,'party_num'}
      ,{27,'sanctions'}
      ,{28,'additional_info'}
      ,{29,'party_firm'}
      ,{30,'tin'}
      ,{31,'name_first'}
      ,{32,'name_last'}
      ,{33,'name_middle'}
      ,{34,'suffix'}
      ,{35,'nickname'}
      ,{36,'party_position'}
      ,{37,'party_employer'}
      ,{38,'ssn'}
      ,{39,'dob'}
      ,{40,'address'}
      ,{41,'city'}
      ,{42,'state'}
      ,{43,'zip'}
      ,{44,'party_type'}
      ,{45,'party_key'}
      ,{46,'int_key'}
      ,{47,'phone'}
      ,{48,'akaname'}
      ,{49,'dbaname'}
      ,{50,'aid'}
      ,{51,'did'}
      ,{52,'did_score'}
      ,{53,'bdid'}
      ,{54,'bdid_score'}
      ,{55,'enh_did_src'}
      ,{56,'title'}
      ,{57,'fname'}
      ,{58,'mname'}
      ,{59,'lname'}
      ,{60,'name_suffix'}
      ,{61,'name_score'}
      ,{62,'ename'}
      ,{63,'cname'}
      ,{64,'prim_range'}
      ,{65,'predir'}
      ,{66,'prim_name'}
      ,{67,'addr_suffix'}
      ,{68,'postdir'}
      ,{69,'unit_desig'}
      ,{70,'sec_range'}
      ,{71,'p_city_name'}
      ,{72,'v_city_name'}
      ,{73,'st'}
      ,{74,'zip5'}
      ,{75,'zip4'}
      ,{76,'fips_state'}
      ,{77,'fips_county'}
      ,{78,'addr_rec_type'}
      ,{79,'geo_lat'}
      ,{80,'geo_long'}
      ,{81,'cbsa'}
      ,{82,'geo_blk'}
      ,{83,'geo_match'}
      ,{84,'cart'}
      ,{85,'cr_sort_sz'}
      ,{86,'lot'}
      ,{87,'lot_order'}
      ,{88,'dpbc'}
      ,{89,'chk_digit'}
      ,{90,'err_stat'}],SALT33.MAC_Character_Counts.Field_Identification);
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
    party_bip_Fields.InValid_dotid((SALT33.StrType)le.dotid),
    party_bip_Fields.InValid_dotscore((SALT33.StrType)le.dotscore),
    party_bip_Fields.InValid_dotweight((SALT33.StrType)le.dotweight),
    party_bip_Fields.InValid_empid((SALT33.StrType)le.empid),
    party_bip_Fields.InValid_empscore((SALT33.StrType)le.empscore),
    party_bip_Fields.InValid_empweight((SALT33.StrType)le.empweight),
    party_bip_Fields.InValid_powid((SALT33.StrType)le.powid),
    party_bip_Fields.InValid_powscore((SALT33.StrType)le.powscore),
    party_bip_Fields.InValid_powweight((SALT33.StrType)le.powweight),
    party_bip_Fields.InValid_proxid((SALT33.StrType)le.proxid),
    party_bip_Fields.InValid_proxscore((SALT33.StrType)le.proxscore),
    party_bip_Fields.InValid_proxweight((SALT33.StrType)le.proxweight),
    party_bip_Fields.InValid_seleid((SALT33.StrType)le.seleid),
    party_bip_Fields.InValid_selescore((SALT33.StrType)le.selescore),
    party_bip_Fields.InValid_seleweight((SALT33.StrType)le.seleweight),
    party_bip_Fields.InValid_orgid((SALT33.StrType)le.orgid),
    party_bip_Fields.InValid_orgscore((SALT33.StrType)le.orgscore),
    party_bip_Fields.InValid_orgweight((SALT33.StrType)le.orgweight),
    party_bip_Fields.InValid_ultid((SALT33.StrType)le.ultid),
    party_bip_Fields.InValid_ultscore((SALT33.StrType)le.ultscore),
    party_bip_Fields.InValid_ultweight((SALT33.StrType)le.ultweight),
    party_bip_Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id),
    party_bip_Fields.InValid_batch((SALT33.StrType)le.batch),
    party_bip_Fields.InValid_dbcode((SALT33.StrType)le.dbcode),
    party_bip_Fields.InValid_incident_num((SALT33.StrType)le.incident_num),
    party_bip_Fields.InValid_party_num((SALT33.StrType)le.party_num),
    party_bip_Fields.InValid_sanctions((SALT33.StrType)le.sanctions),
    party_bip_Fields.InValid_additional_info((SALT33.StrType)le.additional_info),
    party_bip_Fields.InValid_party_firm((SALT33.StrType)le.party_firm),
    party_bip_Fields.InValid_tin((SALT33.StrType)le.tin),
    party_bip_Fields.InValid_name_first((SALT33.StrType)le.name_first),
    party_bip_Fields.InValid_name_last((SALT33.StrType)le.name_last),
    party_bip_Fields.InValid_name_middle((SALT33.StrType)le.name_middle),
    party_bip_Fields.InValid_suffix((SALT33.StrType)le.suffix),
    party_bip_Fields.InValid_nickname((SALT33.StrType)le.nickname),
    party_bip_Fields.InValid_party_position((SALT33.StrType)le.party_position),
    party_bip_Fields.InValid_party_employer((SALT33.StrType)le.party_employer),
    party_bip_Fields.InValid_ssn((SALT33.StrType)le.ssn),
    party_bip_Fields.InValid_dob((SALT33.StrType)le.dob),
    party_bip_Fields.InValid_address((SALT33.StrType)le.address),
    party_bip_Fields.InValid_city((SALT33.StrType)le.city),
    party_bip_Fields.InValid_state((SALT33.StrType)le.state),
    party_bip_Fields.InValid_zip((SALT33.StrType)le.zip),
    party_bip_Fields.InValid_party_type((SALT33.StrType)le.party_type),
    party_bip_Fields.InValid_party_key((SALT33.StrType)le.party_key),
    party_bip_Fields.InValid_int_key((SALT33.StrType)le.int_key),
    party_bip_Fields.InValid_phone((SALT33.StrType)le.phone),
    party_bip_Fields.InValid_akaname((SALT33.StrType)le.akaname),
    party_bip_Fields.InValid_dbaname((SALT33.StrType)le.dbaname),
    party_bip_Fields.InValid_aid((SALT33.StrType)le.aid),
    party_bip_Fields.InValid_did((SALT33.StrType)le.did),
    party_bip_Fields.InValid_did_score((SALT33.StrType)le.did_score),
    party_bip_Fields.InValid_bdid((SALT33.StrType)le.bdid),
    party_bip_Fields.InValid_bdid_score((SALT33.StrType)le.bdid_score),
    party_bip_Fields.InValid_enh_did_src((SALT33.StrType)le.enh_did_src),
    party_bip_Fields.InValid_title((SALT33.StrType)le.title),
    party_bip_Fields.InValid_fname((SALT33.StrType)le.fname),
    party_bip_Fields.InValid_mname((SALT33.StrType)le.mname),
    party_bip_Fields.InValid_lname((SALT33.StrType)le.lname),
    party_bip_Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix),
    party_bip_Fields.InValid_name_score((SALT33.StrType)le.name_score),
    party_bip_Fields.InValid_ename((SALT33.StrType)le.ename),
    party_bip_Fields.InValid_cname((SALT33.StrType)le.cname),
    party_bip_Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    party_bip_Fields.InValid_predir((SALT33.StrType)le.predir),
    party_bip_Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    party_bip_Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    party_bip_Fields.InValid_postdir((SALT33.StrType)le.postdir),
    party_bip_Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    party_bip_Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    party_bip_Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    party_bip_Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    party_bip_Fields.InValid_st((SALT33.StrType)le.st),
    party_bip_Fields.InValid_zip5((SALT33.StrType)le.zip5),
    party_bip_Fields.InValid_zip4((SALT33.StrType)le.zip4),
    party_bip_Fields.InValid_fips_state((SALT33.StrType)le.fips_state),
    party_bip_Fields.InValid_fips_county((SALT33.StrType)le.fips_county),
    party_bip_Fields.InValid_addr_rec_type((SALT33.StrType)le.addr_rec_type),
    party_bip_Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    party_bip_Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    party_bip_Fields.InValid_cbsa((SALT33.StrType)le.cbsa),
    party_bip_Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    party_bip_Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    party_bip_Fields.InValid_cart((SALT33.StrType)le.cart),
    party_bip_Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    party_bip_Fields.InValid_lot((SALT33.StrType)le.lot),
    party_bip_Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    party_bip_Fields.InValid_dpbc((SALT33.StrType)le.dpbc),
    party_bip_Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    party_bip_Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.dbcode := le.dbcode;
END;
Errors := NORMALIZE(h,90,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.dbcode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,dbcode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.dbcode;
  FieldNme := party_bip_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_Char','Unknown','Unknown','Invalid_Num','Unknown','Unknown','Unknown','Invalid_Suffix','Unknown','Unknown','Unknown','Invalid_Num','Invalid_CurrentDate','Unknown','Unknown','Invalid_State','Invalid_Zip','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Enh_Did_Src','Unknown','Unknown','Unknown','Unknown','Invalid_Suffix','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,party_bip_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_empid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_powid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_batch(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dbcode(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_incident_num(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_num(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_sanctions(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_additional_info(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_firm(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_tin(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_name_first(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_name_last(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_name_middle(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_nickname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_position(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_employer(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dob(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_address(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_city(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_state(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_zip(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_type(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_party_key(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_int_key(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_phone(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_akaname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dbaname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_aid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_did(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_enh_did_src(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_title(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_fname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_mname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_lname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_ename(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_cname(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_predir(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_st(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_addr_rec_type(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_cart(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_lot(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),party_bip_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.dbcode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
