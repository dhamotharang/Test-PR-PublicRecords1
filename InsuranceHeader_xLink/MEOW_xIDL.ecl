IMPORT SALT311;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_xIDL(DATASET(Process_xIDL_Layouts().InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT311.UIDType ButNot=[], UNSIGNED2 aBlockLimit=0) := MODULE /*MEOWHACK05*/
Process_xIDL_Layouts().OutputLayout GetResults(Process_xIDL_Layouts().InputLayout le) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 LNAME_len := LENGTH(TRIM(le.LNAME));
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM(le.PRIM_RANGE));
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM(le.PRIM_NAME));
  UNSIGNED1 SSN5_len := LENGTH(TRIM(le.SSN5));
  UNSIGNED1 SSN4_len := LENGTH(TRIM(le.SSN4));
  UNSIGNED1 DL_NBR_len := LENGTH(TRIM(le.DL_NBR));
  In_disableForce := le.disableForce;
  SELF.keys_tried := IF (Key_InsuranceHeader_NAME().CanSearch(le),1 << 1,0) + IF (Key_InsuranceHeader_ADDRESS().CanSearch(le),1 << 2,0) + IF (Key_InsuranceHeader_SSN().CanSearch(le),1 << 3,0) + IF (Key_InsuranceHeader_SSN4().CanSearch(le),1 << 4,0) + IF (Key_InsuranceHeader_DOB().CanSearch(le),1 << 5,0) + IF (Key_InsuranceHeader_DOBF().CanSearch(le),1 << 6,0) + IF (Key_InsuranceHeader_ZIP_PR().CanSearch(le),1 << 7,0) + IF (Key_InsuranceHeader_SRC_RID().CanSearch(le),1 << 8,0) + IF (Key_InsuranceHeader_DLN().CanSearch(le),1 << 9,0) + IF (Key_InsuranceHeader_PH().CanSearch(le),1 << 10,0) + IF (Key_InsuranceHeader_LFZ().CanSearch(le),1 << 11,0) + IF (Key_InsuranceHeader_RELATIVE().CanSearch(le),1 << 12,0) + IF (Key_InsuranceHeader_VIN().CanSearch(le),1 << 13,0);
  fetchResults0 := ROLLUP(
    MERGE(
    SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_NAME().CanSearch(le),Key_InsuranceHeader_NAME(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_CITY := le.CITY,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().CanSearch(le),Key_InsuranceHeader_ADDRESS(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_ZIP := le.ZIP_cases,param_SEC_RANGE := le.SEC_RANGE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SSN().CanSearch(le),Key_InsuranceHeader_SSN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().CanSearch(le),Key_InsuranceHeader_SSN4(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DOB().CanSearch(le),Key_InsuranceHeader_DOB(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DOB := (UNSIGNED4)le.DOB,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_CITY := le.CITY,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().CanSearch(le),Key_InsuranceHeader_DOBF(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DOB := (UNSIGNED4)le.DOB,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_CITY := le.CITY,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().CanSearch(le),Key_InsuranceHeader_ZIP_PR(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_ZIP := le.ZIP_cases,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().CanSearch(le),Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DLN().CanSearch(le),Key_InsuranceHeader_DLN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_PH().CanSearch(le),Key_InsuranceHeader_PH(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_PHONE := le.PHONE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_ST := le.ST,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().CanSearch(le),Key_InsuranceHeader_LFZ(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_ZIP := le.ZIP_cases,param_CITY := le.CITY,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SEC_RANGE := le.SEC_RANGE,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_ST := le.ST,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().CanSearch(le),Key_InsuranceHeader_RELATIVE(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_fname2 := le.fname2,param_lname2 := le.lname2,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_disableForce := In_disableForce)),DID)
    ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_VIN().CanSearch(le),Key_InsuranceHeader_VIN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_VIN := le.VIN,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_disableForce := In_disableForce)),DID),SORTED(DID)) /* Merged */
    , RIGHT.DID > 0 AND LEFT.DID = RIGHT.DID, Process_xIDL_Layouts().Combine_Scores(LEFT, RIGHT, In_disableForce))((DID NOT IN ButNot) AND (SALT311.DebugMode OR ~ForceFailed OR ButNot <> [])); // Warning - is a fetch to keys etc
  	fetchResults11 := Process_xIDL_Layouts().combine_Zip(fetchResults0);
	fetchResults1 := UNGROUP(InsuranceHeader_xlink.patch_specificities(fetchResults11));
	fetchResults := TOPN(fetchResults1(DID > 0),le.MaxIDs + 1,-Weight) & fetchResults1(DID = 0); /*ZIPPATCHHACK01d*/
  SELF.Results := PROJECT(CHOOSEN(Process_xIDL_Layouts().AdjustKeysUsedAndFailed(fetchResults), le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_xIDL_Layouts().MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_RID=0 AND Entered_DID=0),GetResults(left),PREFETCH(Config.MeowPrefetch,PARALLEL));
  Process_xIDL_Layouts().OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    In_disableForce := le.disableForce;
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, DID )
    , RIGHT.DID > 0 AND LEFT.DID = RIGHT.DID, Process_xIDL_Layouts().Combine_Scores(LEFT, RIGHT, In_disableForce))((DID NOT IN ButNot) AND (SALT311.DebugMode OR ~ForceFailed OR ButNot <> [])),le.MaxIds + 1,-Weight);
    SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
    SELF.IsTruncated := ((le.IsTruncated OR ri.IsTruncated) AND COUNT(mergedResults) = le.MaxIds) OR COUNT(mergedResults) > le.MaxIds;
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR20 := IF ( MultiRec, RR1, RR0 );
  Process_xIDL_Layouts().OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
    SELF.Results := UNGROUP(Process_xIDL_Layouts().AdjustScoresForNonExactMatches(le.Results));
    SELF := le;
  END;
  RR2 := PROJECT(RR20,AdjustScores(LEFT));
  Process_xIDL_Layouts().OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF.IsTruncated := le.IsTruncated AND COUNT(SELF.Results) = le.MaxIds;
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT311.MAC_External_AddPcnt(RR3,Process_xIDL_Layouts().LayoutScoredFetch,Results,Process_xIDL_Layouts().OutputLayout,29,RR4);/*HACK16*/
  EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the DID on them
  Process_xIDL_Layouts().id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := FALSE;
    SELF.DID := le.Entered_DID;
    SELF.RID := le.Entered_RID;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.Score := 100;
  END;
  SHARED pass_thru := PROJECT(in(~(Entered_RID=0 AND Entered_DID=0)),ptt(LEFT));
// Transform to process 'real' results
  Process_xIDL_Layouts().id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := le.IsTruncated;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results0 := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER));
  EXPORT Uid_Results := Uid_Results0+pass_thru;
  EXPORT Raw_Data := Process_xIDL_Layouts().Fetch_Stream_Expanded(Uid_Results);
 
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_SNAME;
      INTEGER2 Match_FNAME;
      INTEGER2 Match_MNAME;
      INTEGER2 Match_LNAME;
      INTEGER2 Match_DERIVED_GENDER;
      INTEGER2 Match_PRIM_RANGE;
      INTEGER2 Match_PRIM_NAME;
      INTEGER2 Match_SEC_RANGE;
      INTEGER2 Match_CITY;
      INTEGER2 Match_ST;
      INTEGER2 Match_ZIP;
      INTEGER2 Match_SSN5;
      INTEGER2 Match_SSN4;
      INTEGER2 Match_DOB;
      INTEGER2 Match_PHONE;
      INTEGER2 Match_DL_STATE;
      INTEGER2 Match_DL_NBR;
      INTEGER2 Match_SRC;
      INTEGER2 Match_SOURCE_RID;
      INTEGER2 Match_DT_FIRST_SEEN;
      INTEGER2 Match_DT_LAST_SEEN;
      INTEGER2 Match_DT_EFFECTIVE_FIRST;
      INTEGER2 Match_DT_EFFECTIVE_LAST;
      INTEGER2 Match_MAINNAME;
      INTEGER2 Match_FULLNAME;
      INTEGER2 Match_ADDR1;
      INTEGER2 Match_LOCALE;
      INTEGER2 Match_ADDRESS;
    END;
    IMPORT SALT311,InsuranceHeader_xLink;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_SNAME := MAP ( ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SNAME = (TYPEOF(ri.SNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SNAME(le.SNAME,ri.SNAME,FALSE)));
    SELF.Match_FNAME := MAP ( ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,0,0,FALSE)));
    SELF.Match_MNAME := MAP ( ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_MNAME(le.MNAME,ri.MNAME,0,0,FALSE)));
    SELF.Match_LNAME := MAP ( ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,0,0,FALSE)));
    SELF.Match_DERIVED_GENDER := MAP ( ri.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,ri.DERIVED_GENDER,FALSE)));
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,0,0,FALSE)));
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,0,0,FALSE)));
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE)));
    SELF.Match_CITY := MAP ( ri.CITY = (TYPEOF(ri.CITY))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.CITY = (TYPEOF(ri.CITY))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_CITY(le.CITY,ri.CITY,FALSE)));
    SELF.Match_ST := MAP ( ri.ST = (TYPEOF(ri.ST))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.ST = (TYPEOF(ri.ST))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_ST(le.ST,ri.ST,FALSE)));
    SELF.Match_ZIP := MAP ( ~EXISTS(ri.ZIP_cases) => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.ZIP = (TYPEOF(le.ZIP))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_ZIP_el(le.ZIP,SET(ri.ZIP_cases,ZIP),FALSE)));
    SELF.Match_SSN5 := MAP ( ri.SSN5 = (TYPEOF(ri.SSN5))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SSN5 = (TYPEOF(ri.SSN5))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SSN5(le.SSN5,ri.SSN5,0,0,FALSE)));
    SELF.Match_SSN4 := MAP ( ri.SSN4 = (TYPEOF(ri.SSN4))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SSN4 = (TYPEOF(ri.SSN4))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SSN4(le.SSN4,ri.SSN4,0,0,FALSE)));
    SELF.Match_DOB := SALT311.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
    SELF.Match_PHONE := MAP ( ri.PHONE = (TYPEOF(ri.PHONE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.PHONE = (TYPEOF(ri.PHONE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_PHONE(le.PHONE,ri.PHONE,FALSE)));
    SELF.Match_DL_STATE := MAP ( ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DL_STATE = (TYPEOF(ri.DL_STATE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_DL_STATE(le.DL_STATE,ri.DL_STATE,FALSE)));
    SELF.Match_DL_NBR := MAP ( ri.DL_NBR = (TYPEOF(ri.DL_NBR))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DL_NBR = (TYPEOF(ri.DL_NBR))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_DL_NBR(le.DL_NBR,ri.DL_NBR,0,0,FALSE)));
    SELF.Match_SRC := MAP ( ri.SRC = (TYPEOF(ri.SRC))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SRC = (TYPEOF(ri.SRC))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SRC(le.SRC,ri.SRC,FALSE)));
    SELF.Match_SOURCE_RID := MAP ( ri.SOURCE_RID = (TYPEOF(ri.SOURCE_RID))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SOURCE_RID = (TYPEOF(ri.SOURCE_RID))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(InsuranceHeader_xLink.match_methods(InsuranceHeader_xLink.File_InsuranceHeader).match_SOURCE_RID(le.SOURCE_RID,ri.SOURCE_RID,FALSE)));
    SELF.Match_DT_FIRST_SEEN := MAP ( ri.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_FIRST_SEEN = le.DT_FIRST_SEEN => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_LAST_SEEN := MAP ( ri.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_LAST_SEEN = le.DT_LAST_SEEN => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_EFFECTIVE_FIRST := MAP ( ri.DT_EFFECTIVE_FIRST = (TYPEOF(ri.DT_EFFECTIVE_FIRST))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_EFFECTIVE_FIRST = (TYPEOF(ri.DT_EFFECTIVE_FIRST))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_EFFECTIVE_FIRST = le.DT_EFFECTIVE_FIRST => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_EFFECTIVE_LAST := MAP ( ri.DT_EFFECTIVE_LAST = (TYPEOF(ri.DT_EFFECTIVE_LAST))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_EFFECTIVE_LAST = (TYPEOF(ri.DT_EFFECTIVE_LAST))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_EFFECTIVE_LAST = le.DT_EFFECTIVE_LAST => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    ri_MAINNAME := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_MAINNAME = (typeof(ri.MAINNAME))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_MAINNAME = le_MAINNAME => SALT311.HeaderSearchMatchCode.Match,SALT311.MatchBagOfWords(le_MAINNAME,ri_MAINNAME,31744,1) > InsuranceHeader_xLink.Config.MAINNAME_Force * 100 => SALT311.HeaderSearchMatchCode.FuzzyMatch, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_FULLNAME := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SNAME));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_FULLNAME = (typeof(ri.FULLNAME))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_FULLNAME = le_FULLNAME => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_ADDR1 := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.ADDR1);//For later scoring
    le_ADDR1 := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME));//For later scoring
    SELF.Match_ADDR1 := MAP ( ri.ADDR1 = (typeof(ri.ADDR1))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_ADDR1 = (typeof(ri.ADDR1))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_ADDR1 = le_ADDR1 => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_LOCALE := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.LOCALE);//For later scoring
    le_LOCALE := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.CITY) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP));//For later scoring
    SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_LOCALE = (typeof(ri.LOCALE))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_LOCALE = le_LOCALE => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_ADDRESS := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.ADDRESS);//For later scoring
    le_ADDRESS := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.CITY) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP));//For later scoring
    SELF.Match_ADDRESS := MAP ( ri.ADDRESS = (typeof(ri.ADDRESS))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_ADDRESS = (typeof(ri.ADDRESS))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_ADDRESS = le_ADDRESS => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
      SELF.Record_Score := SELF.Match_SNAME + SELF.Match_FNAME + SELF.Match_MNAME + SELF.Match_LNAME + SELF.Match_DERIVED_GENDER + SELF.Match_PRIM_RANGE + SELF.Match_PRIM_NAME + SELF.Match_SEC_RANGE + SELF.Match_CITY + SELF.Match_ST + SELF.Match_ZIP + SELF.Match_SSN5 + SELF.Match_SSN4 + SELF.Match_DOB + SELF.Match_PHONE + SELF.Match_DL_STATE + SELF.Match_DL_NBR + SELF.Match_SRC + SELF.Match_SOURCE_RID + SELF.Match_DT_FIRST_SEEN + SELF.Match_DT_LAST_SEEN + SELF.Match_DT_EFFECTIVE_FIRST + SELF.Match_DT_EFFECTIVE_LAST + SELF.Match_MAINNAME + SELF.Match_FULLNAME + SELF.Match_ADDR1 + SELF.Match_LOCALE + SELF.Match_ADDRESS;
      SELF.Is_FullMatch := SELF.Match_SNAME>=0 AND SELF.Match_FNAME>=0 AND SELF.Match_MNAME>=0 AND SELF.Match_LNAME>=0 AND SELF.Match_DERIVED_GENDER>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_CITY>=0 AND SELF.Match_ST>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_SSN5>=0 AND SELF.Match_SSN4>=0 AND SELF.Match_DOB>=0 AND SELF.Match_PHONE>=0 AND SELF.Match_DL_STATE>=0 AND SELF.Match_DL_NBR>=0 AND SELF.Match_SRC>=0 AND SELF.Match_SOURCE_RID>=0 AND SELF.Match_DT_FIRST_SEEN>=0 AND SELF.Match_DT_LAST_SEEN>=0 AND SELF.Match_DT_EFFECTIVE_FIRST>=0 AND SELF.Match_DT_EFFECTIVE_LAST>=0 AND SELF.Match_MAINNAME>=0 AND SELF.Match_FULLNAME>=0 AND SELF.Match_ADDR1>=0 AND SELF.Match_LOCALE>=0 AND SELF.Match_ADDRESS>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.DID=ri.DID AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
 
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,DID,-(Record_Score+Weight-W1)),WHOLE RECORD);
  EXPORT Raw_Data0 := JOIN( Uid_Results,Process_xIDL_Layouts().Key0,LEFT.DID=RIGHT.DID,LIMIT(Config.JoinLimit) );
  EXPORT Data_0 := DEDUP(SORT(Raw_Data0,-Weight,DID),WHOLE RECORD);
  EXPORT Raw_Data1 := JOIN( Uid_Results,Process_xIDL_Layouts().Key1,LEFT.DID=RIGHT.DID,LIMIT(Config.JoinLimit) );
  EXPORT Data_1 := DEDUP(SORT(Raw_Data1,-Weight,DID),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_xIDL_Layouts().InputLayout tr(Raw_Data le) := TRANSFORM
  SELF.Entered_RID := 0;
    SELF.Entered_DID := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  DSAfter_SNAME := SALT311.MAC_Field_Prop_Do(Raw_Data,SNAME,DID);
  DSAfter_MNAME := SALT311.MAC_Field_Prop_Do(DSAfter_SNAME,MNAME,DID);
  DSAfter_DERIVED_GENDER := SALT311.MAC_Field_Prop_Do(DSAfter_MNAME,DERIVED_GENDER,DID);
  DSAfter_SSN5 := SALT311.MAC_Field_Prop_Do(DSAfter_DERIVED_GENDER,SSN5,DID);
  DSAfter_SSN4 := SALT311.MAC_Field_Prop_Do(DSAfter_SSN5,SSN4,DID);
  DSAfter_DOB := SALT311.MAC_Field_Prop_Do(DSAfter_SSN4,DOB,DID);
  DSAfter_PHONE := SALT311.MAC_Field_Prop_Do(DSAfter_DOB,PHONE,DID);
  DSAfter_DL_NBR := SALT311.MAC_Field_Prop_Do(DSAfter_PHONE,DL_NBR,DID);
  DSAfter_SRC := SALT311.MAC_Field_Prop_Do(DSAfter_DL_NBR,SRC,DID);
  ds := PROJECT(DSAfter_SRC,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
Process_xIDL_Layouts().OutputLayout GetResultsSpecific(Process_xIDL_Layouts().InputLayout le,STRING LinkPathName) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 LNAME_len := LENGTH(TRIM(le.LNAME));
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM(le.PRIM_RANGE));
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM(le.PRIM_NAME));
  UNSIGNED1 SSN5_len := LENGTH(TRIM(le.SSN5));
  UNSIGNED1 SSN4_len := LENGTH(TRIM(le.SSN4));
  UNSIGNED1 DL_NBR_len := LENGTH(TRIM(le.DL_NBR));
  In_disableForce := le.disableForce;
  SELF.keys_tried := MAP(
        LinkPathName = 'NAME' =>  + IF (Key_InsuranceHeader_NAME().CanSearch(le),1 << 1,0),
        LinkPathName = 'ADDRESS' =>  + IF (Key_InsuranceHeader_ADDRESS().CanSearch(le),1 << 2,0),
        LinkPathName = 'SSN' =>  + IF (Key_InsuranceHeader_SSN().CanSearch(le),1 << 3,0),
        LinkPathName = 'SSN4' =>  + IF (Key_InsuranceHeader_SSN4().CanSearch(le),1 << 4,0),
        LinkPathName = 'DOB' =>  + IF (Key_InsuranceHeader_DOB().CanSearch(le),1 << 5,0),
        LinkPathName = 'DOBF' =>  + IF (Key_InsuranceHeader_DOBF().CanSearch(le),1 << 6,0),
        LinkPathName = 'ZIP_PR' =>  + IF (Key_InsuranceHeader_ZIP_PR().CanSearch(le),1 << 7,0),
        LinkPathName = 'SRC_RID' =>  + IF (Key_InsuranceHeader_SRC_RID().CanSearch(le),1 << 8,0),
        LinkPathName = 'DLN' =>  + IF (Key_InsuranceHeader_DLN().CanSearch(le),1 << 9,0),
        LinkPathName = 'PH' =>  + IF (Key_InsuranceHeader_PH().CanSearch(le),1 << 10,0),
        LinkPathName = 'LFZ' =>  + IF (Key_InsuranceHeader_LFZ().CanSearch(le),1 << 11,0),
        LinkPathName = 'RELATIVE' =>  + IF (Key_InsuranceHeader_RELATIVE().CanSearch(le),1 << 12,0),
        LinkPathName = 'VIN' =>  + IF (Key_InsuranceHeader_VIN().CanSearch(le),1 << 13,0),0);
  fetchResults := MAP(
        LinkPathName = 'NAME' => IF(Key_InsuranceHeader_NAME().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_NAME().CanSearch(le),Key_InsuranceHeader_NAME(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_CITY := le.CITY,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'ADDRESS' => IF(Key_InsuranceHeader_ADDRESS().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().CanSearch(le),Key_InsuranceHeader_ADDRESS(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_ZIP := le.ZIP_cases,param_SEC_RANGE := le.SEC_RANGE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'SSN' => IF(Key_InsuranceHeader_SSN().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SSN().CanSearch(le),Key_InsuranceHeader_SSN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'SSN4' => IF(Key_InsuranceHeader_SSN4().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().CanSearch(le),Key_InsuranceHeader_SSN4(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'DOB' => IF(Key_InsuranceHeader_DOB().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DOB().CanSearch(le),Key_InsuranceHeader_DOB(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DOB := (UNSIGNED4)le.DOB,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_CITY := le.CITY,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'DOBF' => IF(Key_InsuranceHeader_DOBF().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().CanSearch(le),Key_InsuranceHeader_DOBF(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DOB := (UNSIGNED4)le.DOB,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_ST := le.ST,param_CITY := le.CITY,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_SNAME := le.SNAME,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'ZIP_PR' => IF(Key_InsuranceHeader_ZIP_PR().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().CanSearch(le),Key_InsuranceHeader_ZIP_PR(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_ZIP := le.ZIP_cases,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SEC_RANGE := le.SEC_RANGE,param_CITY := le.CITY,param_ST := le.ST,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'SRC_RID' => IF(Key_InsuranceHeader_SRC_RID().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().CanSearch(le),Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'DLN' => IF(Key_InsuranceHeader_DLN().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_DLN().CanSearch(le),Key_InsuranceHeader_DLN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_DL_NBR := le.DL_NBR,param_DL_NBR_len := DL_NBR_len,param_DL_STATE := le.DL_STATE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'PH' => IF(Key_InsuranceHeader_PH().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_PH().CanSearch(le),Key_InsuranceHeader_PH(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_PHONE := le.PHONE,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_ST := le.ST,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'LFZ' => IF(Key_InsuranceHeader_LFZ().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().CanSearch(le),Key_InsuranceHeader_LFZ(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_ZIP := le.ZIP_cases,param_CITY := le.CITY,param_PRIM_RANGE := le.PRIM_RANGE,param_PRIM_RANGE_len := PRIM_RANGE_len,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_NAME_len := PRIM_NAME_len,param_SSN5 := le.SSN5,param_SSN5_len := SSN5_len,param_SSN4 := le.SSN4,param_SSN4_len := SSN4_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SEC_RANGE := le.SEC_RANGE,param_SNAME := le.SNAME,param_DOB := (UNSIGNED4)le.DOB,param_ST := le.ST,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'RELATIVE' => IF(Key_InsuranceHeader_RELATIVE().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().CanSearch(le),Key_InsuranceHeader_RELATIVE(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_fname2 := le.fname2,param_lname2 := le.lname2,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),
        LinkPathName = 'VIN' => IF(Key_InsuranceHeader_VIN().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_VIN().CanSearch(le),Key_InsuranceHeader_VIN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch(param_VIN := le.VIN,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_disableForce := In_disableForce)),DID),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),DATASET([],Process_xIDL_Layouts().LayoutScoredFetch));
  SELF.Results := PROJECT(CHOOSEN(fetchResults, le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_xIDL_Layouts().MAC_Add_ResolutionFlags()
  SELF := le;
END;
  EXPORT DirectDIDFetch(STRING LpName):= PROJECT(in(Entered_RID=0 AND Entered_DID=0),GetResultsSpecific(left,LpName),PREFETCH(Config.MeowPrefetch,PARALLEL));
END;
 
