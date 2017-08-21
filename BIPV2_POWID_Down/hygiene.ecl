IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_POWID_Down) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orgid_pcnt *  28.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  14.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_v_city_name_pcnt *  11.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *  28.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  14.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   5.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *  11.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT35.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orgid','prim_range','prim_name','st','zip','v_city_name','company_name','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orgid_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_v_city_name_pcnt,le.populated_company_name_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orgid,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_st,le.maxlength_zip,le.maxlength_v_city_name,le.maxlength_company_name,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_orgid,le.avelength_prim_range,le.avelength_prim_name,le.avelength_st,le.avelength_zip,le.avelength_v_city_name,le.avelength_company_name,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.POWID;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.orgid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.orgid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.orgid),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.company_name),TRIM((SALT35.StrType)le.dt_first_seen),TRIM((SALT35.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orgid'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'st'}
      ,{5,'zip'}
      ,{6,'v_city_name'}
      ,{7,'company_name'}
      ,{8,'dt_first_seen'}
      ,{9,'dt_last_seen'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orgid((SALT35.StrType)le.orgid),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_st((SALT35.StrType)le.st),
    Fields.InValid_zip((SALT35.StrType)le.zip),
    0, // Uncleanable field
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_company_name((SALT35.StrType)le.company_name),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_dt_first_seen((SALT35.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT35.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','alpha','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),'',Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),'','',Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT35.Mac_SrcFrequency_Outliers(h,prim_range,source,prim_range_Unusually_Frequent_outliers, prim_range_Unique_outliers, prim_range_Unique_outlier_sources, prim_range_Distinct_outliers,prim_range_Distinct_outlier_sources, prim_range_Top5_outliers, prim_range_Top5_outlier_sources)
  SALT35.Mac_SrcFrequency_Outliers(h,prim_name,source,prim_name_Unusually_Frequent_outliers, prim_name_Unique_outliers, prim_name_Unique_outlier_sources, prim_name_Distinct_outliers,prim_name_Distinct_outlier_sources, prim_name_Top5_outliers, prim_name_Top5_outlier_sources)
  SALT35.Mac_SrcFrequency_Outliers(h,st,source,st_Unusually_Frequent_outliers, st_Unique_outliers, st_Unique_outlier_sources, st_Distinct_outliers,st_Distinct_outlier_sources, st_Top5_outliers, st_Top5_outlier_sources)
  SALT35.Mac_SrcFrequency_Outliers(h,v_city_name,source,v_city_name_Unusually_Frequent_outliers, v_city_name_Unique_outliers, v_city_name_Unique_outlier_sources, v_city_name_Distinct_outliers,v_city_name_Distinct_outlier_sources, v_city_name_Top5_outliers, v_city_name_Top5_outlier_sources)
  SALT35.Mac_SrcFrequency_Outliers(h,zip,source,zip_Unusually_Frequent_outliers, zip_Unique_outliers, zip_Unique_outlier_sources, zip_Distinct_outliers,zip_Distinct_outlier_sources, zip_Top5_outliers, zip_Top5_outlier_sources)
EXPORT AllUnusuallyFrequentOutliers := prim_range_Unusually_Frequent_outliers + prim_name_Unusually_Frequent_outliers + st_Unusually_Frequent_outliers + v_city_name_Unusually_Frequent_outliers + zip_Unusually_Frequent_outliers;
EXPORT AllUniqueOutliers := prim_range_Unique_outliers + prim_name_Unique_outliers + st_Unique_outliers + v_city_name_Unique_outliers + zip_Unique_outliers;
EXPORT AllDistinctOutliers := prim_range_Distinct_outliers + prim_name_Distinct_outliers + st_Distinct_outliers + v_city_name_Distinct_outliers + zip_Distinct_outliers;
EXPORT AllTop5Outliers := prim_range_Top5_outliers + prim_name_Top5_outliers + st_Top5_outliers + v_city_name_Top5_outliers + zip_Top5_outliers;
EXPORT AllUniqueOutlierSources := prim_range_Unique_outlier_sources + prim_name_Unique_outlier_sources + st_Unique_outlier_sources + v_city_name_Unique_outlier_sources + zip_Unique_outlier_sources;
EXPORT AllDistinctOutlierSources := prim_range_Distinct_outlier_sources + prim_name_Distinct_outlier_sources + st_Distinct_outlier_sources + v_city_name_Distinct_outlier_sources + zip_Distinct_outlier_sources;
EXPORT AllTop5OutlierSources := prim_range_Top5_outlier_sources + prim_name_Top5_outlier_sources + st_Top5_outlier_sources + v_city_name_Top5_outlier_sources + zip_Top5_outlier_sources;
//We have POWID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT35.MOD_ClusterStats.Counts(h,POWID);
EXPORT ClusterSrc := SALT35.MOD_ClusterStats.Sources(h,POWID,source);
END;
