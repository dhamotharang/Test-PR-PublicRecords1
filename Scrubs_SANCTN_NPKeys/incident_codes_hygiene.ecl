IMPORT ut,SALT33;
EXPORT incident_codes_hygiene(dataset(incident_codes_layout_SANCTN_NPKeys) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.dbcode);    NumberOfRecords := COUNT(GROUP);
    populated_batch_pcnt := AVE(GROUP,IF(h.batch = (TYPEOF(h.batch))'',0,100));
    maxlength_batch := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch)));
    avelength_batch := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.batch)),h.batch<>(typeof(h.batch))'');
    populated_dbcode_pcnt := AVE(GROUP,IF(h.dbcode = (TYPEOF(h.dbcode))'',0,100));
    maxlength_dbcode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)));
    avelength_dbcode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbcode)),h.dbcode<>(typeof(h.dbcode))'');
    populated_primary_key_pcnt := AVE(GROUP,IF(h.primary_key = (TYPEOF(h.primary_key))'',0,100));
    maxlength_primary_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.primary_key)));
    avelength_primary_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.primary_key)),h.primary_key<>(typeof(h.primary_key))'');
    populated_foreign_key_pcnt := AVE(GROUP,IF(h.foreign_key = (TYPEOF(h.foreign_key))'',0,100));
    maxlength_foreign_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.foreign_key)));
    avelength_foreign_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.foreign_key)),h.foreign_key<>(typeof(h.foreign_key))'');
    populated_incident_num_pcnt := AVE(GROUP,IF(h.incident_num = (TYPEOF(h.incident_num))'',0,100));
    maxlength_incident_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)));
    avelength_incident_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)),h.incident_num<>(typeof(h.incident_num))'');
    populated_number_pcnt := AVE(GROUP,IF(h.number = (TYPEOF(h.number))'',0,100));
    maxlength_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number)));
    avelength_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number)),h.number<>(typeof(h.number))'');
    populated_field_name_pcnt := AVE(GROUP,IF(h.field_name = (TYPEOF(h.field_name))'',0,100));
    maxlength_field_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_name)));
    avelength_field_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_name)),h.field_name<>(typeof(h.field_name))'');
    populated_code_type_pcnt := AVE(GROUP,IF(h.code_type = (TYPEOF(h.code_type))'',0,100));
    maxlength_code_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_type)));
    avelength_code_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_type)),h.code_type<>(typeof(h.code_type))'');
    populated_code_value_pcnt := AVE(GROUP,IF(h.code_value = (TYPEOF(h.code_value))'',0,100));
    maxlength_code_value := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_value)));
    avelength_code_value := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_value)),h.code_value<>(typeof(h.code_value))'');
    populated_code_state_pcnt := AVE(GROUP,IF(h.code_state = (TYPEOF(h.code_state))'',0,100));
    maxlength_code_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_state)));
    avelength_code_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.code_state)),h.code_state<>(typeof(h.code_state))'');
    populated_other_desc_pcnt := AVE(GROUP,IF(h.other_desc = (TYPEOF(h.other_desc))'',0,100));
    maxlength_other_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_desc)));
    avelength_other_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_desc)),h.other_desc<>(typeof(h.other_desc))'');
    populated_std_type_desc_pcnt := AVE(GROUP,IF(h.std_type_desc = (TYPEOF(h.std_type_desc))'',0,100));
    maxlength_std_type_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.std_type_desc)));
    avelength_std_type_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.std_type_desc)),h.std_type_desc<>(typeof(h.std_type_desc))'');
    populated_cln_license_number_pcnt := AVE(GROUP,IF(h.cln_license_number = (TYPEOF(h.cln_license_number))'',0,100));
    maxlength_cln_license_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cln_license_number)));
    avelength_cln_license_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cln_license_number)),h.cln_license_number<>(typeof(h.cln_license_number))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,dbcode,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_pcnt *   0.00 / 100 + T.Populated_dbcode_pcnt *   0.00 / 100 + T.Populated_primary_key_pcnt *   0.00 / 100 + T.Populated_foreign_key_pcnt *   0.00 / 100 + T.Populated_incident_num_pcnt *   0.00 / 100 + T.Populated_number_pcnt *   0.00 / 100 + T.Populated_field_name_pcnt *   0.00 / 100 + T.Populated_code_type_pcnt *   0.00 / 100 + T.Populated_code_value_pcnt *   0.00 / 100 + T.Populated_code_state_pcnt *   0.00 / 100 + T.Populated_other_desc_pcnt *   0.00 / 100 + T.Populated_std_type_desc_pcnt *   0.00 / 100 + T.Populated_cln_license_number_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING dbcode1;
    STRING dbcode2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.dbcode1 := le.Source;
    SELF.dbcode2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_batch_pcnt*ri.Populated_batch_pcnt *   0.00 / 10000 + le.Populated_dbcode_pcnt*ri.Populated_dbcode_pcnt *   0.00 / 10000 + le.Populated_primary_key_pcnt*ri.Populated_primary_key_pcnt *   0.00 / 10000 + le.Populated_foreign_key_pcnt*ri.Populated_foreign_key_pcnt *   0.00 / 10000 + le.Populated_incident_num_pcnt*ri.Populated_incident_num_pcnt *   0.00 / 10000 + le.Populated_number_pcnt*ri.Populated_number_pcnt *   0.00 / 10000 + le.Populated_field_name_pcnt*ri.Populated_field_name_pcnt *   0.00 / 10000 + le.Populated_code_type_pcnt*ri.Populated_code_type_pcnt *   0.00 / 10000 + le.Populated_code_value_pcnt*ri.Populated_code_value_pcnt *   0.00 / 10000 + le.Populated_code_state_pcnt*ri.Populated_code_state_pcnt *   0.00 / 10000 + le.Populated_other_desc_pcnt*ri.Populated_other_desc_pcnt *   0.00 / 10000 + le.Populated_std_type_desc_pcnt*ri.Populated_std_type_desc_pcnt *   0.00 / 10000 + le.Populated_cln_license_number_pcnt*ri.Populated_cln_license_number_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'batch','dbcode','primary_key','foreign_key','incident_num','number','field_name','code_type','code_value','code_state','other_desc','std_type_desc','cln_license_number');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_pcnt,le.populated_dbcode_pcnt,le.populated_primary_key_pcnt,le.populated_foreign_key_pcnt,le.populated_incident_num_pcnt,le.populated_number_pcnt,le.populated_field_name_pcnt,le.populated_code_type_pcnt,le.populated_code_value_pcnt,le.populated_code_state_pcnt,le.populated_other_desc_pcnt,le.populated_std_type_desc_pcnt,le.populated_cln_license_number_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch,le.maxlength_dbcode,le.maxlength_primary_key,le.maxlength_foreign_key,le.maxlength_incident_num,le.maxlength_number,le.maxlength_field_name,le.maxlength_code_type,le.maxlength_code_value,le.maxlength_code_state,le.maxlength_other_desc,le.maxlength_std_type_desc,le.maxlength_cln_license_number);
  SELF.avelength := CHOOSE(C,le.avelength_batch,le.avelength_dbcode,le.avelength_primary_key,le.avelength_foreign_key,le.avelength_incident_num,le.avelength_number,le.avelength_field_name,le.avelength_code_type,le.avelength_code_value,le.avelength_code_state,le.avelength_other_desc,le.avelength_std_type_desc,le.avelength_cln_license_number);
END;
EXPORT invSummary := NORMALIZE(summary0, 13, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.dbcode;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),IF (le.primary_key <> 0,TRIM((SALT33.StrType)le.primary_key), ''),IF (le.foreign_key <> 0,TRIM((SALT33.StrType)le.foreign_key), ''),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.number),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.code_type),TRIM((SALT33.StrType)le.code_value),TRIM((SALT33.StrType)le.code_state),TRIM((SALT33.StrType)le.other_desc),TRIM((SALT33.StrType)le.std_type_desc),TRIM((SALT33.StrType)le.cln_license_number)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,13,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 13);
  SELF.FldNo2 := 1 + (C % 13);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),IF (le.primary_key <> 0,TRIM((SALT33.StrType)le.primary_key), ''),IF (le.foreign_key <> 0,TRIM((SALT33.StrType)le.foreign_key), ''),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.number),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.code_type),TRIM((SALT33.StrType)le.code_value),TRIM((SALT33.StrType)le.code_state),TRIM((SALT33.StrType)le.other_desc),TRIM((SALT33.StrType)le.std_type_desc),TRIM((SALT33.StrType)le.cln_license_number)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),IF (le.primary_key <> 0,TRIM((SALT33.StrType)le.primary_key), ''),IF (le.foreign_key <> 0,TRIM((SALT33.StrType)le.foreign_key), ''),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.number),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.code_type),TRIM((SALT33.StrType)le.code_value),TRIM((SALT33.StrType)le.code_state),TRIM((SALT33.StrType)le.other_desc),TRIM((SALT33.StrType)le.std_type_desc),TRIM((SALT33.StrType)le.cln_license_number)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),13*13,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch'}
      ,{2,'dbcode'}
      ,{3,'primary_key'}
      ,{4,'foreign_key'}
      ,{5,'incident_num'}
      ,{6,'number'}
      ,{7,'field_name'}
      ,{8,'code_type'}
      ,{9,'code_value'}
      ,{10,'code_state'}
      ,{11,'other_desc'}
      ,{12,'std_type_desc'}
      ,{13,'cln_license_number'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.dbcode) dbcode; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    incident_codes_Fields.InValid_batch((SALT33.StrType)le.batch),
    incident_codes_Fields.InValid_dbcode((SALT33.StrType)le.dbcode),
    incident_codes_Fields.InValid_primary_key((SALT33.StrType)le.primary_key),
    incident_codes_Fields.InValid_foreign_key((SALT33.StrType)le.foreign_key),
    incident_codes_Fields.InValid_incident_num((SALT33.StrType)le.incident_num),
    incident_codes_Fields.InValid_number((SALT33.StrType)le.number),
    incident_codes_Fields.InValid_field_name((SALT33.StrType)le.field_name),
    incident_codes_Fields.InValid_code_type((SALT33.StrType)le.code_type,(SALT33.StrType)le.field_name),
    incident_codes_Fields.InValid_code_value((SALT33.StrType)le.code_value,(SALT33.StrType)le.field_name),
    incident_codes_Fields.InValid_code_state((SALT33.StrType)le.code_state),
    incident_codes_Fields.InValid_other_desc((SALT33.StrType)le.other_desc),
    incident_codes_Fields.InValid_std_type_desc((SALT33.StrType)le.std_type_desc),
    incident_codes_Fields.InValid_cln_license_number((SALT33.StrType)le.cln_license_number),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.dbcode := le.dbcode;
END;
Errors := NORMALIZE(h,13,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.dbcode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,dbcode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.dbcode;
  FieldNme := incident_codes_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Field','Invalid_LicenceCode','Invalid_ProfessionCode','Invalid_State','Unknown','Unknown','Invalid_Licence');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,incident_codes_Fields.InValidMessage_batch(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_dbcode(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_primary_key(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_foreign_key(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_incident_num(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_number(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_field_name(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_code_type(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_code_value(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_code_state(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_other_desc(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_std_type_desc(TotalErrors.ErrorNum),incident_codes_Fields.InValidMessage_cln_license_number(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.dbcode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
