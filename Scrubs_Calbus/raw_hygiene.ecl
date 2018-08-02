IMPORT SALT38,STD;
EXPORT raw_hygiene(dataset(raw_layout_Calbus) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_district_branch_cnt := COUNT(GROUP,h.district_branch <> (TYPEOF(h.district_branch))'');
    populated_district_branch_pcnt := AVE(GROUP,IF(h.district_branch = (TYPEOF(h.district_branch))'',0,100));
    maxlength_district_branch := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.district_branch)));
    avelength_district_branch := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.district_branch)),h.district_branch<>(typeof(h.district_branch))'');
    populated_account_number_cnt := COUNT(GROUP,h.account_number <> (TYPEOF(h.account_number))'');
    populated_account_number_pcnt := AVE(GROUP,IF(h.account_number = (TYPEOF(h.account_number))'',0,100));
    maxlength_account_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.account_number)));
    avelength_account_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.account_number)),h.account_number<>(typeof(h.account_number))'');
    populated_sub_account_number_cnt := COUNT(GROUP,h.sub_account_number <> (TYPEOF(h.sub_account_number))'');
    populated_sub_account_number_pcnt := AVE(GROUP,IF(h.sub_account_number = (TYPEOF(h.sub_account_number))'',0,100));
    maxlength_sub_account_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sub_account_number)));
    avelength_sub_account_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sub_account_number)),h.sub_account_number<>(typeof(h.sub_account_number))'');
    populated_district_cnt := COUNT(GROUP,h.district <> (TYPEOF(h.district))'');
    populated_district_pcnt := AVE(GROUP,IF(h.district = (TYPEOF(h.district))'',0,100));
    maxlength_district := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.district)));
    avelength_district := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.district)),h.district<>(typeof(h.district))'');
    populated_account_type_cnt := COUNT(GROUP,h.account_type <> (TYPEOF(h.account_type))'');
    populated_account_type_pcnt := AVE(GROUP,IF(h.account_type = (TYPEOF(h.account_type))'',0,100));
    maxlength_account_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.account_type)));
    avelength_account_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.account_type)),h.account_type<>(typeof(h.account_type))'');
    populated_firm_name_cnt := COUNT(GROUP,h.firm_name <> (TYPEOF(h.firm_name))'');
    populated_firm_name_pcnt := AVE(GROUP,IF(h.firm_name = (TYPEOF(h.firm_name))'',0,100));
    maxlength_firm_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.firm_name)));
    avelength_firm_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.firm_name)),h.firm_name<>(typeof(h.firm_name))'');
    populated_owner_name_cnt := COUNT(GROUP,h.owner_name <> (TYPEOF(h.owner_name))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_business_street_cnt := COUNT(GROUP,h.business_street <> (TYPEOF(h.business_street))'');
    populated_business_street_pcnt := AVE(GROUP,IF(h.business_street = (TYPEOF(h.business_street))'',0,100));
    maxlength_business_street := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_street)));
    avelength_business_street := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_street)),h.business_street<>(typeof(h.business_street))'');
    populated_business_city_cnt := COUNT(GROUP,h.business_city <> (TYPEOF(h.business_city))'');
    populated_business_city_pcnt := AVE(GROUP,IF(h.business_city = (TYPEOF(h.business_city))'',0,100));
    maxlength_business_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_city)));
    avelength_business_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_city)),h.business_city<>(typeof(h.business_city))'');
    populated_business_state_cnt := COUNT(GROUP,h.business_state <> (TYPEOF(h.business_state))'');
    populated_business_state_pcnt := AVE(GROUP,IF(h.business_state = (TYPEOF(h.business_state))'',0,100));
    maxlength_business_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_state)));
    avelength_business_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_state)),h.business_state<>(typeof(h.business_state))'');
    populated_business_zip_5_cnt := COUNT(GROUP,h.business_zip_5 <> (TYPEOF(h.business_zip_5))'');
    populated_business_zip_5_pcnt := AVE(GROUP,IF(h.business_zip_5 = (TYPEOF(h.business_zip_5))'',0,100));
    maxlength_business_zip_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_zip_5)));
    avelength_business_zip_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_zip_5)),h.business_zip_5<>(typeof(h.business_zip_5))'');
    populated_business_zip_plus_4_cnt := COUNT(GROUP,h.business_zip_plus_4 <> (TYPEOF(h.business_zip_plus_4))'');
    populated_business_zip_plus_4_pcnt := AVE(GROUP,IF(h.business_zip_plus_4 = (TYPEOF(h.business_zip_plus_4))'',0,100));
    maxlength_business_zip_plus_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_zip_plus_4)));
    avelength_business_zip_plus_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_zip_plus_4)),h.business_zip_plus_4<>(typeof(h.business_zip_plus_4))'');
    populated_business_foreign_zip_cnt := COUNT(GROUP,h.business_foreign_zip <> (TYPEOF(h.business_foreign_zip))'');
    populated_business_foreign_zip_pcnt := AVE(GROUP,IF(h.business_foreign_zip = (TYPEOF(h.business_foreign_zip))'',0,100));
    maxlength_business_foreign_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_foreign_zip)));
    avelength_business_foreign_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_foreign_zip)),h.business_foreign_zip<>(typeof(h.business_foreign_zip))'');
    populated_business_country_name_cnt := COUNT(GROUP,h.business_country_name <> (TYPEOF(h.business_country_name))'');
    populated_business_country_name_pcnt := AVE(GROUP,IF(h.business_country_name = (TYPEOF(h.business_country_name))'',0,100));
    maxlength_business_country_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_country_name)));
    avelength_business_country_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.business_country_name)),h.business_country_name<>(typeof(h.business_country_name))'');
    populated_start_date_cnt := COUNT(GROUP,h.start_date <> (TYPEOF(h.start_date))'');
    populated_start_date_pcnt := AVE(GROUP,IF(h.start_date = (TYPEOF(h.start_date))'',0,100));
    maxlength_start_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.start_date)));
    avelength_start_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.start_date)),h.start_date<>(typeof(h.start_date))'');
    populated_ownership_code_cnt := COUNT(GROUP,h.ownership_code <> (TYPEOF(h.ownership_code))'');
    populated_ownership_code_pcnt := AVE(GROUP,IF(h.ownership_code = (TYPEOF(h.ownership_code))'',0,100));
    maxlength_ownership_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code)));
    avelength_ownership_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ownership_code)),h.ownership_code<>(typeof(h.ownership_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_district_branch_pcnt *   0.00 / 100 + T.Populated_account_number_pcnt *   0.00 / 100 + T.Populated_sub_account_number_pcnt *   0.00 / 100 + T.Populated_district_pcnt *   0.00 / 100 + T.Populated_account_type_pcnt *   0.00 / 100 + T.Populated_firm_name_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_business_street_pcnt *   0.00 / 100 + T.Populated_business_city_pcnt *   0.00 / 100 + T.Populated_business_state_pcnt *   0.00 / 100 + T.Populated_business_zip_5_pcnt *   0.00 / 100 + T.Populated_business_zip_plus_4_pcnt *   0.00 / 100 + T.Populated_business_foreign_zip_pcnt *   0.00 / 100 + T.Populated_business_country_name_pcnt *   0.00 / 100 + T.Populated_start_date_pcnt *   0.00 / 100 + T.Populated_ownership_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'district_branch','account_number','sub_account_number','district','account_type','firm_name','owner_name','business_street','business_city','business_state','business_zip_5','business_zip_plus_4','business_foreign_zip','business_country_name','start_date','ownership_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_district_branch_pcnt,le.populated_account_number_pcnt,le.populated_sub_account_number_pcnt,le.populated_district_pcnt,le.populated_account_type_pcnt,le.populated_firm_name_pcnt,le.populated_owner_name_pcnt,le.populated_business_street_pcnt,le.populated_business_city_pcnt,le.populated_business_state_pcnt,le.populated_business_zip_5_pcnt,le.populated_business_zip_plus_4_pcnt,le.populated_business_foreign_zip_pcnt,le.populated_business_country_name_pcnt,le.populated_start_date_pcnt,le.populated_ownership_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_district_branch,le.maxlength_account_number,le.maxlength_sub_account_number,le.maxlength_district,le.maxlength_account_type,le.maxlength_firm_name,le.maxlength_owner_name,le.maxlength_business_street,le.maxlength_business_city,le.maxlength_business_state,le.maxlength_business_zip_5,le.maxlength_business_zip_plus_4,le.maxlength_business_foreign_zip,le.maxlength_business_country_name,le.maxlength_start_date,le.maxlength_ownership_code);
  SELF.avelength := CHOOSE(C,le.avelength_district_branch,le.avelength_account_number,le.avelength_sub_account_number,le.avelength_district,le.avelength_account_type,le.avelength_firm_name,le.avelength_owner_name,le.avelength_business_street,le.avelength_business_city,le.avelength_business_state,le.avelength_business_zip_5,le.avelength_business_zip_plus_4,le.avelength_business_foreign_zip,le.avelength_business_country_name,le.avelength_start_date,le.avelength_ownership_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 16, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.district_branch),TRIM((SALT38.StrType)le.account_number),TRIM((SALT38.StrType)le.sub_account_number),TRIM((SALT38.StrType)le.district),TRIM((SALT38.StrType)le.account_type),TRIM((SALT38.StrType)le.firm_name),TRIM((SALT38.StrType)le.owner_name),TRIM((SALT38.StrType)le.business_street),TRIM((SALT38.StrType)le.business_city),TRIM((SALT38.StrType)le.business_state),TRIM((SALT38.StrType)le.business_zip_5),TRIM((SALT38.StrType)le.business_zip_plus_4),TRIM((SALT38.StrType)le.business_foreign_zip),TRIM((SALT38.StrType)le.business_country_name),TRIM((SALT38.StrType)le.start_date),TRIM((SALT38.StrType)le.ownership_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,16,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 16);
  SELF.FldNo2 := 1 + (C % 16);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.district_branch),TRIM((SALT38.StrType)le.account_number),TRIM((SALT38.StrType)le.sub_account_number),TRIM((SALT38.StrType)le.district),TRIM((SALT38.StrType)le.account_type),TRIM((SALT38.StrType)le.firm_name),TRIM((SALT38.StrType)le.owner_name),TRIM((SALT38.StrType)le.business_street),TRIM((SALT38.StrType)le.business_city),TRIM((SALT38.StrType)le.business_state),TRIM((SALT38.StrType)le.business_zip_5),TRIM((SALT38.StrType)le.business_zip_plus_4),TRIM((SALT38.StrType)le.business_foreign_zip),TRIM((SALT38.StrType)le.business_country_name),TRIM((SALT38.StrType)le.start_date),TRIM((SALT38.StrType)le.ownership_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.district_branch),TRIM((SALT38.StrType)le.account_number),TRIM((SALT38.StrType)le.sub_account_number),TRIM((SALT38.StrType)le.district),TRIM((SALT38.StrType)le.account_type),TRIM((SALT38.StrType)le.firm_name),TRIM((SALT38.StrType)le.owner_name),TRIM((SALT38.StrType)le.business_street),TRIM((SALT38.StrType)le.business_city),TRIM((SALT38.StrType)le.business_state),TRIM((SALT38.StrType)le.business_zip_5),TRIM((SALT38.StrType)le.business_zip_plus_4),TRIM((SALT38.StrType)le.business_foreign_zip),TRIM((SALT38.StrType)le.business_country_name),TRIM((SALT38.StrType)le.start_date),TRIM((SALT38.StrType)le.ownership_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),16*16,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'district_branch'}
      ,{2,'account_number'}
      ,{3,'sub_account_number'}
      ,{4,'district'}
      ,{5,'account_type'}
      ,{6,'firm_name'}
      ,{7,'owner_name'}
      ,{8,'business_street'}
      ,{9,'business_city'}
      ,{10,'business_state'}
      ,{11,'business_zip_5'}
      ,{12,'business_zip_plus_4'}
      ,{13,'business_foreign_zip'}
      ,{14,'business_country_name'}
      ,{15,'start_date'}
      ,{16,'ownership_code'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_Fields.InValid_district_branch((SALT38.StrType)le.district_branch),
    raw_Fields.InValid_account_number((SALT38.StrType)le.account_number),
    raw_Fields.InValid_sub_account_number((SALT38.StrType)le.sub_account_number),
    raw_Fields.InValid_district((SALT38.StrType)le.district),
    raw_Fields.InValid_account_type((SALT38.StrType)le.account_type),
    raw_Fields.InValid_firm_name((SALT38.StrType)le.firm_name),
    raw_Fields.InValid_owner_name((SALT38.StrType)le.owner_name),
    raw_Fields.InValid_business_street((SALT38.StrType)le.business_street),
    raw_Fields.InValid_business_city((SALT38.StrType)le.business_city),
    raw_Fields.InValid_business_state((SALT38.StrType)le.business_state),
    raw_Fields.InValid_business_zip_5((SALT38.StrType)le.business_zip_5),
    raw_Fields.InValid_business_zip_plus_4((SALT38.StrType)le.business_zip_plus_4),
    raw_Fields.InValid_business_foreign_zip((SALT38.StrType)le.business_foreign_zip),
    raw_Fields.InValid_business_country_name((SALT38.StrType)le.business_country_name),
    raw_Fields.InValid_start_date((SALT38.StrType)le.start_date),
    raw_Fields.InValid_ownership_code((SALT38.StrType)le.ownership_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,16,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_district','invalid_numeric','invalid_numeric','invalid_district','invalid_account_type','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip_5','invalid_zip_plus_4','invalid_full_zip','invalid_country_name','invalid_start_date','invalid_ownership_code');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_Fields.InValidMessage_district_branch(TotalErrors.ErrorNum),raw_Fields.InValidMessage_account_number(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sub_account_number(TotalErrors.ErrorNum),raw_Fields.InValidMessage_district(TotalErrors.ErrorNum),raw_Fields.InValidMessage_account_type(TotalErrors.ErrorNum),raw_Fields.InValidMessage_firm_name(TotalErrors.ErrorNum),raw_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_street(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_city(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_state(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_zip_5(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_zip_plus_4(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_foreign_zip(TotalErrors.ErrorNum),raw_Fields.InValidMessage_business_country_name(TotalErrors.ErrorNum),raw_Fields.InValidMessage_start_date(TotalErrors.ErrorNum),raw_Fields.InValidMessage_ownership_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Calbus, raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
