IMPORT ut,SALT33;
EXPORT MS_hygiene(dataset(MS_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_parent_sequence_number_pcnt := AVE(GROUP,IF(h.parent_sequence_number = (TYPEOF(h.parent_sequence_number))'',0,100));
    maxlength_parent_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)));
    avelength_parent_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)),h.parent_sequence_number<>(typeof(h.parent_sequence_number))'');
    populated_account_base_number_pcnt := AVE(GROUP,IF(h.account_base_number = (TYPEOF(h.account_base_number))'',0,100));
    maxlength_account_base_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_base_number)));
    avelength_account_base_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_base_number)),h.account_base_number<>(typeof(h.account_base_number))'');
    populated_name_of_value_pcnt := AVE(GROUP,IF(h.name_of_value = (TYPEOF(h.name_of_value))'',0,100));
    maxlength_name_of_value := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_of_value)));
    avelength_name_of_value := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_of_value)),h.name_of_value<>(typeof(h.name_of_value))'');
    populated_value_string_pcnt := AVE(GROUP,IF(h.value_string = (TYPEOF(h.value_string))'',0,100));
    maxlength_value_string := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.value_string)));
    avelength_value_string := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.value_string)),h.value_string<>(typeof(h.value_string))'');
    populated_privacy_indicator_pcnt := AVE(GROUP,IF(h.privacy_indicator = (TYPEOF(h.privacy_indicator))'',0,100));
    maxlength_privacy_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.privacy_indicator)));
    avelength_privacy_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.privacy_indicator)),h.privacy_indicator<>(typeof(h.privacy_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_name_of_value_pcnt *   0.00 / 100 + T.Populated_value_string_pcnt *   0.00 / 100 + T.Populated_privacy_indicator_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','name_of_value','value_string','privacy_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_name_of_value_pcnt,le.populated_value_string_pcnt,le.populated_privacy_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_name_of_value,le.maxlength_value_string,le.maxlength_privacy_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_name_of_value,le.avelength_value_string,le.avelength_privacy_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 7, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_base_number),TRIM((SALT33.StrType)le.name_of_value),TRIM((SALT33.StrType)le.value_string),TRIM((SALT33.StrType)le.privacy_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,7,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 7);
  SELF.FldNo2 := 1 + (C % 7);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_base_number),TRIM((SALT33.StrType)le.name_of_value),TRIM((SALT33.StrType)le.value_string),TRIM((SALT33.StrType)le.privacy_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_base_number),TRIM((SALT33.StrType)le.name_of_value),TRIM((SALT33.StrType)le.value_string),TRIM((SALT33.StrType)le.privacy_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),7*7,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'name_of_value'}
      ,{6,'value_string'}
      ,{7,'privacy_indicator'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    MS_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier),
    MS_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number),
    MS_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number),
    MS_Fields.InValid_account_base_number((SALT33.StrType)le.account_base_number),
    MS_Fields.InValid_name_of_value((SALT33.StrType)le.name_of_value),
    MS_Fields.InValid_value_string((SALT33.StrType)le.value_string),
    MS_Fields.InValid_privacy_indicator((SALT33.StrType)le.privacy_indicator),
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
  FieldNme := MS_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_name_of_value','invalid_valuenum','invalid_privacy_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,MS_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),MS_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),MS_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),MS_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),MS_Fields.InValidMessage_name_of_value(TotalErrors.ErrorNum),MS_Fields.InValidMessage_value_string(TotalErrors.ErrorNum),MS_Fields.InValidMessage_privacy_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
