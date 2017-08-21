IMPORT ut,SALT33;
EXPORT sentence_doc_hygiene(dataset(sentence_doc_layout_crim) h) := MODULE
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
    populated_sentencedate_pcnt := AVE(GROUP,IF(h.sentencedate = (TYPEOF(h.sentencedate))'',0,100));
    maxlength_sentencedate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencedate)));
    avelength_sentencedate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencedate)),h.sentencedate<>(typeof(h.sentencedate))'');
    populated_sentencebegindate_pcnt := AVE(GROUP,IF(h.sentencebegindate = (TYPEOF(h.sentencebegindate))'',0,100));
    maxlength_sentencebegindate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencebegindate)));
    avelength_sentencebegindate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencebegindate)),h.sentencebegindate<>(typeof(h.sentencebegindate))'');
    populated_sentenceenddate_pcnt := AVE(GROUP,IF(h.sentenceenddate = (TYPEOF(h.sentenceenddate))'',0,100));
    maxlength_sentenceenddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceenddate)));
    avelength_sentenceenddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceenddate)),h.sentenceenddate<>(typeof(h.sentenceenddate))'');
    populated_sentencetype_pcnt := AVE(GROUP,IF(h.sentencetype = (TYPEOF(h.sentencetype))'',0,100));
    maxlength_sentencetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencetype)));
    avelength_sentencetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencetype)),h.sentencetype<>(typeof(h.sentencetype))'');
    populated_sentencemaxyears_pcnt := AVE(GROUP,IF(h.sentencemaxyears = (TYPEOF(h.sentencemaxyears))'',0,100));
    maxlength_sentencemaxyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxyears)));
    avelength_sentencemaxyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxyears)),h.sentencemaxyears<>(typeof(h.sentencemaxyears))'');
    populated_sentencemaxmonths_pcnt := AVE(GROUP,IF(h.sentencemaxmonths = (TYPEOF(h.sentencemaxmonths))'',0,100));
    maxlength_sentencemaxmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxmonths)));
    avelength_sentencemaxmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxmonths)),h.sentencemaxmonths<>(typeof(h.sentencemaxmonths))'');
    populated_sentencemaxdays_pcnt := AVE(GROUP,IF(h.sentencemaxdays = (TYPEOF(h.sentencemaxdays))'',0,100));
    maxlength_sentencemaxdays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxdays)));
    avelength_sentencemaxdays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemaxdays)),h.sentencemaxdays<>(typeof(h.sentencemaxdays))'');
    populated_sentenceminyears_pcnt := AVE(GROUP,IF(h.sentenceminyears = (TYPEOF(h.sentenceminyears))'',0,100));
    maxlength_sentenceminyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceminyears)));
    avelength_sentenceminyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceminyears)),h.sentenceminyears<>(typeof(h.sentenceminyears))'');
    populated_sentenceminmonths_pcnt := AVE(GROUP,IF(h.sentenceminmonths = (TYPEOF(h.sentenceminmonths))'',0,100));
    maxlength_sentenceminmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceminmonths)));
    avelength_sentenceminmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceminmonths)),h.sentenceminmonths<>(typeof(h.sentenceminmonths))'');
    populated_sentencemindays_pcnt := AVE(GROUP,IF(h.sentencemindays = (TYPEOF(h.sentencemindays))'',0,100));
    maxlength_sentencemindays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemindays)));
    avelength_sentencemindays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencemindays)),h.sentencemindays<>(typeof(h.sentencemindays))'');
    populated_scheduledreleasedate_pcnt := AVE(GROUP,IF(h.scheduledreleasedate = (TYPEOF(h.scheduledreleasedate))'',0,100));
    maxlength_scheduledreleasedate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scheduledreleasedate)));
    avelength_scheduledreleasedate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scheduledreleasedate)),h.scheduledreleasedate<>(typeof(h.scheduledreleasedate))'');
    populated_actualreleasedate_pcnt := AVE(GROUP,IF(h.actualreleasedate = (TYPEOF(h.actualreleasedate))'',0,100));
    maxlength_actualreleasedate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.actualreleasedate)));
    avelength_actualreleasedate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.actualreleasedate)),h.actualreleasedate<>(typeof(h.actualreleasedate))'');
    populated_sentencestatus_pcnt := AVE(GROUP,IF(h.sentencestatus = (TYPEOF(h.sentencestatus))'',0,100));
    maxlength_sentencestatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencestatus)));
    avelength_sentencestatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentencestatus)),h.sentencestatus<>(typeof(h.sentencestatus))'');
    populated_timeservedyears_pcnt := AVE(GROUP,IF(h.timeservedyears = (TYPEOF(h.timeservedyears))'',0,100));
    maxlength_timeservedyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeservedyears)));
    avelength_timeservedyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeservedyears)),h.timeservedyears<>(typeof(h.timeservedyears))'');
    populated_timeservedmonths_pcnt := AVE(GROUP,IF(h.timeservedmonths = (TYPEOF(h.timeservedmonths))'',0,100));
    maxlength_timeservedmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeservedmonths)));
    avelength_timeservedmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeservedmonths)),h.timeservedmonths<>(typeof(h.timeservedmonths))'');
    populated_timeserveddays_pcnt := AVE(GROUP,IF(h.timeserveddays = (TYPEOF(h.timeserveddays))'',0,100));
    maxlength_timeserveddays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeserveddays)));
    avelength_timeserveddays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.timeserveddays)),h.timeserveddays<>(typeof(h.timeserveddays))'');
    populated_publicservicehours_pcnt := AVE(GROUP,IF(h.publicservicehours = (TYPEOF(h.publicservicehours))'',0,100));
    maxlength_publicservicehours := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.publicservicehours)));
    avelength_publicservicehours := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.publicservicehours)),h.publicservicehours<>(typeof(h.publicservicehours))'');
    populated_sentenceadditionalinfo_pcnt := AVE(GROUP,IF(h.sentenceadditionalinfo = (TYPEOF(h.sentenceadditionalinfo))'',0,100));
    maxlength_sentenceadditionalinfo := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceadditionalinfo)));
    avelength_sentenceadditionalinfo := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sentenceadditionalinfo)),h.sentenceadditionalinfo<>(typeof(h.sentenceadditionalinfo))'');
    populated_communitysupervisioncounty_pcnt := AVE(GROUP,IF(h.communitysupervisioncounty = (TYPEOF(h.communitysupervisioncounty))'',0,100));
    maxlength_communitysupervisioncounty := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisioncounty)));
    avelength_communitysupervisioncounty := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisioncounty)),h.communitysupervisioncounty<>(typeof(h.communitysupervisioncounty))'');
    populated_communitysupervisionyears_pcnt := AVE(GROUP,IF(h.communitysupervisionyears = (TYPEOF(h.communitysupervisionyears))'',0,100));
    maxlength_communitysupervisionyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisionyears)));
    avelength_communitysupervisionyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisionyears)),h.communitysupervisionyears<>(typeof(h.communitysupervisionyears))'');
    populated_communitysupervisionmonths_pcnt := AVE(GROUP,IF(h.communitysupervisionmonths = (TYPEOF(h.communitysupervisionmonths))'',0,100));
    maxlength_communitysupervisionmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisionmonths)));
    avelength_communitysupervisionmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisionmonths)),h.communitysupervisionmonths<>(typeof(h.communitysupervisionmonths))'');
    populated_communitysupervisiondays_pcnt := AVE(GROUP,IF(h.communitysupervisiondays = (TYPEOF(h.communitysupervisiondays))'',0,100));
    maxlength_communitysupervisiondays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisiondays)));
    avelength_communitysupervisiondays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.communitysupervisiondays)),h.communitysupervisiondays<>(typeof(h.communitysupervisiondays))'');
    populated_parolebegindate_pcnt := AVE(GROUP,IF(h.parolebegindate = (TYPEOF(h.parolebegindate))'',0,100));
    maxlength_parolebegindate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolebegindate)));
    avelength_parolebegindate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolebegindate)),h.parolebegindate<>(typeof(h.parolebegindate))'');
    populated_paroleenddate_pcnt := AVE(GROUP,IF(h.paroleenddate = (TYPEOF(h.paroleenddate))'',0,100));
    maxlength_paroleenddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleenddate)));
    avelength_paroleenddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleenddate)),h.paroleenddate<>(typeof(h.paroleenddate))'');
    populated_paroleeligibilitydate_pcnt := AVE(GROUP,IF(h.paroleeligibilitydate = (TYPEOF(h.paroleeligibilitydate))'',0,100));
    maxlength_paroleeligibilitydate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleeligibilitydate)));
    avelength_paroleeligibilitydate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleeligibilitydate)),h.paroleeligibilitydate<>(typeof(h.paroleeligibilitydate))'');
    populated_parolehearingdate_pcnt := AVE(GROUP,IF(h.parolehearingdate = (TYPEOF(h.parolehearingdate))'',0,100));
    maxlength_parolehearingdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolehearingdate)));
    avelength_parolehearingdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolehearingdate)),h.parolehearingdate<>(typeof(h.parolehearingdate))'');
    populated_parolemaxyears_pcnt := AVE(GROUP,IF(h.parolemaxyears = (TYPEOF(h.parolemaxyears))'',0,100));
    maxlength_parolemaxyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxyears)));
    avelength_parolemaxyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxyears)),h.parolemaxyears<>(typeof(h.parolemaxyears))'');
    populated_parolemaxmonths_pcnt := AVE(GROUP,IF(h.parolemaxmonths = (TYPEOF(h.parolemaxmonths))'',0,100));
    maxlength_parolemaxmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxmonths)));
    avelength_parolemaxmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxmonths)),h.parolemaxmonths<>(typeof(h.parolemaxmonths))'');
    populated_parolemaxdays_pcnt := AVE(GROUP,IF(h.parolemaxdays = (TYPEOF(h.parolemaxdays))'',0,100));
    maxlength_parolemaxdays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxdays)));
    avelength_parolemaxdays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemaxdays)),h.parolemaxdays<>(typeof(h.parolemaxdays))'');
    populated_paroleminyears_pcnt := AVE(GROUP,IF(h.paroleminyears = (TYPEOF(h.paroleminyears))'',0,100));
    maxlength_paroleminyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleminyears)));
    avelength_paroleminyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleminyears)),h.paroleminyears<>(typeof(h.paroleminyears))'');
    populated_paroleminmonths_pcnt := AVE(GROUP,IF(h.paroleminmonths = (TYPEOF(h.paroleminmonths))'',0,100));
    maxlength_paroleminmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleminmonths)));
    avelength_paroleminmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleminmonths)),h.paroleminmonths<>(typeof(h.paroleminmonths))'');
    populated_parolemindays_pcnt := AVE(GROUP,IF(h.parolemindays = (TYPEOF(h.parolemindays))'',0,100));
    maxlength_parolemindays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemindays)));
    avelength_parolemindays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolemindays)),h.parolemindays<>(typeof(h.parolemindays))'');
    populated_parolestatus_pcnt := AVE(GROUP,IF(h.parolestatus = (TYPEOF(h.parolestatus))'',0,100));
    maxlength_parolestatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolestatus)));
    avelength_parolestatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parolestatus)),h.parolestatus<>(typeof(h.parolestatus))'');
    populated_paroleofficer_pcnt := AVE(GROUP,IF(h.paroleofficer = (TYPEOF(h.paroleofficer))'',0,100));
    maxlength_paroleofficer := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleofficer)));
    avelength_paroleofficer := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleofficer)),h.paroleofficer<>(typeof(h.paroleofficer))'');
    populated_paroleoffcerphone_pcnt := AVE(GROUP,IF(h.paroleoffcerphone = (TYPEOF(h.paroleoffcerphone))'',0,100));
    maxlength_paroleoffcerphone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleoffcerphone)));
    avelength_paroleoffcerphone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.paroleoffcerphone)),h.paroleoffcerphone<>(typeof(h.paroleoffcerphone))'');
    populated_probationbegindate_pcnt := AVE(GROUP,IF(h.probationbegindate = (TYPEOF(h.probationbegindate))'',0,100));
    maxlength_probationbegindate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationbegindate)));
    avelength_probationbegindate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationbegindate)),h.probationbegindate<>(typeof(h.probationbegindate))'');
    populated_probationenddate_pcnt := AVE(GROUP,IF(h.probationenddate = (TYPEOF(h.probationenddate))'',0,100));
    maxlength_probationenddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationenddate)));
    avelength_probationenddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationenddate)),h.probationenddate<>(typeof(h.probationenddate))'');
    populated_probationmaxyears_pcnt := AVE(GROUP,IF(h.probationmaxyears = (TYPEOF(h.probationmaxyears))'',0,100));
    maxlength_probationmaxyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxyears)));
    avelength_probationmaxyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxyears)),h.probationmaxyears<>(typeof(h.probationmaxyears))'');
    populated_probationmaxmonths_pcnt := AVE(GROUP,IF(h.probationmaxmonths = (TYPEOF(h.probationmaxmonths))'',0,100));
    maxlength_probationmaxmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxmonths)));
    avelength_probationmaxmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxmonths)),h.probationmaxmonths<>(typeof(h.probationmaxmonths))'');
    populated_probationmaxdays_pcnt := AVE(GROUP,IF(h.probationmaxdays = (TYPEOF(h.probationmaxdays))'',0,100));
    maxlength_probationmaxdays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxdays)));
    avelength_probationmaxdays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmaxdays)),h.probationmaxdays<>(typeof(h.probationmaxdays))'');
    populated_probationminyears_pcnt := AVE(GROUP,IF(h.probationminyears = (TYPEOF(h.probationminyears))'',0,100));
    maxlength_probationminyears := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationminyears)));
    avelength_probationminyears := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationminyears)),h.probationminyears<>(typeof(h.probationminyears))'');
    populated_probationminmonths_pcnt := AVE(GROUP,IF(h.probationminmonths = (TYPEOF(h.probationminmonths))'',0,100));
    maxlength_probationminmonths := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationminmonths)));
    avelength_probationminmonths := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationminmonths)),h.probationminmonths<>(typeof(h.probationminmonths))'');
    populated_probationmindays_pcnt := AVE(GROUP,IF(h.probationmindays = (TYPEOF(h.probationmindays))'',0,100));
    maxlength_probationmindays := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmindays)));
    avelength_probationmindays := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationmindays)),h.probationmindays<>(typeof(h.probationmindays))'');
    populated_probationstatus_pcnt := AVE(GROUP,IF(h.probationstatus = (TYPEOF(h.probationstatus))'',0,100));
    maxlength_probationstatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationstatus)));
    avelength_probationstatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.probationstatus)),h.probationstatus<>(typeof(h.probationstatus))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_sentencedate_pcnt *   0.00 / 100 + T.Populated_sentencebegindate_pcnt *   0.00 / 100 + T.Populated_sentenceenddate_pcnt *   0.00 / 100 + T.Populated_sentencetype_pcnt *   0.00 / 100 + T.Populated_sentencemaxyears_pcnt *   0.00 / 100 + T.Populated_sentencemaxmonths_pcnt *   0.00 / 100 + T.Populated_sentencemaxdays_pcnt *   0.00 / 100 + T.Populated_sentenceminyears_pcnt *   0.00 / 100 + T.Populated_sentenceminmonths_pcnt *   0.00 / 100 + T.Populated_sentencemindays_pcnt *   0.00 / 100 + T.Populated_scheduledreleasedate_pcnt *   0.00 / 100 + T.Populated_actualreleasedate_pcnt *   0.00 / 100 + T.Populated_sentencestatus_pcnt *   0.00 / 100 + T.Populated_timeservedyears_pcnt *   0.00 / 100 + T.Populated_timeservedmonths_pcnt *   0.00 / 100 + T.Populated_timeserveddays_pcnt *   0.00 / 100 + T.Populated_publicservicehours_pcnt *   0.00 / 100 + T.Populated_sentenceadditionalinfo_pcnt *   0.00 / 100 + T.Populated_communitysupervisioncounty_pcnt *   0.00 / 100 + T.Populated_communitysupervisionyears_pcnt *   0.00 / 100 + T.Populated_communitysupervisionmonths_pcnt *   0.00 / 100 + T.Populated_communitysupervisiondays_pcnt *   0.00 / 100 + T.Populated_parolebegindate_pcnt *   0.00 / 100 + T.Populated_paroleenddate_pcnt *   0.00 / 100 + T.Populated_paroleeligibilitydate_pcnt *   0.00 / 100 + T.Populated_parolehearingdate_pcnt *   0.00 / 100 + T.Populated_parolemaxyears_pcnt *   0.00 / 100 + T.Populated_parolemaxmonths_pcnt *   0.00 / 100 + T.Populated_parolemaxdays_pcnt *   0.00 / 100 + T.Populated_paroleminyears_pcnt *   0.00 / 100 + T.Populated_paroleminmonths_pcnt *   0.00 / 100 + T.Populated_parolemindays_pcnt *   0.00 / 100 + T.Populated_parolestatus_pcnt *   0.00 / 100 + T.Populated_paroleofficer_pcnt *   0.00 / 100 + T.Populated_paroleoffcerphone_pcnt *   0.00 / 100 + T.Populated_probationbegindate_pcnt *   0.00 / 100 + T.Populated_probationenddate_pcnt *   0.00 / 100 + T.Populated_probationmaxyears_pcnt *   0.00 / 100 + T.Populated_probationmaxmonths_pcnt *   0.00 / 100 + T.Populated_probationmaxdays_pcnt *   0.00 / 100 + T.Populated_probationminyears_pcnt *   0.00 / 100 + T.Populated_probationminmonths_pcnt *   0.00 / 100 + T.Populated_probationmindays_pcnt *   0.00 / 100 + T.Populated_probationstatus_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_sentencedate_pcnt*ri.Populated_sentencedate_pcnt *   0.00 / 10000 + le.Populated_sentencebegindate_pcnt*ri.Populated_sentencebegindate_pcnt *   0.00 / 10000 + le.Populated_sentenceenddate_pcnt*ri.Populated_sentenceenddate_pcnt *   0.00 / 10000 + le.Populated_sentencetype_pcnt*ri.Populated_sentencetype_pcnt *   0.00 / 10000 + le.Populated_sentencemaxyears_pcnt*ri.Populated_sentencemaxyears_pcnt *   0.00 / 10000 + le.Populated_sentencemaxmonths_pcnt*ri.Populated_sentencemaxmonths_pcnt *   0.00 / 10000 + le.Populated_sentencemaxdays_pcnt*ri.Populated_sentencemaxdays_pcnt *   0.00 / 10000 + le.Populated_sentenceminyears_pcnt*ri.Populated_sentenceminyears_pcnt *   0.00 / 10000 + le.Populated_sentenceminmonths_pcnt*ri.Populated_sentenceminmonths_pcnt *   0.00 / 10000 + le.Populated_sentencemindays_pcnt*ri.Populated_sentencemindays_pcnt *   0.00 / 10000 + le.Populated_scheduledreleasedate_pcnt*ri.Populated_scheduledreleasedate_pcnt *   0.00 / 10000 + le.Populated_actualreleasedate_pcnt*ri.Populated_actualreleasedate_pcnt *   0.00 / 10000 + le.Populated_sentencestatus_pcnt*ri.Populated_sentencestatus_pcnt *   0.00 / 10000 + le.Populated_timeservedyears_pcnt*ri.Populated_timeservedyears_pcnt *   0.00 / 10000 + le.Populated_timeservedmonths_pcnt*ri.Populated_timeservedmonths_pcnt *   0.00 / 10000 + le.Populated_timeserveddays_pcnt*ri.Populated_timeserveddays_pcnt *   0.00 / 10000 + le.Populated_publicservicehours_pcnt*ri.Populated_publicservicehours_pcnt *   0.00 / 10000 + le.Populated_sentenceadditionalinfo_pcnt*ri.Populated_sentenceadditionalinfo_pcnt *   0.00 / 10000 + le.Populated_communitysupervisioncounty_pcnt*ri.Populated_communitysupervisioncounty_pcnt *   0.00 / 10000 + le.Populated_communitysupervisionyears_pcnt*ri.Populated_communitysupervisionyears_pcnt *   0.00 / 10000 + le.Populated_communitysupervisionmonths_pcnt*ri.Populated_communitysupervisionmonths_pcnt *   0.00 / 10000 + le.Populated_communitysupervisiondays_pcnt*ri.Populated_communitysupervisiondays_pcnt *   0.00 / 10000 + le.Populated_parolebegindate_pcnt*ri.Populated_parolebegindate_pcnt *   0.00 / 10000 + le.Populated_paroleenddate_pcnt*ri.Populated_paroleenddate_pcnt *   0.00 / 10000 + le.Populated_paroleeligibilitydate_pcnt*ri.Populated_paroleeligibilitydate_pcnt *   0.00 / 10000 + le.Populated_parolehearingdate_pcnt*ri.Populated_parolehearingdate_pcnt *   0.00 / 10000 + le.Populated_parolemaxyears_pcnt*ri.Populated_parolemaxyears_pcnt *   0.00 / 10000 + le.Populated_parolemaxmonths_pcnt*ri.Populated_parolemaxmonths_pcnt *   0.00 / 10000 + le.Populated_parolemaxdays_pcnt*ri.Populated_parolemaxdays_pcnt *   0.00 / 10000 + le.Populated_paroleminyears_pcnt*ri.Populated_paroleminyears_pcnt *   0.00 / 10000 + le.Populated_paroleminmonths_pcnt*ri.Populated_paroleminmonths_pcnt *   0.00 / 10000 + le.Populated_parolemindays_pcnt*ri.Populated_parolemindays_pcnt *   0.00 / 10000 + le.Populated_parolestatus_pcnt*ri.Populated_parolestatus_pcnt *   0.00 / 10000 + le.Populated_paroleofficer_pcnt*ri.Populated_paroleofficer_pcnt *   0.00 / 10000 + le.Populated_paroleoffcerphone_pcnt*ri.Populated_paroleoffcerphone_pcnt *   0.00 / 10000 + le.Populated_probationbegindate_pcnt*ri.Populated_probationbegindate_pcnt *   0.00 / 10000 + le.Populated_probationenddate_pcnt*ri.Populated_probationenddate_pcnt *   0.00 / 10000 + le.Populated_probationmaxyears_pcnt*ri.Populated_probationmaxyears_pcnt *   0.00 / 10000 + le.Populated_probationmaxmonths_pcnt*ri.Populated_probationmaxmonths_pcnt *   0.00 / 10000 + le.Populated_probationmaxdays_pcnt*ri.Populated_probationmaxdays_pcnt *   0.00 / 10000 + le.Populated_probationminyears_pcnt*ri.Populated_probationminyears_pcnt *   0.00 / 10000 + le.Populated_probationminmonths_pcnt*ri.Populated_probationminmonths_pcnt *   0.00 / 10000 + le.Populated_probationmindays_pcnt*ri.Populated_probationmindays_pcnt *   0.00 / 10000 + le.Populated_probationstatus_pcnt*ri.Populated_probationstatus_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus','sourcename','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_caseid_pcnt,le.populated_sentencedate_pcnt,le.populated_sentencebegindate_pcnt,le.populated_sentenceenddate_pcnt,le.populated_sentencetype_pcnt,le.populated_sentencemaxyears_pcnt,le.populated_sentencemaxmonths_pcnt,le.populated_sentencemaxdays_pcnt,le.populated_sentenceminyears_pcnt,le.populated_sentenceminmonths_pcnt,le.populated_sentencemindays_pcnt,le.populated_scheduledreleasedate_pcnt,le.populated_actualreleasedate_pcnt,le.populated_sentencestatus_pcnt,le.populated_timeservedyears_pcnt,le.populated_timeservedmonths_pcnt,le.populated_timeserveddays_pcnt,le.populated_publicservicehours_pcnt,le.populated_sentenceadditionalinfo_pcnt,le.populated_communitysupervisioncounty_pcnt,le.populated_communitysupervisionyears_pcnt,le.populated_communitysupervisionmonths_pcnt,le.populated_communitysupervisiondays_pcnt,le.populated_parolebegindate_pcnt,le.populated_paroleenddate_pcnt,le.populated_paroleeligibilitydate_pcnt,le.populated_parolehearingdate_pcnt,le.populated_parolemaxyears_pcnt,le.populated_parolemaxmonths_pcnt,le.populated_parolemaxdays_pcnt,le.populated_paroleminyears_pcnt,le.populated_paroleminmonths_pcnt,le.populated_parolemindays_pcnt,le.populated_parolestatus_pcnt,le.populated_paroleofficer_pcnt,le.populated_paroleoffcerphone_pcnt,le.populated_probationbegindate_pcnt,le.populated_probationenddate_pcnt,le.populated_probationmaxyears_pcnt,le.populated_probationmaxmonths_pcnt,le.populated_probationmaxdays_pcnt,le.populated_probationminyears_pcnt,le.populated_probationminmonths_pcnt,le.populated_probationmindays_pcnt,le.populated_probationstatus_pcnt,le.populated_sourcename_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_caseid,le.maxlength_sentencedate,le.maxlength_sentencebegindate,le.maxlength_sentenceenddate,le.maxlength_sentencetype,le.maxlength_sentencemaxyears,le.maxlength_sentencemaxmonths,le.maxlength_sentencemaxdays,le.maxlength_sentenceminyears,le.maxlength_sentenceminmonths,le.maxlength_sentencemindays,le.maxlength_scheduledreleasedate,le.maxlength_actualreleasedate,le.maxlength_sentencestatus,le.maxlength_timeservedyears,le.maxlength_timeservedmonths,le.maxlength_timeserveddays,le.maxlength_publicservicehours,le.maxlength_sentenceadditionalinfo,le.maxlength_communitysupervisioncounty,le.maxlength_communitysupervisionyears,le.maxlength_communitysupervisionmonths,le.maxlength_communitysupervisiondays,le.maxlength_parolebegindate,le.maxlength_paroleenddate,le.maxlength_paroleeligibilitydate,le.maxlength_parolehearingdate,le.maxlength_parolemaxyears,le.maxlength_parolemaxmonths,le.maxlength_parolemaxdays,le.maxlength_paroleminyears,le.maxlength_paroleminmonths,le.maxlength_parolemindays,le.maxlength_parolestatus,le.maxlength_paroleofficer,le.maxlength_paroleoffcerphone,le.maxlength_probationbegindate,le.maxlength_probationenddate,le.maxlength_probationmaxyears,le.maxlength_probationmaxmonths,le.maxlength_probationmaxdays,le.maxlength_probationminyears,le.maxlength_probationminmonths,le.maxlength_probationmindays,le.maxlength_probationstatus,le.maxlength_sourcename,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_caseid,le.avelength_sentencedate,le.avelength_sentencebegindate,le.avelength_sentenceenddate,le.avelength_sentencetype,le.avelength_sentencemaxyears,le.avelength_sentencemaxmonths,le.avelength_sentencemaxdays,le.avelength_sentenceminyears,le.avelength_sentenceminmonths,le.avelength_sentencemindays,le.avelength_scheduledreleasedate,le.avelength_actualreleasedate,le.avelength_sentencestatus,le.avelength_timeservedyears,le.avelength_timeservedmonths,le.avelength_timeserveddays,le.avelength_publicservicehours,le.avelength_sentenceadditionalinfo,le.avelength_communitysupervisioncounty,le.avelength_communitysupervisionyears,le.avelength_communitysupervisionmonths,le.avelength_communitysupervisiondays,le.avelength_parolebegindate,le.avelength_paroleenddate,le.avelength_paroleeligibilitydate,le.avelength_parolehearingdate,le.avelength_parolemaxyears,le.avelength_parolemaxmonths,le.avelength_parolemaxdays,le.avelength_paroleminyears,le.avelength_paroleminmonths,le.avelength_parolemindays,le.avelength_parolestatus,le.avelength_paroleofficer,le.avelength_paroleoffcerphone,le.avelength_probationbegindate,le.avelength_probationenddate,le.avelength_probationmaxyears,le.avelength_probationmaxmonths,le.avelength_probationmaxdays,le.avelength_probationminyears,le.avelength_probationminmonths,le.avelength_probationmindays,le.avelength_probationstatus,le.avelength_sourcename,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 49, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.timeservedyears),TRIM((SALT33.StrType)le.timeservedmonths),TRIM((SALT33.StrType)le.timeserveddays),TRIM((SALT33.StrType)le.publicservicehours),TRIM((SALT33.StrType)le.sentenceadditionalinfo),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.parolebegindate),TRIM((SALT33.StrType)le.paroleenddate),TRIM((SALT33.StrType)le.paroleeligibilitydate),TRIM((SALT33.StrType)le.parolehearingdate),TRIM((SALT33.StrType)le.parolemaxyears),TRIM((SALT33.StrType)le.parolemaxmonths),TRIM((SALT33.StrType)le.parolemaxdays),TRIM((SALT33.StrType)le.paroleminyears),TRIM((SALT33.StrType)le.paroleminmonths),TRIM((SALT33.StrType)le.parolemindays),TRIM((SALT33.StrType)le.parolestatus),TRIM((SALT33.StrType)le.paroleofficer),TRIM((SALT33.StrType)le.paroleoffcerphone),TRIM((SALT33.StrType)le.probationbegindate),TRIM((SALT33.StrType)le.probationenddate),TRIM((SALT33.StrType)le.probationmaxyears),TRIM((SALT33.StrType)le.probationmaxmonths),TRIM((SALT33.StrType)le.probationmaxdays),TRIM((SALT33.StrType)le.probationminyears),TRIM((SALT33.StrType)le.probationminmonths),TRIM((SALT33.StrType)le.probationmindays),TRIM((SALT33.StrType)le.probationstatus),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,49,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 49);
  SELF.FldNo2 := 1 + (C % 49);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.timeservedyears),TRIM((SALT33.StrType)le.timeservedmonths),TRIM((SALT33.StrType)le.timeserveddays),TRIM((SALT33.StrType)le.publicservicehours),TRIM((SALT33.StrType)le.sentenceadditionalinfo),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.parolebegindate),TRIM((SALT33.StrType)le.paroleenddate),TRIM((SALT33.StrType)le.paroleeligibilitydate),TRIM((SALT33.StrType)le.parolehearingdate),TRIM((SALT33.StrType)le.parolemaxyears),TRIM((SALT33.StrType)le.parolemaxmonths),TRIM((SALT33.StrType)le.parolemaxdays),TRIM((SALT33.StrType)le.paroleminyears),TRIM((SALT33.StrType)le.paroleminmonths),TRIM((SALT33.StrType)le.parolemindays),TRIM((SALT33.StrType)le.parolestatus),TRIM((SALT33.StrType)le.paroleofficer),TRIM((SALT33.StrType)le.paroleoffcerphone),TRIM((SALT33.StrType)le.probationbegindate),TRIM((SALT33.StrType)le.probationenddate),TRIM((SALT33.StrType)le.probationmaxyears),TRIM((SALT33.StrType)le.probationmaxmonths),TRIM((SALT33.StrType)le.probationmaxdays),TRIM((SALT33.StrType)le.probationminyears),TRIM((SALT33.StrType)le.probationminmonths),TRIM((SALT33.StrType)le.probationmindays),TRIM((SALT33.StrType)le.probationstatus),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.timeservedyears),TRIM((SALT33.StrType)le.timeservedmonths),TRIM((SALT33.StrType)le.timeserveddays),TRIM((SALT33.StrType)le.publicservicehours),TRIM((SALT33.StrType)le.sentenceadditionalinfo),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.parolebegindate),TRIM((SALT33.StrType)le.paroleenddate),TRIM((SALT33.StrType)le.paroleeligibilitydate),TRIM((SALT33.StrType)le.parolehearingdate),TRIM((SALT33.StrType)le.parolemaxyears),TRIM((SALT33.StrType)le.parolemaxmonths),TRIM((SALT33.StrType)le.parolemaxdays),TRIM((SALT33.StrType)le.paroleminyears),TRIM((SALT33.StrType)le.paroleminmonths),TRIM((SALT33.StrType)le.parolemindays),TRIM((SALT33.StrType)le.parolestatus),TRIM((SALT33.StrType)le.paroleofficer),TRIM((SALT33.StrType)le.paroleoffcerphone),TRIM((SALT33.StrType)le.probationbegindate),TRIM((SALT33.StrType)le.probationenddate),TRIM((SALT33.StrType)le.probationmaxyears),TRIM((SALT33.StrType)le.probationmaxmonths),TRIM((SALT33.StrType)le.probationmaxdays),TRIM((SALT33.StrType)le.probationminyears),TRIM((SALT33.StrType)le.probationminmonths),TRIM((SALT33.StrType)le.probationmindays),TRIM((SALT33.StrType)le.probationstatus),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),49*49,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'caseid'}
      ,{4,'sentencedate'}
      ,{5,'sentencebegindate'}
      ,{6,'sentenceenddate'}
      ,{7,'sentencetype'}
      ,{8,'sentencemaxyears'}
      ,{9,'sentencemaxmonths'}
      ,{10,'sentencemaxdays'}
      ,{11,'sentenceminyears'}
      ,{12,'sentenceminmonths'}
      ,{13,'sentencemindays'}
      ,{14,'scheduledreleasedate'}
      ,{15,'actualreleasedate'}
      ,{16,'sentencestatus'}
      ,{17,'timeservedyears'}
      ,{18,'timeservedmonths'}
      ,{19,'timeserveddays'}
      ,{20,'publicservicehours'}
      ,{21,'sentenceadditionalinfo'}
      ,{22,'communitysupervisioncounty'}
      ,{23,'communitysupervisionyears'}
      ,{24,'communitysupervisionmonths'}
      ,{25,'communitysupervisiondays'}
      ,{26,'parolebegindate'}
      ,{27,'paroleenddate'}
      ,{28,'paroleeligibilitydate'}
      ,{29,'parolehearingdate'}
      ,{30,'parolemaxyears'}
      ,{31,'parolemaxmonths'}
      ,{32,'parolemaxdays'}
      ,{33,'paroleminyears'}
      ,{34,'paroleminmonths'}
      ,{35,'parolemindays'}
      ,{36,'parolestatus'}
      ,{37,'paroleofficer'}
      ,{38,'paroleoffcerphone'}
      ,{39,'probationbegindate'}
      ,{40,'probationenddate'}
      ,{41,'probationmaxyears'}
      ,{42,'probationmaxmonths'}
      ,{43,'probationmaxdays'}
      ,{44,'probationminyears'}
      ,{45,'probationminmonths'}
      ,{46,'probationmindays'}
      ,{47,'probationstatus'}
      ,{48,'sourcename'}
      ,{49,'vendor'}],SALT33.MAC_Character_Counts.Field_Identification);
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
    sentence_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid),
    sentence_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode),
    sentence_doc_Fields.InValid_caseid((SALT33.StrType)le.caseid),
    sentence_doc_Fields.InValid_sentencedate((SALT33.StrType)le.sentencedate),
    sentence_doc_Fields.InValid_sentencebegindate((SALT33.StrType)le.sentencebegindate),
    sentence_doc_Fields.InValid_sentenceenddate((SALT33.StrType)le.sentenceenddate),
    sentence_doc_Fields.InValid_sentencetype((SALT33.StrType)le.sentencetype),
    sentence_doc_Fields.InValid_sentencemaxyears((SALT33.StrType)le.sentencemaxyears),
    sentence_doc_Fields.InValid_sentencemaxmonths((SALT33.StrType)le.sentencemaxmonths),
    sentence_doc_Fields.InValid_sentencemaxdays((SALT33.StrType)le.sentencemaxdays),
    sentence_doc_Fields.InValid_sentenceminyears((SALT33.StrType)le.sentenceminyears),
    sentence_doc_Fields.InValid_sentenceminmonths((SALT33.StrType)le.sentenceminmonths),
    sentence_doc_Fields.InValid_sentencemindays((SALT33.StrType)le.sentencemindays),
    sentence_doc_Fields.InValid_scheduledreleasedate((SALT33.StrType)le.scheduledreleasedate),
    sentence_doc_Fields.InValid_actualreleasedate((SALT33.StrType)le.actualreleasedate),
    sentence_doc_Fields.InValid_sentencestatus((SALT33.StrType)le.sentencestatus),
    sentence_doc_Fields.InValid_timeservedyears((SALT33.StrType)le.timeservedyears),
    sentence_doc_Fields.InValid_timeservedmonths((SALT33.StrType)le.timeservedmonths),
    sentence_doc_Fields.InValid_timeserveddays((SALT33.StrType)le.timeserveddays),
    sentence_doc_Fields.InValid_publicservicehours((SALT33.StrType)le.publicservicehours),
    sentence_doc_Fields.InValid_sentenceadditionalinfo((SALT33.StrType)le.sentenceadditionalinfo),
    sentence_doc_Fields.InValid_communitysupervisioncounty((SALT33.StrType)le.communitysupervisioncounty),
    sentence_doc_Fields.InValid_communitysupervisionyears((SALT33.StrType)le.communitysupervisionyears),
    sentence_doc_Fields.InValid_communitysupervisionmonths((SALT33.StrType)le.communitysupervisionmonths),
    sentence_doc_Fields.InValid_communitysupervisiondays((SALT33.StrType)le.communitysupervisiondays),
    sentence_doc_Fields.InValid_parolebegindate((SALT33.StrType)le.parolebegindate),
    sentence_doc_Fields.InValid_paroleenddate((SALT33.StrType)le.paroleenddate),
    sentence_doc_Fields.InValid_paroleeligibilitydate((SALT33.StrType)le.paroleeligibilitydate),
    sentence_doc_Fields.InValid_parolehearingdate((SALT33.StrType)le.parolehearingdate),
    sentence_doc_Fields.InValid_parolemaxyears((SALT33.StrType)le.parolemaxyears),
    sentence_doc_Fields.InValid_parolemaxmonths((SALT33.StrType)le.parolemaxmonths),
    sentence_doc_Fields.InValid_parolemaxdays((SALT33.StrType)le.parolemaxdays),
    sentence_doc_Fields.InValid_paroleminyears((SALT33.StrType)le.paroleminyears),
    sentence_doc_Fields.InValid_paroleminmonths((SALT33.StrType)le.paroleminmonths),
    sentence_doc_Fields.InValid_parolemindays((SALT33.StrType)le.parolemindays),
    sentence_doc_Fields.InValid_parolestatus((SALT33.StrType)le.parolestatus),
    sentence_doc_Fields.InValid_paroleofficer((SALT33.StrType)le.paroleofficer),
    sentence_doc_Fields.InValid_paroleoffcerphone((SALT33.StrType)le.paroleoffcerphone),
    sentence_doc_Fields.InValid_probationbegindate((SALT33.StrType)le.probationbegindate),
    sentence_doc_Fields.InValid_probationenddate((SALT33.StrType)le.probationenddate),
    sentence_doc_Fields.InValid_probationmaxyears((SALT33.StrType)le.probationmaxyears),
    sentence_doc_Fields.InValid_probationmaxmonths((SALT33.StrType)le.probationmaxmonths),
    sentence_doc_Fields.InValid_probationmaxdays((SALT33.StrType)le.probationmaxdays),
    sentence_doc_Fields.InValid_probationminyears((SALT33.StrType)le.probationminyears),
    sentence_doc_Fields.InValid_probationminmonths((SALT33.StrType)le.probationminmonths),
    sentence_doc_Fields.InValid_probationmindays((SALT33.StrType)le.probationmindays),
    sentence_doc_Fields.InValid_probationstatus((SALT33.StrType)le.probationstatus),
    sentence_doc_Fields.InValid_sourcename((SALT33.StrType)le.sourcename),
    sentence_doc_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,49,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := sentence_doc_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Non_Blank','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,sentence_doc_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_caseid(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencedate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencebegindate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentenceenddate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencetype(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencemaxyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencemaxmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencemaxdays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentenceminyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentenceminmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencemindays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_scheduledreleasedate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_actualreleasedate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentencestatus(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_timeservedyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_timeservedmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_timeserveddays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_publicservicehours(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sentenceadditionalinfo(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_communitysupervisioncounty(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_communitysupervisionyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_communitysupervisionmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_communitysupervisiondays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolebegindate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleenddate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleeligibilitydate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolehearingdate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolemaxyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolemaxmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolemaxdays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleminyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleminmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolemindays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_parolestatus(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleofficer(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_paroleoffcerphone(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationbegindate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationenddate(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationmaxyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationmaxmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationmaxdays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationminyears(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationminmonths(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationmindays(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_probationstatus(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),sentence_doc_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
