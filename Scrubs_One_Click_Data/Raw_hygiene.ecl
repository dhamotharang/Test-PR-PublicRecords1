IMPORT SALT311,STD;
EXPORT Raw_hygiene(dataset(Raw_layout_One_Click_Data) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_homeaddress_cnt := COUNT(GROUP,h.homeaddress <> (TYPEOF(h.homeaddress))'');
    populated_homeaddress_pcnt := AVE(GROUP,IF(h.homeaddress = (TYPEOF(h.homeaddress))'',0,100));
    maxlength_homeaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeaddress)));
    avelength_homeaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeaddress)),h.homeaddress<>(typeof(h.homeaddress))'');
    populated_homecity_cnt := COUNT(GROUP,h.homecity <> (TYPEOF(h.homecity))'');
    populated_homecity_pcnt := AVE(GROUP,IF(h.homecity = (TYPEOF(h.homecity))'',0,100));
    maxlength_homecity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homecity)));
    avelength_homecity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homecity)),h.homecity<>(typeof(h.homecity))'');
    populated_homestate_cnt := COUNT(GROUP,h.homestate <> (TYPEOF(h.homestate))'');
    populated_homestate_pcnt := AVE(GROUP,IF(h.homestate = (TYPEOF(h.homestate))'',0,100));
    maxlength_homestate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestate)));
    avelength_homestate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestate)),h.homestate<>(typeof(h.homestate))'');
    populated_homezip_cnt := COUNT(GROUP,h.homezip <> (TYPEOF(h.homezip))'');
    populated_homezip_pcnt := AVE(GROUP,IF(h.homezip = (TYPEOF(h.homezip))'',0,100));
    maxlength_homezip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homezip)));
    avelength_homezip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homezip)),h.homezip<>(typeof(h.homezip))'');
    populated_homephone_cnt := COUNT(GROUP,h.homephone <> (TYPEOF(h.homephone))'');
    populated_homephone_pcnt := AVE(GROUP,IF(h.homephone = (TYPEOF(h.homephone))'',0,100));
    maxlength_homephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homephone)));
    avelength_homephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homephone)),h.homephone<>(typeof(h.homephone))'');
    populated_mobilephone_cnt := COUNT(GROUP,h.mobilephone <> (TYPEOF(h.mobilephone))'');
    populated_mobilephone_pcnt := AVE(GROUP,IF(h.mobilephone = (TYPEOF(h.mobilephone))'',0,100));
    maxlength_mobilephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobilephone)));
    avelength_mobilephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mobilephone)),h.mobilephone<>(typeof(h.mobilephone))'');
    populated_emailaddress_cnt := COUNT(GROUP,h.emailaddress <> (TYPEOF(h.emailaddress))'');
    populated_emailaddress_pcnt := AVE(GROUP,IF(h.emailaddress = (TYPEOF(h.emailaddress))'',0,100));
    maxlength_emailaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailaddress)));
    avelength_emailaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailaddress)),h.emailaddress<>(typeof(h.emailaddress))'');
    populated_workname_cnt := COUNT(GROUP,h.workname <> (TYPEOF(h.workname))'');
    populated_workname_pcnt := AVE(GROUP,IF(h.workname = (TYPEOF(h.workname))'',0,100));
    maxlength_workname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workname)));
    avelength_workname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workname)),h.workname<>(typeof(h.workname))'');
    populated_workaddress_cnt := COUNT(GROUP,h.workaddress <> (TYPEOF(h.workaddress))'');
    populated_workaddress_pcnt := AVE(GROUP,IF(h.workaddress = (TYPEOF(h.workaddress))'',0,100));
    maxlength_workaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workaddress)));
    avelength_workaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workaddress)),h.workaddress<>(typeof(h.workaddress))'');
    populated_workcity_cnt := COUNT(GROUP,h.workcity <> (TYPEOF(h.workcity))'');
    populated_workcity_pcnt := AVE(GROUP,IF(h.workcity = (TYPEOF(h.workcity))'',0,100));
    maxlength_workcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcity)));
    avelength_workcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workcity)),h.workcity<>(typeof(h.workcity))'');
    populated_workstate_cnt := COUNT(GROUP,h.workstate <> (TYPEOF(h.workstate))'');
    populated_workstate_pcnt := AVE(GROUP,IF(h.workstate = (TYPEOF(h.workstate))'',0,100));
    maxlength_workstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workstate)));
    avelength_workstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workstate)),h.workstate<>(typeof(h.workstate))'');
    populated_workzip_cnt := COUNT(GROUP,h.workzip <> (TYPEOF(h.workzip))'');
    populated_workzip_pcnt := AVE(GROUP,IF(h.workzip = (TYPEOF(h.workzip))'',0,100));
    maxlength_workzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workzip)));
    avelength_workzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workzip)),h.workzip<>(typeof(h.workzip))'');
    populated_workphone_cnt := COUNT(GROUP,h.workphone <> (TYPEOF(h.workphone))'');
    populated_workphone_pcnt := AVE(GROUP,IF(h.workphone = (TYPEOF(h.workphone))'',0,100));
    maxlength_workphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.workphone)));
    avelength_workphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.workphone)),h.workphone<>(typeof(h.workphone))'');
    populated_ref1firstname_cnt := COUNT(GROUP,h.ref1firstname <> (TYPEOF(h.ref1firstname))'');
    populated_ref1firstname_pcnt := AVE(GROUP,IF(h.ref1firstname = (TYPEOF(h.ref1firstname))'',0,100));
    maxlength_ref1firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1firstname)));
    avelength_ref1firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1firstname)),h.ref1firstname<>(typeof(h.ref1firstname))'');
    populated_ref1lastname_cnt := COUNT(GROUP,h.ref1lastname <> (TYPEOF(h.ref1lastname))'');
    populated_ref1lastname_pcnt := AVE(GROUP,IF(h.ref1lastname = (TYPEOF(h.ref1lastname))'',0,100));
    maxlength_ref1lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1lastname)));
    avelength_ref1lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1lastname)),h.ref1lastname<>(typeof(h.ref1lastname))'');
    populated_ref1phone_cnt := COUNT(GROUP,h.ref1phone <> (TYPEOF(h.ref1phone))'');
    populated_ref1phone_pcnt := AVE(GROUP,IF(h.ref1phone = (TYPEOF(h.ref1phone))'',0,100));
    maxlength_ref1phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1phone)));
    avelength_ref1phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ref1phone)),h.ref1phone<>(typeof(h.ref1phone))'');
    populated_lastinquirydate_cnt := COUNT(GROUP,h.lastinquirydate <> (TYPEOF(h.lastinquirydate))'');
    populated_lastinquirydate_pcnt := AVE(GROUP,IF(h.lastinquirydate = (TYPEOF(h.lastinquirydate))'',0,100));
    maxlength_lastinquirydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastinquirydate)));
    avelength_lastinquirydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastinquirydate)),h.lastinquirydate<>(typeof(h.lastinquirydate))'');
    populated_ip_cnt := COUNT(GROUP,h.ip <> (TYPEOF(h.ip))'');
    populated_ip_pcnt := AVE(GROUP,IF(h.ip = (TYPEOF(h.ip))'',0,100));
    maxlength_ip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip)));
    avelength_ip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip)),h.ip<>(typeof(h.ip))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_homeaddress_pcnt *   0.00 / 100 + T.Populated_homecity_pcnt *   0.00 / 100 + T.Populated_homestate_pcnt *   0.00 / 100 + T.Populated_homezip_pcnt *   0.00 / 100 + T.Populated_homephone_pcnt *   0.00 / 100 + T.Populated_mobilephone_pcnt *   0.00 / 100 + T.Populated_emailaddress_pcnt *   0.00 / 100 + T.Populated_workname_pcnt *   0.00 / 100 + T.Populated_workaddress_pcnt *   0.00 / 100 + T.Populated_workcity_pcnt *   0.00 / 100 + T.Populated_workstate_pcnt *   0.00 / 100 + T.Populated_workzip_pcnt *   0.00 / 100 + T.Populated_workphone_pcnt *   0.00 / 100 + T.Populated_ref1firstname_pcnt *   0.00 / 100 + T.Populated_ref1lastname_pcnt *   0.00 / 100 + T.Populated_ref1phone_pcnt *   0.00 / 100 + T.Populated_lastinquirydate_pcnt *   0.00 / 100 + T.Populated_ip_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ssn','firstname','lastname','dob','homeaddress','homecity','homestate','homezip','homephone','mobilephone','emailaddress','workname','workaddress','workcity','workstate','workzip','workphone','ref1firstname','ref1lastname','ref1phone','lastinquirydate','ip');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ssn_pcnt,le.populated_firstname_pcnt,le.populated_lastname_pcnt,le.populated_dob_pcnt,le.populated_homeaddress_pcnt,le.populated_homecity_pcnt,le.populated_homestate_pcnt,le.populated_homezip_pcnt,le.populated_homephone_pcnt,le.populated_mobilephone_pcnt,le.populated_emailaddress_pcnt,le.populated_workname_pcnt,le.populated_workaddress_pcnt,le.populated_workcity_pcnt,le.populated_workstate_pcnt,le.populated_workzip_pcnt,le.populated_workphone_pcnt,le.populated_ref1firstname_pcnt,le.populated_ref1lastname_pcnt,le.populated_ref1phone_pcnt,le.populated_lastinquirydate_pcnt,le.populated_ip_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ssn,le.maxlength_firstname,le.maxlength_lastname,le.maxlength_dob,le.maxlength_homeaddress,le.maxlength_homecity,le.maxlength_homestate,le.maxlength_homezip,le.maxlength_homephone,le.maxlength_mobilephone,le.maxlength_emailaddress,le.maxlength_workname,le.maxlength_workaddress,le.maxlength_workcity,le.maxlength_workstate,le.maxlength_workzip,le.maxlength_workphone,le.maxlength_ref1firstname,le.maxlength_ref1lastname,le.maxlength_ref1phone,le.maxlength_lastinquirydate,le.maxlength_ip);
  SELF.avelength := CHOOSE(C,le.avelength_ssn,le.avelength_firstname,le.avelength_lastname,le.avelength_dob,le.avelength_homeaddress,le.avelength_homecity,le.avelength_homestate,le.avelength_homezip,le.avelength_homephone,le.avelength_mobilephone,le.avelength_emailaddress,le.avelength_workname,le.avelength_workaddress,le.avelength_workcity,le.avelength_workstate,le.avelength_workzip,le.avelength_workphone,le.avelength_ref1firstname,le.avelength_ref1lastname,le.avelength_ref1phone,le.avelength_lastinquirydate,le.avelength_ip);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.homeaddress),TRIM((SALT311.StrType)le.homecity),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.homezip),TRIM((SALT311.StrType)le.homephone),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.workname),TRIM((SALT311.StrType)le.workaddress),TRIM((SALT311.StrType)le.workcity),TRIM((SALT311.StrType)le.workstate),TRIM((SALT311.StrType)le.workzip),TRIM((SALT311.StrType)le.workphone),TRIM((SALT311.StrType)le.ref1firstname),TRIM((SALT311.StrType)le.ref1lastname),TRIM((SALT311.StrType)le.ref1phone),TRIM((SALT311.StrType)le.lastinquirydate),TRIM((SALT311.StrType)le.ip)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.homeaddress),TRIM((SALT311.StrType)le.homecity),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.homezip),TRIM((SALT311.StrType)le.homephone),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.workname),TRIM((SALT311.StrType)le.workaddress),TRIM((SALT311.StrType)le.workcity),TRIM((SALT311.StrType)le.workstate),TRIM((SALT311.StrType)le.workzip),TRIM((SALT311.StrType)le.workphone),TRIM((SALT311.StrType)le.ref1firstname),TRIM((SALT311.StrType)le.ref1lastname),TRIM((SALT311.StrType)le.ref1phone),TRIM((SALT311.StrType)le.lastinquirydate),TRIM((SALT311.StrType)le.ip)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.homeaddress),TRIM((SALT311.StrType)le.homecity),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.homezip),TRIM((SALT311.StrType)le.homephone),TRIM((SALT311.StrType)le.mobilephone),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.workname),TRIM((SALT311.StrType)le.workaddress),TRIM((SALT311.StrType)le.workcity),TRIM((SALT311.StrType)le.workstate),TRIM((SALT311.StrType)le.workzip),TRIM((SALT311.StrType)le.workphone),TRIM((SALT311.StrType)le.ref1firstname),TRIM((SALT311.StrType)le.ref1lastname),TRIM((SALT311.StrType)le.ref1phone),TRIM((SALT311.StrType)le.lastinquirydate),TRIM((SALT311.StrType)le.ip)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ssn'}
      ,{2,'firstname'}
      ,{3,'lastname'}
      ,{4,'dob'}
      ,{5,'homeaddress'}
      ,{6,'homecity'}
      ,{7,'homestate'}
      ,{8,'homezip'}
      ,{9,'homephone'}
      ,{10,'mobilephone'}
      ,{11,'emailaddress'}
      ,{12,'workname'}
      ,{13,'workaddress'}
      ,{14,'workcity'}
      ,{15,'workstate'}
      ,{16,'workzip'}
      ,{17,'workphone'}
      ,{18,'ref1firstname'}
      ,{19,'ref1lastname'}
      ,{20,'ref1phone'}
      ,{21,'lastinquirydate'}
      ,{22,'ip'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Raw_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Raw_Fields.InValid_firstname((SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname),
    Raw_Fields.InValid_lastname((SALT311.StrType)le.lastname),
    Raw_Fields.InValid_dob((SALT311.StrType)le.dob),
    Raw_Fields.InValid_homeaddress((SALT311.StrType)le.homeaddress),
    Raw_Fields.InValid_homecity((SALT311.StrType)le.homecity),
    Raw_Fields.InValid_homestate((SALT311.StrType)le.homestate),
    Raw_Fields.InValid_homezip((SALT311.StrType)le.homezip),
    Raw_Fields.InValid_homephone((SALT311.StrType)le.homephone),
    Raw_Fields.InValid_mobilephone((SALT311.StrType)le.mobilephone),
    Raw_Fields.InValid_emailaddress((SALT311.StrType)le.emailaddress),
    Raw_Fields.InValid_workname((SALT311.StrType)le.workname),
    Raw_Fields.InValid_workaddress((SALT311.StrType)le.workaddress),
    Raw_Fields.InValid_workcity((SALT311.StrType)le.workcity),
    Raw_Fields.InValid_workstate((SALT311.StrType)le.workstate),
    Raw_Fields.InValid_workzip((SALT311.StrType)le.workzip),
    Raw_Fields.InValid_workphone((SALT311.StrType)le.workphone),
    Raw_Fields.InValid_ref1firstname((SALT311.StrType)le.ref1firstname),
    Raw_Fields.InValid_ref1lastname((SALT311.StrType)le.ref1lastname),
    Raw_Fields.InValid_ref1phone((SALT311.StrType)le.ref1phone),
    Raw_Fields.InValid_lastinquirydate((SALT311.StrType)le.lastinquirydate),
    Raw_Fields.InValid_ip((SALT311.StrType)le.ip),
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
  FieldNme := Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_SSN','Invalid_fName','Unknown','Invalid_Dob','Invalid_mandatory_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Phone','Unknown','Invalid_mandatory_Alpha','Unknown','Unknown','Unknown','Unknown','Invalid_Phone','Unknown','Unknown','Invalid_Phone','Invalid_pastDate','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Raw_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_homeaddress(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_homecity(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_homestate(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_homezip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_homephone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_mobilephone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_emailaddress(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workaddress(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workcity(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workstate(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workzip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_workphone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ref1firstname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ref1lastname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ref1phone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_lastinquirydate(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_One_Click_Data, Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
