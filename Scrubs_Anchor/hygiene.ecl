IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_Anchor) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_address_1_cnt := COUNT(GROUP,h.address_1 <> (TYPEOF(h.address_1))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_cnt := COUNT(GROUP,h.address_2 <> (TYPEOF(h.address_2))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_sourceurl_cnt := COUNT(GROUP,h.sourceurl <> (TYPEOF(h.sourceurl))'');
    populated_sourceurl_pcnt := AVE(GROUP,IF(h.sourceurl = (TYPEOF(h.sourceurl))'',0,100));
    maxlength_sourceurl := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sourceurl)));
    avelength_sourceurl := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sourceurl)),h.sourceurl<>(typeof(h.sourceurl))'');
    populated_ipaddress_cnt := COUNT(GROUP,h.ipaddress <> (TYPEOF(h.ipaddress))'');
    populated_ipaddress_pcnt := AVE(GROUP,IF(h.ipaddress = (TYPEOF(h.ipaddress))'',0,100));
    maxlength_ipaddress := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ipaddress)));
    avelength_ipaddress := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ipaddress)),h.ipaddress<>(typeof(h.ipaddress))'');
    populated_optindate_cnt := COUNT(GROUP,h.optindate <> (TYPEOF(h.optindate))'');
    populated_optindate_pcnt := AVE(GROUP,IF(h.optindate = (TYPEOF(h.optindate))'',0,100));
    maxlength_optindate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.optindate)));
    avelength_optindate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.optindate)),h.optindate<>(typeof(h.optindate))'');
    populated_emailaddress_cnt := COUNT(GROUP,h.emailaddress <> (TYPEOF(h.emailaddress))'');
    populated_emailaddress_pcnt := AVE(GROUP,IF(h.emailaddress = (TYPEOF(h.emailaddress))'',0,100));
    maxlength_emailaddress := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.emailaddress)));
    avelength_emailaddress := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.emailaddress)),h.emailaddress<>(typeof(h.emailaddress))'');
    populated_anchorinternalcode_cnt := COUNT(GROUP,h.anchorinternalcode <> (TYPEOF(h.anchorinternalcode))'');
    populated_anchorinternalcode_pcnt := AVE(GROUP,IF(h.anchorinternalcode = (TYPEOF(h.anchorinternalcode))'',0,100));
    maxlength_anchorinternalcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.anchorinternalcode)));
    avelength_anchorinternalcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.anchorinternalcode)),h.anchorinternalcode<>(typeof(h.anchorinternalcode))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_sourceurl_pcnt *   0.00 / 100 + T.Populated_ipaddress_pcnt *   0.00 / 100 + T.Populated_optindate_pcnt *   0.00 / 100 + T.Populated_emailaddress_pcnt *   0.00 / 100 + T.Populated_anchorinternalcode_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'firstname','lastname','address_1','address_2','city','state','zipcode','sourceurl','ipaddress','optindate','emailaddress','anchorinternalcode','addresstype','dob','latitude','longitude');
  SELF.populated_pcnt := CHOOSE(C,le.populated_firstname_pcnt,le.populated_lastname_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_sourceurl_pcnt,le.populated_ipaddress_pcnt,le.populated_optindate_pcnt,le.populated_emailaddress_pcnt,le.populated_anchorinternalcode_pcnt,le.populated_addresstype_pcnt,le.populated_dob_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_firstname,le.maxlength_lastname,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_sourceurl,le.maxlength_ipaddress,le.maxlength_optindate,le.maxlength_emailaddress,le.maxlength_anchorinternalcode,le.maxlength_addresstype,le.maxlength_dob,le.maxlength_latitude,le.maxlength_longitude);
  SELF.avelength := CHOOSE(C,le.avelength_firstname,le.avelength_lastname,le.avelength_address_1,le.avelength_address_2,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_sourceurl,le.avelength_ipaddress,le.avelength_optindate,le.avelength_emailaddress,le.avelength_anchorinternalcode,le.avelength_addresstype,le.avelength_dob,le.avelength_latitude,le.avelength_longitude);
END;
EXPORT invSummary := NORMALIZE(summary0, 16, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.sourceurl),TRIM((SALT38.StrType)le.ipaddress),TRIM((SALT38.StrType)le.optindate),TRIM((SALT38.StrType)le.emailaddress),TRIM((SALT38.StrType)le.anchorinternalcode),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.latitude),TRIM((SALT38.StrType)le.longitude)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,16,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 16);
  SELF.FldNo2 := 1 + (C % 16);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.sourceurl),TRIM((SALT38.StrType)le.ipaddress),TRIM((SALT38.StrType)le.optindate),TRIM((SALT38.StrType)le.emailaddress),TRIM((SALT38.StrType)le.anchorinternalcode),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.latitude),TRIM((SALT38.StrType)le.longitude)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.sourceurl),TRIM((SALT38.StrType)le.ipaddress),TRIM((SALT38.StrType)le.optindate),TRIM((SALT38.StrType)le.emailaddress),TRIM((SALT38.StrType)le.anchorinternalcode),TRIM((SALT38.StrType)le.addresstype),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.latitude),TRIM((SALT38.StrType)le.longitude)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),16*16,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'firstname'}
      ,{2,'lastname'}
      ,{3,'address_1'}
      ,{4,'address_2'}
      ,{5,'city'}
      ,{6,'state'}
      ,{7,'zipcode'}
      ,{8,'sourceurl'}
      ,{9,'ipaddress'}
      ,{10,'optindate'}
      ,{11,'emailaddress'}
      ,{12,'anchorinternalcode'}
      ,{13,'addresstype'}
      ,{14,'dob'}
      ,{15,'latitude'}
      ,{16,'longitude'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_firstname((SALT38.StrType)le.firstname),
    Fields.InValid_lastname((SALT38.StrType)le.lastname),
    Fields.InValid_address_1((SALT38.StrType)le.address_1),
    Fields.InValid_address_2((SALT38.StrType)le.address_2),
    Fields.InValid_city((SALT38.StrType)le.city),
    Fields.InValid_state((SALT38.StrType)le.state),
    Fields.InValid_zipcode((SALT38.StrType)le.zipcode),
    Fields.InValid_sourceurl((SALT38.StrType)le.sourceurl),
    Fields.InValid_ipaddress((SALT38.StrType)le.ipaddress),
    Fields.InValid_optindate((SALT38.StrType)le.optindate),
    Fields.InValid_emailaddress((SALT38.StrType)le.emailaddress),
    Fields.InValid_anchorinternalcode((SALT38.StrType)le.anchorinternalcode),
    Fields.InValid_addresstype((SALT38.StrType)le.addresstype),
    Fields.InValid_dob((SALT38.StrType)le.dob),
    Fields.InValid_latitude((SALT38.StrType)le.latitude),
    Fields.InValid_longitude((SALT38.StrType)le.longitude),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_name','invalid_name','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip','Unknown','invalid_ip','invalid_date','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_sourceurl(TotalErrors.ErrorNum),Fields.InValidMessage_ipaddress(TotalErrors.ErrorNum),Fields.InValidMessage_optindate(TotalErrors.ErrorNum),Fields.InValidMessage_emailaddress(TotalErrors.ErrorNum),Fields.InValidMessage_anchorinternalcode(TotalErrors.ErrorNum),Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Anchor, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
