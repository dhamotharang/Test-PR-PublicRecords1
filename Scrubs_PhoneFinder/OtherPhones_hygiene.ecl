IMPORT SALT311,STD;
EXPORT OtherPhones_hygiene(dataset(OtherPhones_layout_PhoneFinder) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_sequence_number_cnt := COUNT(GROUP,h.sequence_number <> (TYPEOF(h.sequence_number))'');
    populated_sequence_number_pcnt := AVE(GROUP,IF(h.sequence_number = (TYPEOF(h.sequence_number))'',0,100));
    maxlength_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)));
    avelength_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)),h.sequence_number<>(typeof(h.sequence_number))'');
    populated_phone_id_cnt := COUNT(GROUP,h.phone_id <> (TYPEOF(h.phone_id))'');
    populated_phone_id_pcnt := AVE(GROUP,IF(h.phone_id = (TYPEOF(h.phone_id))'',0,100));
    maxlength_phone_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)));
    avelength_phone_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)),h.phone_id<>(typeof(h.phone_id))'');
    populated_phonenumber_cnt := COUNT(GROUP,h.phonenumber <> (TYPEOF(h.phonenumber))'');
    populated_phonenumber_pcnt := AVE(GROUP,IF(h.phonenumber = (TYPEOF(h.phonenumber))'',0,100));
    maxlength_phonenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)));
    avelength_phonenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)),h.phonenumber<>(typeof(h.phonenumber))'');
    populated_risk_indicator_cnt := COUNT(GROUP,h.risk_indicator <> (TYPEOF(h.risk_indicator))'');
    populated_risk_indicator_pcnt := AVE(GROUP,IF(h.risk_indicator = (TYPEOF(h.risk_indicator))'',0,100));
    maxlength_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator)));
    avelength_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator)),h.risk_indicator<>(typeof(h.risk_indicator))'');
    populated_phone_type_cnt := COUNT(GROUP,h.phone_type <> (TYPEOF(h.phone_type))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_phone_status_cnt := COUNT(GROUP,h.phone_status <> (TYPEOF(h.phone_status))'');
    populated_phone_status_pcnt := AVE(GROUP,IF(h.phone_status = (TYPEOF(h.phone_status))'',0,100));
    maxlength_phone_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_status)));
    avelength_phone_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_status)),h.phone_status<>(typeof(h.phone_status))'');
    populated_listing_name_cnt := COUNT(GROUP,h.listing_name <> (TYPEOF(h.listing_name))'');
    populated_listing_name_pcnt := AVE(GROUP,IF(h.listing_name = (TYPEOF(h.listing_name))'',0,100));
    maxlength_listing_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_name)));
    avelength_listing_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_name)),h.listing_name<>(typeof(h.listing_name))'');
    populated_porting_code_cnt := COUNT(GROUP,h.porting_code <> (TYPEOF(h.porting_code))'');
    populated_porting_code_pcnt := AVE(GROUP,IF(h.porting_code = (TYPEOF(h.porting_code))'',0,100));
    maxlength_porting_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.porting_code)));
    avelength_porting_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.porting_code)),h.porting_code<>(typeof(h.porting_code))'');
    populated_phone_forwarded_cnt := COUNT(GROUP,h.phone_forwarded <> (TYPEOF(h.phone_forwarded))'');
    populated_phone_forwarded_pcnt := AVE(GROUP,IF(h.phone_forwarded = (TYPEOF(h.phone_forwarded))'',0,100));
    maxlength_phone_forwarded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_forwarded)));
    avelength_phone_forwarded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_forwarded)),h.phone_forwarded<>(typeof(h.phone_forwarded))'');
    populated_verified_carrier_cnt := COUNT(GROUP,h.verified_carrier <> (TYPEOF(h.verified_carrier))'');
    populated_verified_carrier_pcnt := AVE(GROUP,IF(h.verified_carrier = (TYPEOF(h.verified_carrier))'',0,100));
    maxlength_verified_carrier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_carrier)));
    avelength_verified_carrier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_carrier)),h.verified_carrier<>(typeof(h.verified_carrier))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_identity_count_cnt := COUNT(GROUP,h.identity_count <> (TYPEOF(h.identity_count))'');
    populated_identity_count_pcnt := AVE(GROUP,IF(h.identity_count = (TYPEOF(h.identity_count))'',0,100));
    maxlength_identity_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_count)));
    avelength_identity_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_count)),h.identity_count<>(typeof(h.identity_count))'');
    populated_carrier_cnt := COUNT(GROUP,h.carrier <> (TYPEOF(h.carrier))'');
    populated_carrier_pcnt := AVE(GROUP,IF(h.carrier = (TYPEOF(h.carrier))'',0,100));
    maxlength_carrier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier)));
    avelength_carrier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier)),h.carrier<>(typeof(h.carrier))'');
    populated_phone_star_rating_cnt := COUNT(GROUP,h.phone_star_rating <> (TYPEOF(h.phone_star_rating))'');
    populated_phone_star_rating_pcnt := AVE(GROUP,IF(h.phone_star_rating = (TYPEOF(h.phone_star_rating))'',0,100));
    maxlength_phone_star_rating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_star_rating)));
    avelength_phone_star_rating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_star_rating)),h.phone_star_rating<>(typeof(h.phone_star_rating))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_phone_id_pcnt *   0.00 / 100 + T.Populated_phonenumber_pcnt *   0.00 / 100 + T.Populated_risk_indicator_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_phone_status_pcnt *   0.00 / 100 + T.Populated_listing_name_pcnt *   0.00 / 100 + T.Populated_porting_code_pcnt *   0.00 / 100 + T.Populated_phone_forwarded_pcnt *   0.00 / 100 + T.Populated_verified_carrier_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_identity_count_pcnt *   0.00 / 100 + T.Populated_carrier_pcnt *   0.00 / 100 + T.Populated_phone_star_rating_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'transaction_id','sequence_number','phone_id','phonenumber','risk_indicator','phone_type','phone_status','listing_name','porting_code','phone_forwarded','verified_carrier','date_added','identity_count','carrier','phone_star_rating','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_transaction_id_pcnt,le.populated_sequence_number_pcnt,le.populated_phone_id_pcnt,le.populated_phonenumber_pcnt,le.populated_risk_indicator_pcnt,le.populated_phone_type_pcnt,le.populated_phone_status_pcnt,le.populated_listing_name_pcnt,le.populated_porting_code_pcnt,le.populated_phone_forwarded_pcnt,le.populated_verified_carrier_pcnt,le.populated_date_added_pcnt,le.populated_identity_count_pcnt,le.populated_carrier_pcnt,le.populated_phone_star_rating_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_transaction_id,le.maxlength_sequence_number,le.maxlength_phone_id,le.maxlength_phonenumber,le.maxlength_risk_indicator,le.maxlength_phone_type,le.maxlength_phone_status,le.maxlength_listing_name,le.maxlength_porting_code,le.maxlength_phone_forwarded,le.maxlength_verified_carrier,le.maxlength_date_added,le.maxlength_identity_count,le.maxlength_carrier,le.maxlength_phone_star_rating,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_transaction_id,le.avelength_sequence_number,le.avelength_phone_id,le.avelength_phonenumber,le.avelength_risk_indicator,le.avelength_phone_type,le.avelength_phone_status,le.avelength_listing_name,le.avelength_porting_code,le.avelength_phone_forwarded,le.avelength_verified_carrier,le.avelength_date_added,le.avelength_identity_count,le.avelength_carrier,le.avelength_phone_star_rating,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 16, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),TRIM((SALT311.StrType)le.listing_name),TRIM((SALT311.StrType)le.porting_code),TRIM((SALT311.StrType)le.phone_forwarded),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,16,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 16);
  SELF.FldNo2 := 1 + (C % 16);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),TRIM((SALT311.StrType)le.listing_name),TRIM((SALT311.StrType)le.porting_code),TRIM((SALT311.StrType)le.phone_forwarded),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),TRIM((SALT311.StrType)le.listing_name),TRIM((SALT311.StrType)le.porting_code),TRIM((SALT311.StrType)le.phone_forwarded),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),16*16,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'transaction_id'}
      ,{2,'sequence_number'}
      ,{3,'phone_id'}
      ,{4,'phonenumber'}
      ,{5,'risk_indicator'}
      ,{6,'phone_type'}
      ,{7,'phone_status'}
      ,{8,'listing_name'}
      ,{9,'porting_code'}
      ,{10,'phone_forwarded'}
      ,{11,'verified_carrier'}
      ,{12,'date_added'}
      ,{13,'identity_count'}
      ,{14,'carrier'}
      ,{15,'phone_star_rating'}
      ,{16,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    OtherPhones_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    OtherPhones_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    OtherPhones_Fields.InValid_phone_id((SALT311.StrType)le.phone_id),
    OtherPhones_Fields.InValid_phonenumber((SALT311.StrType)le.phonenumber),
    OtherPhones_Fields.InValid_risk_indicator((SALT311.StrType)le.risk_indicator),
    OtherPhones_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    OtherPhones_Fields.InValid_phone_status((SALT311.StrType)le.phone_status),
    OtherPhones_Fields.InValid_listing_name((SALT311.StrType)le.listing_name),
    OtherPhones_Fields.InValid_porting_code((SALT311.StrType)le.porting_code),
    OtherPhones_Fields.InValid_phone_forwarded((SALT311.StrType)le.phone_forwarded),
    OtherPhones_Fields.InValid_verified_carrier((SALT311.StrType)le.verified_carrier),
    OtherPhones_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    OtherPhones_Fields.InValid_identity_count((SALT311.StrType)le.identity_count),
    OtherPhones_Fields.InValid_carrier((SALT311.StrType)le.carrier),
    OtherPhones_Fields.InValid_phone_star_rating((SALT311.StrType)le.phone_star_rating),
    OtherPhones_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,16,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := OtherPhones_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_ID','Invalid_No','Invalid_No','Invalid_Phone','Invalid_Risk','Invalid_Type','Invalid_Status','Invalid_AlphaChar','Invalid_Port','Invalid_AlphaChar','Invalid_No','Invalid_Date','Invalid_No','Unknown','Invalid_Rating','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,OtherPhones_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phone_id(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phonenumber(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_risk_indicator(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phone_status(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_listing_name(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_porting_code(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phone_forwarded(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_verified_carrier(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_identity_count(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_carrier(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_phone_star_rating(TotalErrors.ErrorNum),OtherPhones_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, OtherPhones_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
