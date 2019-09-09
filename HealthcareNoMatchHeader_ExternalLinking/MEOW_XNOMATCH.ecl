IMPORT STD, SALT311,HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_XNOMATCH(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
    , DATASET(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout) in
    , BOOLEAN MultiRec = FALSE
    ,SET OF SALT311.UIDType ButNot=[]
  ) := MODULE
Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout GetResults(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout le) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 SSN_len := LENGTH(TRIM(le.SSN));
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 LNAME_len := LENGTH(TRIM(le.LNAME));
  In_disableForce := le.disableForce;
  SELF.keys_tried := IF (Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).CanSearch(le),1 << 1,0);
  fetchResults0 := ROLLUP(IF ( SELF.keys_tried>0,
    SORTED(IF(HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).CanSearch(le),Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).Scorednomatch_idFetch(param_DOB := (UNSIGNED4)le.DOB,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY_NAME := le.CITY_NAME,param_ZIP := le.ZIP,param_ST := le.ST,param_GENDER := le.GENDER,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SSN := le.SSN,param_SSN_len := SSN_len,param_LEXID := le.LEXID,param_SEC_RANGE := le.SEC_RANGE,param_SUFFIX := le.SUFFIX,param_disableForce := In_disableForce)),nomatch_id)
    ,SORTED(Key_HEADER_(pSrc,pVersion,pInfile).Scorednomatch_idFetch(param_SRC := le.SRC,param_SSN := le.SSN,param_SSN_len := SSN_len,param_DOB := (UNSIGNED4)le.DOB,param_LEXID := le.LEXID,param_SUFFIX := le.SUFFIX,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_GENDER := le.GENDER,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_SEC_RANGE := le.SEC_RANGE,param_CITY_NAME := le.CITY_NAME,param_ST := le.ST,param_ZIP := le.ZIP,param_MAINNAME := le.MAINNAME,param_ADDR1 := le.ADDR1,param_LOCALE := le.LOCALE,param_ADDRESS := le.ADDRESS,param_FULLNAME := le.FULLNAME,param_disableForce := In_disableForce),nomatch_id)) /* IF */ 
 
    , RIGHT.nomatch_id > 0 AND LEFT.nomatch_id = RIGHT.nomatch_id, Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).Combine_Scores(LEFT, RIGHT, In_disableForce))((nomatch_id NOT IN ButNot) AND (SALT311.DebugMode OR ~ForceFailed OR ButNot <> [])); // Warning - is a fetch to keys etc
  fetchResults := TOPN(fetchResults0(nomatch_id > 0),le.MaxIDs + 1,-Weight) & fetchResults0(nomatch_id = 0);
  SELF.Results := PROJECT(CHOOSEN(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).AdjustKeysUsedAndFailed(fetchResults), le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_RID=0 AND Entered_nomatch_id=0),GetResults(left),PREFETCH(Config.MeowPrefetch,PARALLEL));
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    In_disableForce := le.disableForce;
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, nomatch_id )
    , RIGHT.nomatch_id > 0 AND LEFT.nomatch_id = RIGHT.nomatch_id, Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).Combine_Scores(LEFT, RIGHT, In_disableForce))((nomatch_id NOT IN ButNot) AND (SALT311.DebugMode OR ~ForceFailed OR ButNot <> [])),le.MaxIds + 1,-Weight);
    SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
    SELF.IsTruncated := ((le.IsTruncated OR ri.IsTruncated) AND COUNT(mergedResults) = le.MaxIds) OR COUNT(mergedResults) > le.MaxIds;
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR20 := IF ( MultiRec, RR1, RR0 );
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
    SELF.Results := UNGROUP(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).AdjustScoresForNonExactMatches(le.Results));
    SELF := le;
  END;
  RR2 := PROJECT(RR20,AdjustScores(LEFT));
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF.IsTruncated := le.IsTruncated AND COUNT(SELF.Results) = le.MaxIds;
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT311.MAC_External_AddPcnt(RR3,Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch,Results,Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout,18,RR4);
  EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the nomatch_id on them
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := FALSE;
    SELF.nomatch_id := le.Entered_nomatch_id;
    SELF.RID := le.Entered_RID;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.Score := 100;
  END;
  SHARED pass_thru := PROJECT(in(~(Entered_RID=0 AND Entered_nomatch_id=0)),ptt(LEFT));
// Transform to process 'real' results
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := le.IsTruncated;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results0 := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER));
  EXPORT Uid_Results := Uid_Results0+pass_thru;
  EXPORT Raw_Data := Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).Fetch_Stream_Expanded(Uid_Results);
 
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_SRC;
      INTEGER2 Match_SSN;
      INTEGER2 Match_DOB;
      INTEGER2 Match_LEXID;
      INTEGER2 Match_SUFFIX;
      INTEGER2 Match_FNAME;
      INTEGER2 Match_MNAME;
      INTEGER2 Match_LNAME;
      INTEGER2 Match_GENDER;
      INTEGER2 Match_PRIM_NAME;
      INTEGER2 Match_PRIM_RANGE;
      INTEGER2 Match_SEC_RANGE;
      INTEGER2 Match_CITY_NAME;
      INTEGER2 Match_ST;
      INTEGER2 Match_ZIP;
      INTEGER2 Match_DT_FIRST_SEEN;
      INTEGER2 Match_DT_LAST_SEEN;
      INTEGER2 Match_MAINNAME;
      INTEGER2 Match_ADDR1;
      INTEGER2 Match_LOCALE;
      INTEGER2 Match_ADDRESS;
      INTEGER2 Match_FULLNAME;
    END;
    IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking,HealthcareNoMatchHeader_Ingest;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_SRC := MAP ( ri.SRC = (TYPEOF(ri.SRC))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SRC = (TYPEOF(ri.SRC))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.SRC = le.SRC => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    SELF.Match_SSN := MAP ( ri.SSN = (TYPEOF(ri.SSN))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SSN = (TYPEOF(ri.SSN))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_SSN(le.SSN,ri.SSN,0,0,FALSE)));
    SELF.Match_DOB := SALT311.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
    SELF.Match_LEXID := MAP ( ri.LEXID = (TYPEOF(ri.LEXID))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.LEXID = (TYPEOF(ri.LEXID))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_LEXID(le.LEXID,ri.LEXID,FALSE)));
    SELF.Match_SUFFIX := MAP ( ri.SUFFIX = (TYPEOF(ri.SUFFIX))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SUFFIX = (TYPEOF(ri.SUFFIX))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_SUFFIX(le.SUFFIX,ri.SUFFIX,FALSE)));
    SELF.Match_FNAME := MAP ( ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_FNAME(le.FNAME,ri.FNAME,0,0,FALSE)));
    SELF.Match_MNAME := MAP ( ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_MNAME(le.MNAME,ri.MNAME,0,0,FALSE)));
    SELF.Match_LNAME := MAP ( ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_LNAME(le.LNAME,ri.LNAME,0,0,FALSE)));
    SELF.Match_GENDER := MAP ( ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.GENDER = (TYPEOF(ri.GENDER))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_GENDER(le.GENDER,ri.GENDER,FALSE)));
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,FALSE)));
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,FALSE)));
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE)));
    SELF.Match_CITY_NAME := MAP ( ri.CITY_NAME = (TYPEOF(ri.CITY_NAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.CITY_NAME = (TYPEOF(ri.CITY_NAME))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_CITY_NAME(le.CITY_NAME,ri.CITY_NAME,FALSE)));
    SELF.Match_ST := MAP ( ri.ST = (TYPEOF(ri.ST))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.ST = (TYPEOF(ri.ST))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_ST(le.ST,ri.ST,FALSE)));
    SELF.Match_ZIP := MAP ( ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.ZIP = (TYPEOF(ri.ZIP))'' => SALT311.HeaderSearchMatchCode.BlankField,SALT311.MatchCode.GroupHeaderSearchCodes(HealthcareNoMatchHeader_InternalLinking.match_methods(pSrc,pVersion,pInfile).match_ZIP(le.ZIP,ri.ZIP,FALSE)));
    SELF.Match_DT_FIRST_SEEN := MAP ( ri.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_FIRST_SEEN = (TYPEOF(ri.DT_FIRST_SEEN))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_FIRST_SEEN = le.DT_FIRST_SEEN => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    SELF.Match_DT_LAST_SEEN := MAP ( ri.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le.DT_LAST_SEEN = (TYPEOF(ri.DT_LAST_SEEN))'' => SALT311.HeaderSearchMatchCode.BlankField,ri.DT_LAST_SEEN = le.DT_LAST_SEEN => SALT311.HeaderSearchMatchCode.Match,SALT311.HeaderSearchMatchCode.NoMatch);
    ri_MAINNAME := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_MAINNAME = (typeof(ri.MAINNAME))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_MAINNAME = le_MAINNAME => SALT311.HeaderSearchMatchCode.Match,SALT311.MatchBagOfWords(le_MAINNAME,ri_MAINNAME,31744,1) > HealthcareNoMatchHeader_ExternalLinking.Config.MAINNAME_Force * 100 => SALT311.HeaderSearchMatchCode.FuzzyMatch, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_ADDR1 := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.ADDR1);//For later scoring
    le_ADDR1 := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME));//For later scoring
    SELF.Match_ADDR1 := MAP ( ri.ADDR1 = (typeof(ri.ADDR1))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_ADDR1 = (typeof(ri.ADDR1))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_ADDR1 = le_ADDR1 => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_LOCALE := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.LOCALE);//For later scoring
    le_LOCALE := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP));//For later scoring
    SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_LOCALE = (typeof(ri.LOCALE))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_LOCALE = le_LOCALE => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_ADDRESS := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.ADDRESS);//For later scoring
    le_ADDRESS := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP));//For later scoring
    SELF.Match_ADDRESS := MAP ( ri.ADDRESS = (typeof(ri.ADDRESS))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_ADDRESS = (typeof(ri.ADDRESS))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_ADDRESS = le_ADDRESS => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
    ri_FULLNAME := SALT311.Fn_WordBag_AppendSpecs_Fake((SALT311.StrType)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT311.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SUFFIX));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => SALT311.HeaderSearchMatchCode.NoSearchCriteria, le_FULLNAME = (typeof(ri.FULLNAME))'' => SALT311.HeaderSearchMatchCode.BlankField, ri_FULLNAME = le_FULLNAME => SALT311.HeaderSearchMatchCode.Match, SALT311.HeaderSearchMatchCode.NoMatch);
      SELF.Record_Score := SELF.Match_SRC + SELF.Match_SSN + SELF.Match_DOB + SELF.Match_LEXID + SELF.Match_SUFFIX + SELF.Match_FNAME + SELF.Match_MNAME + SELF.Match_LNAME + SELF.Match_GENDER + SELF.Match_PRIM_NAME + SELF.Match_PRIM_RANGE + SELF.Match_SEC_RANGE + SELF.Match_CITY_NAME + SELF.Match_ST + SELF.Match_ZIP + SELF.Match_DT_FIRST_SEEN + SELF.Match_DT_LAST_SEEN + SELF.Match_MAINNAME + SELF.Match_ADDR1 + SELF.Match_LOCALE + SELF.Match_ADDRESS + SELF.Match_FULLNAME;
      SELF.Is_FullMatch := SELF.Match_SRC>=0 AND SELF.Match_SSN>=0 AND SELF.Match_DOB>=0 AND SELF.Match_LEXID>=0 AND SELF.Match_SUFFIX>=0 AND SELF.Match_FNAME>=0 AND SELF.Match_MNAME>=0 AND SELF.Match_LNAME>=0 AND SELF.Match_GENDER>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_CITY_NAME>=0 AND SELF.Match_ST>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_DT_FIRST_SEEN>=0 AND SELF.Match_DT_LAST_SEEN>=0 AND SELF.Match_MAINNAME>=0 AND SELF.Match_ADDR1>=0 AND SELF.Match_LOCALE>=0 AND SELF.Match_ADDRESS>=0 AND SELF.Match_FULLNAME>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.nomatch_id=ri.nomatch_id AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
 
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,nomatch_id,-(Record_Score+Weight-W1)),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout tr(Raw_Data le) := TRANSFORM
  SELF.Entered_RID := 0;
    SELF.Entered_nomatch_id := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  DSAfter_DOB := SALT311.MAC_Field_Prop_Do(Raw_Data,DOB,nomatch_id);
  DSAfter_LEXID := SALT311.MAC_Field_Prop_Do(DSAfter_DOB,LEXID,nomatch_id);
  DSAfter_SUFFIX := SALT311.MAC_Field_Prop_Do(DSAfter_LEXID,SUFFIX,nomatch_id);
  DSAfter_FNAME := SALT311.MAC_Field_Prop_Do(DSAfter_SUFFIX,FNAME,nomatch_id);
  DSAfter_MNAME := SALT311.MAC_Field_Prop_Do(DSAfter_FNAME,MNAME,nomatch_id);
  DSAfter_LNAME := SALT311.MAC_Field_Prop_Do(DSAfter_MNAME,LNAME,nomatch_id);
  ds := PROJECT(DSAfter_LNAME,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).OutputLayout GetResultsSpecific(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout le,STRING LinkPathName) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 SSN_len := LENGTH(TRIM(le.SSN));
  UNSIGNED1 FNAME_len := LENGTH(TRIM(le.FNAME));
  UNSIGNED1 MNAME_len := LENGTH(TRIM(le.MNAME));
  UNSIGNED1 LNAME_len := LENGTH(TRIM(le.LNAME));
  In_disableForce := le.disableForce;
  SELF.keys_tried := MAP(
        LinkPathName = 'NOMATCH' =>  + IF (Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).CanSearch(le),1 << 1,0),0);
  fetchResults := MAP(
        LinkPathName = 'NOMATCH' => IF(Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).CanSearch(le),SORTED(IF(HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).CanSearch(le),Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).Scorednomatch_idFetch(param_DOB := (UNSIGNED4)le.DOB,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_CITY_NAME := le.CITY_NAME,param_ZIP := le.ZIP,param_ST := le.ST,param_GENDER := le.GENDER,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_SSN := le.SSN,param_SSN_len := SSN_len,param_LEXID := le.LEXID,param_SEC_RANGE := le.SEC_RANGE,param_SUFFIX := le.SUFFIX,param_disableForce := In_disableForce)),nomatch_id),DATASET([],Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch)),
    SORTED(Key_HEADER_(pSrc,pVersion,pInfile).Scorednomatch_idFetch(param_SRC := le.SRC,param_SSN := le.SSN,param_SSN_len := SSN_len,param_DOB := (UNSIGNED4)le.DOB,param_LEXID := le.LEXID,param_SUFFIX := le.SUFFIX,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_MNAME := le.MNAME,param_MNAME_len := MNAME_len,param_LNAME := le.LNAME,param_LNAME_len := LNAME_len,param_GENDER := le.GENDER,param_PRIM_NAME := le.PRIM_NAME,param_PRIM_RANGE := le.PRIM_RANGE,param_SEC_RANGE := le.SEC_RANGE,param_CITY_NAME := le.CITY_NAME,param_ST := le.ST,param_ZIP := le.ZIP,param_MAINNAME := le.MAINNAME,param_ADDR1 := le.ADDR1,param_LOCALE := le.LOCALE,param_ADDRESS := le.ADDRESS,param_FULLNAME := le.FULLNAME,param_disableForce := In_disableForce),nomatch_id));
  SELF.Results := PROJECT(CHOOSEN(fetchResults, le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).MAC_Add_ResolutionFlags()
  SELF := le;
END;
  EXPORT Directnomatch_idFetch(STRING LpName):= PROJECT(in(Entered_RID=0 AND Entered_nomatch_id=0),GetResultsSpecific(left,LpName),PREFETCH(Config.MeowPrefetch,PARALLEL));
END;
 
