IMPORT SALT37;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_PS(DATASET(Process_PS_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT37.UIDType ButNot=[]) := MODULE
Process_PS_Layouts.OutputLayout GetResults(Process_PS_Layouts.InputLayout le) := TRANSFORM
// Need to annotate wordbags with specificities
  SALT37.mac_wordbag_appendspecs_rx(le.LNAME,Specificities(File_Classify_PS).LNAME_values_key,LNAME,LNAME_spec)
// Need to calculate lengths for EDIT fields
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM(le.PRIM_RANGE));
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM(le.PRIM_NAME));
  UNSIGNED1 POSSIBLE_SSN_len := LENGTH(TRIM(le.POSSIBLE_SSN));
  In_disableForce := le.disableForce;
  SELF.keys_tried := IF (Key_Classify_PS_NAME.CanSearch(le),1 << 1,0) + IF (Key_Classify_PS_ADDRESS.CanSearch(le),1 << 2,0) + IF (Key_Classify_PS_DOB.CanSearch(le),1 << 3,0) + IF (Key_Classify_PS_ZIP_PR.CanSearch(le),1 << 4,0) + IF (Key_Classify_PS_DLN.CanSearch(le),1 << 5,0) + IF (Key_Classify_PS_PH.CanSearch(le),1 << 6,0) + IF (Key_Classify_PS_LFZ.CanSearch(le),1 << 7,0) + IF (Key_Classify_PS_VIN.CanSearch(le),1 << 8,0) + IF (Key_Classify_PS_LEXID.CanSearch(le),1 << 9,0) + IF (Key_Classify_PS_SSN.CanSearch(le),1 << 10,0) + IF (Key_Classify_PS_LATLONG.CanSearch(le),1 << 11,0) + IF (Key_Classify_PS_PLATE.CanSearch(le),1 << 12,0) + IF (Key_Classify_PS_COMPANY.CanSearch(le),1 << 13,0);
  fetchResults := TOPN(ROLLUP(
    MERGE(
    SORTED(Key_Classify_PS_NAME.ScoredEID_HASHFetch(param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := LNAME_spec,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_DOB := (UNSIGNED4)le.DOB,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_ADDRESS.ScoredEID_HASHFetch(param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_ZIP := le.ZIP,param_SEC_RANGE := le.SEC_RANGE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_DOB.ScoredEID_HASHFetch(param_DOB := (UNSIGNED4)le.DOB,param_LNAME := LNAME_spec,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_P_CITY_NAME := le.P_CITY_NAME,param_NAME_SUFFIX := le.NAME_SUFFIX,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_ZIP_PR.ScoredEID_HASHFetch(param_ZIP := le.ZIP,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := LNAME_spec,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_DLN.ScoredEID_HASHFetch(param_DL := le.DL,param_DL_ST := le.DL_ST,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_PH.ScoredEID_HASHFetch(param_PHONE := le.PHONE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_DOB := (UNSIGNED4)le.DOB,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_LFZ.ScoredEID_HASHFetch(param_LNAME := LNAME_spec,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_ZIP := le.ZIP,param_P_CITY_NAME := le.P_CITY_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SEC_RANGE := le.SEC_RANGE,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_VIN.ScoredEID_HASHFetch(param_VIN := le.VIN,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_LEXID.ScoredEID_HASHFetch(param_LEXID := le.LEXID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_DL := le.DL,param_DL_ST := le.DL_ST,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_SSN.ScoredEID_HASHFetch(param_POSSIBLE_SSN := le.POSSIBLE_SSN,param_POSSIBLE_SSN_len := POSSIBLE_SSN_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_LATLONG.ScoredEID_HASHFetch(param_LATITUDE := le.LATITUDE,param_LONGITUDE := le.LONGITUDE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_POSSIBLE_SSN := le.POSSIBLE_SSN,param_POSSIBLE_SSN_len := POSSIBLE_SSN_len,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_PLATE.ScoredEID_HASHFetch(param_PLATE := le.PLATE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH)
    ,SORTED(Key_Classify_PS_COMPANY.ScoredEID_HASHFetch(param_CLEAN_COMPANY_NAME := le.CLEAN_COMPANY_NAME,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID,param_disableForce := In_disableForce),EID_HASH),SORTED(EID_HASH)) /* Merged */
    , RIGHT.EID_HASH > 0 AND LEFT.EID_HASH = RIGHT.EID_HASH, Process_PS_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce))(EID_HASH NOT IN ButNot),le.MaxIDs + 1,-Weight)(SALT37.DebugMode OR ~ForceFailed OR ButNot<>[]); // Warning - is a fetch to keys etc
  SELF.Results := CHOOSEN(fetchResults, le.MaxIDs);
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_PS_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_EID_HASH=0),GetResults(left),PREFETCH(Config.MeowPrefetch,PARALLEL));
  Process_PS_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    In_disableForce := le.disableForce;
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, EID_HASH )
    , RIGHT.EID_HASH > 0 AND LEFT.EID_HASH = RIGHT.EID_HASH, Process_PS_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce))(EID_HASH NOT IN ButNot),le.MaxIds + 1,-Weight);
    SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
    SELF.IsTruncated := COUNT(mergedResults) > le.MaxIds;
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR20 := IF ( MultiRec, RR1, RR0 );
  Process_PS_Layouts.OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
    SELF.Results := UNGROUP(Process_PS_Layouts.AdjustScoresForNonExactMatches(le.Results));
    SELF := le;
  END;
  RR2 := PROJECT(RR20,AdjustScores(LEFT));
  Process_PS_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT37.MAC_External_AddPcnt(RR3,Process_PS_Layouts.LayoutScoredFetch,Results,Process_PS_Layouts.OutputLayout,28,RR4);
EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the EID_HASH on them
  process_PS_layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.IsTruncated := FALSE;
    SELF.EID_HASH := le.Entered_EID_HASH;
  END;
  SHARED pass_thru := PROJECT(in(~(Entered_EID_HASH=0)),ptt(LEFT));
// Transform to process 'real' results
  process_PS_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := le.IsTruncated;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results0 := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER));
  EXPORT Uid_Results := Uid_Results0+pass_thru;
  EXPORT Raw_Data := process_PS_layouts.Fetch_Stream(Uid_Results);
 
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_NAME_SUFFIX;
      INTEGER2 Match_FNAME;
      INTEGER2 Match_MNAME;
      INTEGER2 Match_LNAME;
      INTEGER2 Match_PRIM_RANGE;
      INTEGER2 Match_PRIM_NAME;
      INTEGER2 Match_SEC_RANGE;
      INTEGER2 Match_P_CITY_NAME;
      INTEGER2 Match_ST;
      INTEGER2 Match_ZIP;
      INTEGER2 Match_DOB;
      INTEGER2 Match_PHONE;
      INTEGER2 Match_DL_ST;
      INTEGER2 Match_DL;
      INTEGER2 Match_LEXID;
      INTEGER2 Match_POSSIBLE_SSN;
      INTEGER2 Match_CRIME;
      INTEGER2 Match_NAME_TYPE;
      INTEGER2 Match_CLEAN_GENDER;
      INTEGER2 Match_CLASS_CODE;
      INTEGER2 Match_DT_FIRST_SEEN;
      INTEGER2 Match_DT_LAST_SEEN;
      INTEGER2 Match_DATA_PROVIDER_ORI;
      INTEGER2 Match_VIN;
      INTEGER2 Match_PLATE;
      INTEGER2 Match_LATITUDE;
      INTEGER2 Match_LONGITUDE;
      INTEGER2 Match_SEARCH_ADDR1;
      INTEGER2 Match_SEARCH_ADDR2;
      INTEGER2 Match_CLEAN_COMPANY_NAME;
      INTEGER2 Match_MAINNAME;
      INTEGER2 Match_FULLNAME;
    END;
    IMPORT SALT37;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_NAME_SUFFIX := MAP ( ri.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.NAME_SUFFIX = le.NAME_SUFFIX => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_FNAME := MAP ( ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.FNAME = (TYPEOF(ri.FNAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.FNAME = le.FNAME => SALT37.HeaderSearchMatchCode.Match,le.FNAME = ri.FNAME[length(trim(le.FNAME))] OR ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => SALT37.HeaderSearchMatchCode.FuzzyMatch,Config.WithinEditN(le.FNAME,0,ri.FNAME,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_MNAME := MAP ( ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.MNAME = (TYPEOF(ri.MNAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.MNAME = le.MNAME => SALT37.HeaderSearchMatchCode.Match,le.MNAME = ri.MNAME[length(trim(le.MNAME))] OR ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => SALT37.HeaderSearchMatchCode.FuzzyMatch,Config.WithinEditN(le.MNAME,0,ri.MNAME,0,2, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    le_LNAME := SALT37.Fn_WordBag_AppendSpecs_Fake((SALT37.StrType)le.LNAME);//For later scoring
    ri_LNAME := SALT37.Fn_WordBag_AppendSpecs_Fake((SALT37.StrType)ri.LNAME);//For later scoring
    SELF.Match_LNAME := MAP ( ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.LNAME = (TYPEOF(ri.LNAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.LNAME = le.LNAME => SALT37.HeaderSearchMatchCode.Match,SALT37.MatchBagOfWords(le_LNAME,ri_LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100 => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.PRIM_RANGE = le.PRIM_RANGE => SALT37.HeaderSearchMatchCode.Match,Config.WithinEditN(le.PRIM_RANGE,0,ri.PRIM_RANGE,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.PRIM_NAME = le.PRIM_NAME => SALT37.HeaderSearchMatchCode.Match,Config.WithinEditN(le.PRIM_NAME,0,ri.PRIM_NAME,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.SEC_RANGE = le.SEC_RANGE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_P_CITY_NAME := MAP ( ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.P_CITY_NAME = le.P_CITY_NAME => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_ST := MAP ( ri.ST = (TYPEOF(ri.ST))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.ST = (TYPEOF(ri.ST))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.ST = le.ST => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_ZIP := MAP ( ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.ZIP = (TYPEOF(ri.ZIP))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.ZIP = le.ZIP => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DOB := SALT37.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
    SELF.Match_PHONE := MAP ( ri.PHONE = (TYPEOF(ri.PHONE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.PHONE = (TYPEOF(ri.PHONE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.PHONE = le.PHONE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DL_ST := MAP ( ri.DL_ST = (TYPEOF(ri.DL_ST))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.DL_ST = (TYPEOF(ri.DL_ST))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.DL_ST = le.DL_ST => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DL := MAP ( ri.DL = (TYPEOF(ri.DL))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.DL = (TYPEOF(ri.DL))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.DL = le.DL => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_LEXID := MAP ( ri.LEXID = (TYPEOF(ri.LEXID))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.LEXID = (TYPEOF(ri.LEXID))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.LEXID = le.LEXID => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_POSSIBLE_SSN := MAP ( ri.POSSIBLE_SSN = (TYPEOF(ri.POSSIBLE_SSN))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.POSSIBLE_SSN = (TYPEOF(ri.POSSIBLE_SSN))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.POSSIBLE_SSN = le.POSSIBLE_SSN => SALT37.HeaderSearchMatchCode.Match,Config.WithinEditN(le.POSSIBLE_SSN,0,ri.POSSIBLE_SSN,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_CRIME := MAP ( ri.CRIME = (TYPEOF(ri.CRIME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.CRIME = (TYPEOF(ri.CRIME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.CRIME = le.CRIME => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_NAME_TYPE := MAP ( ri.NAME_TYPE = (TYPEOF(ri.NAME_TYPE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.NAME_TYPE = (TYPEOF(ri.NAME_TYPE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.NAME_TYPE = le.NAME_TYPE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_CLEAN_GENDER := MAP ( ri.CLEAN_GENDER = (TYPEOF(ri.CLEAN_GENDER))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.CLEAN_GENDER = (TYPEOF(ri.CLEAN_GENDER))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.CLEAN_GENDER = le.CLEAN_GENDER => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_CLASS_CODE := MAP ( ri.CLASS_CODE = (TYPEOF(ri.CLASS_CODE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.CLASS_CODE = (TYPEOF(ri.CLASS_CODE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.CLASS_CODE = le.CLASS_CODE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_FIRST_SEEN := MAP ( ri.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.DT_FIRST_SEEN = le.DT_FIRST_SEEN => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_LAST_SEEN := MAP ( ri.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.DT_LAST_SEEN = le.DT_LAST_SEEN => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DATA_PROVIDER_ORI := MAP ( ri.DATA_PROVIDER_ORI = (TYPEOF(ri.DATA_PROVIDER_ORI))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.DATA_PROVIDER_ORI = (TYPEOF(ri.DATA_PROVIDER_ORI))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.DATA_PROVIDER_ORI = le.DATA_PROVIDER_ORI => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_VIN := MAP ( ri.VIN = (TYPEOF(ri.VIN))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.VIN = (TYPEOF(ri.VIN))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.VIN = le.VIN => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_PLATE := MAP ( ri.PLATE = (TYPEOF(ri.PLATE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.PLATE = (TYPEOF(ri.PLATE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.PLATE = le.PLATE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_LATITUDE := MAP ( ri.LATITUDE = (TYPEOF(ri.LATITUDE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.LATITUDE = (TYPEOF(ri.LATITUDE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.LATITUDE = le.LATITUDE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_LONGITUDE := MAP ( ri.LONGITUDE = (TYPEOF(ri.LONGITUDE))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.LONGITUDE = (TYPEOF(ri.LONGITUDE))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.LONGITUDE = le.LONGITUDE => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_SEARCH_ADDR1 := MAP ( ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.SEARCH_ADDR1 = le.SEARCH_ADDR1 => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_SEARCH_ADDR2 := MAP ( ri.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.SEARCH_ADDR2 = le.SEARCH_ADDR2 => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_CLEAN_COMPANY_NAME := MAP ( ri.CLEAN_COMPANY_NAME = (TYPEOF(ri.CLEAN_COMPANY_NAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.CLEAN_COMPANY_NAME = (TYPEOF(ri.CLEAN_COMPANY_NAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.CLEAN_COMPANY_NAME = le.CLEAN_COMPANY_NAME => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    ri_MAINNAME := SALT37.Fn_WordBag_AppendSpecs_Fake((SALT37.StrType)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT37.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT37.StrType)le.FNAME) + ' ' + TRIM((SALT37.StrType)le.MNAME) + ' ' + TRIM((SALT37.StrType)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le_MAINNAME = (typeof(ri.MAINNAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri_MAINNAME = le_MAINNAME => SALT37.HeaderSearchMatchCode.Match, SALT37.HeaderSearchMatchCode.NoMatch);
    ri_FULLNAME := SALT37.Fn_WordBag_AppendSpecs_Fake((SALT37.StrType)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT37.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT37.StrType)le.FNAME) + ' ' + TRIM((SALT37.StrType)le.MNAME) + ' ' + TRIM((SALT37.StrType)le.LNAME) + ' ' + TRIM((SALT37.StrType)le.NAME_SUFFIX));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le_FULLNAME = (typeof(ri.FULLNAME))'' => SALT37.HeaderSearchMatchCode.BlankField, ri_FULLNAME = le_FULLNAME => SALT37.HeaderSearchMatchCode.Match, SALT37.HeaderSearchMatchCode.NoMatch);
      SELF.Record_Score := SELF.Match_NAME_SUFFIX + SELF.Match_FNAME + SELF.Match_MNAME + SELF.Match_LNAME + SELF.Match_PRIM_RANGE + SELF.Match_PRIM_NAME + SELF.Match_SEC_RANGE + SELF.Match_P_CITY_NAME + SELF.Match_ST + SELF.Match_ZIP + SELF.Match_DOB + SELF.Match_PHONE + SELF.Match_DL_ST + SELF.Match_DL + SELF.Match_LEXID + SELF.Match_POSSIBLE_SSN + SELF.Match_CRIME + SELF.Match_NAME_TYPE + SELF.Match_CLEAN_GENDER + SELF.Match_CLASS_CODE + SELF.Match_DT_FIRST_SEEN + SELF.Match_DT_LAST_SEEN + SELF.Match_DATA_PROVIDER_ORI + SELF.Match_VIN + SELF.Match_PLATE + SELF.Match_LATITUDE + SELF.Match_LONGITUDE + SELF.Match_SEARCH_ADDR1 + SELF.Match_SEARCH_ADDR2 + SELF.Match_CLEAN_COMPANY_NAME + SELF.Match_MAINNAME + SELF.Match_FULLNAME;
      SELF.Is_FullMatch := SELF.Match_NAME_SUFFIX>=0 AND SELF.Match_FNAME>=0 AND SELF.Match_MNAME>=0 AND SELF.Match_LNAME>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_P_CITY_NAME>=0 AND SELF.Match_ST>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_DOB>=0 AND SELF.Match_PHONE>=0 AND SELF.Match_DL_ST>=0 AND SELF.Match_DL>=0 AND SELF.Match_LEXID>=0 AND SELF.Match_POSSIBLE_SSN>=0 AND SELF.Match_CRIME>=0 AND SELF.Match_NAME_TYPE>=0 AND SELF.Match_CLEAN_GENDER>=0 AND SELF.Match_CLASS_CODE>=0 AND SELF.Match_DT_FIRST_SEEN>=0 AND SELF.Match_DT_LAST_SEEN>=0 AND SELF.Match_DATA_PROVIDER_ORI>=0 AND SELF.Match_VIN>=0 AND SELF.Match_PLATE>=0 AND SELF.Match_LATITUDE>=0 AND SELF.Match_LONGITUDE>=0 AND SELF.Match_SEARCH_ADDR1>=0 AND SELF.Match_SEARCH_ADDR2>=0 AND SELF.Match_CLEAN_COMPANY_NAME>=0 AND SELF.Match_MAINNAME>=0 AND SELF.Match_FULLNAME>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.EID_HASH=ri.EID_HASH AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
 
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,EID_HASH,-(Record_Score+Weight-W1)),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_PS_Layouts.InputLayout tr(Raw_Data le) := TRANSFORM
    SELF.Entered_EID_HASH := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  DSAfter_NAME_SUFFIX := SALT37.MAC_Field_Prop_Do(Raw_Data,NAME_SUFFIX,EID_HASH);
  DSAfter_MNAME := SALT37.MAC_Field_Prop_Do(DSAfter_NAME_SUFFIX,MNAME,EID_HASH);
  DSAfter_DOB := SALT37.MAC_Field_Prop_Do(DSAfter_MNAME,DOB,EID_HASH);
  DSAfter_PHONE := SALT37.MAC_Field_Prop_Do(DSAfter_DOB,PHONE,EID_HASH);
  DSAfter_POSSIBLE_SSN := SALT37.MAC_Field_Prop_Do(DSAfter_PHONE,POSSIBLE_SSN,EID_HASH);
  ds := PROJECT(DSAfter_POSSIBLE_SSN,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
Process_PS_Layouts.OutputLayout GetResultsSpecific(Process_PS_Layouts.InputLayout le,STRING LinkPathName) := TRANSFORM
// Need to annotate wordbags with specificities
  SALT37.mac_wordbag_appendspecs_rx(le.LNAME,Specificities(File_Classify_PS).LNAME_values_key,LNAME,LNAME_spec)
// Need to calculate lengths for EDIT fields
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM(le.PRIM_RANGE));
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM(le.PRIM_NAME));
  UNSIGNED1 POSSIBLE_SSN_len := LENGTH(TRIM(le.POSSIBLE_SSN));
  In_disableForce := le.disableForce;
  SELF.keys_tried := MAP(
        LinkPathName = 'NAME' =>  + IF (Key_Classify_PS_NAME.CanSearch(le),1 << 1,0),
        LinkPathName = 'ADDRESS' =>  + IF (Key_Classify_PS_ADDRESS.CanSearch(le),1 << 2,0),
        LinkPathName = 'DOB' =>  + IF (Key_Classify_PS_DOB.CanSearch(le),1 << 3,0),
        LinkPathName = 'ZIP_PR' =>  + IF (Key_Classify_PS_ZIP_PR.CanSearch(le),1 << 4,0),
        LinkPathName = 'DLN' =>  + IF (Key_Classify_PS_DLN.CanSearch(le),1 << 5,0),
        LinkPathName = 'PH' =>  + IF (Key_Classify_PS_PH.CanSearch(le),1 << 6,0),
        LinkPathName = 'LFZ' =>  + IF (Key_Classify_PS_LFZ.CanSearch(le),1 << 7,0),
        LinkPathName = 'VIN' =>  + IF (Key_Classify_PS_VIN.CanSearch(le),1 << 8,0),
        LinkPathName = 'LEXID' =>  + IF (Key_Classify_PS_LEXID.CanSearch(le),1 << 9,0),
        LinkPathName = 'SSN' =>  + IF (Key_Classify_PS_SSN.CanSearch(le),1 << 10,0),
        LinkPathName = 'LATLONG' =>  + IF (Key_Classify_PS_LATLONG.CanSearch(le),1 << 11,0),
        LinkPathName = 'PLATE' =>  + IF (Key_Classify_PS_PLATE.CanSearch(le),1 << 12,0),
        LinkPathName = 'COMPANY' =>  + IF (Key_Classify_PS_COMPANY.CanSearch(le),1 << 13,0),0);
  fetchResults := MAP(
        LinkPathName = 'NAME' => IF(Key_Classify_PS_NAME.CanSearch(le),SORTED(Key_Classify_PS_NAME.ScoredEID_HASHFetch(param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := LNAME_spec,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_DOB := (UNSIGNED4)le.DOB,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'ADDRESS' => IF(Key_Classify_PS_ADDRESS.CanSearch(le),SORTED(Key_Classify_PS_ADDRESS.ScoredEID_HASHFetch(param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_ZIP := le.ZIP,param_SEC_RANGE := le.SEC_RANGE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'DOB' => IF(Key_Classify_PS_DOB.CanSearch(le),SORTED(Key_Classify_PS_DOB.ScoredEID_HASHFetch(param_DOB := (UNSIGNED4)le.DOB,param_LNAME := LNAME_spec,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_P_CITY_NAME := le.P_CITY_NAME,param_NAME_SUFFIX := le.NAME_SUFFIX,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'ZIP_PR' => IF(Key_Classify_PS_ZIP_PR.CanSearch(le),SORTED(Key_Classify_PS_ZIP_PR.ScoredEID_HASHFetch(param_ZIP := le.ZIP,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := LNAME_spec,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'DLN' => IF(Key_Classify_PS_DLN.CanSearch(le),SORTED(Key_Classify_PS_DLN.ScoredEID_HASHFetch(param_DL := le.DL,param_DL_ST := le.DL_ST,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'PH' => IF(Key_Classify_PS_PH.CanSearch(le),SORTED(Key_Classify_PS_PH.ScoredEID_HASHFetch(param_PHONE := le.PHONE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_DOB := (UNSIGNED4)le.DOB,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'LFZ' => IF(Key_Classify_PS_LFZ.CanSearch(le),SORTED(Key_Classify_PS_LFZ.ScoredEID_HASHFetch(param_LNAME := LNAME_spec,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_ZIP := le.ZIP,param_P_CITY_NAME := le.P_CITY_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SEC_RANGE := le.SEC_RANGE,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'VIN' => IF(Key_Classify_PS_VIN.CanSearch(le),SORTED(Key_Classify_PS_VIN.ScoredEID_HASHFetch(param_VIN := le.VIN,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'LEXID' => IF(Key_Classify_PS_LEXID.CanSearch(le),SORTED(Key_Classify_PS_LEXID.ScoredEID_HASHFetch(param_LEXID := le.LEXID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_DL := le.DL,param_DL_ST := le.DL_ST,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'SSN' => IF(Key_Classify_PS_SSN.CanSearch(le),SORTED(Key_Classify_PS_SSN.ScoredEID_HASHFetch(param_POSSIBLE_SSN := le.POSSIBLE_SSN,param_POSSIBLE_SSN_len := POSSIBLE_SSN_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'LATLONG' => IF(Key_Classify_PS_LATLONG.CanSearch(le),SORTED(Key_Classify_PS_LATLONG.ScoredEID_HASHFetch(param_LATITUDE := le.LATITUDE,param_LONGITUDE := le.LONGITUDE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_POSSIBLE_SSN := le.POSSIBLE_SSN,param_POSSIBLE_SSN_len := POSSIBLE_SSN_len,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'PLATE' => IF(Key_Classify_PS_PLATE.CanSearch(le),SORTED(Key_Classify_PS_PLATE.ScoredEID_HASHFetch(param_PLATE := le.PLATE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := LNAME_spec,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),
        LinkPathName = 'COMPANY' => IF(Key_Classify_PS_COMPANY.CanSearch(le),SORTED(Key_Classify_PS_COMPANY.ScoredEID_HASHFetch(param_CLEAN_COMPANY_NAME := le.CLEAN_COMPANY_NAME,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID,param_disableForce := In_disableForce),EID_HASH),DATASET([],Process_PS_Layouts.LayoutScoredFetch)),DATASET([],Process_PS_Layouts.LayoutScoredFetch));
  SELF.Results := CHOOSEN(fetchResults, le.MaxIDs);
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_PS_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  EXPORT DirectEID_HASHFetch(STRING LpName):= PROJECT(in(Entered_EID_HASH=0),GetResultsSpecific(left,LpName),PREFETCH(Config.MeowPrefetch,PARALLEL));
END;
 
