IMPORT SALT37;
EXPORT Input_CA_San_Diego_hygiene(dataset(Input_CA_San_Diego_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_prev_file_date_pcnt := AVE(GROUP,IF(h.prev_file_date = (TYPEOF(h.prev_file_date))'',0,100));
    maxlength_prev_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_date)));
    avelength_prev_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_date)),h.prev_file_date<>(typeof(h.prev_file_date))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_prev_file_number_pcnt := AVE(GROUP,IF(h.prev_file_number = (TYPEOF(h.prev_file_number))'',0,100));
    maxlength_prev_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_number)));
    avelength_prev_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_number)),h.prev_file_number<>(typeof(h.prev_file_number))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prep_mail_addr_line1_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line1 = (TYPEOF(h.prep_mail_addr_line1))'',0,100));
    maxlength_prep_mail_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)));
    avelength_prep_mail_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)),h.prep_mail_addr_line1<>(typeof(h.prep_mail_addr_line1))'');
    populated_prep_mail_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line_last = (TYPEOF(h.prep_mail_addr_line_last))'',0,100));
    maxlength_prep_mail_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)));
    avelength_prep_mail_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)),h.prep_mail_addr_line_last<>(typeof(h.prep_mail_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_prev_file_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_prev_file_number_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'business_name','file_date','prev_file_date','file_number','prev_file_number','filing_type','owner_name','prep_addr_line1','prep_addr_line_last','prep_mail_addr_line1','prep_mail_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_file_date_pcnt,le.populated_prev_file_date_pcnt,le.populated_file_number_pcnt,le.populated_prev_file_number_pcnt,le.populated_filing_type_pcnt,le.populated_owner_name_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prep_mail_addr_line1_pcnt,le.populated_prep_mail_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_file_date,le.maxlength_prev_file_date,le.maxlength_file_number,le.maxlength_prev_file_number,le.maxlength_filing_type,le.maxlength_owner_name,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prep_mail_addr_line1,le.maxlength_prep_mail_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_file_date,le.avelength_prev_file_date,le.avelength_file_number,le.avelength_prev_file_number,le.avelength_filing_type,le.avelength_owner_name,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prep_mail_addr_line1,le.avelength_prep_mail_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'file_date'}
      ,{3,'prev_file_date'}
      ,{4,'file_number'}
      ,{5,'prev_file_number'}
      ,{6,'filing_type'}
      ,{7,'owner_name'}
      ,{8,'prep_addr_line1'}
      ,{9,'prep_addr_line_last'}
      ,{10,'prep_mail_addr_line1'}
      ,{11,'prep_mail_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_San_Diego_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_San_Diego_Fields.InValid_file_date((SALT37.StrType)le.file_date),
    Input_CA_San_Diego_Fields.InValid_prev_file_date((SALT37.StrType)le.prev_file_date),
    Input_CA_San_Diego_Fields.InValid_file_number((SALT37.StrType)le.file_number),
    Input_CA_San_Diego_Fields.InValid_prev_file_number((SALT37.StrType)le.prev_file_number),
    Input_CA_San_Diego_Fields.InValid_filing_type((SALT37.StrType)le.filing_type),
    Input_CA_San_Diego_Fields.InValid_owner_name((SALT37.StrType)le.owner_name),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Input_CA_San_Diego_Fields.InValid_prep_mail_addr_line1((SALT37.StrType)le.prep_mail_addr_line1),
    Input_CA_San_Diego_Fields.InValid_prep_mail_addr_line_last((SALT37.StrType)le.prep_mail_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_San_Diego_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_San_Diego_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prev_file_date(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prev_file_number(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_mail_addr_line1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_mail_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
