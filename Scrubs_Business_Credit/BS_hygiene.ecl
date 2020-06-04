IMPORT SALT311,STD;
EXPORT BS_hygiene(dataset(BS_layout_Business_Credit) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_cnt := COUNT(GROUP,h.segment_identifier <> (TYPEOF(h.segment_identifier))'');
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_cnt := COUNT(GROUP,h.file_sequence_number <> (TYPEOF(h.file_sequence_number))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_parent_sequence_number_cnt := COUNT(GROUP,h.parent_sequence_number <> (TYPEOF(h.parent_sequence_number))'');
    populated_parent_sequence_number_pcnt := AVE(GROUP,IF(h.parent_sequence_number = (TYPEOF(h.parent_sequence_number))'',0,100));
    maxlength_parent_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parent_sequence_number)));
    avelength_parent_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parent_sequence_number)),h.parent_sequence_number<>(typeof(h.parent_sequence_number))'');
    populated_account_base_number_cnt := COUNT(GROUP,h.account_base_number <> (TYPEOF(h.account_base_number))'');
    populated_account_base_number_pcnt := AVE(GROUP,IF(h.account_base_number = (TYPEOF(h.account_base_number))'',0,100));
    maxlength_account_base_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_base_number)));
    avelength_account_base_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_base_number)),h.account_base_number<>(typeof(h.account_base_number))'');
    populated_business_name_cnt := COUNT(GROUP,h.business_name <> (TYPEOF(h.business_name))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_web_address_cnt := COUNT(GROUP,h.web_address <> (TYPEOF(h.web_address))'');
    populated_web_address_pcnt := AVE(GROUP,IF(h.web_address = (TYPEOF(h.web_address))'',0,100));
    maxlength_web_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)));
    avelength_web_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)),h.web_address<>(typeof(h.web_address))'');
    populated_guarantor_owner_indicator_cnt := COUNT(GROUP,h.guarantor_owner_indicator <> (TYPEOF(h.guarantor_owner_indicator))'');
    populated_guarantor_owner_indicator_pcnt := AVE(GROUP,IF(h.guarantor_owner_indicator = (TYPEOF(h.guarantor_owner_indicator))'',0,100));
    maxlength_guarantor_owner_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guarantor_owner_indicator)));
    avelength_guarantor_owner_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guarantor_owner_indicator)),h.guarantor_owner_indicator<>(typeof(h.guarantor_owner_indicator))'');
    populated_relationship_to_business_indicator_cnt := COUNT(GROUP,h.relationship_to_business_indicator <> (TYPEOF(h.relationship_to_business_indicator))'');
    populated_relationship_to_business_indicator_pcnt := AVE(GROUP,IF(h.relationship_to_business_indicator = (TYPEOF(h.relationship_to_business_indicator))'',0,100));
    maxlength_relationship_to_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_to_business_indicator)));
    avelength_relationship_to_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_to_business_indicator)),h.relationship_to_business_indicator<>(typeof(h.relationship_to_business_indicator))'');
    populated_percent_of_liability_cnt := COUNT(GROUP,h.percent_of_liability <> (TYPEOF(h.percent_of_liability))'');
    populated_percent_of_liability_pcnt := AVE(GROUP,IF(h.percent_of_liability = (TYPEOF(h.percent_of_liability))'',0,100));
    maxlength_percent_of_liability := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_of_liability)));
    avelength_percent_of_liability := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_of_liability)),h.percent_of_liability<>(typeof(h.percent_of_liability))'');
    populated_percent_of_ownership_if_owner_principal_cnt := COUNT(GROUP,h.percent_of_ownership_if_owner_principal <> (TYPEOF(h.percent_of_ownership_if_owner_principal))'');
    populated_percent_of_ownership_if_owner_principal_pcnt := AVE(GROUP,IF(h.percent_of_ownership_if_owner_principal = (TYPEOF(h.percent_of_ownership_if_owner_principal))'',0,100));
    maxlength_percent_of_ownership_if_owner_principal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_of_ownership_if_owner_principal)));
    avelength_percent_of_ownership_if_owner_principal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_of_ownership_if_owner_principal)),h.percent_of_ownership_if_owner_principal<>(typeof(h.percent_of_ownership_if_owner_principal))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_web_address_pcnt *   0.00 / 100 + T.Populated_guarantor_owner_indicator_pcnt *   0.00 / 100 + T.Populated_relationship_to_business_indicator_pcnt *   0.00 / 100 + T.Populated_percent_of_liability_pcnt *   0.00 / 100 + T.Populated_percent_of_ownership_if_owner_principal_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','business_name','web_address','guarantor_owner_indicator','relationship_to_business_indicator','percent_of_liability','percent_of_ownership_if_owner_principal');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_business_name_pcnt,le.populated_web_address_pcnt,le.populated_guarantor_owner_indicator_pcnt,le.populated_relationship_to_business_indicator_pcnt,le.populated_percent_of_liability_pcnt,le.populated_percent_of_ownership_if_owner_principal_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_business_name,le.maxlength_web_address,le.maxlength_guarantor_owner_indicator,le.maxlength_relationship_to_business_indicator,le.maxlength_percent_of_liability,le.maxlength_percent_of_ownership_if_owner_principal);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_business_name,le.avelength_web_address,le.avelength_guarantor_owner_indicator,le.avelength_relationship_to_business_indicator,le.avelength_percent_of_liability,le.avelength_percent_of_ownership_if_owner_principal);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.segment_identifier),TRIM((SALT311.StrType)le.file_sequence_number),TRIM((SALT311.StrType)le.parent_sequence_number),TRIM((SALT311.StrType)le.account_base_number),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.guarantor_owner_indicator),TRIM((SALT311.StrType)le.relationship_to_business_indicator),TRIM((SALT311.StrType)le.percent_of_liability),TRIM((SALT311.StrType)le.percent_of_ownership_if_owner_principal)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.segment_identifier),TRIM((SALT311.StrType)le.file_sequence_number),TRIM((SALT311.StrType)le.parent_sequence_number),TRIM((SALT311.StrType)le.account_base_number),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.guarantor_owner_indicator),TRIM((SALT311.StrType)le.relationship_to_business_indicator),TRIM((SALT311.StrType)le.percent_of_liability),TRIM((SALT311.StrType)le.percent_of_ownership_if_owner_principal)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.segment_identifier),TRIM((SALT311.StrType)le.file_sequence_number),TRIM((SALT311.StrType)le.parent_sequence_number),TRIM((SALT311.StrType)le.account_base_number),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.guarantor_owner_indicator),TRIM((SALT311.StrType)le.relationship_to_business_indicator),TRIM((SALT311.StrType)le.percent_of_liability),TRIM((SALT311.StrType)le.percent_of_ownership_if_owner_principal)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'business_name'}
      ,{6,'web_address'}
      ,{7,'guarantor_owner_indicator'}
      ,{8,'relationship_to_business_indicator'}
      ,{9,'percent_of_liability'}
      ,{10,'percent_of_ownership_if_owner_principal'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BS_Fields.InValid_segment_identifier((SALT311.StrType)le.segment_identifier),
    BS_Fields.InValid_file_sequence_number((SALT311.StrType)le.file_sequence_number),
    BS_Fields.InValid_parent_sequence_number((SALT311.StrType)le.parent_sequence_number),
    BS_Fields.InValid_account_base_number((SALT311.StrType)le.account_base_number),
    BS_Fields.InValid_business_name((SALT311.StrType)le.business_name),
    BS_Fields.InValid_web_address((SALT311.StrType)le.web_address),
    BS_Fields.InValid_guarantor_owner_indicator((SALT311.StrType)le.guarantor_owner_indicator),
    BS_Fields.InValid_relationship_to_business_indicator((SALT311.StrType)le.relationship_to_business_indicator),
    BS_Fields.InValid_percent_of_liability((SALT311.StrType)le.percent_of_liability),
    BS_Fields.InValid_percent_of_ownership_if_owner_principal((SALT311.StrType)le.percent_of_ownership_if_owner_principal),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BS_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_business_name','invalid_web_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_percent_of_liability','invalid_percent_of_ownership_if_owner_principal');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BS_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),BS_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),BS_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),BS_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),BS_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),BS_Fields.InValidMessage_web_address(TotalErrors.ErrorNum),BS_Fields.InValidMessage_guarantor_owner_indicator(TotalErrors.ErrorNum),BS_Fields.InValidMessage_relationship_to_business_indicator(TotalErrors.ErrorNum),BS_Fields.InValidMessage_percent_of_liability(TotalErrors.ErrorNum),BS_Fields.InValidMessage_percent_of_ownership_if_owner_principal(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Business_Credit, BS_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
