IMPORT SALT311,STD;
EXPORT Input_TX_Harris_hygiene(dataset(Input_TX_Harris_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_FILE_NUMBER_cnt := COUNT(GROUP,h.FILE_NUMBER <> (TYPEOF(h.FILE_NUMBER))'');
    populated_FILE_NUMBER_pcnt := AVE(GROUP,IF(h.FILE_NUMBER = (TYPEOF(h.FILE_NUMBER))'',0,100));
    maxlength_FILE_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_NUMBER)));
    avelength_FILE_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_NUMBER)),h.FILE_NUMBER<>(typeof(h.FILE_NUMBER))'');
    populated_DATE_FILED_cnt := COUNT(GROUP,h.DATE_FILED <> (TYPEOF(h.DATE_FILED))'');
    populated_DATE_FILED_pcnt := AVE(GROUP,IF(h.DATE_FILED = (TYPEOF(h.DATE_FILED))'',0,100));
    maxlength_DATE_FILED := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DATE_FILED)));
    avelength_DATE_FILED := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DATE_FILED)),h.DATE_FILED<>(typeof(h.DATE_FILED))'');
    populated_NAME1_cnt := COUNT(GROUP,h.NAME1 <> (TYPEOF(h.NAME1))'');
    populated_NAME1_pcnt := AVE(GROUP,IF(h.NAME1 = (TYPEOF(h.NAME1))'',0,100));
    maxlength_NAME1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.NAME1)));
    avelength_NAME1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.NAME1)),h.NAME1<>(typeof(h.NAME1))'');
    populated_NAME2_cnt := COUNT(GROUP,h.NAME2 <> (TYPEOF(h.NAME2))'');
    populated_NAME2_pcnt := AVE(GROUP,IF(h.NAME2 = (TYPEOF(h.NAME2))'',0,100));
    maxlength_NAME2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.NAME2)));
    avelength_NAME2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.NAME2)),h.NAME2<>(typeof(h.NAME2))'');
    populated_prep_addr1_line1_cnt := COUNT(GROUP,h.prep_addr1_line1 <> (TYPEOF(h.prep_addr1_line1))'');
    populated_prep_addr1_line1_pcnt := AVE(GROUP,IF(h.prep_addr1_line1 = (TYPEOF(h.prep_addr1_line1))'',0,100));
    maxlength_prep_addr1_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr1_line1)));
    avelength_prep_addr1_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr1_line1)),h.prep_addr1_line1<>(typeof(h.prep_addr1_line1))'');
    populated_prep_addr1_line_last_cnt := COUNT(GROUP,h.prep_addr1_line_last <> (TYPEOF(h.prep_addr1_line_last))'');
    populated_prep_addr1_line_last_pcnt := AVE(GROUP,IF(h.prep_addr1_line_last = (TYPEOF(h.prep_addr1_line_last))'',0,100));
    maxlength_prep_addr1_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr1_line_last)));
    avelength_prep_addr1_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr1_line_last)),h.prep_addr1_line_last<>(typeof(h.prep_addr1_line_last))'');
    populated_prep_addr2_line1_cnt := COUNT(GROUP,h.prep_addr2_line1 <> (TYPEOF(h.prep_addr2_line1))'');
    populated_prep_addr2_line1_pcnt := AVE(GROUP,IF(h.prep_addr2_line1 = (TYPEOF(h.prep_addr2_line1))'',0,100));
    maxlength_prep_addr2_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr2_line1)));
    avelength_prep_addr2_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr2_line1)),h.prep_addr2_line1<>(typeof(h.prep_addr2_line1))'');
    populated_prep_addr2_line_last_cnt := COUNT(GROUP,h.prep_addr2_line_last <> (TYPEOF(h.prep_addr2_line_last))'');
    populated_prep_addr2_line_last_pcnt := AVE(GROUP,IF(h.prep_addr2_line_last = (TYPEOF(h.prep_addr2_line_last))'',0,100));
    maxlength_prep_addr2_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr2_line_last)));
    avelength_prep_addr2_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr2_line_last)),h.prep_addr2_line_last<>(typeof(h.prep_addr2_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_FILE_NUMBER_pcnt *   0.00 / 100 + T.Populated_DATE_FILED_pcnt *   0.00 / 100 + T.Populated_NAME1_pcnt *   0.00 / 100 + T.Populated_NAME2_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line_last_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'FILE_NUMBER','DATE_FILED','NAME1','NAME2','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_FILE_NUMBER_pcnt,le.populated_DATE_FILED_pcnt,le.populated_NAME1_pcnt,le.populated_NAME2_pcnt,le.populated_prep_addr1_line1_pcnt,le.populated_prep_addr1_line_last_pcnt,le.populated_prep_addr2_line1_pcnt,le.populated_prep_addr2_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_FILE_NUMBER,le.maxlength_DATE_FILED,le.maxlength_NAME1,le.maxlength_NAME2,le.maxlength_prep_addr1_line1,le.maxlength_prep_addr1_line_last,le.maxlength_prep_addr2_line1,le.maxlength_prep_addr2_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_FILE_NUMBER,le.avelength_DATE_FILED,le.avelength_NAME1,le.avelength_NAME2,le.avelength_prep_addr1_line1,le.avelength_prep_addr1_line_last,le.avelength_prep_addr2_line1,le.avelength_prep_addr2_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.DATE_FILED),TRIM((SALT311.StrType)le.NAME1),TRIM((SALT311.StrType)le.NAME2),TRIM((SALT311.StrType)le.prep_addr1_line1),TRIM((SALT311.StrType)le.prep_addr1_line_last),TRIM((SALT311.StrType)le.prep_addr2_line1),TRIM((SALT311.StrType)le.prep_addr2_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.DATE_FILED),TRIM((SALT311.StrType)le.NAME1),TRIM((SALT311.StrType)le.NAME2),TRIM((SALT311.StrType)le.prep_addr1_line1),TRIM((SALT311.StrType)le.prep_addr1_line_last),TRIM((SALT311.StrType)le.prep_addr2_line1),TRIM((SALT311.StrType)le.prep_addr2_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.DATE_FILED),TRIM((SALT311.StrType)le.NAME1),TRIM((SALT311.StrType)le.NAME2),TRIM((SALT311.StrType)le.prep_addr1_line1),TRIM((SALT311.StrType)le.prep_addr1_line_last),TRIM((SALT311.StrType)le.prep_addr2_line1),TRIM((SALT311.StrType)le.prep_addr2_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'FILE_NUMBER'}
      ,{2,'DATE_FILED'}
      ,{3,'NAME1'}
      ,{4,'NAME2'}
      ,{5,'prep_addr1_line1'}
      ,{6,'prep_addr1_line_last'}
      ,{7,'prep_addr2_line1'}
      ,{8,'prep_addr2_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_TX_Harris_Fields.InValid_FILE_NUMBER((SALT311.StrType)le.FILE_NUMBER),
    Input_TX_Harris_Fields.InValid_DATE_FILED((SALT311.StrType)le.DATE_FILED),
    Input_TX_Harris_Fields.InValid_NAME1((SALT311.StrType)le.NAME1),
    Input_TX_Harris_Fields.InValid_NAME2((SALT311.StrType)le.NAME2),
    Input_TX_Harris_Fields.InValid_prep_addr1_line1((SALT311.StrType)le.prep_addr1_line1),
    Input_TX_Harris_Fields.InValid_prep_addr1_line_last((SALT311.StrType)le.prep_addr1_line_last),
    Input_TX_Harris_Fields.InValid_prep_addr2_line1((SALT311.StrType)le.prep_addr2_line1),
    Input_TX_Harris_Fields.InValid_prep_addr2_line_last((SALT311.StrType)le.prep_addr2_line_last),
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
  FieldNme := Input_TX_Harris_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_TX_Harris_Fields.InValidMessage_FILE_NUMBER(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_DATE_FILED(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_NAME1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_NAME2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line_last(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_TX_Harris_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
