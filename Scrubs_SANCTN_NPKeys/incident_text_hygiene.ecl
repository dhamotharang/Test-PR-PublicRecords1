IMPORT ut,SALT33;
EXPORT incident_text_hygiene(dataset(incident_text_layout_SANCTN_NPKeys) h) := MODULE
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
    populated_seq_pcnt := AVE(GROUP,IF(h.seq = (TYPEOF(h.seq))'',0,100));
    maxlength_seq := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seq)));
    avelength_seq := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seq)),h.seq<>(typeof(h.seq))'');
    populated_field_name_pcnt := AVE(GROUP,IF(h.field_name = (TYPEOF(h.field_name))'',0,100));
    maxlength_field_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_name)));
    avelength_field_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_name)),h.field_name<>(typeof(h.field_name))'');
    populated_field_txt_pcnt := AVE(GROUP,IF(h.field_txt = (TYPEOF(h.field_txt))'',0,100));
    maxlength_field_txt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_txt)));
    avelength_field_txt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.field_txt)),h.field_txt<>(typeof(h.field_txt))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,dbcode,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_pcnt *   0.00 / 100 + T.Populated_dbcode_pcnt *   0.00 / 100 + T.Populated_incident_num_pcnt *   0.00 / 100 + T.Populated_seq_pcnt *   0.00 / 100 + T.Populated_field_name_pcnt *   0.00 / 100 + T.Populated_field_txt_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_batch_pcnt*ri.Populated_batch_pcnt *   0.00 / 10000 + le.Populated_dbcode_pcnt*ri.Populated_dbcode_pcnt *   0.00 / 10000 + le.Populated_incident_num_pcnt*ri.Populated_incident_num_pcnt *   0.00 / 10000 + le.Populated_seq_pcnt*ri.Populated_seq_pcnt *   0.00 / 10000 + le.Populated_field_name_pcnt*ri.Populated_field_name_pcnt *   0.00 / 10000 + le.Populated_field_txt_pcnt*ri.Populated_field_txt_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'batch','dbcode','incident_num','seq','field_name','field_txt');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_pcnt,le.populated_dbcode_pcnt,le.populated_incident_num_pcnt,le.populated_seq_pcnt,le.populated_field_name_pcnt,le.populated_field_txt_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch,le.maxlength_dbcode,le.maxlength_incident_num,le.maxlength_seq,le.maxlength_field_name,le.maxlength_field_txt);
  SELF.avelength := CHOOSE(C,le.avelength_batch,le.avelength_dbcode,le.avelength_incident_num,le.avelength_seq,le.avelength_field_name,le.avelength_field_txt);
END;
EXPORT invSummary := NORMALIZE(summary0, 6, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.dbcode;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.seq),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.field_txt)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,6,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 6);
  SELF.FldNo2 := 1 + (C % 6);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.seq),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.field_txt)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.batch),TRIM((SALT33.StrType)le.dbcode),TRIM((SALT33.StrType)le.incident_num),TRIM((SALT33.StrType)le.seq),TRIM((SALT33.StrType)le.field_name),TRIM((SALT33.StrType)le.field_txt)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),6*6,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch'}
      ,{2,'dbcode'}
      ,{3,'incident_num'}
      ,{4,'seq'}
      ,{5,'field_name'}
      ,{6,'field_txt'}],SALT33.MAC_Character_Counts.Field_Identification);
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
    incident_text_Fields.InValid_batch((SALT33.StrType)le.batch),
    incident_text_Fields.InValid_dbcode((SALT33.StrType)le.dbcode),
    incident_text_Fields.InValid_incident_num((SALT33.StrType)le.incident_num),
    incident_text_Fields.InValid_seq((SALT33.StrType)le.seq),
    incident_text_Fields.InValid_field_name((SALT33.StrType)le.field_name),
    incident_text_Fields.InValid_field_txt((SALT33.StrType)le.field_txt),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.dbcode := le.dbcode;
END;
Errors := NORMALIZE(h,6,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.dbcode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,dbcode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.dbcode;
  FieldNme := incident_text_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,incident_text_Fields.InValidMessage_batch(TotalErrors.ErrorNum),incident_text_Fields.InValidMessage_dbcode(TotalErrors.ErrorNum),incident_text_Fields.InValidMessage_incident_num(TotalErrors.ErrorNum),incident_text_Fields.InValidMessage_seq(TotalErrors.ErrorNum),incident_text_Fields.InValidMessage_field_name(TotalErrors.ErrorNum),incident_text_Fields.InValidMessage_field_txt(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.dbcode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
