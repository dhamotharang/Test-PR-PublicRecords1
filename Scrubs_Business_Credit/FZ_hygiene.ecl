IMPORT ut,SALT31;
EXPORT FZ_hygiene(dataset(FZ_layout_Business_Credit) h) := MODULE
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
    populated_total_aa_segments_pcnt := AVE(GROUP,IF(h.total_aa_segments = (TYPEOF(h.total_aa_segments))'',0,100));
    maxlength_total_aa_segments := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_aa_segments)));
    avelength_total_aa_segments := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_aa_segments)),h.total_aa_segments<>(typeof(h.total_aa_segments))'');
    populated_total_zz_segments_pcnt := AVE(GROUP,IF(h.total_zz_segments = (TYPEOF(h.total_zz_segments))'',0,100));
    maxlength_total_zz_segments := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_zz_segments)));
    avelength_total_zz_segments := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_zz_segments)),h.total_zz_segments<>(typeof(h.total_zz_segments))'');
    populated_total_record_count_pcnt := AVE(GROUP,IF(h.total_record_count = (TYPEOF(h.total_record_count))'',0,100));
    maxlength_total_record_count := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_record_count)));
    avelength_total_record_count := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_record_count)),h.total_record_count<>(typeof(h.total_record_count))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_total_aa_segments_pcnt *   0.00 / 100 + T.Populated_total_zz_segments_pcnt *   0.00 / 100 + T.Populated_total_record_count_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','total_aa_segments','total_zz_segments','total_record_count');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_total_aa_segments_pcnt,le.populated_total_zz_segments_pcnt,le.populated_total_record_count_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_total_aa_segments,le.maxlength_total_zz_segments,le.maxlength_total_record_count);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_total_aa_segments,le.avelength_total_zz_segments,le.avelength_total_record_count);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.total_aa_segments),TRIM((SALT31.StrType)le.total_zz_segments),TRIM((SALT31.StrType)le.total_record_count)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.total_aa_segments),TRIM((SALT31.StrType)le.total_zz_segments),TRIM((SALT31.StrType)le.total_record_count)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.total_aa_segments),TRIM((SALT31.StrType)le.total_zz_segments),TRIM((SALT31.StrType)le.total_record_count)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'total_aa_segments'}
      ,{4,'total_zz_segments'}
      ,{5,'total_record_count'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    FZ_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    FZ_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    FZ_Fields.InValid_total_aa_segments((SALT31.StrType)le.total_aa_segments),
    FZ_Fields.InValid_total_zz_segments((SALT31.StrType)le.total_zz_segments),
    FZ_Fields.InValid_total_record_count((SALT31.StrType)le.total_record_count),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,5,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := FZ_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_fz_file_sequence_number','invalid_total_aa_segments','invalid_total_zz_segments','invalid_total_record_count');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,FZ_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),FZ_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),FZ_Fields.InValidMessage_total_aa_segments(TotalErrors.ErrorNum),FZ_Fields.InValidMessage_total_zz_segments(TotalErrors.ErrorNum),FZ_Fields.InValidMessage_total_record_count(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
