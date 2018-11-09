IMPORT ut,SALT33;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_PS(DATASET(Process_PS_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT33.UIDType ButNot=[]) := MODULE
Process_PS_Layouts.OutputLayout GetResults(Process_PS_Layouts.InputLayout le) := TRANSFORM
  SELF.keys_tried := IF (Key_Classify_PS_NAME.CanSearch(le),1 << 1,0) + IF (Key_Classify_PS_ADDRESS.CanSearch(le),1 << 2,0) + IF (Key_Classify_PS_ADDRESS1.CanSearch(le),1 << 3,0) + IF (Key_Classify_PS_DOB.CanSearch(le),1 << 4,0) + IF (Key_Classify_PS_ZIP_PR.CanSearch(le),1 << 5,0) + IF (Key_Classify_PS_DLN.CanSearch(le),1 << 6,0) + IF (Key_Classify_PS_PH.CanSearch(le),1 << 7,0) + IF (Key_Classify_PS_LFZ.CanSearch(le),1 << 8,0) + IF (Key_Classify_PS_VIN.CanSearch(le),1 << 9,0) + IF (Key_Classify_PS_LEXID.CanSearch(le),1 << 10,0) + IF (Key_Classify_PS_SSN.CanSearch(le),1 << 11,0) + IF (Key_Classify_PS_LATLONG.CanSearch(le),1 << 12,0) + IF (Key_Classify_PS_PLATE.CanSearch(le),1 << 13,0) + IF (Key_Classify_PS_COMPANY.CanSearch(le),1 << 14,0);
  SELF.Results := TOPN(ROLLUP(
    MERGE(
    SORTED(Key_Classify_PS_NAME.ScoredEID_HASHFetch(param_FNAME := le.FNAME,param_LNAME := le.LNAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_MNAME := le.MNAME,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_NAME := le.PRIM_NAME,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_DOB := (UNSIGNED4)le.DOB,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID),EID_HASH)
    ,SORTED(Key_Classify_PS_ADDRESS.ScoredEID_HASHFetch(param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_NAME := le.PRIM_NAME,param_ZIP := le.ZIP,param_SEC_RANGE := le.SEC_RANGE,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_ADDRESS1.ScoredEID_HASHFetch(param_PRIM_NAME := le.PRIM_NAME,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_PRIM_RANGE := le.PRIM_RANGE,param_LNAME := le.LNAME,param_FNAME := le.FNAME,param_SEC_RANGE := le.SEC_RANGE,param_ZIP := le.ZIP,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_DOB.ScoredEID_HASHFetch(param_DOB := (UNSIGNED4)le.DOB,param_LNAME := le.LNAME,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_ST := le.ST,param_P_CITY_NAME := le.P_CITY_NAME,param_NAME_SUFFIX := le.NAME_SUFFIX),EID_HASH)
    ,SORTED(Key_Classify_PS_ZIP_PR.ScoredEID_HASHFetch(param_ZIP := le.ZIP,param_PRIM_RANGE := le.PRIM_RANGE,param_FNAME := le.FNAME,param_LNAME := le.LNAME,param_PRIM_NAME := le.PRIM_NAME,param_SEC_RANGE := le.SEC_RANGE,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_DLN.ScoredEID_HASHFetch(param_DL := le.DL,param_DL_ST := le.DL_ST,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_PH.ScoredEID_HASHFetch(param_PHONE := le.PHONE,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_DOB := (UNSIGNED4)le.DOB,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST),EID_HASH)
    ,SORTED(Key_Classify_PS_LFZ.ScoredEID_HASHFetch(param_LNAME := le.LNAME,param_FNAME := le.FNAME,param_ZIP := le.ZIP,param_P_CITY_NAME := le.P_CITY_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_NAME := le.PRIM_NAME,param_MNAME := le.MNAME,param_SEC_RANGE := le.SEC_RANGE,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_VIN.ScoredEID_HASHFetch(param_VIN := le.VIN,param_LNAME := le.LNAME,param_P_CITY_NAME := le.P_CITY_NAME),EID_HASH)
    ,SORTED(Key_Classify_PS_LEXID.ScoredEID_HASHFetch(param_LEXID := le.LEXID,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_NAME_SUFFIX := le.NAME_SUFFIX,param_DOB := (UNSIGNED4)le.DOB,param_DL := le.DL),EID_HASH)
    ,SORTED(Key_Classify_PS_SSN.ScoredEID_HASHFetch(param_POSSIBLE_SSN := le.POSSIBLE_SSN,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_DOB := (UNSIGNED4)le.DOB),EID_HASH)
    ,SORTED(Key_Classify_PS_LATLONG.ScoredEID_HASHFetch(param_LATITUDE := le.LATITUDE,param_LONGITUDE := le.LONGITUDE,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_POSSIBLE_SSN := le.POSSIBLE_SSN),EID_HASH)
    ,SORTED(Key_Classify_PS_PLATE.ScoredEID_HASHFetch(param_PLATE := le.PLATE,param_FNAME := le.FNAME,param_MNAME := le.MNAME,param_LNAME := le.LNAME,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST),EID_HASH)
    ,SORTED(Key_Classify_PS_COMPANY.ScoredEID_HASHFetch(param_CLEAN_COMPANY_NAME := le.CLEAN_COMPANY_NAME,param_SEARCH_ADDR1 := le.SEARCH_ADDR1,param_P_CITY_NAME := le.P_CITY_NAME,param_ST := le.ST,param_SEARCH_ADDR2 := le.SEARCH_ADDR2,param_LEXID := le.LEXID),EID_HASH),SORTED(EID_HASH)) /* Merged */
    , RIGHT.EID_HASH > 0 AND LEFT.EID_HASH = RIGHT.EID_HASH, Process_PS_Layouts.Combine_Scores(LEFT,RIGHT))(EID_HASH NOT IN ButNot),le.MaxIDs,-Weight)(SALT33.DebugMode OR ~ForceFailed OR ButNot<>[]); // Warning - is a fetch to keys etc
  Process_PS_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_EID_HASH=0),GetResults(left),PREFETCH(20,PARALLEL));
  Process_PS_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    SELF.Results := TOPN(ROLLUP( SORT( le.Results+ri.Results, EID_HASH )
    , RIGHT.EID_HASH > 0 AND LEFT.EID_HASH = RIGHT.EID_HASH, Process_PS_Layouts.Combine_Scores(LEFT,RIGHT))(EID_HASH NOT IN ButNot),le.MaxIds,-Weight);
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
  SALT33.MAC_External_AddPcnt(RR3,Process_PS_Layouts.LayoutScoredFetch,Results,Process_PS_Layouts.OutputLayout,28,RR4);
EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the EID_HASH on them
  process_PS_layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.EID_HASH := le.Entered_EID_HASH;
  END;
  pass_thru := PROJECT(in(~(Entered_EID_HASH=0)),ptt(LEFT));
// Transform to process 'real' results
  process_PS_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER))+pass_thru;
  EXPORT Fetch_Stream(DATASET(process_PS_layouts.id_stream_layout) d) := FUNCTION
    k := Process_PS_Layouts.Key;
    DLayout := RECORD
      process_PS_layouts.id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT process_PS_layouts.id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(Uid_Results le, k ri) := TRANSFORM
      SELF.did_fetch := ri.EID_HASH<>0;
      SELF.EID_HASH := IF ( SELF.did_fetch, ri.EID_HASH, le.EID_HASH ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    RETURN JOIN( d,k,(LEFT.EID_HASH = RIGHT.EID_HASH),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000)); // Ignore excess records without erroring
    END;
 
  EXPORT Raw_Data := Fetch_Stream(Uid_Results);
 
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
    IMPORT SALT33;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_NAME_SUFFIX := MAP ( ri.NAME_SUFFIX = (typeof(ri.NAME_SUFFIX))'' => 0, le.NAME_SUFFIX = (typeof(ri.NAME_SUFFIX))'' => -1, ri.NAME_SUFFIX = le.NAME_SUFFIX => 2,-2);
    SELF.Match_FNAME := MAP ( ri.FNAME = (typeof(ri.FNAME))'' => 0, le.FNAME = (typeof(ri.FNAME))'' => -1, ri.FNAME = le.FNAME => 2,SALT33.WithinEditN(le.FNAME,ri.FNAME,1, 0) => 1,metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME) => 1,le.FNAME = ri.FNAME[length(trim(le.FNAME))] OR ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => 1,-2);
    SELF.Match_MNAME := MAP ( ri.MNAME = (typeof(ri.MNAME))'' => 0, le.MNAME = (typeof(ri.MNAME))'' => -1, ri.MNAME = le.MNAME => 2,SALT33.WithinEditN(le.MNAME,ri.MNAME,2, 0) => 1,le.MNAME = ri.MNAME[length(trim(le.MNAME))] OR ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => 1,-2);
    SELF.Match_LNAME := MAP ( ri.LNAME = (typeof(ri.LNAME))'' => 0, le.LNAME = (typeof(ri.LNAME))'' => -1, ri.LNAME = le.LNAME => 2,SALT33.WithinEditN(le.LNAME,ri.LNAME,1, 0) => 1,metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME) => 1,-2);
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0, le.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => -1, ri.PRIM_RANGE = le.PRIM_RANGE => 2,SALT33.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1, 0) => 1,-2);
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0, le.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => -1, ri.PRIM_NAME = le.PRIM_NAME => 2,SALT33.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1, 0) => 1,-2);
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0, le.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => -1, ri.SEC_RANGE = le.SEC_RANGE => 2,-2);
    SELF.Match_P_CITY_NAME := MAP ( ri.P_CITY_NAME = (typeof(ri.P_CITY_NAME))'' => 0, le.P_CITY_NAME = (typeof(ri.P_CITY_NAME))'' => -1, ri.P_CITY_NAME = le.P_CITY_NAME => 2,-2);
    SELF.Match_ST := MAP ( ri.ST = (typeof(ri.ST))'' => 0, le.ST = (typeof(ri.ST))'' => -1, ri.ST = le.ST => 2,-2);
    SELF.Match_ZIP := MAP ( ri.ZIP = (typeof(ri.ZIP))'' => 0, le.ZIP = (typeof(ri.ZIP))'' => -1, ri.ZIP = le.ZIP => 2,-2);
    SELF.Match_DOB := SALT33.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
    SELF.Match_PHONE := MAP ( ri.PHONE = (typeof(ri.PHONE))'' => 0, le.PHONE = (typeof(ri.PHONE))'' => -1, ri.PHONE = le.PHONE => 2,-2);
    SELF.Match_DL_ST := MAP ( ri.DL_ST = (typeof(ri.DL_ST))'' => 0, le.DL_ST = (typeof(ri.DL_ST))'' => -1, ri.DL_ST = le.DL_ST => 2,-2);
    SELF.Match_DL := MAP ( ri.DL = (typeof(ri.DL))'' => 0, le.DL = (typeof(ri.DL))'' => -1, ri.DL = le.DL => 2,-2);
    SELF.Match_LEXID := MAP ( ri.LEXID = (typeof(ri.LEXID))'' => 0, le.LEXID = (typeof(ri.LEXID))'' => -1, ri.LEXID = le.LEXID => 2,-2);
    SELF.Match_POSSIBLE_SSN := MAP ( ri.POSSIBLE_SSN = (typeof(ri.POSSIBLE_SSN))'' => 0, le.POSSIBLE_SSN = (typeof(ri.POSSIBLE_SSN))'' => -1, ri.POSSIBLE_SSN = le.POSSIBLE_SSN => 2,SALT33.WithinEditN(le.POSSIBLE_SSN,ri.POSSIBLE_SSN,1, 0) => 1,-2);
    SELF.Match_CRIME := MAP ( ri.CRIME = (typeof(ri.CRIME))'' => 0, le.CRIME = (typeof(ri.CRIME))'' => -1, ri.CRIME = le.CRIME => 2,-2);
    SELF.Match_NAME_TYPE := MAP ( ri.NAME_TYPE = (typeof(ri.NAME_TYPE))'' => 0, le.NAME_TYPE = (typeof(ri.NAME_TYPE))'' => -1, ri.NAME_TYPE = le.NAME_TYPE => 2,-2);
    SELF.Match_CLEAN_GENDER := MAP ( ri.CLEAN_GENDER = (typeof(ri.CLEAN_GENDER))'' => 0, le.CLEAN_GENDER = (typeof(ri.CLEAN_GENDER))'' => -1, ri.CLEAN_GENDER = le.CLEAN_GENDER => 2,-2);
    SELF.Match_CLASS_CODE := MAP ( ri.CLASS_CODE = (typeof(ri.CLASS_CODE))'' => 0, le.CLASS_CODE = (typeof(ri.CLASS_CODE))'' => -1, ri.CLASS_CODE = le.CLASS_CODE => 2,-2);
    SELF.Match_DT_FIRST_SEEN := MAP ( ri.DT_FIRST_SEEN = (typeof(ri.DT_FIRST_SEEN))'' => 0, le.DT_FIRST_SEEN = (typeof(ri.DT_FIRST_SEEN))'' => -1, ri.DT_FIRST_SEEN = le.DT_FIRST_SEEN => 2,-2);
    SELF.Match_DT_LAST_SEEN := MAP ( ri.DT_LAST_SEEN = (typeof(ri.DT_LAST_SEEN))'' => 0, le.DT_LAST_SEEN = (typeof(ri.DT_LAST_SEEN))'' => -1, ri.DT_LAST_SEEN = le.DT_LAST_SEEN => 2,-2);
    SELF.Match_DATA_PROVIDER_ORI := MAP ( ri.DATA_PROVIDER_ORI = (typeof(ri.DATA_PROVIDER_ORI))'' => 0, le.DATA_PROVIDER_ORI = (typeof(ri.DATA_PROVIDER_ORI))'' => -1, ri.DATA_PROVIDER_ORI = le.DATA_PROVIDER_ORI => 2,-2);
    SELF.Match_VIN := MAP ( ri.VIN = (typeof(ri.VIN))'' => 0, le.VIN = (typeof(ri.VIN))'' => -1, ri.VIN = le.VIN => 2,-2);
    SELF.Match_PLATE := MAP ( ri.PLATE = (typeof(ri.PLATE))'' => 0, le.PLATE = (typeof(ri.PLATE))'' => -1, ri.PLATE = le.PLATE => 2,-2);
    SELF.Match_LATITUDE := MAP ( ri.LATITUDE = (typeof(ri.LATITUDE))'' => 0, le.LATITUDE = (typeof(ri.LATITUDE))'' => -1, ri.LATITUDE = le.LATITUDE => 2,-2);
    SELF.Match_LONGITUDE := MAP ( ri.LONGITUDE = (typeof(ri.LONGITUDE))'' => 0, le.LONGITUDE = (typeof(ri.LONGITUDE))'' => -1, ri.LONGITUDE = le.LONGITUDE => 2,-2);
    SELF.Match_SEARCH_ADDR1 := MAP ( ri.SEARCH_ADDR1 = (typeof(ri.SEARCH_ADDR1))'' => 0, le.SEARCH_ADDR1 = (typeof(ri.SEARCH_ADDR1))'' => -1, ri.SEARCH_ADDR1 = le.SEARCH_ADDR1 => 2,-2);
    SELF.Match_SEARCH_ADDR2 := MAP ( ri.SEARCH_ADDR2 = (typeof(ri.SEARCH_ADDR2))'' => 0, le.SEARCH_ADDR2 = (typeof(ri.SEARCH_ADDR2))'' => -1, ri.SEARCH_ADDR2 = le.SEARCH_ADDR2 => 2,-2);
    SELF.Match_CLEAN_COMPANY_NAME := MAP ( ri.CLEAN_COMPANY_NAME = (typeof(ri.CLEAN_COMPANY_NAME))'' => 0, le.CLEAN_COMPANY_NAME = (typeof(ri.CLEAN_COMPANY_NAME))'' => -1, ri.CLEAN_COMPANY_NAME = le.CLEAN_COMPANY_NAME => 2,-2);
    ri_MAINNAME := SALT33.Fn_WordBag_AppendSpecs_Fake((SALT33.StrType)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT33.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT33.StrType)le.FNAME) + ' ' + TRIM((SALT33.StrType)le.MNAME) + ' ' + TRIM((SALT33.StrType)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => 0, le_MAINNAME = (typeof(ri.MAINNAME))'' => -1, ri_MAINNAME = le_MAINNAME => 2,SALT33.MatchBagOfWords(le_MAINNAME,ri_MAINNAME,31744,1) > Bair_ExternalLinkKeys.Config.MAINNAME_Force * 100 => 1, -2);
    ri_FULLNAME := SALT33.Fn_WordBag_AppendSpecs_Fake((SALT33.StrType)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT33.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT33.StrType)le.FNAME) + ' ' + TRIM((SALT33.StrType)le.MNAME) + ' ' + TRIM((SALT33.StrType)le.LNAME) + ' ' + TRIM((SALT33.StrType)le.NAME_SUFFIX));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => 0, le_FULLNAME = (typeof(ri.FULLNAME))'' => -1, ri_FULLNAME = le_FULLNAME => 2, -2);
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
  DSAfter_NAME_SUFFIX := SALT33.MAC_Field_Prop_Do(Raw_Data,NAME_SUFFIX,EID_HASH);
  DSAfter_MNAME := SALT33.MAC_Field_Prop_Do(DSAfter_NAME_SUFFIX,MNAME,EID_HASH);
  DSAfter_DOB := SALT33.MAC_Field_Prop_Do(DSAfter_MNAME,DOB,EID_HASH);
  DSAfter_PHONE := SALT33.MAC_Field_Prop_Do(DSAfter_DOB,PHONE,EID_HASH);
  DSAfter_POSSIBLE_SSN := SALT33.MAC_Field_Prop_Do(DSAfter_PHONE,POSSIBLE_SSN,EID_HASH);
  ds := PROJECT(DSAfter_POSSIBLE_SSN,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
END;
 
