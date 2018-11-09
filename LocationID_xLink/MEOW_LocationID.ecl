IMPORT SALT37;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_LocationID(DATASET(Process_LocationID_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT37.UIDType ButNot=[]) := MODULE
Process_LocationID_Layouts.OutputLayout GetResults(Process_LocationID_Layouts.InputLayout le) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 predir_len := LENGTH(TRIM(le.predir));
  UNSIGNED1 prim_name_len := LENGTH(TRIM(le.prim_name));
  UNSIGNED1 addr_suffix_len := LENGTH(TRIM(le.addr_suffix));
  UNSIGNED1 postdir_len := LENGTH(TRIM(le.postdir));
  UNSIGNED1 unit_desig_len := LENGTH(TRIM(le.unit_desig));
  UNSIGNED1 v_city_name_len := LENGTH(TRIM(le.v_city_name));
  SELF.keys_tried := IF (Key_LocationId_STATECITY.CanSearch(le),1 << 1,0) + IF (Key_LocationId_ZIP.CanSearch(le),1 << 2,0);
  fetchResults := TOPN(ROLLUP(IF ( Process_LocationID_Layouts.HardKeyMatch(le) ,
    MERGE(
    SORTED(Key_LocationId_STATECITY.ScoredLocIdFetch(param_v_city_name := le.v_city_name,param_v_city_name_len := v_city_name_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_sec_range := le.sec_range,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_predir := le.predir,param_predir_len := predir_len),LocId)
    ,SORTED(Key_LocationId_ZIP.ScoredLocIdFetch(param_zip5 := le.zip5,param_prim_range := le.prim_range,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_sec_range := le.sec_range,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_predir := le.predir,param_predir_len := predir_len),LocId),SORTED(LocId)) /* Merged */
    ,SORTED(Key_LocationId_.ScoredLocIdFetch(param_prim_range := le.prim_range,param_predir := le.predir,param_predir_len := predir_len,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_sec_range := le.sec_range,param_v_city_name := le.v_city_name,param_v_city_name_len := v_city_name_len,param_st := le.st,param_zip5 := le.zip5),LocId)) /* IF */ 
 
    , RIGHT.LocId > 0 AND LEFT.LocId = RIGHT.LocId, Process_LocationID_Layouts.Combine_Scores(LEFT,RIGHT))(LocId NOT IN ButNot),le.MaxIDs + 1,-Weight)(SALT37.DebugMode OR ~ForceFailed OR ButNot<>[]); // Warning - is a fetch to keys etc
  SELF.Results := CHOOSEN(fetchResults, le.MaxIDs);
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_LocationID_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_rid=0 AND Entered_LocId=0),GetResults(left),PREFETCH(_CFG.MeowPrefetch,PARALLEL));
  Process_LocationID_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, LocId )
    , RIGHT.LocId > 0 AND LEFT.LocId = RIGHT.LocId, Process_LocationID_Layouts.Combine_Scores(LEFT,RIGHT))(LocId NOT IN ButNot),le.MaxIds + 1,-Weight);
    SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
    SELF.IsTruncated := COUNT(mergedResults) > le.MaxIds;
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR20 := IF ( MultiRec, RR1, RR0 );
  Process_LocationID_Layouts.OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
    SELF.Results := UNGROUP(Process_LocationID_Layouts.AdjustScoresForNonExactMatches(le.Results));
    SELF := le;
  END;
  RR2 := PROJECT(RR20,AdjustScores(LEFT));
  Process_LocationID_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT37.MAC_External_AddPcnt(RR3,Process_LocationID_Layouts.LayoutScoredFetch,Results,Process_LocationID_Layouts.OutputLayout,27,RR4);
EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the LocId on them
  process_LocationID_layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := _CFG.MatchThreshold; // Assume at least 'threshold' met
    SELF.IsTruncated := FALSE;
    SELF.LocId := le.Entered_LocId;
    SELF.rid := le.Entered_rid;
  END;
  SHARED pass_thru := PROJECT(in(~(Entered_rid=0 AND Entered_LocId=0)),ptt(LEFT));
// Transform to process 'real' results
  process_LocationID_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := le.IsTruncated;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results0 := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER));
  EXPORT Uid_Results := Uid_Results0+pass_thru;
  EXPORT Raw_Data := process_LocationID_layouts.Fetch_Stream_Expanded(Uid_Results);
 
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_prim_range;
      INTEGER2 Match_predir;
      INTEGER2 Match_prim_name;
      INTEGER2 Match_addr_suffix;
      INTEGER2 Match_postdir;
      INTEGER2 Match_unit_desig;
      INTEGER2 Match_sec_range;
      INTEGER2 Match_v_city_name;
      INTEGER2 Match_st;
      INTEGER2 Match_zip5;
    END;
    IMPORT SALT37;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_prim_range := MAP ( ri.prim_range = (TYPEOF(ri.prim_range))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.prim_range = (TYPEOF(ri.prim_range))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.prim_range = le.prim_range => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_predir := MAP ( ri.predir = (TYPEOF(ri.predir))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.predir = (TYPEOF(ri.predir))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.predir = le.predir => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.predir,0,ri.predir,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_prim_name := MAP ( ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.prim_name = (TYPEOF(ri.prim_name))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.prim_name = le.prim_name => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.prim_name,0,ri.prim_name,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_addr_suffix := MAP ( ri.addr_suffix = (TYPEOF(ri.addr_suffix))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.addr_suffix = (TYPEOF(ri.addr_suffix))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.addr_suffix = le.addr_suffix => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.addr_suffix,0,ri.addr_suffix,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_postdir := MAP ( ri.postdir = (TYPEOF(ri.postdir))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.postdir = (TYPEOF(ri.postdir))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.postdir = le.postdir => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.postdir,0,ri.postdir,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_unit_desig := MAP ( ri.unit_desig = (TYPEOF(ri.unit_desig))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.unit_desig = (TYPEOF(ri.unit_desig))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.unit_desig = le.unit_desig => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.unit_desig,0,ri.unit_desig,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_sec_range := MAP ( ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.sec_range = (TYPEOF(ri.sec_range))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.sec_range = le.sec_range => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_v_city_name := MAP ( ri.v_city_name = (TYPEOF(ri.v_city_name))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.v_city_name = (TYPEOF(ri.v_city_name))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.v_city_name = le.v_city_name => SALT37.HeaderSearchMatchCode.Match,_CFG.WithinEditN(le.v_city_name,0,ri.v_city_name,0,1, 0) => SALT37.HeaderSearchMatchCode.FuzzyMatch,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_st := MAP ( ri.st = (TYPEOF(ri.st))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.st = (TYPEOF(ri.st))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.st = le.st => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
    SELF.Match_zip5 := MAP ( ri.zip5 = (TYPEOF(ri.zip5))'' => SALT37.HeaderSearchMatchCode.NoSearchCriteria, le.zip5 = (TYPEOF(ri.zip5))'' => SALT37.HeaderSearchMatchCode.BlankField, ri.zip5 = le.zip5 => SALT37.HeaderSearchMatchCode.Match,SALT37.HeaderSearchMatchCode.NoMatch);
      SELF.Record_Score := SELF.Match_prim_range + SELF.Match_predir + SELF.Match_prim_name + SELF.Match_addr_suffix + SELF.Match_postdir + SELF.Match_unit_desig + SELF.Match_sec_range + SELF.Match_v_city_name + SELF.Match_st + SELF.Match_zip5;
      SELF.Is_FullMatch := SELF.Match_prim_range>=0 AND SELF.Match_predir>=0 AND SELF.Match_prim_name>=0 AND SELF.Match_addr_suffix>=0 AND SELF.Match_postdir>=0 AND SELF.Match_unit_desig>=0 AND SELF.Match_sec_range>=0 AND SELF.Match_v_city_name>=0 AND SELF.Match_st>=0 AND SELF.Match_zip5>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.LocId=ri.LocId AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
 
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,LocId,-(Record_Score+Weight-W1)),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_LocationID_Layouts.InputLayout tr(Raw_Data le) := TRANSFORM
  SELF.Entered_rid := 0;
    SELF.Entered_LocId := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  ds := PROJECT(Raw_Data,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
Process_LocationID_Layouts.OutputLayout GetResultsSpecific(Process_LocationID_Layouts.InputLayout le,STRING LinkPathName) := TRANSFORM
// Need to calculate lengths for EDIT fields
  UNSIGNED1 predir_len := LENGTH(TRIM(le.predir));
  UNSIGNED1 prim_name_len := LENGTH(TRIM(le.prim_name));
  UNSIGNED1 addr_suffix_len := LENGTH(TRIM(le.addr_suffix));
  UNSIGNED1 postdir_len := LENGTH(TRIM(le.postdir));
  UNSIGNED1 unit_desig_len := LENGTH(TRIM(le.unit_desig));
  UNSIGNED1 v_city_name_len := LENGTH(TRIM(le.v_city_name));
  SELF.keys_tried := MAP(
        LinkPathName = 'STATECITY' =>  + IF (Key_LocationId_STATECITY.CanSearch(le),1 << 1,0),
        LinkPathName = 'ZIP' =>  + IF (Key_LocationId_ZIP.CanSearch(le),1 << 2,0),0);
  fetchResults := MAP(
        LinkPathName = 'STATECITY' => IF(Key_LocationId_STATECITY.CanSearch(le),SORTED(Key_LocationId_STATECITY.ScoredLocIdFetch(param_v_city_name := le.v_city_name,param_v_city_name_len := v_city_name_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_sec_range := le.sec_range,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_predir := le.predir,param_predir_len := predir_len),LocId),DATASET([],Process_LocationID_Layouts.LayoutScoredFetch)),
        LinkPathName = 'ZIP' => IF(Key_LocationId_ZIP.CanSearch(le),SORTED(Key_LocationId_ZIP.ScoredLocIdFetch(param_zip5 := le.zip5,param_prim_range := le.prim_range,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_sec_range := le.sec_range,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_predir := le.predir,param_predir_len := predir_len),LocId),DATASET([],Process_LocationID_Layouts.LayoutScoredFetch)),
    SORTED(Key_LocationId_.ScoredLocIdFetch(param_prim_range := le.prim_range,param_predir := le.predir,param_predir_len := predir_len,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_addr_suffix := le.addr_suffix,param_addr_suffix_len := addr_suffix_len,param_postdir := le.postdir,param_postdir_len := postdir_len,param_unit_desig := le.unit_desig,param_unit_desig_len := unit_desig_len,param_sec_range := le.sec_range,param_v_city_name := le.v_city_name,param_v_city_name_len := v_city_name_len,param_st := le.st,param_zip5 := le.zip5),LocId));
  SELF.Results := CHOOSEN(fetchResults, le.MaxIDs);
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  Process_LocationID_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  EXPORT DirectLocIdFetch(STRING LpName):= PROJECT(in(Entered_rid=0 AND Entered_LocId=0),GetResultsSpecific(left,LpName),PREFETCH(_CFG.MeowPrefetch,PARALLEL));
END;
 
