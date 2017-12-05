IMPORT SALT38,STD;
EXPORT New_hygiene(dataset(New_layout_Suppress) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_product_cnt := COUNT(GROUP,h.product <> (TYPEOF(h.product))'');
    populated_product_pcnt := AVE(GROUP,IF(h.product = (TYPEOF(h.product))'',0,100));
    maxlength_product := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.product)));
    avelength_product := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.product)),h.product<>(typeof(h.product))'');
    populated_linking_type_cnt := COUNT(GROUP,h.linking_type <> (TYPEOF(h.linking_type))'');
    populated_linking_type_pcnt := AVE(GROUP,IF(h.linking_type = (TYPEOF(h.linking_type))'',0,100));
    maxlength_linking_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.linking_type)));
    avelength_linking_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.linking_type)),h.linking_type<>(typeof(h.linking_type))'');
    populated_linking_id_cnt := COUNT(GROUP,h.linking_id <> (TYPEOF(h.linking_id))'');
    populated_linking_id_pcnt := AVE(GROUP,IF(h.linking_id = (TYPEOF(h.linking_id))'',0,100));
    maxlength_linking_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.linking_id)));
    avelength_linking_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.linking_id)),h.linking_id<>(typeof(h.linking_id))'');
    populated_document_type_cnt := COUNT(GROUP,h.document_type <> (TYPEOF(h.document_type))'');
    populated_document_type_pcnt := AVE(GROUP,IF(h.document_type = (TYPEOF(h.document_type))'',0,100));
    maxlength_document_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.document_type)));
    avelength_document_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.document_type)),h.document_type<>(typeof(h.document_type))'');
    populated_document_id_cnt := COUNT(GROUP,h.document_id <> (TYPEOF(h.document_id))'');
    populated_document_id_pcnt := AVE(GROUP,IF(h.document_id = (TYPEOF(h.document_id))'',0,100));
    maxlength_document_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.document_id)));
    avelength_document_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.document_id)),h.document_id<>(typeof(h.document_id))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_user_cnt := COUNT(GROUP,h.user <> (TYPEOF(h.user))'');
    populated_user_pcnt := AVE(GROUP,IF(h.user = (TYPEOF(h.user))'',0,100));
    maxlength_user := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.user)));
    avelength_user := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.user)),h.user<>(typeof(h.user))'');
    populated_compliance_id_cnt := COUNT(GROUP,h.compliance_id <> (TYPEOF(h.compliance_id))'');
    populated_compliance_id_pcnt := AVE(GROUP,IF(h.compliance_id = (TYPEOF(h.compliance_id))'',0,100));
    maxlength_compliance_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.compliance_id)));
    avelength_compliance_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.compliance_id)),h.compliance_id<>(typeof(h.compliance_id))'');
    populated_comment_cnt := COUNT(GROUP,h.comment <> (TYPEOF(h.comment))'');
    populated_comment_pcnt := AVE(GROUP,IF(h.comment = (TYPEOF(h.comment))'',0,100));
    maxlength_comment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comment)));
    avelength_comment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comment)),h.comment<>(typeof(h.comment))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_product_pcnt *   0.00 / 100 + T.Populated_linking_type_pcnt *   0.00 / 100 + T.Populated_linking_id_pcnt *   0.00 / 100 + T.Populated_document_type_pcnt *   0.00 / 100 + T.Populated_document_id_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_pcnt *   0.00 / 100 + T.Populated_compliance_id_pcnt *   0.00 / 100 + T.Populated_comment_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'product','linking_type','linking_id','document_type','document_id','date_added','user','compliance_id','comment');
  SELF.populated_pcnt := CHOOSE(C,le.populated_product_pcnt,le.populated_linking_type_pcnt,le.populated_linking_id_pcnt,le.populated_document_type_pcnt,le.populated_document_id_pcnt,le.populated_date_added_pcnt,le.populated_user_pcnt,le.populated_compliance_id_pcnt,le.populated_comment_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_product,le.maxlength_linking_type,le.maxlength_linking_id,le.maxlength_document_type,le.maxlength_document_id,le.maxlength_date_added,le.maxlength_user,le.maxlength_compliance_id,le.maxlength_comment);
  SELF.avelength := CHOOSE(C,le.avelength_product,le.avelength_linking_type,le.avelength_linking_id,le.avelength_document_type,le.avelength_document_id,le.avelength_date_added,le.avelength_user,le.avelength_compliance_id,le.avelength_comment);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.product),TRIM((SALT38.StrType)le.linking_type),TRIM((SALT38.StrType)le.linking_id),TRIM((SALT38.StrType)le.document_type),TRIM((SALT38.StrType)le.document_id),TRIM((SALT38.StrType)le.date_added),TRIM((SALT38.StrType)le.user),TRIM((SALT38.StrType)le.compliance_id),TRIM((SALT38.StrType)le.comment)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.product),TRIM((SALT38.StrType)le.linking_type),TRIM((SALT38.StrType)le.linking_id),TRIM((SALT38.StrType)le.document_type),TRIM((SALT38.StrType)le.document_id),TRIM((SALT38.StrType)le.date_added),TRIM((SALT38.StrType)le.user),TRIM((SALT38.StrType)le.compliance_id),TRIM((SALT38.StrType)le.comment)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.product),TRIM((SALT38.StrType)le.linking_type),TRIM((SALT38.StrType)le.linking_id),TRIM((SALT38.StrType)le.document_type),TRIM((SALT38.StrType)le.document_id),TRIM((SALT38.StrType)le.date_added),TRIM((SALT38.StrType)le.user),TRIM((SALT38.StrType)le.compliance_id),TRIM((SALT38.StrType)le.comment)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'product'}
      ,{2,'linking_type'}
      ,{3,'linking_id'}
      ,{4,'document_type'}
      ,{5,'document_id'}
      ,{6,'date_added'}
      ,{7,'user'}
      ,{8,'compliance_id'}
      ,{9,'comment'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    New_Fields.InValid_product((SALT38.StrType)le.product),
    New_Fields.InValid_linking_type((SALT38.StrType)le.linking_type),
    New_Fields.InValid_linking_id((SALT38.StrType)le.linking_id),
    New_Fields.InValid_document_type((SALT38.StrType)le.document_type),
    New_Fields.InValid_document_id((SALT38.StrType)le.document_id),
    New_Fields.InValid_date_added((SALT38.StrType)le.date_added),
    New_Fields.InValid_user((SALT38.StrType)le.user),
    New_Fields.InValid_compliance_id((SALT38.StrType)le.compliance_id),
    New_Fields.InValid_comment((SALT38.StrType)le.comment),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,9,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := New_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_product','invalid_linking_type','invalid_num','invalid_document_type','invlid_document_id','Unknown','Unknown','invalid_num','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,New_Fields.InValidMessage_product(TotalErrors.ErrorNum),New_Fields.InValidMessage_linking_type(TotalErrors.ErrorNum),New_Fields.InValidMessage_linking_id(TotalErrors.ErrorNum),New_Fields.InValidMessage_document_type(TotalErrors.ErrorNum),New_Fields.InValidMessage_document_id(TotalErrors.ErrorNum),New_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),New_Fields.InValidMessage_user(TotalErrors.ErrorNum),New_Fields.InValidMessage_compliance_id(TotalErrors.ErrorNum),New_Fields.InValidMessage_comment(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Suppress, New_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
