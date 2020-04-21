IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_ECRulings) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dartid_cnt := COUNT(GROUP,h.dartid <> (TYPEOF(h.dartid))'');
    populated_dartid_pcnt := AVE(GROUP,IF(h.dartid = (TYPEOF(h.dartid))'',0,100));
    maxlength_dartid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)));
    avelength_dartid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)),h.dartid<>(typeof(h.dartid))'');
    populated_dateadded_cnt := COUNT(GROUP,h.dateadded <> (TYPEOF(h.dateadded))'');
    populated_dateadded_pcnt := AVE(GROUP,IF(h.dateadded = (TYPEOF(h.dateadded))'',0,100));
    maxlength_dateadded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)));
    avelength_dateadded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateadded)),h.dateadded<>(typeof(h.dateadded))'');
    populated_dateupdated_cnt := COUNT(GROUP,h.dateupdated <> (TYPEOF(h.dateupdated))'');
    populated_dateupdated_pcnt := AVE(GROUP,IF(h.dateupdated = (TYPEOF(h.dateupdated))'',0,100));
    maxlength_dateupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)));
    avelength_dateupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)),h.dateupdated<>(typeof(h.dateupdated))'');
    populated_website_cnt := COUNT(GROUP,h.website <> (TYPEOF(h.website))'');
    populated_website_pcnt := AVE(GROUP,IF(h.website = (TYPEOF(h.website))'',0,100));
    maxlength_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)));
    avelength_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)),h.website<>(typeof(h.website))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_euid_cnt := COUNT(GROUP,h.euid <> (TYPEOF(h.euid))'');
    populated_euid_pcnt := AVE(GROUP,IF(h.euid = (TYPEOF(h.euid))'',0,100));
    maxlength_euid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.euid)));
    avelength_euid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.euid)),h.euid<>(typeof(h.euid))'');
    populated_policyarea_cnt := COUNT(GROUP,h.policyarea <> (TYPEOF(h.policyarea))'');
    populated_policyarea_pcnt := AVE(GROUP,IF(h.policyarea = (TYPEOF(h.policyarea))'',0,100));
    maxlength_policyarea := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyarea)));
    avelength_policyarea := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policyarea)),h.policyarea<>(typeof(h.policyarea))'');
    populated_casenumber_cnt := COUNT(GROUP,h.casenumber <> (TYPEOF(h.casenumber))'');
    populated_casenumber_pcnt := AVE(GROUP,IF(h.casenumber = (TYPEOF(h.casenumber))'',0,100));
    maxlength_casenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casenumber)));
    avelength_casenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casenumber)),h.casenumber<>(typeof(h.casenumber))'');
    populated_memberstate_cnt := COUNT(GROUP,h.memberstate <> (TYPEOF(h.memberstate))'');
    populated_memberstate_pcnt := AVE(GROUP,IF(h.memberstate = (TYPEOF(h.memberstate))'',0,100));
    maxlength_memberstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.memberstate)));
    avelength_memberstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.memberstate)),h.memberstate<>(typeof(h.memberstate))'');
    populated_lastdecisiondate_cnt := COUNT(GROUP,h.lastdecisiondate <> (TYPEOF(h.lastdecisiondate))'');
    populated_lastdecisiondate_pcnt := AVE(GROUP,IF(h.lastdecisiondate = (TYPEOF(h.lastdecisiondate))'',0,100));
    maxlength_lastdecisiondate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdecisiondate)));
    avelength_lastdecisiondate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdecisiondate)),h.lastdecisiondate<>(typeof(h.lastdecisiondate))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_businessname_cnt := COUNT(GROUP,h.businessname <> (TYPEOF(h.businessname))'');
    populated_businessname_pcnt := AVE(GROUP,IF(h.businessname = (TYPEOF(h.businessname))'',0,100));
    maxlength_businessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)));
    avelength_businessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)),h.businessname<>(typeof(h.businessname))'');
    populated_region_cnt := COUNT(GROUP,h.region <> (TYPEOF(h.region))'');
    populated_region_pcnt := AVE(GROUP,IF(h.region = (TYPEOF(h.region))'',0,100));
    maxlength_region := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.region)));
    avelength_region := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.region)),h.region<>(typeof(h.region))'');
    populated_primaryobjective_cnt := COUNT(GROUP,h.primaryobjective <> (TYPEOF(h.primaryobjective))'');
    populated_primaryobjective_pcnt := AVE(GROUP,IF(h.primaryobjective = (TYPEOF(h.primaryobjective))'',0,100));
    maxlength_primaryobjective := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primaryobjective)));
    avelength_primaryobjective := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primaryobjective)),h.primaryobjective<>(typeof(h.primaryobjective))'');
    populated_aidinstrument_cnt := COUNT(GROUP,h.aidinstrument <> (TYPEOF(h.aidinstrument))'');
    populated_aidinstrument_pcnt := AVE(GROUP,IF(h.aidinstrument = (TYPEOF(h.aidinstrument))'',0,100));
    maxlength_aidinstrument := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aidinstrument)));
    avelength_aidinstrument := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aidinstrument)),h.aidinstrument<>(typeof(h.aidinstrument))'');
    populated_casetype_cnt := COUNT(GROUP,h.casetype <> (TYPEOF(h.casetype))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_durationdatefrom_cnt := COUNT(GROUP,h.durationdatefrom <> (TYPEOF(h.durationdatefrom))'');
    populated_durationdatefrom_pcnt := AVE(GROUP,IF(h.durationdatefrom = (TYPEOF(h.durationdatefrom))'',0,100));
    maxlength_durationdatefrom := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.durationdatefrom)));
    avelength_durationdatefrom := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.durationdatefrom)),h.durationdatefrom<>(typeof(h.durationdatefrom))'');
    populated_durationdateto_cnt := COUNT(GROUP,h.durationdateto <> (TYPEOF(h.durationdateto))'');
    populated_durationdateto_pcnt := AVE(GROUP,IF(h.durationdateto = (TYPEOF(h.durationdateto))'',0,100));
    maxlength_durationdateto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.durationdateto)));
    avelength_durationdateto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.durationdateto)),h.durationdateto<>(typeof(h.durationdateto))'');
    populated_notificationregistrationdate_cnt := COUNT(GROUP,h.notificationregistrationdate <> (TYPEOF(h.notificationregistrationdate))'');
    populated_notificationregistrationdate_pcnt := AVE(GROUP,IF(h.notificationregistrationdate = (TYPEOF(h.notificationregistrationdate))'',0,100));
    maxlength_notificationregistrationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.notificationregistrationdate)));
    avelength_notificationregistrationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.notificationregistrationdate)),h.notificationregistrationdate<>(typeof(h.notificationregistrationdate))'');
    populated_dgresponsible_cnt := COUNT(GROUP,h.dgresponsible <> (TYPEOF(h.dgresponsible))'');
    populated_dgresponsible_pcnt := AVE(GROUP,IF(h.dgresponsible = (TYPEOF(h.dgresponsible))'',0,100));
    maxlength_dgresponsible := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dgresponsible)));
    avelength_dgresponsible := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dgresponsible)),h.dgresponsible<>(typeof(h.dgresponsible))'');
    populated_relatedcasenumber1_cnt := COUNT(GROUP,h.relatedcasenumber1 <> (TYPEOF(h.relatedcasenumber1))'');
    populated_relatedcasenumber1_pcnt := AVE(GROUP,IF(h.relatedcasenumber1 = (TYPEOF(h.relatedcasenumber1))'',0,100));
    maxlength_relatedcasenumber1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber1)));
    avelength_relatedcasenumber1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber1)),h.relatedcasenumber1<>(typeof(h.relatedcasenumber1))'');
    populated_relatedcaseinformation1_cnt := COUNT(GROUP,h.relatedcaseinformation1 <> (TYPEOF(h.relatedcaseinformation1))'');
    populated_relatedcaseinformation1_pcnt := AVE(GROUP,IF(h.relatedcaseinformation1 = (TYPEOF(h.relatedcaseinformation1))'',0,100));
    maxlength_relatedcaseinformation1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation1)));
    avelength_relatedcaseinformation1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation1)),h.relatedcaseinformation1<>(typeof(h.relatedcaseinformation1))'');
    populated_relatedcasenumber2_cnt := COUNT(GROUP,h.relatedcasenumber2 <> (TYPEOF(h.relatedcasenumber2))'');
    populated_relatedcasenumber2_pcnt := AVE(GROUP,IF(h.relatedcasenumber2 = (TYPEOF(h.relatedcasenumber2))'',0,100));
    maxlength_relatedcasenumber2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber2)));
    avelength_relatedcasenumber2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber2)),h.relatedcasenumber2<>(typeof(h.relatedcasenumber2))'');
    populated_relatedcaseinformation2_cnt := COUNT(GROUP,h.relatedcaseinformation2 <> (TYPEOF(h.relatedcaseinformation2))'');
    populated_relatedcaseinformation2_pcnt := AVE(GROUP,IF(h.relatedcaseinformation2 = (TYPEOF(h.relatedcaseinformation2))'',0,100));
    maxlength_relatedcaseinformation2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation2)));
    avelength_relatedcaseinformation2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation2)),h.relatedcaseinformation2<>(typeof(h.relatedcaseinformation2))'');
    populated_relatedcasenumber3_cnt := COUNT(GROUP,h.relatedcasenumber3 <> (TYPEOF(h.relatedcasenumber3))'');
    populated_relatedcasenumber3_pcnt := AVE(GROUP,IF(h.relatedcasenumber3 = (TYPEOF(h.relatedcasenumber3))'',0,100));
    maxlength_relatedcasenumber3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber3)));
    avelength_relatedcasenumber3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber3)),h.relatedcasenumber3<>(typeof(h.relatedcasenumber3))'');
    populated_relatedcaseinformation3_cnt := COUNT(GROUP,h.relatedcaseinformation3 <> (TYPEOF(h.relatedcaseinformation3))'');
    populated_relatedcaseinformation3_pcnt := AVE(GROUP,IF(h.relatedcaseinformation3 = (TYPEOF(h.relatedcaseinformation3))'',0,100));
    maxlength_relatedcaseinformation3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation3)));
    avelength_relatedcaseinformation3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation3)),h.relatedcaseinformation3<>(typeof(h.relatedcaseinformation3))'');
    populated_relatedcasenumber4_cnt := COUNT(GROUP,h.relatedcasenumber4 <> (TYPEOF(h.relatedcasenumber4))'');
    populated_relatedcasenumber4_pcnt := AVE(GROUP,IF(h.relatedcasenumber4 = (TYPEOF(h.relatedcasenumber4))'',0,100));
    maxlength_relatedcasenumber4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber4)));
    avelength_relatedcasenumber4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber4)),h.relatedcasenumber4<>(typeof(h.relatedcasenumber4))'');
    populated_relatedcaseinformation4_cnt := COUNT(GROUP,h.relatedcaseinformation4 <> (TYPEOF(h.relatedcaseinformation4))'');
    populated_relatedcaseinformation4_pcnt := AVE(GROUP,IF(h.relatedcaseinformation4 = (TYPEOF(h.relatedcaseinformation4))'',0,100));
    maxlength_relatedcaseinformation4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation4)));
    avelength_relatedcaseinformation4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation4)),h.relatedcaseinformation4<>(typeof(h.relatedcaseinformation4))'');
    populated_relatedcasenumber5_cnt := COUNT(GROUP,h.relatedcasenumber5 <> (TYPEOF(h.relatedcasenumber5))'');
    populated_relatedcasenumber5_pcnt := AVE(GROUP,IF(h.relatedcasenumber5 = (TYPEOF(h.relatedcasenumber5))'',0,100));
    maxlength_relatedcasenumber5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber5)));
    avelength_relatedcasenumber5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcasenumber5)),h.relatedcasenumber5<>(typeof(h.relatedcasenumber5))'');
    populated_relatedcaseinformation5_cnt := COUNT(GROUP,h.relatedcaseinformation5 <> (TYPEOF(h.relatedcaseinformation5))'');
    populated_relatedcaseinformation5_pcnt := AVE(GROUP,IF(h.relatedcaseinformation5 = (TYPEOF(h.relatedcaseinformation5))'',0,100));
    maxlength_relatedcaseinformation5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation5)));
    avelength_relatedcaseinformation5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedcaseinformation5)),h.relatedcaseinformation5<>(typeof(h.relatedcaseinformation5))'');
    populated_provisionaldeadlinedate_cnt := COUNT(GROUP,h.provisionaldeadlinedate <> (TYPEOF(h.provisionaldeadlinedate))'');
    populated_provisionaldeadlinedate_pcnt := AVE(GROUP,IF(h.provisionaldeadlinedate = (TYPEOF(h.provisionaldeadlinedate))'',0,100));
    maxlength_provisionaldeadlinedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinedate)));
    avelength_provisionaldeadlinedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinedate)),h.provisionaldeadlinedate<>(typeof(h.provisionaldeadlinedate))'');
    populated_provisionaldeadlinearticle_cnt := COUNT(GROUP,h.provisionaldeadlinearticle <> (TYPEOF(h.provisionaldeadlinearticle))'');
    populated_provisionaldeadlinearticle_pcnt := AVE(GROUP,IF(h.provisionaldeadlinearticle = (TYPEOF(h.provisionaldeadlinearticle))'',0,100));
    maxlength_provisionaldeadlinearticle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinearticle)));
    avelength_provisionaldeadlinearticle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinearticle)),h.provisionaldeadlinearticle<>(typeof(h.provisionaldeadlinearticle))'');
    populated_provisionaldeadlinestatus_cnt := COUNT(GROUP,h.provisionaldeadlinestatus <> (TYPEOF(h.provisionaldeadlinestatus))'');
    populated_provisionaldeadlinestatus_pcnt := AVE(GROUP,IF(h.provisionaldeadlinestatus = (TYPEOF(h.provisionaldeadlinestatus))'',0,100));
    maxlength_provisionaldeadlinestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinestatus)));
    avelength_provisionaldeadlinestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.provisionaldeadlinestatus)),h.provisionaldeadlinestatus<>(typeof(h.provisionaldeadlinestatus))'');
    populated_regulation_cnt := COUNT(GROUP,h.regulation <> (TYPEOF(h.regulation))'');
    populated_regulation_pcnt := AVE(GROUP,IF(h.regulation = (TYPEOF(h.regulation))'',0,100));
    maxlength_regulation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regulation)));
    avelength_regulation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regulation)),h.regulation<>(typeof(h.regulation))'');
    populated_relatedlink_cnt := COUNT(GROUP,h.relatedlink <> (TYPEOF(h.relatedlink))'');
    populated_relatedlink_pcnt := AVE(GROUP,IF(h.relatedlink = (TYPEOF(h.relatedlink))'',0,100));
    maxlength_relatedlink := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedlink)));
    avelength_relatedlink := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relatedlink)),h.relatedlink<>(typeof(h.relatedlink))'');
    populated_decpubid_cnt := COUNT(GROUP,h.decpubid <> (TYPEOF(h.decpubid))'');
    populated_decpubid_pcnt := AVE(GROUP,IF(h.decpubid = (TYPEOF(h.decpubid))'',0,100));
    maxlength_decpubid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.decpubid)));
    avelength_decpubid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.decpubid)),h.decpubid<>(typeof(h.decpubid))'');
    populated_decisiondate_cnt := COUNT(GROUP,h.decisiondate <> (TYPEOF(h.decisiondate))'');
    populated_decisiondate_pcnt := AVE(GROUP,IF(h.decisiondate = (TYPEOF(h.decisiondate))'',0,100));
    maxlength_decisiondate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisiondate)));
    avelength_decisiondate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisiondate)),h.decisiondate<>(typeof(h.decisiondate))'');
    populated_decisionarticle_cnt := COUNT(GROUP,h.decisionarticle <> (TYPEOF(h.decisionarticle))'');
    populated_decisionarticle_pcnt := AVE(GROUP,IF(h.decisionarticle = (TYPEOF(h.decisionarticle))'',0,100));
    maxlength_decisionarticle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisionarticle)));
    avelength_decisionarticle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisionarticle)),h.decisionarticle<>(typeof(h.decisionarticle))'');
    populated_decisiondetails_cnt := COUNT(GROUP,h.decisiondetails <> (TYPEOF(h.decisiondetails))'');
    populated_decisiondetails_pcnt := AVE(GROUP,IF(h.decisiondetails = (TYPEOF(h.decisiondetails))'',0,100));
    maxlength_decisiondetails := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisiondetails)));
    avelength_decisiondetails := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.decisiondetails)),h.decisiondetails<>(typeof(h.decisiondetails))'');
    populated_pressrelease_cnt := COUNT(GROUP,h.pressrelease <> (TYPEOF(h.pressrelease))'');
    populated_pressrelease_pcnt := AVE(GROUP,IF(h.pressrelease = (TYPEOF(h.pressrelease))'',0,100));
    maxlength_pressrelease := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pressrelease)));
    avelength_pressrelease := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pressrelease)),h.pressrelease<>(typeof(h.pressrelease))'');
    populated_pressreleasedate_cnt := COUNT(GROUP,h.pressreleasedate <> (TYPEOF(h.pressreleasedate))'');
    populated_pressreleasedate_pcnt := AVE(GROUP,IF(h.pressreleasedate = (TYPEOF(h.pressreleasedate))'',0,100));
    maxlength_pressreleasedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pressreleasedate)));
    avelength_pressreleasedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pressreleasedate)),h.pressreleasedate<>(typeof(h.pressreleasedate))'');
    populated_publicationjournaldate_cnt := COUNT(GROUP,h.publicationjournaldate <> (TYPEOF(h.publicationjournaldate))'');
    populated_publicationjournaldate_pcnt := AVE(GROUP,IF(h.publicationjournaldate = (TYPEOF(h.publicationjournaldate))'',0,100));
    maxlength_publicationjournaldate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournaldate)));
    avelength_publicationjournaldate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournaldate)),h.publicationjournaldate<>(typeof(h.publicationjournaldate))'');
    populated_publicationjournal_cnt := COUNT(GROUP,h.publicationjournal <> (TYPEOF(h.publicationjournal))'');
    populated_publicationjournal_pcnt := AVE(GROUP,IF(h.publicationjournal = (TYPEOF(h.publicationjournal))'',0,100));
    maxlength_publicationjournal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournal)));
    avelength_publicationjournal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournal)),h.publicationjournal<>(typeof(h.publicationjournal))'');
    populated_publicationjournaledition_cnt := COUNT(GROUP,h.publicationjournaledition <> (TYPEOF(h.publicationjournaledition))'');
    populated_publicationjournaledition_pcnt := AVE(GROUP,IF(h.publicationjournaledition = (TYPEOF(h.publicationjournaledition))'',0,100));
    maxlength_publicationjournaledition := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournaledition)));
    avelength_publicationjournaledition := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournaledition)),h.publicationjournaledition<>(typeof(h.publicationjournaledition))'');
    populated_publicationjournalyear_cnt := COUNT(GROUP,h.publicationjournalyear <> (TYPEOF(h.publicationjournalyear))'');
    populated_publicationjournalyear_pcnt := AVE(GROUP,IF(h.publicationjournalyear = (TYPEOF(h.publicationjournalyear))'',0,100));
    maxlength_publicationjournalyear := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournalyear)));
    avelength_publicationjournalyear := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationjournalyear)),h.publicationjournalyear<>(typeof(h.publicationjournalyear))'');
    populated_publicationpriorjournal_cnt := COUNT(GROUP,h.publicationpriorjournal <> (TYPEOF(h.publicationpriorjournal))'');
    populated_publicationpriorjournal_pcnt := AVE(GROUP,IF(h.publicationpriorjournal = (TYPEOF(h.publicationpriorjournal))'',0,100));
    maxlength_publicationpriorjournal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationpriorjournal)));
    avelength_publicationpriorjournal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationpriorjournal)),h.publicationpriorjournal<>(typeof(h.publicationpriorjournal))'');
    populated_publicationpriorjournaldate_cnt := COUNT(GROUP,h.publicationpriorjournaldate <> (TYPEOF(h.publicationpriorjournaldate))'');
    populated_publicationpriorjournaldate_pcnt := AVE(GROUP,IF(h.publicationpriorjournaldate = (TYPEOF(h.publicationpriorjournaldate))'',0,100));
    maxlength_publicationpriorjournaldate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationpriorjournaldate)));
    avelength_publicationpriorjournaldate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicationpriorjournaldate)),h.publicationpriorjournaldate<>(typeof(h.publicationpriorjournaldate))'');
    populated_econactid_cnt := COUNT(GROUP,h.econactid <> (TYPEOF(h.econactid))'');
    populated_econactid_pcnt := AVE(GROUP,IF(h.econactid = (TYPEOF(h.econactid))'',0,100));
    maxlength_econactid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.econactid)));
    avelength_econactid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.econactid)),h.econactid<>(typeof(h.econactid))'');
    populated_economicactivity_cnt := COUNT(GROUP,h.economicactivity <> (TYPEOF(h.economicactivity))'');
    populated_economicactivity_pcnt := AVE(GROUP,IF(h.economicactivity = (TYPEOF(h.economicactivity))'',0,100));
    maxlength_economicactivity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.economicactivity)));
    avelength_economicactivity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.economicactivity)),h.economicactivity<>(typeof(h.economicactivity))'');
    populated_compeventid_cnt := COUNT(GROUP,h.compeventid <> (TYPEOF(h.compeventid))'');
    populated_compeventid_pcnt := AVE(GROUP,IF(h.compeventid = (TYPEOF(h.compeventid))'',0,100));
    maxlength_compeventid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.compeventid)));
    avelength_compeventid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.compeventid)),h.compeventid<>(typeof(h.compeventid))'');
    populated_eventdate_cnt := COUNT(GROUP,h.eventdate <> (TYPEOF(h.eventdate))'');
    populated_eventdate_pcnt := AVE(GROUP,IF(h.eventdate = (TYPEOF(h.eventdate))'',0,100));
    maxlength_eventdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdate)));
    avelength_eventdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdate)),h.eventdate<>(typeof(h.eventdate))'');
    populated_eventdoctype_cnt := COUNT(GROUP,h.eventdoctype <> (TYPEOF(h.eventdoctype))'');
    populated_eventdoctype_pcnt := AVE(GROUP,IF(h.eventdoctype = (TYPEOF(h.eventdoctype))'',0,100));
    maxlength_eventdoctype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdoctype)));
    avelength_eventdoctype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdoctype)),h.eventdoctype<>(typeof(h.eventdoctype))'');
    populated_eventdocument_cnt := COUNT(GROUP,h.eventdocument <> (TYPEOF(h.eventdocument))'');
    populated_eventdocument_pcnt := AVE(GROUP,IF(h.eventdocument = (TYPEOF(h.eventdocument))'',0,100));
    maxlength_eventdocument := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdocument)));
    avelength_eventdocument := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eventdocument)),h.eventdocument<>(typeof(h.eventdocument))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_eu_country_code_cnt := COUNT(GROUP,h.eu_country_code <> (TYPEOF(h.eu_country_code))'');
    populated_eu_country_code_pcnt := AVE(GROUP,IF(h.eu_country_code = (TYPEOF(h.eu_country_code))'',0,100));
    maxlength_eu_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_country_code)));
    avelength_eu_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_country_code)),h.eu_country_code<>(typeof(h.eu_country_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_dateadded_pcnt *   0.00 / 100 + T.Populated_dateupdated_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_euid_pcnt *   0.00 / 100 + T.Populated_policyarea_pcnt *   0.00 / 100 + T.Populated_casenumber_pcnt *   0.00 / 100 + T.Populated_memberstate_pcnt *   0.00 / 100 + T.Populated_lastdecisiondate_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_businessname_pcnt *   0.00 / 100 + T.Populated_region_pcnt *   0.00 / 100 + T.Populated_primaryobjective_pcnt *   0.00 / 100 + T.Populated_aidinstrument_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_durationdatefrom_pcnt *   0.00 / 100 + T.Populated_durationdateto_pcnt *   0.00 / 100 + T.Populated_notificationregistrationdate_pcnt *   0.00 / 100 + T.Populated_dgresponsible_pcnt *   0.00 / 100 + T.Populated_relatedcasenumber1_pcnt *   0.00 / 100 + T.Populated_relatedcaseinformation1_pcnt *   0.00 / 100 + T.Populated_relatedcasenumber2_pcnt *   0.00 / 100 + T.Populated_relatedcaseinformation2_pcnt *   0.00 / 100 + T.Populated_relatedcasenumber3_pcnt *   0.00 / 100 + T.Populated_relatedcaseinformation3_pcnt *   0.00 / 100 + T.Populated_relatedcasenumber4_pcnt *   0.00 / 100 + T.Populated_relatedcaseinformation4_pcnt *   0.00 / 100 + T.Populated_relatedcasenumber5_pcnt *   0.00 / 100 + T.Populated_relatedcaseinformation5_pcnt *   0.00 / 100 + T.Populated_provisionaldeadlinedate_pcnt *   0.00 / 100 + T.Populated_provisionaldeadlinearticle_pcnt *   0.00 / 100 + T.Populated_provisionaldeadlinestatus_pcnt *   0.00 / 100 + T.Populated_regulation_pcnt *   0.00 / 100 + T.Populated_relatedlink_pcnt *   0.00 / 100 + T.Populated_decpubid_pcnt *   0.00 / 100 + T.Populated_decisiondate_pcnt *   0.00 / 100 + T.Populated_decisionarticle_pcnt *   0.00 / 100 + T.Populated_decisiondetails_pcnt *   0.00 / 100 + T.Populated_pressrelease_pcnt *   0.00 / 100 + T.Populated_pressreleasedate_pcnt *   0.00 / 100 + T.Populated_publicationjournaldate_pcnt *   0.00 / 100 + T.Populated_publicationjournal_pcnt *   0.00 / 100 + T.Populated_publicationjournaledition_pcnt *   0.00 / 100 + T.Populated_publicationjournalyear_pcnt *   0.00 / 100 + T.Populated_publicationpriorjournal_pcnt *   0.00 / 100 + T.Populated_publicationpriorjournaldate_pcnt *   0.00 / 100 + T.Populated_econactid_pcnt *   0.00 / 100 + T.Populated_economicactivity_pcnt *   0.00 / 100 + T.Populated_compeventid_pcnt *   0.00 / 100 + T.Populated_eventdate_pcnt *   0.00 / 100 + T.Populated_eventdoctype_pcnt *   0.00 / 100 + T.Populated_eventdocument_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_eu_country_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dartid','dateadded','dateupdated','website','state','euid','policyarea','casenumber','memberstate','lastdecisiondate','title','businessname','region','primaryobjective','aidinstrument','casetype','durationdatefrom','durationdateto','notificationregistrationdate','dgresponsible','relatedcasenumber1','relatedcaseinformation1','relatedcasenumber2','relatedcaseinformation2','relatedcasenumber3','relatedcaseinformation3','relatedcasenumber4','relatedcaseinformation4','relatedcasenumber5','relatedcaseinformation5','provisionaldeadlinedate','provisionaldeadlinearticle','provisionaldeadlinestatus','regulation','relatedlink','decpubid','decisiondate','decisionarticle','decisiondetails','pressrelease','pressreleasedate','publicationjournaldate','publicationjournal','publicationjournaledition','publicationjournalyear','publicationpriorjournal','publicationpriorjournaldate','econactid','economicactivity','compeventid','eventdate','eventdoctype','eventdocument','did','bdid','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','eu_country_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dartid_pcnt,le.populated_dateadded_pcnt,le.populated_dateupdated_pcnt,le.populated_website_pcnt,le.populated_state_pcnt,le.populated_euid_pcnt,le.populated_policyarea_pcnt,le.populated_casenumber_pcnt,le.populated_memberstate_pcnt,le.populated_lastdecisiondate_pcnt,le.populated_title_pcnt,le.populated_businessname_pcnt,le.populated_region_pcnt,le.populated_primaryobjective_pcnt,le.populated_aidinstrument_pcnt,le.populated_casetype_pcnt,le.populated_durationdatefrom_pcnt,le.populated_durationdateto_pcnt,le.populated_notificationregistrationdate_pcnt,le.populated_dgresponsible_pcnt,le.populated_relatedcasenumber1_pcnt,le.populated_relatedcaseinformation1_pcnt,le.populated_relatedcasenumber2_pcnt,le.populated_relatedcaseinformation2_pcnt,le.populated_relatedcasenumber3_pcnt,le.populated_relatedcaseinformation3_pcnt,le.populated_relatedcasenumber4_pcnt,le.populated_relatedcaseinformation4_pcnt,le.populated_relatedcasenumber5_pcnt,le.populated_relatedcaseinformation5_pcnt,le.populated_provisionaldeadlinedate_pcnt,le.populated_provisionaldeadlinearticle_pcnt,le.populated_provisionaldeadlinestatus_pcnt,le.populated_regulation_pcnt,le.populated_relatedlink_pcnt,le.populated_decpubid_pcnt,le.populated_decisiondate_pcnt,le.populated_decisionarticle_pcnt,le.populated_decisiondetails_pcnt,le.populated_pressrelease_pcnt,le.populated_pressreleasedate_pcnt,le.populated_publicationjournaldate_pcnt,le.populated_publicationjournal_pcnt,le.populated_publicationjournaledition_pcnt,le.populated_publicationjournalyear_pcnt,le.populated_publicationpriorjournal_pcnt,le.populated_publicationpriorjournaldate_pcnt,le.populated_econactid_pcnt,le.populated_economicactivity_pcnt,le.populated_compeventid_pcnt,le.populated_eventdate_pcnt,le.populated_eventdoctype_pcnt,le.populated_eventdocument_pcnt,le.populated_did_pcnt,le.populated_bdid_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_eu_country_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dartid,le.maxlength_dateadded,le.maxlength_dateupdated,le.maxlength_website,le.maxlength_state,le.maxlength_euid,le.maxlength_policyarea,le.maxlength_casenumber,le.maxlength_memberstate,le.maxlength_lastdecisiondate,le.maxlength_title,le.maxlength_businessname,le.maxlength_region,le.maxlength_primaryobjective,le.maxlength_aidinstrument,le.maxlength_casetype,le.maxlength_durationdatefrom,le.maxlength_durationdateto,le.maxlength_notificationregistrationdate,le.maxlength_dgresponsible,le.maxlength_relatedcasenumber1,le.maxlength_relatedcaseinformation1,le.maxlength_relatedcasenumber2,le.maxlength_relatedcaseinformation2,le.maxlength_relatedcasenumber3,le.maxlength_relatedcaseinformation3,le.maxlength_relatedcasenumber4,le.maxlength_relatedcaseinformation4,le.maxlength_relatedcasenumber5,le.maxlength_relatedcaseinformation5,le.maxlength_provisionaldeadlinedate,le.maxlength_provisionaldeadlinearticle,le.maxlength_provisionaldeadlinestatus,le.maxlength_regulation,le.maxlength_relatedlink,le.maxlength_decpubid,le.maxlength_decisiondate,le.maxlength_decisionarticle,le.maxlength_decisiondetails,le.maxlength_pressrelease,le.maxlength_pressreleasedate,le.maxlength_publicationjournaldate,le.maxlength_publicationjournal,le.maxlength_publicationjournaledition,le.maxlength_publicationjournalyear,le.maxlength_publicationpriorjournal,le.maxlength_publicationpriorjournaldate,le.maxlength_econactid,le.maxlength_economicactivity,le.maxlength_compeventid,le.maxlength_eventdate,le.maxlength_eventdoctype,le.maxlength_eventdocument,le.maxlength_did,le.maxlength_bdid,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_eu_country_code);
  SELF.avelength := CHOOSE(C,le.avelength_dartid,le.avelength_dateadded,le.avelength_dateupdated,le.avelength_website,le.avelength_state,le.avelength_euid,le.avelength_policyarea,le.avelength_casenumber,le.avelength_memberstate,le.avelength_lastdecisiondate,le.avelength_title,le.avelength_businessname,le.avelength_region,le.avelength_primaryobjective,le.avelength_aidinstrument,le.avelength_casetype,le.avelength_durationdatefrom,le.avelength_durationdateto,le.avelength_notificationregistrationdate,le.avelength_dgresponsible,le.avelength_relatedcasenumber1,le.avelength_relatedcaseinformation1,le.avelength_relatedcasenumber2,le.avelength_relatedcaseinformation2,le.avelength_relatedcasenumber3,le.avelength_relatedcaseinformation3,le.avelength_relatedcasenumber4,le.avelength_relatedcaseinformation4,le.avelength_relatedcasenumber5,le.avelength_relatedcaseinformation5,le.avelength_provisionaldeadlinedate,le.avelength_provisionaldeadlinearticle,le.avelength_provisionaldeadlinestatus,le.avelength_regulation,le.avelength_relatedlink,le.avelength_decpubid,le.avelength_decisiondate,le.avelength_decisionarticle,le.avelength_decisiondetails,le.avelength_pressrelease,le.avelength_pressreleasedate,le.avelength_publicationjournaldate,le.avelength_publicationjournal,le.avelength_publicationjournaledition,le.avelength_publicationjournalyear,le.avelength_publicationpriorjournal,le.avelength_publicationpriorjournaldate,le.avelength_econactid,le.avelength_economicactivity,le.avelength_compeventid,le.avelength_eventdate,le.avelength_eventdoctype,le.avelength_eventdocument,le.avelength_did,le.avelength_bdid,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_eu_country_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 60, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.euid),TRIM((SALT311.StrType)le.policyarea),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.memberstate),TRIM((SALT311.StrType)le.lastdecisiondate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.region),TRIM((SALT311.StrType)le.primaryobjective),TRIM((SALT311.StrType)le.aidinstrument),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.durationdatefrom),TRIM((SALT311.StrType)le.durationdateto),TRIM((SALT311.StrType)le.notificationregistrationdate),TRIM((SALT311.StrType)le.dgresponsible),TRIM((SALT311.StrType)le.relatedcasenumber1),TRIM((SALT311.StrType)le.relatedcaseinformation1),TRIM((SALT311.StrType)le.relatedcasenumber2),TRIM((SALT311.StrType)le.relatedcaseinformation2),TRIM((SALT311.StrType)le.relatedcasenumber3),TRIM((SALT311.StrType)le.relatedcaseinformation3),TRIM((SALT311.StrType)le.relatedcasenumber4),TRIM((SALT311.StrType)le.relatedcaseinformation4),TRIM((SALT311.StrType)le.relatedcasenumber5),TRIM((SALT311.StrType)le.relatedcaseinformation5),TRIM((SALT311.StrType)le.provisionaldeadlinedate),TRIM((SALT311.StrType)le.provisionaldeadlinearticle),TRIM((SALT311.StrType)le.provisionaldeadlinestatus),TRIM((SALT311.StrType)le.regulation),TRIM((SALT311.StrType)le.relatedlink),TRIM((SALT311.StrType)le.decpubid),TRIM((SALT311.StrType)le.decisiondate),TRIM((SALT311.StrType)le.decisionarticle),TRIM((SALT311.StrType)le.decisiondetails),TRIM((SALT311.StrType)le.pressrelease),TRIM((SALT311.StrType)le.pressreleasedate),TRIM((SALT311.StrType)le.publicationjournaldate),TRIM((SALT311.StrType)le.publicationjournal),TRIM((SALT311.StrType)le.publicationjournaledition),TRIM((SALT311.StrType)le.publicationjournalyear),TRIM((SALT311.StrType)le.publicationpriorjournal),TRIM((SALT311.StrType)le.publicationpriorjournaldate),TRIM((SALT311.StrType)le.econactid),TRIM((SALT311.StrType)le.economicactivity),TRIM((SALT311.StrType)le.compeventid),TRIM((SALT311.StrType)le.eventdate),TRIM((SALT311.StrType)le.eventdoctype),TRIM((SALT311.StrType)le.eventdocument),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.eu_country_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,60,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 60);
  SELF.FldNo2 := 1 + (C % 60);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.euid),TRIM((SALT311.StrType)le.policyarea),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.memberstate),TRIM((SALT311.StrType)le.lastdecisiondate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.region),TRIM((SALT311.StrType)le.primaryobjective),TRIM((SALT311.StrType)le.aidinstrument),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.durationdatefrom),TRIM((SALT311.StrType)le.durationdateto),TRIM((SALT311.StrType)le.notificationregistrationdate),TRIM((SALT311.StrType)le.dgresponsible),TRIM((SALT311.StrType)le.relatedcasenumber1),TRIM((SALT311.StrType)le.relatedcaseinformation1),TRIM((SALT311.StrType)le.relatedcasenumber2),TRIM((SALT311.StrType)le.relatedcaseinformation2),TRIM((SALT311.StrType)le.relatedcasenumber3),TRIM((SALT311.StrType)le.relatedcaseinformation3),TRIM((SALT311.StrType)le.relatedcasenumber4),TRIM((SALT311.StrType)le.relatedcaseinformation4),TRIM((SALT311.StrType)le.relatedcasenumber5),TRIM((SALT311.StrType)le.relatedcaseinformation5),TRIM((SALT311.StrType)le.provisionaldeadlinedate),TRIM((SALT311.StrType)le.provisionaldeadlinearticle),TRIM((SALT311.StrType)le.provisionaldeadlinestatus),TRIM((SALT311.StrType)le.regulation),TRIM((SALT311.StrType)le.relatedlink),TRIM((SALT311.StrType)le.decpubid),TRIM((SALT311.StrType)le.decisiondate),TRIM((SALT311.StrType)le.decisionarticle),TRIM((SALT311.StrType)le.decisiondetails),TRIM((SALT311.StrType)le.pressrelease),TRIM((SALT311.StrType)le.pressreleasedate),TRIM((SALT311.StrType)le.publicationjournaldate),TRIM((SALT311.StrType)le.publicationjournal),TRIM((SALT311.StrType)le.publicationjournaledition),TRIM((SALT311.StrType)le.publicationjournalyear),TRIM((SALT311.StrType)le.publicationpriorjournal),TRIM((SALT311.StrType)le.publicationpriorjournaldate),TRIM((SALT311.StrType)le.econactid),TRIM((SALT311.StrType)le.economicactivity),TRIM((SALT311.StrType)le.compeventid),TRIM((SALT311.StrType)le.eventdate),TRIM((SALT311.StrType)le.eventdoctype),TRIM((SALT311.StrType)le.eventdocument),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.eu_country_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.dateadded),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.euid),TRIM((SALT311.StrType)le.policyarea),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.memberstate),TRIM((SALT311.StrType)le.lastdecisiondate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.region),TRIM((SALT311.StrType)le.primaryobjective),TRIM((SALT311.StrType)le.aidinstrument),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.durationdatefrom),TRIM((SALT311.StrType)le.durationdateto),TRIM((SALT311.StrType)le.notificationregistrationdate),TRIM((SALT311.StrType)le.dgresponsible),TRIM((SALT311.StrType)le.relatedcasenumber1),TRIM((SALT311.StrType)le.relatedcaseinformation1),TRIM((SALT311.StrType)le.relatedcasenumber2),TRIM((SALT311.StrType)le.relatedcaseinformation2),TRIM((SALT311.StrType)le.relatedcasenumber3),TRIM((SALT311.StrType)le.relatedcaseinformation3),TRIM((SALT311.StrType)le.relatedcasenumber4),TRIM((SALT311.StrType)le.relatedcaseinformation4),TRIM((SALT311.StrType)le.relatedcasenumber5),TRIM((SALT311.StrType)le.relatedcaseinformation5),TRIM((SALT311.StrType)le.provisionaldeadlinedate),TRIM((SALT311.StrType)le.provisionaldeadlinearticle),TRIM((SALT311.StrType)le.provisionaldeadlinestatus),TRIM((SALT311.StrType)le.regulation),TRIM((SALT311.StrType)le.relatedlink),TRIM((SALT311.StrType)le.decpubid),TRIM((SALT311.StrType)le.decisiondate),TRIM((SALT311.StrType)le.decisionarticle),TRIM((SALT311.StrType)le.decisiondetails),TRIM((SALT311.StrType)le.pressrelease),TRIM((SALT311.StrType)le.pressreleasedate),TRIM((SALT311.StrType)le.publicationjournaldate),TRIM((SALT311.StrType)le.publicationjournal),TRIM((SALT311.StrType)le.publicationjournaledition),TRIM((SALT311.StrType)le.publicationjournalyear),TRIM((SALT311.StrType)le.publicationpriorjournal),TRIM((SALT311.StrType)le.publicationpriorjournaldate),TRIM((SALT311.StrType)le.econactid),TRIM((SALT311.StrType)le.economicactivity),TRIM((SALT311.StrType)le.compeventid),TRIM((SALT311.StrType)le.eventdate),TRIM((SALT311.StrType)le.eventdoctype),TRIM((SALT311.StrType)le.eventdocument),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.eu_country_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),60*60,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dartid'}
      ,{2,'dateadded'}
      ,{3,'dateupdated'}
      ,{4,'website'}
      ,{5,'state'}
      ,{6,'euid'}
      ,{7,'policyarea'}
      ,{8,'casenumber'}
      ,{9,'memberstate'}
      ,{10,'lastdecisiondate'}
      ,{11,'title'}
      ,{12,'businessname'}
      ,{13,'region'}
      ,{14,'primaryobjective'}
      ,{15,'aidinstrument'}
      ,{16,'casetype'}
      ,{17,'durationdatefrom'}
      ,{18,'durationdateto'}
      ,{19,'notificationregistrationdate'}
      ,{20,'dgresponsible'}
      ,{21,'relatedcasenumber1'}
      ,{22,'relatedcaseinformation1'}
      ,{23,'relatedcasenumber2'}
      ,{24,'relatedcaseinformation2'}
      ,{25,'relatedcasenumber3'}
      ,{26,'relatedcaseinformation3'}
      ,{27,'relatedcasenumber4'}
      ,{28,'relatedcaseinformation4'}
      ,{29,'relatedcasenumber5'}
      ,{30,'relatedcaseinformation5'}
      ,{31,'provisionaldeadlinedate'}
      ,{32,'provisionaldeadlinearticle'}
      ,{33,'provisionaldeadlinestatus'}
      ,{34,'regulation'}
      ,{35,'relatedlink'}
      ,{36,'decpubid'}
      ,{37,'decisiondate'}
      ,{38,'decisionarticle'}
      ,{39,'decisiondetails'}
      ,{40,'pressrelease'}
      ,{41,'pressreleasedate'}
      ,{42,'publicationjournaldate'}
      ,{43,'publicationjournal'}
      ,{44,'publicationjournaledition'}
      ,{45,'publicationjournalyear'}
      ,{46,'publicationpriorjournal'}
      ,{47,'publicationpriorjournaldate'}
      ,{48,'econactid'}
      ,{49,'economicactivity'}
      ,{50,'compeventid'}
      ,{51,'eventdate'}
      ,{52,'eventdoctype'}
      ,{53,'eventdocument'}
      ,{54,'did'}
      ,{55,'bdid'}
      ,{56,'dt_vendor_first_reported'}
      ,{57,'dt_vendor_last_reported'}
      ,{58,'dt_first_seen'}
      ,{59,'dt_last_seen'}
      ,{60,'eu_country_code'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Fields.InValid_dateadded((SALT311.StrType)le.dateadded),
    Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated),
    Fields.InValid_website((SALT311.StrType)le.website),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_euid((SALT311.StrType)le.euid),
    Fields.InValid_policyarea((SALT311.StrType)le.policyarea),
    Fields.InValid_casenumber((SALT311.StrType)le.casenumber),
    Fields.InValid_memberstate((SALT311.StrType)le.memberstate),
    Fields.InValid_lastdecisiondate((SALT311.StrType)le.lastdecisiondate),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_businessname((SALT311.StrType)le.businessname),
    Fields.InValid_region((SALT311.StrType)le.region),
    Fields.InValid_primaryobjective((SALT311.StrType)le.primaryobjective),
    Fields.InValid_aidinstrument((SALT311.StrType)le.aidinstrument),
    Fields.InValid_casetype((SALT311.StrType)le.casetype),
    Fields.InValid_durationdatefrom((SALT311.StrType)le.durationdatefrom),
    Fields.InValid_durationdateto((SALT311.StrType)le.durationdateto),
    Fields.InValid_notificationregistrationdate((SALT311.StrType)le.notificationregistrationdate),
    Fields.InValid_dgresponsible((SALT311.StrType)le.dgresponsible),
    Fields.InValid_relatedcasenumber1((SALT311.StrType)le.relatedcasenumber1),
    Fields.InValid_relatedcaseinformation1((SALT311.StrType)le.relatedcaseinformation1),
    Fields.InValid_relatedcasenumber2((SALT311.StrType)le.relatedcasenumber2),
    Fields.InValid_relatedcaseinformation2((SALT311.StrType)le.relatedcaseinformation2),
    Fields.InValid_relatedcasenumber3((SALT311.StrType)le.relatedcasenumber3),
    Fields.InValid_relatedcaseinformation3((SALT311.StrType)le.relatedcaseinformation3),
    Fields.InValid_relatedcasenumber4((SALT311.StrType)le.relatedcasenumber4),
    Fields.InValid_relatedcaseinformation4((SALT311.StrType)le.relatedcaseinformation4),
    Fields.InValid_relatedcasenumber5((SALT311.StrType)le.relatedcasenumber5),
    Fields.InValid_relatedcaseinformation5((SALT311.StrType)le.relatedcaseinformation5),
    Fields.InValid_provisionaldeadlinedate((SALT311.StrType)le.provisionaldeadlinedate),
    Fields.InValid_provisionaldeadlinearticle((SALT311.StrType)le.provisionaldeadlinearticle),
    Fields.InValid_provisionaldeadlinestatus((SALT311.StrType)le.provisionaldeadlinestatus),
    Fields.InValid_regulation((SALT311.StrType)le.regulation),
    Fields.InValid_relatedlink((SALT311.StrType)le.relatedlink),
    Fields.InValid_decpubid((SALT311.StrType)le.decpubid),
    Fields.InValid_decisiondate((SALT311.StrType)le.decisiondate),
    Fields.InValid_decisionarticle((SALT311.StrType)le.decisionarticle),
    Fields.InValid_decisiondetails((SALT311.StrType)le.decisiondetails),
    Fields.InValid_pressrelease((SALT311.StrType)le.pressrelease),
    Fields.InValid_pressreleasedate((SALT311.StrType)le.pressreleasedate),
    Fields.InValid_publicationjournaldate((SALT311.StrType)le.publicationjournaldate),
    Fields.InValid_publicationjournal((SALT311.StrType)le.publicationjournal),
    Fields.InValid_publicationjournaledition((SALT311.StrType)le.publicationjournaledition),
    Fields.InValid_publicationjournalyear((SALT311.StrType)le.publicationjournalyear),
    Fields.InValid_publicationpriorjournal((SALT311.StrType)le.publicationpriorjournal),
    Fields.InValid_publicationpriorjournaldate((SALT311.StrType)le.publicationpriorjournaldate),
    Fields.InValid_econactid((SALT311.StrType)le.econactid),
    Fields.InValid_economicactivity((SALT311.StrType)le.economicactivity),
    Fields.InValid_compeventid((SALT311.StrType)le.compeventid),
    Fields.InValid_eventdate((SALT311.StrType)le.eventdate),
    Fields.InValid_eventdoctype((SALT311.StrType)le.eventdoctype),
    Fields.InValid_eventdocument((SALT311.StrType)le.eventdocument),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_eu_country_code((SALT311.StrType)le.eu_country_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,60,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_Date','Unknown','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Date','Invalid_Date','Invalid_Future','Invalid_Date','Invalid_Alpha','Invalid_No','Unknown','Invalid_No','Unknown','Invalid_No','Unknown','Invalid_No','Unknown','Invalid_No','Unknown','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Date','Invalid_No','Invalid_Date','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Date','Invalid_Date','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_AlphaNumChar','Invalid_No','Invalid_Date','Invalid_Alpha','Invalid_AlphaChar','Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_State');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Fields.InValidMessage_dateadded(TotalErrors.ErrorNum),Fields.InValidMessage_dateupdated(TotalErrors.ErrorNum),Fields.InValidMessage_website(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_euid(TotalErrors.ErrorNum),Fields.InValidMessage_policyarea(TotalErrors.ErrorNum),Fields.InValidMessage_casenumber(TotalErrors.ErrorNum),Fields.InValidMessage_memberstate(TotalErrors.ErrorNum),Fields.InValidMessage_lastdecisiondate(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_businessname(TotalErrors.ErrorNum),Fields.InValidMessage_region(TotalErrors.ErrorNum),Fields.InValidMessage_primaryobjective(TotalErrors.ErrorNum),Fields.InValidMessage_aidinstrument(TotalErrors.ErrorNum),Fields.InValidMessage_casetype(TotalErrors.ErrorNum),Fields.InValidMessage_durationdatefrom(TotalErrors.ErrorNum),Fields.InValidMessage_durationdateto(TotalErrors.ErrorNum),Fields.InValidMessage_notificationregistrationdate(TotalErrors.ErrorNum),Fields.InValidMessage_dgresponsible(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcasenumber1(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcaseinformation1(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcasenumber2(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcaseinformation2(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcasenumber3(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcaseinformation3(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcasenumber4(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcaseinformation4(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcasenumber5(TotalErrors.ErrorNum),Fields.InValidMessage_relatedcaseinformation5(TotalErrors.ErrorNum),Fields.InValidMessage_provisionaldeadlinedate(TotalErrors.ErrorNum),Fields.InValidMessage_provisionaldeadlinearticle(TotalErrors.ErrorNum),Fields.InValidMessage_provisionaldeadlinestatus(TotalErrors.ErrorNum),Fields.InValidMessage_regulation(TotalErrors.ErrorNum),Fields.InValidMessage_relatedlink(TotalErrors.ErrorNum),Fields.InValidMessage_decpubid(TotalErrors.ErrorNum),Fields.InValidMessage_decisiondate(TotalErrors.ErrorNum),Fields.InValidMessage_decisionarticle(TotalErrors.ErrorNum),Fields.InValidMessage_decisiondetails(TotalErrors.ErrorNum),Fields.InValidMessage_pressrelease(TotalErrors.ErrorNum),Fields.InValidMessage_pressreleasedate(TotalErrors.ErrorNum),Fields.InValidMessage_publicationjournaldate(TotalErrors.ErrorNum),Fields.InValidMessage_publicationjournal(TotalErrors.ErrorNum),Fields.InValidMessage_publicationjournaledition(TotalErrors.ErrorNum),Fields.InValidMessage_publicationjournalyear(TotalErrors.ErrorNum),Fields.InValidMessage_publicationpriorjournal(TotalErrors.ErrorNum),Fields.InValidMessage_publicationpriorjournaldate(TotalErrors.ErrorNum),Fields.InValidMessage_econactid(TotalErrors.ErrorNum),Fields.InValidMessage_economicactivity(TotalErrors.ErrorNum),Fields.InValidMessage_compeventid(TotalErrors.ErrorNum),Fields.InValidMessage_eventdate(TotalErrors.ErrorNum),Fields.InValidMessage_eventdoctype(TotalErrors.ErrorNum),Fields.InValidMessage_eventdocument(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_eu_country_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_ECRulings, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
