import ut,ngadl;
export hygiene(dataset(layout_HEADER) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_LNAME_pcnt := ave(group,if(h.LNAME = (typeof(h.LNAME))'',0,100));
    maxlength_LNAME := max(group,length(trim((string)h.LNAME)));
    avelength_LNAME := ave(group,length(trim((string)h.LNAME)));
    populated_FNAME_pcnt := ave(group,if(h.FNAME = (typeof(h.FNAME))'',0,100));
    maxlength_FNAME := max(group,length(trim((string)h.FNAME)));
    avelength_FNAME := ave(group,length(trim((string)h.FNAME)));
    populated_MNAME_pcnt := ave(group,if(h.MNAME = (typeof(h.MNAME))'',0,100));
    maxlength_MNAME := max(group,length(trim((string)h.MNAME)));
    avelength_MNAME := ave(group,length(trim((string)h.MNAME)));
    populated_NAME_SUFFIX_pcnt := ave(group,if(h.NAME_SUFFIX = (typeof(h.NAME_SUFFIX))'',0,100));
    maxlength_NAME_SUFFIX := max(group,length(trim((string)h.NAME_SUFFIX)));
    avelength_NAME_SUFFIX := ave(group,length(trim((string)h.NAME_SUFFIX)));
    populated_TITLE_pcnt := ave(group,if(h.TITLE = (typeof(h.TITLE))'',0,100));
    maxlength_TITLE := max(group,length(trim((string)h.TITLE)));
    avelength_TITLE := ave(group,length(trim((string)h.TITLE)));
    populated_P_CITY_NAME_pcnt := ave(group,if(h.P_CITY_NAME = (typeof(h.P_CITY_NAME))'',0,100));
    maxlength_P_CITY_NAME := max(group,length(trim((string)h.P_CITY_NAME)));
    avelength_P_CITY_NAME := ave(group,length(trim((string)h.P_CITY_NAME)));
    populated_STATE_pcnt := ave(group,if(h.STATE = (typeof(h.STATE))'',0,100));
    maxlength_STATE := max(group,length(trim((string)h.STATE)));
    avelength_STATE := ave(group,length(trim((string)h.STATE)));
    populated_PRIM_RANGE_pcnt := ave(group,if(h.PRIM_RANGE = (typeof(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := max(group,length(trim((string)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := ave(group,length(trim((string)h.PRIM_RANGE)));
    populated_PRIM_NAME_pcnt := ave(group,if(h.PRIM_NAME = (typeof(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := max(group,length(trim((string)h.PRIM_NAME)));
    avelength_PRIM_NAME := ave(group,length(trim((string)h.PRIM_NAME)));
    populated_SEC_RANGE_pcnt := ave(group,if(h.SEC_RANGE = (typeof(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := max(group,length(trim((string)h.SEC_RANGE)));
    avelength_SEC_RANGE := ave(group,length(trim((string)h.SEC_RANGE)));
    populated_STATE_ORIGIN_pcnt := ave(group,if(h.STATE_ORIGIN = (typeof(h.STATE_ORIGIN))'',0,100));
    maxlength_STATE_ORIGIN := max(group,length(trim((string)h.STATE_ORIGIN)));
    avelength_STATE_ORIGIN := ave(group,length(trim((string)h.STATE_ORIGIN)));
    populated_DID_pcnt := ave(group,if(h.DID = (typeof(h.DID))'',0,100));
    maxlength_DID := max(group,length(trim((string)h.DID)));
    avelength_DID := ave(group,length(trim((string)h.DID)));
    populated_OFFENDER_KEY_pcnt := ave(group,if(h.OFFENDER_KEY = (typeof(h.OFFENDER_KEY))'',0,100));
    maxlength_OFFENDER_KEY := max(group,length(trim((string)h.OFFENDER_KEY)));
    avelength_OFFENDER_KEY := ave(group,length(trim((string)h.OFFENDER_KEY)));
    populated_ORIG_SSN_pcnt := ave(group,if(h.ORIG_SSN = (typeof(h.ORIG_SSN))'',0,100));
    maxlength_ORIG_SSN := max(group,length(trim((string)h.ORIG_SSN)));
    avelength_ORIG_SSN := ave(group,length(trim((string)h.ORIG_SSN)));
    populated_DOB_pcnt := ave(group,if(h.DOB = (typeof(h.DOB))'',0,100));
    maxlength_DOB := max(group,length(trim((string)h.DOB)));
    avelength_DOB := ave(group,length(trim((string)h.DOB)));
    populated_INS_NUM_pcnt := ave(group,if(h.INS_NUM = (typeof(h.INS_NUM))'',0,100));
    maxlength_INS_NUM := max(group,length(trim((string)h.INS_NUM)));
    avelength_INS_NUM := ave(group,length(trim((string)h.INS_NUM)));
    populated_CASE_NUMBER_pcnt := ave(group,if(h.CASE_NUMBER = (typeof(h.CASE_NUMBER))'',0,100));
    maxlength_CASE_NUMBER := max(group,length(trim((string)h.CASE_NUMBER)));
    avelength_CASE_NUMBER := ave(group,length(trim((string)h.CASE_NUMBER)));
    populated_DLE_NUM_pcnt := ave(group,if(h.DLE_NUM = (typeof(h.DLE_NUM))'',0,100));
    maxlength_DLE_NUM := max(group,length(trim((string)h.DLE_NUM)));
    avelength_DLE_NUM := ave(group,length(trim((string)h.DLE_NUM)));
    populated_FBI_NUM_pcnt := ave(group,if(h.FBI_NUM = (typeof(h.FBI_NUM))'',0,100));
    maxlength_FBI_NUM := max(group,length(trim((string)h.FBI_NUM)));
    avelength_FBI_NUM := ave(group,length(trim((string)h.FBI_NUM)));
    populated_DOC_NUM_pcnt := ave(group,if(h.DOC_NUM = (typeof(h.DOC_NUM))'',0,100));
    maxlength_DOC_NUM := max(group,length(trim((string)h.DOC_NUM)));
    avelength_DOC_NUM := ave(group,length(trim((string)h.DOC_NUM)));
    populated_ID_NUM_pcnt := ave(group,if(h.ID_NUM = (typeof(h.ID_NUM))'',0,100));
    maxlength_ID_NUM := max(group,length(trim((string)h.ID_NUM)));
    avelength_ID_NUM := ave(group,length(trim((string)h.ID_NUM)));
    populated_SOR_NUMBER_pcnt := ave(group,if(h.SOR_NUMBER = (typeof(h.SOR_NUMBER))'',0,100));
    maxlength_SOR_NUMBER := max(group,length(trim((string)h.SOR_NUMBER)));
    avelength_SOR_NUMBER := ave(group,length(trim((string)h.SOR_NUMBER)));
    populated_NCIC_NUMBER_pcnt := ave(group,if(h.NCIC_NUMBER = (typeof(h.NCIC_NUMBER))'',0,100));
    maxlength_NCIC_NUMBER := max(group,length(trim((string)h.NCIC_NUMBER)));
    avelength_NCIC_NUMBER := ave(group,length(trim((string)h.NCIC_NUMBER)));
    populated_VEH_TAG_pcnt := ave(group,if(h.VEH_TAG = (typeof(h.VEH_TAG))'',0,100));
    maxlength_VEH_TAG := max(group,length(trim((string)h.VEH_TAG)));
    avelength_VEH_TAG := ave(group,length(trim((string)h.VEH_TAG)));
    populated_DL_NUM_pcnt := ave(group,if(h.DL_NUM = (typeof(h.DL_NUM))'',0,100));
    maxlength_DL_NUM := max(group,length(trim((string)h.DL_NUM)));
    avelength_DL_NUM := ave(group,length(trim((string)h.DL_NUM)));
    populated_VENDOR_pcnt := ave(group,if(h.VENDOR = (typeof(h.VENDOR))'',0,100));
    maxlength_VENDOR := max(group,length(trim((string)h.VENDOR)));
    avelength_VENDOR := ave(group,length(trim((string)h.VENDOR)));
    populated_VEH_STATE_pcnt := ave(group,if(h.VEH_STATE = (typeof(h.VEH_STATE))'',0,100));
    maxlength_VEH_STATE := max(group,length(trim((string)h.VEH_STATE)));
    avelength_VEH_STATE := ave(group,length(trim((string)h.VEH_STATE)));
    populated_DL_STATE_pcnt := ave(group,if(h.DL_STATE = (typeof(h.DL_STATE))'',0,100));
    maxlength_DL_STATE := max(group,length(trim((string)h.DL_STATE)));
    avelength_DL_STATE := ave(group,length(trim((string)h.DL_STATE)));
  END;
  RETURN table(h,SummaryLayout);
END;
SrcCntRec := record
  h.SOURCE_FILE			;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SOURCE_FILE			,few);
// The character counts
  ngadl.mac_character_counts.mac(h,LNAME,'LNAME',LNAME_profile);
  ngadl.mac_character_counts.mac(h,FNAME,'FNAME',FNAME_profile);
  ngadl.mac_character_counts.mac(h,MNAME,'MNAME',MNAME_profile);
  ngadl.mac_character_counts.mac(h,NAME_SUFFIX,'NAME_SUFFIX',NAME_SUFFIX_profile);
  ngadl.mac_character_counts.mac(h,TITLE,'TITLE',TITLE_profile);
  ngadl.mac_character_counts.mac(h,P_CITY_NAME,'P_CITY_NAME',P_CITY_NAME_profile);
  ngadl.mac_character_counts.mac(h,STATE,'STATE',STATE_profile);
  ngadl.mac_character_counts.mac(h,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_profile);
  ngadl.mac_character_counts.mac(h,PRIM_NAME,'PRIM_NAME',PRIM_NAME_profile);
  ngadl.mac_character_counts.mac(h,SEC_RANGE,'SEC_RANGE',SEC_RANGE_profile);
  ngadl.mac_character_counts.mac(h,STATE_ORIGIN,'STATE_ORIGIN',STATE_ORIGIN_profile);
  ngadl.mac_character_counts.mac(h,DID,'DID',DID_profile);
  ngadl.mac_character_counts.mac(h,OFFENDER_KEY,'OFFENDER_KEY',OFFENDER_KEY_profile);
  ngadl.mac_character_counts.mac(h,ORIG_SSN,'ORIG_SSN',ORIG_SSN_profile);
  ngadl.mac_character_counts.mac(h,DOB,'DOB',DOB_profile);
  ngadl.mac_character_counts.mac(h,INS_NUM,'INS_NUM',INS_NUM_profile);
  ngadl.mac_character_counts.mac(h,CASE_NUMBER,'CASE_NUMBER',CASE_NUMBER_profile);
  ngadl.mac_character_counts.mac(h,DLE_NUM,'DLE_NUM',DLE_NUM_profile);
  ngadl.mac_character_counts.mac(h,FBI_NUM,'FBI_NUM',FBI_NUM_profile);
  ngadl.mac_character_counts.mac(h,DOC_NUM,'DOC_NUM',DOC_NUM_profile);
  ngadl.mac_character_counts.mac(h,ID_NUM,'ID_NUM',ID_NUM_profile);
  ngadl.mac_character_counts.mac(h,SOR_NUMBER,'SOR_NUMBER',SOR_NUMBER_profile);
  ngadl.mac_character_counts.mac(h,NCIC_NUMBER,'NCIC_NUMBER',NCIC_NUMBER_profile);
  ngadl.mac_character_counts.mac(h,VEH_TAG,'VEH_TAG',VEH_TAG_profile);
  ngadl.mac_character_counts.mac(h,DL_NUM,'DL_NUM',DL_NUM_profile);
  ngadl.mac_character_counts.mac(h,VENDOR,'VENDOR',VENDOR_profile);
  ngadl.mac_character_counts.mac(h,VEH_STATE,'VEH_STATE',VEH_STATE_profile);
  ngadl.mac_character_counts.mac(h,DL_STATE,'DL_STATE',DL_STATE_profile);
export All_Profiles :=  LNAME_profile + FNAME_profile + MNAME_profile + NAME_SUFFIX_profile + TITLE_profile + P_CITY_NAME_profile + STATE_profile + PRIM_RANGE_profile + PRIM_NAME_profile + SEC_RANGE_profile + STATE_ORIGIN_profile + DID_profile + OFFENDER_KEY_profile + ORIG_SSN_profile + DOB_profile + INS_NUM_profile + CASE_NUMBER_profile + DLE_NUM_profile + FBI_NUM_profile + DOC_NUM_profile + ID_NUM_profile + SOR_NUMBER_profile + NCIC_NUMBER_profile + VEH_TAG_profile + DL_NUM_profile + VENDOR_profile + VEH_STATE_profile + DL_STATE_profile;
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.SOURCE_FILE			) SOURCE_FILE			; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_LNAME((string)le.LNAME),
    Fields.InValid_FNAME((string)le.FNAME),
    Fields.InValid_MNAME((string)le.MNAME),
    Fields.InValid_NAME_SUFFIX((string)le.NAME_SUFFIX),
    Fields.InValid_TITLE((string)le.TITLE),
    Fields.InValid_P_CITY_NAME((string)le.P_CITY_NAME),
    Fields.InValid_STATE((string)le.STATE),
    Fields.InValid_PRIM_RANGE((string)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((string)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((string)le.SEC_RANGE),
    Fields.InValid_STATE_ORIGIN((string)le.STATE_ORIGIN),
    Fields.InValid_DID((string)le.DID),
    Fields.InValid_OFFENDER_KEY((string)le.OFFENDER_KEY),
    Fields.InValid_ORIG_SSN((string)le.ORIG_SSN),
    Fields.InValid_DOB((string)le.DOB),
    Fields.InValid_INS_NUM((string)le.INS_NUM),
    Fields.InValid_CASE_NUMBER((string)le.CASE_NUMBER),
    Fields.InValid_DLE_NUM((string)le.DLE_NUM),
    Fields.InValid_FBI_NUM((string)le.FBI_NUM),
    Fields.InValid_DOC_NUM((string)le.DOC_NUM),
    Fields.InValid_ID_NUM((string)le.ID_NUM),
    Fields.InValid_SOR_NUMBER((string)le.SOR_NUMBER),
    Fields.InValid_NCIC_NUMBER((string)le.NCIC_NUMBER),
    Fields.InValid_VEH_TAG((string)le.VEH_TAG),
    Fields.InValid_DL_NUM((string)le.DL_NUM),
    Fields.InValid_VENDOR((string)le.VENDOR),
    Fields.InValid_VEH_STATE((string)le.VEH_STATE),
    Fields.InValid_DL_STATE((string)le.DL_STATE),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.SOURCE_FILE			 := le.SOURCE_FILE			;
end;
Errors := normalize(h,28,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.SOURCE_FILE			;
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SOURCE_FILE			);
PrettyErrorTotals := record
  TotalErrors.SOURCE_FILE			;
  FieldName := CHOOSE(TotalErrors.FieldNum,'LNAME','FNAME','MNAME','NAME_SUFFIX','TITLE','P_CITY_NAME','STATE','PRIM_RANGE','PRIM_NAME','SEC_RANGE','STATE_ORIGIN','DID','OFFENDER_KEY','ORIG_SSN','DOB','INS_NUM','CASE_NUMBER','DLE_NUM','FBI_NUM','DOC_NUM','ID_NUM','SOR_NUMBER','NCIC_NUMBER','VEH_TAG','DL_NUM','VENDOR','VEH_STATE','DL_STATE');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_NAME_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_TITLE(TotalErrors.ErrorNum),Fields.InValidMessage_P_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_STATE_ORIGIN(TotalErrors.ErrorNum),Fields.InValidMessage_DID(TotalErrors.ErrorNum),Fields.InValidMessage_OFFENDER_KEY(TotalErrors.ErrorNum),Fields.InValidMessage_ORIG_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_INS_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_CASE_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DLE_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_FBI_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_DOC_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_ID_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_SOR_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_NCIC_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_VEH_TAG(TotalErrors.ErrorNum),Fields.InValidMessage_DL_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR(TotalErrors.ErrorNum),Fields.InValidMessage_VEH_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_DL_STATE(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.SOURCE_FILE			=right.SOURCE_FILE			,lookup); // Add source group counts for STRATA compliance
end;
