IMPORT ut,SALT33;
EXPORT base_hygiene(dataset(base_layout_Experian_Phones) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_encrypted_experian_pin_pcnt := AVE(GROUP,IF(h.encrypted_experian_pin = (TYPEOF(h.encrypted_experian_pin))'',0,100));
    maxlength_encrypted_experian_pin := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.encrypted_experian_pin)));
    avelength_encrypted_experian_pin := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.encrypted_experian_pin)),h.encrypted_experian_pin<>(typeof(h.encrypted_experian_pin))'');
    populated_phone_pos_pcnt := AVE(GROUP,IF(h.phone_pos = (TYPEOF(h.phone_pos))'',0,100));
    maxlength_phone_pos := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_pos)));
    avelength_phone_pos := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_pos)),h.phone_pos<>(typeof(h.phone_pos))'');
    populated_phone_digits_pcnt := AVE(GROUP,IF(h.phone_digits = (TYPEOF(h.phone_digits))'',0,100));
    maxlength_phone_digits := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_digits)));
    avelength_phone_digits := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_digits)),h.phone_digits<>(typeof(h.phone_digits))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_phone_source_pcnt := AVE(GROUP,IF(h.phone_source = (TYPEOF(h.phone_source))'',0,100));
    maxlength_phone_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_source)));
    avelength_phone_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_source)),h.phone_source<>(typeof(h.phone_source))'');
    populated_phone_last_updt_pcnt := AVE(GROUP,IF(h.phone_last_updt = (TYPEOF(h.phone_last_updt))'',0,100));
    maxlength_phone_last_updt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_last_updt)));
    avelength_phone_last_updt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_last_updt)),h.phone_last_updt<>(typeof(h.phone_last_updt))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_pin_did_pcnt := AVE(GROUP,IF(h.pin_did = (TYPEOF(h.pin_did))'',0,100));
    maxlength_pin_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_did)));
    avelength_pin_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_did)),h.pin_did<>(typeof(h.pin_did))'');
    populated_pin_title_pcnt := AVE(GROUP,IF(h.pin_title = (TYPEOF(h.pin_title))'',0,100));
    maxlength_pin_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_title)));
    avelength_pin_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_title)),h.pin_title<>(typeof(h.pin_title))'');
    populated_pin_fname_pcnt := AVE(GROUP,IF(h.pin_fname = (TYPEOF(h.pin_fname))'',0,100));
    maxlength_pin_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_fname)));
    avelength_pin_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_fname)),h.pin_fname<>(typeof(h.pin_fname))'');
    populated_pin_mname_pcnt := AVE(GROUP,IF(h.pin_mname = (TYPEOF(h.pin_mname))'',0,100));
    maxlength_pin_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_mname)));
    avelength_pin_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_mname)),h.pin_mname<>(typeof(h.pin_mname))'');
    populated_pin_lname_pcnt := AVE(GROUP,IF(h.pin_lname = (TYPEOF(h.pin_lname))'',0,100));
    maxlength_pin_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_lname)));
    avelength_pin_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_lname)),h.pin_lname<>(typeof(h.pin_lname))'');
    populated_pin_name_suffix_pcnt := AVE(GROUP,IF(h.pin_name_suffix = (TYPEOF(h.pin_name_suffix))'',0,100));
    maxlength_pin_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_name_suffix)));
    avelength_pin_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pin_name_suffix)),h.pin_name_suffix<>(typeof(h.pin_name_suffix))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_is_current_pcnt := AVE(GROUP,IF(h.is_current = (TYPEOF(h.is_current))'',0,100));
    maxlength_is_current := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_current)));
    avelength_is_current := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_current)),h.is_current<>(typeof(h.is_current))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_encrypted_experian_pin_pcnt *   0.00 / 100 + T.Populated_phone_pos_pcnt *   0.00 / 100 + T.Populated_phone_digits_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_phone_source_pcnt *   0.00 / 100 + T.Populated_phone_last_updt_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_pin_did_pcnt *   0.00 / 100 + T.Populated_pin_title_pcnt *   0.00 / 100 + T.Populated_pin_fname_pcnt *   0.00 / 100 + T.Populated_pin_mname_pcnt *   0.00 / 100 + T.Populated_pin_lname_pcnt *   0.00 / 100 + T.Populated_pin_name_suffix_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_is_current_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'score','encrypted_experian_pin','phone_pos','phone_digits','phone_type','phone_source','phone_last_updt','did','did_score','pin_did','pin_title','pin_fname','pin_mname','pin_lname','pin_name_suffix','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rec_type','is_current');
  SELF.populated_pcnt := CHOOSE(C,le.populated_score_pcnt,le.populated_encrypted_experian_pin_pcnt,le.populated_phone_pos_pcnt,le.populated_phone_digits_pcnt,le.populated_phone_type_pcnt,le.populated_phone_source_pcnt,le.populated_phone_last_updt_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_pin_did_pcnt,le.populated_pin_title_pcnt,le.populated_pin_fname_pcnt,le.populated_pin_mname_pcnt,le.populated_pin_lname_pcnt,le.populated_pin_name_suffix_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_rec_type_pcnt,le.populated_is_current_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_score,le.maxlength_encrypted_experian_pin,le.maxlength_phone_pos,le.maxlength_phone_digits,le.maxlength_phone_type,le.maxlength_phone_source,le.maxlength_phone_last_updt,le.maxlength_did,le.maxlength_did_score,le.maxlength_pin_did,le.maxlength_pin_title,le.maxlength_pin_fname,le.maxlength_pin_mname,le.maxlength_pin_lname,le.maxlength_pin_name_suffix,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_rec_type,le.maxlength_is_current);
  SELF.avelength := CHOOSE(C,le.avelength_score,le.avelength_encrypted_experian_pin,le.avelength_phone_pos,le.avelength_phone_digits,le.avelength_phone_type,le.avelength_phone_source,le.avelength_phone_last_updt,le.avelength_did,le.avelength_did_score,le.avelength_pin_did,le.avelength_pin_title,le.avelength_pin_fname,le.avelength_pin_mname,le.avelength_pin_lname,le.avelength_pin_name_suffix,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_rec_type,le.avelength_is_current);
END;
EXPORT invSummary := NORMALIZE(summary0, 21, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.encrypted_experian_pin),IF (le.phone_pos <> 0,TRIM((SALT33.StrType)le.phone_pos), ''),TRIM((SALT33.StrType)le.phone_digits),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_source),TRIM((SALT33.StrType)le.phone_last_updt),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.pin_did <> 0,TRIM((SALT33.StrType)le.pin_did), ''),TRIM((SALT33.StrType)le.pin_title),TRIM((SALT33.StrType)le.pin_fname),TRIM((SALT33.StrType)le.pin_mname),TRIM((SALT33.StrType)le.pin_lname),TRIM((SALT33.StrType)le.pin_name_suffix),IF (le.date_first_seen <> 0,TRIM((SALT33.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT33.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_last_reported), ''),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.is_current)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 21);
  SELF.FldNo2 := 1 + (C % 21);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.encrypted_experian_pin),IF (le.phone_pos <> 0,TRIM((SALT33.StrType)le.phone_pos), ''),TRIM((SALT33.StrType)le.phone_digits),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_source),TRIM((SALT33.StrType)le.phone_last_updt),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.pin_did <> 0,TRIM((SALT33.StrType)le.pin_did), ''),TRIM((SALT33.StrType)le.pin_title),TRIM((SALT33.StrType)le.pin_fname),TRIM((SALT33.StrType)le.pin_mname),TRIM((SALT33.StrType)le.pin_lname),TRIM((SALT33.StrType)le.pin_name_suffix),IF (le.date_first_seen <> 0,TRIM((SALT33.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT33.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_last_reported), ''),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.is_current)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.encrypted_experian_pin),IF (le.phone_pos <> 0,TRIM((SALT33.StrType)le.phone_pos), ''),TRIM((SALT33.StrType)le.phone_digits),TRIM((SALT33.StrType)le.phone_type),TRIM((SALT33.StrType)le.phone_source),TRIM((SALT33.StrType)le.phone_last_updt),IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT33.StrType)le.did_score), ''),IF (le.pin_did <> 0,TRIM((SALT33.StrType)le.pin_did), ''),TRIM((SALT33.StrType)le.pin_title),TRIM((SALT33.StrType)le.pin_fname),TRIM((SALT33.StrType)le.pin_mname),TRIM((SALT33.StrType)le.pin_lname),TRIM((SALT33.StrType)le.pin_name_suffix),IF (le.date_first_seen <> 0,TRIM((SALT33.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT33.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT33.StrType)le.date_vendor_last_reported), ''),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.is_current)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),21*21,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'score'}
      ,{2,'encrypted_experian_pin'}
      ,{3,'phone_pos'}
      ,{4,'phone_digits'}
      ,{5,'phone_type'}
      ,{6,'phone_source'}
      ,{7,'phone_last_updt'}
      ,{8,'did'}
      ,{9,'did_score'}
      ,{10,'pin_did'}
      ,{11,'pin_title'}
      ,{12,'pin_fname'}
      ,{13,'pin_mname'}
      ,{14,'pin_lname'}
      ,{15,'pin_name_suffix'}
      ,{16,'date_first_seen'}
      ,{17,'date_last_seen'}
      ,{18,'date_vendor_first_reported'}
      ,{19,'date_vendor_last_reported'}
      ,{20,'rec_type'}
      ,{21,'is_current'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    base_Fields.InValid_score((SALT33.StrType)le.score),
    base_Fields.InValid_encrypted_experian_pin((SALT33.StrType)le.encrypted_experian_pin),
    base_Fields.InValid_phone_pos((SALT33.StrType)le.phone_pos),
    base_Fields.InValid_phone_digits((SALT33.StrType)le.phone_digits),
    base_Fields.InValid_phone_type((SALT33.StrType)le.phone_type),
    base_Fields.InValid_phone_source((SALT33.StrType)le.phone_source),
    base_Fields.InValid_phone_last_updt((SALT33.StrType)le.phone_last_updt),
    base_Fields.InValid_did((SALT33.StrType)le.did),
    base_Fields.InValid_did_score((SALT33.StrType)le.did_score),
    base_Fields.InValid_pin_did((SALT33.StrType)le.pin_did),
    base_Fields.InValid_pin_title((SALT33.StrType)le.pin_title),
    base_Fields.InValid_pin_fname((SALT33.StrType)le.pin_fname),
    base_Fields.InValid_pin_mname((SALT33.StrType)le.pin_mname),
    base_Fields.InValid_pin_lname((SALT33.StrType)le.pin_lname),
    base_Fields.InValid_pin_name_suffix((SALT33.StrType)le.pin_name_suffix),
    base_Fields.InValid_date_first_seen((SALT33.StrType)le.date_first_seen),
    base_Fields.InValid_date_last_seen((SALT33.StrType)le.date_last_seen),
    base_Fields.InValid_date_vendor_first_reported((SALT33.StrType)le.date_vendor_first_reported),
    base_Fields.InValid_date_vendor_last_reported((SALT33.StrType)le.date_vendor_last_reported),
    base_Fields.InValid_rec_type((SALT33.StrType)le.rec_type),
    base_Fields.InValid_is_current((SALT33.StrType)le.is_current),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,21,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Pin','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_RecType','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,base_Fields.InValidMessage_score(TotalErrors.ErrorNum),base_Fields.InValidMessage_encrypted_experian_pin(TotalErrors.ErrorNum),base_Fields.InValidMessage_phone_pos(TotalErrors.ErrorNum),base_Fields.InValidMessage_phone_digits(TotalErrors.ErrorNum),base_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),base_Fields.InValidMessage_phone_source(TotalErrors.ErrorNum),base_Fields.InValidMessage_phone_last_updt(TotalErrors.ErrorNum),base_Fields.InValidMessage_did(TotalErrors.ErrorNum),base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_did(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_title(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_fname(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_mname(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_lname(TotalErrors.ErrorNum),base_Fields.InValidMessage_pin_name_suffix(TotalErrors.ErrorNum),base_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),base_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),base_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),base_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),base_Fields.InValidMessage_is_current(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
