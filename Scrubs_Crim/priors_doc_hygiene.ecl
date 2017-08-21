IMPORT ut,SALT33;
EXPORT priors_doc_hygiene(dataset(priors_doc_layout_crim) h) := MODULE
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
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_dispositiondate_pcnt := AVE(GROUP,IF(h.dispositiondate = (TYPEOF(h.dispositiondate))'',0,100));
    maxlength_dispositiondate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositiondate)));
    avelength_dispositiondate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispositiondate)),h.dispositiondate<>(typeof(h.dispositiondate))'');
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
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_casenumber_pcnt *   0.00 / 100 + T.Populated_offensedesc_pcnt *   0.00 / 100 + T.Populated_offensedate_pcnt *   0.00 / 100 + T.Populated_offensetype_pcnt *   0.00 / 100 + T.Populated_offensedegree_pcnt *   0.00 / 100 + T.Populated_offenseclass_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_dispositiondate_pcnt *   0.00 / 100 + T.Populated_sentencedate_pcnt *   0.00 / 100 + T.Populated_sentencebegindate_pcnt *   0.00 / 100 + T.Populated_sentenceenddate_pcnt *   0.00 / 100 + T.Populated_sentencetype_pcnt *   0.00 / 100 + T.Populated_sentencemaxyears_pcnt *   0.00 / 100 + T.Populated_sentencemaxmonths_pcnt *   0.00 / 100 + T.Populated_sentencemaxdays_pcnt *   0.00 / 100 + T.Populated_sentenceminyears_pcnt *   0.00 / 100 + T.Populated_sentenceminmonths_pcnt *   0.00 / 100 + T.Populated_sentencemindays_pcnt *   0.00 / 100 + T.Populated_scheduledreleasedate_pcnt *   0.00 / 100 + T.Populated_actualreleasedate_pcnt *   0.00 / 100 + T.Populated_sentencestatus_pcnt *   0.00 / 100 + T.Populated_communitysupervisioncounty_pcnt *   0.00 / 100 + T.Populated_communitysupervisionyears_pcnt *   0.00 / 100 + T.Populated_communitysupervisionmonths_pcnt *   0.00 / 100 + T.Populated_communitysupervisiondays_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_casenumber_pcnt*ri.Populated_casenumber_pcnt *   0.00 / 10000 + le.Populated_offensedesc_pcnt*ri.Populated_offensedesc_pcnt *   0.00 / 10000 + le.Populated_offensedate_pcnt*ri.Populated_offensedate_pcnt *   0.00 / 10000 + le.Populated_offensetype_pcnt*ri.Populated_offensetype_pcnt *   0.00 / 10000 + le.Populated_offensedegree_pcnt*ri.Populated_offensedegree_pcnt *   0.00 / 10000 + le.Populated_offenseclass_pcnt*ri.Populated_offenseclass_pcnt *   0.00 / 10000 + le.Populated_disposition_pcnt*ri.Populated_disposition_pcnt *   0.00 / 10000 + le.Populated_dispositiondate_pcnt*ri.Populated_dispositiondate_pcnt *   0.00 / 10000 + le.Populated_sentencedate_pcnt*ri.Populated_sentencedate_pcnt *   0.00 / 10000 + le.Populated_sentencebegindate_pcnt*ri.Populated_sentencebegindate_pcnt *   0.00 / 10000 + le.Populated_sentenceenddate_pcnt*ri.Populated_sentenceenddate_pcnt *   0.00 / 10000 + le.Populated_sentencetype_pcnt*ri.Populated_sentencetype_pcnt *   0.00 / 10000 + le.Populated_sentencemaxyears_pcnt*ri.Populated_sentencemaxyears_pcnt *   0.00 / 10000 + le.Populated_sentencemaxmonths_pcnt*ri.Populated_sentencemaxmonths_pcnt *   0.00 / 10000 + le.Populated_sentencemaxdays_pcnt*ri.Populated_sentencemaxdays_pcnt *   0.00 / 10000 + le.Populated_sentenceminyears_pcnt*ri.Populated_sentenceminyears_pcnt *   0.00 / 10000 + le.Populated_sentenceminmonths_pcnt*ri.Populated_sentenceminmonths_pcnt *   0.00 / 10000 + le.Populated_sentencemindays_pcnt*ri.Populated_sentencemindays_pcnt *   0.00 / 10000 + le.Populated_scheduledreleasedate_pcnt*ri.Populated_scheduledreleasedate_pcnt *   0.00 / 10000 + le.Populated_actualreleasedate_pcnt*ri.Populated_actualreleasedate_pcnt *   0.00 / 10000 + le.Populated_sentencestatus_pcnt*ri.Populated_sentencestatus_pcnt *   0.00 / 10000 + le.Populated_communitysupervisioncounty_pcnt*ri.Populated_communitysupervisioncounty_pcnt *   0.00 / 10000 + le.Populated_communitysupervisionyears_pcnt*ri.Populated_communitysupervisionyears_pcnt *   0.00 / 10000 + le.Populated_communitysupervisionmonths_pcnt*ri.Populated_communitysupervisionmonths_pcnt *   0.00 / 10000 + le.Populated_communitysupervisiondays_pcnt*ri.Populated_communitysupervisiondays_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_sourceid_pcnt*ri.Populated_sourceid_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'recordid','statecode','caseid','casenumber','offensedesc','offensedate','offensetype','offensedegree','offenseclass','disposition','dispositiondate','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','sourcename','sourceid','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_caseid_pcnt,le.populated_casenumber_pcnt,le.populated_offensedesc_pcnt,le.populated_offensedate_pcnt,le.populated_offensetype_pcnt,le.populated_offensedegree_pcnt,le.populated_offenseclass_pcnt,le.populated_disposition_pcnt,le.populated_dispositiondate_pcnt,le.populated_sentencedate_pcnt,le.populated_sentencebegindate_pcnt,le.populated_sentenceenddate_pcnt,le.populated_sentencetype_pcnt,le.populated_sentencemaxyears_pcnt,le.populated_sentencemaxmonths_pcnt,le.populated_sentencemaxdays_pcnt,le.populated_sentenceminyears_pcnt,le.populated_sentenceminmonths_pcnt,le.populated_sentencemindays_pcnt,le.populated_scheduledreleasedate_pcnt,le.populated_actualreleasedate_pcnt,le.populated_sentencestatus_pcnt,le.populated_communitysupervisioncounty_pcnt,le.populated_communitysupervisionyears_pcnt,le.populated_communitysupervisionmonths_pcnt,le.populated_communitysupervisiondays_pcnt,le.populated_sourcename_pcnt,le.populated_sourceid_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_caseid,le.maxlength_casenumber,le.maxlength_offensedesc,le.maxlength_offensedate,le.maxlength_offensetype,le.maxlength_offensedegree,le.maxlength_offenseclass,le.maxlength_disposition,le.maxlength_dispositiondate,le.maxlength_sentencedate,le.maxlength_sentencebegindate,le.maxlength_sentenceenddate,le.maxlength_sentencetype,le.maxlength_sentencemaxyears,le.maxlength_sentencemaxmonths,le.maxlength_sentencemaxdays,le.maxlength_sentenceminyears,le.maxlength_sentenceminmonths,le.maxlength_sentencemindays,le.maxlength_scheduledreleasedate,le.maxlength_actualreleasedate,le.maxlength_sentencestatus,le.maxlength_communitysupervisioncounty,le.maxlength_communitysupervisionyears,le.maxlength_communitysupervisionmonths,le.maxlength_communitysupervisiondays,le.maxlength_sourcename,le.maxlength_sourceid,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_caseid,le.avelength_casenumber,le.avelength_offensedesc,le.avelength_offensedate,le.avelength_offensetype,le.avelength_offensedegree,le.avelength_offenseclass,le.avelength_disposition,le.avelength_dispositiondate,le.avelength_sentencedate,le.avelength_sentencebegindate,le.avelength_sentenceenddate,le.avelength_sentencetype,le.avelength_sentencemaxyears,le.avelength_sentencemaxmonths,le.avelength_sentencemaxdays,le.avelength_sentenceminyears,le.avelength_sentenceminmonths,le.avelength_sentencemindays,le.avelength_scheduledreleasedate,le.avelength_actualreleasedate,le.avelength_sentencestatus,le.avelength_communitysupervisioncounty,le.avelength_communitysupervisionyears,le.avelength_communitysupervisionmonths,le.avelength_communitysupervisiondays,le.avelength_sourcename,le.avelength_sourceid,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 31, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,31,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 31);
  SELF.FldNo2 := 1 + (C % 31);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.casenumber),TRIM((SALT33.StrType)le.offensedesc),TRIM((SALT33.StrType)le.offensedate),TRIM((SALT33.StrType)le.offensetype),TRIM((SALT33.StrType)le.offensedegree),TRIM((SALT33.StrType)le.offenseclass),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.dispositiondate),TRIM((SALT33.StrType)le.sentencedate),TRIM((SALT33.StrType)le.sentencebegindate),TRIM((SALT33.StrType)le.sentenceenddate),TRIM((SALT33.StrType)le.sentencetype),TRIM((SALT33.StrType)le.sentencemaxyears),TRIM((SALT33.StrType)le.sentencemaxmonths),TRIM((SALT33.StrType)le.sentencemaxdays),TRIM((SALT33.StrType)le.sentenceminyears),TRIM((SALT33.StrType)le.sentenceminmonths),TRIM((SALT33.StrType)le.sentencemindays),TRIM((SALT33.StrType)le.scheduledreleasedate),TRIM((SALT33.StrType)le.actualreleasedate),TRIM((SALT33.StrType)le.sentencestatus),TRIM((SALT33.StrType)le.communitysupervisioncounty),TRIM((SALT33.StrType)le.communitysupervisionyears),TRIM((SALT33.StrType)le.communitysupervisionmonths),TRIM((SALT33.StrType)le.communitysupervisiondays),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourceid),TRIM((SALT33.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),31*31,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'caseid'}
      ,{4,'casenumber'}
      ,{5,'offensedesc'}
      ,{6,'offensedate'}
      ,{7,'offensetype'}
      ,{8,'offensedegree'}
      ,{9,'offenseclass'}
      ,{10,'disposition'}
      ,{11,'dispositiondate'}
      ,{12,'sentencedate'}
      ,{13,'sentencebegindate'}
      ,{14,'sentenceenddate'}
      ,{15,'sentencetype'}
      ,{16,'sentencemaxyears'}
      ,{17,'sentencemaxmonths'}
      ,{18,'sentencemaxdays'}
      ,{19,'sentenceminyears'}
      ,{20,'sentenceminmonths'}
      ,{21,'sentencemindays'}
      ,{22,'scheduledreleasedate'}
      ,{23,'actualreleasedate'}
      ,{24,'sentencestatus'}
      ,{25,'communitysupervisioncounty'}
      ,{26,'communitysupervisionyears'}
      ,{27,'communitysupervisionmonths'}
      ,{28,'communitysupervisiondays'}
      ,{29,'sourcename'}
      ,{30,'sourceid'}
      ,{31,'vendor'}],SALT33.MAC_Character_Counts.Field_Identification);
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
    priors_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid),
    priors_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode),
    priors_doc_Fields.InValid_caseid((SALT33.StrType)le.caseid),
    priors_doc_Fields.InValid_casenumber((SALT33.StrType)le.casenumber),
    priors_doc_Fields.InValid_offensedesc((SALT33.StrType)le.offensedesc),
    priors_doc_Fields.InValid_offensedate((SALT33.StrType)le.offensedate),
    priors_doc_Fields.InValid_offensetype((SALT33.StrType)le.offensetype),
    priors_doc_Fields.InValid_offensedegree((SALT33.StrType)le.offensedegree),
    priors_doc_Fields.InValid_offenseclass((SALT33.StrType)le.offenseclass),
    priors_doc_Fields.InValid_disposition((SALT33.StrType)le.disposition),
    priors_doc_Fields.InValid_dispositiondate((SALT33.StrType)le.dispositiondate),
    priors_doc_Fields.InValid_sentencedate((SALT33.StrType)le.sentencedate),
    priors_doc_Fields.InValid_sentencebegindate((SALT33.StrType)le.sentencebegindate),
    priors_doc_Fields.InValid_sentenceenddate((SALT33.StrType)le.sentenceenddate),
    priors_doc_Fields.InValid_sentencetype((SALT33.StrType)le.sentencetype),
    priors_doc_Fields.InValid_sentencemaxyears((SALT33.StrType)le.sentencemaxyears),
    priors_doc_Fields.InValid_sentencemaxmonths((SALT33.StrType)le.sentencemaxmonths),
    priors_doc_Fields.InValid_sentencemaxdays((SALT33.StrType)le.sentencemaxdays),
    priors_doc_Fields.InValid_sentenceminyears((SALT33.StrType)le.sentenceminyears),
    priors_doc_Fields.InValid_sentenceminmonths((SALT33.StrType)le.sentenceminmonths),
    priors_doc_Fields.InValid_sentencemindays((SALT33.StrType)le.sentencemindays),
    priors_doc_Fields.InValid_scheduledreleasedate((SALT33.StrType)le.scheduledreleasedate),
    priors_doc_Fields.InValid_actualreleasedate((SALT33.StrType)le.actualreleasedate),
    priors_doc_Fields.InValid_sentencestatus((SALT33.StrType)le.sentencestatus),
    priors_doc_Fields.InValid_communitysupervisioncounty((SALT33.StrType)le.communitysupervisioncounty),
    priors_doc_Fields.InValid_communitysupervisionyears((SALT33.StrType)le.communitysupervisionyears),
    priors_doc_Fields.InValid_communitysupervisionmonths((SALT33.StrType)le.communitysupervisionmonths),
    priors_doc_Fields.InValid_communitysupervisiondays((SALT33.StrType)le.communitysupervisiondays),
    priors_doc_Fields.InValid_sourcename((SALT33.StrType)le.sourcename),
    priors_doc_Fields.InValid_sourceid((SALT33.StrType)le.sourceid),
    priors_doc_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,31,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := priors_doc_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_Char','Non_Blank','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Non_Blank','Invalid_Num','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,priors_doc_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_caseid(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_casenumber(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_offensedesc(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_offensedate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_offensetype(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_offensedegree(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_offenseclass(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_disposition(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_dispositiondate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencedate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencebegindate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentenceenddate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencetype(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencemaxyears(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencemaxmonths(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencemaxdays(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentenceminyears(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentenceminmonths(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencemindays(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_scheduledreleasedate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_actualreleasedate(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sentencestatus(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_communitysupervisioncounty(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_communitysupervisionyears(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_communitysupervisionmonths(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_communitysupervisiondays(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),priors_doc_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
