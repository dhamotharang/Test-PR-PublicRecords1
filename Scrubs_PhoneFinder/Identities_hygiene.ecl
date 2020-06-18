IMPORT SALT311,STD;
EXPORT Identities_hygiene(dataset(Identities_layout_PhoneFinder) h) := MODULE
 
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
    populated_lexid_cnt := COUNT(GROUP,h.lexid <> (TYPEOF(h.lexid))'');
    populated_lexid_pcnt := AVE(GROUP,IF(h.lexid = (TYPEOF(h.lexid))'',0,100));
    maxlength_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)));
    avelength_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)),h.lexid<>(typeof(h.lexid))'');
    populated_full_name_cnt := COUNT(GROUP,h.full_name <> (TYPEOF(h.full_name))'');
    populated_full_name_pcnt := AVE(GROUP,IF(h.full_name = (TYPEOF(h.full_name))'',0,100));
    maxlength_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)));
    avelength_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)),h.full_name<>(typeof(h.full_name))'');
    populated_full_address_cnt := COUNT(GROUP,h.full_address <> (TYPEOF(h.full_address))'');
    populated_full_address_pcnt := AVE(GROUP,IF(h.full_address = (TYPEOF(h.full_address))'',0,100));
    maxlength_full_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_address)));
    avelength_full_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_address)),h.full_address<>(typeof(h.full_address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_verified_carrier_cnt := COUNT(GROUP,h.verified_carrier <> (TYPEOF(h.verified_carrier))'');
    populated_verified_carrier_pcnt := AVE(GROUP,IF(h.verified_carrier = (TYPEOF(h.verified_carrier))'',0,100));
    maxlength_verified_carrier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_carrier)));
    avelength_verified_carrier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_carrier)),h.verified_carrier<>(typeof(h.verified_carrier))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_lexid_pcnt *   0.00 / 100 + T.Populated_full_name_pcnt *   0.00 / 100 + T.Populated_full_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_verified_carrier_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'transaction_id','sequence_number','lexid','full_name','full_address','city','state','zip','verified_carrier','date_added','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_transaction_id_pcnt,le.populated_sequence_number_pcnt,le.populated_lexid_pcnt,le.populated_full_name_pcnt,le.populated_full_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_verified_carrier_pcnt,le.populated_date_added_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_transaction_id,le.maxlength_sequence_number,le.maxlength_lexid,le.maxlength_full_name,le.maxlength_full_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_verified_carrier,le.maxlength_date_added,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_transaction_id,le.avelength_sequence_number,le.avelength_lexid,le.avelength_full_name,le.avelength_full_address,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_verified_carrier,le.avelength_date_added,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.lexid),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.lexid),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.transaction_id),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.lexid),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),IF (le.verified_carrier <> 0,TRIM((SALT311.StrType)le.verified_carrier), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'transaction_id'}
      ,{2,'sequence_number'}
      ,{3,'lexid'}
      ,{4,'full_name'}
      ,{5,'full_address'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'zip'}
      ,{9,'verified_carrier'}
      ,{10,'date_added'}
      ,{11,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Identities_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    Identities_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Identities_Fields.InValid_lexid((SALT311.StrType)le.lexid),
    Identities_Fields.InValid_full_name((SALT311.StrType)le.full_name),
    Identities_Fields.InValid_full_address((SALT311.StrType)le.full_address),
    Identities_Fields.InValid_city((SALT311.StrType)le.city),
    Identities_Fields.InValid_state((SALT311.StrType)le.state),
    Identities_Fields.InValid_zip((SALT311.StrType)le.zip),
    Identities_Fields.InValid_verified_carrier((SALT311.StrType)le.verified_carrier),
    Identities_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Identities_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Identities_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_ID','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Date','Invalid_File');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Identities_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_lexid(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_full_name(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_full_address(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_city(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_state(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_verified_carrier(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Identities_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Identities_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
