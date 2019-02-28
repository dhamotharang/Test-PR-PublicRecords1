IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_CourtLocations) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fipscode_cnt := COUNT(GROUP,h.fipscode <> (TYPEOF(h.fipscode))'');
    populated_fipscode_pcnt := AVE(GROUP,IF(h.fipscode = (TYPEOF(h.fipscode))'',0,100));
    maxlength_fipscode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fipscode)));
    avelength_fipscode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fipscode)),h.fipscode<>(typeof(h.fipscode))'');
    populated_statefips_cnt := COUNT(GROUP,h.statefips <> (TYPEOF(h.statefips))'');
    populated_statefips_pcnt := AVE(GROUP,IF(h.statefips = (TYPEOF(h.statefips))'',0,100));
    maxlength_statefips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statefips)));
    avelength_statefips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statefips)),h.statefips<>(typeof(h.statefips))'');
    populated_countyfips_cnt := COUNT(GROUP,h.countyfips <> (TYPEOF(h.countyfips))'');
    populated_countyfips_pcnt := AVE(GROUP,IF(h.countyfips = (TYPEOF(h.countyfips))'',0,100));
    maxlength_countyfips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countyfips)));
    avelength_countyfips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countyfips)),h.countyfips<>(typeof(h.countyfips))'');
    populated_courtid_cnt := COUNT(GROUP,h.courtid <> (TYPEOF(h.courtid))'');
    populated_courtid_pcnt := AVE(GROUP,IF(h.courtid = (TYPEOF(h.courtid))'',0,100));
    maxlength_courtid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)));
    avelength_courtid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtid)),h.courtid<>(typeof(h.courtid))'');
    populated_consolidatedcourtid_cnt := COUNT(GROUP,h.consolidatedcourtid <> (TYPEOF(h.consolidatedcourtid))'');
    populated_consolidatedcourtid_pcnt := AVE(GROUP,IF(h.consolidatedcourtid = (TYPEOF(h.consolidatedcourtid))'',0,100));
    maxlength_consolidatedcourtid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consolidatedcourtid)));
    avelength_consolidatedcourtid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consolidatedcourtid)),h.consolidatedcourtid<>(typeof(h.consolidatedcourtid))'');
    populated_masterid_cnt := COUNT(GROUP,h.masterid <> (TYPEOF(h.masterid))'');
    populated_masterid_pcnt := AVE(GROUP,IF(h.masterid = (TYPEOF(h.masterid))'',0,100));
    maxlength_masterid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masterid)));
    avelength_masterid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masterid)),h.masterid<>(typeof(h.masterid))'');
    populated_stateofservice_cnt := COUNT(GROUP,h.stateofservice <> (TYPEOF(h.stateofservice))'');
    populated_stateofservice_pcnt := AVE(GROUP,IF(h.stateofservice = (TYPEOF(h.stateofservice))'',0,100));
    maxlength_stateofservice := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateofservice)));
    avelength_stateofservice := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateofservice)),h.stateofservice<>(typeof(h.stateofservice))'');
    populated_countyofservice_cnt := COUNT(GROUP,h.countyofservice <> (TYPEOF(h.countyofservice))'');
    populated_countyofservice_pcnt := AVE(GROUP,IF(h.countyofservice = (TYPEOF(h.countyofservice))'',0,100));
    maxlength_countyofservice := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countyofservice)));
    avelength_countyofservice := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countyofservice)),h.countyofservice<>(typeof(h.countyofservice))'');
    populated_courtname_cnt := COUNT(GROUP,h.courtname <> (TYPEOF(h.courtname))'');
    populated_courtname_pcnt := AVE(GROUP,IF(h.courtname = (TYPEOF(h.courtname))'',0,100));
    maxlength_courtname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)));
    avelength_courtname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)),h.courtname<>(typeof(h.courtname))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_mailaddress1_cnt := COUNT(GROUP,h.mailaddress1 <> (TYPEOF(h.mailaddress1))'');
    populated_mailaddress1_pcnt := AVE(GROUP,IF(h.mailaddress1 = (TYPEOF(h.mailaddress1))'',0,100));
    maxlength_mailaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddress1)));
    avelength_mailaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddress1)),h.mailaddress1<>(typeof(h.mailaddress1))'');
    populated_mailaddress2_cnt := COUNT(GROUP,h.mailaddress2 <> (TYPEOF(h.mailaddress2))'');
    populated_mailaddress2_pcnt := AVE(GROUP,IF(h.mailaddress2 = (TYPEOF(h.mailaddress2))'',0,100));
    maxlength_mailaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddress2)));
    avelength_mailaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailaddress2)),h.mailaddress2<>(typeof(h.mailaddress2))'');
    populated_mailcity_cnt := COUNT(GROUP,h.mailcity <> (TYPEOF(h.mailcity))'');
    populated_mailcity_pcnt := AVE(GROUP,IF(h.mailcity = (TYPEOF(h.mailcity))'',0,100));
    maxlength_mailcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailcity)));
    avelength_mailcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailcity)),h.mailcity<>(typeof(h.mailcity))'');
    populated_mailctate_cnt := COUNT(GROUP,h.mailctate <> (TYPEOF(h.mailctate))'');
    populated_mailctate_pcnt := AVE(GROUP,IF(h.mailctate = (TYPEOF(h.mailctate))'',0,100));
    maxlength_mailctate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailctate)));
    avelength_mailctate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailctate)),h.mailctate<>(typeof(h.mailctate))'');
    populated_mailzipcode_cnt := COUNT(GROUP,h.mailzipcode <> (TYPEOF(h.mailzipcode))'');
    populated_mailzipcode_pcnt := AVE(GROUP,IF(h.mailzipcode = (TYPEOF(h.mailzipcode))'',0,100));
    maxlength_mailzipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailzipcode)));
    avelength_mailzipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailzipcode)),h.mailzipcode<>(typeof(h.mailzipcode))'');
    populated_mailzip4_cnt := COUNT(GROUP,h.mailzip4 <> (TYPEOF(h.mailzip4))'');
    populated_mailzip4_pcnt := AVE(GROUP,IF(h.mailzip4 = (TYPEOF(h.mailzip4))'',0,100));
    maxlength_mailzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailzip4)));
    avelength_mailzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailzip4)),h.mailzip4<>(typeof(h.mailzip4))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fipscode_pcnt *   0.00 / 100 + T.Populated_statefips_pcnt *   0.00 / 100 + T.Populated_countyfips_pcnt *   0.00 / 100 + T.Populated_courtid_pcnt *   0.00 / 100 + T.Populated_consolidatedcourtid_pcnt *   0.00 / 100 + T.Populated_masterid_pcnt *   0.00 / 100 + T.Populated_stateofservice_pcnt *   0.00 / 100 + T.Populated_countyofservice_pcnt *   0.00 / 100 + T.Populated_courtname_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_mailaddress1_pcnt *   0.00 / 100 + T.Populated_mailaddress2_pcnt *   0.00 / 100 + T.Populated_mailcity_pcnt *   0.00 / 100 + T.Populated_mailctate_pcnt *   0.00 / 100 + T.Populated_mailzipcode_pcnt *   0.00 / 100 + T.Populated_mailzip4_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fipscode_pcnt,le.populated_statefips_pcnt,le.populated_countyfips_pcnt,le.populated_courtid_pcnt,le.populated_consolidatedcourtid_pcnt,le.populated_masterid_pcnt,le.populated_stateofservice_pcnt,le.populated_countyofservice_pcnt,le.populated_courtname_pcnt,le.populated_phone_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_zip4_pcnt,le.populated_mailaddress1_pcnt,le.populated_mailaddress2_pcnt,le.populated_mailcity_pcnt,le.populated_mailctate_pcnt,le.populated_mailzipcode_pcnt,le.populated_mailzip4_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fipscode,le.maxlength_statefips,le.maxlength_countyfips,le.maxlength_courtid,le.maxlength_consolidatedcourtid,le.maxlength_masterid,le.maxlength_stateofservice,le.maxlength_countyofservice,le.maxlength_courtname,le.maxlength_phone,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_zip4,le.maxlength_mailaddress1,le.maxlength_mailaddress2,le.maxlength_mailcity,le.maxlength_mailctate,le.maxlength_mailzipcode,le.maxlength_mailzip4);
  SELF.avelength := CHOOSE(C,le.avelength_fipscode,le.avelength_statefips,le.avelength_countyfips,le.avelength_courtid,le.avelength_consolidatedcourtid,le.avelength_masterid,le.avelength_stateofservice,le.avelength_countyofservice,le.avelength_courtname,le.avelength_phone,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_zip4,le.avelength_mailaddress1,le.avelength_mailaddress2,le.avelength_mailcity,le.avelength_mailctate,le.avelength_mailzipcode,le.avelength_mailzip4);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.statefips),TRIM((SALT311.StrType)le.countyfips),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.consolidatedcourtid),TRIM((SALT311.StrType)le.masterid),TRIM((SALT311.StrType)le.stateofservice),TRIM((SALT311.StrType)le.countyofservice),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mailaddress1),TRIM((SALT311.StrType)le.mailaddress2),TRIM((SALT311.StrType)le.mailcity),TRIM((SALT311.StrType)le.mailctate),TRIM((SALT311.StrType)le.mailzipcode),TRIM((SALT311.StrType)le.mailzip4)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.statefips),TRIM((SALT311.StrType)le.countyfips),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.consolidatedcourtid),TRIM((SALT311.StrType)le.masterid),TRIM((SALT311.StrType)le.stateofservice),TRIM((SALT311.StrType)le.countyofservice),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mailaddress1),TRIM((SALT311.StrType)le.mailaddress2),TRIM((SALT311.StrType)le.mailcity),TRIM((SALT311.StrType)le.mailctate),TRIM((SALT311.StrType)le.mailzipcode),TRIM((SALT311.StrType)le.mailzip4)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.fipscode),TRIM((SALT311.StrType)le.statefips),TRIM((SALT311.StrType)le.countyfips),TRIM((SALT311.StrType)le.courtid),TRIM((SALT311.StrType)le.consolidatedcourtid),TRIM((SALT311.StrType)le.masterid),TRIM((SALT311.StrType)le.stateofservice),TRIM((SALT311.StrType)le.countyofservice),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mailaddress1),TRIM((SALT311.StrType)le.mailaddress2),TRIM((SALT311.StrType)le.mailcity),TRIM((SALT311.StrType)le.mailctate),TRIM((SALT311.StrType)le.mailzipcode),TRIM((SALT311.StrType)le.mailzip4)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fipscode'}
      ,{2,'statefips'}
      ,{3,'countyfips'}
      ,{4,'courtid'}
      ,{5,'consolidatedcourtid'}
      ,{6,'masterid'}
      ,{7,'stateofservice'}
      ,{8,'countyofservice'}
      ,{9,'courtname'}
      ,{10,'phone'}
      ,{11,'address1'}
      ,{12,'address2'}
      ,{13,'city'}
      ,{14,'state'}
      ,{15,'zipcode'}
      ,{16,'zip4'}
      ,{17,'mailaddress1'}
      ,{18,'mailaddress2'}
      ,{19,'mailcity'}
      ,{20,'mailctate'}
      ,{21,'mailzipcode'}
      ,{22,'mailzip4'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_fipscode((SALT311.StrType)le.fipscode),
    Fields.InValid_statefips((SALT311.StrType)le.statefips),
    Fields.InValid_countyfips((SALT311.StrType)le.countyfips),
    Fields.InValid_courtid((SALT311.StrType)le.courtid),
    Fields.InValid_consolidatedcourtid((SALT311.StrType)le.consolidatedcourtid),
    Fields.InValid_masterid((SALT311.StrType)le.masterid),
    Fields.InValid_stateofservice((SALT311.StrType)le.stateofservice),
    Fields.InValid_countyofservice((SALT311.StrType)le.countyofservice),
    Fields.InValid_courtname((SALT311.StrType)le.courtname),
    Fields.InValid_phone((SALT311.StrType)le.phone),
    Fields.InValid_address1((SALT311.StrType)le.address1),
    Fields.InValid_address2((SALT311.StrType)le.address2),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_mailaddress1((SALT311.StrType)le.mailaddress1),
    Fields.InValid_mailaddress2((SALT311.StrType)le.mailaddress2),
    Fields.InValid_mailcity((SALT311.StrType)le.mailcity),
    Fields.InValid_mailctate((SALT311.StrType)le.mailctate),
    Fields.InValid_mailzipcode((SALT311.StrType)le.mailzipcode),
    Fields.InValid_mailzip4((SALT311.StrType)le.mailzip4),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,22,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_fipscode(TotalErrors.ErrorNum),Fields.InValidMessage_statefips(TotalErrors.ErrorNum),Fields.InValidMessage_countyfips(TotalErrors.ErrorNum),Fields.InValidMessage_courtid(TotalErrors.ErrorNum),Fields.InValidMessage_consolidatedcourtid(TotalErrors.ErrorNum),Fields.InValidMessage_masterid(TotalErrors.ErrorNum),Fields.InValidMessage_stateofservice(TotalErrors.ErrorNum),Fields.InValidMessage_countyofservice(TotalErrors.ErrorNum),Fields.InValidMessage_courtname(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_mailaddress1(TotalErrors.ErrorNum),Fields.InValidMessage_mailaddress2(TotalErrors.ErrorNum),Fields.InValidMessage_mailcity(TotalErrors.ErrorNum),Fields.InValidMessage_mailctate(TotalErrors.ErrorNum),Fields.InValidMessage_mailzipcode(TotalErrors.ErrorNum),Fields.InValidMessage_mailzip4(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(_Scrubs_VendorSrc_CourtLocations, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
