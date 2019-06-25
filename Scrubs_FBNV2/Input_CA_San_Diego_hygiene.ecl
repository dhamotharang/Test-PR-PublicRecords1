IMPORT SALT311,STD;
EXPORT Input_CA_San_Diego_hygiene(dataset(Input_CA_San_Diego_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_FILE_NUMBER_cnt := COUNT(GROUP,h.FILE_NUMBER <> (TYPEOF(h.FILE_NUMBER))'');
    populated_FILE_NUMBER_pcnt := AVE(GROUP,IF(h.FILE_NUMBER = (TYPEOF(h.FILE_NUMBER))'',0,100));
    maxlength_FILE_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_NUMBER)));
    avelength_FILE_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_NUMBER)),h.FILE_NUMBER<>(typeof(h.FILE_NUMBER))'');
    populated_FILE_DATE_cnt := COUNT(GROUP,h.FILE_DATE <> (TYPEOF(h.FILE_DATE))'');
    populated_FILE_DATE_pcnt := AVE(GROUP,IF(h.FILE_DATE = (TYPEOF(h.FILE_DATE))'',0,100));
    maxlength_FILE_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_DATE)));
    avelength_FILE_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_DATE)),h.FILE_DATE<>(typeof(h.FILE_DATE))'');
    populated_PREV_FILE_NUMBER_cnt := COUNT(GROUP,h.PREV_FILE_NUMBER <> (TYPEOF(h.PREV_FILE_NUMBER))'');
    populated_PREV_FILE_NUMBER_pcnt := AVE(GROUP,IF(h.PREV_FILE_NUMBER = (TYPEOF(h.PREV_FILE_NUMBER))'',0,100));
    maxlength_PREV_FILE_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PREV_FILE_NUMBER)));
    avelength_PREV_FILE_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PREV_FILE_NUMBER)),h.PREV_FILE_NUMBER<>(typeof(h.PREV_FILE_NUMBER))'');
    populated_PREV_FILE_DATE_cnt := COUNT(GROUP,h.PREV_FILE_DATE <> (TYPEOF(h.PREV_FILE_DATE))'');
    populated_PREV_FILE_DATE_pcnt := AVE(GROUP,IF(h.PREV_FILE_DATE = (TYPEOF(h.PREV_FILE_DATE))'',0,100));
    maxlength_PREV_FILE_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PREV_FILE_DATE)));
    avelength_PREV_FILE_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PREV_FILE_DATE)),h.PREV_FILE_DATE<>(typeof(h.PREV_FILE_DATE))'');
    populated_FILING_TYPE_cnt := COUNT(GROUP,h.FILING_TYPE <> (TYPEOF(h.FILING_TYPE))'');
    populated_FILING_TYPE_pcnt := AVE(GROUP,IF(h.FILING_TYPE = (TYPEOF(h.FILING_TYPE))'',0,100));
    maxlength_FILING_TYPE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILING_TYPE)));
    avelength_FILING_TYPE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILING_TYPE)),h.FILING_TYPE<>(typeof(h.FILING_TYPE))'');
    populated_BUSINESS_NAME_cnt := COUNT(GROUP,h.BUSINESS_NAME <> (TYPEOF(h.BUSINESS_NAME))'');
    populated_BUSINESS_NAME_pcnt := AVE(GROUP,IF(h.BUSINESS_NAME = (TYPEOF(h.BUSINESS_NAME))'',0,100));
    maxlength_BUSINESS_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)));
    avelength_BUSINESS_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)),h.BUSINESS_NAME<>(typeof(h.BUSINESS_NAME))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_FILE_NUMBER_pcnt *   0.00 / 100 + T.Populated_FILE_DATE_pcnt *   0.00 / 100 + T.Populated_PREV_FILE_NUMBER_pcnt *   0.00 / 100 + T.Populated_PREV_FILE_DATE_pcnt *   0.00 / 100 + T.Populated_FILING_TYPE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_NAME_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'FILE_NUMBER','FILE_DATE','PREV_FILE_NUMBER','PREV_FILE_DATE','FILING_TYPE','BUSINESS_NAME','prep_addr_line1','prep_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_FILE_NUMBER_pcnt,le.populated_FILE_DATE_pcnt,le.populated_PREV_FILE_NUMBER_pcnt,le.populated_PREV_FILE_DATE_pcnt,le.populated_FILING_TYPE_pcnt,le.populated_BUSINESS_NAME_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_FILE_NUMBER,le.maxlength_FILE_DATE,le.maxlength_PREV_FILE_NUMBER,le.maxlength_PREV_FILE_DATE,le.maxlength_FILING_TYPE,le.maxlength_BUSINESS_NAME,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_FILE_NUMBER,le.avelength_FILE_DATE,le.avelength_PREV_FILE_NUMBER,le.avelength_PREV_FILE_DATE,le.avelength_FILING_TYPE,le.avelength_BUSINESS_NAME,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.PREV_FILE_NUMBER),TRIM((SALT311.StrType)le.PREV_FILE_DATE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.PREV_FILE_NUMBER),TRIM((SALT311.StrType)le.PREV_FILE_DATE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.FILE_NUMBER),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.PREV_FILE_NUMBER),TRIM((SALT311.StrType)le.PREV_FILE_DATE),TRIM((SALT311.StrType)le.FILING_TYPE),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'FILE_NUMBER'}
      ,{2,'FILE_DATE'}
      ,{3,'PREV_FILE_NUMBER'}
      ,{4,'PREV_FILE_DATE'}
      ,{5,'FILING_TYPE'}
      ,{6,'BUSINESS_NAME'}
      ,{7,'prep_addr_line1'}
      ,{8,'prep_addr_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_San_Diego_Fields.InValid_FILE_NUMBER((SALT311.StrType)le.FILE_NUMBER),
    Input_CA_San_Diego_Fields.InValid_FILE_DATE((SALT311.StrType)le.FILE_DATE),
    Input_CA_San_Diego_Fields.InValid_PREV_FILE_NUMBER((SALT311.StrType)le.PREV_FILE_NUMBER),
    Input_CA_San_Diego_Fields.InValid_PREV_FILE_DATE((SALT311.StrType)le.PREV_FILE_DATE),
    Input_CA_San_Diego_Fields.InValid_FILING_TYPE((SALT311.StrType)le.FILING_TYPE),
    Input_CA_San_Diego_Fields.InValid_BUSINESS_NAME((SALT311.StrType)le.BUSINESS_NAME),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last),
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
  FieldNme := Input_CA_San_Diego_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_San_Diego_Fields.InValidMessage_FILE_NUMBER(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_FILE_DATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_PREV_FILE_NUMBER(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_PREV_FILE_DATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_FILING_TYPE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_BUSINESS_NAME(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_CA_San_Diego_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
