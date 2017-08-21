IMPORT ut,SALT31;
EXPORT PN_hygiene(dataset(PN_layout_Business_Credit) h) := MODULE
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
    populated_area_code_pcnt := AVE(GROUP,IF(h.area_code = (TYPEOF(h.area_code))'',0,100));
    maxlength_area_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.area_code)));
    avelength_area_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.area_code)),h.area_code<>(typeof(h.area_code))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_phone_extension_pcnt := AVE(GROUP,IF(h.phone_extension = (TYPEOF(h.phone_extension))'',0,100));
    maxlength_phone_extension := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_extension)));
    avelength_phone_extension := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_extension)),h.phone_extension<>(typeof(h.phone_extension))'');
    populated_primary_phone_indicator_pcnt := AVE(GROUP,IF(h.primary_phone_indicator = (TYPEOF(h.primary_phone_indicator))'',0,100));
    maxlength_primary_phone_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_phone_indicator)));
    avelength_primary_phone_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_phone_indicator)),h.primary_phone_indicator<>(typeof(h.primary_phone_indicator))'');
    populated_published_unlisted_indicator_pcnt := AVE(GROUP,IF(h.published_unlisted_indicator = (TYPEOF(h.published_unlisted_indicator))'',0,100));
    maxlength_published_unlisted_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.published_unlisted_indicator)));
    avelength_published_unlisted_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.published_unlisted_indicator)),h.published_unlisted_indicator<>(typeof(h.published_unlisted_indicator))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_extension_pcnt *   0.00 / 100 + T.Populated_primary_phone_indicator_pcnt *   0.00 / 100 + T.Populated_published_unlisted_indicator_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','area_code','phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_area_code_pcnt,le.populated_phone_number_pcnt,le.populated_phone_extension_pcnt,le.populated_primary_phone_indicator_pcnt,le.populated_published_unlisted_indicator_pcnt,le.populated_phone_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_area_code,le.maxlength_phone_number,le.maxlength_phone_extension,le.maxlength_primary_phone_indicator,le.maxlength_published_unlisted_indicator,le.maxlength_phone_type);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_area_code,le.avelength_phone_number,le.avelength_phone_extension,le.avelength_primary_phone_indicator,le.avelength_published_unlisted_indicator,le.avelength_phone_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.area_code),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_extension),TRIM((SALT31.StrType)le.primary_phone_indicator),TRIM((SALT31.StrType)le.published_unlisted_indicator),TRIM((SALT31.StrType)le.phone_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.area_code),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_extension),TRIM((SALT31.StrType)le.primary_phone_indicator),TRIM((SALT31.StrType)le.published_unlisted_indicator),TRIM((SALT31.StrType)le.phone_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.area_code),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_extension),TRIM((SALT31.StrType)le.primary_phone_indicator),TRIM((SALT31.StrType)le.published_unlisted_indicator),TRIM((SALT31.StrType)le.phone_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'area_code'}
      ,{6,'phone_number'}
      ,{7,'phone_extension'}
      ,{8,'primary_phone_indicator'}
      ,{9,'published_unlisted_indicator'}
      ,{10,'phone_type'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    PN_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    PN_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    PN_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    PN_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    PN_Fields.InValid_area_code((SALT31.StrType)le.area_code),
    PN_Fields.InValid_phone_number((SALT31.StrType)le.phone_number),
    PN_Fields.InValid_phone_extension((SALT31.StrType)le.phone_extension),
    PN_Fields.InValid_primary_phone_indicator((SALT31.StrType)le.primary_phone_indicator),
    PN_Fields.InValid_published_unlisted_indicator((SALT31.StrType)le.published_unlisted_indicator),
    PN_Fields.InValid_phone_type((SALT31.StrType)le.phone_type),
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
  FieldNme := PN_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_area_code','invalid_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,PN_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),PN_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),PN_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),PN_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),PN_Fields.InValidMessage_area_code(TotalErrors.ErrorNum),PN_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),PN_Fields.InValidMessage_phone_extension(TotalErrors.ErrorNum),PN_Fields.InValidMessage_primary_phone_indicator(TotalErrors.ErrorNum),PN_Fields.InValidMessage_published_unlisted_indicator(TotalErrors.ErrorNum),PN_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
