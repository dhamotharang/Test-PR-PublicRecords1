IMPORT SALT311,STD;
EXPORT Input_FL_Filing_hygiene(dataset(Input_FL_Filing_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_FIC_FIL_DOC_NUM_cnt := COUNT(GROUP,h.FIC_FIL_DOC_NUM <> (TYPEOF(h.FIC_FIL_DOC_NUM))'');
    populated_FIC_FIL_DOC_NUM_pcnt := AVE(GROUP,IF(h.FIC_FIL_DOC_NUM = (TYPEOF(h.FIC_FIL_DOC_NUM))'',0,100));
    maxlength_FIC_FIL_DOC_NUM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_DOC_NUM)));
    avelength_FIC_FIL_DOC_NUM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_DOC_NUM)),h.FIC_FIL_DOC_NUM<>(typeof(h.FIC_FIL_DOC_NUM))'');
    populated_FIC_FIL_NAME_cnt := COUNT(GROUP,h.FIC_FIL_NAME <> (TYPEOF(h.FIC_FIL_NAME))'');
    populated_FIC_FIL_NAME_pcnt := AVE(GROUP,IF(h.FIC_FIL_NAME = (TYPEOF(h.FIC_FIL_NAME))'',0,100));
    maxlength_FIC_FIL_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_NAME)));
    avelength_FIC_FIL_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_NAME)),h.FIC_FIL_NAME<>(typeof(h.FIC_FIL_NAME))'');
    populated_FIC_FIL_DATE_cnt := COUNT(GROUP,h.FIC_FIL_DATE <> (TYPEOF(h.FIC_FIL_DATE))'');
    populated_FIC_FIL_DATE_pcnt := AVE(GROUP,IF(h.FIC_FIL_DATE = (TYPEOF(h.FIC_FIL_DATE))'',0,100));
    maxlength_FIC_FIL_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_DATE)));
    avelength_FIC_FIL_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_FIL_DATE)),h.FIC_FIL_DATE<>(typeof(h.FIC_FIL_DATE))'');
    populated_FIC_OWNER_DOC_NUM_cnt := COUNT(GROUP,h.FIC_OWNER_DOC_NUM <> (TYPEOF(h.FIC_OWNER_DOC_NUM))'');
    populated_FIC_OWNER_DOC_NUM_pcnt := AVE(GROUP,IF(h.FIC_OWNER_DOC_NUM = (TYPEOF(h.FIC_OWNER_DOC_NUM))'',0,100));
    maxlength_FIC_OWNER_DOC_NUM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_OWNER_DOC_NUM)));
    avelength_FIC_OWNER_DOC_NUM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_OWNER_DOC_NUM)),h.FIC_OWNER_DOC_NUM<>(typeof(h.FIC_OWNER_DOC_NUM))'');
    populated_FIC_OWNER_NAME_cnt := COUNT(GROUP,h.FIC_OWNER_NAME <> (TYPEOF(h.FIC_OWNER_NAME))'');
    populated_FIC_OWNER_NAME_pcnt := AVE(GROUP,IF(h.FIC_OWNER_NAME = (TYPEOF(h.FIC_OWNER_NAME))'',0,100));
    maxlength_FIC_OWNER_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_OWNER_NAME)));
    avelength_FIC_OWNER_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIC_OWNER_NAME)),h.FIC_OWNER_NAME<>(typeof(h.FIC_OWNER_NAME))'');
    populated_p_owner_name_cnt := COUNT(GROUP,h.p_owner_name <> (TYPEOF(h.p_owner_name))'');
    populated_p_owner_name_pcnt := AVE(GROUP,IF(h.p_owner_name = (TYPEOF(h.p_owner_name))'',0,100));
    maxlength_p_owner_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_owner_name)));
    avelength_p_owner_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_owner_name)),h.p_owner_name<>(typeof(h.p_owner_name))'');
    populated_c_owner_name_cnt := COUNT(GROUP,h.c_owner_name <> (TYPEOF(h.c_owner_name))'');
    populated_c_owner_name_pcnt := AVE(GROUP,IF(h.c_owner_name = (TYPEOF(h.c_owner_name))'',0,100));
    maxlength_c_owner_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.c_owner_name)));
    avelength_c_owner_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.c_owner_name)),h.c_owner_name<>(typeof(h.c_owner_name))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prep_owner_addr_line1_cnt := COUNT(GROUP,h.prep_owner_addr_line1 <> (TYPEOF(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_cnt := COUNT(GROUP,h.prep_owner_addr_line_last <> (TYPEOF(h.prep_owner_addr_line_last))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_seq_cnt := COUNT(GROUP,h.seq <> (TYPEOF(h.seq))'');
    populated_seq_pcnt := AVE(GROUP,IF(h.seq = (TYPEOF(h.seq))'',0,100));
    maxlength_seq := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seq)));
    avelength_seq := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seq)),h.seq<>(typeof(h.seq))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_FIC_FIL_DOC_NUM_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_NAME_pcnt *   0.00 / 100 + T.Populated_FIC_FIL_DATE_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_DOC_NUM_pcnt *   0.00 / 100 + T.Populated_FIC_OWNER_NAME_pcnt *   0.00 / 100 + T.Populated_p_owner_name_pcnt *   0.00 / 100 + T.Populated_c_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_seq_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'FIC_FIL_DOC_NUM','FIC_FIL_NAME','FIC_FIL_DATE','FIC_OWNER_DOC_NUM','FIC_OWNER_NAME','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','seq');
  SELF.populated_pcnt := CHOOSE(C,le.populated_FIC_FIL_DOC_NUM_pcnt,le.populated_FIC_FIL_NAME_pcnt,le.populated_FIC_FIL_DATE_pcnt,le.populated_FIC_OWNER_DOC_NUM_pcnt,le.populated_FIC_OWNER_NAME_pcnt,le.populated_p_owner_name_pcnt,le.populated_c_owner_name_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_seq_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_FIC_FIL_DOC_NUM,le.maxlength_FIC_FIL_NAME,le.maxlength_FIC_FIL_DATE,le.maxlength_FIC_OWNER_DOC_NUM,le.maxlength_FIC_OWNER_NAME,le.maxlength_p_owner_name,le.maxlength_c_owner_name,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_seq);
  SELF.avelength := CHOOSE(C,le.avelength_FIC_FIL_DOC_NUM,le.avelength_FIC_FIL_NAME,le.avelength_FIC_FIL_DATE,le.avelength_FIC_OWNER_DOC_NUM,le.avelength_FIC_OWNER_NAME,le.avelength_p_owner_name,le.avelength_c_owner_name,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_seq);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.FIC_FIL_DOC_NUM),TRIM((SALT311.StrType)le.FIC_FIL_NAME),TRIM((SALT311.StrType)le.FIC_FIL_DATE),TRIM((SALT311.StrType)le.FIC_OWNER_DOC_NUM),TRIM((SALT311.StrType)le.FIC_OWNER_NAME),TRIM((SALT311.StrType)le.p_owner_name),TRIM((SALT311.StrType)le.c_owner_name),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.seq)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.FIC_FIL_DOC_NUM),TRIM((SALT311.StrType)le.FIC_FIL_NAME),TRIM((SALT311.StrType)le.FIC_FIL_DATE),TRIM((SALT311.StrType)le.FIC_OWNER_DOC_NUM),TRIM((SALT311.StrType)le.FIC_OWNER_NAME),TRIM((SALT311.StrType)le.p_owner_name),TRIM((SALT311.StrType)le.c_owner_name),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.seq)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.FIC_FIL_DOC_NUM),TRIM((SALT311.StrType)le.FIC_FIL_NAME),TRIM((SALT311.StrType)le.FIC_FIL_DATE),TRIM((SALT311.StrType)le.FIC_OWNER_DOC_NUM),TRIM((SALT311.StrType)le.FIC_OWNER_NAME),TRIM((SALT311.StrType)le.p_owner_name),TRIM((SALT311.StrType)le.c_owner_name),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.seq)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'FIC_FIL_DOC_NUM'}
      ,{2,'FIC_FIL_NAME'}
      ,{3,'FIC_FIL_DATE'}
      ,{4,'FIC_OWNER_DOC_NUM'}
      ,{5,'FIC_OWNER_NAME'}
      ,{6,'p_owner_name'}
      ,{7,'c_owner_name'}
      ,{8,'prep_addr_line1'}
      ,{9,'prep_addr_line_last'}
      ,{10,'prep_owner_addr_line1'}
      ,{11,'prep_owner_addr_line_last'}
      ,{12,'seq'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Filing_Fields.InValid_FIC_FIL_DOC_NUM((SALT311.StrType)le.FIC_FIL_DOC_NUM),
    Input_FL_Filing_Fields.InValid_FIC_FIL_NAME((SALT311.StrType)le.FIC_FIL_NAME),
    Input_FL_Filing_Fields.InValid_FIC_FIL_DATE((SALT311.StrType)le.FIC_FIL_DATE),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_DOC_NUM((SALT311.StrType)le.FIC_OWNER_DOC_NUM),
    Input_FL_Filing_Fields.InValid_FIC_OWNER_NAME((SALT311.StrType)le.FIC_OWNER_NAME),
    Input_FL_Filing_Fields.InValid_p_owner_name((SALT311.StrType)le.p_owner_name),
    Input_FL_Filing_Fields.InValid_c_owner_name((SALT311.StrType)le.c_owner_name),
    Input_FL_Filing_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last),
    Input_FL_Filing_Fields.InValid_seq((SALT311.StrType)le.seq),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_FL_Filing_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Filing_Fields.InValidMessage_FIC_FIL_DOC_NUM(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_NAME(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_FIL_DATE(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_DOC_NUM(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_FIC_OWNER_NAME(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_p_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_c_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_seq(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_FL_Filing_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
