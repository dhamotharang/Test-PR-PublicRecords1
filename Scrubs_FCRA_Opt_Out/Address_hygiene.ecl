IMPORT SALT38,STD;
EXPORT Address_hygiene(dataset(Address_layout_FCRA_Opt_Out) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_z5_cnt := COUNT(GROUP,h.z5 <> (TYPEOF(h.z5))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_source_flag_cnt := COUNT(GROUP,h.source_flag <> (TYPEOF(h.source_flag))'');
    populated_source_flag_pcnt := AVE(GROUP,IF(h.source_flag = (TYPEOF(h.source_flag))'',0,100));
    maxlength_source_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_flag)));
    avelength_source_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_flag)),h.source_flag<>(typeof(h.source_flag))'');
    populated_julian_date_cnt := COUNT(GROUP,h.julian_date <> (TYPEOF(h.julian_date))'');
    populated_julian_date_pcnt := AVE(GROUP,IF(h.julian_date = (TYPEOF(h.julian_date))'',0,100));
    maxlength_julian_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.julian_date)));
    avelength_julian_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.julian_date)),h.julian_date<>(typeof(h.julian_date))'');
    populated_inname_first_cnt := COUNT(GROUP,h.inname_first <> (TYPEOF(h.inname_first))'');
    populated_inname_first_pcnt := AVE(GROUP,IF(h.inname_first = (TYPEOF(h.inname_first))'',0,100));
    maxlength_inname_first := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.inname_first)));
    avelength_inname_first := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.inname_first)),h.inname_first<>(typeof(h.inname_first))'');
    populated_inname_last_cnt := COUNT(GROUP,h.inname_last <> (TYPEOF(h.inname_last))'');
    populated_inname_last_pcnt := AVE(GROUP,IF(h.inname_last = (TYPEOF(h.inname_last))'',0,100));
    maxlength_inname_last := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.inname_last)));
    avelength_inname_last := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.inname_last)),h.inname_last<>(typeof(h.inname_last))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_ssn_append_cnt := COUNT(GROUP,h.ssn_append <> (TYPEOF(h.ssn_append))'');
    populated_ssn_append_pcnt := AVE(GROUP,IF(h.ssn_append = (TYPEOF(h.ssn_append))'',0,100));
    maxlength_ssn_append := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn_append)));
    avelength_ssn_append := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn_append)),h.ssn_append<>(typeof(h.ssn_append))'');
    populated_permanent_flag_cnt := COUNT(GROUP,h.permanent_flag <> (TYPEOF(h.permanent_flag))'');
    populated_permanent_flag_pcnt := AVE(GROUP,IF(h.permanent_flag = (TYPEOF(h.permanent_flag))'',0,100));
    maxlength_permanent_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permanent_flag)));
    avelength_permanent_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permanent_flag)),h.permanent_flag<>(typeof(h.permanent_flag))'');
    populated_opt_back_in_cnt := COUNT(GROUP,h.opt_back_in <> (TYPEOF(h.opt_back_in))'');
    populated_opt_back_in_pcnt := AVE(GROUP,IF(h.opt_back_in = (TYPEOF(h.opt_back_in))'',0,100));
    maxlength_opt_back_in := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.opt_back_in)));
    avelength_opt_back_in := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.opt_back_in)),h.opt_back_in<>(typeof(h.opt_back_in))'');
    populated_date_yyyymmdd_cnt := COUNT(GROUP,h.date_yyyymmdd <> (TYPEOF(h.date_yyyymmdd))'');
    populated_date_yyyymmdd_pcnt := AVE(GROUP,IF(h.date_yyyymmdd = (TYPEOF(h.date_yyyymmdd))'',0,100));
    maxlength_date_yyyymmdd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_yyyymmdd)));
    avelength_date_yyyymmdd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_yyyymmdd)),h.date_yyyymmdd<>(typeof(h.date_yyyymmdd))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_source_flag_pcnt *   0.00 / 100 + T.Populated_julian_date_pcnt *   0.00 / 100 + T.Populated_inname_first_pcnt *   0.00 / 100 + T.Populated_inname_last_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_ssn_append_pcnt *   0.00 / 100 + T.Populated_permanent_flag_pcnt *   0.00 / 100 + T.Populated_opt_back_in_pcnt *   0.00 / 100 + T.Populated_date_yyyymmdd_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'z5','prim_range','prim_name','sec_range','ssn','did','source_flag','julian_date','inname_first','inname_last','address','city','state','zip5','did_score','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd');
  SELF.populated_pcnt := CHOOSE(C,le.populated_z5_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_ssn_pcnt,le.populated_did_pcnt,le.populated_source_flag_pcnt,le.populated_julian_date_pcnt,le.populated_inname_first_pcnt,le.populated_inname_last_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_did_score_pcnt,le.populated_ssn_append_pcnt,le.populated_permanent_flag_pcnt,le.populated_opt_back_in_pcnt,le.populated_date_yyyymmdd_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_z5,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_ssn,le.maxlength_did,le.maxlength_source_flag,le.maxlength_julian_date,le.maxlength_inname_first,le.maxlength_inname_last,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip5,le.maxlength_did_score,le.maxlength_ssn_append,le.maxlength_permanent_flag,le.maxlength_opt_back_in,le.maxlength_date_yyyymmdd);
  SELF.avelength := CHOOSE(C,le.avelength_z5,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_ssn,le.avelength_did,le.avelength_source_flag,le.avelength_julian_date,le.avelength_inname_first,le.avelength_inname_last,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip5,le.avelength_did_score,le.avelength_ssn_append,le.avelength_permanent_flag,le.avelength_opt_back_in,le.avelength_date_yyyymmdd);
END;
EXPORT invSummary := NORMALIZE(summary0, 19, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.source_flag),TRIM((SALT38.StrType)le.julian_date),TRIM((SALT38.StrType)le.inname_first),TRIM((SALT38.StrType)le.inname_last),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.ssn_append),TRIM((SALT38.StrType)le.permanent_flag),TRIM((SALT38.StrType)le.opt_back_in),TRIM((SALT38.StrType)le.date_yyyymmdd)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,19,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 19);
  SELF.FldNo2 := 1 + (C % 19);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.source_flag),TRIM((SALT38.StrType)le.julian_date),TRIM((SALT38.StrType)le.inname_first),TRIM((SALT38.StrType)le.inname_last),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.ssn_append),TRIM((SALT38.StrType)le.permanent_flag),TRIM((SALT38.StrType)le.opt_back_in),TRIM((SALT38.StrType)le.date_yyyymmdd)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.source_flag),TRIM((SALT38.StrType)le.julian_date),TRIM((SALT38.StrType)le.inname_first),TRIM((SALT38.StrType)le.inname_last),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.ssn_append),TRIM((SALT38.StrType)le.permanent_flag),TRIM((SALT38.StrType)le.opt_back_in),TRIM((SALT38.StrType)le.date_yyyymmdd)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),19*19,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'z5'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'sec_range'}
      ,{5,'ssn'}
      ,{6,'did'}
      ,{7,'source_flag'}
      ,{8,'julian_date'}
      ,{9,'inname_first'}
      ,{10,'inname_last'}
      ,{11,'address'}
      ,{12,'city'}
      ,{13,'state'}
      ,{14,'zip5'}
      ,{15,'did_score'}
      ,{16,'ssn_append'}
      ,{17,'permanent_flag'}
      ,{18,'opt_back_in'}
      ,{19,'date_yyyymmdd'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Address_Fields.InValid_z5((SALT38.StrType)le.z5),
    Address_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Address_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Address_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Address_Fields.InValid_ssn((SALT38.StrType)le.ssn),
    Address_Fields.InValid_did((SALT38.StrType)le.did),
    Address_Fields.InValid_source_flag((SALT38.StrType)le.source_flag),
    Address_Fields.InValid_julian_date((SALT38.StrType)le.julian_date),
    Address_Fields.InValid_inname_first((SALT38.StrType)le.inname_first),
    Address_Fields.InValid_inname_last((SALT38.StrType)le.inname_last),
    Address_Fields.InValid_address((SALT38.StrType)le.address),
    Address_Fields.InValid_city((SALT38.StrType)le.city),
    Address_Fields.InValid_state((SALT38.StrType)le.state),
    Address_Fields.InValid_zip5((SALT38.StrType)le.zip5),
    Address_Fields.InValid_did_score((SALT38.StrType)le.did_score),
    Address_Fields.InValid_ssn_append((SALT38.StrType)le.ssn_append),
    Address_Fields.InValid_permanent_flag((SALT38.StrType)le.permanent_flag),
    Address_Fields.InValid_opt_back_in((SALT38.StrType)le.opt_back_in),
    Address_Fields.InValid_date_yyyymmdd((SALT38.StrType)le.date_yyyymmdd),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,19,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Address_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Zip','Invalid_Blank','Invalid_Blank','Unknown','Invalid_SSN','Unknown','Unknown','Invalid_JullianDate','Invalid_Inname','Invalid_Inname','Unknown','Unknown','Invalid_State','Invalid_Zip','Unknown','Invalid_SSN_append','Invalid_Flag','Invalid_Flag','Invalid_Date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Address_Fields.InValidMessage_z5(TotalErrors.ErrorNum),Address_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Address_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Address_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Address_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Address_Fields.InValidMessage_did(TotalErrors.ErrorNum),Address_Fields.InValidMessage_source_flag(TotalErrors.ErrorNum),Address_Fields.InValidMessage_julian_date(TotalErrors.ErrorNum),Address_Fields.InValidMessage_inname_first(TotalErrors.ErrorNum),Address_Fields.InValidMessage_inname_last(TotalErrors.ErrorNum),Address_Fields.InValidMessage_address(TotalErrors.ErrorNum),Address_Fields.InValidMessage_city(TotalErrors.ErrorNum),Address_Fields.InValidMessage_state(TotalErrors.ErrorNum),Address_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Address_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Address_Fields.InValidMessage_ssn_append(TotalErrors.ErrorNum),Address_Fields.InValidMessage_permanent_flag(TotalErrors.ErrorNum),Address_Fields.InValidMessage_opt_back_in(TotalErrors.ErrorNum),Address_Fields.InValidMessage_date_yyyymmdd(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FCRA_Opt_Out, Address_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
