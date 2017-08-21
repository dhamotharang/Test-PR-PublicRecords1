import ut,ngadl;
export hygiene(dataset(layout_HEADER) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_SSN_pcnt := ave(group,if(h.SSN = (typeof(h.SSN))'',0,100));
    maxlength_SSN := max(group,length(trim((string)h.SSN)));
    avelength_SSN := ave(group,length(trim((string)h.SSN)));
    populated_VENDOR_ID_pcnt := ave(group,if(h.VENDOR_ID = (typeof(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := max(group,length(trim((string)h.VENDOR_ID)));
    avelength_VENDOR_ID := ave(group,length(trim((string)h.VENDOR_ID)));
    populated_PHONE_pcnt := ave(group,if(h.PHONE = (typeof(h.PHONE))'',0,100));
    maxlength_PHONE := max(group,length(trim((string)h.PHONE)));
    avelength_PHONE := ave(group,length(trim((string)h.PHONE)));
    populated_LNAME_pcnt := ave(group,if(h.LNAME = (typeof(h.LNAME))'',0,100));
    maxlength_LNAME := max(group,length(trim((string)h.LNAME)));
    avelength_LNAME := ave(group,length(trim((string)h.LNAME)));
    populated_PRIM_NAME_pcnt := ave(group,if(h.PRIM_NAME = (typeof(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := max(group,length(trim((string)h.PRIM_NAME)));
    avelength_PRIM_NAME := ave(group,length(trim((string)h.PRIM_NAME)));
    populated_DOB_pcnt := ave(group,if(h.DOB = (typeof(h.DOB))'',0,100));
    maxlength_DOB := max(group,length(trim((string)h.DOB)));
    avelength_DOB := ave(group,length(trim((string)h.DOB)));
    populated_PRIM_RANGE_pcnt := ave(group,if(h.PRIM_RANGE = (typeof(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := max(group,length(trim((string)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := ave(group,length(trim((string)h.PRIM_RANGE)));
    populated_SEC_RANGE_pcnt := ave(group,if(h.SEC_RANGE = (typeof(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := max(group,length(trim((string)h.SEC_RANGE)));
    avelength_SEC_RANGE := ave(group,length(trim((string)h.SEC_RANGE)));
    populated_FNAME_pcnt := ave(group,if(h.FNAME = (typeof(h.FNAME))'',0,100));
    maxlength_FNAME := max(group,length(trim((string)h.FNAME)));
    avelength_FNAME := ave(group,length(trim((string)h.FNAME)));
    populated_CITY_NAME_pcnt := ave(group,if(h.CITY_NAME = (typeof(h.CITY_NAME))'',0,100));
    maxlength_CITY_NAME := max(group,length(trim((string)h.CITY_NAME)));
    avelength_CITY_NAME := ave(group,length(trim((string)h.CITY_NAME)));
    populated_MNAME_pcnt := ave(group,if(h.MNAME = (typeof(h.MNAME))'',0,100));
    maxlength_MNAME := max(group,length(trim((string)h.MNAME)));
    avelength_MNAME := ave(group,length(trim((string)h.MNAME)));
    populated_NAME_SUFFIX_pcnt := ave(group,if(h.NAME_SUFFIX = (typeof(h.NAME_SUFFIX))'',0,100));
    maxlength_NAME_SUFFIX := max(group,length(trim((string)h.NAME_SUFFIX)));
    avelength_NAME_SUFFIX := ave(group,length(trim((string)h.NAME_SUFFIX)));
    populated_ST_pcnt := ave(group,if(h.ST = (typeof(h.ST))'',0,100));
    maxlength_ST := max(group,length(trim((string)h.ST)));
    avelength_ST := ave(group,length(trim((string)h.ST)));
    populated_GENDER_pcnt := ave(group,if(h.GENDER = (typeof(h.GENDER))'',0,100));
    maxlength_GENDER := max(group,length(trim((string)h.GENDER)));
    avelength_GENDER := ave(group,length(trim((string)h.GENDER)));
    populated_SRC_pcnt := ave(group,if(h.SRC = (typeof(h.SRC))'',0,100));
    maxlength_SRC := max(group,length(trim((string)h.SRC)));
    avelength_SRC := ave(group,length(trim((string)h.SRC)));
  END;
  RETURN table(h,SummaryLayout);
END;
SrcCntRec := record
  h.SRC;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SRC,few);
// The character counts
  Gordon.mac_character_counts.mac(h,SSN,'SSN',SSN_profile);
  Gordon.mac_character_counts.mac(h,VENDOR_ID,'VENDOR_ID',VENDOR_ID_profile);
  Gordon.mac_character_counts.mac(h,PHONE,'PHONE',PHONE_profile);
  Gordon.mac_character_counts.mac(h,LNAME,'LNAME',LNAME_profile);
  Gordon.mac_character_counts.mac(h,PRIM_NAME,'PRIM_NAME',PRIM_NAME_profile);
  Gordon.mac_character_counts.mac(h,DOB,'DOB',DOB_profile);
  Gordon.mac_character_counts.mac(h,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_profile);
  Gordon.mac_character_counts.mac(h,SEC_RANGE,'SEC_RANGE',SEC_RANGE_profile);
  Gordon.mac_character_counts.mac(h,FNAME,'FNAME',FNAME_profile);
  Gordon.mac_character_counts.mac(h,CITY_NAME,'CITY_NAME',CITY_NAME_profile);
  Gordon.mac_character_counts.mac(h,MNAME,'MNAME',MNAME_profile);
  Gordon.mac_character_counts.mac(h,NAME_SUFFIX,'NAME_SUFFIX',NAME_SUFFIX_profile);
  Gordon.mac_character_counts.mac(h,ST,'ST',ST_profile);
  Gordon.mac_character_counts.mac(h,GENDER,'GENDER',GENDER_profile);
  Gordon.mac_character_counts.mac(h,SRC,'SRC',SRC_profile);
export All_Profiles :=  SSN_profile + VENDOR_ID_profile + PHONE_profile + LNAME_profile + PRIM_NAME_profile + DOB_profile + PRIM_RANGE_profile + SEC_RANGE_profile + FNAME_profile + CITY_NAME_profile + MNAME_profile + NAME_SUFFIX_profile + ST_profile + GENDER_profile + SRC_profile;
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.SRC) SRC; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_SSN((string)le.SSN),
    Fields.InValid_VENDOR_ID((string)le.VENDOR_ID),
    Fields.InValid_PHONE((string)le.PHONE),
    Fields.InValid_LNAME((string)le.LNAME),
    Fields.InValid_PRIM_NAME((string)le.PRIM_NAME),
    Fields.InValid_DOB((string)le.DOB),
    Fields.InValid_PRIM_RANGE((string)le.PRIM_RANGE),
    Fields.InValid_SEC_RANGE((string)le.SEC_RANGE),
    Fields.InValid_FNAME((string)le.FNAME),
    Fields.InValid_CITY_NAME((string)le.CITY_NAME),
    Fields.InValid_MNAME((string)le.MNAME),
    Fields.InValid_NAME_SUFFIX((string)le.NAME_SUFFIX),
    Fields.InValid_ST((string)le.ST),
    Fields.InValid_GENDER((string)le.GENDER),
    Fields.InValid_SRC((string)le.SRC),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.SRC := le.SRC;
end;
Errors := normalize(h,18,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.SRC;
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC);
PrettyErrorTotals := record
  TotalErrors.SRC;
  FieldName := CHOOSE(TotalErrors.FieldNum,'SSN','VENDOR_ID','PHONE','LNAME','PRIM_NAME','DOB','PRIM_RANGE','SEC_RANGE','FNAME','CITY_NAME','MNAME','NAME_SUFFIX','ST','GENDER','SRC');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_NAME_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.SRC=right.SRC,lookup); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
Gordon.mac_srcfrequency_outliers(h,FNAME,SRC,FNAME_outliers)
Gordon.mac_srcfrequency_outliers(h,LNAME,SRC,LNAME_outliers)
Gordon.mac_srcfrequency_outliers(h,PRIM_NAME,SRC,PRIM_NAME_outliers)
Gordon.mac_srcfrequency_outliers(h,PRIM_RANGE,SRC,PRIM_RANGE_outliers)
Gordon.mac_srcfrequency_outliers(h,SEC_RANGE,SRC,SEC_RANGE_outliers)
Gordon.mac_srcfrequency_outliers(h,MNAME,SRC,MNAME_outliers)
export All_Outliers := FNAME_outliers + LNAME_outliers + PRIM_NAME_outliers + PRIM_RANGE_outliers + SEC_RANGE_outliers + MNAME_outliers;
//We have DID specified - so we can compute statistics on the cluster counts
export ClusterCounts := function
  t := distribute(table(h,{DID}),hash(DID));
  r0 := record
    t.DID;
    unsigned6 InCluster := count(group);
  end;
  tots := table(t,r0,DID,local);
  r1 := record
    tots.InCluster;
    unsigned6 NumberOfClusters := count(group);
  end;
  return sort(table(tots,r1,InCluster,few),InCluster);
end;
end;
