IMPORT ut,SALT31;
EXPORT AH_hygiene(dataset(AH_layout_Business_Credit) h) := MODULE
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
    populated_previous_member_id_pcnt := AVE(GROUP,IF(h.previous_member_id = (TYPEOF(h.previous_member_id))'',0,100));
    maxlength_previous_member_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_member_id)));
    avelength_previous_member_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_member_id)),h.previous_member_id<>(typeof(h.previous_member_id))'');
    populated_previous_account_number_pcnt := AVE(GROUP,IF(h.previous_account_number = (TYPEOF(h.previous_account_number))'',0,100));
    maxlength_previous_account_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_account_number)));
    avelength_previous_account_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_account_number)),h.previous_account_number<>(typeof(h.previous_account_number))'');
    populated_previous_account_type_pcnt := AVE(GROUP,IF(h.previous_account_type = (TYPEOF(h.previous_account_type))'',0,100));
    maxlength_previous_account_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_account_type)));
    avelength_previous_account_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.previous_account_type)),h.previous_account_type<>(typeof(h.previous_account_type))'');
    populated_type_of_conversion_maintenance_pcnt := AVE(GROUP,IF(h.type_of_conversion_maintenance = (TYPEOF(h.type_of_conversion_maintenance))'',0,100));
    maxlength_type_of_conversion_maintenance := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_of_conversion_maintenance)));
    avelength_type_of_conversion_maintenance := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_of_conversion_maintenance)),h.type_of_conversion_maintenance<>(typeof(h.type_of_conversion_maintenance))'');
    populated_date_account_converted_pcnt := AVE(GROUP,IF(h.date_account_converted = (TYPEOF(h.date_account_converted))'',0,100));
    maxlength_date_account_converted := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_account_converted)));
    avelength_date_account_converted := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_account_converted)),h.date_account_converted<>(typeof(h.date_account_converted))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_previous_member_id_pcnt *   0.00 / 100 + T.Populated_previous_account_number_pcnt *   0.00 / 100 + T.Populated_previous_account_type_pcnt *   0.00 / 100 + T.Populated_type_of_conversion_maintenance_pcnt *   0.00 / 100 + T.Populated_date_account_converted_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','previous_member_id','previous_account_number','previous_account_type','type_of_conversion_maintenance','date_account_converted');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_previous_member_id_pcnt,le.populated_previous_account_number_pcnt,le.populated_previous_account_type_pcnt,le.populated_type_of_conversion_maintenance_pcnt,le.populated_date_account_converted_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_previous_member_id,le.maxlength_previous_account_number,le.maxlength_previous_account_type,le.maxlength_type_of_conversion_maintenance,le.maxlength_date_account_converted);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_previous_member_id,le.avelength_previous_account_number,le.avelength_previous_account_type,le.avelength_type_of_conversion_maintenance,le.avelength_date_account_converted);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.previous_member_id),TRIM((SALT31.StrType)le.previous_account_number),TRIM((SALT31.StrType)le.previous_account_type),TRIM((SALT31.StrType)le.type_of_conversion_maintenance),TRIM((SALT31.StrType)le.date_account_converted)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.previous_member_id),TRIM((SALT31.StrType)le.previous_account_number),TRIM((SALT31.StrType)le.previous_account_type),TRIM((SALT31.StrType)le.type_of_conversion_maintenance),TRIM((SALT31.StrType)le.date_account_converted)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.previous_member_id),TRIM((SALT31.StrType)le.previous_account_number),TRIM((SALT31.StrType)le.previous_account_type),TRIM((SALT31.StrType)le.type_of_conversion_maintenance),TRIM((SALT31.StrType)le.date_account_converted)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'previous_member_id'}
      ,{6,'previous_account_number'}
      ,{7,'previous_account_type'}
      ,{8,'type_of_conversion_maintenance'}
      ,{9,'date_account_converted'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AH_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    AH_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    AH_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    AH_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    AH_Fields.InValid_previous_member_id((SALT31.StrType)le.previous_member_id),
    AH_Fields.InValid_previous_account_number((SALT31.StrType)le.previous_account_number),
    AH_Fields.InValid_previous_account_type((SALT31.StrType)le.previous_account_type),
    AH_Fields.InValid_type_of_conversion_maintenance((SALT31.StrType)le.type_of_conversion_maintenance),
    AH_Fields.InValid_date_account_converted((SALT31.StrType)le.date_account_converted),
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
  FieldNme := AH_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_previous_member_id','invalid_previous_account_number','invalid_previous_account_number','invalid_type_of_conversion_maintenance','invalid_date_account_converted');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AH_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),AH_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),AH_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),AH_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),AH_Fields.InValidMessage_previous_member_id(TotalErrors.ErrorNum),AH_Fields.InValidMessage_previous_account_number(TotalErrors.ErrorNum),AH_Fields.InValidMessage_previous_account_type(TotalErrors.ErrorNum),AH_Fields.InValidMessage_type_of_conversion_maintenance(TotalErrors.ErrorNum),AH_Fields.InValidMessage_date_account_converted(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
