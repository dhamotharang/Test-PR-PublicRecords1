IMPORT SALT311,STD;
EXPORT Input_CA_Ventura_hygiene(dataset(Input_CA_Ventura_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_recorded_date_cnt := COUNT(GROUP,h.recorded_date <> (TYPEOF(h.recorded_date))'');
    populated_recorded_date_pcnt := AVE(GROUP,IF(h.recorded_date = (TYPEOF(h.recorded_date))'',0,100));
    maxlength_recorded_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorded_date)));
    avelength_recorded_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorded_date)),h.recorded_date<>(typeof(h.recorded_date))'');
    populated_business_name_cnt := COUNT(GROUP,h.business_name <> (TYPEOF(h.business_name))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_owner_name_cnt := COUNT(GROUP,h.owner_name <> (TYPEOF(h.owner_name))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_start_date_cnt := COUNT(GROUP,h.start_date <> (TYPEOF(h.start_date))'');
    populated_start_date_pcnt := AVE(GROUP,IF(h.start_date = (TYPEOF(h.start_date))'',0,100));
    maxlength_start_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.start_date)));
    avelength_start_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.start_date)),h.start_date<>(typeof(h.start_date))'');
    populated_abandondate_cnt := COUNT(GROUP,h.abandondate <> (TYPEOF(h.abandondate))'');
    populated_abandondate_pcnt := AVE(GROUP,IF(h.abandondate = (TYPEOF(h.abandondate))'',0,100));
    maxlength_abandondate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.abandondate)));
    avelength_abandondate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.abandondate)),h.abandondate<>(typeof(h.abandondate))'');
    populated_file_number_cnt := COUNT(GROUP,h.file_number <> (TYPEOF(h.file_number))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_prep_bus_addr_line1_cnt := COUNT(GROUP,h.prep_bus_addr_line1 <> (TYPEOF(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line1_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line1 = (TYPEOF(h.prep_bus_addr_line1))'',0,100));
    maxlength_prep_bus_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line1)));
    avelength_prep_bus_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line1)),h.prep_bus_addr_line1<>(typeof(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line_last_cnt := COUNT(GROUP,h.prep_bus_addr_line_last <> (TYPEOF(h.prep_bus_addr_line_last))'');
    populated_prep_bus_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line_last = (TYPEOF(h.prep_bus_addr_line_last))'',0,100));
    maxlength_prep_bus_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line_last)));
    avelength_prep_bus_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line_last)),h.prep_bus_addr_line_last<>(typeof(h.prep_bus_addr_line_last))'');
    populated_prep_owner_addr_line1_cnt := COUNT(GROUP,h.prep_owner_addr_line1 <> (TYPEOF(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_cnt := COUNT(GROUP,h.prep_owner_addr_line_last <> (TYPEOF(h.prep_owner_addr_line_last))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recorded_date_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_start_date_pcnt *   0.00 / 100 + T.Populated_abandondate_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'recorded_date','business_name','owner_name','start_date','abandondate','file_number','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recorded_date_pcnt,le.populated_business_name_pcnt,le.populated_owner_name_pcnt,le.populated_start_date_pcnt,le.populated_abandondate_pcnt,le.populated_file_number_pcnt,le.populated_prep_bus_addr_line1_pcnt,le.populated_prep_bus_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recorded_date,le.maxlength_business_name,le.maxlength_owner_name,le.maxlength_start_date,le.maxlength_abandondate,le.maxlength_file_number,le.maxlength_prep_bus_addr_line1,le.maxlength_prep_bus_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_recorded_date,le.avelength_business_name,le.avelength_owner_name,le.avelength_start_date,le.avelength_abandondate,le.avelength_file_number,le.avelength_prep_bus_addr_line1,le.avelength_prep_bus_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.recorded_date),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.start_date),TRIM((SALT311.StrType)le.abandondate),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.recorded_date),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.start_date),TRIM((SALT311.StrType)le.abandondate),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.recorded_date),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.start_date),TRIM((SALT311.StrType)le.abandondate),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recorded_date'}
      ,{2,'business_name'}
      ,{3,'owner_name'}
      ,{4,'start_date'}
      ,{5,'abandondate'}
      ,{6,'file_number'}
      ,{7,'prep_bus_addr_line1'}
      ,{8,'prep_bus_addr_line_last'}
      ,{9,'prep_owner_addr_line1'}
      ,{10,'prep_owner_addr_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Ventura_Fields.InValid_recorded_date((SALT311.StrType)le.recorded_date),
    Input_CA_Ventura_Fields.InValid_business_name((SALT311.StrType)le.business_name),
    Input_CA_Ventura_Fields.InValid_owner_name((SALT311.StrType)le.owner_name),
    Input_CA_Ventura_Fields.InValid_start_date((SALT311.StrType)le.start_date),
    Input_CA_Ventura_Fields.InValid_abandondate((SALT311.StrType)le.abandondate),
    Input_CA_Ventura_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Input_CA_Ventura_Fields.InValid_prep_bus_addr_line1((SALT311.StrType)le.prep_bus_addr_line1),
    Input_CA_Ventura_Fields.InValid_prep_bus_addr_line_last((SALT311.StrType)le.prep_bus_addr_line_last),
    Input_CA_Ventura_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1),
    Input_CA_Ventura_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Ventura_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Ventura_Fields.InValidMessage_recorded_date(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_start_date(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_abandondate(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_bus_addr_line1(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_bus_addr_line_last(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_CA_Ventura_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
