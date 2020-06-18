IMPORT SALT311,STD;
EXPORT CC_hygiene(dataset(CC_layout_Debt_Settlement) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_idnum_cnt := COUNT(GROUP,h.idnum <> (TYPEOF(h.idnum))'');
    populated_idnum_pcnt := AVE(GROUP,IF(h.idnum = (TYPEOF(h.idnum))'',0,100));
    maxlength_idnum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.idnum)));
    avelength_idnum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.idnum)),h.idnum<>(typeof(h.idnum))'');
    populated_businessname_cnt := COUNT(GROUP,h.businessname <> (TYPEOF(h.businessname))'');
    populated_businessname_pcnt := AVE(GROUP,IF(h.businessname = (TYPEOF(h.businessname))'',0,100));
    maxlength_businessname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)));
    avelength_businessname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businessname)),h.businessname<>(typeof(h.businessname))'');
    populated_dba_cnt := COUNT(GROUP,h.dba <> (TYPEOF(h.dba))'');
    populated_dba_pcnt := AVE(GROUP,IF(h.dba = (TYPEOF(h.dba))'',0,100));
    maxlength_dba := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)));
    avelength_dba := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba)),h.dba<>(typeof(h.dba))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
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
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_fax_cnt := COUNT(GROUP,h.fax <> (TYPEOF(h.fax))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_licensedatefrom_cnt := COUNT(GROUP,h.licensedatefrom <> (TYPEOF(h.licensedatefrom))'');
    populated_licensedatefrom_pcnt := AVE(GROUP,IF(h.licensedatefrom = (TYPEOF(h.licensedatefrom))'',0,100));
    maxlength_licensedatefrom := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedatefrom)));
    avelength_licensedatefrom := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedatefrom)),h.licensedatefrom<>(typeof(h.licensedatefrom))'');
    populated_licensedateto_cnt := COUNT(GROUP,h.licensedateto <> (TYPEOF(h.licensedateto))'');
    populated_licensedateto_pcnt := AVE(GROUP,IF(h.licensedateto = (TYPEOF(h.licensedateto))'',0,100));
    maxlength_licensedateto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedateto)));
    avelength_licensedateto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensedateto)),h.licensedateto<>(typeof(h.licensedateto))'');
    populated_orgtype_cnt := COUNT(GROUP,h.orgtype <> (TYPEOF(h.orgtype))'');
    populated_orgtype_pcnt := AVE(GROUP,IF(h.orgtype = (TYPEOF(h.orgtype))'',0,100));
    maxlength_orgtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgtype)));
    avelength_orgtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgtype)),h.orgtype<>(typeof(h.orgtype))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_idnum_pcnt *   0.00 / 100 + T.Populated_businessname_pcnt *   0.00 / 100 + T.Populated_dba_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_licensedatefrom_pcnt *   0.00 / 100 + T.Populated_licensedateto_pcnt *   0.00 / 100 + T.Populated_orgtype_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'idnum','businessname','dba','orgid','address1','address2','city','state','zip','zip4','phone','fax','email','url','status','licensedatefrom','licensedateto','orgtype','source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_idnum_pcnt,le.populated_businessname_pcnt,le.populated_dba_pcnt,le.populated_orgid_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_phone_pcnt,le.populated_fax_pcnt,le.populated_email_pcnt,le.populated_url_pcnt,le.populated_status_pcnt,le.populated_licensedatefrom_pcnt,le.populated_licensedateto_pcnt,le.populated_orgtype_pcnt,le.populated_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_idnum,le.maxlength_businessname,le.maxlength_dba,le.maxlength_orgid,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_phone,le.maxlength_fax,le.maxlength_email,le.maxlength_url,le.maxlength_status,le.maxlength_licensedatefrom,le.maxlength_licensedateto,le.maxlength_orgtype,le.maxlength_source);
  SELF.avelength := CHOOSE(C,le.avelength_idnum,le.avelength_businessname,le.avelength_dba,le.avelength_orgid,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_phone,le.avelength_fax,le.avelength_email,le.avelength_url,le.avelength_status,le.avelength_licensedatefrom,le.avelength_licensedateto,le.avelength_orgtype,le.avelength_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 19, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.idnum),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.licensedatefrom),TRIM((SALT311.StrType)le.licensedateto),TRIM((SALT311.StrType)le.orgtype),TRIM((SALT311.StrType)le.source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,19,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 19);
  SELF.FldNo2 := 1 + (C % 19);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.idnum),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.licensedatefrom),TRIM((SALT311.StrType)le.licensedateto),TRIM((SALT311.StrType)le.orgtype),TRIM((SALT311.StrType)le.source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.idnum),TRIM((SALT311.StrType)le.businessname),TRIM((SALT311.StrType)le.dba),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.licensedatefrom),TRIM((SALT311.StrType)le.licensedateto),TRIM((SALT311.StrType)le.orgtype),TRIM((SALT311.StrType)le.source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),19*19,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'idnum'}
      ,{2,'businessname'}
      ,{3,'dba'}
      ,{4,'orgid'}
      ,{5,'address1'}
      ,{6,'address2'}
      ,{7,'city'}
      ,{8,'state'}
      ,{9,'zip'}
      ,{10,'zip4'}
      ,{11,'phone'}
      ,{12,'fax'}
      ,{13,'email'}
      ,{14,'url'}
      ,{15,'status'}
      ,{16,'licensedatefrom'}
      ,{17,'licensedateto'}
      ,{18,'orgtype'}
      ,{19,'source'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CC_Fields.InValid_idnum((SALT311.StrType)le.idnum),
    CC_Fields.InValid_businessname((SALT311.StrType)le.businessname),
    CC_Fields.InValid_dba((SALT311.StrType)le.dba),
    CC_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    CC_Fields.InValid_address1((SALT311.StrType)le.address1),
    CC_Fields.InValid_address2((SALT311.StrType)le.address2),
    CC_Fields.InValid_city((SALT311.StrType)le.city),
    CC_Fields.InValid_state((SALT311.StrType)le.state),
    CC_Fields.InValid_zip((SALT311.StrType)le.zip),
    CC_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    CC_Fields.InValid_phone((SALT311.StrType)le.phone),
    CC_Fields.InValid_fax((SALT311.StrType)le.fax),
    CC_Fields.InValid_email((SALT311.StrType)le.email),
    CC_Fields.InValid_url((SALT311.StrType)le.url),
    CC_Fields.InValid_status((SALT311.StrType)le.status),
    CC_Fields.InValid_licensedatefrom((SALT311.StrType)le.licensedatefrom),
    CC_Fields.InValid_licensedateto((SALT311.StrType)le.licensedateto),
    CC_Fields.InValid_orgtype((SALT311.StrType)le.orgtype),
    CC_Fields.InValid_source((SALT311.StrType)le.source),
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
  FieldNme := CC_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_id','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_St','Invalid_zip','Invalid_zip4','Invalid_Phone','Unknown','Unknown','Invalid_alpha','Invalid_Status','Invalid_Date','Invalid_Future_Date','Invalid_OrgType','Invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CC_Fields.InValidMessage_idnum(TotalErrors.ErrorNum),CC_Fields.InValidMessage_businessname(TotalErrors.ErrorNum),CC_Fields.InValidMessage_dba(TotalErrors.ErrorNum),CC_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),CC_Fields.InValidMessage_address1(TotalErrors.ErrorNum),CC_Fields.InValidMessage_address2(TotalErrors.ErrorNum),CC_Fields.InValidMessage_city(TotalErrors.ErrorNum),CC_Fields.InValidMessage_state(TotalErrors.ErrorNum),CC_Fields.InValidMessage_zip(TotalErrors.ErrorNum),CC_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),CC_Fields.InValidMessage_phone(TotalErrors.ErrorNum),CC_Fields.InValidMessage_fax(TotalErrors.ErrorNum),CC_Fields.InValidMessage_email(TotalErrors.ErrorNum),CC_Fields.InValidMessage_url(TotalErrors.ErrorNum),CC_Fields.InValidMessage_status(TotalErrors.ErrorNum),CC_Fields.InValidMessage_licensedatefrom(TotalErrors.ErrorNum),CC_Fields.InValidMessage_licensedateto(TotalErrors.ErrorNum),CC_Fields.InValidMessage_orgtype(TotalErrors.ErrorNum),CC_Fields.InValidMessage_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Debt_Settlement, CC_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
