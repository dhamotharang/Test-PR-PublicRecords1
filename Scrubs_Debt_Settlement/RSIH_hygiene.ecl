IMPORT SALT311,STD;
EXPORT RSIH_hygiene(dataset(RSIH_layout_Debt_Settlement) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_avdanumber_cnt := COUNT(GROUP,h.avdanumber <> (TYPEOF(h.avdanumber))'');
    populated_avdanumber_pcnt := AVE(GROUP,IF(h.avdanumber = (TYPEOF(h.avdanumber))'',0,100));
    maxlength_avdanumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.avdanumber)));
    avelength_avdanumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.avdanumber)),h.avdanumber<>(typeof(h.avdanumber))'');
    populated_attorneyname_cnt := COUNT(GROUP,h.attorneyname <> (TYPEOF(h.attorneyname))'');
    populated_attorneyname_pcnt := AVE(GROUP,IF(h.attorneyname = (TYPEOF(h.attorneyname))'',0,100));
    maxlength_attorneyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneyname)));
    avelength_attorneyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attorneyname)),h.attorneyname<>(typeof(h.attorneyname))'');
    populated_businessname_cnt := COUNT(GROUP,h.businessname <> (TYPEOF(h.businessname))'');
    populated_businessname_pcnt := AVE(GROUP,IF(h.businessname = (TYPEOF(h.businessname))'',0,100));
    maxlength_businessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)));
    avelength_businessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)),h.businessname<>(typeof(h.businessname))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_primary_range_cln_cnt := COUNT(GROUP,h.primary_range_cln <> (TYPEOF(h.primary_range_cln))'');
    populated_primary_range_cln_pcnt := AVE(GROUP,IF(h.primary_range_cln = (TYPEOF(h.primary_range_cln))'',0,100));
    maxlength_primary_range_cln := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_range_cln)));
    avelength_primary_range_cln := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_range_cln)),h.primary_range_cln<>(typeof(h.primary_range_cln))'');
    populated_primary_name_cln_cnt := COUNT(GROUP,h.primary_name_cln <> (TYPEOF(h.primary_name_cln))'');
    populated_primary_name_cln_pcnt := AVE(GROUP,IF(h.primary_name_cln = (TYPEOF(h.primary_name_cln))'',0,100));
    maxlength_primary_name_cln := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_name_cln)));
    avelength_primary_name_cln := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_name_cln)),h.primary_name_cln<>(typeof(h.primary_name_cln))'');
    populated_sec_range_cln_cnt := COUNT(GROUP,h.sec_range_cln <> (TYPEOF(h.sec_range_cln))'');
    populated_sec_range_cln_pcnt := AVE(GROUP,IF(h.sec_range_cln = (TYPEOF(h.sec_range_cln))'',0,100));
    maxlength_sec_range_cln := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_cln)));
    avelength_sec_range_cln := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_cln)),h.sec_range_cln<>(typeof(h.sec_range_cln))'');
    populated_zip_cln_cnt := COUNT(GROUP,h.zip_cln <> (TYPEOF(h.zip_cln))'');
    populated_zip_cln_pcnt := AVE(GROUP,IF(h.zip_cln = (TYPEOF(h.zip_cln))'',0,100));
    maxlength_zip_cln := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cln)));
    avelength_zip_cln := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_cln)),h.zip_cln<>(typeof(h.zip_cln))'');
    populated_did_header_addr_count_cnt := COUNT(GROUP,h.did_header_addr_count <> (TYPEOF(h.did_header_addr_count))'');
    populated_did_header_addr_count_pcnt := AVE(GROUP,IF(h.did_header_addr_count = (TYPEOF(h.did_header_addr_count))'',0,100));
    maxlength_did_header_addr_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_header_addr_count)));
    avelength_did_header_addr_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_header_addr_count)),h.did_header_addr_count<>(typeof(h.did_header_addr_count))'');
    populated_did_header_phone_count_cnt := COUNT(GROUP,h.did_header_phone_count <> (TYPEOF(h.did_header_phone_count))'');
    populated_did_header_phone_count_pcnt := AVE(GROUP,IF(h.did_header_phone_count = (TYPEOF(h.did_header_phone_count))'',0,100));
    maxlength_did_header_phone_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_header_phone_count)));
    avelength_did_header_phone_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_header_phone_count)),h.did_header_phone_count<>(typeof(h.did_header_phone_count))'');
    populated_did_phoneplus_gongphone_count_cnt := COUNT(GROUP,h.did_phoneplus_gongphone_count <> (TYPEOF(h.did_phoneplus_gongphone_count))'');
    populated_did_phoneplus_gongphone_count_pcnt := AVE(GROUP,IF(h.did_phoneplus_gongphone_count = (TYPEOF(h.did_phoneplus_gongphone_count))'',0,100));
    maxlength_did_phoneplus_gongphone_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_phoneplus_gongphone_count)));
    avelength_did_phoneplus_gongphone_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_phoneplus_gongphone_count)),h.did_phoneplus_gongphone_count<>(typeof(h.did_phoneplus_gongphone_count))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_avdanumber_pcnt *   0.00 / 100 + T.Populated_attorneyname_pcnt *   0.00 / 100 + T.Populated_businessname_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_primary_range_cln_pcnt *   0.00 / 100 + T.Populated_primary_name_cln_pcnt *   0.00 / 100 + T.Populated_sec_range_cln_pcnt *   0.00 / 100 + T.Populated_zip_cln_pcnt *   0.00 / 100 + T.Populated_did_header_addr_count_pcnt *   0.00 / 100 + T.Populated_did_header_phone_count_pcnt *   0.00 / 100 + T.Populated_did_phoneplus_gongphone_count_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'avdanumber','attorneyname','businessname','address1','address2','phone','email','primary_range_cln','primary_name_cln','sec_range_cln','zip_cln','did_header_addr_count','did_header_phone_count','did_phoneplus_gongphone_count');
  SELF.populated_pcnt := CHOOSE(C,le.populated_avdanumber_pcnt,le.populated_attorneyname_pcnt,le.populated_businessname_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_phone_pcnt,le.populated_email_pcnt,le.populated_primary_range_cln_pcnt,le.populated_primary_name_cln_pcnt,le.populated_sec_range_cln_pcnt,le.populated_zip_cln_pcnt,le.populated_did_header_addr_count_pcnt,le.populated_did_header_phone_count_pcnt,le.populated_did_phoneplus_gongphone_count_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_avdanumber,le.maxlength_attorneyname,le.maxlength_businessname,le.maxlength_address1,le.maxlength_address2,le.maxlength_phone,le.maxlength_email,le.maxlength_primary_range_cln,le.maxlength_primary_name_cln,le.maxlength_sec_range_cln,le.maxlength_zip_cln,le.maxlength_did_header_addr_count,le.maxlength_did_header_phone_count,le.maxlength_did_phoneplus_gongphone_count);
  SELF.avelength := CHOOSE(C,le.avelength_avdanumber,le.avelength_attorneyname,le.avelength_businessname,le.avelength_address1,le.avelength_address2,le.avelength_phone,le.avelength_email,le.avelength_primary_range_cln,le.avelength_primary_name_cln,le.avelength_sec_range_cln,le.avelength_zip_cln,le.avelength_did_header_addr_count,le.avelength_did_header_phone_count,le.avelength_did_phoneplus_gongphone_count);
END;
EXPORT invSummary := NORMALIZE(summary0, 14, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.avdanumber),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.primary_range_cln),TRIM((SALT311.StrType)le.primary_name_cln),TRIM((SALT311.StrType)le.sec_range_cln),TRIM((SALT311.StrType)le.zip_cln),TRIM((SALT311.StrType)le.did_header_addr_count),TRIM((SALT311.StrType)le.did_header_phone_count),TRIM((SALT311.StrType)le.did_phoneplus_gongphone_count)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,14,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 14);
  SELF.FldNo2 := 1 + (C % 14);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.avdanumber),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.primary_range_cln),TRIM((SALT311.StrType)le.primary_name_cln),TRIM((SALT311.StrType)le.sec_range_cln),TRIM((SALT311.StrType)le.zip_cln),TRIM((SALT311.StrType)le.did_header_addr_count),TRIM((SALT311.StrType)le.did_header_phone_count),TRIM((SALT311.StrType)le.did_phoneplus_gongphone_count)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.avdanumber),TRIM((SALT311.StrType)le.attorneyname),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.primary_range_cln),TRIM((SALT311.StrType)le.primary_name_cln),TRIM((SALT311.StrType)le.sec_range_cln),TRIM((SALT311.StrType)le.zip_cln),TRIM((SALT311.StrType)le.did_header_addr_count),TRIM((SALT311.StrType)le.did_header_phone_count),TRIM((SALT311.StrType)le.did_phoneplus_gongphone_count)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),14*14,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'avdanumber'}
      ,{2,'attorneyname'}
      ,{3,'businessname'}
      ,{4,'address1'}
      ,{5,'address2'}
      ,{6,'phone'}
      ,{7,'email'}
      ,{8,'primary_range_cln'}
      ,{9,'primary_name_cln'}
      ,{10,'sec_range_cln'}
      ,{11,'zip_cln'}
      ,{12,'did_header_addr_count'}
      ,{13,'did_header_phone_count'}
      ,{14,'did_phoneplus_gongphone_count'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RSIH_Fields.InValid_avdanumber((SALT311.StrType)le.avdanumber),
    RSIH_Fields.InValid_attorneyname((SALT311.StrType)le.attorneyname),
    RSIH_Fields.InValid_businessname((SALT311.StrType)le.businessname),
    RSIH_Fields.InValid_address1((SALT311.StrType)le.address1),
    RSIH_Fields.InValid_address2((SALT311.StrType)le.address2),
    RSIH_Fields.InValid_phone((SALT311.StrType)le.phone),
    RSIH_Fields.InValid_email((SALT311.StrType)le.email),
    RSIH_Fields.InValid_primary_range_cln((SALT311.StrType)le.primary_range_cln),
    RSIH_Fields.InValid_primary_name_cln((SALT311.StrType)le.primary_name_cln),
    RSIH_Fields.InValid_sec_range_cln((SALT311.StrType)le.sec_range_cln),
    RSIH_Fields.InValid_zip_cln((SALT311.StrType)le.zip_cln),
    RSIH_Fields.InValid_did_header_addr_count((SALT311.StrType)le.did_header_addr_count),
    RSIH_Fields.InValid_did_header_phone_count((SALT311.StrType)le.did_header_phone_count),
    RSIH_Fields.InValid_did_phoneplus_gongphone_count((SALT311.StrType)le.did_phoneplus_gongphone_count),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,14,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RSIH_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_avdanum','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_Phone','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_numeric','Invalid_numeric','Invalid_numeric','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RSIH_Fields.InValidMessage_avdanumber(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_attorneyname(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_businessname(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_address1(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_address2(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_phone(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_email(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_primary_range_cln(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_primary_name_cln(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_sec_range_cln(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_zip_cln(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_did_header_addr_count(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_did_header_phone_count(TotalErrors.ErrorNum),RSIH_Fields.InValidMessage_did_phoneplus_gongphone_count(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Debt_Settlement, RSIH_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
