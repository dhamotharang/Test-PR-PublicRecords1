IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Tradeline) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_link_id_cnt := COUNT(GROUP,h.link_id <> (TYPEOF(h.link_id))'');
    populated_link_id_pcnt := AVE(GROUP,IF(h.link_id = (TYPEOF(h.link_id))'',0,100));
    maxlength_link_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_id)));
    avelength_link_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_id)),h.link_id<>(typeof(h.link_id))'');
    populated_account_key_cnt := COUNT(GROUP,h.account_key <> (TYPEOF(h.account_key))'');
    populated_account_key_pcnt := AVE(GROUP,IF(h.account_key = (TYPEOF(h.account_key))'',0,100));
    maxlength_account_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_key)));
    avelength_account_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_key)),h.account_key<>(typeof(h.account_key))'');
    populated_segment_id_cnt := COUNT(GROUP,h.segment_id <> (TYPEOF(h.segment_id))'');
    populated_segment_id_pcnt := AVE(GROUP,IF(h.segment_id = (TYPEOF(h.segment_id))'',0,100));
    maxlength_segment_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_id)));
    avelength_segment_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_id)),h.segment_id<>(typeof(h.segment_id))'');
    populated_ar_date_cnt := COUNT(GROUP,h.ar_date <> (TYPEOF(h.ar_date))'');
    populated_ar_date_pcnt := AVE(GROUP,IF(h.ar_date = (TYPEOF(h.ar_date))'',0,100));
    maxlength_ar_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_date)));
    avelength_ar_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_date)),h.ar_date<>(typeof(h.ar_date))'');
    populated_total_ar_cnt := COUNT(GROUP,h.total_ar <> (TYPEOF(h.total_ar))'');
    populated_total_ar_pcnt := AVE(GROUP,IF(h.total_ar = (TYPEOF(h.total_ar))'',0,100));
    maxlength_total_ar := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_ar)));
    avelength_total_ar := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_ar)),h.total_ar<>(typeof(h.total_ar))'');
    populated_current_ar_cnt := COUNT(GROUP,h.current_ar <> (TYPEOF(h.current_ar))'');
    populated_current_ar_pcnt := AVE(GROUP,IF(h.current_ar = (TYPEOF(h.current_ar))'',0,100));
    maxlength_current_ar := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_ar)));
    avelength_current_ar := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_ar)),h.current_ar<>(typeof(h.current_ar))'');
    populated_aging_1to30_cnt := COUNT(GROUP,h.aging_1to30 <> (TYPEOF(h.aging_1to30))'');
    populated_aging_1to30_pcnt := AVE(GROUP,IF(h.aging_1to30 = (TYPEOF(h.aging_1to30))'',0,100));
    maxlength_aging_1to30 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_1to30)));
    avelength_aging_1to30 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_1to30)),h.aging_1to30<>(typeof(h.aging_1to30))'');
    populated_aging_31to60_cnt := COUNT(GROUP,h.aging_31to60 <> (TYPEOF(h.aging_31to60))'');
    populated_aging_31to60_pcnt := AVE(GROUP,IF(h.aging_31to60 = (TYPEOF(h.aging_31to60))'',0,100));
    maxlength_aging_31to60 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_31to60)));
    avelength_aging_31to60 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_31to60)),h.aging_31to60<>(typeof(h.aging_31to60))'');
    populated_aging_61to90_cnt := COUNT(GROUP,h.aging_61to90 <> (TYPEOF(h.aging_61to90))'');
    populated_aging_61to90_pcnt := AVE(GROUP,IF(h.aging_61to90 = (TYPEOF(h.aging_61to90))'',0,100));
    maxlength_aging_61to90 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_61to90)));
    avelength_aging_61to90 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_61to90)),h.aging_61to90<>(typeof(h.aging_61to90))'');
    populated_aging_91plus_cnt := COUNT(GROUP,h.aging_91plus <> (TYPEOF(h.aging_91plus))'');
    populated_aging_91plus_pcnt := AVE(GROUP,IF(h.aging_91plus = (TYPEOF(h.aging_91plus))'',0,100));
    maxlength_aging_91plus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_91plus)));
    avelength_aging_91plus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aging_91plus)),h.aging_91plus<>(typeof(h.aging_91plus))'');
    populated_credit_limit_cnt := COUNT(GROUP,h.credit_limit <> (TYPEOF(h.credit_limit))'');
    populated_credit_limit_pcnt := AVE(GROUP,IF(h.credit_limit = (TYPEOF(h.credit_limit))'',0,100));
    maxlength_credit_limit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_limit)));
    avelength_credit_limit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_limit)),h.credit_limit<>(typeof(h.credit_limit))'');
    populated_first_sale_date_cnt := COUNT(GROUP,h.first_sale_date <> (TYPEOF(h.first_sale_date))'');
    populated_first_sale_date_pcnt := AVE(GROUP,IF(h.first_sale_date = (TYPEOF(h.first_sale_date))'',0,100));
    maxlength_first_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_sale_date)));
    avelength_first_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_sale_date)),h.first_sale_date<>(typeof(h.first_sale_date))'');
    populated_last_sale_date_cnt := COUNT(GROUP,h.last_sale_date <> (TYPEOF(h.last_sale_date))'');
    populated_last_sale_date_pcnt := AVE(GROUP,IF(h.last_sale_date = (TYPEOF(h.last_sale_date))'',0,100));
    maxlength_last_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_sale_date)));
    avelength_last_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_sale_date)),h.last_sale_date<>(typeof(h.last_sale_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_link_id_pcnt *   0.00 / 100 + T.Populated_account_key_pcnt *   0.00 / 100 + T.Populated_segment_id_pcnt *   0.00 / 100 + T.Populated_ar_date_pcnt *   0.00 / 100 + T.Populated_total_ar_pcnt *   0.00 / 100 + T.Populated_current_ar_pcnt *   0.00 / 100 + T.Populated_aging_1to30_pcnt *   0.00 / 100 + T.Populated_aging_31to60_pcnt *   0.00 / 100 + T.Populated_aging_61to90_pcnt *   0.00 / 100 + T.Populated_aging_91plus_pcnt *   0.00 / 100 + T.Populated_credit_limit_pcnt *   0.00 / 100 + T.Populated_first_sale_date_pcnt *   0.00 / 100 + T.Populated_last_sale_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'link_id','account_key','segment_id','ar_date','total_ar','current_ar','aging_1to30','aging_31to60','aging_61to90','aging_91plus','credit_limit','first_sale_date','last_sale_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_link_id_pcnt,le.populated_account_key_pcnt,le.populated_segment_id_pcnt,le.populated_ar_date_pcnt,le.populated_total_ar_pcnt,le.populated_current_ar_pcnt,le.populated_aging_1to30_pcnt,le.populated_aging_31to60_pcnt,le.populated_aging_61to90_pcnt,le.populated_aging_91plus_pcnt,le.populated_credit_limit_pcnt,le.populated_first_sale_date_pcnt,le.populated_last_sale_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_link_id,le.maxlength_account_key,le.maxlength_segment_id,le.maxlength_ar_date,le.maxlength_total_ar,le.maxlength_current_ar,le.maxlength_aging_1to30,le.maxlength_aging_31to60,le.maxlength_aging_61to90,le.maxlength_aging_91plus,le.maxlength_credit_limit,le.maxlength_first_sale_date,le.maxlength_last_sale_date);
  SELF.avelength := CHOOSE(C,le.avelength_link_id,le.avelength_account_key,le.avelength_segment_id,le.avelength_ar_date,le.avelength_total_ar,le.avelength_current_ar,le.avelength_aging_1to30,le.avelength_aging_31to60,le.avelength_aging_61to90,le.avelength_aging_91plus,le.avelength_credit_limit,le.avelength_first_sale_date,le.avelength_last_sale_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 13, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.account_key),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.ar_date),TRIM((SALT311.StrType)le.total_ar),TRIM((SALT311.StrType)le.current_ar),TRIM((SALT311.StrType)le.aging_1to30),TRIM((SALT311.StrType)le.aging_31to60),TRIM((SALT311.StrType)le.aging_61to90),TRIM((SALT311.StrType)le.aging_91plus),TRIM((SALT311.StrType)le.credit_limit),TRIM((SALT311.StrType)le.first_sale_date),TRIM((SALT311.StrType)le.last_sale_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,13,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 13);
  SELF.FldNo2 := 1 + (C % 13);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.account_key),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.ar_date),TRIM((SALT311.StrType)le.total_ar),TRIM((SALT311.StrType)le.current_ar),TRIM((SALT311.StrType)le.aging_1to30),TRIM((SALT311.StrType)le.aging_31to60),TRIM((SALT311.StrType)le.aging_61to90),TRIM((SALT311.StrType)le.aging_91plus),TRIM((SALT311.StrType)le.credit_limit),TRIM((SALT311.StrType)le.first_sale_date),TRIM((SALT311.StrType)le.last_sale_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.account_key),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.ar_date),TRIM((SALT311.StrType)le.total_ar),TRIM((SALT311.StrType)le.current_ar),TRIM((SALT311.StrType)le.aging_1to30),TRIM((SALT311.StrType)le.aging_31to60),TRIM((SALT311.StrType)le.aging_61to90),TRIM((SALT311.StrType)le.aging_91plus),TRIM((SALT311.StrType)le.credit_limit),TRIM((SALT311.StrType)le.first_sale_date),TRIM((SALT311.StrType)le.last_sale_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),13*13,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'link_id'}
      ,{2,'account_key'}
      ,{3,'segment_id'}
      ,{4,'ar_date'}
      ,{5,'total_ar'}
      ,{6,'current_ar'}
      ,{7,'aging_1to30'}
      ,{8,'aging_31to60'}
      ,{9,'aging_61to90'}
      ,{10,'aging_91plus'}
      ,{11,'credit_limit'}
      ,{12,'first_sale_date'}
      ,{13,'last_sale_date'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_link_id((SALT311.StrType)le.link_id),
    Fields.InValid_account_key((SALT311.StrType)le.account_key),
    Fields.InValid_segment_id((SALT311.StrType)le.segment_id),
    Fields.InValid_ar_date((SALT311.StrType)le.ar_date),
    Fields.InValid_total_ar((SALT311.StrType)le.total_ar),
    Fields.InValid_current_ar((SALT311.StrType)le.current_ar),
    Fields.InValid_aging_1to30((SALT311.StrType)le.aging_1to30),
    Fields.InValid_aging_31to60((SALT311.StrType)le.aging_31to60),
    Fields.InValid_aging_61to90((SALT311.StrType)le.aging_61to90),
    Fields.InValid_aging_91plus((SALT311.StrType)le.aging_91plus),
    Fields.InValid_credit_limit((SALT311.StrType)le.credit_limit),
    Fields.InValid_first_sale_date((SALT311.StrType)le.first_sale_date),
    Fields.InValid_last_sale_date((SALT311.StrType)le.last_sale_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,13,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'numeric','Unknown','Unknown','date','number','number','number','number','number','number','number','date','date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_link_id(TotalErrors.ErrorNum),Fields.InValidMessage_account_key(TotalErrors.ErrorNum),Fields.InValidMessage_segment_id(TotalErrors.ErrorNum),Fields.InValidMessage_ar_date(TotalErrors.ErrorNum),Fields.InValidMessage_total_ar(TotalErrors.ErrorNum),Fields.InValidMessage_current_ar(TotalErrors.ErrorNum),Fields.InValidMessage_aging_1to30(TotalErrors.ErrorNum),Fields.InValidMessage_aging_31to60(TotalErrors.ErrorNum),Fields.InValidMessage_aging_61to90(TotalErrors.ErrorNum),Fields.InValidMessage_aging_91plus(TotalErrors.ErrorNum),Fields.InValidMessage_credit_limit(TotalErrors.ErrorNum),Fields.InValidMessage_first_sale_date(TotalErrors.ErrorNum),Fields.InValidMessage_last_sale_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Cortera_Tradeline, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
