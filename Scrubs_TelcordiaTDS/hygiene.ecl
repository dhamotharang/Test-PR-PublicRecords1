IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_TelcordiaTDS) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_npa_cnt := COUNT(GROUP,h.npa <> (TYPEOF(h.npa))'');
    populated_npa_pcnt := AVE(GROUP,IF(h.npa = (TYPEOF(h.npa))'',0,100));
    maxlength_npa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)));
    avelength_npa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)),h.npa<>(typeof(h.npa))'');
    populated_nxx_cnt := COUNT(GROUP,h.nxx <> (TYPEOF(h.nxx))'');
    populated_nxx_pcnt := AVE(GROUP,IF(h.nxx = (TYPEOF(h.nxx))'',0,100));
    maxlength_nxx := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)));
    avelength_nxx := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)),h.nxx<>(typeof(h.nxx))'');
    populated_tb_cnt := COUNT(GROUP,h.tb <> (TYPEOF(h.tb))'');
    populated_tb_pcnt := AVE(GROUP,IF(h.tb = (TYPEOF(h.tb))'',0,100));
    maxlength_tb := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tb)));
    avelength_tb := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tb)),h.tb<>(typeof(h.tb))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_timezone_cnt := COUNT(GROUP,h.timezone <> (TYPEOF(h.timezone))'');
    populated_timezone_pcnt := AVE(GROUP,IF(h.timezone = (TYPEOF(h.timezone))'',0,100));
    maxlength_timezone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)));
    avelength_timezone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)),h.timezone<>(typeof(h.timezone))'');
    populated_coctype_cnt := COUNT(GROUP,h.coctype <> (TYPEOF(h.coctype))'');
    populated_coctype_pcnt := AVE(GROUP,IF(h.coctype = (TYPEOF(h.coctype))'',0,100));
    maxlength_coctype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coctype)));
    avelength_coctype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coctype)),h.coctype<>(typeof(h.coctype))'');
    populated_ssc_cnt := COUNT(GROUP,h.ssc <> (TYPEOF(h.ssc))'');
    populated_ssc_pcnt := AVE(GROUP,IF(h.ssc = (TYPEOF(h.ssc))'',0,100));
    maxlength_ssc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssc)));
    avelength_ssc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssc)),h.ssc<>(typeof(h.ssc))'');
    populated_wireless_ind_cnt := COUNT(GROUP,h.wireless_ind <> (TYPEOF(h.wireless_ind))'');
    populated_wireless_ind_pcnt := AVE(GROUP,IF(h.wireless_ind = (TYPEOF(h.wireless_ind))'',0,100));
    maxlength_wireless_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wireless_ind)));
    avelength_wireless_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wireless_ind)),h.wireless_ind<>(typeof(h.wireless_ind))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_nxx_pcnt *   0.00 / 100 + T.Populated_tb_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_timezone_pcnt *   0.00 / 100 + T.Populated_coctype_pcnt *   0.00 / 100 + T.Populated_ssc_pcnt *   0.00 / 100 + T.Populated_wireless_ind_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'npa','nxx','tb','state','timezone','coctype','ssc','wireless_ind');
  SELF.populated_pcnt := CHOOSE(C,le.populated_npa_pcnt,le.populated_nxx_pcnt,le.populated_tb_pcnt,le.populated_state_pcnt,le.populated_timezone_pcnt,le.populated_coctype_pcnt,le.populated_ssc_pcnt,le.populated_wireless_ind_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_npa,le.maxlength_nxx,le.maxlength_tb,le.maxlength_state,le.maxlength_timezone,le.maxlength_coctype,le.maxlength_ssc,le.maxlength_wireless_ind);
  SELF.avelength := CHOOSE(C,le.avelength_npa,le.avelength_nxx,le.avelength_tb,le.avelength_state,le.avelength_timezone,le.avelength_coctype,le.avelength_ssc,le.avelength_wireless_ind);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.coctype),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.wireless_ind)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.coctype),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.wireless_ind)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.coctype),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.wireless_ind)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'npa'}
      ,{2,'nxx'}
      ,{3,'tb'}
      ,{4,'state'}
      ,{5,'timezone'}
      ,{6,'coctype'}
      ,{7,'ssc'}
      ,{8,'wireless_ind'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_npa((SALT311.StrType)le.npa),
    Fields.InValid_nxx((SALT311.StrType)le.nxx),
    Fields.InValid_tb((SALT311.StrType)le.tb),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_timezone((SALT311.StrType)le.timezone),
    Fields.InValid_coctype((SALT311.StrType)le.coctype),
    Fields.InValid_ssc((SALT311.StrType)le.ssc),
    Fields.InValid_wireless_ind((SALT311.StrType)le.wireless_ind),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Letter','Invalid_Num','Invalid_Coctype','Invalid_Char','Invalid_Wireless');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_npa(TotalErrors.ErrorNum),Fields.InValidMessage_nxx(TotalErrors.ErrorNum),Fields.InValidMessage_tb(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_timezone(TotalErrors.ErrorNum),Fields.InValidMessage_coctype(TotalErrors.ErrorNum),Fields.InValidMessage_ssc(TotalErrors.ErrorNum),Fields.InValidMessage_wireless_ind(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_TelcordiaTDS, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
