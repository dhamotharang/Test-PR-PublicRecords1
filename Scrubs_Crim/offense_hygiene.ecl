IMPORT ut,SALT33;
EXPORT offense_hygiene(dataset(offense_layout_crim) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.vendor);    NumberOfRecords := COUNT(GROUP);
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_casenumber_pcnt := AVE(GROUP,IF(h.casenumber = (TYPEOF(h.casenumber))'',0,100));
    maxlength_casenumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casenumber)));
    avelength_casenumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casenumber)),h.casenumber<>(typeof(h.casenumber))'');
    populated_casetitle_pcnt := AVE(GROUP,IF(h.casetitle = (TYPEOF(h.casetitle))'',0,100));
    maxlength_casetitle := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casetitle)));
    avelength_casetitle := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casetitle)),h.casetitle<>(typeof(h.casetitle))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_casestatus_pcnt := AVE(GROUP,IF(h.casestatus = (TYPEOF(h.casestatus))'',0,100));
    maxlength_casestatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casestatus)));
    avelength_casestatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casestatus)),h.casestatus<>(typeof(h.casestatus))'');
    populated_casestatusdate_pcnt := AVE(GROUP,IF(h.casestatusdate = (TYPEOF(h.casestatusdate))'',0,100));
    maxlength_casestatusdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casestatusdate)));
    avelength_casestatusdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casestatusdate)),h.casestatusdate<>(typeof(h.casestatusdate))'');
    populated_casecomments_pcnt := AVE(GROUP,IF(h.casecomments = (TYPEOF(h.casecomments))'',0,100));
    maxlength_casecomments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casecomments)));
    avelength_casecomments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casecomments)),h.casecomments<>(typeof(h.casecomments))'');
    populated_fileddate_pcnt := AVE(GROUP,IF(h.fileddate = (TYPEOF(h.fileddate))'',0,100));
    maxlength_fileddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fileddate)));
    avelength_fileddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fileddate)),h.fileddate<>(typeof(h.fileddate))'');
    populated_caseinfo_pcnt := AVE(GROUP,IF(h.caseinfo = (TYPEOF(h.caseinfo))'',0,100));
    maxlength_caseinfo := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseinfo)));
    avelength_caseinfo := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseinfo)),h.caseinfo<>(typeof(h.caseinfo))'');
    populated_docketnumber_pcnt := AVE(GROUP,IF(h.docketnumber = (TYPEOF(h.docketnumber))'',0,100));
    maxlength_docketnumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.docketnumber)));
    avelength_docketnumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.docketnumber)),h.docketnumber<>(typeof(h.docketnumber))'');
    populated_offensecode_pcnt := AVE(GROUP,IF(h.offensecode = (TYPEOF(h.offensecode))'',0,100));
    maxlength_offensecode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensecode)));
    avelength_offensecode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensecode)),h.offensecode<>(typeof(h.offensecode))'');
    populated_offensedesc_pcnt := AVE(GROUP,IF(h.offensedesc = (TYPEOF(h.offensedesc))'',0,100));
    maxlength_offensedesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedesc)));
    avelength_offensedesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedesc)),h.offensedesc<>(typeof(h.offensedesc))'');
    populated_offensedate_pcnt := AVE(GROUP,IF(h.offensedate = (TYPEOF(h.offensedate))'',0,100));
    maxlength_offensedate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedate)));
    avelength_offensedate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedate)),h.offensedate<>(typeof(h.offensedate))'');
    populated_offensetype_pcnt := AVE(GROUP,IF(h.offensetype = (TYPEOF(h.offensetype))'',0,100));
    maxlength_offensetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensetype)));
    avelength_offensetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensetype)),h.offensetype<>(typeof(h.offensetype))'');
    populated_offensedegree_pcnt := AVE(GROUP,IF(h.offensedegree = (TYPEOF(h.offensedegree))'',0,100));
    maxlength_offensedegree := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedegree)));
    avelength_offensedegree := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensedegree)),h.offensedegree<>(typeof(h.offensedegree))'');
    populated_offenseclass_pcnt := AVE(GROUP,IF(h.offenseclass = (TYPEOF(h.offenseclass))'',0,100));
    maxlength_offenseclass := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offenseclass)));
    avelength_offenseclass := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offenseclass)),h.offenseclass<>(typeof(h.offenseclass))'');
    populated_dispositionstatus_pcnt := AVE(GROUP,IF(h.dispositionstatus = (TYPEOF(h.dispositionstatus))'',0,100));
    maxlength_dispositionstatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositionstatus)));
    avelength_dispositionstatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositionstatus)),h.dispositionstatus<>(typeof(h.dispositionstatus))'');
    populated_dispositionstatusdate_pcnt := AVE(GROUP,IF(h.dispositionstatusdate = (TYPEOF(h.dispositionstatusdate))'',0,100));
    maxlength_dispositionstatusdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositionstatusdate)));
    avelength_dispositionstatusdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositionstatusdate)),h.dispositionstatusdate<>(typeof(h.dispositionstatusdate))'');
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_dispositiondate_pcnt := AVE(GROUP,IF(h.dispositiondate = (TYPEOF(h.dispositiondate))'',0,100));
    maxlength_dispositiondate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositiondate)));
    avelength_dispositiondate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositiondate)),h.dispositiondate<>(typeof(h.dispositiondate))'');
    populated_offenselocation_pcnt := AVE(GROUP,IF(h.offenselocation = (TYPEOF(h.offenselocation))'',0,100));
    maxlength_offenselocation := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offenselocation)));
    avelength_offenselocation := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offenselocation)),h.offenselocation<>(typeof(h.offenselocation))'');
    populated_finaloffense_pcnt := AVE(GROUP,IF(h.finaloffense = (TYPEOF(h.finaloffense))'',0,100));
    maxlength_finaloffense := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.finaloffense)));
    avelength_finaloffense := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.finaloffense)),h.finaloffense<>(typeof(h.finaloffense))'');
    populated_finaloffensedate_pcnt := AVE(GROUP,IF(h.finaloffensedate = (TYPEOF(h.finaloffensedate))'',0,100));
    maxlength_finaloffensedate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.finaloffensedate)));
    avelength_finaloffensedate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.finaloffensedate)),h.finaloffensedate<>(typeof(h.finaloffensedate))'');
    populated_offensecount_pcnt := AVE(GROUP,IF(h.offensecount = (TYPEOF(h.offensecount))'',0,100));
    maxlength_offensecount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensecount)));
    avelength_offensecount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offensecount)),h.offensecount<>(typeof(h.offensecount))'');
    populated_victimunder18_pcnt := AVE(GROUP,IF(h.victimunder18 = (TYPEOF(h.victimunder18))'',0,100));
    maxlength_victimunder18 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.victimunder18)));
    avelength_victimunder18 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.victimunder18)),h.victimunder18<>(typeof(h.victimunder18))'');
    populated_prioroffenseflag_pcnt := AVE(GROUP,IF(h.prioroffenseflag = (TYPEOF(h.prioroffenseflag))'',0,100));
    maxlength_prioroffenseflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prioroffenseflag)));
    avelength_prioroffenseflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prioroffenseflag)),h.prioroffenseflag<>(typeof(h.prioroffenseflag))'');
    populated_initialplea_pcnt := AVE(GROUP,IF(h.initialplea = (TYPEOF(h.initialplea))'',0,100));
    maxlength_initialplea := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.initialplea)));
    avelength_initialplea := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.initialplea)),h.initialplea<>(typeof(h.initialplea))'');
    populated_initialpleadate_pcnt := AVE(GROUP,IF(h.initialpleadate = (TYPEOF(h.initialpleadate))'',0,100));
    maxlength_initialpleadate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.initialpleadate)));
    avelength_initialpleadate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.initialpleadate)),h.initialpleadate<>(typeof(h.initialpleadate))'');
    populated_finalruling_pcnt := AVE(GROUP,IF(h.finalruling = (TYPEOF(h.finalruling))'',0,100));
    maxlength_finalruling := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.finalruling)));
    avelength_finalruling := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.finalruling)),h.finalruling<>(typeof(h.finalruling))'');
    populated_finalrulingdate_pcnt := AVE(GROUP,IF(h.finalrulingdate = (TYPEOF(h.finalrulingdate))'',0,100));
    maxlength_finalrulingdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.finalrulingdate)));
    avelength_finalrulingdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.finalrulingdate)),h.finalrulingdate<>(typeof(h.finalrulingdate))'');
    populated_appealstatus_pcnt := AVE(GROUP,IF(h.appealstatus = (TYPEOF(h.appealstatus))'',0,100));
    maxlength_appealstatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.appealstatus)));
    avelength_appealstatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.appealstatus)),h.appealstatus<>(typeof(h.appealstatus))'');
    populated_appealdate_pcnt := AVE(GROUP,IF(h.appealdate = (TYPEOF(h.appealdate))'',0,100));
    maxlength_appealdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.appealdate)));
    avelength_appealdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.appealdate)),h.appealdate<>(typeof(h.appealdate))'');
    populated_courtname_pcnt := AVE(GROUP,IF(h.courtname = (TYPEOF(h.courtname))'',0,100));
    maxlength_courtname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtname)));
    avelength_courtname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtname)),h.courtname<>(typeof(h.courtname))'');
    populated_fineamount_pcnt := AVE(GROUP,IF(h.fineamount = (TYPEOF(h.fineamount))'',0,100));
    maxlength_fineamount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fineamount)));
    avelength_fineamount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fineamount)),h.fineamount<>(typeof(h.fineamount))'');
    populated_courtfee_pcnt := AVE(GROUP,IF(h.courtfee = (TYPEOF(h.courtfee))'',0,100));
    maxlength_courtfee := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtfee)));
    avelength_courtfee := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtfee)),h.courtfee<>(typeof(h.courtfee))'');
    populated_restitution_pcnt := AVE(GROUP,IF(h.restitution = (TYPEOF(h.restitution))'',0,100));
    maxlength_restitution := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.restitution)));
    avelength_restitution := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.restitution)),h.restitution<>(typeof(h.restitution))'');
    populated_trialtype_pcnt := AVE(GROUP,IF(h.trialtype = (TYPEOF(h.trialtype))'',0,100));
    maxlength_trialtype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.trialtype)));
    avelength_trialtype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.trialtype)),h.trialtype<>(typeof(h.trialtype))'');
    populated_courtdate_pcnt := AVE(GROUP,IF(h.courtdate = (TYPEOF(h.courtdate))'',0,100));
    maxlength_courtdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtdate)));
    avelength_courtdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.courtdate)),h.courtdate<>(typeof(h.courtdate))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
    populated_classification_code_pcnt := AVE(GROUP,IF(h.classification_code = (TYPEOF(h.classification_code))'',0,100));
    maxlength_classification_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.classification_code)));
    avelength_classification_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.classification_code)),h.classification_code<>(typeof(h.classification_code))'');
    populated_sub_classification_code_pcnt := AVE(GROUP,IF(h.sub_classification_code = (TYPEOF(h.sub_classification_code))'',0,100));
    maxlength_sub_classification_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sub_classification_code)));
    avelength_sub_classification_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sub_classification_code)),h.sub_classification_code<>(typeof(h.sub_classification_code))'');
    populated_unit_pcnt := AVE(GROUP,IF(h.unit = (TYPEOF(h.unit))'',0,100));
    maxlength_unit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit)));
    avelength_unit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit)),h.unit<>(typeof(h.unit))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_institutionname_pcnt := AVE(GROUP,IF(h.institutionname = (TYPEOF(h.institutionname))'',0,100));
    maxlength_institutionname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionname)));
    avelength_institutionname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionname)),h.institutionname<>(typeof(h.institutionname))'');
    populated_institutiondetails_pcnt := AVE(GROUP,IF(h.institutiondetails = (TYPEOF(h.institutiondetails))'',0,100));
    maxlength_institutiondetails := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutiondetails)));
    avelength_institutiondetails := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutiondetails)),h.institutiondetails<>(typeof(h.institutiondetails))'');
    populated_institutionreceiptdate_pcnt := AVE(GROUP,IF(h.institutionreceiptdate = (TYPEOF(h.institutionreceiptdate))'',0,100));
    maxlength_institutionreceiptdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionreceiptdate)));
    avelength_institutionreceiptdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionreceiptdate)),h.institutionreceiptdate<>(typeof(h.institutionreceiptdate))'');
    populated_releasetolocation_pcnt := AVE(GROUP,IF(h.releasetolocation = (TYPEOF(h.releasetolocation))'',0,100));
    maxlength_releasetolocation := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetolocation)));
    avelength_releasetolocation := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetolocation)),h.releasetolocation<>(typeof(h.releasetolocation))'');
    populated_releasetodetails_pcnt := AVE(GROUP,IF(h.releasetodetails = (TYPEOF(h.releasetodetails))'',0,100));
    maxlength_releasetodetails := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetodetails)));
    avelength_releasetodetails := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetodetails)),h.releasetodetails<>(typeof(h.releasetodetails))'');
    populated_deceasedflag_pcnt := AVE(GROUP,IF(h.deceasedflag = (TYPEOF(h.deceasedflag))'',0,100));
    maxlength_deceasedflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceasedflag)));
    avelength_deceasedflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceasedflag)),h.deceasedflag<>(typeof(h.deceasedflag))'');
    populated_deceaseddate_pcnt := AVE(GROUP,IF(h.deceaseddate = (TYPEOF(h.deceaseddate))'',0,100));
    maxlength_deceaseddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceaseddate)));
    avelength_deceaseddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceaseddate)),h.deceaseddate<>(typeof(h.deceaseddate))'');
    populated_healthflag_pcnt := AVE(GROUP,IF(h.healthflag = (TYPEOF(h.healthflag))'',0,100));
    maxlength_healthflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthflag)));
    avelength_healthflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthflag)),h.healthflag<>(typeof(h.healthflag))'');
    populated_healthdesc_pcnt := AVE(GROUP,IF(h.healthdesc = (TYPEOF(h.healthdesc))'',0,100));
    maxlength_healthdesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthdesc)));
    avelength_healthdesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthdesc)),h.healthdesc<>(typeof(h.healthdesc))'');
    populated_bloodtype_pcnt := AVE(GROUP,IF(h.bloodtype = (TYPEOF(h.bloodtype))'',0,100));
    maxlength_bloodtype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bloodtype)));
    avelength_bloodtype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bloodtype)),h.bloodtype<>(typeof(h.bloodtype))'');
    populated_sexoffenderregistrydate_pcnt := AVE(GROUP,IF(h.sexoffenderregistrydate = (TYPEOF(h.sexoffenderregistrydate))'',0,100));
    maxlength_sexoffenderregistrydate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrydate)));
    avelength_sexoffenderregistrydate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrydate)),h.sexoffenderregistrydate<>(typeof(h.sexoffenderregistrydate))'');
    populated_sexoffenderregexpirationdate_pcnt := AVE(GROUP,IF(h.sexoffenderregexpirationdate = (TYPEOF(h.sexoffenderregexpirationdate))'',0,100));
    maxlength_sexoffenderregexpirationdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregexpirationdate)));
    avelength_sexoffenderregexpirationdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregexpirationdate)),h.sexoffenderregexpirationdate<>(typeof(h.sexoffenderregexpirationdate))'');
    populated_sexoffenderregistrynumber_pcnt := AVE(GROUP,IF(h.sexoffenderregistrynumber = (TYPEOF(h.sexoffenderregistrynumber))'',0,100));
    maxlength_sexoffenderregistrynumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrynumber)));
    avelength_sexoffenderregistrynumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrynumber)),h.sexoffenderregistrynumber<>(typeof(h.sexoffenderregistrynumber))'');
    populated_sourceid2_pcnt := AVE(GROUP,IF(h.sourceid2 = (TYPEOF(h.sourceid2))'',0,100));
    maxlength_sourceid2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid2)));
    avelength_sourceid2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid2)),h.sourceid2<>(typeof(h.sourceid2))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_casenumber_pcnt *   0.00 / 100 + T.Populated_casetitle_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_casestatus_pcnt *   0.00 / 100 + T.Populated_casestatusdate_pcnt *   0.00 / 100 + T.Populated_casecomments_pcnt *   0.00 / 100 + T.Populated_fileddate_pcnt *   0.00 / 100 + T.Populated_caseinfo_pcnt *   0.00 / 100 + T.Populated_docketnumber_pcnt *   0.00 / 100 + T.Populated_offensecode_pcnt *   0.00 / 100 + T.Populated_offensedesc_pcnt *   0.00 / 100 + T.Populated_offensedate_pcnt *   0.00 / 100 + T.Populated_offensetype_pcnt *   0.00 / 100 + T.Populated_offensedegree_pcnt *   0.00 / 100 + T.Populated_offenseclass_pcnt *   0.00 / 100 + T.Populated_dispositionstatus_pcnt *   0.00 / 100 + T.Populated_dispositionstatusdate_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_dispositiondate_pcnt *   0.00 / 100 + T.Populated_offenselocation_pcnt *   0.00 / 100 + T.Populated_finaloffense_pcnt *   0.00 / 100 + T.Populated_finaloffensedate_pcnt *   0.00 / 100 + T.Populated_offensecount_pcnt *   0.00 / 100 + T.Populated_victimunder18_pcnt *   0.00 / 100 + T.Populated_prioroffenseflag_pcnt *   0.00 / 100 + T.Populated_initialplea_pcnt *   0.00 / 100 + T.Populated_initialpleadate_pcnt *   0.00 / 100 + T.Populated_finalruling_pcnt *   0.00 / 100 + T.Populated_finalrulingdate_pcnt *   0.00 / 100 + T.Populated_appealstatus_pcnt *   0.00 / 100 + T.Populated_appealdate_pcnt *   0.00 / 100 + T.Populated_courtname_pcnt *   0.00 / 100 + T.Populated_fineamount_pcnt *   0.00 / 100 + T.Populated_courtfee_pcnt *   0.00 / 100 + T.Populated_restitution_pcnt *   0.00 / 100 + T.Populated_trialtype_pcnt *   0.00 / 100 + T.Populated_courtdate_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_classification_code_pcnt *   0.00 / 100 + T.Populated_sub_classification_code_pcnt *   0.00 / 100 + T.Populated_unit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_institutionname_pcnt *   0.00 / 100 + T.Populated_institutiondetails_pcnt *   0.00 / 100 + T.Populated_institutionreceiptdate_pcnt *   0.00 / 100 + T.Populated_releasetolocation_pcnt *   0.00 / 100 + T.Populated_releasetodetails_pcnt *   0.00 / 100 + T.Populated_deceasedflag_pcnt *   0.00 / 100 + T.Populated_deceaseddate_pcnt *   0.00 / 100 + T.Populated_healthflag_pcnt *   0.00 / 100 + T.Populated_healthdesc_pcnt *   0.00 / 100 + T.Populated_bloodtype_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrydate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 100 + T.Populated_sourceid2_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_casenumber_pcnt*ri.Populated_casenumber_pcnt *   0.00 / 10000 + le.Populated_casetitle_pcnt*ri.Populated_casetitle_pcnt *   0.00 / 10000 + le.Populated_casetype_pcnt*ri.Populated_casetype_pcnt *   0.00 / 10000 + le.Populated_casestatus_pcnt*ri.Populated_casestatus_pcnt *   0.00 / 10000 + le.Populated_casestatusdate_pcnt*ri.Populated_casestatusdate_pcnt *   0.00 / 10000 + le.Populated_casecomments_pcnt*ri.Populated_casecomments_pcnt *   0.00 / 10000 + le.Populated_fileddate_pcnt*ri.Populated_fileddate_pcnt *   0.00 / 10000 + le.Populated_caseinfo_pcnt*ri.Populated_caseinfo_pcnt *   0.00 / 10000 + le.Populated_docketnumber_pcnt*ri.Populated_docketnumber_pcnt *   0.00 / 10000 + le.Populated_offensecode_pcnt*ri.Populated_offensecode_pcnt *   0.00 / 10000 + le.Populated_offensedesc_pcnt*ri.Populated_offensedesc_pcnt *   0.00 / 10000 + le.Populated_offensedate_pcnt*ri.Populated_offensedate_pcnt *   0.00 / 10000 + le.Populated_offensetype_pcnt*ri.Populated_offensetype_pcnt *   0.00 / 10000 + le.Populated_offensedegree_pcnt*ri.Populated_offensedegree_pcnt *   0.00 / 10000 + le.Populated_offenseclass_pcnt*ri.Populated_offenseclass_pcnt *   0.00 / 10000 + le.Populated_dispositionstatus_pcnt*ri.Populated_dispositionstatus_pcnt *   0.00 / 10000 + le.Populated_dispositionstatusdate_pcnt*ri.Populated_dispositionstatusdate_pcnt *   0.00 / 10000 + le.Populated_disposition_pcnt*ri.Populated_disposition_pcnt *   0.00 / 10000 + le.Populated_dispositiondate_pcnt*ri.Populated_dispositiondate_pcnt *   0.00 / 10000 + le.Populated_offenselocation_pcnt*ri.Populated_offenselocation_pcnt *   0.00 / 10000 + le.Populated_finaloffense_pcnt*ri.Populated_finaloffense_pcnt *   0.00 / 10000 + le.Populated_finaloffensedate_pcnt*ri.Populated_finaloffensedate_pcnt *   0.00 / 10000 + le.Populated_offensecount_pcnt*ri.Populated_offensecount_pcnt *   0.00 / 10000 + le.Populated_victimunder18_pcnt*ri.Populated_victimunder18_pcnt *   0.00 / 10000 + le.Populated_prioroffenseflag_pcnt*ri.Populated_prioroffenseflag_pcnt *   0.00 / 10000 + le.Populated_initialplea_pcnt*ri.Populated_initialplea_pcnt *   0.00 / 10000 + le.Populated_initialpleadate_pcnt*ri.Populated_initialpleadate_pcnt *   0.00 / 10000 + le.Populated_finalruling_pcnt*ri.Populated_finalruling_pcnt *   0.00 / 10000 + le.Populated_finalrulingdate_pcnt*ri.Populated_finalrulingdate_pcnt *   0.00 / 10000 + le.Populated_appealstatus_pcnt*ri.Populated_appealstatus_pcnt *   0.00 / 10000 + le.Populated_appealdate_pcnt*ri.Populated_appealdate_pcnt *   0.00 / 10000 + le.Populated_courtname_pcnt*ri.Populated_courtname_pcnt *   0.00 / 10000 + le.Populated_fineamount_pcnt*ri.Populated_fineamount_pcnt *   0.00 / 10000 + le.Populated_courtfee_pcnt*ri.Populated_courtfee_pcnt *   0.00 / 10000 + le.Populated_restitution_pcnt*ri.Populated_restitution_pcnt *   0.00 / 10000 + le.Populated_trialtype_pcnt*ri.Populated_trialtype_pcnt *   0.00 / 10000 + le.Populated_courtdate_pcnt*ri.Populated_courtdate_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_sourceid_pcnt*ri.Populated_sourceid_pcnt *   0.00 / 10000 + le.Populated_classification_code_pcnt*ri.Populated_classification_code_pcnt *   0.00 / 10000 + le.Populated_sub_classification_code_pcnt*ri.Populated_sub_classification_code_pcnt *   0.00 / 10000 + le.Populated_unit_pcnt*ri.Populated_unit_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_institutionname_pcnt*ri.Populated_institutionname_pcnt *   0.00 / 10000 + le.Populated_institutiondetails_pcnt*ri.Populated_institutiondetails_pcnt *   0.00 / 10000 + le.Populated_institutionreceiptdate_pcnt*ri.Populated_institutionreceiptdate_pcnt *   0.00 / 10000 + le.Populated_releasetolocation_pcnt*ri.Populated_releasetolocation_pcnt *   0.00 / 10000 + le.Populated_releasetodetails_pcnt*ri.Populated_releasetodetails_pcnt *   0.00 / 10000 + le.Populated_deceasedflag_pcnt*ri.Populated_deceasedflag_pcnt *   0.00 / 10000 + le.Populated_deceaseddate_pcnt*ri.Populated_deceaseddate_pcnt *   0.00 / 10000 + le.Populated_healthflag_pcnt*ri.Populated_healthflag_pcnt *   0.00 / 10000 + le.Populated_healthdesc_pcnt*ri.Populated_healthdesc_pcnt *   0.00 / 10000 + le.Populated_bloodtype_pcnt*ri.Populated_bloodtype_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregistrydate_pcnt*ri.Populated_sexoffenderregistrydate_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregexpirationdate_pcnt*ri.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregistrynumber_pcnt*ri.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 10000 + le.Populated_sourceid2_pcnt*ri.Populated_sourceid2_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'recordid','statecode','caseid','casenumber','casetitle','casetype','casestatus','casestatusdate','casecomments','fileddate','caseinfo','docketnumber','offensecode','offensedesc','offensedate','offensetype','offensedegree','offenseclass','dispositionstatus','dispositionstatusdate','disposition','dispositiondate','offenselocation','finaloffense','finaloffensedate','offensecount','victimunder18','prioroffenseflag','initialplea','initialpleadate','finalruling','finalrulingdate','appealstatus','appealdate','courtname','fineamount','courtfee','restitution','trialtype','courtdate','sourcename','sourceid','classification_code','sub_classification_code','unit','city','state','zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid2','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_caseid_pcnt,le.populated_casenumber_pcnt,le.populated_casetitle_pcnt,le.populated_casetype_pcnt,le.populated_casestatus_pcnt,le.populated_casestatusdate_pcnt,le.populated_casecomments_pcnt,le.populated_fileddate_pcnt,le.populated_caseinfo_pcnt,le.populated_docketnumber_pcnt,le.populated_offensecode_pcnt,le.populated_offensedesc_pcnt,le.populated_offensedate_pcnt,le.populated_offensetype_pcnt,le.populated_offensedegree_pcnt,le.populated_offenseclass_pcnt,le.populated_dispositionstatus_pcnt,le.populated_dispositionstatusdate_pcnt,le.populated_disposition_pcnt,le.populated_dispositiondate_pcnt,le.populated_offenselocation_pcnt,le.populated_finaloffense_pcnt,le.populated_finaloffensedate_pcnt,le.populated_offensecount_pcnt,le.populated_victimunder18_pcnt,le.populated_prioroffenseflag_pcnt,le.populated_initialplea_pcnt,le.populated_initialpleadate_pcnt,le.populated_finalruling_pcnt,le.populated_finalrulingdate_pcnt,le.populated_appealstatus_pcnt,le.populated_appealdate_pcnt,le.populated_courtname_pcnt,le.populated_fineamount_pcnt,le.populated_courtfee_pcnt,le.populated_restitution_pcnt,le.populated_trialtype_pcnt,le.populated_courtdate_pcnt,le.populated_sourcename_pcnt,le.populated_sourceid_pcnt,le.populated_classification_code_pcnt,le.populated_sub_classification_code_pcnt,le.populated_unit_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_county_pcnt,le.populated_institutionname_pcnt,le.populated_institutiondetails_pcnt,le.populated_institutionreceiptdate_pcnt,le.populated_releasetolocation_pcnt,le.populated_releasetodetails_pcnt,le.populated_deceasedflag_pcnt,le.populated_deceaseddate_pcnt,le.populated_healthflag_pcnt,le.populated_healthdesc_pcnt,le.populated_bloodtype_pcnt,le.populated_sexoffenderregistrydate_pcnt,le.populated_sexoffenderregexpirationdate_pcnt,le.populated_sexoffenderregistrynumber_pcnt,le.populated_sourceid2_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_caseid,le.maxlength_casenumber,le.maxlength_casetitle,le.maxlength_casetype,le.maxlength_casestatus,le.maxlength_casestatusdate,le.maxlength_casecomments,le.maxlength_fileddate,le.maxlength_caseinfo,le.maxlength_docketnumber,le.maxlength_offensecode,le.maxlength_offensedesc,le.maxlength_offensedate,le.maxlength_offensetype,le.maxlength_offensedegree,le.maxlength_offenseclass,le.maxlength_dispositionstatus,le.maxlength_dispositionstatusdate,le.maxlength_disposition,le.maxlength_dispositiondate,le.maxlength_offenselocation,le.maxlength_finaloffense,le.maxlength_finaloffensedate,le.maxlength_offensecount,le.maxlength_victimunder18,le.maxlength_prioroffenseflag,le.maxlength_initialplea,le.maxlength_initialpleadate,le.maxlength_finalruling,le.maxlength_finalrulingdate,le.maxlength_appealstatus,le.maxlength_appealdate,le.maxlength_courtname,le.maxlength_fineamount,le.maxlength_courtfee,le.maxlength_restitution,le.maxlength_trialtype,le.maxlength_courtdate,le.maxlength_sourcename,le.maxlength_sourceid,le.maxlength_classification_code,le.maxlength_sub_classification_code,le.maxlength_unit,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_county,le.maxlength_institutionname,le.maxlength_institutiondetails,le.maxlength_institutionreceiptdate,le.maxlength_releasetolocation,le.maxlength_releasetodetails,le.maxlength_deceasedflag,le.maxlength_deceaseddate,le.maxlength_healthflag,le.maxlength_healthdesc,le.maxlength_bloodtype,le.maxlength_sexoffenderregistrydate,le.maxlength_sexoffenderregexpirationdate,le.maxlength_sexoffenderregistrynumber,le.maxlength_sourceid2,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_caseid,le.avelength_casenumber,le.avelength_casetitle,le.avelength_casetype,le.avelength_casestatus,le.avelength_casestatusdate,le.avelength_casecomments,le.avelength_fileddate,le.avelength_caseinfo,le.avelength_docketnumber,le.avelength_offensecode,le.avelength_offensedesc,le.avelength_offensedate,le.avelength_offensetype,le.avelength_offensedegree,le.avelength_offenseclass,le.avelength_dispositionstatus,le.avelength_dispositionstatusdate,le.avelength_disposition,le.avelength_dispositiondate,le.avelength_offenselocation,le.avelength_finaloffense,le.avelength_finaloffensedate,le.avelength_offensecount,le.avelength_victimunder18,le.avelength_prioroffenseflag,le.avelength_initialplea,le.avelength_initialpleadate,le.avelength_finalruling,le.avelength_finalrulingdate,le.avelength_appealstatus,le.avelength_appealdate,le.avelength_courtname,le.avelength_fineamount,le.avelength_courtfee,le.avelength_restitution,le.avelength_trialtype,le.avelength_courtdate,le.avelength_sourcename,le.avelength_sourceid,le.avelength_classification_code,le.avelength_sub_classification_code,le.avelength_unit,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_county,le.avelength_institutionname,le.avelength_institutiondetails,le.avelength_institutionreceiptdate,le.avelength_releasetolocation,le.avelength_releasetodetails,le.avelength_deceasedflag,le.avelength_deceaseddate,le.avelength_healthflag,le.avelength_healthdesc,le.avelength_bloodtype,le.avelength_sexoffenderregistrydate,le.avelength_sexoffenderregexpirationdate,le.avelength_sexoffenderregistrynumber,le.avelength_sourceid2,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 64, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.casetitle),TRIM((SALT33.StrType)le.casetype),TRIM((SALT33.StrType)le.casestatus),TRIM((SALT33.StrType)le.casestatusdate),TRIM((SALT33.StrType)le.casecomments),TRIM((SALT33.StrType)le.fileddate),TRIM((SALT33.StrType)le.caseinfo),TRIM((SALT33.StrType)le.docketnumber),TRIM((SALT33.StrType)le.offensecode),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.dispositionstatus),TRIM((SALT33.StrType)le.dispositionstatusdate),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.offenselocation),TRIM((SALT33.StrType)le.finaloffense),TRIM((SALT33.StrType)le.finaloffensedate),TRIM((SALT33.StrType)le.offensecount),TRIM((SALT33.StrType)le.victimunder18),TRIM((SALT33.StrType)le.prioroffenseflag),TRIM((SALT33.StrType)le.initialplea),TRIM((SALT33.StrType)le.initialpleadate),TRIM((SALT33.StrType)le.finalruling),TRIM((SALT33.StrType)le.finalrulingdate),TRIM((SALT33.StrType)le.appealstatus),TRIM((SALT33.StrType)le.appealdate),TRIM((SALT33.StrType)le.courtname),TRIM((SALT33.StrType)le.fineamount),TRIM((SALT33.StrType)le.courtfee),TRIM((SALT33.StrType)le.restitution),TRIM((SALT33.StrType)le.trialtype),TRIM((SALT33.StrType)le.courtdate),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.classification_code),TRIM((SALT33.StrType)le.sub_classification_code),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid2),TRIM((SALT33.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,64,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 64);
  SELF.FldNo2 := 1 + (C % 64);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.casetitle),TRIM((SALT33.StrType)le.casetype),TRIM((SALT33.StrType)le.casestatus),TRIM((SALT33.StrType)le.casestatusdate),TRIM((SALT33.StrType)le.casecomments),TRIM((SALT33.StrType)le.fileddate),TRIM((SALT33.StrType)le.caseinfo),TRIM((SALT33.StrType)le.docketnumber),TRIM((SALT33.StrType)le.offensecode),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.dispositionstatus),TRIM((SALT33.StrType)le.dispositionstatusdate),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.offenselocation),TRIM((SALT33.StrType)le.finaloffense),TRIM((SALT33.StrType)le.finaloffensedate),TRIM((SALT33.StrType)le.offensecount),TRIM((SALT33.StrType)le.victimunder18),TRIM((SALT33.StrType)le.prioroffenseflag),TRIM((SALT33.StrType)le.initialplea),TRIM((SALT33.StrType)le.initialpleadate),TRIM((SALT33.StrType)le.finalruling),TRIM((SALT33.StrType)le.finalrulingdate),TRIM((SALT33.StrType)le.appealstatus),TRIM((SALT33.StrType)le.appealdate),TRIM((SALT33.StrType)le.courtname),TRIM((SALT33.StrType)le.fineamount),TRIM((SALT33.StrType)le.courtfee),TRIM((SALT33.StrType)le.restitution),TRIM((SALT33.StrType)le.trialtype),TRIM((SALT33.StrType)le.courtdate),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.classification_code),TRIM((SALT33.StrType)le.sub_classification_code),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid2),TRIM((SALT33.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.casetitle),TRIM((SALT33.StrType)le.casetype),TRIM((SALT33.StrType)le.casestatus),TRIM((SALT33.StrType)le.casestatusdate),TRIM((SALT33.StrType)le.casecomments),TRIM((SALT33.StrType)le.fileddate),TRIM((SALT33.StrType)le.caseinfo),TRIM((SALT33.StrType)le.docketnumber),TRIM((SALT33.StrType)le.offensecode),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.dispositionstatus),TRIM((SALT33.StrType)le.dispositionstatusdate),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.offenselocation),TRIM((SALT33.StrType)le.finaloffense),TRIM((SALT33.StrType)le.finaloffensedate),TRIM((SALT33.StrType)le.offensecount),TRIM((SALT33.StrType)le.victimunder18),TRIM((SALT33.StrType)le.prioroffenseflag),TRIM((SALT33.StrType)le.initialplea),TRIM((SALT33.StrType)le.initialpleadate),TRIM((SALT33.StrType)le.finalruling),TRIM((SALT33.StrType)le.finalrulingdate),TRIM((SALT33.StrType)le.appealstatus),TRIM((SALT33.StrType)le.appealdate),TRIM((SALT33.StrType)le.courtname),TRIM((SALT33.StrType)le.fineamount),TRIM((SALT33.StrType)le.courtfee),TRIM((SALT33.StrType)le.restitution),TRIM((SALT33.StrType)le.trialtype),TRIM((SALT33.StrType)le.courtdate),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.classification_code),TRIM((SALT33.StrType)le.sub_classification_code),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.state),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid2),TRIM((SALT33.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),64*64,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'caseid'}
      ,{4,'casenumber'}
      ,{5,'casetitle'}
      ,{6,'casetype'}
      ,{7,'casestatus'}
      ,{8,'casestatusdate'}
      ,{9,'casecomments'}
      ,{10,'fileddate'}
      ,{11,'caseinfo'}
      ,{12,'docketnumber'}
      ,{13,'offensecode'}
      ,{14,'offensedesc'}
      ,{15,'offensedate'}
      ,{16,'offensetype'}
      ,{17,'offensedegree'}
      ,{18,'offenseclass'}
      ,{19,'dispositionstatus'}
      ,{20,'dispositionstatusdate'}
      ,{21,'disposition'}
      ,{22,'dispositiondate'}
      ,{23,'offenselocation'}
      ,{24,'finaloffense'}
      ,{25,'finaloffensedate'}
      ,{26,'offensecount'}
      ,{27,'victimunder18'}
      ,{28,'prioroffenseflag'}
      ,{29,'initialplea'}
      ,{30,'initialpleadate'}
      ,{31,'finalruling'}
      ,{32,'finalrulingdate'}
      ,{33,'appealstatus'}
      ,{34,'appealdate'}
      ,{35,'courtname'}
      ,{36,'fineamount'}
      ,{37,'courtfee'}
      ,{38,'restitution'}
      ,{39,'trialtype'}
      ,{40,'courtdate'}
      ,{41,'sourcename'}
      ,{42,'sourceid'}
      ,{43,'classification_code'}
      ,{44,'sub_classification_code'}
      ,{45,'unit'}
      ,{46,'city'}
      ,{47,'state'}
      ,{48,'zip'}
      ,{49,'county'}
      ,{50,'institutionname'}
      ,{51,'institutiondetails'}
      ,{52,'institutionreceiptdate'}
      ,{53,'releasetolocation'}
      ,{54,'releasetodetails'}
      ,{55,'deceasedflag'}
      ,{56,'deceaseddate'}
      ,{57,'healthflag'}
      ,{58,'healthdesc'}
      ,{59,'bloodtype'}
      ,{60,'sexoffenderregistrydate'}
      ,{61,'sexoffenderregexpirationdate'}
      ,{62,'sexoffenderregistrynumber'}
      ,{63,'sourceid2'}
      ,{64,'vendor'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    offense_Fields.InValid_recordid((SALT33.StrType)le.recordid),
    offense_Fields.InValid_statecode((SALT33.StrType)le.statecode),
    offense_Fields.InValid_caseid((SALT33.StrType)le.caseid),
    offense_Fields.InValid_casenumber((SALT33.StrType)le.casenumber),
    offense_Fields.InValid_casetitle((SALT33.StrType)le.casetitle),
    offense_Fields.InValid_casetype((SALT33.StrType)le.casetype),
    offense_Fields.InValid_casestatus((SALT33.StrType)le.casestatus),
    offense_Fields.InValid_casestatusdate((SALT33.StrType)le.casestatusdate),
    offense_Fields.InValid_casecomments((SALT33.StrType)le.casecomments),
    offense_Fields.InValid_fileddate((SALT33.StrType)le.fileddate),
    offense_Fields.InValid_caseinfo((SALT33.StrType)le.caseinfo),
    offense_Fields.InValid_docketnumber((SALT33.StrType)le.docketnumber),
    offense_Fields.InValid_offensecode((SALT33.StrType)le.offensecode),
    offense_Fields.InValid_offensedesc((SALT33.StrType)le.offensedesc),
    offense_Fields.InValid_offensedate((SALT33.StrType)le.offensedate),
    offense_Fields.InValid_offensetype((SALT33.StrType)le.offensetype),
    offense_Fields.InValid_offensedegree((SALT33.StrType)le.offensedegree),
    offense_Fields.InValid_offenseclass((SALT33.StrType)le.offenseclass),
    offense_Fields.InValid_dispositionstatus((SALT33.StrType)le.dispositionstatus),
    offense_Fields.InValid_dispositionstatusdate((SALT33.StrType)le.dispositionstatusdate),
    offense_Fields.InValid_disposition((SALT33.StrType)le.disposition),
    offense_Fields.InValid_dispositiondate((SALT33.StrType)le.dispositiondate),
    offense_Fields.InValid_offenselocation((SALT33.StrType)le.offenselocation),
    offense_Fields.InValid_finaloffense((SALT33.StrType)le.finaloffense),
    offense_Fields.InValid_finaloffensedate((SALT33.StrType)le.finaloffensedate),
    offense_Fields.InValid_offensecount((SALT33.StrType)le.offensecount),
    offense_Fields.InValid_victimunder18((SALT33.StrType)le.victimunder18),
    offense_Fields.InValid_prioroffenseflag((SALT33.StrType)le.prioroffenseflag),
    offense_Fields.InValid_initialplea((SALT33.StrType)le.initialplea),
    offense_Fields.InValid_initialpleadate((SALT33.StrType)le.initialpleadate),
    offense_Fields.InValid_finalruling((SALT33.StrType)le.finalruling),
    offense_Fields.InValid_finalrulingdate((SALT33.StrType)le.finalrulingdate),
    offense_Fields.InValid_appealstatus((SALT33.StrType)le.appealstatus),
    offense_Fields.InValid_appealdate((SALT33.StrType)le.appealdate),
    offense_Fields.InValid_courtname((SALT33.StrType)le.courtname),
    offense_Fields.InValid_fineamount((SALT33.StrType)le.fineamount),
    offense_Fields.InValid_courtfee((SALT33.StrType)le.courtfee),
    offense_Fields.InValid_restitution((SALT33.StrType)le.restitution),
    offense_Fields.InValid_trialtype((SALT33.StrType)le.trialtype),
    offense_Fields.InValid_courtdate((SALT33.StrType)le.courtdate),
    offense_Fields.InValid_sourcename((SALT33.StrType)le.sourcename),
    offense_Fields.InValid_sourceid((SALT33.StrType)le.sourceid),
    offense_Fields.InValid_classification_code((SALT33.StrType)le.classification_code),
    offense_Fields.InValid_sub_classification_code((SALT33.StrType)le.sub_classification_code),
    offense_Fields.InValid_unit((SALT33.StrType)le.unit),
    offense_Fields.InValid_city((SALT33.StrType)le.city),
    offense_Fields.InValid_state((SALT33.StrType)le.state),
    offense_Fields.InValid_zip((SALT33.StrType)le.zip),
    offense_Fields.InValid_county((SALT33.StrType)le.county),
    offense_Fields.InValid_institutionname((SALT33.StrType)le.institutionname),
    offense_Fields.InValid_institutiondetails((SALT33.StrType)le.institutiondetails),
    offense_Fields.InValid_institutionreceiptdate((SALT33.StrType)le.institutionreceiptdate),
    offense_Fields.InValid_releasetolocation((SALT33.StrType)le.releasetolocation),
    offense_Fields.InValid_releasetodetails((SALT33.StrType)le.releasetodetails),
    offense_Fields.InValid_deceasedflag((SALT33.StrType)le.deceasedflag),
    offense_Fields.InValid_deceaseddate((SALT33.StrType)le.deceaseddate),
    offense_Fields.InValid_healthflag((SALT33.StrType)le.healthflag),
    offense_Fields.InValid_healthdesc((SALT33.StrType)le.healthdesc),
    offense_Fields.InValid_bloodtype((SALT33.StrType)le.bloodtype),
    offense_Fields.InValid_sexoffenderregistrydate((SALT33.StrType)le.sexoffenderregistrydate),
    offense_Fields.InValid_sexoffenderregexpirationdate((SALT33.StrType)le.sexoffenderregexpirationdate),
    offense_Fields.InValid_sexoffenderregistrynumber((SALT33.StrType)le.sexoffenderregistrynumber),
    offense_Fields.InValid_sourceid2((SALT33.StrType)le.sourceid2),
    offense_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,64,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := offense_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_Char','Non_Blank','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Invalid_Current_Date','Unknown','Invalid_VictimUnder18','Unknown','Unknown','Invalid_Current_Date','Unknown','Invalid_Current_Date','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,offense_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),offense_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),offense_Fields.InValidMessage_caseid(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casenumber(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casetitle(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casetype(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casestatus(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casestatusdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_casecomments(TotalErrors.ErrorNum),offense_Fields.InValidMessage_fileddate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_caseinfo(TotalErrors.ErrorNum),offense_Fields.InValidMessage_docketnumber(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensecode(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensedesc(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensedate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensetype(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensedegree(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offenseclass(TotalErrors.ErrorNum),offense_Fields.InValidMessage_dispositionstatus(TotalErrors.ErrorNum),offense_Fields.InValidMessage_dispositionstatusdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_disposition(TotalErrors.ErrorNum),offense_Fields.InValidMessage_dispositiondate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offenselocation(TotalErrors.ErrorNum),offense_Fields.InValidMessage_finaloffense(TotalErrors.ErrorNum),offense_Fields.InValidMessage_finaloffensedate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_offensecount(TotalErrors.ErrorNum),offense_Fields.InValidMessage_victimunder18(TotalErrors.ErrorNum),offense_Fields.InValidMessage_prioroffenseflag(TotalErrors.ErrorNum),offense_Fields.InValidMessage_initialplea(TotalErrors.ErrorNum),offense_Fields.InValidMessage_initialpleadate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_finalruling(TotalErrors.ErrorNum),offense_Fields.InValidMessage_finalrulingdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_appealstatus(TotalErrors.ErrorNum),offense_Fields.InValidMessage_appealdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_courtname(TotalErrors.ErrorNum),offense_Fields.InValidMessage_fineamount(TotalErrors.ErrorNum),offense_Fields.InValidMessage_courtfee(TotalErrors.ErrorNum),offense_Fields.InValidMessage_restitution(TotalErrors.ErrorNum),offense_Fields.InValidMessage_trialtype(TotalErrors.ErrorNum),offense_Fields.InValidMessage_courtdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),offense_Fields.InValidMessage_classification_code(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sub_classification_code(TotalErrors.ErrorNum),offense_Fields.InValidMessage_unit(TotalErrors.ErrorNum),offense_Fields.InValidMessage_city(TotalErrors.ErrorNum),offense_Fields.InValidMessage_state(TotalErrors.ErrorNum),offense_Fields.InValidMessage_zip(TotalErrors.ErrorNum),offense_Fields.InValidMessage_county(TotalErrors.ErrorNum),offense_Fields.InValidMessage_institutionname(TotalErrors.ErrorNum),offense_Fields.InValidMessage_institutiondetails(TotalErrors.ErrorNum),offense_Fields.InValidMessage_institutionreceiptdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_releasetolocation(TotalErrors.ErrorNum),offense_Fields.InValidMessage_releasetodetails(TotalErrors.ErrorNum),offense_Fields.InValidMessage_deceasedflag(TotalErrors.ErrorNum),offense_Fields.InValidMessage_deceaseddate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_healthflag(TotalErrors.ErrorNum),offense_Fields.InValidMessage_healthdesc(TotalErrors.ErrorNum),offense_Fields.InValidMessage_bloodtype(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sexoffenderregistrydate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sexoffenderregexpirationdate(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sexoffenderregistrynumber(TotalErrors.ErrorNum),offense_Fields.InValidMessage_sourceid2(TotalErrors.ErrorNum),offense_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
