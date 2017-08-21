import ut,ngadl;
export hygiene(dataset(layout_HEADER) h) := MODULE
SrcCntRec := record
  h.SRC;  // Source Group Identifier
  unsigned CountGroup := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SRC,few);
// The character counts
  ngadl.mac_character_counts.mac(h,SSN,'SSN',SSN_profile);
  ngadl.mac_character_counts.mac(h,VENDOR_ID,'VENDOR_ID',VENDOR_ID_profile);
  ngadl.mac_character_counts.mac(h,LNAME,'LNAME',LNAME_profile);
  ngadl.mac_character_counts.mac(h,PRIM_NAME,'PRIM_NAME',PRIM_NAME_profile);
  ngadl.mac_character_counts.mac(h,DOB,'DOB',DOB_profile);
  ngadl.mac_character_counts.mac(h,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_profile);
  ngadl.mac_character_counts.mac(h,SEC_RANGE,'SEC_RANGE',SEC_RANGE_profile);
  ngadl.mac_character_counts.mac(h,FNAME,'FNAME',FNAME_profile);
  ngadl.mac_character_counts.mac(h,CITY_NAME,'CITY_NAME',CITY_NAME_profile);
  ngadl.mac_character_counts.mac(h,MNAME,'MNAME',MNAME_profile);
  ngadl.mac_character_counts.mac(h,NAME_SUFFIX,'NAME_SUFFIX',NAME_SUFFIX_profile);
  ngadl.mac_character_counts.mac(h,ST,'ST',ST_profile);
  ngadl.mac_character_counts.mac(h,GENDER,'GENDER',GENDER_profile);
  ngadl.mac_character_counts.mac(h,SRC,'SRC',SRC_profile);
export All_Profiles :=  SSN_profile + VENDOR_ID_profile + LNAME_profile + PRIM_NAME_profile + DOB_profile + PRIM_RANGE_profile + SEC_RANGE_profile + FNAME_profile + CITY_NAME_profile + MNAME_profile + NAME_SUFFIX_profile + ST_profile + GENDER_profile + SRC_profile;
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.SRC) SRC; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_SSN((string)le.SSN),
    Fields.InValid_VENDOR_ID((string)le.VENDOR_ID),
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
Errors := normalize(h,17,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.SRC;
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC);
PrettyErrorTotals := record
  TotalErrors.SRC;
  FieldName := CHOOSE(TotalErrors.FieldNum,'SSN','VENDOR_ID','LNAME','PRIM_NAME','DOB','PRIM_RANGE','SEC_RANGE','FNAME','CITY_NAME','MNAME','NAME_SUFFIX','ST','GENDER','SRC');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_NAME_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.SRC=right.SRC,lookup); // Add source group counts for STRATA compliance
end;
