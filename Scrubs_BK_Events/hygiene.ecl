IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_BK_Events) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dractivitytypecode_cnt := COUNT(GROUP,h.dractivitytypecode <> (TYPEOF(h.dractivitytypecode))'');
    populated_dractivitytypecode_pcnt := AVE(GROUP,IF(h.dractivitytypecode = (TYPEOF(h.dractivitytypecode))'',0,100));
    maxlength_dractivitytypecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dractivitytypecode)));
    avelength_dractivitytypecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dractivitytypecode)),h.dractivitytypecode<>(typeof(h.dractivitytypecode))'');
    populated_docketentryid_cnt := COUNT(GROUP,h.docketentryid <> (TYPEOF(h.docketentryid))'');
    populated_docketentryid_pcnt := AVE(GROUP,IF(h.docketentryid = (TYPEOF(h.docketentryid))'',0,100));
    maxlength_docketentryid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketentryid)));
    avelength_docketentryid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketentryid)),h.docketentryid<>(typeof(h.docketentryid))'');
    populated_courtid_cnt := COUNT(GROUP,h.courtid <> (TYPEOF(h.courtid))'');
    populated_courtid_pcnt := AVE(GROUP,IF(h.courtid = (TYPEOF(h.courtid))'',0,100));
    maxlength_courtid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)));
    avelength_courtid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)),h.courtid<>(typeof(h.courtid))'');
    populated_casekey_cnt := COUNT(GROUP,h.casekey <> (TYPEOF(h.casekey))'');
    populated_casekey_pcnt := AVE(GROUP,IF(h.casekey = (TYPEOF(h.casekey))'',0,100));
    maxlength_casekey := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casekey)));
    avelength_casekey := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casekey)),h.casekey<>(typeof(h.casekey))'');
    populated_casetype_cnt := COUNT(GROUP,h.casetype <> (TYPEOF(h.casetype))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_bkcasenumber_cnt := COUNT(GROUP,h.bkcasenumber <> (TYPEOF(h.bkcasenumber))'');
    populated_bkcasenumber_pcnt := AVE(GROUP,IF(h.bkcasenumber = (TYPEOF(h.bkcasenumber))'',0,100));
    maxlength_bkcasenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkcasenumber)));
    avelength_bkcasenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkcasenumber)),h.bkcasenumber<>(typeof(h.bkcasenumber))'');
    populated_bkcasenumberurl_cnt := COUNT(GROUP,h.bkcasenumberurl <> (TYPEOF(h.bkcasenumberurl))'');
    populated_bkcasenumberurl_pcnt := AVE(GROUP,IF(h.bkcasenumberurl = (TYPEOF(h.bkcasenumberurl))'',0,100));
    maxlength_bkcasenumberurl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkcasenumberurl)));
    avelength_bkcasenumberurl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bkcasenumberurl)),h.bkcasenumberurl<>(typeof(h.bkcasenumberurl))'');
    populated_proceedingscasenumber_cnt := COUNT(GROUP,h.proceedingscasenumber <> (TYPEOF(h.proceedingscasenumber))'');
    populated_proceedingscasenumber_pcnt := AVE(GROUP,IF(h.proceedingscasenumber = (TYPEOF(h.proceedingscasenumber))'',0,100));
    maxlength_proceedingscasenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proceedingscasenumber)));
    avelength_proceedingscasenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proceedingscasenumber)),h.proceedingscasenumber<>(typeof(h.proceedingscasenumber))'');
    populated_proceedingscasenumberurl_cnt := COUNT(GROUP,h.proceedingscasenumberurl <> (TYPEOF(h.proceedingscasenumberurl))'');
    populated_proceedingscasenumberurl_pcnt := AVE(GROUP,IF(h.proceedingscasenumberurl = (TYPEOF(h.proceedingscasenumberurl))'',0,100));
    maxlength_proceedingscasenumberurl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proceedingscasenumberurl)));
    avelength_proceedingscasenumberurl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proceedingscasenumberurl)),h.proceedingscasenumberurl<>(typeof(h.proceedingscasenumberurl))'');
    populated_caseid_cnt := COUNT(GROUP,h.caseid <> (TYPEOF(h.caseid))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_pacercaseid_cnt := COUNT(GROUP,h.pacercaseid <> (TYPEOF(h.pacercaseid))'');
    populated_pacercaseid_pcnt := AVE(GROUP,IF(h.pacercaseid = (TYPEOF(h.pacercaseid))'',0,100));
    maxlength_pacercaseid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pacercaseid)));
    avelength_pacercaseid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pacercaseid)),h.pacercaseid<>(typeof(h.pacercaseid))'');
    populated_attachmenturl_cnt := COUNT(GROUP,h.attachmenturl <> (TYPEOF(h.attachmenturl))'');
    populated_attachmenturl_pcnt := AVE(GROUP,IF(h.attachmenturl = (TYPEOF(h.attachmenturl))'',0,100));
    maxlength_attachmenturl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attachmenturl)));
    avelength_attachmenturl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attachmenturl)),h.attachmenturl<>(typeof(h.attachmenturl))'');
    populated_entrynumber_cnt := COUNT(GROUP,h.entrynumber <> (TYPEOF(h.entrynumber))'');
    populated_entrynumber_pcnt := AVE(GROUP,IF(h.entrynumber = (TYPEOF(h.entrynumber))'',0,100));
    maxlength_entrynumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entrynumber)));
    avelength_entrynumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entrynumber)),h.entrynumber<>(typeof(h.entrynumber))'');
    populated_entereddate_cnt := COUNT(GROUP,h.entereddate <> (TYPEOF(h.entereddate))'');
    populated_entereddate_pcnt := AVE(GROUP,IF(h.entereddate = (TYPEOF(h.entereddate))'',0,100));
    maxlength_entereddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entereddate)));
    avelength_entereddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entereddate)),h.entereddate<>(typeof(h.entereddate))'');
    populated_pacer_entereddate_cnt := COUNT(GROUP,h.pacer_entereddate <> (TYPEOF(h.pacer_entereddate))'');
    populated_pacer_entereddate_pcnt := AVE(GROUP,IF(h.pacer_entereddate = (TYPEOF(h.pacer_entereddate))'',0,100));
    maxlength_pacer_entereddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pacer_entereddate)));
    avelength_pacer_entereddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pacer_entereddate)),h.pacer_entereddate<>(typeof(h.pacer_entereddate))'');
    populated_fileddate_cnt := COUNT(GROUP,h.fileddate <> (TYPEOF(h.fileddate))'');
    populated_fileddate_pcnt := AVE(GROUP,IF(h.fileddate = (TYPEOF(h.fileddate))'',0,100));
    maxlength_fileddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fileddate)));
    avelength_fileddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fileddate)),h.fileddate<>(typeof(h.fileddate))'');
    populated_score_cnt := COUNT(GROUP,h.score <> (TYPEOF(h.score))'');
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_drcategoryeventid_cnt := COUNT(GROUP,h.drcategoryeventid <> (TYPEOF(h.drcategoryeventid))'');
    populated_drcategoryeventid_pcnt := AVE(GROUP,IF(h.drcategoryeventid = (TYPEOF(h.drcategoryeventid))'',0,100));
    maxlength_drcategoryeventid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drcategoryeventid)));
    avelength_drcategoryeventid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drcategoryeventid)),h.drcategoryeventid<>(typeof(h.drcategoryeventid))'');
    populated_court_code_cnt := COUNT(GROUP,h.court_code <> (TYPEOF(h.court_code))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_district_cnt := COUNT(GROUP,h.district <> (TYPEOF(h.district))'');
    populated_district_pcnt := AVE(GROUP,IF(h.district = (TYPEOF(h.district))'',0,100));
    maxlength_district := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.district)));
    avelength_district := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.district)),h.district<>(typeof(h.district))'');
    populated_boca_court_cnt := COUNT(GROUP,h.boca_court <> (TYPEOF(h.boca_court))'');
    populated_boca_court_pcnt := AVE(GROUP,IF(h.boca_court = (TYPEOF(h.boca_court))'',0,100));
    maxlength_boca_court := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boca_court)));
    avelength_boca_court := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boca_court)),h.boca_court<>(typeof(h.boca_court))'');
    populated_catevent_description_cnt := COUNT(GROUP,h.catevent_description <> (TYPEOF(h.catevent_description))'');
    populated_catevent_description_pcnt := AVE(GROUP,IF(h.catevent_description = (TYPEOF(h.catevent_description))'',0,100));
    maxlength_catevent_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.catevent_description)));
    avelength_catevent_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.catevent_description)),h.catevent_description<>(typeof(h.catevent_description))'');
    populated_catevent_category_cnt := COUNT(GROUP,h.catevent_category <> (TYPEOF(h.catevent_category))'');
    populated_catevent_category_pcnt := AVE(GROUP,IF(h.catevent_category = (TYPEOF(h.catevent_category))'',0,100));
    maxlength_catevent_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.catevent_category)));
    avelength_catevent_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.catevent_category)),h.catevent_category<>(typeof(h.catevent_category))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dractivitytypecode_pcnt *   0.00 / 100 + T.Populated_docketentryid_pcnt *   0.00 / 100 + T.Populated_courtid_pcnt *   0.00 / 100 + T.Populated_casekey_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_bkcasenumber_pcnt *   0.00 / 100 + T.Populated_bkcasenumberurl_pcnt *   0.00 / 100 + T.Populated_proceedingscasenumber_pcnt *   0.00 / 100 + T.Populated_proceedingscasenumberurl_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_pacercaseid_pcnt *   0.00 / 100 + T.Populated_attachmenturl_pcnt *   0.00 / 100 + T.Populated_entrynumber_pcnt *   0.00 / 100 + T.Populated_entereddate_pcnt *   0.00 / 100 + T.Populated_pacer_entereddate_pcnt *   0.00 / 100 + T.Populated_fileddate_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_drcategoryeventid_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_district_pcnt *   0.00 / 100 + T.Populated_boca_court_pcnt *   0.00 / 100 + T.Populated_catevent_description_pcnt *   0.00 / 100 + T.Populated_catevent_category_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dractivitytypecode','docketentryid','courtid','casekey','casetype','bkcasenumber','bkcasenumberurl','proceedingscasenumber','proceedingscasenumberurl','caseid','pacercaseid','attachmenturl','entrynumber','entereddate','pacer_entereddate','fileddate','score','drcategoryeventid','court_code','district','boca_court','catevent_description','catevent_category');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dractivitytypecode_pcnt,le.populated_docketentryid_pcnt,le.populated_courtid_pcnt,le.populated_casekey_pcnt,le.populated_casetype_pcnt,le.populated_bkcasenumber_pcnt,le.populated_bkcasenumberurl_pcnt,le.populated_proceedingscasenumber_pcnt,le.populated_proceedingscasenumberurl_pcnt,le.populated_caseid_pcnt,le.populated_pacercaseid_pcnt,le.populated_attachmenturl_pcnt,le.populated_entrynumber_pcnt,le.populated_entereddate_pcnt,le.populated_pacer_entereddate_pcnt,le.populated_fileddate_pcnt,le.populated_score_pcnt,le.populated_drcategoryeventid_pcnt,le.populated_court_code_pcnt,le.populated_district_pcnt,le.populated_boca_court_pcnt,le.populated_catevent_description_pcnt,le.populated_catevent_category_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dractivitytypecode,le.maxlength_docketentryid,le.maxlength_courtid,le.maxlength_casekey,le.maxlength_casetype,le.maxlength_bkcasenumber,le.maxlength_bkcasenumberurl,le.maxlength_proceedingscasenumber,le.maxlength_proceedingscasenumberurl,le.maxlength_caseid,le.maxlength_pacercaseid,le.maxlength_attachmenturl,le.maxlength_entrynumber,le.maxlength_entereddate,le.maxlength_pacer_entereddate,le.maxlength_fileddate,le.maxlength_score,le.maxlength_drcategoryeventid,le.maxlength_court_code,le.maxlength_district,le.maxlength_boca_court,le.maxlength_catevent_description,le.maxlength_catevent_category);
  SELF.avelength := CHOOSE(C,le.avelength_dractivitytypecode,le.avelength_docketentryid,le.avelength_courtid,le.avelength_casekey,le.avelength_casetype,le.avelength_bkcasenumber,le.avelength_bkcasenumberurl,le.avelength_proceedingscasenumber,le.avelength_proceedingscasenumberurl,le.avelength_caseid,le.avelength_pacercaseid,le.avelength_attachmenturl,le.avelength_entrynumber,le.avelength_entereddate,le.avelength_pacer_entereddate,le.avelength_fileddate,le.avelength_score,le.avelength_drcategoryeventid,le.avelength_court_code,le.avelength_district,le.avelength_boca_court,le.avelength_catevent_description,le.avelength_catevent_category);
END;
EXPORT invSummary := NORMALIZE(summary0, 23, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dractivitytypecode),TRIM((SALT311.StrType)le.docketentryid),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.casekey),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.bkcasenumber),TRIM((SALT311.StrType)le.bkcasenumberurl),TRIM((SALT311.StrType)le.proceedingscasenumber),TRIM((SALT311.StrType)le.proceedingscasenumberurl),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.pacercaseid),TRIM((SALT311.StrType)le.attachmenturl),TRIM((SALT311.StrType)le.entrynumber),TRIM((SALT311.StrType)le.entereddate),TRIM((SALT311.StrType)le.pacer_entereddate),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.drcategoryeventid),TRIM((SALT311.StrType)le.court_code),TRIM((SALT311.StrType)le.district),TRIM((SALT311.StrType)le.boca_court),TRIM((SALT311.StrType)le.catevent_description),TRIM((SALT311.StrType)le.catevent_category)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 23);
  SELF.FldNo2 := 1 + (C % 23);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dractivitytypecode),TRIM((SALT311.StrType)le.docketentryid),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.casekey),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.bkcasenumber),TRIM((SALT311.StrType)le.bkcasenumberurl),TRIM((SALT311.StrType)le.proceedingscasenumber),TRIM((SALT311.StrType)le.proceedingscasenumberurl),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.pacercaseid),TRIM((SALT311.StrType)le.attachmenturl),TRIM((SALT311.StrType)le.entrynumber),TRIM((SALT311.StrType)le.entereddate),TRIM((SALT311.StrType)le.pacer_entereddate),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.drcategoryeventid),TRIM((SALT311.StrType)le.court_code),TRIM((SALT311.StrType)le.district),TRIM((SALT311.StrType)le.boca_court),TRIM((SALT311.StrType)le.catevent_description),TRIM((SALT311.StrType)le.catevent_category)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dractivitytypecode),TRIM((SALT311.StrType)le.docketentryid),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.casekey),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.bkcasenumber),TRIM((SALT311.StrType)le.bkcasenumberurl),TRIM((SALT311.StrType)le.proceedingscasenumber),TRIM((SALT311.StrType)le.proceedingscasenumberurl),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.pacercaseid),TRIM((SALT311.StrType)le.attachmenturl),TRIM((SALT311.StrType)le.entrynumber),TRIM((SALT311.StrType)le.entereddate),TRIM((SALT311.StrType)le.pacer_entereddate),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.drcategoryeventid),TRIM((SALT311.StrType)le.court_code),TRIM((SALT311.StrType)le.district),TRIM((SALT311.StrType)le.boca_court),TRIM((SALT311.StrType)le.catevent_description),TRIM((SALT311.StrType)le.catevent_category)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),23*23,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dractivitytypecode'}
      ,{2,'docketentryid'}
      ,{3,'courtid'}
      ,{4,'casekey'}
      ,{5,'casetype'}
      ,{6,'bkcasenumber'}
      ,{7,'bkcasenumberurl'}
      ,{8,'proceedingscasenumber'}
      ,{9,'proceedingscasenumberurl'}
      ,{10,'caseid'}
      ,{11,'pacercaseid'}
      ,{12,'attachmenturl'}
      ,{13,'entrynumber'}
      ,{14,'entereddate'}
      ,{15,'pacer_entereddate'}
      ,{16,'fileddate'}
      ,{17,'score'}
      ,{18,'drcategoryeventid'}
      ,{19,'court_code'}
      ,{20,'district'}
      ,{21,'boca_court'}
      ,{22,'catevent_description'}
      ,{23,'catevent_category'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dractivitytypecode((SALT311.StrType)le.dractivitytypecode),
    Fields.InValid_docketentryid((SALT311.StrType)le.docketentryid),
    Fields.InValid_courtid((SALT311.StrType)le.courtid),
    Fields.InValid_casekey((SALT311.StrType)le.casekey),
    Fields.InValid_casetype((SALT311.StrType)le.casetype),
    Fields.InValid_bkcasenumber((SALT311.StrType)le.bkcasenumber),
    Fields.InValid_bkcasenumberurl((SALT311.StrType)le.bkcasenumberurl),
    Fields.InValid_proceedingscasenumber((SALT311.StrType)le.proceedingscasenumber),
    Fields.InValid_proceedingscasenumberurl((SALT311.StrType)le.proceedingscasenumberurl),
    Fields.InValid_caseid((SALT311.StrType)le.caseid),
    Fields.InValid_pacercaseid((SALT311.StrType)le.pacercaseid),
    Fields.InValid_attachmenturl((SALT311.StrType)le.attachmenturl),
    Fields.InValid_entrynumber((SALT311.StrType)le.entrynumber),
    Fields.InValid_entereddate((SALT311.StrType)le.entereddate),
    Fields.InValid_pacer_entereddate((SALT311.StrType)le.pacer_entereddate),
    Fields.InValid_fileddate((SALT311.StrType)le.fileddate),
    Fields.InValid_score((SALT311.StrType)le.score),
    Fields.InValid_drcategoryeventid((SALT311.StrType)le.drcategoryeventid),
    Fields.InValid_court_code((SALT311.StrType)le.court_code),
    Fields.InValid_district((SALT311.StrType)le.district),
    Fields.InValid_boca_court((SALT311.StrType)le.boca_court),
    Fields.InValid_catevent_description((SALT311.StrType)le.catevent_description),
    Fields.InValid_catevent_category((SALT311.StrType)le.catevent_category),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,23,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Alpha','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_CaseNo','Invalid_URL','Invalid_CaseNo','Invalid_URL','Invalid_No','Invalid_Int','Invalid_URL','Invalid_Int','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Float','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNumChar');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dractivitytypecode(TotalErrors.ErrorNum),Fields.InValidMessage_docketentryid(TotalErrors.ErrorNum),Fields.InValidMessage_courtid(TotalErrors.ErrorNum),Fields.InValidMessage_casekey(TotalErrors.ErrorNum),Fields.InValidMessage_casetype(TotalErrors.ErrorNum),Fields.InValidMessage_bkcasenumber(TotalErrors.ErrorNum),Fields.InValidMessage_bkcasenumberurl(TotalErrors.ErrorNum),Fields.InValidMessage_proceedingscasenumber(TotalErrors.ErrorNum),Fields.InValidMessage_proceedingscasenumberurl(TotalErrors.ErrorNum),Fields.InValidMessage_caseid(TotalErrors.ErrorNum),Fields.InValidMessage_pacercaseid(TotalErrors.ErrorNum),Fields.InValidMessage_attachmenturl(TotalErrors.ErrorNum),Fields.InValidMessage_entrynumber(TotalErrors.ErrorNum),Fields.InValidMessage_entereddate(TotalErrors.ErrorNum),Fields.InValidMessage_pacer_entereddate(TotalErrors.ErrorNum),Fields.InValidMessage_fileddate(TotalErrors.ErrorNum),Fields.InValidMessage_score(TotalErrors.ErrorNum),Fields.InValidMessage_drcategoryeventid(TotalErrors.ErrorNum),Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Fields.InValidMessage_district(TotalErrors.ErrorNum),Fields.InValidMessage_boca_court(TotalErrors.ErrorNum),Fields.InValidMessage_catevent_description(TotalErrors.ErrorNum),Fields.InValidMessage_catevent_category(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BK_Events, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
