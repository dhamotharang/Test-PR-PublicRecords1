IMPORT ut,SALT31;
EXPORT FA_hygiene(dataset(FA_layout_Business_Credit) h) := MODULE
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
    populated_test_or_production_indicator_pcnt := AVE(GROUP,IF(h.test_or_production_indicator = (TYPEOF(h.test_or_production_indicator))'',0,100));
    maxlength_test_or_production_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.test_or_production_indicator)));
    avelength_test_or_production_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.test_or_production_indicator)),h.test_or_production_indicator<>(typeof(h.test_or_production_indicator))'');
    populated_file_type_indicator_pcnt := AVE(GROUP,IF(h.file_type_indicator = (TYPEOF(h.file_type_indicator))'',0,100));
    maxlength_file_type_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_type_indicator)));
    avelength_file_type_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_type_indicator)),h.file_type_indicator<>(typeof(h.file_type_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_test_or_production_indicator_pcnt *   0.00 / 100 + T.Populated_file_type_indicator_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','test_or_production_indicator','file_type_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_test_or_production_indicator_pcnt,le.populated_file_type_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_test_or_production_indicator,le.maxlength_file_type_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_test_or_production_indicator,le.avelength_file_type_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.test_or_production_indicator),TRIM((SALT31.StrType)le.file_type_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.test_or_production_indicator),TRIM((SALT31.StrType)le.file_type_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.test_or_production_indicator),TRIM((SALT31.StrType)le.file_type_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'test_or_production_indicator'}
      ,{4,'file_type_indicator'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    FA_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    FA_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    FA_Fields.InValid_test_or_production_indicator((SALT31.StrType)le.test_or_production_indicator),
    FA_Fields.InValid_file_type_indicator((SALT31.StrType)le.file_type_indicator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,4,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := FA_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_test_or_production_indicator','invalid_file_type_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,FA_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),FA_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),FA_Fields.InValidMessage_test_or_production_indicator(TotalErrors.ErrorNum),FA_Fields.InValidMessage_file_type_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
