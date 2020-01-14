IMPORT ut,SALT33;
EXPORT party_aka_dba_hygiene(dataset(party_aka_dba_layout_SANCTN_NPKeys) h) := MODULE
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
    populated_incident_num_pcnt := AVE(GROUP,IF(h.incident_num = (TYPEOF(h.incident_num))'',0,100));
    maxlength_incident_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)));
    avelength_incident_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.incident_num)),h.incident_num<>(typeof(h.incident_num))'');
    populated_party_num_pcnt := AVE(GROUP,IF(h.party_num = (TYPEOF(h.party_num))'',0,100));
    maxlength_party_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_num)));
    avelength_party_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_num)),h.party_num<>(typeof(h.party_num))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_aka_dba_text_pcnt := AVE(GROUP,IF(h.aka_dba_text = (TYPEOF(h.aka_dba_text))'',0,100));
    maxlength_aka_dba_text := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.aka_dba_text)));
    avelength_aka_dba_text := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.aka_dba_text)),h.aka_dba_text<>(typeof(h.aka_dba_text))'');
    populated_party_key_pcnt := AVE(GROUP,IF(h.party_key = (TYPEOF(h.party_key))'',0,100));
    maxlength_party_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_key)));
    avelength_party_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_key)),h.party_key<>(typeof(h.party_key))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,dbcode,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_pcnt *   0.00 / 100 + T.Populated_dbcode_pcnt *   0.00 / 100 + T.Populated_incident_num_pcnt *   0.00 / 100 + T.Populated_party_num_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_aka_dba_text_pcnt *   0.00 / 100 + T.Populated_party_key_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_batch_pcnt*ri.Populated_batch_pcnt *   0.00 / 10000 + le.Populated_dbcode_pcnt*ri.Populated_dbcode_pcnt *   0.00 / 10000 + le.Populated_incident_num_pcnt*ri.Populated_incident_num_pcnt *   0.00 / 10000 + le.Populated_party_num_pcnt*ri.Populated_party_num_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_first_name_pcnt*ri.Populated_first_name_pcnt *   0.00 / 10000 + le.Populated_middle_name_pcnt*ri.Populated_middle_name_pcnt *   0.00 / 10000 + le.Populated_last_name_pcnt*ri.Populated_last_name_pcnt *   0.00 / 10000 + le.Populated_aka_dba_text_pcnt*ri.Populated_aka_dba_text_pcnt *   0.00 / 10000 + le.Populated_party_key_pcnt*ri.Populated_party_key_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'batch','dbcode','incident_num','party_num','name_type','first_name','middle_name','last_name','aka_dba_text','party_key');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_pcnt,le.populated_dbcode_pcnt,le.populated_incident_num_pcnt,le.populated_party_num_pcnt,le.populated_name_type_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_pcnt,le.populated_aka_dba_text_pcnt,le.populated_party_key_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch,le.maxlength_dbcode,le.maxlength_incident_num,le.maxlength_party_num,le.maxlength_name_type,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name,le.maxlength_aka_dba_text,le.maxlength_party_key);
  SELF.avelength := CHOOSE(C,le.avelength_batch,le.avelength_dbcode,le.avelength_incident_num,le.avelength_party_num,le.avelength_name_type,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name,le.avelength_aka_dba_text,le.avelength_party_key);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.dbcode;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.first_name),TRIM((SALT33.StrType)le.middle_name),TRIM((SALT33.StrType)le.last_name),TRIM((SALT33.StrType)le.aka_dba_text),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.first_name),TRIM((SALT33.StrType)le.middle_name),TRIM((SALT33.StrType)le.last_name),TRIM((SALT33.StrType)le.aka_dba_text),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.party_num),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.first_name),TRIM((SALT33.StrType)le.middle_name),TRIM((SALT33.StrType)le.last_name),TRIM((SALT33.StrType)le.aka_dba_text),IF (le.party_key <> 0,TRIM((SALT33.StrType)le.party_key), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch'}
      ,{2,'dbcode'}
      ,{3,'incident_num'}
      ,{4,'party_num'}
      ,{5,'name_type'}
      ,{6,'first_name'}
      ,{7,'middle_name'}
      ,{8,'last_name'}
      ,{9,'aka_dba_text'}
      ,{10,'party_key'}],SALT33.MAC_Character_Counts.Field_Identification);
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
    party_aka_dba_Fields.InValid_batch((SALT33.StrType)le.batch),
    party_aka_dba_Fields.InValid_dbcode((SALT33.StrType)le.dbcode),
    party_aka_dba_Fields.InValid_incident_num((SALT33.StrType)le.incident_num),
    party_aka_dba_Fields.InValid_party_num((SALT33.StrType)le.party_num),
    party_aka_dba_Fields.InValid_name_type((SALT33.StrType)le.name_type),
    party_aka_dba_Fields.InValid_first_name((SALT33.StrType)le.first_name),
    party_aka_dba_Fields.InValid_middle_name((SALT33.StrType)le.middle_name),
    party_aka_dba_Fields.InValid_last_name((SALT33.StrType)le.last_name),
    party_aka_dba_Fields.InValid_aka_dba_text((SALT33.StrType)le.aka_dba_text),
    party_aka_dba_Fields.InValid_party_key((SALT33.StrType)le.party_key),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.dbcode := le.dbcode;
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.dbcode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,dbcode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.dbcode;
  FieldNme := party_aka_dba_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_NameType','Unknown','Unknown','Unknown','Unknown','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,party_aka_dba_Fields.InValidMessage_batch(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_dbcode(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_incident_num(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_party_num(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_name_type(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_aka_dba_text(TotalErrors.ErrorNum),party_aka_dba_Fields.InValidMessage_party_key(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.dbcode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
