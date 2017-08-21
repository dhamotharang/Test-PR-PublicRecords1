IMPORT ut,SALT31;
EXPORT BI_hygiene(dataset(BI_layout_Business_Credit) h) := MODULE
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
    populated_classification_code_type_pcnt := AVE(GROUP,IF(h.classification_code_type = (TYPEOF(h.classification_code_type))'',0,100));
    maxlength_classification_code_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.classification_code_type)));
    avelength_classification_code_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.classification_code_type)),h.classification_code_type<>(typeof(h.classification_code_type))'');
    populated_classification_code_pcnt := AVE(GROUP,IF(h.classification_code = (TYPEOF(h.classification_code))'',0,100));
    maxlength_classification_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.classification_code)));
    avelength_classification_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.classification_code)),h.classification_code<>(typeof(h.classification_code))'');
    populated_primary_industry_code_indicator_pcnt := AVE(GROUP,IF(h.primary_industry_code_indicator = (TYPEOF(h.primary_industry_code_indicator))'',0,100));
    maxlength_primary_industry_code_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_industry_code_indicator)));
    avelength_primary_industry_code_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_industry_code_indicator)),h.primary_industry_code_indicator<>(typeof(h.primary_industry_code_indicator))'');
    populated_privacy_indicator_pcnt := AVE(GROUP,IF(h.privacy_indicator = (TYPEOF(h.privacy_indicator))'',0,100));
    maxlength_privacy_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.privacy_indicator)));
    avelength_privacy_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.privacy_indicator)),h.privacy_indicator<>(typeof(h.privacy_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_classification_code_type_pcnt *   0.00 / 100 + T.Populated_classification_code_pcnt *   0.00 / 100 + T.Populated_primary_industry_code_indicator_pcnt *   0.00 / 100 + T.Populated_privacy_indicator_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','classification_code_type','classification_code','primary_industry_code_indicator','privacy_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_classification_code_type_pcnt,le.populated_classification_code_pcnt,le.populated_primary_industry_code_indicator_pcnt,le.populated_privacy_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_classification_code_type,le.maxlength_classification_code,le.maxlength_primary_industry_code_indicator,le.maxlength_privacy_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_classification_code_type,le.avelength_classification_code,le.avelength_primary_industry_code_indicator,le.avelength_privacy_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.classification_code_type),TRIM((SALT31.StrType)le.classification_code),TRIM((SALT31.StrType)le.primary_industry_code_indicator),TRIM((SALT31.StrType)le.privacy_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.classification_code_type),TRIM((SALT31.StrType)le.classification_code),TRIM((SALT31.StrType)le.primary_industry_code_indicator),TRIM((SALT31.StrType)le.privacy_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.classification_code_type),TRIM((SALT31.StrType)le.classification_code),TRIM((SALT31.StrType)le.primary_industry_code_indicator),TRIM((SALT31.StrType)le.privacy_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'classification_code_type'}
      ,{6,'classification_code'}
      ,{7,'primary_industry_code_indicator'}
      ,{8,'privacy_indicator'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BI_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    BI_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    BI_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    BI_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    BI_Fields.InValid_classification_code_type((SALT31.StrType)le.classification_code_type),
    BI_Fields.InValid_classification_code((SALT31.StrType)le.classification_code),
    BI_Fields.InValid_primary_industry_code_indicator((SALT31.StrType)le.primary_industry_code_indicator),
    BI_Fields.InValid_privacy_indicator((SALT31.StrType)le.privacy_indicator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BI_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_classification_code_type','invalid_classification_code','invalid_primary_industry_code_indicator','invalid_privacy_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BI_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),BI_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),BI_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),BI_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),BI_Fields.InValidMessage_classification_code_type(TotalErrors.ErrorNum),BI_Fields.InValidMessage_classification_code(TotalErrors.ErrorNum),BI_Fields.InValidMessage_primary_industry_code_indicator(TotalErrors.ErrorNum),BI_Fields.InValidMessage_privacy_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
