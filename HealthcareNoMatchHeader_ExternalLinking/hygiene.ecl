IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_HEADER) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.SRC))'', MAX(GROUP,h.SRC));
    NumberOfRecords := COUNT(GROUP);
    populated_SRC_cnt := COUNT(GROUP,h.SRC <> (TYPEOF(h.SRC))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_SSN_cnt := COUNT(GROUP,h.SSN <> (TYPEOF(h.SSN))'');
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_DOB_cnt := COUNT(GROUP,h.DOB <> (TYPEOF(h.DOB))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_LEXID_cnt := COUNT(GROUP,h.LEXID <> (TYPEOF(h.LEXID))'');
    populated_LEXID_pcnt := AVE(GROUP,IF(h.LEXID = (TYPEOF(h.LEXID))'',0,100));
    maxlength_LEXID := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.LEXID)));
    avelength_LEXID := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.LEXID)),h.LEXID<>(typeof(h.LEXID))'');
    populated_SUFFIX_cnt := COUNT(GROUP,h.SUFFIX <> (TYPEOF(h.SUFFIX))'');
    populated_SUFFIX_pcnt := AVE(GROUP,IF(h.SUFFIX = (TYPEOF(h.SUFFIX))'',0,100));
    maxlength_SUFFIX := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SUFFIX)));
    avelength_SUFFIX := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SUFFIX)),h.SUFFIX<>(typeof(h.SUFFIX))'');
    populated_FNAME_cnt := COUNT(GROUP,h.FNAME <> (TYPEOF(h.FNAME))'');
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_MNAME_cnt := COUNT(GROUP,h.MNAME <> (TYPEOF(h.MNAME))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_LNAME_cnt := COUNT(GROUP,h.LNAME <> (TYPEOF(h.LNAME))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_GENDER_cnt := COUNT(GROUP,h.GENDER <> (TYPEOF(h.GENDER))'');
    populated_GENDER_pcnt := AVE(GROUP,IF(h.GENDER = (TYPEOF(h.GENDER))'',0,100));
    maxlength_GENDER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.GENDER)));
    avelength_GENDER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.GENDER)),h.GENDER<>(typeof(h.GENDER))'');
    populated_PRIM_NAME_cnt := COUNT(GROUP,h.PRIM_NAME <> (TYPEOF(h.PRIM_NAME))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_PRIM_RANGE_cnt := COUNT(GROUP,h.PRIM_RANGE <> (TYPEOF(h.PRIM_RANGE))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_SEC_RANGE_cnt := COUNT(GROUP,h.SEC_RANGE <> (TYPEOF(h.SEC_RANGE))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_CITY_NAME_cnt := COUNT(GROUP,h.CITY_NAME <> (TYPEOF(h.CITY_NAME))'');
    populated_CITY_NAME_pcnt := AVE(GROUP,IF(h.CITY_NAME = (TYPEOF(h.CITY_NAME))'',0,100));
    maxlength_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.CITY_NAME)));
    avelength_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.CITY_NAME)),h.CITY_NAME<>(typeof(h.CITY_NAME))'');
    populated_ST_cnt := COUNT(GROUP,h.ST <> (TYPEOF(h.ST))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_ZIP_cnt := COUNT(GROUP,h.ZIP <> (TYPEOF(h.ZIP))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_DT_FIRST_SEEN_cnt := COUNT(GROUP,h.DT_FIRST_SEEN <> (TYPEOF(h.DT_FIRST_SEEN))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_cnt := COUNT(GROUP,h.DT_LAST_SEEN <> (TYPEOF(h.DT_LAST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,SRC,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_SRC_pcnt *   0.00 / 100 + T.Populated_SSN_pcnt *   0.00 / 100 + T.Populated_DOB_pcnt *   0.00 / 100 + T.Populated_LEXID_pcnt *  18.00 / 100 + T.Populated_SUFFIX_pcnt *  10.00 / 100 + T.Populated_FNAME_pcnt *   8.00 / 100 + T.Populated_MNAME_pcnt *  14.00 / 100 + T.Populated_LNAME_pcnt *  10.00 / 100 + T.Populated_GENDER_pcnt *   1.00 / 100 + T.Populated_PRIM_NAME_pcnt *  10.00 / 100 + T.Populated_PRIM_RANGE_pcnt *  13.00 / 100 + T.Populated_SEC_RANGE_pcnt *   8.00 / 100 + T.Populated_CITY_NAME_pcnt *   6.00 / 100 + T.Populated_ST_pcnt *   0.00 / 100 + T.Populated_ZIP_pcnt *   6.00 / 100 + T.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_LAST_SEEN_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING SRC1;
    STRING SRC2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.SRC1 := le.Source;
    SELF.SRC2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_SRC_pcnt*ri.Populated_SRC_pcnt *   0.00 / 10000 + le.Populated_SSN_pcnt*ri.Populated_SSN_pcnt *   0.00 / 10000 + le.Populated_DOB_pcnt*ri.Populated_DOB_pcnt *   0.00 / 10000 + le.Populated_LEXID_pcnt*ri.Populated_LEXID_pcnt *  18.00 / 10000 + le.Populated_SUFFIX_pcnt*ri.Populated_SUFFIX_pcnt *  10.00 / 10000 + le.Populated_FNAME_pcnt*ri.Populated_FNAME_pcnt *   8.00 / 10000 + le.Populated_MNAME_pcnt*ri.Populated_MNAME_pcnt *  14.00 / 10000 + le.Populated_LNAME_pcnt*ri.Populated_LNAME_pcnt *  10.00 / 10000 + le.Populated_GENDER_pcnt*ri.Populated_GENDER_pcnt *   1.00 / 10000 + le.Populated_PRIM_NAME_pcnt*ri.Populated_PRIM_NAME_pcnt *  10.00 / 10000 + le.Populated_PRIM_RANGE_pcnt*ri.Populated_PRIM_RANGE_pcnt *  13.00 / 10000 + le.Populated_SEC_RANGE_pcnt*ri.Populated_SEC_RANGE_pcnt *   8.00 / 10000 + le.Populated_CITY_NAME_pcnt*ri.Populated_CITY_NAME_pcnt *   6.00 / 10000 + le.Populated_ST_pcnt*ri.Populated_ST_pcnt *   0.00 / 10000 + le.Populated_ZIP_pcnt*ri.Populated_ZIP_pcnt *   6.00 / 10000 + le.Populated_DT_FIRST_SEEN_pcnt*ri.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_LAST_SEEN_pcnt*ri.Populated_DT_LAST_SEEN_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'SRC','SSN','DOB','LEXID','SUFFIX','FNAME','MNAME','LNAME','GENDER','PRIM_NAME','PRIM_RANGE','SEC_RANGE','CITY_NAME','ST','ZIP','DT_FIRST_SEEN','DT_LAST_SEEN');
  SELF.populated_pcnt := CHOOSE(C,le.populated_SRC_pcnt,le.populated_SSN_pcnt,le.populated_DOB_pcnt,le.populated_LEXID_pcnt,le.populated_SUFFIX_pcnt,le.populated_FNAME_pcnt,le.populated_MNAME_pcnt,le.populated_LNAME_pcnt,le.populated_GENDER_pcnt,le.populated_PRIM_NAME_pcnt,le.populated_PRIM_RANGE_pcnt,le.populated_SEC_RANGE_pcnt,le.populated_CITY_NAME_pcnt,le.populated_ST_pcnt,le.populated_ZIP_pcnt,le.populated_DT_FIRST_SEEN_pcnt,le.populated_DT_LAST_SEEN_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_SRC,le.maxlength_SSN,le.maxlength_DOB,le.maxlength_LEXID,le.maxlength_SUFFIX,le.maxlength_FNAME,le.maxlength_MNAME,le.maxlength_LNAME,le.maxlength_GENDER,le.maxlength_PRIM_NAME,le.maxlength_PRIM_RANGE,le.maxlength_SEC_RANGE,le.maxlength_CITY_NAME,le.maxlength_ST,le.maxlength_ZIP,le.maxlength_DT_FIRST_SEEN,le.maxlength_DT_LAST_SEEN);
  SELF.avelength := CHOOSE(C,le.avelength_SRC,le.avelength_SSN,le.avelength_DOB,le.avelength_LEXID,le.avelength_SUFFIX,le.avelength_FNAME,le.avelength_MNAME,le.avelength_LNAME,le.avelength_GENDER,le.avelength_PRIM_NAME,le.avelength_PRIM_RANGE,le.avelength_SEC_RANGE,le.avelength_CITY_NAME,le.avelength_ST,le.avelength_ZIP,le.avelength_DT_FIRST_SEEN,le.avelength_DT_LAST_SEEN);
END;
EXPORT invSummary := NORMALIZE(summary0, 17, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.nomatch_id;
  SELF.Src := le.SRC;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SSN),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.LEXID),TRIM((SALT311.StrType)le.SUFFIX),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.GENDER),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY_NAME),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,17,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 17);
  SELF.FldNo2 := 1 + (C % 17);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SSN),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.LEXID),TRIM((SALT311.StrType)le.SUFFIX),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.GENDER),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY_NAME),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.SRC),TRIM((SALT311.StrType)le.SSN),TRIM((SALT311.StrType)le.DOB),TRIM((SALT311.StrType)le.LEXID),TRIM((SALT311.StrType)le.SUFFIX),TRIM((SALT311.StrType)le.FNAME),TRIM((SALT311.StrType)le.MNAME),TRIM((SALT311.StrType)le.LNAME),TRIM((SALT311.StrType)le.GENDER),TRIM((SALT311.StrType)le.PRIM_NAME),TRIM((SALT311.StrType)le.PRIM_RANGE),TRIM((SALT311.StrType)le.SEC_RANGE),TRIM((SALT311.StrType)le.CITY_NAME),TRIM((SALT311.StrType)le.ST),TRIM((SALT311.StrType)le.ZIP),TRIM((SALT311.StrType)le.DT_FIRST_SEEN),TRIM((SALT311.StrType)le.DT_LAST_SEEN)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),17*17,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'SRC'}
      ,{2,'SSN'}
      ,{3,'DOB'}
      ,{4,'LEXID'}
      ,{5,'SUFFIX'}
      ,{6,'FNAME'}
      ,{7,'MNAME'}
      ,{8,'LNAME'}
      ,{9,'GENDER'}
      ,{10,'PRIM_NAME'}
      ,{11,'PRIM_RANGE'}
      ,{12,'SEC_RANGE'}
      ,{13,'CITY_NAME'}
      ,{14,'ST'}
      ,{15,'ZIP'}
      ,{16,'DT_FIRST_SEEN'}
      ,{17,'DT_LAST_SEEN'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SRC) SRC; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_SRC((SALT311.StrType)le.SRC),
    Fields.InValid_SSN((SALT311.StrType)le.SSN),
    Fields.InValid_DOB((SALT311.StrType)le.DOB),
    Fields.InValid_LEXID((SALT311.StrType)le.LEXID),
    Fields.InValid_SUFFIX((SALT311.StrType)le.SUFFIX),
    Fields.InValid_FNAME((SALT311.StrType)le.FNAME),
    Fields.InValid_MNAME((SALT311.StrType)le.MNAME),
    Fields.InValid_LNAME((SALT311.StrType)le.LNAME),
    Fields.InValid_GENDER((SALT311.StrType)le.GENDER),
    Fields.InValid_PRIM_NAME((SALT311.StrType)le.PRIM_NAME),
    Fields.InValid_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE),
    Fields.InValid_SEC_RANGE((SALT311.StrType)le.SEC_RANGE),
    Fields.InValid_CITY_NAME((SALT311.StrType)le.CITY_NAME),
    Fields.InValid_ST((SALT311.StrType)le.ST),
    Fields.InValid_ZIP((SALT311.StrType)le.ZIP),
    Fields.InValid_DT_FIRST_SEEN((SALT311.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT311.StrType)le.DT_LAST_SEEN),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SRC := le.SRC;
END;
Errors := NORMALIZE(h,22,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.SRC;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.SRC;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'DEFAULT','NUMBER','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_LEXID(TotalErrors.ErrorNum),Fields.InValidMessage_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),'','','','','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.SRC=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have nomatch_id specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,nomatch_id);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,nomatch_id,SRC);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(HealthcareNoMatchHeader_ExternalLinking, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
