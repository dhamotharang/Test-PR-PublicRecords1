IMPORT SALT39,STD;
EXPORT MarketAppend_hygiene(dataset(MarketAppend_layout_MarketAppend) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_company_id_cnt := COUNT(GROUP,h.company_id <> (TYPEOF(h.company_id))'');
    populated_company_id_pcnt := AVE(GROUP,IF(h.company_id = (TYPEOF(h.company_id))'',0,100));
    maxlength_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_id)));
    avelength_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_id)),h.company_id<>(typeof(h.company_id))'');
    populated_app_type_cnt := COUNT(GROUP,h.app_type <> (TYPEOF(h.app_type))'');
    populated_app_type_pcnt := AVE(GROUP,IF(h.app_type = (TYPEOF(h.app_type))'',0,100));
    maxlength_app_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.app_type)));
    avelength_app_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.app_type)),h.app_type<>(typeof(h.app_type))'');
    populated_market_cnt := COUNT(GROUP,h.market <> (TYPEOF(h.market))'');
    populated_market_pcnt := AVE(GROUP,IF(h.market = (TYPEOF(h.market))'',0,100));
    maxlength_market := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.market)));
    avelength_market := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.market)),h.market<>(typeof(h.market))'');
    populated_sub_market_cnt := COUNT(GROUP,h.sub_market <> (TYPEOF(h.sub_market))'');
    populated_sub_market_pcnt := AVE(GROUP,IF(h.sub_market = (TYPEOF(h.sub_market))'',0,100));
    maxlength_sub_market := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sub_market)));
    avelength_sub_market := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sub_market)),h.sub_market<>(typeof(h.sub_market))'');
    populated_vertical_cnt := COUNT(GROUP,h.vertical <> (TYPEOF(h.vertical))'');
    populated_vertical_pcnt := AVE(GROUP,IF(h.vertical = (TYPEOF(h.vertical))'',0,100));
    maxlength_vertical := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vertical)));
    avelength_vertical := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vertical)),h.vertical<>(typeof(h.vertical))'');
    populated_main_country_code_cnt := COUNT(GROUP,h.main_country_code <> (TYPEOF(h.main_country_code))'');
    populated_main_country_code_pcnt := AVE(GROUP,IF(h.main_country_code = (TYPEOF(h.main_country_code))'',0,100));
    maxlength_main_country_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.main_country_code)));
    avelength_main_country_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.main_country_code)),h.main_country_code<>(typeof(h.main_country_code))'');
    populated_bill_country_code_cnt := COUNT(GROUP,h.bill_country_code <> (TYPEOF(h.bill_country_code))'');
    populated_bill_country_code_pcnt := AVE(GROUP,IF(h.bill_country_code = (TYPEOF(h.bill_country_code))'',0,100));
    maxlength_bill_country_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bill_country_code)));
    avelength_bill_country_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bill_country_code)),h.bill_country_code<>(typeof(h.bill_country_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_company_id_pcnt *   0.00 / 100 + T.Populated_app_type_pcnt *   0.00 / 100 + T.Populated_market_pcnt *   0.00 / 100 + T.Populated_sub_market_pcnt *   0.00 / 100 + T.Populated_vertical_pcnt *   0.00 / 100 + T.Populated_main_country_code_pcnt *   0.00 / 100 + T.Populated_bill_country_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_company_id_pcnt,le.populated_app_type_pcnt,le.populated_market_pcnt,le.populated_sub_market_pcnt,le.populated_vertical_pcnt,le.populated_main_country_code_pcnt,le.populated_bill_country_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_company_id,le.maxlength_app_type,le.maxlength_market,le.maxlength_sub_market,le.maxlength_vertical,le.maxlength_main_country_code,le.maxlength_bill_country_code);
  SELF.avelength := CHOOSE(C,le.avelength_company_id,le.avelength_app_type,le.avelength_market,le.avelength_sub_market,le.avelength_vertical,le.avelength_main_country_code,le.avelength_bill_country_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 7, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.company_id),TRIM((SALT39.StrType)le.app_type),TRIM((SALT39.StrType)le.market),TRIM((SALT39.StrType)le.sub_market),TRIM((SALT39.StrType)le.vertical),TRIM((SALT39.StrType)le.main_country_code),TRIM((SALT39.StrType)le.bill_country_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,7,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 7);
  SELF.FldNo2 := 1 + (C % 7);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.company_id),TRIM((SALT39.StrType)le.app_type),TRIM((SALT39.StrType)le.market),TRIM((SALT39.StrType)le.sub_market),TRIM((SALT39.StrType)le.vertical),TRIM((SALT39.StrType)le.main_country_code),TRIM((SALT39.StrType)le.bill_country_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.company_id),TRIM((SALT39.StrType)le.app_type),TRIM((SALT39.StrType)le.market),TRIM((SALT39.StrType)le.sub_market),TRIM((SALT39.StrType)le.vertical),TRIM((SALT39.StrType)le.main_country_code),TRIM((SALT39.StrType)le.bill_country_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),7*7,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'company_id'}
      ,{2,'app_type'}
      ,{3,'market'}
      ,{4,'sub_market'}
      ,{5,'vertical'}
      ,{6,'main_country_code'}
      ,{7,'bill_country_code'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    MarketAppend_Fields.InValid_company_id((SALT39.StrType)le.company_id),
    MarketAppend_Fields.InValid_app_type((SALT39.StrType)le.app_type),
    MarketAppend_Fields.InValid_market((SALT39.StrType)le.market),
    MarketAppend_Fields.InValid_sub_market((SALT39.StrType)le.sub_market),
    MarketAppend_Fields.InValid_vertical((SALT39.StrType)le.vertical),
    MarketAppend_Fields.InValid_main_country_code((SALT39.StrType)le.main_country_code),
    MarketAppend_Fields.InValid_bill_country_code((SALT39.StrType)le.bill_country_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,7,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := MarketAppend_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,MarketAppend_Fields.InValidMessage_company_id(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_app_type(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_market(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_sub_market(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_vertical(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_main_country_code(TotalErrors.ErrorNum),MarketAppend_Fields.InValidMessage_bill_country_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MarketAppend_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
