IMPORT SALT37;
EXPORT Base_Contact_hygiene(dataset(Base_Contact_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_contact_name_pcnt := AVE(GROUP,IF(h.contact_name = (TYPEOF(h.contact_name))'',0,100));
    maxlength_contact_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_name)));
    avelength_contact_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_name)),h.contact_name<>(typeof(h.contact_name))'');
    populated_contact_addr_pcnt := AVE(GROUP,IF(h.contact_addr = (TYPEOF(h.contact_addr))'',0,100));
    maxlength_contact_addr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_addr)));
    avelength_contact_addr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_addr)),h.contact_addr<>(typeof(h.contact_addr))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_contact_name_pcnt *   0.00 / 100 + T.Populated_contact_addr_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'contact_name','contact_addr','contact_phone','prep_addr_line1','prep_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_contact_name_pcnt,le.populated_contact_addr_pcnt,le.populated_contact_phone_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_contact_name,le.maxlength_contact_addr,le.maxlength_contact_phone,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_contact_name,le.avelength_contact_addr,le.avelength_contact_phone,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.contact_name),TRIM((SALT37.StrType)le.contact_addr),TRIM((SALT37.StrType)le.contact_phone),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.contact_name),TRIM((SALT37.StrType)le.contact_addr),TRIM((SALT37.StrType)le.contact_phone),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.contact_name),TRIM((SALT37.StrType)le.contact_addr),TRIM((SALT37.StrType)le.contact_phone),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'contact_name'}
      ,{2,'contact_addr'}
      ,{3,'contact_phone'}
      ,{4,'prep_addr_line1'}
      ,{5,'prep_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Contact_Fields.InValid_contact_name((SALT37.StrType)le.contact_name),
    Base_Contact_Fields.InValid_contact_addr((SALT37.StrType)le.contact_addr),
    Base_Contact_Fields.InValid_contact_phone((SALT37.StrType)le.contact_phone),
    Base_Contact_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Base_Contact_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
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
  FieldNme := Base_Contact_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Contact_Fields.InValidMessage_contact_name(TotalErrors.ErrorNum),Base_Contact_Fields.InValidMessage_contact_addr(TotalErrors.ErrorNum),Base_Contact_Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Base_Contact_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Contact_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
