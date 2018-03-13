IMPORT SALT39,STD;
EXPORT LIDBReceived_hygiene(dataset(LIDBReceived_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_reference_id_cnt := COUNT(GROUP,h.reference_id <> (TYPEOF(h.reference_id))'');
    populated_reference_id_pcnt := AVE(GROUP,IF(h.reference_id = (TYPEOF(h.reference_id))'',0,100));
    maxlength_reference_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.reference_id)));
    avelength_reference_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.reference_id)),h.reference_id<>(typeof(h.reference_id))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_reply_code_cnt := COUNT(GROUP,h.reply_code <> (TYPEOF(h.reply_code))'');
    populated_reply_code_pcnt := AVE(GROUP,IF(h.reply_code = (TYPEOF(h.reply_code))'',0,100));
    maxlength_reply_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.reply_code)));
    avelength_reply_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.reply_code)),h.reply_code<>(typeof(h.reply_code))'');
    populated_local_routing_number_cnt := COUNT(GROUP,h.local_routing_number <> (TYPEOF(h.local_routing_number))'');
    populated_local_routing_number_pcnt := AVE(GROUP,IF(h.local_routing_number = (TYPEOF(h.local_routing_number))'',0,100));
    maxlength_local_routing_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_routing_number)));
    avelength_local_routing_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_routing_number)),h.local_routing_number<>(typeof(h.local_routing_number))'');
    populated_account_owner_cnt := COUNT(GROUP,h.account_owner <> (TYPEOF(h.account_owner))'');
    populated_account_owner_pcnt := AVE(GROUP,IF(h.account_owner = (TYPEOF(h.account_owner))'',0,100));
    maxlength_account_owner := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.account_owner)));
    avelength_account_owner := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.account_owner)),h.account_owner<>(typeof(h.account_owner))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_carrier_category_cnt := COUNT(GROUP,h.carrier_category <> (TYPEOF(h.carrier_category))'');
    populated_carrier_category_pcnt := AVE(GROUP,IF(h.carrier_category = (TYPEOF(h.carrier_category))'',0,100));
    maxlength_carrier_category := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_category)));
    avelength_carrier_category := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_category)),h.carrier_category<>(typeof(h.carrier_category))'');
    populated_local_area_transport_area_cnt := COUNT(GROUP,h.local_area_transport_area <> (TYPEOF(h.local_area_transport_area))'');
    populated_local_area_transport_area_pcnt := AVE(GROUP,IF(h.local_area_transport_area = (TYPEOF(h.local_area_transport_area))'',0,100));
    maxlength_local_area_transport_area := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_area_transport_area)));
    avelength_local_area_transport_area := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_area_transport_area)),h.local_area_transport_area<>(typeof(h.local_area_transport_area))'');
    populated_point_code_cnt := COUNT(GROUP,h.point_code <> (TYPEOF(h.point_code))'');
    populated_point_code_pcnt := AVE(GROUP,IF(h.point_code = (TYPEOF(h.point_code))'',0,100));
    maxlength_point_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.point_code)));
    avelength_point_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.point_code)),h.point_code<>(typeof(h.point_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_reply_code_pcnt *   0.00 / 100 + T.Populated_local_routing_number_pcnt *   0.00 / 100 + T.Populated_account_owner_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_carrier_category_pcnt *   0.00 / 100 + T.Populated_local_area_transport_area_pcnt *   0.00 / 100 + T.Populated_point_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'reference_id','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_reference_id_pcnt,le.populated_phone_pcnt,le.populated_reply_code_pcnt,le.populated_local_routing_number_pcnt,le.populated_account_owner_pcnt,le.populated_carrier_name_pcnt,le.populated_carrier_category_pcnt,le.populated_local_area_transport_area_pcnt,le.populated_point_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_reference_id,le.maxlength_phone,le.maxlength_reply_code,le.maxlength_local_routing_number,le.maxlength_account_owner,le.maxlength_carrier_name,le.maxlength_carrier_category,le.maxlength_local_area_transport_area,le.maxlength_point_code);
  SELF.avelength := CHOOSE(C,le.avelength_reference_id,le.avelength_phone,le.avelength_reply_code,le.avelength_local_routing_number,le.avelength_account_owner,le.avelength_carrier_name,le.avelength_carrier_category,le.avelength_local_area_transport_area,le.avelength_point_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.reference_id),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.reference_id),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.reference_id),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'reference_id'}
      ,{2,'phone'}
      ,{3,'reply_code'}
      ,{4,'local_routing_number'}
      ,{5,'account_owner'}
      ,{6,'carrier_name'}
      ,{7,'carrier_category'}
      ,{8,'local_area_transport_area'}
      ,{9,'point_code'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    LIDBReceived_Fields.InValid_reference_id((SALT39.StrType)le.reference_id),
    LIDBReceived_Fields.InValid_phone((SALT39.StrType)le.phone),
    LIDBReceived_Fields.InValid_reply_code((SALT39.StrType)le.reply_code),
    LIDBReceived_Fields.InValid_local_routing_number((SALT39.StrType)le.local_routing_number),
    LIDBReceived_Fields.InValid_account_owner((SALT39.StrType)le.account_owner),
    LIDBReceived_Fields.InValid_carrier_name((SALT39.StrType)le.carrier_name),
    LIDBReceived_Fields.InValid_carrier_category((SALT39.StrType)le.carrier_category),
    LIDBReceived_Fields.InValid_local_area_transport_area((SALT39.StrType)le.local_area_transport_area),
    LIDBReceived_Fields.InValid_point_code((SALT39.StrType)le.point_code),
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
  FieldNme := LIDBReceived_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_RefID','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AccOwn','Invalid_Char','Invalid_Char','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,LIDBReceived_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_phone(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_reply_code(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_local_routing_number(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_account_owner(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_carrier_category(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_local_area_transport_area(TotalErrors.ErrorNum),LIDBReceived_Fields.InValidMessage_point_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, LIDBReceived_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
