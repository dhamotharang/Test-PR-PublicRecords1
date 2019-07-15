IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_datetime_cnt := COUNT(GROUP,h.datetime <> (TYPEOF(h.datetime))'');
    populated_datetime_pcnt := AVE(GROUP,IF(h.datetime = (TYPEOF(h.datetime))'',0,100));
    maxlength_datetime := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.datetime)));
    avelength_datetime := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.datetime)),h.datetime<>(typeof(h.datetime))'');
    populated_customer_id_cnt := COUNT(GROUP,h.customer_id <> (TYPEOF(h.customer_id))'');
    populated_customer_id_pcnt := AVE(GROUP,IF(h.customer_id = (TYPEOF(h.customer_id))'',0,100));
    maxlength_customer_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.customer_id)));
    avelength_customer_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.customer_id)),h.customer_id<>(typeof(h.customer_id))'');
    populated_search_function_name_cnt := COUNT(GROUP,h.search_function_name <> (TYPEOF(h.search_function_name))'');
    populated_search_function_name_pcnt := AVE(GROUP,IF(h.search_function_name = (TYPEOF(h.search_function_name))'',0,100));
    maxlength_search_function_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.search_function_name)));
    avelength_search_function_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.search_function_name)),h.search_function_name<>(typeof(h.search_function_name))'');
    populated_entity_type_cnt := COUNT(GROUP,h.entity_type <> (TYPEOF(h.entity_type))'');
    populated_entity_type_pcnt := AVE(GROUP,IF(h.entity_type = (TYPEOF(h.entity_type))'',0,100));
    maxlength_entity_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type)));
    avelength_entity_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type)),h.entity_type<>(typeof(h.entity_type))'');
    populated_field1_cnt := COUNT(GROUP,h.field1 <> (TYPEOF(h.field1))'');
    populated_field1_pcnt := AVE(GROUP,IF(h.field1 = (TYPEOF(h.field1))'',0,100));
    maxlength_field1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field1)));
    avelength_field1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field1)),h.field1<>(typeof(h.field1))'');
    populated_field2_cnt := COUNT(GROUP,h.field2 <> (TYPEOF(h.field2))'');
    populated_field2_pcnt := AVE(GROUP,IF(h.field2 = (TYPEOF(h.field2))'',0,100));
    maxlength_field2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field2)));
    avelength_field2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field2)),h.field2<>(typeof(h.field2))'');
    populated_field3_cnt := COUNT(GROUP,h.field3 <> (TYPEOF(h.field3))'');
    populated_field3_pcnt := AVE(GROUP,IF(h.field3 = (TYPEOF(h.field3))'',0,100));
    maxlength_field3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field3)));
    avelength_field3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field3)),h.field3<>(typeof(h.field3))'');
    populated_field4_cnt := COUNT(GROUP,h.field4 <> (TYPEOF(h.field4))'');
    populated_field4_pcnt := AVE(GROUP,IF(h.field4 = (TYPEOF(h.field4))'',0,100));
    maxlength_field4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field4)));
    avelength_field4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field4)),h.field4<>(typeof(h.field4))'');
    populated_field5_cnt := COUNT(GROUP,h.field5 <> (TYPEOF(h.field5))'');
    populated_field5_pcnt := AVE(GROUP,IF(h.field5 = (TYPEOF(h.field5))'',0,100));
    maxlength_field5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field5)));
    avelength_field5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field5)),h.field5<>(typeof(h.field5))'');
    populated_field6_cnt := COUNT(GROUP,h.field6 <> (TYPEOF(h.field6))'');
    populated_field6_pcnt := AVE(GROUP,IF(h.field6 = (TYPEOF(h.field6))'',0,100));
    maxlength_field6 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field6)));
    avelength_field6 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field6)),h.field6<>(typeof(h.field6))'');
    populated_field7_cnt := COUNT(GROUP,h.field7 <> (TYPEOF(h.field7))'');
    populated_field7_pcnt := AVE(GROUP,IF(h.field7 = (TYPEOF(h.field7))'',0,100));
    maxlength_field7 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field7)));
    avelength_field7 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field7)),h.field7<>(typeof(h.field7))'');
    populated_field8_cnt := COUNT(GROUP,h.field8 <> (TYPEOF(h.field8))'');
    populated_field8_pcnt := AVE(GROUP,IF(h.field8 = (TYPEOF(h.field8))'',0,100));
    maxlength_field8 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field8)));
    avelength_field8 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field8)),h.field8<>(typeof(h.field8))'');
    populated_field9_cnt := COUNT(GROUP,h.field9 <> (TYPEOF(h.field9))'');
    populated_field9_pcnt := AVE(GROUP,IF(h.field9 = (TYPEOF(h.field9))'',0,100));
    maxlength_field9 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field9)));
    avelength_field9 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field9)),h.field9<>(typeof(h.field9))'');
    populated_field10_cnt := COUNT(GROUP,h.field10 <> (TYPEOF(h.field10))'');
    populated_field10_pcnt := AVE(GROUP,IF(h.field10 = (TYPEOF(h.field10))'',0,100));
    maxlength_field10 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field10)));
    avelength_field10 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field10)),h.field10<>(typeof(h.field10))'');
    populated_field11_cnt := COUNT(GROUP,h.field11 <> (TYPEOF(h.field11))'');
    populated_field11_pcnt := AVE(GROUP,IF(h.field11 = (TYPEOF(h.field11))'',0,100));
    maxlength_field11 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field11)));
    avelength_field11 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field11)),h.field11<>(typeof(h.field11))'');
    populated_field12_cnt := COUNT(GROUP,h.field12 <> (TYPEOF(h.field12))'');
    populated_field12_pcnt := AVE(GROUP,IF(h.field12 = (TYPEOF(h.field12))'',0,100));
    maxlength_field12 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field12)));
    avelength_field12 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field12)),h.field12<>(typeof(h.field12))'');
    populated_field13_cnt := COUNT(GROUP,h.field13 <> (TYPEOF(h.field13))'');
    populated_field13_pcnt := AVE(GROUP,IF(h.field13 = (TYPEOF(h.field13))'',0,100));
    maxlength_field13 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field13)));
    avelength_field13 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field13)),h.field13<>(typeof(h.field13))'');
    populated_field14_cnt := COUNT(GROUP,h.field14 <> (TYPEOF(h.field14))'');
    populated_field14_pcnt := AVE(GROUP,IF(h.field14 = (TYPEOF(h.field14))'',0,100));
    maxlength_field14 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field14)));
    avelength_field14 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field14)),h.field14<>(typeof(h.field14))'');
    populated_field15_cnt := COUNT(GROUP,h.field15 <> (TYPEOF(h.field15))'');
    populated_field15_pcnt := AVE(GROUP,IF(h.field15 = (TYPEOF(h.field15))'',0,100));
    maxlength_field15 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field15)));
    avelength_field15 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field15)),h.field15<>(typeof(h.field15))'');
    populated_field16_cnt := COUNT(GROUP,h.field16 <> (TYPEOF(h.field16))'');
    populated_field16_pcnt := AVE(GROUP,IF(h.field16 = (TYPEOF(h.field16))'',0,100));
    maxlength_field16 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.field16)));
    avelength_field16 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.field16)),h.field16<>(typeof(h.field16))'');
    populated_id__cnt := COUNT(GROUP,h.id_ <> (TYPEOF(h.id_))'');
    populated_id__pcnt := AVE(GROUP,IF(h.id_ = (TYPEOF(h.id_))'',0,100));
    maxlength_id_ := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.id_)));
    avelength_id_ := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.id_)),h.id_<>(typeof(h.id_))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_datetime_pcnt *   0.00 / 100 + T.Populated_customer_id_pcnt *   0.00 / 100 + T.Populated_search_function_name_pcnt *   0.00 / 100 + T.Populated_entity_type_pcnt *   0.00 / 100 + T.Populated_field1_pcnt *   0.00 / 100 + T.Populated_field2_pcnt *   0.00 / 100 + T.Populated_field3_pcnt *   0.00 / 100 + T.Populated_field4_pcnt *   0.00 / 100 + T.Populated_field5_pcnt *   0.00 / 100 + T.Populated_field6_pcnt *   0.00 / 100 + T.Populated_field7_pcnt *   0.00 / 100 + T.Populated_field8_pcnt *   0.00 / 100 + T.Populated_field9_pcnt *   0.00 / 100 + T.Populated_field10_pcnt *   0.00 / 100 + T.Populated_field11_pcnt *   0.00 / 100 + T.Populated_field12_pcnt *   0.00 / 100 + T.Populated_field13_pcnt *   0.00 / 100 + T.Populated_field14_pcnt *   0.00 / 100 + T.Populated_field15_pcnt *   0.00 / 100 + T.Populated_field16_pcnt *   0.00 / 100 + T.Populated_id__pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'datetime','customer_id','search_function_name','entity_type','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_');
  SELF.populated_pcnt := CHOOSE(C,le.populated_datetime_pcnt,le.populated_customer_id_pcnt,le.populated_search_function_name_pcnt,le.populated_entity_type_pcnt,le.populated_field1_pcnt,le.populated_field2_pcnt,le.populated_field3_pcnt,le.populated_field4_pcnt,le.populated_field5_pcnt,le.populated_field6_pcnt,le.populated_field7_pcnt,le.populated_field8_pcnt,le.populated_field9_pcnt,le.populated_field10_pcnt,le.populated_field11_pcnt,le.populated_field12_pcnt,le.populated_field13_pcnt,le.populated_field14_pcnt,le.populated_field15_pcnt,le.populated_field16_pcnt,le.populated_id__pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_datetime,le.maxlength_customer_id,le.maxlength_search_function_name,le.maxlength_entity_type,le.maxlength_field1,le.maxlength_field2,le.maxlength_field3,le.maxlength_field4,le.maxlength_field5,le.maxlength_field6,le.maxlength_field7,le.maxlength_field8,le.maxlength_field9,le.maxlength_field10,le.maxlength_field11,le.maxlength_field12,le.maxlength_field13,le.maxlength_field14,le.maxlength_field15,le.maxlength_field16,le.maxlength_id_);
  SELF.avelength := CHOOSE(C,le.avelength_datetime,le.avelength_customer_id,le.avelength_search_function_name,le.avelength_entity_type,le.avelength_field1,le.avelength_field2,le.avelength_field3,le.avelength_field4,le.avelength_field5,le.avelength_field6,le.avelength_field7,le.avelength_field8,le.avelength_field9,le.avelength_field10,le.avelength_field11,le.avelength_field12,le.avelength_field13,le.avelength_field14,le.avelength_field15,le.avelength_field16,le.avelength_id_);
END;
EXPORT invSummary := NORMALIZE(summary0, 21, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.customer_id),TRIM((SALT39.StrType)le.search_function_name),TRIM((SALT39.StrType)le.entity_type),TRIM((SALT39.StrType)le.field1),TRIM((SALT39.StrType)le.field2),TRIM((SALT39.StrType)le.field3),TRIM((SALT39.StrType)le.field4),TRIM((SALT39.StrType)le.field5),TRIM((SALT39.StrType)le.field6),TRIM((SALT39.StrType)le.field7),TRIM((SALT39.StrType)le.field8),TRIM((SALT39.StrType)le.field9),TRIM((SALT39.StrType)le.field10),TRIM((SALT39.StrType)le.field11),TRIM((SALT39.StrType)le.field12),TRIM((SALT39.StrType)le.field13),TRIM((SALT39.StrType)le.field14),TRIM((SALT39.StrType)le.field15),TRIM((SALT39.StrType)le.field16),TRIM((SALT39.StrType)le.id_)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 21);
  SELF.FldNo2 := 1 + (C % 21);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.customer_id),TRIM((SALT39.StrType)le.search_function_name),TRIM((SALT39.StrType)le.entity_type),TRIM((SALT39.StrType)le.field1),TRIM((SALT39.StrType)le.field2),TRIM((SALT39.StrType)le.field3),TRIM((SALT39.StrType)le.field4),TRIM((SALT39.StrType)le.field5),TRIM((SALT39.StrType)le.field6),TRIM((SALT39.StrType)le.field7),TRIM((SALT39.StrType)le.field8),TRIM((SALT39.StrType)le.field9),TRIM((SALT39.StrType)le.field10),TRIM((SALT39.StrType)le.field11),TRIM((SALT39.StrType)le.field12),TRIM((SALT39.StrType)le.field13),TRIM((SALT39.StrType)le.field14),TRIM((SALT39.StrType)le.field15),TRIM((SALT39.StrType)le.field16),TRIM((SALT39.StrType)le.id_)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.customer_id),TRIM((SALT39.StrType)le.search_function_name),TRIM((SALT39.StrType)le.entity_type),TRIM((SALT39.StrType)le.field1),TRIM((SALT39.StrType)le.field2),TRIM((SALT39.StrType)le.field3),TRIM((SALT39.StrType)le.field4),TRIM((SALT39.StrType)le.field5),TRIM((SALT39.StrType)le.field6),TRIM((SALT39.StrType)le.field7),TRIM((SALT39.StrType)le.field8),TRIM((SALT39.StrType)le.field9),TRIM((SALT39.StrType)le.field10),TRIM((SALT39.StrType)le.field11),TRIM((SALT39.StrType)le.field12),TRIM((SALT39.StrType)le.field13),TRIM((SALT39.StrType)le.field14),TRIM((SALT39.StrType)le.field15),TRIM((SALT39.StrType)le.field16),TRIM((SALT39.StrType)le.id_)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),21*21,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'datetime'}
      ,{2,'customer_id'}
      ,{3,'search_function_name'}
      ,{4,'entity_type'}
      ,{5,'field1'}
      ,{6,'field2'}
      ,{7,'field3'}
      ,{8,'field4'}
      ,{9,'field5'}
      ,{10,'field6'}
      ,{11,'field7'}
      ,{12,'field8'}
      ,{13,'field9'}
      ,{14,'field10'}
      ,{15,'field11'}
      ,{16,'field12'}
      ,{17,'field13'}
      ,{18,'field14'}
      ,{19,'field15'}
      ,{20,'field16'}
      ,{21,'id_'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_datetime((SALT39.StrType)le.datetime),
    Fields.InValid_customer_id((SALT39.StrType)le.customer_id),
    Fields.InValid_search_function_name((SALT39.StrType)le.search_function_name),
    Fields.InValid_entity_type((SALT39.StrType)le.entity_type),
    Fields.InValid_field1((SALT39.StrType)le.field1),
    Fields.InValid_field2((SALT39.StrType)le.field2),
    Fields.InValid_field3((SALT39.StrType)le.field3),
    Fields.InValid_field4((SALT39.StrType)le.field4),
    Fields.InValid_field5((SALT39.StrType)le.field5),
    Fields.InValid_field6((SALT39.StrType)le.field6),
    Fields.InValid_field7((SALT39.StrType)le.field7),
    Fields.InValid_field8((SALT39.StrType)le.field8),
    Fields.InValid_field9((SALT39.StrType)le.field9),
    Fields.InValid_field10((SALT39.StrType)le.field10),
    Fields.InValid_field11((SALT39.StrType)le.field11),
    Fields.InValid_field12((SALT39.StrType)le.field12),
    Fields.InValid_field13((SALT39.StrType)le.field13),
    Fields.InValid_field14((SALT39.StrType)le.field14),
    Fields.InValid_field15((SALT39.StrType)le.field15),
    Fields.InValid_field16((SALT39.StrType)le.field16),
    Fields.InValid_id_((SALT39.StrType)le.id_),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'datetime','datetime','datetime','datetime','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_datetime(TotalErrors.ErrorNum),Fields.InValidMessage_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_search_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_entity_type(TotalErrors.ErrorNum),Fields.InValidMessage_field1(TotalErrors.ErrorNum),Fields.InValidMessage_field2(TotalErrors.ErrorNum),Fields.InValidMessage_field3(TotalErrors.ErrorNum),Fields.InValidMessage_field4(TotalErrors.ErrorNum),Fields.InValidMessage_field5(TotalErrors.ErrorNum),Fields.InValidMessage_field6(TotalErrors.ErrorNum),Fields.InValidMessage_field7(TotalErrors.ErrorNum),Fields.InValidMessage_field8(TotalErrors.ErrorNum),Fields.InValidMessage_field9(TotalErrors.ErrorNum),Fields.InValidMessage_field10(TotalErrors.ErrorNum),Fields.InValidMessage_field11(TotalErrors.ErrorNum),Fields.InValidMessage_field12(TotalErrors.ErrorNum),Fields.InValidMessage_field13(TotalErrors.ErrorNum),Fields.InValidMessage_field14(TotalErrors.ErrorNum),Fields.InValidMessage_field15(TotalErrors.ErrorNum),Fields.InValidMessage_field16(TotalErrors.ErrorNum),Fields.InValidMessage_id_(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_Bridger, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
