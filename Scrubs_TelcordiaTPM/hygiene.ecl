IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_TelcordiaTPM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_npa_cnt := COUNT(GROUP,h.npa <> (TYPEOF(h.npa))'');
    populated_npa_pcnt := AVE(GROUP,IF(h.npa = (TYPEOF(h.npa))'',0,100));
    maxlength_npa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)));
    avelength_npa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)),h.npa<>(typeof(h.npa))'');
    populated_nxx_cnt := COUNT(GROUP,h.nxx <> (TYPEOF(h.nxx))'');
    populated_nxx_pcnt := AVE(GROUP,IF(h.nxx = (TYPEOF(h.nxx))'',0,100));
    maxlength_nxx := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)));
    avelength_nxx := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)),h.nxx<>(typeof(h.nxx))'');
    populated_tb_cnt := COUNT(GROUP,h.tb <> (TYPEOF(h.tb))'');
    populated_tb_pcnt := AVE(GROUP,IF(h.tb = (TYPEOF(h.tb))'',0,100));
    maxlength_tb := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tb)));
    avelength_tb := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tb)),h.tb<>(typeof(h.tb))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
    populated_company_type_cnt := COUNT(GROUP,h.company_type <> (TYPEOF(h.company_type))'');
    populated_company_type_pcnt := AVE(GROUP,IF(h.company_type = (TYPEOF(h.company_type))'',0,100));
    maxlength_company_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_type)));
    avelength_company_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_type)),h.company_type<>(typeof(h.company_type))'');
    populated_nxx_type_cnt := COUNT(GROUP,h.nxx_type <> (TYPEOF(h.nxx_type))'');
    populated_nxx_type_pcnt := AVE(GROUP,IF(h.nxx_type = (TYPEOF(h.nxx_type))'',0,100));
    maxlength_nxx_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx_type)));
    avelength_nxx_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx_type)),h.nxx_type<>(typeof(h.nxx_type))'');
    populated_dial_ind_cnt := COUNT(GROUP,h.dial_ind <> (TYPEOF(h.dial_ind))'');
    populated_dial_ind_pcnt := AVE(GROUP,IF(h.dial_ind = (TYPEOF(h.dial_ind))'',0,100));
    maxlength_dial_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dial_ind)));
    avelength_dial_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dial_ind)),h.dial_ind<>(typeof(h.dial_ind))'');
    populated_point_id_cnt := COUNT(GROUP,h.point_id <> (TYPEOF(h.point_id))'');
    populated_point_id_pcnt := AVE(GROUP,IF(h.point_id = (TYPEOF(h.point_id))'',0,100));
    maxlength_point_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.point_id)));
    avelength_point_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.point_id)),h.point_id<>(typeof(h.point_id))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_nxx_pcnt *   0.00 / 100 + T.Populated_tb_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_company_type_pcnt *   0.00 / 100 + T.Populated_nxx_type_pcnt *   0.00 / 100 + T.Populated_dial_ind_pcnt *   0.00 / 100 + T.Populated_point_id_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'npa','nxx','tb','city','st','ocn','company_type','nxx_type','dial_ind','point_id','lf','zip');
  SELF.populated_pcnt := CHOOSE(C,le.populated_npa_pcnt,le.populated_nxx_pcnt,le.populated_tb_pcnt,le.populated_city_pcnt,le.populated_st_pcnt,le.populated_ocn_pcnt,le.populated_company_type_pcnt,le.populated_nxx_type_pcnt,le.populated_dial_ind_pcnt,le.populated_point_id_pcnt,le.populated_lf_pcnt,le.populated_zip_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_npa,le.maxlength_nxx,le.maxlength_tb,le.maxlength_city,le.maxlength_st,le.maxlength_ocn,le.maxlength_company_type,le.maxlength_nxx_type,le.maxlength_dial_ind,le.maxlength_point_id,le.maxlength_lf,le.maxlength_zip);
  SELF.avelength := CHOOSE(C,le.avelength_npa,le.avelength_nxx,le.avelength_tb,le.avelength_city,le.avelength_st,le.avelength_ocn,le.avelength_company_type,le.avelength_nxx_type,le.avelength_dial_ind,le.avelength_point_id,le.avelength_lf,le.avelength_zip);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.company_type),TRIM((SALT311.StrType)le.nxx_type),TRIM((SALT311.StrType)le.dial_ind),TRIM((SALT311.StrType)le.point_id),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.zip)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.company_type),TRIM((SALT311.StrType)le.nxx_type),TRIM((SALT311.StrType)le.dial_ind),TRIM((SALT311.StrType)le.point_id),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.zip)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.tb),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.company_type),TRIM((SALT311.StrType)le.nxx_type),TRIM((SALT311.StrType)le.dial_ind),TRIM((SALT311.StrType)le.point_id),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.zip)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'npa'}
      ,{2,'nxx'}
      ,{3,'tb'}
      ,{4,'city'}
      ,{5,'st'}
      ,{6,'ocn'}
      ,{7,'company_type'}
      ,{8,'nxx_type'}
      ,{9,'dial_ind'}
      ,{10,'point_id'}
      ,{11,'lf'}
      ,{12,'zip'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_npa((SALT311.StrType)le.npa),
    Fields.InValid_nxx((SALT311.StrType)le.nxx),
    Fields.InValid_tb((SALT311.StrType)le.tb),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_ocn((SALT311.StrType)le.ocn),
    Fields.InValid_company_type((SALT311.StrType)le.company_type),
    Fields.InValid_nxx_type((SALT311.StrType)le.nxx_type),
    Fields.InValid_dial_ind((SALT311.StrType)le.dial_ind),
    Fields.InValid_point_id((SALT311.StrType)le.point_id),
    Fields.InValid_lf((SALT311.StrType)le.lf),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_TB','Unknown','Unknown','Unknown','Invalid_CompanyType','Invalid_Num','Invalid_dialind','Invalid_PointID','Unknown','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_npa(TotalErrors.ErrorNum),Fields.InValidMessage_nxx(TotalErrors.ErrorNum),Fields.InValidMessage_tb(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_ocn(TotalErrors.ErrorNum),Fields.InValidMessage_company_type(TotalErrors.ErrorNum),Fields.InValidMessage_nxx_type(TotalErrors.ErrorNum),Fields.InValidMessage_dial_ind(TotalErrors.ErrorNum),Fields.InValidMessage_point_id(TotalErrors.ErrorNum),Fields.InValidMessage_lf(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_TelcordiaTPM, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
