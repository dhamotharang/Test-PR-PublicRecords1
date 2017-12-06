EXPORT Process_LocationID_Layouts := MODULE
 
IMPORT SALT37;
SHARED h := File_LocationId;//The input file
 
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::meow';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::meow';
 
EXPORT Key := INDEX(h,{LocId},{h},KeyName_sf); 
EXPORT BuildKey := INDEX(h,{LocId},{h},KeyName);  /* HACK05 */

// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::sup::rid';
 
EXPORT KeyIDHistoryName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::sup::rid';
 
EXPORT AssignCurrentKeyIDHistoryToSuperFile := FileServices.AddSuperFile(KeyIDHistoryName_sf,KeyIDHistoryName);
 
EXPORT ClearKeyIDHistorySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyIDHistoryName_sf,,TRUE),FileServices.ClearSuperFile(KeyIDHistoryName_sf));
  SHARED sIDHist := TABLE(h,{LocId,rid},rid,LocId,MERGE);
 
EXPORT KeyIDHistory := INDEX(sIDHist,{rid},{sIDHist},KeyIDHistoryName_sf);
EXPORT BuildKeyIDHistory := INDEX(sIDHist,{rid},{sIDHist},KeyIDHistoryName);  /* HACK06 */
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(BuildKey, OVERWRITE),BUILDINDEX(BuildKeyIDHistory, OVERWRITE)); /* HACK07 */
EXPORT id_stream_layout := RECORD
    SALT37.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    SALT37.UIDType LocId;
    SALT37.UIDType rid := 0; // Unique record ID for external file
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(rid<>0,LocId=0); // Only record ID supplied
  id_stream_layout Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J_rec := JOIN(C,KeyIDHistory,LEFT.rid=RIGHT.rid,Load(LEFT,RIGHT),LIMIT(_CFG.JoinLimit));
  C0 := id(LocId<>0); // LocId is the minormost element
  id_stream_layout Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rid := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J0 := JOIN(C0,KeyIDHistory,LEFT.LocId=RIGHT.rid,Load0(LEFT,RIGHT),LIMIT(_CFG.JoinLimit));
  RETURN J_rec+J0;
END;
EXPORT Fetch_Stream(DATASET(id_stream_layout) d) := FUNCTION
    k := Key;
    DLayout := RECORD
      id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(id_stream_layout le, k ri) := TRANSFORM
      SELF.did_fetch := ri.LocId<>0;
      SELF.LocId := IF ( SELF.did_fetch, ri.LocId, le.LocId ); // Copy from 'real data' if it exists
      SELF.rid := IF ( SELF.did_fetch, ri.rid, le.rid ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J := JOIN( d,k,(LEFT.LocId = RIGHT.LocId),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(_CFG.JoinLimit)); // Ignore excess records without erroring
    RETURN J;
END;
 
EXPORT Fetch_Stream_Expanded(DATASET(id_stream_layout) d) := FUNCTION
  rd1 := Fetch_Stream(d);
  old := PROJECT(rd1(~did_fetch),id_stream_layout); // Failed to fetch
  renew_candidates := id_stream_historic(old); // See if more recent version of ID is fetchable
  renewed := Fetch_Stream(renew_candidates);
  RETURN rd1(did_fetch OR KeysFailed<>0)+renewed;
END;
 
EXPORT MAC_Fetch_Batch(infile, In_LocId, In_UniqueID, asIndex = TRUE) := FUNCTIONMACRO
  IMPORT SALT37,LocationId_xLink;
  payloadKey := LocationId_xLink.Process_LocationID_Layouts.Key;
  idHistKey := LocationId_xLink.Process_LocationID_Layouts.KeyIDHistory;
  outLayout := RECORD
    infile.In_UniqueID;
    SALT37.UIDType inputLocId;
    RECORDOF(payloadKey);
  END;
  outLayout emptyResult(infile le) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLocId := le.In_LocId;
    SELF := [];
  END;
 
  outLayout xJoinHist(outLayout le, idHistKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLocId := le.inputLocId;
    SELF := ri;
    SELF := [];
  END;
 
  outLayout xJoinPayload(outLayout le, payloadKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputLocId := le.inputLocId;
    SELF := ri;
  END;
 
  infile_emptyResult := PROJECT(infile, emptyResult(LEFT));
  JEntKeyed := JOIN(infile_emptyResult, payloadKey, LEFT.inputLocId = RIGHT.LocId, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JEntPull := JOIN(infile_emptyResult, PULL(payloadKey), LEFT.inputLocId = RIGHT.LocId, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsEnt := IF(asIndex, JEntKeyed, JEntPull);
  resultsEnt_found := resultsEnt(LocId > 0);
  resultsEnt_notfound := resultsEnt(LocId = 0);
 
  JRecKeyed_1 := JOIN(resultsEnt_notfound, idHistKey, LEFT.inputLocId = RIGHT.rid, xJoinHist(LEFT,RIGHT), LEFT OUTER);
  JRecPull_1 := JOIN(resultsEnt_notfound, PULL(idHistKey), LEFT.inputLocId = RIGHT.rid, xJoinHist(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHist := IF(asIndex, JRecKeyed_1, JRecPull_1);
  resultsIDHist_found := resultsIDHist(LocId > 0);
  resultsIDHist_notfound := resultsIDHist(LocId = 0);
 
  JRecKeyed_2 := JOIN(resultsIDHist_found, payloadKey, LEFT.LocId = RIGHT.LocId, xJoinPayload(LEFT,RIGHT), LEFT OUTER);
  JRecPull_2 := JOIN(resultsIDHist_found, PULL(payloadKey), LEFT.LocId = RIGHT.LocId, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH);
 
  resultsIDHistAll := IF(asIndex, JRecKeyed_2, JRecPull_2);
  resultsAll := resultsEnt_found & resultsIDHistAll & PROJECT(resultsIDHist_notfound, TRANSFORM(outLayout, SELF.inputLocId := LEFT.inputLocId, SELF.In_UniqueID := LEFT.In_UniqueID, SELF := []));
 
  RETURN resultsAll;
ENDMACRO;
 
EXPORT InputLayout := RECORD
  SALT37.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  h.prim_range;
  h.predir;
  h.prim_name;
  h.addr_suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip5;
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show LocId if it has a record which fully matches
  SALT37.UIDType Entered_rid := 0; // Allow user to enter rid to pull data
  SALT37.UIDType Entered_LocId := 0; // Allow user to enter LocId to pull data
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.v_city_name <> (TYPEOF(le.v_city_name))'' AND Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name)=0 AND le.st <> (TYPEOF(le.st))'' AND Fields.InValid_st((SALT37.StrType)le.st)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND Fields.InValid_prim_range((SALT37.StrType)le.prim_range)=0 AND le.prim_name <> (TYPEOF(le.prim_name))'' AND Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0 OR le.zip5 <> (TYPEOF(le.zip5))'' AND Fields.InValid_zip5((SALT37.StrType)le.zip5)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND Fields.InValid_prim_range((SALT37.StrType)le.prim_range)=0 AND le.prim_name <> (TYPEOF(le.prim_name))'' AND Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0;
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.LocId;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT37.UIDType Reference := 0;//Presently for batch
  SALT37.UIDType rid := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  INTEGER2 prim_rangeWeight := 0;
  INTEGER1 prim_range_match_code := 0;
  TYPEOF(h.predir) predir := (TYPEOF(h.predir))'';
  INTEGER2 predirWeight := 0;
  INTEGER1 predir_match_code := 0;
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  INTEGER2 prim_nameWeight := 0;
  INTEGER1 prim_name_match_code := 0;
  TYPEOF(h.addr_suffix) addr_suffix := (TYPEOF(h.addr_suffix))'';
  INTEGER2 addr_suffixWeight := 0;
  INTEGER1 addr_suffix_match_code := 0;
  TYPEOF(h.postdir) postdir := (TYPEOF(h.postdir))'';
  INTEGER2 postdirWeight := 0;
  INTEGER1 postdir_match_code := 0;
  TYPEOF(h.unit_desig) unit_desig := (TYPEOF(h.unit_desig))'';
  INTEGER2 unit_desigWeight := 0;
  INTEGER1 unit_desig_match_code := 0;
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  INTEGER2 sec_rangeWeight := 0;
  INTEGER1 sec_range_match_code := 0;
  TYPEOF(h.v_city_name) v_city_name := (TYPEOF(h.v_city_name))'';
  INTEGER2 v_city_nameWeight := 0;
  INTEGER1 v_city_name_match_code := 0;
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  INTEGER2 stWeight := 0;
  INTEGER1 st_match_code := 0;
  TYPEOF(h.zip5) zip5 := (TYPEOF(h.zip5))'';
  INTEGER2 zip5Weight := 0;
  INTEGER1 zip5_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT37.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT37.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  BOOLEAN prim_rangeWeightForcedDown := IF ( isWeightForcedDown(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code),TRUE,FALSE );
  SELF.prim_rangeWeight := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_rangeWeight, ri.prim_rangeWeight );
  SELF.prim_range := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_range, ri.prim_range );
  SELF.prim_range_match_code := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_range_match_code, ri.prim_range_match_code );
  BOOLEAN predirWeightForcedDown := IF ( isWeightForcedDown(le.predirWeight,ri.predirWeight,le.predir_match_code,ri.predir_match_code),TRUE,FALSE );
  SELF.predirWeight := IF ( isLeftWinner(le.predirWeight,ri.predirWeight,le.predir_match_code,ri.predir_match_code ), le.predirWeight, ri.predirWeight );
  SELF.predir := IF ( isLeftWinner(le.predirWeight,ri.predirWeight,le.predir_match_code,ri.predir_match_code ), le.predir, ri.predir );
  SELF.predir_match_code := IF ( isLeftWinner(le.predirWeight,ri.predirWeight,le.predir_match_code,ri.predir_match_code ), le.predir_match_code, ri.predir_match_code );
  BOOLEAN prim_nameWeightForcedDown := IF ( isWeightForcedDown(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code),TRUE,FALSE );
  SELF.prim_nameWeight := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_nameWeight, ri.prim_nameWeight );
  SELF.prim_name := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_name, ri.prim_name );
  SELF.prim_name_match_code := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_name_match_code, ri.prim_name_match_code );
  BOOLEAN addr_suffixWeightForcedDown := IF ( isWeightForcedDown(le.addr_suffixWeight,ri.addr_suffixWeight,le.addr_suffix_match_code,ri.addr_suffix_match_code),TRUE,FALSE );
  SELF.addr_suffixWeight := IF ( isLeftWinner(le.addr_suffixWeight,ri.addr_suffixWeight,le.addr_suffix_match_code,ri.addr_suffix_match_code ), le.addr_suffixWeight, ri.addr_suffixWeight );
  SELF.addr_suffix := IF ( isLeftWinner(le.addr_suffixWeight,ri.addr_suffixWeight,le.addr_suffix_match_code,ri.addr_suffix_match_code ), le.addr_suffix, ri.addr_suffix );
  SELF.addr_suffix_match_code := IF ( isLeftWinner(le.addr_suffixWeight,ri.addr_suffixWeight,le.addr_suffix_match_code,ri.addr_suffix_match_code ), le.addr_suffix_match_code, ri.addr_suffix_match_code );
  BOOLEAN postdirWeightForcedDown := IF ( isWeightForcedDown(le.postdirWeight,ri.postdirWeight,le.postdir_match_code,ri.postdir_match_code),TRUE,FALSE );
  SELF.postdirWeight := IF ( isLeftWinner(le.postdirWeight,ri.postdirWeight,le.postdir_match_code,ri.postdir_match_code ), le.postdirWeight, ri.postdirWeight );
  SELF.postdir := IF ( isLeftWinner(le.postdirWeight,ri.postdirWeight,le.postdir_match_code,ri.postdir_match_code ), le.postdir, ri.postdir );
  SELF.postdir_match_code := IF ( isLeftWinner(le.postdirWeight,ri.postdirWeight,le.postdir_match_code,ri.postdir_match_code ), le.postdir_match_code, ri.postdir_match_code );
  BOOLEAN unit_desigWeightForcedDown := IF ( isWeightForcedDown(le.unit_desigWeight,ri.unit_desigWeight,le.unit_desig_match_code,ri.unit_desig_match_code),TRUE,FALSE );
  SELF.unit_desigWeight := IF ( isLeftWinner(le.unit_desigWeight,ri.unit_desigWeight,le.unit_desig_match_code,ri.unit_desig_match_code ), le.unit_desigWeight, ri.unit_desigWeight );
  SELF.unit_desig := IF ( isLeftWinner(le.unit_desigWeight,ri.unit_desigWeight,le.unit_desig_match_code,ri.unit_desig_match_code ), le.unit_desig, ri.unit_desig );
  SELF.unit_desig_match_code := IF ( isLeftWinner(le.unit_desigWeight,ri.unit_desigWeight,le.unit_desig_match_code,ri.unit_desig_match_code ), le.unit_desig_match_code, ri.unit_desig_match_code );
  BOOLEAN sec_rangeWeightForcedDown := IF ( isWeightForcedDown(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code),TRUE,FALSE );
  SELF.sec_rangeWeight := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_rangeWeight, ri.sec_rangeWeight );
  SELF.sec_range := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_range, ri.sec_range );
  SELF.sec_range_match_code := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_range_match_code, ri.sec_range_match_code );
  BOOLEAN v_city_nameWeightForcedDown := IF ( isWeightForcedDown(le.v_city_nameWeight,ri.v_city_nameWeight,le.v_city_name_match_code,ri.v_city_name_match_code),TRUE,FALSE );
  SELF.v_city_nameWeight := IF ( isLeftWinner(le.v_city_nameWeight,ri.v_city_nameWeight,le.v_city_name_match_code,ri.v_city_name_match_code ), le.v_city_nameWeight, ri.v_city_nameWeight );
  SELF.v_city_name := IF ( isLeftWinner(le.v_city_nameWeight,ri.v_city_nameWeight,le.v_city_name_match_code,ri.v_city_name_match_code ), le.v_city_name, ri.v_city_name );
  SELF.v_city_name_match_code := IF ( isLeftWinner(le.v_city_nameWeight,ri.v_city_nameWeight,le.v_city_name_match_code,ri.v_city_name_match_code ), le.v_city_name_match_code, ri.v_city_name_match_code );
  BOOLEAN stWeightForcedDown := IF ( isWeightForcedDown(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code),TRUE,FALSE );
  SELF.stWeight := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.stWeight, ri.stWeight );
  SELF.st := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st, ri.st );
  SELF.st_match_code := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st_match_code, ri.st_match_code );
  BOOLEAN zip5WeightForcedDown := IF ( isWeightForcedDown(le.zip5Weight,ri.zip5Weight,le.zip5_match_code,ri.zip5_match_code),TRUE,FALSE );
  SELF.zip5Weight := IF ( isLeftWinner(le.zip5Weight,ri.zip5Weight,le.zip5_match_code,ri.zip5_match_code ), le.zip5Weight, ri.zip5Weight );
  SELF.zip5 := IF ( isLeftWinner(le.zip5Weight,ri.zip5Weight,le.zip5_match_code,ri.zip5_match_code ), le.zip5, ri.zip5 );
  SELF.zip5_match_code := IF ( isLeftWinner(le.zip5Weight,ri.zip5Weight,le.zip5_match_code,ri.zip5_match_code ), le.zip5_match_code, ri.zip5_match_code );
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  INTEGER2 Weight := MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.predirWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.addr_suffixWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.v_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zip5Weight);
  SELF.Weight := IF(Weight>0,Weight,MAX(le.Weight,ri.Weight));
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN IsTruncated := FALSE; // more results available than were returned
  BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT37.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-5)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.prim_rangeWeight = 0,'','|'+IF(le.prim_rangeWeight < 0,'-','')+'prim_range')+IF(le.predirWeight = 0,'','|'+IF(le.predirWeight < 0,'-','')+'predir')+IF(le.prim_nameWeight = 0,'','|'+IF(le.prim_nameWeight < 0,'-','')+'prim_name')+IF(le.addr_suffixWeight = 0,'','|'+IF(le.addr_suffixWeight < 0,'-','')+'addr_suffix')+IF(le.postdirWeight = 0,'','|'+IF(le.postdirWeight < 0,'-','')+'postdir')+IF(le.unit_desigWeight = 0,'','|'+IF(le.unit_desigWeight < 0,'-','')+'unit_desig')+IF(le.sec_rangeWeight = 0,'','|'+IF(le.sec_rangeWeight < 0,'-','')+'sec_range')+IF(le.v_city_nameWeight = 0,'','|'+IF(le.v_city_nameWeight < 0,'-','')+'v_city_name')+IF(le.stWeight = 0,'','|'+IF(le.stWeight < 0,'-','')+'st')+IF(le.zip5Weight = 0,'','|'+IF(le.zip5Weight < 0,'-','')+'zip5');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  prim_rangeWeight := MAX(GROUP,IF( in_data.prim_range_match_code=SALT37.MatchCode.ExactMatch, in_data.prim_rangeWeight,0 ));
  predirWeight := MAX(GROUP,IF( in_data.predir_match_code=SALT37.MatchCode.ExactMatch, in_data.predirWeight,0 ));
  prim_nameWeight := MAX(GROUP,IF( in_data.prim_name_match_code=SALT37.MatchCode.ExactMatch, in_data.prim_nameWeight,0 ));
  addr_suffixWeight := MAX(GROUP,IF( in_data.addr_suffix_match_code=SALT37.MatchCode.ExactMatch, in_data.addr_suffixWeight,0 ));
  postdirWeight := MAX(GROUP,IF( in_data.postdir_match_code=SALT37.MatchCode.ExactMatch, in_data.postdirWeight,0 ));
  unit_desigWeight := MAX(GROUP,IF( in_data.unit_desig_match_code=SALT37.MatchCode.ExactMatch, in_data.unit_desigWeight,0 ));
  sec_rangeWeight := MAX(GROUP,IF( in_data.sec_range_match_code=SALT37.MatchCode.ExactMatch, in_data.sec_rangeWeight,0 ));
  v_city_nameWeight := MAX(GROUP,IF( in_data.v_city_name_match_code=SALT37.MatchCode.ExactMatch, in_data.v_city_nameWeight,0 ));
  stWeight := MAX(GROUP,IF( in_data.st_match_code=SALT37.MatchCode.ExactMatch, in_data.stWeight,0 ));
  zip5Weight := MAX(GROUP,IF( in_data.zip5_match_code=SALT37.MatchCode.ExactMatch, in_data.zip5Weight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.prim_rangeWeight := MAP( ri.prim_rangeWeight=0 OR le.prim_range_match_code=SALT37.MatchCode.ExactMatch => le.prim_rangeWeight,MIN(le.prim_rangeWeight,ri.prim_rangeWeight-1) );
  SELF.predirWeight := MAP( ri.predirWeight=0 OR le.predir_match_code=SALT37.MatchCode.ExactMatch => le.predirWeight,MIN(le.predirWeight,ri.predirWeight-1) );
  SELF.prim_nameWeight := MAP( ri.prim_nameWeight=0 OR le.prim_name_match_code=SALT37.MatchCode.ExactMatch => le.prim_nameWeight,MIN(le.prim_nameWeight,ri.prim_nameWeight-1) );
  SELF.addr_suffixWeight := MAP( ri.addr_suffixWeight=0 OR le.addr_suffix_match_code=SALT37.MatchCode.ExactMatch => le.addr_suffixWeight,MIN(le.addr_suffixWeight,ri.addr_suffixWeight-1) );
  SELF.postdirWeight := MAP( ri.postdirWeight=0 OR le.postdir_match_code=SALT37.MatchCode.ExactMatch => le.postdirWeight,MIN(le.postdirWeight,ri.postdirWeight-1) );
  SELF.unit_desigWeight := MAP( ri.unit_desigWeight=0 OR le.unit_desig_match_code=SALT37.MatchCode.ExactMatch => le.unit_desigWeight,MIN(le.unit_desigWeight,ri.unit_desigWeight-1) );
  SELF.sec_rangeWeight := MAP( ri.sec_rangeWeight=0 OR le.sec_range_match_code=SALT37.MatchCode.ExactMatch => le.sec_rangeWeight,MIN(le.sec_rangeWeight,ri.sec_rangeWeight-1) );
  SELF.v_city_nameWeight := MAP( ri.v_city_nameWeight=0 OR le.v_city_name_match_code=SALT37.MatchCode.ExactMatch => le.v_city_nameWeight,MIN(le.v_city_nameWeight,ri.v_city_nameWeight-1) );
  SELF.stWeight := MAP( ri.stWeight=0 OR le.st_match_code=SALT37.MatchCode.ExactMatch => le.stWeight,MIN(le.stWeight,ri.stWeight-1) );
  SELF.zip5Weight := MAP( ri.zip5Weight=0 OR le.zip5_match_code=SALT37.MatchCode.ExactMatch => le.zip5Weight,MIN(le.zip5Weight,ri.zip5Weight-1) );
  INTEGER2 Weight := MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.predirWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.addr_suffixWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.v_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zip5Weight);
  SELF.Weight := IF(Weight>0,Weight,MAX(0,le.Weight));
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,LocId);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),LocId),LEFT.LocId=RIGHT.LocId,Combine_Scores(LEFT,RIGHT))(SALT37.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT37.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,27,R3);
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, LocId, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, LocId, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(_CFG.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'STATECITY,','') + IF(k&(1<<2)<>0,'ZIP,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT37.UIDType LocId;
  DATASET(SALT37.Layout_FieldValueList) prim_range_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) predir_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) prim_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) addr_suffix_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) postdir_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) sec_range_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) st_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) zip5_Values := DATASET([],SALT37.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LocId := le.LocId;
    SELF.prim_range_values := SALT37.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.predir_values := SALT37.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
    SELF.prim_name_values := SALT37.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.addr_suffix_values := SALT37.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
    SELF.postdir_values := SALT37.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
    SELF.unit_desig_values := SALT37.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
    SELF.sec_range_values := SALT37.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.v_city_name_values := SALT37.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
    SELF.st_values := SALT37.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip5_values := SALT37.fn_combine_fieldvaluelist(le.zip5_values,ri.zip5_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(LocId) ), LocId, LOCAL ), LEFT.LocId = RIGHT.LocId, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.LocId := le.LocId;
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.predir_values := SORT(le.predir_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.addr_suffix_values := SORT(le.addr_suffix_values, -cnt, val, LOCAL);
    SELF.postdir_values := SORT(le.postdir_values, -cnt, val, LOCAL);
    SELF.unit_desig_values := SORT(le.unit_desig_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.v_city_name_values := SORT(le.v_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip5_values := SORT(le.zip5_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LocId := le.LocId;
  SELF.prim_range_Values := IF ( (SALT37.StrType)le.prim_range = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_range)}],SALT37.Layout_FieldValueList));
  SELF.predir_Values := IF ( (SALT37.StrType)le.predir = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.predir)}],SALT37.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( (SALT37.StrType)le.prim_name = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_name)}],SALT37.Layout_FieldValueList));
  SELF.addr_suffix_Values := IF ( (SALT37.StrType)le.addr_suffix = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.addr_suffix)}],SALT37.Layout_FieldValueList));
  SELF.postdir_Values := IF ( (SALT37.StrType)le.postdir = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.postdir)}],SALT37.Layout_FieldValueList));
  SELF.unit_desig_Values := IF ( (SALT37.StrType)le.unit_desig = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.unit_desig)}],SALT37.Layout_FieldValueList));
  SELF.sec_range_Values := IF ( (SALT37.StrType)le.sec_range = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.sec_range)}],SALT37.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( (SALT37.StrType)le.v_city_name = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.v_city_name)}],SALT37.Layout_FieldValueList));
  SELF.st_Values := IF ( (SALT37.StrType)le.st = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.st)}],SALT37.Layout_FieldValueList));
  SELF.zip5_Values := IF ( (SALT37.StrType)le.zip5 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.zip5)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
// Records which already had the LocId on them may not be up to date. Update those IDs
EXPORT UpdateIDs(DATASET(InputLayout) in) := FUNCTION
  id_stream_layout init(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := _CFG.MatchThreshold; // Assume at least 'threshold' met
    SELF.LocId := le.Entered_LocId;
    SELF.rid := le.Entered_rid;
  END;
  idupdate_candidates := PROJECT(in,init(LEFT));
  ids_updated0 := id_stream_historic(idupdate_candidates);
  ids_updated := PROJECT(ids_updated0,TRANSFORM(LayoutScoredFetch,SELF.Reference:=LEFT.UniqueId,SELF.keys_used:=0,SELF.keys_failed:=0,SELF:=LEFT));
  RETURN CombineLinkpathScores(ids_updated);
END;
END;
