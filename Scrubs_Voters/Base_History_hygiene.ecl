IMPORT SALT39,STD;
EXPORT Base_History_hygiene(dataset(Base_History_layout_Voters) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_vtid_cnt := COUNT(GROUP,h.vtid <> (TYPEOF(h.vtid))'');
    populated_vtid_pcnt := AVE(GROUP,IF(h.vtid = (TYPEOF(h.vtid))'',0,100));
    maxlength_vtid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vtid)));
    avelength_vtid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vtid)),h.vtid<>(typeof(h.vtid))'');
    populated_voted_year_cnt := COUNT(GROUP,h.voted_year <> (TYPEOF(h.voted_year))'');
    populated_voted_year_pcnt := AVE(GROUP,IF(h.voted_year = (TYPEOF(h.voted_year))'',0,100));
    maxlength_voted_year := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.voted_year)));
    avelength_voted_year := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.voted_year)),h.voted_year<>(typeof(h.voted_year))'');
    populated_primary_cnt := COUNT(GROUP,h.primary <> (TYPEOF(h.primary))'');
    populated_primary_pcnt := AVE(GROUP,IF(h.primary = (TYPEOF(h.primary))'',0,100));
    maxlength_primary := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary)));
    avelength_primary := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary)),h.primary<>(typeof(h.primary))'');
    populated_special_1_cnt := COUNT(GROUP,h.special_1 <> (TYPEOF(h.special_1))'');
    populated_special_1_pcnt := AVE(GROUP,IF(h.special_1 = (TYPEOF(h.special_1))'',0,100));
    maxlength_special_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.special_1)));
    avelength_special_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.special_1)),h.special_1<>(typeof(h.special_1))'');
    populated_other_cnt := COUNT(GROUP,h.other <> (TYPEOF(h.other))'');
    populated_other_pcnt := AVE(GROUP,IF(h.other = (TYPEOF(h.other))'',0,100));
    maxlength_other := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.other)));
    avelength_other := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.other)),h.other<>(typeof(h.other))'');
    populated_special_2_cnt := COUNT(GROUP,h.special_2 <> (TYPEOF(h.special_2))'');
    populated_special_2_pcnt := AVE(GROUP,IF(h.special_2 = (TYPEOF(h.special_2))'',0,100));
    maxlength_special_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.special_2)));
    avelength_special_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.special_2)),h.special_2<>(typeof(h.special_2))'');
    populated_general_cnt := COUNT(GROUP,h.general <> (TYPEOF(h.general))'');
    populated_general_pcnt := AVE(GROUP,IF(h.general = (TYPEOF(h.general))'',0,100));
    maxlength_general := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.general)));
    avelength_general := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.general)),h.general<>(typeof(h.general))'');
    populated_pres_cnt := COUNT(GROUP,h.pres <> (TYPEOF(h.pres))'');
    populated_pres_pcnt := AVE(GROUP,IF(h.pres = (TYPEOF(h.pres))'',0,100));
    maxlength_pres := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.pres)));
    avelength_pres := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.pres)),h.pres<>(typeof(h.pres))'');
    populated_vote_date_cnt := COUNT(GROUP,h.vote_date <> (TYPEOF(h.vote_date))'');
    populated_vote_date_pcnt := AVE(GROUP,IF(h.vote_date = (TYPEOF(h.vote_date))'',0,100));
    maxlength_vote_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vote_date)));
    avelength_vote_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vote_date)),h.vote_date<>(typeof(h.vote_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_vtid_pcnt *   0.00 / 100 + T.Populated_voted_year_pcnt *   0.00 / 100 + T.Populated_primary_pcnt *   0.00 / 100 + T.Populated_special_1_pcnt *   0.00 / 100 + T.Populated_other_pcnt *   0.00 / 100 + T.Populated_special_2_pcnt *   0.00 / 100 + T.Populated_general_pcnt *   0.00 / 100 + T.Populated_pres_pcnt *   0.00 / 100 + T.Populated_vote_date_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'vtid','voted_year','primary','special_1','other','special_2','general','pres','vote_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_vtid_pcnt,le.populated_voted_year_pcnt,le.populated_primary_pcnt,le.populated_special_1_pcnt,le.populated_other_pcnt,le.populated_special_2_pcnt,le.populated_general_pcnt,le.populated_pres_pcnt,le.populated_vote_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_vtid,le.maxlength_voted_year,le.maxlength_primary,le.maxlength_special_1,le.maxlength_other,le.maxlength_special_2,le.maxlength_general,le.maxlength_pres,le.maxlength_vote_date);
  SELF.avelength := CHOOSE(C,le.avelength_vtid,le.avelength_voted_year,le.avelength_primary,le.avelength_special_1,le.avelength_other,le.avelength_special_2,le.avelength_general,le.avelength_pres,le.avelength_vote_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.voted_year),TRIM((SALT39.StrType)le.primary),TRIM((SALT39.StrType)le.special_1),TRIM((SALT39.StrType)le.other),TRIM((SALT39.StrType)le.special_2),TRIM((SALT39.StrType)le.general),TRIM((SALT39.StrType)le.pres),TRIM((SALT39.StrType)le.vote_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.voted_year),TRIM((SALT39.StrType)le.primary),TRIM((SALT39.StrType)le.special_1),TRIM((SALT39.StrType)le.other),TRIM((SALT39.StrType)le.special_2),TRIM((SALT39.StrType)le.general),TRIM((SALT39.StrType)le.pres),TRIM((SALT39.StrType)le.vote_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.voted_year),TRIM((SALT39.StrType)le.primary),TRIM((SALT39.StrType)le.special_1),TRIM((SALT39.StrType)le.other),TRIM((SALT39.StrType)le.special_2),TRIM((SALT39.StrType)le.general),TRIM((SALT39.StrType)le.pres),TRIM((SALT39.StrType)le.vote_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'vtid'}
      ,{2,'voted_year'}
      ,{3,'primary'}
      ,{4,'special_1'}
      ,{5,'other'}
      ,{6,'special_2'}
      ,{7,'general'}
      ,{8,'pres'}
      ,{9,'vote_date'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_History_Fields.InValid_vtid((SALT39.StrType)le.vtid),
    Base_History_Fields.InValid_voted_year((SALT39.StrType)le.voted_year),
    Base_History_Fields.InValid_primary((SALT39.StrType)le.primary),
    Base_History_Fields.InValid_special_1((SALT39.StrType)le.special_1),
    Base_History_Fields.InValid_other((SALT39.StrType)le.other),
    Base_History_Fields.InValid_special_2((SALT39.StrType)le.special_2),
    Base_History_Fields.InValid_general((SALT39.StrType)le.general),
    Base_History_Fields.InValid_pres((SALT39.StrType)le.pres,(SALT39.StrType)le.primary,(SALT39.StrType)le.special_1,(SALT39.StrType)le.other,(SALT39.StrType)le.special_2,(SALT39.StrType)le.general),
    Base_History_Fields.InValid_vote_date((SALT39.StrType)le.vote_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,9,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_History_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_voted_year','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_pres','invalid_vote_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_History_Fields.InValidMessage_vtid(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_voted_year(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_primary(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_special_1(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_other(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_special_2(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_general(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_pres(TotalErrors.ErrorNum),Base_History_Fields.InValidMessage_vote_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Voters, Base_History_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
