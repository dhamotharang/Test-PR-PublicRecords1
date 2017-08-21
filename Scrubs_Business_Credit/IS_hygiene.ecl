IMPORT ut,SALT31;
EXPORT IS_hygiene(dataset(IS_layout_Business_Credit) h) := MODULE
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
    populated_original_fname_pcnt := AVE(GROUP,IF(h.original_fname = (TYPEOF(h.original_fname))'',0,100));
    maxlength_original_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_fname)));
    avelength_original_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_fname)),h.original_fname<>(typeof(h.original_fname))'');
    populated_original_mname_pcnt := AVE(GROUP,IF(h.original_mname = (TYPEOF(h.original_mname))'',0,100));
    maxlength_original_mname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_mname)));
    avelength_original_mname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_mname)),h.original_mname<>(typeof(h.original_mname))'');
    populated_original_lname_pcnt := AVE(GROUP,IF(h.original_lname = (TYPEOF(h.original_lname))'',0,100));
    maxlength_original_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_lname)));
    avelength_original_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_lname)),h.original_lname<>(typeof(h.original_lname))'');
    populated_original_suffix_pcnt := AVE(GROUP,IF(h.original_suffix = (TYPEOF(h.original_suffix))'',0,100));
    maxlength_original_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_suffix)));
    avelength_original_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.original_suffix)),h.original_suffix<>(typeof(h.original_suffix))'');
    populated_e_mail_address_pcnt := AVE(GROUP,IF(h.e_mail_address = (TYPEOF(h.e_mail_address))'',0,100));
    maxlength_e_mail_address := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.e_mail_address)));
    avelength_e_mail_address := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.e_mail_address)),h.e_mail_address<>(typeof(h.e_mail_address))'');
    populated_guarantor_owner_indicator_pcnt := AVE(GROUP,IF(h.guarantor_owner_indicator = (TYPEOF(h.guarantor_owner_indicator))'',0,100));
    maxlength_guarantor_owner_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.guarantor_owner_indicator)));
    avelength_guarantor_owner_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.guarantor_owner_indicator)),h.guarantor_owner_indicator<>(typeof(h.guarantor_owner_indicator))'');
    populated_relationship_to_business_indicator_pcnt := AVE(GROUP,IF(h.relationship_to_business_indicator = (TYPEOF(h.relationship_to_business_indicator))'',0,100));
    maxlength_relationship_to_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.relationship_to_business_indicator)));
    avelength_relationship_to_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.relationship_to_business_indicator)),h.relationship_to_business_indicator<>(typeof(h.relationship_to_business_indicator))'');
    populated_business_title_pcnt := AVE(GROUP,IF(h.business_title = (TYPEOF(h.business_title))'',0,100));
    maxlength_business_title := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.business_title)));
    avelength_business_title := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.business_title)),h.business_title<>(typeof(h.business_title))'');
    populated_percent_of_liability_pcnt := AVE(GROUP,IF(h.percent_of_liability = (TYPEOF(h.percent_of_liability))'',0,100));
    maxlength_percent_of_liability := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.percent_of_liability)));
    avelength_percent_of_liability := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.percent_of_liability)),h.percent_of_liability<>(typeof(h.percent_of_liability))'');
    populated_percent_of_ownership_pcnt := AVE(GROUP,IF(h.percent_of_ownership = (TYPEOF(h.percent_of_ownership))'',0,100));
    maxlength_percent_of_ownership := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.percent_of_ownership)));
    avelength_percent_of_ownership := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.percent_of_ownership)),h.percent_of_ownership<>(typeof(h.percent_of_ownership))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_base_number_pcnt *   0.00 / 100 + T.Populated_original_fname_pcnt *   0.00 / 100 + T.Populated_original_mname_pcnt *   0.00 / 100 + T.Populated_original_lname_pcnt *   0.00 / 100 + T.Populated_original_suffix_pcnt *   0.00 / 100 + T.Populated_e_mail_address_pcnt *   0.00 / 100 + T.Populated_guarantor_owner_indicator_pcnt *   0.00 / 100 + T.Populated_relationship_to_business_indicator_pcnt *   0.00 / 100 + T.Populated_business_title_pcnt *   0.00 / 100 + T.Populated_percent_of_liability_pcnt *   0.00 / 100 + T.Populated_percent_of_ownership_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','percent_of_liability','percent_of_ownership');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_base_number_pcnt,le.populated_original_fname_pcnt,le.populated_original_mname_pcnt,le.populated_original_lname_pcnt,le.populated_original_suffix_pcnt,le.populated_e_mail_address_pcnt,le.populated_guarantor_owner_indicator_pcnt,le.populated_relationship_to_business_indicator_pcnt,le.populated_business_title_pcnt,le.populated_percent_of_liability_pcnt,le.populated_percent_of_ownership_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_base_number,le.maxlength_original_fname,le.maxlength_original_mname,le.maxlength_original_lname,le.maxlength_original_suffix,le.maxlength_e_mail_address,le.maxlength_guarantor_owner_indicator,le.maxlength_relationship_to_business_indicator,le.maxlength_business_title,le.maxlength_percent_of_liability,le.maxlength_percent_of_ownership);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_base_number,le.avelength_original_fname,le.avelength_original_mname,le.avelength_original_lname,le.avelength_original_suffix,le.avelength_e_mail_address,le.avelength_guarantor_owner_indicator,le.avelength_relationship_to_business_indicator,le.avelength_business_title,le.avelength_percent_of_liability,le.avelength_percent_of_ownership);
END;
EXPORT invSummary := NORMALIZE(summary0, 14, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.original_fname),TRIM((SALT31.StrType)le.original_mname),TRIM((SALT31.StrType)le.original_lname),TRIM((SALT31.StrType)le.original_suffix),TRIM((SALT31.StrType)le.e_mail_address),TRIM((SALT31.StrType)le.guarantor_owner_indicator),TRIM((SALT31.StrType)le.relationship_to_business_indicator),TRIM((SALT31.StrType)le.business_title),TRIM((SALT31.StrType)le.percent_of_liability),TRIM((SALT31.StrType)le.percent_of_ownership)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,14,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 14);
  SELF.FldNo2 := 1 + (C % 14);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.original_fname),TRIM((SALT31.StrType)le.original_mname),TRIM((SALT31.StrType)le.original_lname),TRIM((SALT31.StrType)le.original_suffix),TRIM((SALT31.StrType)le.e_mail_address),TRIM((SALT31.StrType)le.guarantor_owner_indicator),TRIM((SALT31.StrType)le.relationship_to_business_indicator),TRIM((SALT31.StrType)le.business_title),TRIM((SALT31.StrType)le.percent_of_liability),TRIM((SALT31.StrType)le.percent_of_ownership)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.parent_sequence_number),TRIM((SALT31.StrType)le.account_base_number),TRIM((SALT31.StrType)le.original_fname),TRIM((SALT31.StrType)le.original_mname),TRIM((SALT31.StrType)le.original_lname),TRIM((SALT31.StrType)le.original_suffix),TRIM((SALT31.StrType)le.e_mail_address),TRIM((SALT31.StrType)le.guarantor_owner_indicator),TRIM((SALT31.StrType)le.relationship_to_business_indicator),TRIM((SALT31.StrType)le.business_title),TRIM((SALT31.StrType)le.percent_of_liability),TRIM((SALT31.StrType)le.percent_of_ownership)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),14*14,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_base_number'}
      ,{5,'original_fname'}
      ,{6,'original_mname'}
      ,{7,'original_lname'}
      ,{8,'original_suffix'}
      ,{9,'e_mail_address'}
      ,{10,'guarantor_owner_indicator'}
      ,{11,'relationship_to_business_indicator'}
      ,{12,'business_title'}
      ,{13,'percent_of_liability'}
      ,{14,'percent_of_ownership'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    IS_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    IS_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    IS_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number),
    IS_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number),
    IS_Fields.InValid_original_fname((SALT31.StrType)le.original_fname),
    IS_Fields.InValid_original_mname((SALT31.StrType)le.original_mname),
    IS_Fields.InValid_original_lname((SALT31.StrType)le.original_lname),
    IS_Fields.InValid_original_suffix((SALT31.StrType)le.original_suffix),
    IS_Fields.InValid_e_mail_address((SALT31.StrType)le.e_mail_address),
    IS_Fields.InValid_guarantor_owner_indicator((SALT31.StrType)le.guarantor_owner_indicator),
    IS_Fields.InValid_relationship_to_business_indicator((SALT31.StrType)le.relationship_to_business_indicator),
    IS_Fields.InValid_business_title((SALT31.StrType)le.business_title),
    IS_Fields.InValid_percent_of_liability((SALT31.StrType)le.percent_of_liability),
    IS_Fields.InValid_percent_of_ownership((SALT31.StrType)le.percent_of_ownership),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,14,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := IS_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_percent_of_liability','invalid_percent_of_ownership');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,IS_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),IS_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),IS_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),IS_Fields.InValidMessage_account_base_number(TotalErrors.ErrorNum),IS_Fields.InValidMessage_original_fname(TotalErrors.ErrorNum),IS_Fields.InValidMessage_original_mname(TotalErrors.ErrorNum),IS_Fields.InValidMessage_original_lname(TotalErrors.ErrorNum),IS_Fields.InValidMessage_original_suffix(TotalErrors.ErrorNum),IS_Fields.InValidMessage_e_mail_address(TotalErrors.ErrorNum),IS_Fields.InValidMessage_guarantor_owner_indicator(TotalErrors.ErrorNum),IS_Fields.InValidMessage_relationship_to_business_indicator(TotalErrors.ErrorNum),IS_Fields.InValidMessage_business_title(TotalErrors.ErrorNum),IS_Fields.InValidMessage_percent_of_liability(TotalErrors.ErrorNum),IS_Fields.InValidMessage_percent_of_ownership(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
