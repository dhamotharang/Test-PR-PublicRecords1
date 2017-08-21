IMPORT ut,SALT31;
EXPORT CL_hygiene(dataset(CL_layout_Business_Credit) h) := MODULE
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
    populated_collateral_indicator_pcnt := AVE(GROUP,IF(h.collateral_indicator = (TYPEOF(h.collateral_indicator))'',0,100));
    maxlength_collateral_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.collateral_indicator)));
    avelength_collateral_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.collateral_indicator)),h.collateral_indicator<>(typeof(h.collateral_indicator))'');
    populated_type_of_collateral_secured_for_this_account_pcnt := AVE(GROUP,IF(h.type_of_collateral_secured_for_this_account = (TYPEOF(h.type_of_collateral_secured_for_this_account))'',0,100));
    maxlength_type_of_collateral_secured_for_this_account := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_of_collateral_secured_for_this_account)));
    avelength_type_of_collateral_secured_for_this_account := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.type_of_collateral_secured_for_this_account)),h.type_of_collateral_secured_for_this_account<>(typeof(h.type_of_collateral_secured_for_this_account))'');
    populated_collateral_description_pcnt := AVE(GROUP,IF(h.collateral_description = (TYPEOF(h.collateral_description))'',0,100));
    maxlength_collateral_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.collateral_description)));
    avelength_collateral_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.collateral_description)),h.collateral_description<>(typeof(h.collateral_description))'');
    populated_ucc_filing_number_pcnt := AVE(GROUP,IF(h.ucc_filing_number = (TYPEOF(h.ucc_filing_number))'',0,100));
    maxlength_ucc_filing_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_number)));
    avelength_ucc_filing_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_number)),h.ucc_filing_number<>(typeof(h.ucc_filing_number))'');
    populated_ucc_filing_type_pcnt := AVE(GROUP,IF(h.ucc_filing_type = (TYPEOF(h.ucc_filing_type))'',0,100));
    maxlength_ucc_filing_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_type)));
    avelength_ucc_filing_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_type)),h.ucc_filing_type<>(typeof(h.ucc_filing_type))'');
    populated_ucc_filing_date_pcnt := AVE(GROUP,IF(h.ucc_filing_date = (TYPEOF(h.ucc_filing_date))'',0,100));
    maxlength_ucc_filing_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_date)));
    avelength_ucc_filing_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_date)),h.ucc_filing_date<>(typeof(h.ucc_filing_date))'');
    populated_ucc_filing_expiration_date_pcnt := AVE(GROUP,IF(h.ucc_filing_expiration_date = (TYPEOF(h.ucc_filing_expiration_date))'',0,100));
    maxlength_ucc_filing_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_expiration_date)));
    avelength_ucc_filing_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_expiration_date)),h.ucc_filing_expiration_date<>(typeof(h.ucc_filing_expiration_date))'');
    populated_ucc_filing_jurisdiction_pcnt := AVE(GROUP,IF(h.ucc_filing_jurisdiction = (TYPEOF(h.ucc_filing_jurisdiction))'',0,100));
    maxlength_ucc_filing_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_jurisdiction)));
    avelength_ucc_filing_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_jurisdiction)),h.ucc_filing_jurisdiction<>(typeof(h.ucc_filing_jurisdiction))'');
    populated_ucc_filing_description_pcnt := AVE(GROUP,IF(h.ucc_filing_description = (TYPEOF(h.ucc_filing_description))'',0,100));
    maxlength_ucc_filing_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_description)));
    avelength_ucc_filing_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ucc_filing_description)),h.ucc_filing_description<>(typeof(h.ucc_filing_description))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_collateral_indicator_pcnt *   0.00 / 100 + T.Populated_type_of_collateral_secured_for_this_account_pcnt *   0.00 / 100 + T.Populated_collateral_description_pcnt *   0.00 / 100 + T.Populated_ucc_filing_number_pcnt *   0.00 / 100 + T.Populated_ucc_filing_type_pcnt *   0.00 / 100 + T.Populated_ucc_filing_date_pcnt *   0.00 / 100 + T.Populated_ucc_filing_expiration_date_pcnt *   0.00 / 100 + T.Populated_ucc_filing_jurisdiction_pcnt *   0.00 / 100 + T.Populated_ucc_filing_description_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','collateral_indicator','type_of_collateral_secured_for_this_account','collateral_description','ucc_filing_number','ucc_filing_type','ucc_filing_date','ucc_filing_expiration_date','ucc_filing_jurisdiction','ucc_filing_description');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_collateral_indicator_pcnt,le.populated_type_of_collateral_secured_for_this_account_pcnt,le.populated_collateral_description_pcnt,le.populated_ucc_filing_number_pcnt,le.populated_ucc_filing_type_pcnt,le.populated_ucc_filing_date_pcnt,le.populated_ucc_filing_expiration_date_pcnt,le.populated_ucc_filing_jurisdiction_pcnt,le.populated_ucc_filing_description_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_collateral_indicator,le.maxlength_type_of_collateral_secured_for_this_account,le.maxlength_collateral_description,le.maxlength_ucc_filing_number,le.maxlength_ucc_filing_type,le.maxlength_ucc_filing_date,le.maxlength_ucc_filing_expiration_date,le.maxlength_ucc_filing_jurisdiction,le.maxlength_ucc_filing_description);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_collateral_indicator,le.avelength_type_of_collateral_secured_for_this_account,le.avelength_collateral_description,le.avelength_ucc_filing_number,le.avelength_ucc_filing_type,le.avelength_ucc_filing_date,le.avelength_ucc_filing_expiration_date,le.avelength_ucc_filing_jurisdiction,le.avelength_ucc_filing_description);
END;
EXPORT invSummary := NORMALIZE(summary0, 13, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.collateral_indicator),TRIM((SALT31.StrType)le.type_of_collateral_secured_for_this_account),TRIM((SALT31.StrType)le.collateral_description),TRIM((SALT31.StrType)le.ucc_filing_number),TRIM((SALT31.StrType)le.ucc_filing_type),TRIM((SALT31.StrType)le.ucc_filing_date),TRIM((SALT31.StrType)le.ucc_filing_expiration_date),TRIM((SALT31.StrType)le.ucc_filing_jurisdiction),TRIM((SALT31.StrType)le.ucc_filing_description)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,13,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 13);
  SELF.FldNo2 := 1 + (C % 13);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.collateral_indicator),TRIM((SALT31.StrType)le.type_of_collateral_secured_for_this_account),TRIM((SALT31.StrType)le.collateral_description),TRIM((SALT31.StrType)le.ucc_filing_number),TRIM((SALT31.StrType)le.ucc_filing_type),TRIM((SALT31.StrType)le.ucc_filing_date),TRIM((SALT31.StrType)le.ucc_filing_expiration_date),TRIM((SALT31.StrType)le.ucc_filing_jurisdiction),TRIM((SALT31.StrType)le.ucc_filing_description)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.collateral_indicator),TRIM((SALT31.StrType)le.type_of_collateral_secured_for_this_account),TRIM((SALT31.StrType)le.collateral_description),TRIM((SALT31.StrType)le.ucc_filing_number),TRIM((SALT31.StrType)le.ucc_filing_type),TRIM((SALT31.StrType)le.ucc_filing_date),TRIM((SALT31.StrType)le.ucc_filing_expiration_date),TRIM((SALT31.StrType)le.ucc_filing_jurisdiction),TRIM((SALT31.StrType)le.ucc_filing_description)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),13*13,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'collateral_indicator'}
      ,{6,'type_of_collateral_secured_for_this_account'}
      ,{7,'collateral_description'}
      ,{8,'ucc_filing_number'}
      ,{9,'ucc_filing_type'}
      ,{10,'ucc_filing_date'}
      ,{11,'ucc_filing_expiration_date'}
      ,{12,'ucc_filing_jurisdiction'}
      ,{13,'ucc_filing_description'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CL_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    CL_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    CL_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    CL_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    CL_Fields.InValid_collateral_indicator((SALT31.StrType)le.collateral_indicator),
    CL_Fields.InValid_type_of_collateral_secured_for_this_account((SALT31.StrType)le.type_of_collateral_secured_for_this_account),
    CL_Fields.InValid_collateral_description((SALT31.StrType)le.collateral_description),
    CL_Fields.InValid_ucc_filing_number((SALT31.StrType)le.ucc_filing_number),
    CL_Fields.InValid_ucc_filing_type((SALT31.StrType)le.ucc_filing_type),
    CL_Fields.InValid_ucc_filing_date((SALT31.StrType)le.ucc_filing_date),
    CL_Fields.InValid_ucc_filing_expiration_date((SALT31.StrType)le.ucc_filing_expiration_date),
    CL_Fields.InValid_ucc_filing_jurisdiction((SALT31.StrType)le.ucc_filing_jurisdiction),
    CL_Fields.InValid_ucc_filing_description((SALT31.StrType)le.ucc_filing_description),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,13,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := CL_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_collateral_indicator','invalid_type_of_collateral','invalid_collateral_description','invalid_ucc_filing_number','invalid_ucc_filing_type','invalid_ucc_filing_date','invalid_ucc_filing_expiration_date','invalid_ucc_filing_jurisdiction','invalid_ucc_filing_description');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CL_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),CL_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),CL_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),CL_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),CL_Fields.InValidMessage_collateral_indicator(TotalErrors.ErrorNum),CL_Fields.InValidMessage_type_of_collateral_secured_for_this_account(TotalErrors.ErrorNum),CL_Fields.InValidMessage_collateral_description(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_number(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_type(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_date(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_expiration_date(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_jurisdiction(TotalErrors.ErrorNum),CL_Fields.InValidMessage_ucc_filing_description(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
