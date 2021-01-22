IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_tris_lnssi) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_contrib_risk_field_cnt := COUNT(GROUP,h.contrib_risk_field <> (TYPEOF(h.contrib_risk_field))'');
    populated_contrib_risk_field_pcnt := AVE(GROUP,IF(h.contrib_risk_field = (TYPEOF(h.contrib_risk_field))'',0,100));
    maxlength_contrib_risk_field := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_field)));
    avelength_contrib_risk_field := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_field)),h.contrib_risk_field<>(typeof(h.contrib_risk_field))'');
    populated_contrib_risk_value_cnt := COUNT(GROUP,h.contrib_risk_value <> (TYPEOF(h.contrib_risk_value))'');
    populated_contrib_risk_value_pcnt := AVE(GROUP,IF(h.contrib_risk_value = (TYPEOF(h.contrib_risk_value))'',0,100));
    maxlength_contrib_risk_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_value)));
    avelength_contrib_risk_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_value)),h.contrib_risk_value<>(typeof(h.contrib_risk_value))'');
    populated_contrib_risk_attr_cnt := COUNT(GROUP,h.contrib_risk_attr <> (TYPEOF(h.contrib_risk_attr))'');
    populated_contrib_risk_attr_pcnt := AVE(GROUP,IF(h.contrib_risk_attr = (TYPEOF(h.contrib_risk_attr))'',0,100));
    maxlength_contrib_risk_attr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_attr)));
    avelength_contrib_risk_attr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_risk_attr)),h.contrib_risk_attr<>(typeof(h.contrib_risk_attr))'');
    populated_contrib_state_excl_cnt := COUNT(GROUP,h.contrib_state_excl <> (TYPEOF(h.contrib_state_excl))'');
    populated_contrib_state_excl_pcnt := AVE(GROUP,IF(h.contrib_state_excl = (TYPEOF(h.contrib_state_excl))'',0,100));
    maxlength_contrib_state_excl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_state_excl)));
    avelength_contrib_state_excl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_state_excl)),h.contrib_state_excl<>(typeof(h.contrib_state_excl))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_contrib_risk_field_pcnt *   0.00 / 100 + T.Populated_contrib_risk_value_pcnt *   0.00 / 100 + T.Populated_contrib_risk_attr_pcnt *   0.00 / 100 + T.Populated_contrib_state_excl_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'contrib_risk_field','contrib_risk_value','contrib_risk_attr','contrib_state_excl');
  SELF.populated_pcnt := CHOOSE(C,le.populated_contrib_risk_field_pcnt,le.populated_contrib_risk_value_pcnt,le.populated_contrib_risk_attr_pcnt,le.populated_contrib_state_excl_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_contrib_risk_field,le.maxlength_contrib_risk_value,le.maxlength_contrib_risk_attr,le.maxlength_contrib_state_excl);
  SELF.avelength := CHOOSE(C,le.avelength_contrib_risk_field,le.avelength_contrib_risk_value,le.avelength_contrib_risk_attr,le.avelength_contrib_state_excl);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.contrib_risk_field),TRIM((SALT311.StrType)le.contrib_risk_value),TRIM((SALT311.StrType)le.contrib_risk_attr),TRIM((SALT311.StrType)le.contrib_state_excl)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.contrib_risk_field),TRIM((SALT311.StrType)le.contrib_risk_value),TRIM((SALT311.StrType)le.contrib_risk_attr),TRIM((SALT311.StrType)le.contrib_state_excl)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.contrib_risk_field),TRIM((SALT311.StrType)le.contrib_risk_value),TRIM((SALT311.StrType)le.contrib_risk_attr),TRIM((SALT311.StrType)le.contrib_state_excl)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'contrib_risk_field'}
      ,{2,'contrib_risk_value'}
      ,{3,'contrib_risk_attr'}
      ,{4,'contrib_state_excl'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_contrib_risk_field((SALT311.StrType)le.contrib_risk_field),
    Fields.InValid_contrib_risk_value((SALT311.StrType)le.contrib_risk_value),
    Fields.InValid_contrib_risk_attr((SALT311.StrType)le.contrib_risk_attr),
    Fields.InValid_contrib_state_excl((SALT311.StrType)le.contrib_state_excl),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,4,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_AlphaNumDash','Invalid_AlphaNumPunc','Invalid_num','Invalid_AlphaState');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_contrib_risk_field(TotalErrors.ErrorNum),Fields.InValidMessage_contrib_risk_value(TotalErrors.ErrorNum),Fields.InValidMessage_contrib_risk_attr(TotalErrors.ErrorNum),Fields.InValidMessage_contrib_state_excl(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(scrubs_tris_lnssi, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
