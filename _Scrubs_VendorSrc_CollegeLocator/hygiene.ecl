IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_CollegeLocator) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_lnfilecategory_cnt := COUNT(GROUP,h.lnfilecategory <> (TYPEOF(h.lnfilecategory))'');
    populated_lnfilecategory_pcnt := AVE(GROUP,IF(h.lnfilecategory = (TYPEOF(h.lnfilecategory))'',0,100));
    maxlength_lnfilecategory := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnfilecategory)));
    avelength_lnfilecategory := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnfilecategory)),h.lnfilecategory<>(typeof(h.lnfilecategory))'');
    populated_lnsourcetcode_cnt := COUNT(GROUP,h.lnsourcetcode <> (TYPEOF(h.lnsourcetcode))'');
    populated_lnsourcetcode_pcnt := AVE(GROUP,IF(h.lnsourcetcode = (TYPEOF(h.lnsourcetcode))'',0,100));
    maxlength_lnsourcetcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnsourcetcode)));
    avelength_lnsourcetcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnsourcetcode)),h.lnsourcetcode<>(typeof(h.lnsourcetcode))'');
    populated_vendorname_cnt := COUNT(GROUP,h.vendorname <> (TYPEOF(h.vendorname))'');
    populated_vendorname_pcnt := AVE(GROUP,IF(h.vendorname = (TYPEOF(h.vendorname))'',0,100));
    maxlength_vendorname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorname)));
    avelength_vendorname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendorname)),h.vendorname<>(typeof(h.vendorname))'');
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
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_lnfilecategory_pcnt *   0.00 / 100 + T.Populated_lnsourcetcode_pcnt *   0.00 / 100 + T.Populated_vendorname_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'lnfilecategory','lnsourcetcode','vendorname','address1','address2','city','state','zipcode','phone');
  SELF.populated_pcnt := CHOOSE(C,le.populated_lnfilecategory_pcnt,le.populated_lnsourcetcode_pcnt,le.populated_vendorname_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_phone_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_lnfilecategory,le.maxlength_lnsourcetcode,le.maxlength_vendorname,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_phone);
  SELF.avelength := CHOOSE(C,le.avelength_lnfilecategory,le.avelength_lnsourcetcode,le.avelength_vendorname,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_phone);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.lnfilecategory),TRIM((SALT311.StrType)le.lnsourcetcode),TRIM((SALT311.StrType)le.vendorname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.phone)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.lnfilecategory),TRIM((SALT311.StrType)le.lnsourcetcode),TRIM((SALT311.StrType)le.vendorname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.phone)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.lnfilecategory),TRIM((SALT311.StrType)le.lnsourcetcode),TRIM((SALT311.StrType)le.vendorname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zipcode),TRIM((SALT311.StrType)le.phone)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'lnfilecategory'}
      ,{2,'lnsourcetcode'}
      ,{3,'vendorname'}
      ,{4,'address1'}
      ,{5,'address2'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'zipcode'}
      ,{9,'phone'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_lnfilecategory((SALT311.StrType)le.lnfilecategory),
    Fields.InValid_lnsourcetcode((SALT311.StrType)le.lnsourcetcode),
    Fields.InValid_vendorname((SALT311.StrType)le.vendorname),
    Fields.InValid_address1((SALT311.StrType)le.address1),
    Fields.InValid_address2((SALT311.StrType)le.address2),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zipcode((SALT311.StrType)le.zipcode),
    Fields.InValid_phone((SALT311.StrType)le.phone),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,9,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_lnfilecategory(TotalErrors.ErrorNum),Fields.InValidMessage_lnsourcetcode(TotalErrors.ErrorNum),Fields.InValidMessage_vendorname(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(_Scrubs_VendorSrc_CollegeLocator, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
