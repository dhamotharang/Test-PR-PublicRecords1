IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_LaborActions_EBSA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dart_id_cnt := COUNT(GROUP,h.dart_id <> (TYPEOF(h.dart_id))'');
    populated_dart_id_pcnt := AVE(GROUP,IF(h.dart_id = (TYPEOF(h.dart_id))'',0,100));
    maxlength_dart_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dart_id)));
    avelength_dart_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dart_id)),h.dart_id<>(typeof(h.dart_id))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_date_updated_cnt := COUNT(GROUP,h.date_updated <> (TYPEOF(h.date_updated))'');
    populated_date_updated_pcnt := AVE(GROUP,IF(h.date_updated = (TYPEOF(h.date_updated))'',0,100));
    maxlength_date_updated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_updated)));
    avelength_date_updated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_updated)),h.date_updated<>(typeof(h.date_updated))'');
    populated_website_cnt := COUNT(GROUP,h.website <> (TYPEOF(h.website))'');
    populated_website_pcnt := AVE(GROUP,IF(h.website = (TYPEOF(h.website))'',0,100));
    maxlength_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)));
    avelength_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)),h.website<>(typeof(h.website))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_casetype_cnt := COUNT(GROUP,h.casetype <> (TYPEOF(h.casetype))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_plan_ein_cnt := COUNT(GROUP,h.plan_ein <> (TYPEOF(h.plan_ein))'');
    populated_plan_ein_pcnt := AVE(GROUP,IF(h.plan_ein = (TYPEOF(h.plan_ein))'',0,100));
    maxlength_plan_ein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_ein)));
    avelength_plan_ein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_ein)),h.plan_ein<>(typeof(h.plan_ein))'');
    populated_plan_no_cnt := COUNT(GROUP,h.plan_no <> (TYPEOF(h.plan_no))'');
    populated_plan_no_pcnt := AVE(GROUP,IF(h.plan_no = (TYPEOF(h.plan_no))'',0,100));
    maxlength_plan_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_no)));
    avelength_plan_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_no)),h.plan_no<>(typeof(h.plan_no))'');
    populated_plan_year_cnt := COUNT(GROUP,h.plan_year <> (TYPEOF(h.plan_year))'');
    populated_plan_year_pcnt := AVE(GROUP,IF(h.plan_year = (TYPEOF(h.plan_year))'',0,100));
    maxlength_plan_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_year)));
    avelength_plan_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_year)),h.plan_year<>(typeof(h.plan_year))'');
    populated_plan_name_cnt := COUNT(GROUP,h.plan_name <> (TYPEOF(h.plan_name))'');
    populated_plan_name_pcnt := AVE(GROUP,IF(h.plan_name = (TYPEOF(h.plan_name))'',0,100));
    maxlength_plan_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_name)));
    avelength_plan_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_name)),h.plan_name<>(typeof(h.plan_name))'');
    populated_plan_administrator_cnt := COUNT(GROUP,h.plan_administrator <> (TYPEOF(h.plan_administrator))'');
    populated_plan_administrator_pcnt := AVE(GROUP,IF(h.plan_administrator = (TYPEOF(h.plan_administrator))'',0,100));
    maxlength_plan_administrator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_administrator)));
    avelength_plan_administrator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_administrator)),h.plan_administrator<>(typeof(h.plan_administrator))'');
    populated_admin_state_cnt := COUNT(GROUP,h.admin_state <> (TYPEOF(h.admin_state))'');
    populated_admin_state_pcnt := AVE(GROUP,IF(h.admin_state = (TYPEOF(h.admin_state))'',0,100));
    maxlength_admin_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_state)));
    avelength_admin_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_state)),h.admin_state<>(typeof(h.admin_state))'');
    populated_admin_zip_code_cnt := COUNT(GROUP,h.admin_zip_code <> (TYPEOF(h.admin_zip_code))'');
    populated_admin_zip_code_pcnt := AVE(GROUP,IF(h.admin_zip_code = (TYPEOF(h.admin_zip_code))'',0,100));
    maxlength_admin_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_zip_code)));
    avelength_admin_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_zip_code)),h.admin_zip_code<>(typeof(h.admin_zip_code))'');
    populated_admin_zip_code4_cnt := COUNT(GROUP,h.admin_zip_code4 <> (TYPEOF(h.admin_zip_code4))'');
    populated_admin_zip_code4_pcnt := AVE(GROUP,IF(h.admin_zip_code4 = (TYPEOF(h.admin_zip_code4))'',0,100));
    maxlength_admin_zip_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_zip_code4)));
    avelength_admin_zip_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_zip_code4)),h.admin_zip_code4<>(typeof(h.admin_zip_code4))'');
    populated_closing_reason_cnt := COUNT(GROUP,h.closing_reason <> (TYPEOF(h.closing_reason))'');
    populated_closing_reason_pcnt := AVE(GROUP,IF(h.closing_reason = (TYPEOF(h.closing_reason))'',0,100));
    maxlength_closing_reason := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.closing_reason)));
    avelength_closing_reason := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.closing_reason)),h.closing_reason<>(typeof(h.closing_reason))'');
    populated_closing_date_cnt := COUNT(GROUP,h.closing_date <> (TYPEOF(h.closing_date))'');
    populated_closing_date_pcnt := AVE(GROUP,IF(h.closing_date = (TYPEOF(h.closing_date))'',0,100));
    maxlength_closing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.closing_date)));
    avelength_closing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.closing_date)),h.closing_date<>(typeof(h.closing_date))'');
    populated_penalty_amount_cnt := COUNT(GROUP,h.penalty_amount <> (TYPEOF(h.penalty_amount))'');
    populated_penalty_amount_pcnt := AVE(GROUP,IF(h.penalty_amount = (TYPEOF(h.penalty_amount))'',0,100));
    maxlength_penalty_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.penalty_amount)));
    avelength_penalty_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.penalty_amount)),h.penalty_amount<>(typeof(h.penalty_amount))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dart_id_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_date_updated_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_plan_ein_pcnt *   0.00 / 100 + T.Populated_plan_no_pcnt *   0.00 / 100 + T.Populated_plan_year_pcnt *   0.00 / 100 + T.Populated_plan_name_pcnt *   0.00 / 100 + T.Populated_plan_administrator_pcnt *   0.00 / 100 + T.Populated_admin_state_pcnt *   0.00 / 100 + T.Populated_admin_zip_code_pcnt *   0.00 / 100 + T.Populated_admin_zip_code4_pcnt *   0.00 / 100 + T.Populated_closing_reason_pcnt *   0.00 / 100 + T.Populated_closing_date_pcnt *   0.00 / 100 + T.Populated_penalty_amount_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dart_id','date_added','date_updated','website','state','casetype','plan_ein','plan_no','plan_year','plan_name','plan_administrator','admin_state','admin_zip_code','admin_zip_code4','closing_reason','closing_date','penalty_amount');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dart_id_pcnt,le.populated_date_added_pcnt,le.populated_date_updated_pcnt,le.populated_website_pcnt,le.populated_state_pcnt,le.populated_casetype_pcnt,le.populated_plan_ein_pcnt,le.populated_plan_no_pcnt,le.populated_plan_year_pcnt,le.populated_plan_name_pcnt,le.populated_plan_administrator_pcnt,le.populated_admin_state_pcnt,le.populated_admin_zip_code_pcnt,le.populated_admin_zip_code4_pcnt,le.populated_closing_reason_pcnt,le.populated_closing_date_pcnt,le.populated_penalty_amount_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dart_id,le.maxlength_date_added,le.maxlength_date_updated,le.maxlength_website,le.maxlength_state,le.maxlength_casetype,le.maxlength_plan_ein,le.maxlength_plan_no,le.maxlength_plan_year,le.maxlength_plan_name,le.maxlength_plan_administrator,le.maxlength_admin_state,le.maxlength_admin_zip_code,le.maxlength_admin_zip_code4,le.maxlength_closing_reason,le.maxlength_closing_date,le.maxlength_penalty_amount);
  SELF.avelength := CHOOSE(C,le.avelength_dart_id,le.avelength_date_added,le.avelength_date_updated,le.avelength_website,le.avelength_state,le.avelength_casetype,le.avelength_plan_ein,le.avelength_plan_no,le.avelength_plan_year,le.avelength_plan_name,le.avelength_plan_administrator,le.avelength_admin_state,le.avelength_admin_zip_code,le.avelength_admin_zip_code4,le.avelength_closing_reason,le.avelength_closing_date,le.avelength_penalty_amount);
END;
EXPORT invSummary := NORMALIZE(summary0, 17, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dart_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.date_updated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.plan_ein),TRIM((SALT311.StrType)le.plan_no),TRIM((SALT311.StrType)le.plan_year),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.plan_administrator),TRIM((SALT311.StrType)le.admin_state),TRIM((SALT311.StrType)le.admin_zip_code),TRIM((SALT311.StrType)le.admin_zip_code4),TRIM((SALT311.StrType)le.closing_reason),TRIM((SALT311.StrType)le.closing_date),TRIM((SALT311.StrType)le.penalty_amount)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,17,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 17);
  SELF.FldNo2 := 1 + (C % 17);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dart_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.date_updated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.plan_ein),TRIM((SALT311.StrType)le.plan_no),TRIM((SALT311.StrType)le.plan_year),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.plan_administrator),TRIM((SALT311.StrType)le.admin_state),TRIM((SALT311.StrType)le.admin_zip_code),TRIM((SALT311.StrType)le.admin_zip_code4),TRIM((SALT311.StrType)le.closing_reason),TRIM((SALT311.StrType)le.closing_date),TRIM((SALT311.StrType)le.penalty_amount)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dart_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.date_updated),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.plan_ein),TRIM((SALT311.StrType)le.plan_no),TRIM((SALT311.StrType)le.plan_year),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.plan_administrator),TRIM((SALT311.StrType)le.admin_state),TRIM((SALT311.StrType)le.admin_zip_code),TRIM((SALT311.StrType)le.admin_zip_code4),TRIM((SALT311.StrType)le.closing_reason),TRIM((SALT311.StrType)le.closing_date),TRIM((SALT311.StrType)le.penalty_amount)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),17*17,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dart_id'}
      ,{2,'date_added'}
      ,{3,'date_updated'}
      ,{4,'website'}
      ,{5,'state'}
      ,{6,'casetype'}
      ,{7,'plan_ein'}
      ,{8,'plan_no'}
      ,{9,'plan_year'}
      ,{10,'plan_name'}
      ,{11,'plan_administrator'}
      ,{12,'admin_state'}
      ,{13,'admin_zip_code'}
      ,{14,'admin_zip_code4'}
      ,{15,'closing_reason'}
      ,{16,'closing_date'}
      ,{17,'penalty_amount'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dart_id((SALT311.StrType)le.dart_id),
    Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Fields.InValid_date_updated((SALT311.StrType)le.date_updated),
    Fields.InValid_website((SALT311.StrType)le.website),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_casetype((SALT311.StrType)le.casetype),
    Fields.InValid_plan_ein((SALT311.StrType)le.plan_ein),
    Fields.InValid_plan_no((SALT311.StrType)le.plan_no),
    Fields.InValid_plan_year((SALT311.StrType)le.plan_year),
    Fields.InValid_plan_name((SALT311.StrType)le.plan_name),
    Fields.InValid_plan_administrator((SALT311.StrType)le.plan_administrator),
    Fields.InValid_admin_state((SALT311.StrType)le.admin_state),
    Fields.InValid_admin_zip_code((SALT311.StrType)le.admin_zip_code),
    Fields.InValid_admin_zip_code4((SALT311.StrType)le.admin_zip_code4),
    Fields.InValid_closing_reason((SALT311.StrType)le.closing_reason),
    Fields.InValid_closing_date((SALT311.StrType)le.closing_date),
    Fields.InValid_penalty_amount((SALT311.StrType)le.penalty_amount),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,17,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_Float','Invalid_No','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Date','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dart_id(TotalErrors.ErrorNum),Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_date_updated(TotalErrors.ErrorNum),Fields.InValidMessage_website(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_casetype(TotalErrors.ErrorNum),Fields.InValidMessage_plan_ein(TotalErrors.ErrorNum),Fields.InValidMessage_plan_no(TotalErrors.ErrorNum),Fields.InValidMessage_plan_year(TotalErrors.ErrorNum),Fields.InValidMessage_plan_name(TotalErrors.ErrorNum),Fields.InValidMessage_plan_administrator(TotalErrors.ErrorNum),Fields.InValidMessage_admin_state(TotalErrors.ErrorNum),Fields.InValidMessage_admin_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_admin_zip_code4(TotalErrors.ErrorNum),Fields.InValidMessage_closing_reason(TotalErrors.ErrorNum),Fields.InValidMessage_closing_date(TotalErrors.ErrorNum),Fields.InValidMessage_penalty_amount(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LaborActions_EBSA, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
