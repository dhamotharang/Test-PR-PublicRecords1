IMPORT SALT37;
EXPORT hygiene(dataset(layout_LocationId) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_predir_pcnt *   5.00 / 100 + T.Populated_prim_name_pcnt *  16.00 / 100 + T.Populated_addr_suffix_pcnt *   4.00 / 100 + T.Populated_postdir_pcnt *   7.00 / 100 + T.Populated_unit_desig_pcnt *   7.00 / 100 + T.Populated_sec_range_pcnt *  13.00 / 100 + T.Populated_v_city_name_pcnt *  12.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip5_pcnt *  14.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5');
  SELF.populated_pcnt := CHOOSE(C,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5);
  SELF.avelength := CHOOSE(C,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LocId;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,_CFG.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'prim_range'}
      ,{2,'predir'}
      ,{3,'prim_name'}
      ,{4,'addr_suffix'}
      ,{5,'postdir'}
      ,{6,'unit_desig'}
      ,{7,'sec_range'}
      ,{8,'v_city_name'}
      ,{9,'st'}
      ,{10,'zip5'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Fields.InValid_predir((SALT37.StrType)le.predir),
    Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT37.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT37.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT37.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT37.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name),
    Fields.InValid_st((SALT37.StrType)le.st),
    Fields.InValid_zip5((SALT37.StrType)le.zip5),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','DFLT','Unknown','Unknown','Unknown','Unknown','Unknown','alpha_st','zip5');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have LocId specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT37.MOD_ClusterStats.Counts(h,LocId);
END;
