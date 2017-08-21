IMPORT ut,SALT31;
EXPORT AD_hygiene(dataset(AD_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_parent_sequence_number_pcnt := AVE(GROUP,IF(h.parent_sequence_number = (TYPEOF(h.parent_sequence_number))'',0,100));
    maxlength_parent_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.parent_sequence_number)));
    avelength_parent_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.parent_sequence_number)),h.parent_sequence_number<>(typeof(h.parent_sequence_number))'');
    populated_account_base_number_pcnt := AVE(GROUP,IF(h.account_base_number = (TYPEOF(h.account_base_number))'',0,100));
    maxlength_account_base_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.account_base_number)));
    avelength_account_base_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.account_base_number)),h.account_base_number<>(typeof(h.account_base_number))'');
    populated_address_line_1_pcnt := AVE(GROUP,IF(h.address_line_1 = (TYPEOF(h.address_line_1))'',0,100));
    maxlength_address_line_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_line_1)));
    avelength_address_line_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_line_1)),h.address_line_1<>(typeof(h.address_line_1))'');
    populated_address_line_2_pcnt := AVE(GROUP,IF(h.address_line_2 = (TYPEOF(h.address_line_2))'',0,100));
    maxlength_address_line_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_line_2)));
    avelength_address_line_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_line_2)),h.address_line_2<>(typeof(h.address_line_2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_or_ca_postal_code_pcnt := AVE(GROUP,IF(h.zip_code_or_ca_postal_code = (TYPEOF(h.zip_code_or_ca_postal_code))'',0,100));
    maxlength_zip_code_or_ca_postal_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip_code_or_ca_postal_code)));
    avelength_zip_code_or_ca_postal_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip_code_or_ca_postal_code)),h.zip_code_or_ca_postal_code<>(typeof(h.zip_code_or_ca_postal_code))'');
    populated_postal_code_pcnt := AVE(GROUP,IF(h.postal_code = (TYPEOF(h.postal_code))'',0,100));
    maxlength_postal_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.postal_code)));
    avelength_postal_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.postal_code)),h.postal_code<>(typeof(h.postal_code))'');
    populated_country_code_pcnt := AVE(GROUP,IF(h.country_code = (TYPEOF(h.country_code))'',0,100));
    maxlength_country_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.country_code)));
    avelength_country_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.country_code)),h.country_code<>(typeof(h.country_code))'');
    populated_primary_address_indicator_pcnt := AVE(GROUP,IF(h.primary_address_indicator = (TYPEOF(h.primary_address_indicator))'',0,100));
    maxlength_primary_address_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_address_indicator)));
    avelength_primary_address_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_address_indicator)),h.primary_address_indicator<>(typeof(h.primary_address_indicator))'');
    populated_address_classification_pcnt := AVE(GROUP,IF(h.address_classification = (TYPEOF(h.address_classification))'',0,100));
    maxlength_address_classification := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_classification)));
    avelength_address_classification := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_classification)),h.address_classification<>(typeof(h.address_classification))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_address_line_1_pcnt *   0.00 / 100 + T.Populated_address_line_2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_or_ca_postal_code_pcnt *   0.00 / 100 + T.Populated_postal_code_pcnt *   0.00 / 100 + T.Populated_country_code_pcnt *   0.00 / 100 + T.Populated_primary_address_indicator_pcnt *   0.00 / 100 + T.Populated_address_classification_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','address_line_1','address_line_2','city','state','zip_code_or_ca_postal_code','postal_code','country_code','primary_address_indicator','address_classification');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_address_line_1_pcnt,le.populated_address_line_2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_or_ca_postal_code_pcnt,le.populated_postal_code_pcnt,le.populated_country_code_pcnt,le.populated_primary_address_indicator_pcnt,le.populated_address_classification_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_address_line_1,le.maxlength_address_line_2,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code_or_ca_postal_code,le.maxlength_postal_code,le.maxlength_country_code,le.maxlength_primary_address_indicator,le.maxlength_address_classification);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_address_line_1,le.avelength_address_line_2,le.avelength_city,le.avelength_state,le.avelength_zip_code_or_ca_postal_code,le.avelength_postal_code,le.avelength_country_code,le.avelength_primary_address_indicator,le.avelength_address_classification);
END;
EXPORT invSummary := NORMALIZE(summary0, 13, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.address_line_1),TRIM((SALT31.StrType)le.address_line_2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zip_code_or_ca_postal_code),TRIM((SALT31.StrType)le.postal_code),TRIM((SALT31.StrType)le.country_code),TRIM((SALT31.StrType)le.primary_address_indicator),TRIM((SALT31.StrType)le.address_classification)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,13,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 13);
  SELF.FldNo2 := 1 + (C % 13);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.address_line_1),TRIM((SALT31.StrType)le.address_line_2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zip_code_or_ca_postal_code),TRIM((SALT31.StrType)le.postal_code),TRIM((SALT31.StrType)le.country_code),TRIM((SALT31.StrType)le.primary_address_indicator),TRIM((SALT31.StrType)le.address_classification)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.address_line_1),TRIM((SALT31.StrType)le.address_line_2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zip_code_or_ca_postal_code),TRIM((SALT31.StrType)le.postal_code),TRIM((SALT31.StrType)le.country_code),TRIM((SALT31.StrType)le.primary_address_indicator),TRIM((SALT31.StrType)le.address_classification)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),13*13,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'address_line_1'}
      ,{6,'address_line_2'}
      ,{7,'city'}
      ,{8,'state'}
      ,{9,'zip_code_or_ca_postal_code'}
      ,{10,'postal_code'}
      ,{11,'country_code'}
      ,{12,'primary_address_indicator'}
      ,{13,'address_classification'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AD_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    AD_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    AD_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    AD_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    AD_Fields.InValid_address_line_1((SALT31.StrType)le.address_line_1),
    AD_Fields.InValid_address_line_2((SALT31.StrType)le.address_line_2),
    AD_Fields.InValid_city((SALT31.StrType)le.city),
    AD_Fields.InValid_state((SALT31.StrType)le.state),
    AD_Fields.InValid_zip_code_or_ca_postal_code((SALT31.StrType)le.zip_code_or_ca_postal_code),
    AD_Fields.InValid_postal_code((SALT31.StrType)le.postal_code),
    AD_Fields.InValid_country_code((SALT31.StrType)le.country_code),
    AD_Fields.InValid_primary_address_indicator((SALT31.StrType)le.primary_address_indicator),
    AD_Fields.InValid_address_classification((SALT31.StrType)le.address_classification),
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
  FieldNme := AD_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_address_line_1','invalid_address_line_2','invalid_city','invalid_state','invalid_zip_code_or_ca_postal_code','invalid_postal_code','invalid_country_code','invalid_primary_address_indicator','invalid_address_classification');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AD_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),AD_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),AD_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),AD_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),AD_Fields.InValidMessage_address_line_1(TotalErrors.ErrorNum),AD_Fields.InValidMessage_address_line_2(TotalErrors.ErrorNum),AD_Fields.InValidMessage_city(TotalErrors.ErrorNum),AD_Fields.InValidMessage_state(TotalErrors.ErrorNum),AD_Fields.InValidMessage_zip_code_or_ca_postal_code(TotalErrors.ErrorNum),AD_Fields.InValidMessage_postal_code(TotalErrors.ErrorNum),AD_Fields.InValidMessage_country_code(TotalErrors.ErrorNum),AD_Fields.InValidMessage_primary_address_indicator(TotalErrors.ErrorNum),AD_Fields.InValidMessage_address_classification(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
