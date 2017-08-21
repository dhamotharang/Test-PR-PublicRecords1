IMPORT ut,SALT33;
EXPORT input_hygiene(dataset(input_layout_Experian_Phones) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_encrypted_experian_pin_pcnt := AVE(GROUP,IF(h.encrypted_experian_pin = (TYPEOF(h.encrypted_experian_pin))'',0,100));
    maxlength_encrypted_experian_pin := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.encrypted_experian_pin)));
    avelength_encrypted_experian_pin := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.encrypted_experian_pin)),h.encrypted_experian_pin<>(typeof(h.encrypted_experian_pin))'');
    populated_phone_1_digits_pcnt := AVE(GROUP,IF(h.phone_1_digits = (TYPEOF(h.phone_1_digits))'',0,100));
    maxlength_phone_1_digits := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_digits)));
    avelength_phone_1_digits := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_digits)),h.phone_1_digits<>(typeof(h.phone_1_digits))'');
    populated_phone_1_type_pcnt := AVE(GROUP,IF(h.phone_1_type = (TYPEOF(h.phone_1_type))'',0,100));
    maxlength_phone_1_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_type)));
    avelength_phone_1_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_type)),h.phone_1_type<>(typeof(h.phone_1_type))'');
    populated_phone_1_source_pcnt := AVE(GROUP,IF(h.phone_1_source = (TYPEOF(h.phone_1_source))'',0,100));
    maxlength_phone_1_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_source)));
    avelength_phone_1_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_source)),h.phone_1_source<>(typeof(h.phone_1_source))'');
    populated_phone_1_last_updt_pcnt := AVE(GROUP,IF(h.phone_1_last_updt = (TYPEOF(h.phone_1_last_updt))'',0,100));
    maxlength_phone_1_last_updt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_last_updt)));
    avelength_phone_1_last_updt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_1_last_updt)),h.phone_1_last_updt<>(typeof(h.phone_1_last_updt))'');
    populated_phone_2_digits_pcnt := AVE(GROUP,IF(h.phone_2_digits = (TYPEOF(h.phone_2_digits))'',0,100));
    maxlength_phone_2_digits := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_digits)));
    avelength_phone_2_digits := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_digits)),h.phone_2_digits<>(typeof(h.phone_2_digits))'');
    populated_phone_2_type_pcnt := AVE(GROUP,IF(h.phone_2_type = (TYPEOF(h.phone_2_type))'',0,100));
    maxlength_phone_2_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_type)));
    avelength_phone_2_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_type)),h.phone_2_type<>(typeof(h.phone_2_type))'');
    populated_phone_2_source_pcnt := AVE(GROUP,IF(h.phone_2_source = (TYPEOF(h.phone_2_source))'',0,100));
    maxlength_phone_2_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_source)));
    avelength_phone_2_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_source)),h.phone_2_source<>(typeof(h.phone_2_source))'');
    populated_phone_2_last_updt_pcnt := AVE(GROUP,IF(h.phone_2_last_updt = (TYPEOF(h.phone_2_last_updt))'',0,100));
    maxlength_phone_2_last_updt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_last_updt)));
    avelength_phone_2_last_updt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_2_last_updt)),h.phone_2_last_updt<>(typeof(h.phone_2_last_updt))'');
    populated_phone_3_digits_pcnt := AVE(GROUP,IF(h.phone_3_digits = (TYPEOF(h.phone_3_digits))'',0,100));
    maxlength_phone_3_digits := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_digits)));
    avelength_phone_3_digits := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_digits)),h.phone_3_digits<>(typeof(h.phone_3_digits))'');
    populated_phone_3_type_pcnt := AVE(GROUP,IF(h.phone_3_type = (TYPEOF(h.phone_3_type))'',0,100));
    maxlength_phone_3_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_type)));
    avelength_phone_3_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_type)),h.phone_3_type<>(typeof(h.phone_3_type))'');
    populated_phone_3_source_pcnt := AVE(GROUP,IF(h.phone_3_source = (TYPEOF(h.phone_3_source))'',0,100));
    maxlength_phone_3_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_source)));
    avelength_phone_3_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_source)),h.phone_3_source<>(typeof(h.phone_3_source))'');
    populated_phone_3_last_updt_pcnt := AVE(GROUP,IF(h.phone_3_last_updt = (TYPEOF(h.phone_3_last_updt))'',0,100));
    maxlength_phone_3_last_updt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_last_updt)));
    avelength_phone_3_last_updt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_3_last_updt)),h.phone_3_last_updt<>(typeof(h.phone_3_last_updt))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_encrypted_experian_pin_pcnt *   0.00 / 100 + T.Populated_phone_1_digits_pcnt *   0.00 / 100 + T.Populated_phone_1_type_pcnt *   0.00 / 100 + T.Populated_phone_1_source_pcnt *   0.00 / 100 + T.Populated_phone_1_last_updt_pcnt *   0.00 / 100 + T.Populated_phone_2_digits_pcnt *   0.00 / 100 + T.Populated_phone_2_type_pcnt *   0.00 / 100 + T.Populated_phone_2_source_pcnt *   0.00 / 100 + T.Populated_phone_2_last_updt_pcnt *   0.00 / 100 + T.Populated_phone_3_digits_pcnt *   0.00 / 100 + T.Populated_phone_3_type_pcnt *   0.00 / 100 + T.Populated_phone_3_source_pcnt *   0.00 / 100 + T.Populated_phone_3_last_updt_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'encrypted_experian_pin','phone_1_digits','phone_1_type','phone_1_source','phone_1_last_updt','phone_2_digits','phone_2_type','phone_2_source','phone_2_last_updt','phone_3_digits','phone_3_type','phone_3_source','phone_3_last_updt','filler','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_encrypted_experian_pin_pcnt,le.populated_phone_1_digits_pcnt,le.populated_phone_1_type_pcnt,le.populated_phone_1_source_pcnt,le.populated_phone_1_last_updt_pcnt,le.populated_phone_2_digits_pcnt,le.populated_phone_2_type_pcnt,le.populated_phone_2_source_pcnt,le.populated_phone_2_last_updt_pcnt,le.populated_phone_3_digits_pcnt,le.populated_phone_3_type_pcnt,le.populated_phone_3_source_pcnt,le.populated_phone_3_last_updt_pcnt,le.populated_filler_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_encrypted_experian_pin,le.maxlength_phone_1_digits,le.maxlength_phone_1_type,le.maxlength_phone_1_source,le.maxlength_phone_1_last_updt,le.maxlength_phone_2_digits,le.maxlength_phone_2_type,le.maxlength_phone_2_source,le.maxlength_phone_2_last_updt,le.maxlength_phone_3_digits,le.maxlength_phone_3_type,le.maxlength_phone_3_source,le.maxlength_phone_3_last_updt,le.maxlength_filler,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_encrypted_experian_pin,le.avelength_phone_1_digits,le.avelength_phone_1_type,le.avelength_phone_1_source,le.avelength_phone_1_last_updt,le.avelength_phone_2_digits,le.avelength_phone_2_type,le.avelength_phone_2_source,le.avelength_phone_2_last_updt,le.avelength_phone_3_digits,le.avelength_phone_3_type,le.avelength_phone_3_source,le.avelength_phone_3_last_updt,le.avelength_filler,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.encrypted_experian_pin),TRIM((SALT33.StrType)le.phone_1_digits),TRIM((SALT33.StrType)le.phone_1_type),TRIM((SALT33.StrType)le.phone_1_source),TRIM((SALT33.StrType)le.phone_1_last_updt),TRIM((SALT33.StrType)le.phone_2_digits),TRIM((SALT33.StrType)le.phone_2_type),TRIM((SALT33.StrType)le.phone_2_source),TRIM((SALT33.StrType)le.phone_2_last_updt),TRIM((SALT33.StrType)le.phone_3_digits),TRIM((SALT33.StrType)le.phone_3_type),TRIM((SALT33.StrType)le.phone_3_source),TRIM((SALT33.StrType)le.phone_3_last_updt),TRIM((SALT33.StrType)le.filler),TRIM((SALT33.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.encrypted_experian_pin),TRIM((SALT33.StrType)le.phone_1_digits),TRIM((SALT33.StrType)le.phone_1_type),TRIM((SALT33.StrType)le.phone_1_source),TRIM((SALT33.StrType)le.phone_1_last_updt),TRIM((SALT33.StrType)le.phone_2_digits),TRIM((SALT33.StrType)le.phone_2_type),TRIM((SALT33.StrType)le.phone_2_source),TRIM((SALT33.StrType)le.phone_2_last_updt),TRIM((SALT33.StrType)le.phone_3_digits),TRIM((SALT33.StrType)le.phone_3_type),TRIM((SALT33.StrType)le.phone_3_source),TRIM((SALT33.StrType)le.phone_3_last_updt),TRIM((SALT33.StrType)le.filler),TRIM((SALT33.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.encrypted_experian_pin),TRIM((SALT33.StrType)le.phone_1_digits),TRIM((SALT33.StrType)le.phone_1_type),TRIM((SALT33.StrType)le.phone_1_source),TRIM((SALT33.StrType)le.phone_1_last_updt),TRIM((SALT33.StrType)le.phone_2_digits),TRIM((SALT33.StrType)le.phone_2_type),TRIM((SALT33.StrType)le.phone_2_source),TRIM((SALT33.StrType)le.phone_2_last_updt),TRIM((SALT33.StrType)le.phone_3_digits),TRIM((SALT33.StrType)le.phone_3_type),TRIM((SALT33.StrType)le.phone_3_source),TRIM((SALT33.StrType)le.phone_3_last_updt),TRIM((SALT33.StrType)le.filler),TRIM((SALT33.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'encrypted_experian_pin'}
      ,{2,'phone_1_digits'}
      ,{3,'phone_1_type'}
      ,{4,'phone_1_source'}
      ,{5,'phone_1_last_updt'}
      ,{6,'phone_2_digits'}
      ,{7,'phone_2_type'}
      ,{8,'phone_2_source'}
      ,{9,'phone_2_last_updt'}
      ,{10,'phone_3_digits'}
      ,{11,'phone_3_type'}
      ,{12,'phone_3_source'}
      ,{13,'phone_3_last_updt'}
      ,{14,'filler'}
      ,{15,'crlf'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    input_Fields.InValid_encrypted_experian_pin((SALT33.StrType)le.encrypted_experian_pin),
    input_Fields.InValid_phone_1_digits((SALT33.StrType)le.phone_1_digits),
    input_Fields.InValid_phone_1_type((SALT33.StrType)le.phone_1_type),
    input_Fields.InValid_phone_1_source((SALT33.StrType)le.phone_1_source),
    input_Fields.InValid_phone_1_last_updt((SALT33.StrType)le.phone_1_last_updt),
    input_Fields.InValid_phone_2_digits((SALT33.StrType)le.phone_2_digits),
    input_Fields.InValid_phone_2_type((SALT33.StrType)le.phone_2_type),
    input_Fields.InValid_phone_2_source((SALT33.StrType)le.phone_2_source),
    input_Fields.InValid_phone_2_last_updt((SALT33.StrType)le.phone_2_last_updt),
    input_Fields.InValid_phone_3_digits((SALT33.StrType)le.phone_3_digits),
    input_Fields.InValid_phone_3_type((SALT33.StrType)le.phone_3_type),
    input_Fields.InValid_phone_3_source((SALT33.StrType)le.phone_3_source),
    input_Fields.InValid_phone_3_last_updt((SALT33.StrType)le.phone_3_last_updt),
    input_Fields.InValid_filler((SALT33.StrType)le.filler),
    input_Fields.InValid_crlf((SALT33.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,15,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Pin','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,input_Fields.InValidMessage_encrypted_experian_pin(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_1_digits(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_1_type(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_1_source(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_1_last_updt(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_2_digits(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_2_type(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_2_source(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_2_last_updt(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_3_digits(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_3_type(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_3_source(TotalErrors.ErrorNum),input_Fields.InValidMessage_phone_3_last_updt(TotalErrors.ErrorNum),input_Fields.InValidMessage_filler(TotalErrors.ErrorNum),input_Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
