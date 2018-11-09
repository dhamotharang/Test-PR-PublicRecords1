IMPORT SALT37;
EXPORT hygiene(dataset(layout_BASE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_aid_pcnt := AVE(GROUP,IF(h.aid = (TYPEOF(h.aid))'',0,100));
    maxlength_aid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.aid)));
    avelength_aid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.aid)),h.aid<>(typeof(h.aid))'');
    populated_dateseenfirst_pcnt := AVE(GROUP,IF(h.dateseenfirst = (TYPEOF(h.dateseenfirst))'',0,100));
    maxlength_dateseenfirst := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dateseenfirst)));
    avelength_dateseenfirst := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dateseenfirst)),h.dateseenfirst<>(typeof(h.dateseenfirst))'');
    populated_dateseenlast_pcnt := AVE(GROUP,IF(h.dateseenlast = (TYPEOF(h.dateseenlast))'',0,100));
    maxlength_dateseenlast := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dateseenlast)));
    avelength_dateseenlast := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dateseenlast)),h.dateseenlast<>(typeof(h.dateseenlast))'');
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
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_cntprimname_pcnt := AVE(GROUP,IF(h.cntprimname = (TYPEOF(h.cntprimname))'',0,100));
    maxlength_cntprimname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cntprimname)));
    avelength_cntprimname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cntprimname)),h.cntprimname<>(typeof(h.cntprimname))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_aid_pcnt *   0.00 / 100 + T.Populated_dateseenfirst_pcnt *   0.00 / 100 + T.Populated_dateseenlast_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_cntprimname_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_aid_pcnt*ri.Populated_aid_pcnt *   0.00 / 10000 + le.Populated_dateseenfirst_pcnt*ri.Populated_dateseenfirst_pcnt *   0.00 / 10000 + le.Populated_dateseenlast_pcnt*ri.Populated_dateseenlast_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_cntprimname_pcnt*ri.Populated_cntprimname_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'aid','dateseenfirst','dateseenlast','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5','rec_type','err_stat','cntprimname');
  SELF.populated_pcnt := CHOOSE(C,le.populated_aid_pcnt,le.populated_dateseenfirst_pcnt,le.populated_dateseenlast_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_rec_type_pcnt,le.populated_err_stat_pcnt,le.populated_cntprimname_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_aid,le.maxlength_dateseenfirst,le.maxlength_dateseenlast,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_rec_type,le.maxlength_err_stat,le.maxlength_cntprimname);
  SELF.avelength := CHOOSE(C,le.avelength_aid,le.avelength_dateseenfirst,le.avelength_dateseenlast,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_rec_type,le.avelength_err_stat,le.avelength_cntprimname);
END;
EXPORT invSummary := NORMALIZE(summary0, 16, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LocId;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.aid),TRIM((SALT37.StrType)le.dateseenfirst),TRIM((SALT37.StrType)le.dateseenlast),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.cntprimname)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,16,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 16);
  SELF.FldNo2 := 1 + (C % 16);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.aid),TRIM((SALT37.StrType)le.dateseenfirst),TRIM((SALT37.StrType)le.dateseenlast),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.cntprimname)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.aid),TRIM((SALT37.StrType)le.dateseenfirst),TRIM((SALT37.StrType)le.dateseenlast),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip5),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.cntprimname)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,_CFG.CorrelateSampleSize),16*16,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'aid'}
      ,{2,'dateseenfirst'}
      ,{3,'dateseenlast'}
      ,{4,'prim_range'}
      ,{5,'predir'}
      ,{6,'prim_name'}
      ,{7,'addr_suffix'}
      ,{8,'postdir'}
      ,{9,'unit_desig'}
      ,{10,'sec_range'}
      ,{11,'v_city_name'}
      ,{12,'st'}
      ,{13,'zip5'}
      ,{14,'rec_type'}
      ,{15,'err_stat'}
      ,{16,'cntprimname'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_aid((SALT37.StrType)le.aid),
    Fields.InValid_dateseenfirst((SALT37.StrType)le.dateseenfirst),
    Fields.InValid_dateseenlast((SALT37.StrType)le.dateseenlast),
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
    Fields.InValid_rec_type((SALT37.StrType)le.rec_type),
    Fields.InValid_err_stat((SALT37.StrType)le.err_stat),
    Fields.InValid_cntprimname((SALT37.StrType)le.cntprimname),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,16,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','CITY','alpha_st','zip5','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_aid(TotalErrors.ErrorNum),Fields.InValidMessage_dateseenfirst(TotalErrors.ErrorNum),Fields.InValidMessage_dateseenlast(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_cntprimname(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have LocId specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT37.MOD_ClusterStats.Counts(h,LocId);
EXPORT ClusterSrc := SALT37.MOD_ClusterStats.Sources(h,LocId,source);
END;
