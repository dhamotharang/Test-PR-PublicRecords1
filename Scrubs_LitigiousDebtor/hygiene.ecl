IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_LitigiousDebtor) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_recid_cnt := COUNT(GROUP,h.recid <> (TYPEOF(h.recid))'');
    populated_recid_pcnt := AVE(GROUP,IF(h.recid = (TYPEOF(h.recid))'',0,100));
    maxlength_recid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recid)));
    avelength_recid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recid)),h.recid<>(typeof(h.recid))'');
    populated_courtstate_cnt := COUNT(GROUP,h.courtstate <> (TYPEOF(h.courtstate))'');
    populated_courtstate_pcnt := AVE(GROUP,IF(h.courtstate = (TYPEOF(h.courtstate))'',0,100));
    maxlength_courtstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtstate)));
    avelength_courtstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtstate)),h.courtstate<>(typeof(h.courtstate))'');
    populated_courtid_cnt := COUNT(GROUP,h.courtid <> (TYPEOF(h.courtid))'');
    populated_courtid_pcnt := AVE(GROUP,IF(h.courtid = (TYPEOF(h.courtid))'',0,100));
    maxlength_courtid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)));
    avelength_courtid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)),h.courtid<>(typeof(h.courtid))'');
    populated_courtname_cnt := COUNT(GROUP,h.courtname <> (TYPEOF(h.courtname))'');
    populated_courtname_pcnt := AVE(GROUP,IF(h.courtname = (TYPEOF(h.courtname))'',0,100));
    maxlength_courtname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)));
    avelength_courtname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)),h.courtname<>(typeof(h.courtname))'');
    populated_docketnumber_cnt := COUNT(GROUP,h.docketnumber <> (TYPEOF(h.docketnumber))'');
    populated_docketnumber_pcnt := AVE(GROUP,IF(h.docketnumber = (TYPEOF(h.docketnumber))'',0,100));
    maxlength_docketnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketnumber)));
    avelength_docketnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketnumber)),h.docketnumber<>(typeof(h.docketnumber))'');
    populated_officename_cnt := COUNT(GROUP,h.officename <> (TYPEOF(h.officename))'');
    populated_officename_pcnt := AVE(GROUP,IF(h.officename = (TYPEOF(h.officename))'',0,100));
    maxlength_officename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officename)));
    avelength_officename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officename)),h.officename<>(typeof(h.officename))'');
    populated_asofdate_cnt := COUNT(GROUP,h.asofdate <> (TYPEOF(h.asofdate))'');
    populated_asofdate_pcnt := AVE(GROUP,IF(h.asofdate = (TYPEOF(h.asofdate))'',0,100));
    maxlength_asofdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asofdate)));
    avelength_asofdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asofdate)),h.asofdate<>(typeof(h.asofdate))'');
    populated_classcode_cnt := COUNT(GROUP,h.classcode <> (TYPEOF(h.classcode))'');
    populated_classcode_pcnt := AVE(GROUP,IF(h.classcode = (TYPEOF(h.classcode))'',0,100));
    maxlength_classcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classcode)));
    avelength_classcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classcode)),h.classcode<>(typeof(h.classcode))'');
    populated_casecaption_cnt := COUNT(GROUP,h.casecaption <> (TYPEOF(h.casecaption))'');
    populated_casecaption_pcnt := AVE(GROUP,IF(h.casecaption = (TYPEOF(h.casecaption))'',0,100));
    maxlength_casecaption := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casecaption)));
    avelength_casecaption := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casecaption)),h.casecaption<>(typeof(h.casecaption))'');
    populated_datefiled_cnt := COUNT(GROUP,h.datefiled <> (TYPEOF(h.datefiled))'');
    populated_datefiled_pcnt := AVE(GROUP,IF(h.datefiled = (TYPEOF(h.datefiled))'',0,100));
    maxlength_datefiled := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datefiled)));
    avelength_datefiled := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datefiled)),h.datefiled<>(typeof(h.datefiled))'');
    populated_judgetitle_cnt := COUNT(GROUP,h.judgetitle <> (TYPEOF(h.judgetitle))'');
    populated_judgetitle_pcnt := AVE(GROUP,IF(h.judgetitle = (TYPEOF(h.judgetitle))'',0,100));
    maxlength_judgetitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judgetitle)));
    avelength_judgetitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judgetitle)),h.judgetitle<>(typeof(h.judgetitle))'');
    populated_judgename_cnt := COUNT(GROUP,h.judgename <> (TYPEOF(h.judgename))'');
    populated_judgename_pcnt := AVE(GROUP,IF(h.judgename = (TYPEOF(h.judgename))'',0,100));
    maxlength_judgename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judgename)));
    avelength_judgename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judgename)),h.judgename<>(typeof(h.judgename))'');
    populated_referredtojudgetitle_cnt := COUNT(GROUP,h.referredtojudgetitle <> (TYPEOF(h.referredtojudgetitle))'');
    populated_referredtojudgetitle_pcnt := AVE(GROUP,IF(h.referredtojudgetitle = (TYPEOF(h.referredtojudgetitle))'',0,100));
    maxlength_referredtojudgetitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.referredtojudgetitle)));
    avelength_referredtojudgetitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.referredtojudgetitle)),h.referredtojudgetitle<>(typeof(h.referredtojudgetitle))'');
    populated_referredtojudge_cnt := COUNT(GROUP,h.referredtojudge <> (TYPEOF(h.referredtojudge))'');
    populated_referredtojudge_pcnt := AVE(GROUP,IF(h.referredtojudge = (TYPEOF(h.referredtojudge))'',0,100));
    maxlength_referredtojudge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.referredtojudge)));
    avelength_referredtojudge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.referredtojudge)),h.referredtojudge<>(typeof(h.referredtojudge))'');
    populated_jurydemand_cnt := COUNT(GROUP,h.jurydemand <> (TYPEOF(h.jurydemand))'');
    populated_jurydemand_pcnt := AVE(GROUP,IF(h.jurydemand = (TYPEOF(h.jurydemand))'',0,100));
    maxlength_jurydemand := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.jurydemand)));
    avelength_jurydemand := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.jurydemand)),h.jurydemand<>(typeof(h.jurydemand))'');
    populated_demandamount_cnt := COUNT(GROUP,h.demandamount <> (TYPEOF(h.demandamount))'');
    populated_demandamount_pcnt := AVE(GROUP,IF(h.demandamount = (TYPEOF(h.demandamount))'',0,100));
    maxlength_demandamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.demandamount)));
    avelength_demandamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.demandamount)),h.demandamount<>(typeof(h.demandamount))'');
    populated_suitnaturecode_cnt := COUNT(GROUP,h.suitnaturecode <> (TYPEOF(h.suitnaturecode))'');
    populated_suitnaturecode_pcnt := AVE(GROUP,IF(h.suitnaturecode = (TYPEOF(h.suitnaturecode))'',0,100));
    maxlength_suitnaturecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suitnaturecode)));
    avelength_suitnaturecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suitnaturecode)),h.suitnaturecode<>(typeof(h.suitnaturecode))'');
    populated_suitnaturedesc_cnt := COUNT(GROUP,h.suitnaturedesc <> (TYPEOF(h.suitnaturedesc))'');
    populated_suitnaturedesc_pcnt := AVE(GROUP,IF(h.suitnaturedesc = (TYPEOF(h.suitnaturedesc))'',0,100));
    maxlength_suitnaturedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suitnaturedesc)));
    avelength_suitnaturedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suitnaturedesc)),h.suitnaturedesc<>(typeof(h.suitnaturedesc))'');
    populated_leaddocketnumber_cnt := COUNT(GROUP,h.leaddocketnumber <> (TYPEOF(h.leaddocketnumber))'');
    populated_leaddocketnumber_pcnt := AVE(GROUP,IF(h.leaddocketnumber = (TYPEOF(h.leaddocketnumber))'',0,100));
    maxlength_leaddocketnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.leaddocketnumber)));
    avelength_leaddocketnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.leaddocketnumber)),h.leaddocketnumber<>(typeof(h.leaddocketnumber))'');
    populated_jurisdiction_cnt := COUNT(GROUP,h.jurisdiction <> (TYPEOF(h.jurisdiction))'');
    populated_jurisdiction_pcnt := AVE(GROUP,IF(h.jurisdiction = (TYPEOF(h.jurisdiction))'',0,100));
    maxlength_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.jurisdiction)));
    avelength_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.jurisdiction)),h.jurisdiction<>(typeof(h.jurisdiction))'');
    populated_cause_cnt := COUNT(GROUP,h.cause <> (TYPEOF(h.cause))'');
    populated_cause_pcnt := AVE(GROUP,IF(h.cause = (TYPEOF(h.cause))'',0,100));
    maxlength_cause := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cause)));
    avelength_cause := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cause)),h.cause<>(typeof(h.cause))'');
    populated_statute_cnt := COUNT(GROUP,h.statute <> (TYPEOF(h.statute))'');
    populated_statute_pcnt := AVE(GROUP,IF(h.statute = (TYPEOF(h.statute))'',0,100));
    maxlength_statute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statute)));
    avelength_statute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statute)),h.statute<>(typeof(h.statute))'');
    populated_ca_cnt := COUNT(GROUP,h.ca <> (TYPEOF(h.ca))'');
    populated_ca_pcnt := AVE(GROUP,IF(h.ca = (TYPEOF(h.ca))'',0,100));
    maxlength_ca := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca)));
    avelength_ca := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ca)),h.ca<>(typeof(h.ca))'');
    populated_caseclosed_cnt := COUNT(GROUP,h.caseclosed <> (TYPEOF(h.caseclosed))'');
    populated_caseclosed_pcnt := AVE(GROUP,IF(h.caseclosed = (TYPEOF(h.caseclosed))'',0,100));
    maxlength_caseclosed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseclosed)));
    avelength_caseclosed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseclosed)),h.caseclosed<>(typeof(h.caseclosed))'');
    populated_dateretrieved_cnt := COUNT(GROUP,h.dateretrieved <> (TYPEOF(h.dateretrieved))'');
    populated_dateretrieved_pcnt := AVE(GROUP,IF(h.dateretrieved = (TYPEOF(h.dateretrieved))'',0,100));
    maxlength_dateretrieved := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateretrieved)));
    avelength_dateretrieved := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateretrieved)),h.dateretrieved<>(typeof(h.dateretrieved))'');
    populated_otherdocketnumber_cnt := COUNT(GROUP,h.otherdocketnumber <> (TYPEOF(h.otherdocketnumber))'');
    populated_otherdocketnumber_pcnt := AVE(GROUP,IF(h.otherdocketnumber = (TYPEOF(h.otherdocketnumber))'',0,100));
    maxlength_otherdocketnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.otherdocketnumber)));
    avelength_otherdocketnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.otherdocketnumber)),h.otherdocketnumber<>(typeof(h.otherdocketnumber))'');
    populated_litigantname_cnt := COUNT(GROUP,h.litigantname <> (TYPEOF(h.litigantname))'');
    populated_litigantname_pcnt := AVE(GROUP,IF(h.litigantname = (TYPEOF(h.litigantname))'',0,100));
    maxlength_litigantname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.litigantname)));
    avelength_litigantname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.litigantname)),h.litigantname<>(typeof(h.litigantname))'');
    populated_litigantlabel_cnt := COUNT(GROUP,h.litigantlabel <> (TYPEOF(h.litigantlabel))'');
    populated_litigantlabel_pcnt := AVE(GROUP,IF(h.litigantlabel = (TYPEOF(h.litigantlabel))'',0,100));
    maxlength_litigantlabel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.litigantlabel)));
    avelength_litigantlabel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.litigantlabel)),h.litigantlabel<>(typeof(h.litigantlabel))'');
    populated_layoutcode_cnt := COUNT(GROUP,h.layoutcode <> (TYPEOF(h.layoutcode))'');
    populated_layoutcode_pcnt := AVE(GROUP,IF(h.layoutcode = (TYPEOF(h.layoutcode))'',0,100));
    maxlength_layoutcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.layoutcode)));
    avelength_layoutcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.layoutcode)),h.layoutcode<>(typeof(h.layoutcode))'');
    populated_terminationdate_cnt := COUNT(GROUP,h.terminationdate <> (TYPEOF(h.terminationdate))'');
    populated_terminationdate_pcnt := AVE(GROUP,IF(h.terminationdate = (TYPEOF(h.terminationdate))'',0,100));
    maxlength_terminationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.terminationdate)));
    avelength_terminationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.terminationdate)),h.terminationdate<>(typeof(h.terminationdate))'');
    populated_attorneyname_cnt := COUNT(GROUP,h.attorneyname <> (TYPEOF(h.attorneyname))'');
    populated_attorneyname_pcnt := AVE(GROUP,IF(h.attorneyname = (TYPEOF(h.attorneyname))'',0,100));
    maxlength_attorneyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneyname)));
    avelength_attorneyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneyname)),h.attorneyname<>(typeof(h.attorneyname))'');
    populated_attorneylabel_cnt := COUNT(GROUP,h.attorneylabel <> (TYPEOF(h.attorneylabel))'');
    populated_attorneylabel_pcnt := AVE(GROUP,IF(h.attorneylabel = (TYPEOF(h.attorneylabel))'',0,100));
    maxlength_attorneylabel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneylabel)));
    avelength_attorneylabel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneylabel)),h.attorneylabel<>(typeof(h.attorneylabel))'');
    populated_firmname_cnt := COUNT(GROUP,h.firmname <> (TYPEOF(h.firmname))'');
    populated_firmname_pcnt := AVE(GROUP,IF(h.firmname = (TYPEOF(h.firmname))'',0,100));
    maxlength_firmname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmname)));
    avelength_firmname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firmname)),h.firmname<>(typeof(h.firmname))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_addtlinfo_cnt := COUNT(GROUP,h.addtlinfo <> (TYPEOF(h.addtlinfo))'');
    populated_addtlinfo_pcnt := AVE(GROUP,IF(h.addtlinfo = (TYPEOF(h.addtlinfo))'',0,100));
    maxlength_addtlinfo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addtlinfo)));
    avelength_addtlinfo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addtlinfo)),h.addtlinfo<>(typeof(h.addtlinfo))'');
    populated_termdate_cnt := COUNT(GROUP,h.termdate <> (TYPEOF(h.termdate))'');
    populated_termdate_pcnt := AVE(GROUP,IF(h.termdate = (TYPEOF(h.termdate))'',0,100));
    maxlength_termdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.termdate)));
    avelength_termdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.termdate)),h.termdate<>(typeof(h.termdate))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_causecode_cnt := COUNT(GROUP,h.causecode <> (TYPEOF(h.causecode))'');
    populated_causecode_pcnt := AVE(GROUP,IF(h.causecode = (TYPEOF(h.causecode))'',0,100));
    maxlength_causecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.causecode)));
    avelength_causecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.causecode)),h.causecode<>(typeof(h.causecode))'');
    populated_judge_title_cnt := COUNT(GROUP,h.judge_title <> (TYPEOF(h.judge_title))'');
    populated_judge_title_pcnt := AVE(GROUP,IF(h.judge_title = (TYPEOF(h.judge_title))'',0,100));
    maxlength_judge_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_title)));
    avelength_judge_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_title)),h.judge_title<>(typeof(h.judge_title))'');
    populated_judge_fname_cnt := COUNT(GROUP,h.judge_fname <> (TYPEOF(h.judge_fname))'');
    populated_judge_fname_pcnt := AVE(GROUP,IF(h.judge_fname = (TYPEOF(h.judge_fname))'',0,100));
    maxlength_judge_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_fname)));
    avelength_judge_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_fname)),h.judge_fname<>(typeof(h.judge_fname))'');
    populated_judge_mname_cnt := COUNT(GROUP,h.judge_mname <> (TYPEOF(h.judge_mname))'');
    populated_judge_mname_pcnt := AVE(GROUP,IF(h.judge_mname = (TYPEOF(h.judge_mname))'',0,100));
    maxlength_judge_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_mname)));
    avelength_judge_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_mname)),h.judge_mname<>(typeof(h.judge_mname))'');
    populated_judge_lname_cnt := COUNT(GROUP,h.judge_lname <> (TYPEOF(h.judge_lname))'');
    populated_judge_lname_pcnt := AVE(GROUP,IF(h.judge_lname = (TYPEOF(h.judge_lname))'',0,100));
    maxlength_judge_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_lname)));
    avelength_judge_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_lname)),h.judge_lname<>(typeof(h.judge_lname))'');
    populated_judge_suffix_cnt := COUNT(GROUP,h.judge_suffix <> (TYPEOF(h.judge_suffix))'');
    populated_judge_suffix_pcnt := AVE(GROUP,IF(h.judge_suffix = (TYPEOF(h.judge_suffix))'',0,100));
    maxlength_judge_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_suffix)));
    avelength_judge_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_suffix)),h.judge_suffix<>(typeof(h.judge_suffix))'');
    populated_judge_score_cnt := COUNT(GROUP,h.judge_score <> (TYPEOF(h.judge_score))'');
    populated_judge_score_pcnt := AVE(GROUP,IF(h.judge_score = (TYPEOF(h.judge_score))'',0,100));
    maxlength_judge_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_score)));
    avelength_judge_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judge_score)),h.judge_score<>(typeof(h.judge_score))'');
    populated_business_person_cnt := COUNT(GROUP,h.business_person <> (TYPEOF(h.business_person))'');
    populated_business_person_pcnt := AVE(GROUP,IF(h.business_person = (TYPEOF(h.business_person))'',0,100));
    maxlength_business_person := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_person)));
    avelength_business_person := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_person)),h.business_person<>(typeof(h.business_person))'');
    populated_debtor_cnt := COUNT(GROUP,h.debtor <> (TYPEOF(h.debtor))'');
    populated_debtor_pcnt := AVE(GROUP,IF(h.debtor = (TYPEOF(h.debtor))'',0,100));
    maxlength_debtor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor)));
    avelength_debtor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor)),h.debtor<>(typeof(h.debtor))'');
    populated_debtor_title_cnt := COUNT(GROUP,h.debtor_title <> (TYPEOF(h.debtor_title))'');
    populated_debtor_title_pcnt := AVE(GROUP,IF(h.debtor_title = (TYPEOF(h.debtor_title))'',0,100));
    maxlength_debtor_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_title)));
    avelength_debtor_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_title)),h.debtor_title<>(typeof(h.debtor_title))'');
    populated_debtor_fname_cnt := COUNT(GROUP,h.debtor_fname <> (TYPEOF(h.debtor_fname))'');
    populated_debtor_fname_pcnt := AVE(GROUP,IF(h.debtor_fname = (TYPEOF(h.debtor_fname))'',0,100));
    maxlength_debtor_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_fname)));
    avelength_debtor_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_fname)),h.debtor_fname<>(typeof(h.debtor_fname))'');
    populated_debtor_mname_cnt := COUNT(GROUP,h.debtor_mname <> (TYPEOF(h.debtor_mname))'');
    populated_debtor_mname_pcnt := AVE(GROUP,IF(h.debtor_mname = (TYPEOF(h.debtor_mname))'',0,100));
    maxlength_debtor_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_mname)));
    avelength_debtor_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_mname)),h.debtor_mname<>(typeof(h.debtor_mname))'');
    populated_debtor_lname_cnt := COUNT(GROUP,h.debtor_lname <> (TYPEOF(h.debtor_lname))'');
    populated_debtor_lname_pcnt := AVE(GROUP,IF(h.debtor_lname = (TYPEOF(h.debtor_lname))'',0,100));
    maxlength_debtor_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_lname)));
    avelength_debtor_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_lname)),h.debtor_lname<>(typeof(h.debtor_lname))'');
    populated_debtor_suffix_cnt := COUNT(GROUP,h.debtor_suffix <> (TYPEOF(h.debtor_suffix))'');
    populated_debtor_suffix_pcnt := AVE(GROUP,IF(h.debtor_suffix = (TYPEOF(h.debtor_suffix))'',0,100));
    maxlength_debtor_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_suffix)));
    avelength_debtor_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_suffix)),h.debtor_suffix<>(typeof(h.debtor_suffix))'');
    populated_debtor_score_cnt := COUNT(GROUP,h.debtor_score <> (TYPEOF(h.debtor_score))'');
    populated_debtor_score_pcnt := AVE(GROUP,IF(h.debtor_score = (TYPEOF(h.debtor_score))'',0,100));
    maxlength_debtor_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_score)));
    avelength_debtor_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debtor_score)),h.debtor_score<>(typeof(h.debtor_score))'');
    populated_attorney_title_cnt := COUNT(GROUP,h.attorney_title <> (TYPEOF(h.attorney_title))'');
    populated_attorney_title_pcnt := AVE(GROUP,IF(h.attorney_title = (TYPEOF(h.attorney_title))'',0,100));
    maxlength_attorney_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_title)));
    avelength_attorney_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_title)),h.attorney_title<>(typeof(h.attorney_title))'');
    populated_attorney_fname_cnt := COUNT(GROUP,h.attorney_fname <> (TYPEOF(h.attorney_fname))'');
    populated_attorney_fname_pcnt := AVE(GROUP,IF(h.attorney_fname = (TYPEOF(h.attorney_fname))'',0,100));
    maxlength_attorney_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_fname)));
    avelength_attorney_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_fname)),h.attorney_fname<>(typeof(h.attorney_fname))'');
    populated_attorney_mname_cnt := COUNT(GROUP,h.attorney_mname <> (TYPEOF(h.attorney_mname))'');
    populated_attorney_mname_pcnt := AVE(GROUP,IF(h.attorney_mname = (TYPEOF(h.attorney_mname))'',0,100));
    maxlength_attorney_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_mname)));
    avelength_attorney_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_mname)),h.attorney_mname<>(typeof(h.attorney_mname))'');
    populated_attorney_lname_cnt := COUNT(GROUP,h.attorney_lname <> (TYPEOF(h.attorney_lname))'');
    populated_attorney_lname_pcnt := AVE(GROUP,IF(h.attorney_lname = (TYPEOF(h.attorney_lname))'',0,100));
    maxlength_attorney_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_lname)));
    avelength_attorney_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_lname)),h.attorney_lname<>(typeof(h.attorney_lname))'');
    populated_attorney_suffix_cnt := COUNT(GROUP,h.attorney_suffix <> (TYPEOF(h.attorney_suffix))'');
    populated_attorney_suffix_pcnt := AVE(GROUP,IF(h.attorney_suffix = (TYPEOF(h.attorney_suffix))'',0,100));
    maxlength_attorney_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_suffix)));
    avelength_attorney_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_suffix)),h.attorney_suffix<>(typeof(h.attorney_suffix))'');
    populated_attorney_score_cnt := COUNT(GROUP,h.attorney_score <> (TYPEOF(h.attorney_score))'');
    populated_attorney_score_pcnt := AVE(GROUP,IF(h.attorney_score = (TYPEOF(h.attorney_score))'',0,100));
    maxlength_attorney_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_score)));
    avelength_attorney_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorney_score)),h.attorney_score<>(typeof(h.attorney_score))'');
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
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
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
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_recid_pcnt *   0.00 / 100 + T.Populated_courtstate_pcnt *   0.00 / 100 + T.Populated_courtid_pcnt *   0.00 / 100 + T.Populated_courtname_pcnt *   0.00 / 100 + T.Populated_docketnumber_pcnt *   0.00 / 100 + T.Populated_officename_pcnt *   0.00 / 100 + T.Populated_asofdate_pcnt *   0.00 / 100 + T.Populated_classcode_pcnt *   0.00 / 100 + T.Populated_casecaption_pcnt *   0.00 / 100 + T.Populated_datefiled_pcnt *   0.00 / 100 + T.Populated_judgetitle_pcnt *   0.00 / 100 + T.Populated_judgename_pcnt *   0.00 / 100 + T.Populated_referredtojudgetitle_pcnt *   0.00 / 100 + T.Populated_referredtojudge_pcnt *   0.00 / 100 + T.Populated_jurydemand_pcnt *   0.00 / 100 + T.Populated_demandamount_pcnt *   0.00 / 100 + T.Populated_suitnaturecode_pcnt *   0.00 / 100 + T.Populated_suitnaturedesc_pcnt *   0.00 / 100 + T.Populated_leaddocketnumber_pcnt *   0.00 / 100 + T.Populated_jurisdiction_pcnt *   0.00 / 100 + T.Populated_cause_pcnt *   0.00 / 100 + T.Populated_statute_pcnt *   0.00 / 100 + T.Populated_ca_pcnt *   0.00 / 100 + T.Populated_caseclosed_pcnt *   0.00 / 100 + T.Populated_dateretrieved_pcnt *   0.00 / 100 + T.Populated_otherdocketnumber_pcnt *   0.00 / 100 + T.Populated_litigantname_pcnt *   0.00 / 100 + T.Populated_litigantlabel_pcnt *   0.00 / 100 + T.Populated_layoutcode_pcnt *   0.00 / 100 + T.Populated_terminationdate_pcnt *   0.00 / 100 + T.Populated_attorneyname_pcnt *   0.00 / 100 + T.Populated_attorneylabel_pcnt *   0.00 / 100 + T.Populated_firmname_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_addtlinfo_pcnt *   0.00 / 100 + T.Populated_termdate_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_causecode_pcnt *   0.00 / 100 + T.Populated_judge_title_pcnt *   0.00 / 100 + T.Populated_judge_fname_pcnt *   0.00 / 100 + T.Populated_judge_mname_pcnt *   0.00 / 100 + T.Populated_judge_lname_pcnt *   0.00 / 100 + T.Populated_judge_suffix_pcnt *   0.00 / 100 + T.Populated_judge_score_pcnt *   0.00 / 100 + T.Populated_business_person_pcnt *   0.00 / 100 + T.Populated_debtor_pcnt *   0.00 / 100 + T.Populated_debtor_title_pcnt *   0.00 / 100 + T.Populated_debtor_fname_pcnt *   0.00 / 100 + T.Populated_debtor_mname_pcnt *   0.00 / 100 + T.Populated_debtor_lname_pcnt *   0.00 / 100 + T.Populated_debtor_suffix_pcnt *   0.00 / 100 + T.Populated_debtor_score_pcnt *   0.00 / 100 + T.Populated_attorney_title_pcnt *   0.00 / 100 + T.Populated_attorney_fname_pcnt *   0.00 / 100 + T.Populated_attorney_mname_pcnt *   0.00 / 100 + T.Populated_attorney_lname_pcnt *   0.00 / 100 + T.Populated_attorney_suffix_pcnt *   0.00 / 100 + T.Populated_attorney_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','recid','courtstate','courtid','courtname','docketnumber','officename','asofdate','classcode','casecaption','datefiled','judgetitle','judgename','referredtojudgetitle','referredtojudge','jurydemand','demandamount','suitnaturecode','suitnaturedesc','leaddocketnumber','jurisdiction','cause','statute','ca','caseclosed','dateretrieved','otherdocketnumber','litigantname','litigantlabel','layoutcode','terminationdate','attorneyname','attorneylabel','firmname','address','city','state','zipcode','country','addtlinfo','termdate','bdid','did','causecode','judge_title','judge_fname','judge_mname','judge_lname','judge_suffix','judge_score','business_person','debtor','debtor_title','debtor_fname','debtor_mname','debtor_lname','debtor_suffix','debtor_score','attorney_title','attorney_fname','attorney_mname','attorney_lname','attorney_suffix','attorney_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_recid_pcnt,le.populated_courtstate_pcnt,le.populated_courtid_pcnt,le.populated_courtname_pcnt,le.populated_docketnumber_pcnt,le.populated_officename_pcnt,le.populated_asofdate_pcnt,le.populated_classcode_pcnt,le.populated_casecaption_pcnt,le.populated_datefiled_pcnt,le.populated_judgetitle_pcnt,le.populated_judgename_pcnt,le.populated_referredtojudgetitle_pcnt,le.populated_referredtojudge_pcnt,le.populated_jurydemand_pcnt,le.populated_demandamount_pcnt,le.populated_suitnaturecode_pcnt,le.populated_suitnaturedesc_pcnt,le.populated_leaddocketnumber_pcnt,le.populated_jurisdiction_pcnt,le.populated_cause_pcnt,le.populated_statute_pcnt,le.populated_ca_pcnt,le.populated_caseclosed_pcnt,le.populated_dateretrieved_pcnt,le.populated_otherdocketnumber_pcnt,le.populated_litigantname_pcnt,le.populated_litigantlabel_pcnt,le.populated_layoutcode_pcnt,le.populated_terminationdate_pcnt,le.populated_attorneyname_pcnt,le.populated_attorneylabel_pcnt,le.populated_firmname_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_country_pcnt,le.populated_addtlinfo_pcnt,le.populated_termdate_pcnt,le.populated_bdid_pcnt,le.populated_did_pcnt,le.populated_causecode_pcnt,le.populated_judge_title_pcnt,le.populated_judge_fname_pcnt,le.populated_judge_mname_pcnt,le.populated_judge_lname_pcnt,le.populated_judge_suffix_pcnt,le.populated_judge_score_pcnt,le.populated_business_person_pcnt,le.populated_debtor_pcnt,le.populated_debtor_title_pcnt,le.populated_debtor_fname_pcnt,le.populated_debtor_mname_pcnt,le.populated_debtor_lname_pcnt,le.populated_debtor_suffix_pcnt,le.populated_debtor_score_pcnt,le.populated_attorney_title_pcnt,le.populated_attorney_fname_pcnt,le.populated_attorney_mname_pcnt,le.populated_attorney_lname_pcnt,le.populated_attorney_suffix_pcnt,le.populated_attorney_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_recid,le.maxlength_courtstate,le.maxlength_courtid,le.maxlength_courtname,le.maxlength_docketnumber,le.maxlength_officename,le.maxlength_asofdate,le.maxlength_classcode,le.maxlength_casecaption,le.maxlength_datefiled,le.maxlength_judgetitle,le.maxlength_judgename,le.maxlength_referredtojudgetitle,le.maxlength_referredtojudge,le.maxlength_jurydemand,le.maxlength_demandamount,le.maxlength_suitnaturecode,le.maxlength_suitnaturedesc,le.maxlength_leaddocketnumber,le.maxlength_jurisdiction,le.maxlength_cause,le.maxlength_statute,le.maxlength_ca,le.maxlength_caseclosed,le.maxlength_dateretrieved,le.maxlength_otherdocketnumber,le.maxlength_litigantname,le.maxlength_litigantlabel,le.maxlength_layoutcode,le.maxlength_terminationdate,le.maxlength_attorneyname,le.maxlength_attorneylabel,le.maxlength_firmname,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_country,le.maxlength_addtlinfo,le.maxlength_termdate,le.maxlength_bdid,le.maxlength_did,le.maxlength_causecode,le.maxlength_judge_title,le.maxlength_judge_fname,le.maxlength_judge_mname,le.maxlength_judge_lname,le.maxlength_judge_suffix,le.maxlength_judge_score,le.maxlength_business_person,le.maxlength_debtor,le.maxlength_debtor_title,le.maxlength_debtor_fname,le.maxlength_debtor_mname,le.maxlength_debtor_lname,le.maxlength_debtor_suffix,le.maxlength_debtor_score,le.maxlength_attorney_title,le.maxlength_attorney_fname,le.maxlength_attorney_mname,le.maxlength_attorney_lname,le.maxlength_attorney_suffix,le.maxlength_attorney_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_recid,le.avelength_courtstate,le.avelength_courtid,le.avelength_courtname,le.avelength_docketnumber,le.avelength_officename,le.avelength_asofdate,le.avelength_classcode,le.avelength_casecaption,le.avelength_datefiled,le.avelength_judgetitle,le.avelength_judgename,le.avelength_referredtojudgetitle,le.avelength_referredtojudge,le.avelength_jurydemand,le.avelength_demandamount,le.avelength_suitnaturecode,le.avelength_suitnaturedesc,le.avelength_leaddocketnumber,le.avelength_jurisdiction,le.avelength_cause,le.avelength_statute,le.avelength_ca,le.avelength_caseclosed,le.avelength_dateretrieved,le.avelength_otherdocketnumber,le.avelength_litigantname,le.avelength_litigantlabel,le.avelength_layoutcode,le.avelength_terminationdate,le.avelength_attorneyname,le.avelength_attorneylabel,le.avelength_firmname,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_country,le.avelength_addtlinfo,le.avelength_termdate,le.avelength_bdid,le.avelength_did,le.avelength_causecode,le.avelength_judge_title,le.avelength_judge_fname,le.avelength_judge_mname,le.avelength_judge_lname,le.avelength_judge_suffix,le.avelength_judge_score,le.avelength_business_person,le.avelength_debtor,le.avelength_debtor_title,le.avelength_debtor_fname,le.avelength_debtor_mname,le.avelength_debtor_lname,le.avelength_debtor_suffix,le.avelength_debtor_score,le.avelength_attorney_title,le.avelength_attorney_fname,le.avelength_attorney_mname,le.avelength_attorney_lname,le.avelength_attorney_suffix,le.avelength_attorney_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 95, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.recid),TRIM((SALT311.StrType)le.courtstate),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.officename),TRIM((SALT311.StrType)le.asofdate),TRIM((SALT311.StrType)le.classcode),TRIM((SALT311.StrType)le.casecaption),TRIM((SALT311.StrType)le.datefiled),TRIM((SALT311.StrType)le.judgetitle),TRIM((SALT311.StrType)le.judgename),TRIM((SALT311.StrType)le.referredtojudgetitle),TRIM((SALT311.StrType)le.referredtojudge),TRIM((SALT311.StrType)le.jurydemand),TRIM((SALT311.StrType)le.demandamount),TRIM((SALT311.StrType)le.suitnaturecode),TRIM((SALT311.StrType)le.suitnaturedesc),TRIM((SALT311.StrType)le.leaddocketnumber),TRIM((SALT311.StrType)le.jurisdiction),TRIM((SALT311.StrType)le.cause),TRIM((SALT311.StrType)le.statute),TRIM((SALT311.StrType)le.ca),TRIM((SALT311.StrType)le.caseclosed),TRIM((SALT311.StrType)le.dateretrieved),TRIM((SALT311.StrType)le.otherdocketnumber),TRIM((SALT311.StrType)le.litigantname),TRIM((SALT311.StrType)le.litigantlabel),TRIM((SALT311.StrType)le.layoutcode),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.attorneylabel),TRIM((SALT311.StrType)le.firmname),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.addtlinfo),TRIM((SALT311.StrType)le.termdate),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.causecode),TRIM((SALT311.StrType)le.judge_title),TRIM((SALT311.StrType)le.judge_fname),TRIM((SALT311.StrType)le.judge_mname),TRIM((SALT311.StrType)le.judge_lname),TRIM((SALT311.StrType)le.judge_suffix),TRIM((SALT311.StrType)le.judge_score),TRIM((SALT311.StrType)le.business_person),TRIM((SALT311.StrType)le.debtor),TRIM((SALT311.StrType)le.debtor_title),TRIM((SALT311.StrType)le.debtor_fname),TRIM((SALT311.StrType)le.debtor_mname),TRIM((SALT311.StrType)le.debtor_lname),TRIM((SALT311.StrType)le.debtor_suffix),TRIM((SALT311.StrType)le.debtor_score),TRIM((SALT311.StrType)le.attorney_title),TRIM((SALT311.StrType)le.attorney_fname),TRIM((SALT311.StrType)le.attorney_mname),TRIM((SALT311.StrType)le.attorney_lname),TRIM((SALT311.StrType)le.attorney_suffix),TRIM((SALT311.StrType)le.attorney_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,95,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 95);
  SELF.FldNo2 := 1 + (C % 95);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.recid),TRIM((SALT311.StrType)le.courtstate),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.officename),TRIM((SALT311.StrType)le.asofdate),TRIM((SALT311.StrType)le.classcode),TRIM((SALT311.StrType)le.casecaption),TRIM((SALT311.StrType)le.datefiled),TRIM((SALT311.StrType)le.judgetitle),TRIM((SALT311.StrType)le.judgename),TRIM((SALT311.StrType)le.referredtojudgetitle),TRIM((SALT311.StrType)le.referredtojudge),TRIM((SALT311.StrType)le.jurydemand),TRIM((SALT311.StrType)le.demandamount),TRIM((SALT311.StrType)le.suitnaturecode),TRIM((SALT311.StrType)le.suitnaturedesc),TRIM((SALT311.StrType)le.leaddocketnumber),TRIM((SALT311.StrType)le.jurisdiction),TRIM((SALT311.StrType)le.cause),TRIM((SALT311.StrType)le.statute),TRIM((SALT311.StrType)le.ca),TRIM((SALT311.StrType)le.caseclosed),TRIM((SALT311.StrType)le.dateretrieved),TRIM((SALT311.StrType)le.otherdocketnumber),TRIM((SALT311.StrType)le.litigantname),TRIM((SALT311.StrType)le.litigantlabel),TRIM((SALT311.StrType)le.layoutcode),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.attorneylabel),TRIM((SALT311.StrType)le.firmname),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.addtlinfo),TRIM((SALT311.StrType)le.termdate),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.causecode),TRIM((SALT311.StrType)le.judge_title),TRIM((SALT311.StrType)le.judge_fname),TRIM((SALT311.StrType)le.judge_mname),TRIM((SALT311.StrType)le.judge_lname),TRIM((SALT311.StrType)le.judge_suffix),TRIM((SALT311.StrType)le.judge_score),TRIM((SALT311.StrType)le.business_person),TRIM((SALT311.StrType)le.debtor),TRIM((SALT311.StrType)le.debtor_title),TRIM((SALT311.StrType)le.debtor_fname),TRIM((SALT311.StrType)le.debtor_mname),TRIM((SALT311.StrType)le.debtor_lname),TRIM((SALT311.StrType)le.debtor_suffix),TRIM((SALT311.StrType)le.debtor_score),TRIM((SALT311.StrType)le.attorney_title),TRIM((SALT311.StrType)le.attorney_fname),TRIM((SALT311.StrType)le.attorney_mname),TRIM((SALT311.StrType)le.attorney_lname),TRIM((SALT311.StrType)le.attorney_suffix),TRIM((SALT311.StrType)le.attorney_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.recid),TRIM((SALT311.StrType)le.courtstate),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.officename),TRIM((SALT311.StrType)le.asofdate),TRIM((SALT311.StrType)le.classcode),TRIM((SALT311.StrType)le.casecaption),TRIM((SALT311.StrType)le.datefiled),TRIM((SALT311.StrType)le.judgetitle),TRIM((SALT311.StrType)le.judgename),TRIM((SALT311.StrType)le.referredtojudgetitle),TRIM((SALT311.StrType)le.referredtojudge),TRIM((SALT311.StrType)le.jurydemand),TRIM((SALT311.StrType)le.demandamount),TRIM((SALT311.StrType)le.suitnaturecode),TRIM((SALT311.StrType)le.suitnaturedesc),TRIM((SALT311.StrType)le.leaddocketnumber),TRIM((SALT311.StrType)le.jurisdiction),TRIM((SALT311.StrType)le.cause),TRIM((SALT311.StrType)le.statute),TRIM((SALT311.StrType)le.ca),TRIM((SALT311.StrType)le.caseclosed),TRIM((SALT311.StrType)le.dateretrieved),TRIM((SALT311.StrType)le.otherdocketnumber),TRIM((SALT311.StrType)le.litigantname),TRIM((SALT311.StrType)le.litigantlabel),TRIM((SALT311.StrType)le.layoutcode),TRIM((SALT311.StrType)le.terminationdate),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.attorneylabel),TRIM((SALT311.StrType)le.firmname),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.addtlinfo),TRIM((SALT311.StrType)le.termdate),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.causecode),TRIM((SALT311.StrType)le.judge_title),TRIM((SALT311.StrType)le.judge_fname),TRIM((SALT311.StrType)le.judge_mname),TRIM((SALT311.StrType)le.judge_lname),TRIM((SALT311.StrType)le.judge_suffix),TRIM((SALT311.StrType)le.judge_score),TRIM((SALT311.StrType)le.business_person),TRIM((SALT311.StrType)le.debtor),TRIM((SALT311.StrType)le.debtor_title),TRIM((SALT311.StrType)le.debtor_fname),TRIM((SALT311.StrType)le.debtor_mname),TRIM((SALT311.StrType)le.debtor_lname),TRIM((SALT311.StrType)le.debtor_suffix),TRIM((SALT311.StrType)le.debtor_score),TRIM((SALT311.StrType)le.attorney_title),TRIM((SALT311.StrType)le.attorney_fname),TRIM((SALT311.StrType)le.attorney_mname),TRIM((SALT311.StrType)le.attorney_lname),TRIM((SALT311.StrType)le.attorney_suffix),TRIM((SALT311.StrType)le.attorney_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),95*95,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'record_type'}
      ,{6,'recid'}
      ,{7,'courtstate'}
      ,{8,'courtid'}
      ,{9,'courtname'}
      ,{10,'docketnumber'}
      ,{11,'officename'}
      ,{12,'asofdate'}
      ,{13,'classcode'}
      ,{14,'casecaption'}
      ,{15,'datefiled'}
      ,{16,'judgetitle'}
      ,{17,'judgename'}
      ,{18,'referredtojudgetitle'}
      ,{19,'referredtojudge'}
      ,{20,'jurydemand'}
      ,{21,'demandamount'}
      ,{22,'suitnaturecode'}
      ,{23,'suitnaturedesc'}
      ,{24,'leaddocketnumber'}
      ,{25,'jurisdiction'}
      ,{26,'cause'}
      ,{27,'statute'}
      ,{28,'ca'}
      ,{29,'caseclosed'}
      ,{30,'dateretrieved'}
      ,{31,'otherdocketnumber'}
      ,{32,'litigantname'}
      ,{33,'litigantlabel'}
      ,{34,'layoutcode'}
      ,{35,'terminationdate'}
      ,{36,'attorneyname'}
      ,{37,'attorneylabel'}
      ,{38,'firmname'}
      ,{39,'address'}
      ,{40,'city'}
      ,{41,'state'}
      ,{42,'zipcode'}
      ,{43,'country'}
      ,{44,'addtlinfo'}
      ,{45,'termdate'}
      ,{46,'bdid'}
      ,{47,'did'}
      ,{48,'causecode'}
      ,{49,'judge_title'}
      ,{50,'judge_fname'}
      ,{51,'judge_mname'}
      ,{52,'judge_lname'}
      ,{53,'judge_suffix'}
      ,{54,'judge_score'}
      ,{55,'business_person'}
      ,{56,'debtor'}
      ,{57,'debtor_title'}
      ,{58,'debtor_fname'}
      ,{59,'debtor_mname'}
      ,{60,'debtor_lname'}
      ,{61,'debtor_suffix'}
      ,{62,'debtor_score'}
      ,{63,'attorney_title'}
      ,{64,'attorney_fname'}
      ,{65,'attorney_mname'}
      ,{66,'attorney_lname'}
      ,{67,'attorney_suffix'}
      ,{68,'attorney_score'}
      ,{69,'prim_range'}
      ,{70,'predir'}
      ,{71,'prim_name'}
      ,{72,'addr_suffix'}
      ,{73,'postdir'}
      ,{74,'unit_desig'}
      ,{75,'sec_range'}
      ,{76,'p_city_name'}
      ,{77,'v_city_name'}
      ,{78,'st'}
      ,{79,'zip'}
      ,{80,'zip4'}
      ,{81,'cart'}
      ,{82,'cr_sort_sz'}
      ,{83,'lot'}
      ,{84,'lot_order'}
      ,{85,'dbpc'}
      ,{86,'chk_digit'}
      ,{87,'rec_type'}
      ,{88,'fips_state'}
      ,{89,'fips_county'}
      ,{90,'geo_lat'}
      ,{91,'geo_long'}
      ,{92,'msa'}
      ,{93,'geo_blk'}
      ,{94,'geo_match'}
      ,{95,'err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Fields.InValid_recid((SALT311.StrType)le.recid),
    Fields.InValid_courtstate((SALT311.StrType)le.courtstate),
    Fields.InValid_courtid((SALT311.StrType)le.courtid),
    Fields.InValid_courtname((SALT311.StrType)le.courtname),
    Fields.InValid_docketnumber((SALT311.StrType)le.docketnumber),
    Fields.InValid_officename((SALT311.StrType)le.officename),
    Fields.InValid_asofdate((SALT311.StrType)le.asofdate),
    Fields.InValid_classcode((SALT311.StrType)le.classcode),
    Fields.InValid_casecaption((SALT311.StrType)le.casecaption),
    Fields.InValid_datefiled((SALT311.StrType)le.datefiled),
    Fields.InValid_judgetitle((SALT311.StrType)le.judgetitle),
    Fields.InValid_judgename((SALT311.StrType)le.judgename),
    Fields.InValid_referredtojudgetitle((SALT311.StrType)le.referredtojudgetitle),
    Fields.InValid_referredtojudge((SALT311.StrType)le.referredtojudge),
    Fields.InValid_jurydemand((SALT311.StrType)le.jurydemand),
    Fields.InValid_demandamount((SALT311.StrType)le.demandamount),
    Fields.InValid_suitnaturecode((SALT311.StrType)le.suitnaturecode),
    Fields.InValid_suitnaturedesc((SALT311.StrType)le.suitnaturedesc),
    Fields.InValid_leaddocketnumber((SALT311.StrType)le.leaddocketnumber),
    Fields.InValid_jurisdiction((SALT311.StrType)le.jurisdiction),
    Fields.InValid_cause((SALT311.StrType)le.cause),
    Fields.InValid_statute((SALT311.StrType)le.statute),
    Fields.InValid_ca((SALT311.StrType)le.ca),
    Fields.InValid_caseclosed((SALT311.StrType)le.caseclosed),
    Fields.InValid_dateretrieved((SALT311.StrType)le.dateretrieved),
    Fields.InValid_otherdocketnumber((SALT311.StrType)le.otherdocketnumber),
    Fields.InValid_litigantname((SALT311.StrType)le.litigantname),
    Fields.InValid_litigantlabel((SALT311.StrType)le.litigantlabel),
    Fields.InValid_layoutcode((SALT311.StrType)le.layoutcode),
    Fields.InValid_terminationdate((SALT311.StrType)le.terminationdate),
    Fields.InValid_attorneyname((SALT311.StrType)le.attorneyname),
    Fields.InValid_attorneylabel((SALT311.StrType)le.attorneylabel),
    Fields.InValid_firmname((SALT311.StrType)le.firmname),
    Fields.InValid_address((SALT311.StrType)le.address),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Fields.InValid_country((SALT311.StrType)le.country),
    Fields.InValid_addtlinfo((SALT311.StrType)le.addtlinfo),
    Fields.InValid_termdate((SALT311.StrType)le.termdate),
    Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_causecode((SALT311.StrType)le.causecode),
    Fields.InValid_judge_title((SALT311.StrType)le.judge_title),
    Fields.InValid_judge_fname((SALT311.StrType)le.judge_fname),
    Fields.InValid_judge_mname((SALT311.StrType)le.judge_mname),
    Fields.InValid_judge_lname((SALT311.StrType)le.judge_lname),
    Fields.InValid_judge_suffix((SALT311.StrType)le.judge_suffix),
    Fields.InValid_judge_score((SALT311.StrType)le.judge_score),
    Fields.InValid_business_person((SALT311.StrType)le.business_person),
    Fields.InValid_debtor((SALT311.StrType)le.debtor),
    Fields.InValid_debtor_title((SALT311.StrType)le.debtor_title),
    Fields.InValid_debtor_fname((SALT311.StrType)le.debtor_fname),
    Fields.InValid_debtor_mname((SALT311.StrType)le.debtor_mname),
    Fields.InValid_debtor_lname((SALT311.StrType)le.debtor_lname),
    Fields.InValid_debtor_suffix((SALT311.StrType)le.debtor_suffix),
    Fields.InValid_debtor_score((SALT311.StrType)le.debtor_score),
    Fields.InValid_attorney_title((SALT311.StrType)le.attorney_title),
    Fields.InValid_attorney_fname((SALT311.StrType)le.attorney_fname),
    Fields.InValid_attorney_mname((SALT311.StrType)le.attorney_mname),
    Fields.InValid_attorney_lname((SALT311.StrType)le.attorney_lname),
    Fields.InValid_attorney_suffix((SALT311.StrType)le.attorney_suffix),
    Fields.InValid_attorney_score((SALT311.StrType)le.attorney_score),
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
    Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,95,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_No','Invalid_State','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Date','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Date','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_YOrN','Invalid_YOrN','Invalid_Date','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Unknown','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_recid(TotalErrors.ErrorNum),Fields.InValidMessage_courtstate(TotalErrors.ErrorNum),Fields.InValidMessage_courtid(TotalErrors.ErrorNum),Fields.InValidMessage_courtname(TotalErrors.ErrorNum),Fields.InValidMessage_docketnumber(TotalErrors.ErrorNum),Fields.InValidMessage_officename(TotalErrors.ErrorNum),Fields.InValidMessage_asofdate(TotalErrors.ErrorNum),Fields.InValidMessage_classcode(TotalErrors.ErrorNum),Fields.InValidMessage_casecaption(TotalErrors.ErrorNum),Fields.InValidMessage_datefiled(TotalErrors.ErrorNum),Fields.InValidMessage_judgetitle(TotalErrors.ErrorNum),Fields.InValidMessage_judgename(TotalErrors.ErrorNum),Fields.InValidMessage_referredtojudgetitle(TotalErrors.ErrorNum),Fields.InValidMessage_referredtojudge(TotalErrors.ErrorNum),Fields.InValidMessage_jurydemand(TotalErrors.ErrorNum),Fields.InValidMessage_demandamount(TotalErrors.ErrorNum),Fields.InValidMessage_suitnaturecode(TotalErrors.ErrorNum),Fields.InValidMessage_suitnaturedesc(TotalErrors.ErrorNum),Fields.InValidMessage_leaddocketnumber(TotalErrors.ErrorNum),Fields.InValidMessage_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_cause(TotalErrors.ErrorNum),Fields.InValidMessage_statute(TotalErrors.ErrorNum),Fields.InValidMessage_ca(TotalErrors.ErrorNum),Fields.InValidMessage_caseclosed(TotalErrors.ErrorNum),Fields.InValidMessage_dateretrieved(TotalErrors.ErrorNum),Fields.InValidMessage_otherdocketnumber(TotalErrors.ErrorNum),Fields.InValidMessage_litigantname(TotalErrors.ErrorNum),Fields.InValidMessage_litigantlabel(TotalErrors.ErrorNum),Fields.InValidMessage_layoutcode(TotalErrors.ErrorNum),Fields.InValidMessage_terminationdate(TotalErrors.ErrorNum),Fields.InValidMessage_attorneyname(TotalErrors.ErrorNum),Fields.InValidMessage_attorneylabel(TotalErrors.ErrorNum),Fields.InValidMessage_firmname(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_addtlinfo(TotalErrors.ErrorNum),Fields.InValidMessage_termdate(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_causecode(TotalErrors.ErrorNum),Fields.InValidMessage_judge_title(TotalErrors.ErrorNum),Fields.InValidMessage_judge_fname(TotalErrors.ErrorNum),Fields.InValidMessage_judge_mname(TotalErrors.ErrorNum),Fields.InValidMessage_judge_lname(TotalErrors.ErrorNum),Fields.InValidMessage_judge_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_judge_score(TotalErrors.ErrorNum),Fields.InValidMessage_business_person(TotalErrors.ErrorNum),Fields.InValidMessage_debtor(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_title(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_fname(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_mname(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_lname(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_score(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_title(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_fname(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_mname(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_lname(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LitigiousDebtor, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
