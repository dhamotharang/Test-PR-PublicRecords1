IMPORT SALT37;
EXPORT hygiene(dataset(layout_bk_withdrawnstatus) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_logid_pcnt := AVE(GROUP,IF(h.logid = (TYPEOF(h.logid))'',0,100));
    maxlength_logid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.logid)));
    avelength_logid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.logid)),h.logid<>(typeof(h.logid))'');
    populated_logdate_pcnt := AVE(GROUP,IF(h.logdate = (TYPEOF(h.logdate))'',0,100));
    maxlength_logdate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.logdate)));
    avelength_logdate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.logdate)),h.logdate<>(typeof(h.logdate))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_defendantid_pcnt := AVE(GROUP,IF(h.defendantid = (TYPEOF(h.defendantid))'',0,100));
    maxlength_defendantid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.defendantid)));
    avelength_defendantid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.defendantid)),h.defendantid<>(typeof(h.defendantid))'');
    populated_currentchapter_pcnt := AVE(GROUP,IF(h.currentchapter = (TYPEOF(h.currentchapter))'',0,100));
    maxlength_currentchapter := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentchapter)));
    avelength_currentchapter := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentchapter)),h.currentchapter<>(typeof(h.currentchapter))'');
    populated_previouschapter_pcnt := AVE(GROUP,IF(h.previouschapter = (TYPEOF(h.previouschapter))'',0,100));
    maxlength_previouschapter := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.previouschapter)));
    avelength_previouschapter := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.previouschapter)),h.previouschapter<>(typeof(h.previouschapter))'');
    populated_conversionid_pcnt := AVE(GROUP,IF(h.conversionid = (TYPEOF(h.conversionid))'',0,100));
    maxlength_conversionid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.conversionid)));
    avelength_conversionid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.conversionid)),h.conversionid<>(typeof(h.conversionid))'');
    populated_convertdate_pcnt := AVE(GROUP,IF(h.convertdate = (TYPEOF(h.convertdate))'',0,100));
    maxlength_convertdate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.convertdate)));
    avelength_convertdate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.convertdate)),h.convertdate<>(typeof(h.convertdate))'');
    populated_currentdisposition_pcnt := AVE(GROUP,IF(h.currentdisposition = (TYPEOF(h.currentdisposition))'',0,100));
    maxlength_currentdisposition := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentdisposition)));
    avelength_currentdisposition := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentdisposition)),h.currentdisposition<>(typeof(h.currentdisposition))'');
    populated_dcode_pcnt := AVE(GROUP,IF(h.dcode = (TYPEOF(h.dcode))'',0,100));
    maxlength_dcode := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dcode)));
    avelength_dcode := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dcode)),h.dcode<>(typeof(h.dcode))'');
    populated_currentdispositiondate_pcnt := AVE(GROUP,IF(h.currentdispositiondate = (TYPEOF(h.currentdispositiondate))'',0,100));
    maxlength_currentdispositiondate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentdispositiondate)));
    avelength_currentdispositiondate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.currentdispositiondate)),h.currentdispositiondate<>(typeof(h.currentdispositiondate))'');
    populated_intseed_pcnt := AVE(GROUP,IF(h.intseed = (TYPEOF(h.intseed))'',0,100));
    maxlength_intseed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.intseed)));
    avelength_intseed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.intseed)),h.intseed<>(typeof(h.intseed))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_vacateid_pcnt := AVE(GROUP,IF(h.vacateid = (TYPEOF(h.vacateid))'',0,100));
    maxlength_vacateid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateid)));
    avelength_vacateid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateid)),h.vacateid<>(typeof(h.vacateid))'');
    populated_vacatedate_pcnt := AVE(GROUP,IF(h.vacatedate = (TYPEOF(h.vacatedate))'',0,100));
    maxlength_vacatedate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacatedate)));
    avelength_vacatedate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacatedate)),h.vacatedate<>(typeof(h.vacatedate))'');
    populated_vacateddisposition_pcnt := AVE(GROUP,IF(h.vacateddisposition = (TYPEOF(h.vacateddisposition))'',0,100));
    maxlength_vacateddisposition := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateddisposition)));
    avelength_vacateddisposition := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateddisposition)),h.vacateddisposition<>(typeof(h.vacateddisposition))'');
    populated_vacateddispositiondate_pcnt := AVE(GROUP,IF(h.vacateddispositiondate = (TYPEOF(h.vacateddispositiondate))'',0,100));
    maxlength_vacateddispositiondate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateddispositiondate)));
    avelength_vacateddispositiondate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.vacateddispositiondate)),h.vacateddispositiondate<>(typeof(h.vacateddispositiondate))'');
    populated_withdrawnid_pcnt := AVE(GROUP,IF(h.withdrawnid = (TYPEOF(h.withdrawnid))'',0,100));
    maxlength_withdrawnid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawnid)));
    avelength_withdrawnid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawnid)),h.withdrawnid<>(typeof(h.withdrawnid))'');
    populated_originalwithdrawndate_pcnt := AVE(GROUP,IF(h.originalwithdrawndate = (TYPEOF(h.originalwithdrawndate))'',0,100));
    maxlength_originalwithdrawndate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.originalwithdrawndate)));
    avelength_originalwithdrawndate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.originalwithdrawndate)),h.originalwithdrawndate<>(typeof(h.originalwithdrawndate))'');
    populated_withdrawndate_pcnt := AVE(GROUP,IF(h.withdrawndate = (TYPEOF(h.withdrawndate))'',0,100));
    maxlength_withdrawndate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndate)));
    avelength_withdrawndate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndate)),h.withdrawndate<>(typeof(h.withdrawndate))'');
    populated_withdrawndisposition_pcnt := AVE(GROUP,IF(h.withdrawndisposition = (TYPEOF(h.withdrawndisposition))'',0,100));
    maxlength_withdrawndisposition := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndisposition)));
    avelength_withdrawndisposition := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndisposition)),h.withdrawndisposition<>(typeof(h.withdrawndisposition))'');
    populated_withdrawndispositiondate_pcnt := AVE(GROUP,IF(h.withdrawndispositiondate = (TYPEOF(h.withdrawndispositiondate))'',0,100));
    maxlength_withdrawndispositiondate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndispositiondate)));
    avelength_withdrawndispositiondate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.withdrawndispositiondate)),h.withdrawndispositiondate<>(typeof(h.withdrawndispositiondate))'');
    populated_originalwithdrawndispositiondate_pcnt := AVE(GROUP,IF(h.originalwithdrawndispositiondate = (TYPEOF(h.originalwithdrawndispositiondate))'',0,100));
    maxlength_originalwithdrawndispositiondate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.originalwithdrawndispositiondate)));
    avelength_originalwithdrawndispositiondate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.originalwithdrawndispositiondate)),h.originalwithdrawndispositiondate<>(typeof(h.originalwithdrawndispositiondate))'');
    populated_filedinerror_pcnt := AVE(GROUP,IF(h.filedinerror = (TYPEOF(h.filedinerror))'',0,100));
    maxlength_filedinerror := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filedinerror)));
    avelength_filedinerror := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filedinerror)),h.filedinerror<>(typeof(h.filedinerror))'');
    populated_reopendate_pcnt := AVE(GROUP,IF(h.reopendate = (TYPEOF(h.reopendate))'',0,100));
    maxlength_reopendate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.reopendate)));
    avelength_reopendate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.reopendate)),h.reopendate<>(typeof(h.reopendate))'');
    populated_lastupdateddate_pcnt := AVE(GROUP,IF(h.lastupdateddate = (TYPEOF(h.lastupdateddate))'',0,100));
    maxlength_lastupdateddate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lastupdateddate)));
    avelength_lastupdateddate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lastupdateddate)),h.lastupdateddate<>(typeof(h.lastupdateddate))'');
    populated_iscurrent_pcnt := AVE(GROUP,IF(h.iscurrent = (TYPEOF(h.iscurrent))'',0,100));
    maxlength_iscurrent := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.iscurrent)));
    avelength_iscurrent := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.iscurrent)),h.iscurrent<>(typeof(h.iscurrent))'');
    populated___filename_pcnt := AVE(GROUP,IF(h.__filename = (TYPEOF(h.__filename))'',0,100));
    maxlength___filename := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.__filename)));
    avelength___filename := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.__filename)),h.__filename<>(typeof(h.__filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_logid_pcnt *   0.00 / 100 + T.Populated_logdate_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_defendantid_pcnt *   0.00 / 100 + T.Populated_currentchapter_pcnt *   0.00 / 100 + T.Populated_previouschapter_pcnt *   0.00 / 100 + T.Populated_conversionid_pcnt *   0.00 / 100 + T.Populated_convertdate_pcnt *   0.00 / 100 + T.Populated_currentdisposition_pcnt *   0.00 / 100 + T.Populated_dcode_pcnt *   0.00 / 100 + T.Populated_currentdispositiondate_pcnt *   0.00 / 100 + T.Populated_intseed_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_vacateid_pcnt *   0.00 / 100 + T.Populated_vacatedate_pcnt *   0.00 / 100 + T.Populated_vacateddisposition_pcnt *   0.00 / 100 + T.Populated_vacateddispositiondate_pcnt *   0.00 / 100 + T.Populated_withdrawnid_pcnt *   0.00 / 100 + T.Populated_originalwithdrawndate_pcnt *   0.00 / 100 + T.Populated_withdrawndate_pcnt *   0.00 / 100 + T.Populated_withdrawndisposition_pcnt *   0.00 / 100 + T.Populated_withdrawndispositiondate_pcnt *   0.00 / 100 + T.Populated_originalwithdrawndispositiondate_pcnt *   0.00 / 100 + T.Populated_filedinerror_pcnt *   0.00 / 100 + T.Populated_reopendate_pcnt *   0.00 / 100 + T.Populated_lastupdateddate_pcnt *   0.00 / 100 + T.Populated_iscurrent_pcnt *   0.00 / 100 + T.Populated___filename_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_logid_pcnt,le.populated_logdate_pcnt,le.populated_caseid_pcnt,le.populated_defendantid_pcnt,le.populated_currentchapter_pcnt,le.populated_previouschapter_pcnt,le.populated_conversionid_pcnt,le.populated_convertdate_pcnt,le.populated_currentdisposition_pcnt,le.populated_dcode_pcnt,le.populated_currentdispositiondate_pcnt,le.populated_intseed_pcnt,le.populated_pid_pcnt,le.populated_tmsid_pcnt,le.populated_vacateid_pcnt,le.populated_vacatedate_pcnt,le.populated_vacateddisposition_pcnt,le.populated_vacateddispositiondate_pcnt,le.populated_withdrawnid_pcnt,le.populated_originalwithdrawndate_pcnt,le.populated_withdrawndate_pcnt,le.populated_withdrawndisposition_pcnt,le.populated_withdrawndispositiondate_pcnt,le.populated_originalwithdrawndispositiondate_pcnt,le.populated_filedinerror_pcnt,le.populated_reopendate_pcnt,le.populated_lastupdateddate_pcnt,le.populated_iscurrent_pcnt,le.populated___filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_logid,le.maxlength_logdate,le.maxlength_caseid,le.maxlength_defendantid,le.maxlength_currentchapter,le.maxlength_previouschapter,le.maxlength_conversionid,le.maxlength_convertdate,le.maxlength_currentdisposition,le.maxlength_dcode,le.maxlength_currentdispositiondate,le.maxlength_intseed,le.maxlength_pid,le.maxlength_tmsid,le.maxlength_vacateid,le.maxlength_vacatedate,le.maxlength_vacateddisposition,le.maxlength_vacateddispositiondate,le.maxlength_withdrawnid,le.maxlength_originalwithdrawndate,le.maxlength_withdrawndate,le.maxlength_withdrawndisposition,le.maxlength_withdrawndispositiondate,le.maxlength_originalwithdrawndispositiondate,le.maxlength_filedinerror,le.maxlength_reopendate,le.maxlength_lastupdateddate,le.maxlength_iscurrent,le.maxlength___filename);
  SELF.avelength := CHOOSE(C,le.avelength_logid,le.avelength_logdate,le.avelength_caseid,le.avelength_defendantid,le.avelength_currentchapter,le.avelength_previouschapter,le.avelength_conversionid,le.avelength_convertdate,le.avelength_currentdisposition,le.avelength_dcode,le.avelength_currentdispositiondate,le.avelength_intseed,le.avelength_pid,le.avelength_tmsid,le.avelength_vacateid,le.avelength_vacatedate,le.avelength_vacateddisposition,le.avelength_vacateddispositiondate,le.avelength_withdrawnid,le.avelength_originalwithdrawndate,le.avelength_withdrawndate,le.avelength_withdrawndisposition,le.avelength_withdrawndispositiondate,le.avelength_originalwithdrawndispositiondate,le.avelength_filedinerror,le.avelength_reopendate,le.avelength_lastupdateddate,le.avelength_iscurrent,le.avelength___filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 29, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.logid <> 0,TRIM((SALT37.StrType)le.logid), ''),TRIM((SALT37.StrType)le.logdate),TRIM((SALT37.StrType)le.caseid),TRIM((SALT37.StrType)le.defendantid),TRIM((SALT37.StrType)le.currentchapter),TRIM((SALT37.StrType)le.previouschapter),TRIM((SALT37.StrType)le.conversionid),TRIM((SALT37.StrType)le.convertdate),TRIM((SALT37.StrType)le.currentdisposition),TRIM((SALT37.StrType)le.dcode),TRIM((SALT37.StrType)le.currentdispositiondate),TRIM((SALT37.StrType)le.intseed),TRIM((SALT37.StrType)le.pid),TRIM((SALT37.StrType)le.tmsid),TRIM((SALT37.StrType)le.vacateid),TRIM((SALT37.StrType)le.vacatedate),TRIM((SALT37.StrType)le.vacateddisposition),TRIM((SALT37.StrType)le.vacateddispositiondate),TRIM((SALT37.StrType)le.withdrawnid),TRIM((SALT37.StrType)le.originalwithdrawndate),TRIM((SALT37.StrType)le.withdrawndate),TRIM((SALT37.StrType)le.withdrawndisposition),TRIM((SALT37.StrType)le.withdrawndispositiondate),TRIM((SALT37.StrType)le.originalwithdrawndispositiondate),TRIM((SALT37.StrType)le.filedinerror),TRIM((SALT37.StrType)le.reopendate),TRIM((SALT37.StrType)le.lastupdateddate),TRIM((SALT37.StrType)le.iscurrent),TRIM((SALT37.StrType)le.__filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,29,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 29);
  SELF.FldNo2 := 1 + (C % 29);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.logid <> 0,TRIM((SALT37.StrType)le.logid), ''),TRIM((SALT37.StrType)le.logdate),TRIM((SALT37.StrType)le.caseid),TRIM((SALT37.StrType)le.defendantid),TRIM((SALT37.StrType)le.currentchapter),TRIM((SALT37.StrType)le.previouschapter),TRIM((SALT37.StrType)le.conversionid),TRIM((SALT37.StrType)le.convertdate),TRIM((SALT37.StrType)le.currentdisposition),TRIM((SALT37.StrType)le.dcode),TRIM((SALT37.StrType)le.currentdispositiondate),TRIM((SALT37.StrType)le.intseed),TRIM((SALT37.StrType)le.pid),TRIM((SALT37.StrType)le.tmsid),TRIM((SALT37.StrType)le.vacateid),TRIM((SALT37.StrType)le.vacatedate),TRIM((SALT37.StrType)le.vacateddisposition),TRIM((SALT37.StrType)le.vacateddispositiondate),TRIM((SALT37.StrType)le.withdrawnid),TRIM((SALT37.StrType)le.originalwithdrawndate),TRIM((SALT37.StrType)le.withdrawndate),TRIM((SALT37.StrType)le.withdrawndisposition),TRIM((SALT37.StrType)le.withdrawndispositiondate),TRIM((SALT37.StrType)le.originalwithdrawndispositiondate),TRIM((SALT37.StrType)le.filedinerror),TRIM((SALT37.StrType)le.reopendate),TRIM((SALT37.StrType)le.lastupdateddate),TRIM((SALT37.StrType)le.iscurrent),TRIM((SALT37.StrType)le.__filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.logid <> 0,TRIM((SALT37.StrType)le.logid), ''),TRIM((SALT37.StrType)le.logdate),TRIM((SALT37.StrType)le.caseid),TRIM((SALT37.StrType)le.defendantid),TRIM((SALT37.StrType)le.currentchapter),TRIM((SALT37.StrType)le.previouschapter),TRIM((SALT37.StrType)le.conversionid),TRIM((SALT37.StrType)le.convertdate),TRIM((SALT37.StrType)le.currentdisposition),TRIM((SALT37.StrType)le.dcode),TRIM((SALT37.StrType)le.currentdispositiondate),TRIM((SALT37.StrType)le.intseed),TRIM((SALT37.StrType)le.pid),TRIM((SALT37.StrType)le.tmsid),TRIM((SALT37.StrType)le.vacateid),TRIM((SALT37.StrType)le.vacatedate),TRIM((SALT37.StrType)le.vacateddisposition),TRIM((SALT37.StrType)le.vacateddispositiondate),TRIM((SALT37.StrType)le.withdrawnid),TRIM((SALT37.StrType)le.originalwithdrawndate),TRIM((SALT37.StrType)le.withdrawndate),TRIM((SALT37.StrType)le.withdrawndisposition),TRIM((SALT37.StrType)le.withdrawndispositiondate),TRIM((SALT37.StrType)le.originalwithdrawndispositiondate),TRIM((SALT37.StrType)le.filedinerror),TRIM((SALT37.StrType)le.reopendate),TRIM((SALT37.StrType)le.lastupdateddate),TRIM((SALT37.StrType)le.iscurrent),TRIM((SALT37.StrType)le.__filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),29*29,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'logid'}
      ,{2,'logdate'}
      ,{3,'caseid'}
      ,{4,'defendantid'}
      ,{5,'currentchapter'}
      ,{6,'previouschapter'}
      ,{7,'conversionid'}
      ,{8,'convertdate'}
      ,{9,'currentdisposition'}
      ,{10,'dcode'}
      ,{11,'currentdispositiondate'}
      ,{12,'intseed'}
      ,{13,'pid'}
      ,{14,'tmsid'}
      ,{15,'vacateid'}
      ,{16,'vacatedate'}
      ,{17,'vacateddisposition'}
      ,{18,'vacateddispositiondate'}
      ,{19,'withdrawnid'}
      ,{20,'originalwithdrawndate'}
      ,{21,'withdrawndate'}
      ,{22,'withdrawndisposition'}
      ,{23,'withdrawndispositiondate'}
      ,{24,'originalwithdrawndispositiondate'}
      ,{25,'filedinerror'}
      ,{26,'reopendate'}
      ,{27,'lastupdateddate'}
      ,{28,'iscurrent'}
      ,{29,'__filename'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_logid((SALT37.StrType)le.logid),
    Fields.InValid_logdate((SALT37.StrType)le.logdate),
    Fields.InValid_caseid((SALT37.StrType)le.caseid),
    Fields.InValid_defendantid((SALT37.StrType)le.defendantid),
    Fields.InValid_currentchapter((SALT37.StrType)le.currentchapter),
    Fields.InValid_previouschapter((SALT37.StrType)le.previouschapter),
    Fields.InValid_conversionid((SALT37.StrType)le.conversionid),
    Fields.InValid_convertdate((SALT37.StrType)le.convertdate),
    Fields.InValid_currentdisposition((SALT37.StrType)le.currentdisposition),
    Fields.InValid_dcode((SALT37.StrType)le.dcode),
    Fields.InValid_currentdispositiondate((SALT37.StrType)le.currentdispositiondate),
    Fields.InValid_intseed((SALT37.StrType)le.intseed),
    Fields.InValid_pid((SALT37.StrType)le.pid),
    Fields.InValid_tmsid((SALT37.StrType)le.tmsid),
    Fields.InValid_vacateid((SALT37.StrType)le.vacateid),
    Fields.InValid_vacatedate((SALT37.StrType)le.vacatedate),
    Fields.InValid_vacateddisposition((SALT37.StrType)le.vacateddisposition),
    Fields.InValid_vacateddispositiondate((SALT37.StrType)le.vacateddispositiondate),
    Fields.InValid_withdrawnid((SALT37.StrType)le.withdrawnid),
    Fields.InValid_originalwithdrawndate((SALT37.StrType)le.originalwithdrawndate),
    Fields.InValid_withdrawndate((SALT37.StrType)le.withdrawndate),
    Fields.InValid_withdrawndisposition((SALT37.StrType)le.withdrawndisposition),
    Fields.InValid_withdrawndispositiondate((SALT37.StrType)le.withdrawndispositiondate),
    Fields.InValid_originalwithdrawndispositiondate((SALT37.StrType)le.originalwithdrawndispositiondate),
    Fields.InValid_filedinerror((SALT37.StrType)le.filedinerror),
    Fields.InValid_reopendate((SALT37.StrType)le.reopendate),
    Fields.InValid_lastupdateddate((SALT37.StrType)le.lastupdateddate),
    Fields.InValid_iscurrent((SALT37.StrType)le.iscurrent),
    Fields.InValid___filename((SALT37.StrType)le.__filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,29,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_logid(TotalErrors.ErrorNum),Fields.InValidMessage_logdate(TotalErrors.ErrorNum),Fields.InValidMessage_caseid(TotalErrors.ErrorNum),Fields.InValidMessage_defendantid(TotalErrors.ErrorNum),Fields.InValidMessage_currentchapter(TotalErrors.ErrorNum),Fields.InValidMessage_previouschapter(TotalErrors.ErrorNum),Fields.InValidMessage_conversionid(TotalErrors.ErrorNum),Fields.InValidMessage_convertdate(TotalErrors.ErrorNum),Fields.InValidMessage_currentdisposition(TotalErrors.ErrorNum),Fields.InValidMessage_dcode(TotalErrors.ErrorNum),Fields.InValidMessage_currentdispositiondate(TotalErrors.ErrorNum),Fields.InValidMessage_intseed(TotalErrors.ErrorNum),Fields.InValidMessage_pid(TotalErrors.ErrorNum),Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_vacateid(TotalErrors.ErrorNum),Fields.InValidMessage_vacatedate(TotalErrors.ErrorNum),Fields.InValidMessage_vacateddisposition(TotalErrors.ErrorNum),Fields.InValidMessage_vacateddispositiondate(TotalErrors.ErrorNum),Fields.InValidMessage_withdrawnid(TotalErrors.ErrorNum),Fields.InValidMessage_originalwithdrawndate(TotalErrors.ErrorNum),Fields.InValidMessage_withdrawndate(TotalErrors.ErrorNum),Fields.InValidMessage_withdrawndisposition(TotalErrors.ErrorNum),Fields.InValidMessage_withdrawndispositiondate(TotalErrors.ErrorNum),Fields.InValidMessage_originalwithdrawndispositiondate(TotalErrors.ErrorNum),Fields.InValidMessage_filedinerror(TotalErrors.ErrorNum),Fields.InValidMessage_reopendate(TotalErrors.ErrorNum),Fields.InValidMessage_lastupdateddate(TotalErrors.ErrorNum),Fields.InValidMessage_iscurrent(TotalErrors.ErrorNum),Fields.InValidMessage___filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
