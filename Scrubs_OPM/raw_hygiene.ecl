IMPORT SALT311,STD;
EXPORT raw_hygiene(dataset(raw_layout_OPM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_employee_name_cnt := COUNT(GROUP,h.employee_name <> (TYPEOF(h.employee_name))'');
    populated_employee_name_pcnt := AVE(GROUP,IF(h.employee_name = (TYPEOF(h.employee_name))'',0,100));
    maxlength_employee_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employee_name)));
    avelength_employee_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employee_name)),h.employee_name<>(typeof(h.employee_name))'');
    populated_duty_station_cnt := COUNT(GROUP,h.duty_station <> (TYPEOF(h.duty_station))'');
    populated_duty_station_pcnt := AVE(GROUP,IF(h.duty_station = (TYPEOF(h.duty_station))'',0,100));
    maxlength_duty_station := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duty_station)));
    avelength_duty_station := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duty_station)),h.duty_station<>(typeof(h.duty_station))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_agency_cnt := COUNT(GROUP,h.agency <> (TYPEOF(h.agency))'');
    populated_agency_pcnt := AVE(GROUP,IF(h.agency = (TYPEOF(h.agency))'',0,100));
    maxlength_agency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency)));
    avelength_agency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency)),h.agency<>(typeof(h.agency))'');
    populated_agency_sub_element_cnt := COUNT(GROUP,h.agency_sub_element <> (TYPEOF(h.agency_sub_element))'');
    populated_agency_sub_element_pcnt := AVE(GROUP,IF(h.agency_sub_element = (TYPEOF(h.agency_sub_element))'',0,100));
    maxlength_agency_sub_element := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_sub_element)));
    avelength_agency_sub_element := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_sub_element)),h.agency_sub_element<>(typeof(h.agency_sub_element))'');
    populated_computation_date_cnt := COUNT(GROUP,h.computation_date <> (TYPEOF(h.computation_date))'');
    populated_computation_date_pcnt := AVE(GROUP,IF(h.computation_date = (TYPEOF(h.computation_date))'',0,100));
    maxlength_computation_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.computation_date)));
    avelength_computation_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.computation_date)),h.computation_date<>(typeof(h.computation_date))'');
    populated_occupational_series_cnt := COUNT(GROUP,h.occupational_series <> (TYPEOF(h.occupational_series))'');
    populated_occupational_series_pcnt := AVE(GROUP,IF(h.occupational_series = (TYPEOF(h.occupational_series))'',0,100));
    maxlength_occupational_series := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.occupational_series)));
    avelength_occupational_series := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.occupational_series)),h.occupational_series<>(typeof(h.occupational_series))'');
    populated_file_date_cnt := COUNT(GROUP,h.file_date <> (TYPEOF(h.file_date))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_employee_name_pcnt *   0.00 / 100 + T.Populated_duty_station_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_agency_pcnt *   0.00 / 100 + T.Populated_agency_sub_element_pcnt *   0.00 / 100 + T.Populated_computation_date_pcnt *   0.00 / 100 + T.Populated_occupational_series_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'employee_name','duty_station','country','state','city','county','agency','agency_sub_element','computation_date','occupational_series','file_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_employee_name_pcnt,le.populated_duty_station_pcnt,le.populated_country_pcnt,le.populated_state_pcnt,le.populated_city_pcnt,le.populated_county_pcnt,le.populated_agency_pcnt,le.populated_agency_sub_element_pcnt,le.populated_computation_date_pcnt,le.populated_occupational_series_pcnt,le.populated_file_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_employee_name,le.maxlength_duty_station,le.maxlength_country,le.maxlength_state,le.maxlength_city,le.maxlength_county,le.maxlength_agency,le.maxlength_agency_sub_element,le.maxlength_computation_date,le.maxlength_occupational_series,le.maxlength_file_date);
  SELF.avelength := CHOOSE(C,le.avelength_employee_name,le.avelength_duty_station,le.avelength_country,le.avelength_state,le.avelength_city,le.avelength_county,le.avelength_agency,le.avelength_agency_sub_element,le.avelength_computation_date,le.avelength_occupational_series,le.avelength_file_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.employee_name),TRIM((SALT311.StrType)le.duty_station),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.agency),TRIM((SALT311.StrType)le.agency_sub_element),TRIM((SALT311.StrType)le.computation_date),TRIM((SALT311.StrType)le.occupational_series),TRIM((SALT311.StrType)le.file_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.employee_name),TRIM((SALT311.StrType)le.duty_station),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.agency),TRIM((SALT311.StrType)le.agency_sub_element),TRIM((SALT311.StrType)le.computation_date),TRIM((SALT311.StrType)le.occupational_series),TRIM((SALT311.StrType)le.file_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.employee_name),TRIM((SALT311.StrType)le.duty_station),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.agency),TRIM((SALT311.StrType)le.agency_sub_element),TRIM((SALT311.StrType)le.computation_date),TRIM((SALT311.StrType)le.occupational_series),TRIM((SALT311.StrType)le.file_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'employee_name'}
      ,{2,'duty_station'}
      ,{3,'country'}
      ,{4,'state'}
      ,{5,'city'}
      ,{6,'county'}
      ,{7,'agency'}
      ,{8,'agency_sub_element'}
      ,{9,'computation_date'}
      ,{10,'occupational_series'}
      ,{11,'file_date'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_Fields.InValid_employee_name((SALT311.StrType)le.employee_name),
    raw_Fields.InValid_duty_station((SALT311.StrType)le.duty_station),
    raw_Fields.InValid_country((SALT311.StrType)le.country),
    raw_Fields.InValid_state((SALT311.StrType)le.state),
    raw_Fields.InValid_city((SALT311.StrType)le.city),
    raw_Fields.InValid_county((SALT311.StrType)le.county),
    raw_Fields.InValid_agency((SALT311.StrType)le.agency),
    raw_Fields.InValid_agency_sub_element((SALT311.StrType)le.agency_sub_element),
    raw_Fields.InValid_computation_date((SALT311.StrType)le.computation_date),
    raw_Fields.InValid_occupational_series((SALT311.StrType)le.occupational_series),
    raw_Fields.InValid_file_date((SALT311.StrType)le.file_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_name','invalid_alpha_num','invalid_country','invalid_alpha_blank','invalid_alpha_blank_sp','invalid_alpha_blank_sp','invalid_alpha_num_sp','invalid_alpha_num_sp','invalid_past_date','invalid_occu_Series_cd','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_Fields.InValidMessage_employee_name(TotalErrors.ErrorNum),raw_Fields.InValidMessage_duty_station(TotalErrors.ErrorNum),raw_Fields.InValidMessage_country(TotalErrors.ErrorNum),raw_Fields.InValidMessage_state(TotalErrors.ErrorNum),raw_Fields.InValidMessage_city(TotalErrors.ErrorNum),raw_Fields.InValidMessage_county(TotalErrors.ErrorNum),raw_Fields.InValidMessage_agency(TotalErrors.ErrorNum),raw_Fields.InValidMessage_agency_sub_element(TotalErrors.ErrorNum),raw_Fields.InValidMessage_computation_date(TotalErrors.ErrorNum),raw_Fields.InValidMessage_occupational_series(TotalErrors.ErrorNum),raw_Fields.InValidMessage_file_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OPM, raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
