// Begin code to perform the matching itself
 
IMPORT SALT37,std;
EXPORT matches(DATASET(layout_LocationId) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LocId1 := le.LocId;
  SELF.LocId2 := ri.LocId;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull OR le.prim_range_weight100 = 0 => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT37.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 v_city_name_score_temp := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull OR le.v_city_name_weight100 = 0 => 0,
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT37.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT37.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  INTEGER2 zip5_score_temp := MAP(
                        le.zip5_isnull OR ri.zip5_isnull OR le.zip5_weight100 = 0 => 0,
                        le.zip5 = ri.zip5  => le.zip5_weight100,
                        SALT37.Fn_Fail_Scale(le.zip5_weight100,s.zip5_switch));
  INTEGER2 cntprimname_score_temp := MAP(
                        le.cntprimname_isnull OR ri.cntprimname_isnull OR le.cntprimname_weight100 = 0 => 0,
                        le.cntprimname = ri.cntprimname  => le.cntprimname_weight100,
                        PrimNameCount((UNSIGNED8)le.cntprimname,ri.cntprimname) => SALT37.MOD_NonZero.AVENZ(le.cntprimname_weight100,ri.cntprimname_weight100),
                        SALT37.Fn_Fail_Scale(le.cntprimname_weight100,s.cntprimname_switch));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range OR SALT37.HyphenMatch(le.sec_range,ri.sec_range,1)<=1  => MIN(le.sec_range_weight100,ri.sec_range_weight100),
                        SALT37.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  INTEGER2 postdir_score_temp := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT37.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  INTEGER2 predir_score_temp := MAP(
                        le.predir_isnull OR ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT37.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  INTEGER2 prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name OR SALT37.HyphenMatch(le.prim_name,ri.prim_name,1)<=1  => MIN(le.prim_name_weight100,ri.prim_name_weight100),
                        Config.WithinEditN(le.prim_name,le.prim_name_len,ri.prim_name,ri.prim_name_len,1,0) =>  SALT37.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        PrimNameMatch((STRING28)le.prim_name,ri.prim_name) => SALT37.MOD_NonZero.AVENZ(le.prim_name_weight100,ri.prim_name_weight100),
                        SALT37.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 err_stat_score_temp := MAP(
                        le.err_stat_isnull OR ri.err_stat_isnull => 0,
                        le.err_stat = ri.err_stat  => le.err_stat_weight100,
                        CustomErrStat((STRING4)le.err_stat,ri.err_stat) => SALT37.MOD_NonZero.AVENZ(le.err_stat_weight100,ri.err_stat_weight100),
                        SALT37.Fn_Fail_Scale(le.err_stat_weight100,s.err_stat_switch));
  INTEGER2 addr_suffix_score_temp := MAP(
                        le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT37.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp > Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 v_city_name_score := IF ( v_city_name_score_temp > Config.v_city_name_Force * 100, v_city_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > Config.st_Force * 100, st_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 zip5_score := IF ( zip5_score_temp > Config.zip5_Force * 100, zip5_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 postdir_score := IF ( postdir_score_temp >= Config.postdir_Force * 100, postdir_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 predir_score := IF ( predir_score_temp >= Config.predir_Force * 100, predir_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 err_stat_score := IF ( err_stat_score_temp >= Config.err_stat_Force * 100, err_stat_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 addr_suffix_score := IF ( addr_suffix_score_temp >= Config.addr_suffix_Force * 100, addr_suffix_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cntprimname_score := IF ( cntprimname_score_temp > Config.cntprimname_Force * 100 OR prim_name_score > Config.cntprimname_OR1_prim_name_Force*100, cntprimname_score_temp, SKIP ); // Enforce FORCE parameter
  // Get propagation scores for individual propagated fields
  SELF.Conf_Prop := (0) / 100; // Score based on propogated fields
  iComp := (prim_range_score + v_city_name_score + st_score + zip5_score + cntprimname_score + sec_range_score + postdir_score + predir_score + prim_name_score + err_stat_score + addr_suffix_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-SELF.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':prim_range:v_city_name:st:zip5:cntprimname','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:prim_range(13):v_city_name(7):st(1):zip5(9):cntprimname(10)
 
dn0 := hfile(~prim_range_isnull AND ~v_city_name_isnull AND ~st_isnull AND ~zip5_isnull AND ~cntprimname_isnull);
dn0_deduped := dn0(prim_range_weight100 + v_city_name_weight100 + st_weight100 + zip5_weight100 + cntprimname_weight100>=1900); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.LocId > RIGHT.LocId
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st
    AND LEFT.st = RIGHT.st
    AND LEFT.zip5 = RIGHT.zip5
    AND LEFT.cntprimname = RIGHT.cntprimname
    AND ( ~left.prim_range_isnull AND ~right.prim_range_isnull )
    AND ( ~left.v_city_name_isnull AND ~right.v_city_name_isnull )
    AND ( ~left.st_isnull AND ~right.st_isnull )
    AND ( ~left.zip5_isnull AND ~right.zip5_isnull )
    AND (( ~left.cntprimname_isnull AND ~right.cntprimname_isnull ) OR ( ~left.prim_name_isnull AND ~right.prim_name_isnull ))
    AND ( left.postdir = right.postdir OR left.postdir_isnull OR right.postdir_isnull )
    AND ( left.predir = right.predir OR left.predir_isnull OR right.predir_isnull )
    AND ( left.err_stat = right.err_stat OR left.err_stat_isnull OR right.err_stat_isnull )
    AND ( left.addr_suffix = right.addr_suffix OR left.addr_suffix_isnull OR right.addr_suffix_isnull )
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st
      AND LEFT.st = RIGHT.st
      AND LEFT.zip5 = RIGHT.zip5
      AND LEFT.cntprimname = RIGHT.cntprimname,10000),HASH);
last_mjs_t :=mj0;
SALT37.mac_select_best_matches(last_mjs_t,rid1,rid2,o);
mjs0 := o;
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs; // To by used by rid and LocId
SALT37.mac_avoid_transitives(All_Matches,LocId1,LocId2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o;
SALT37.mac_get_BestPerRecord( All_Matches,rid1,LocId1,rid2,LocId2,o );
EXPORT BestPerRecord := o;
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{LocId, InCluster := COUNT(GROUP)},LocId,LOCAL)(InCluster>1000); // LocId that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.LocId=RIGHT.LocId,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.LocId=RIGHT.LocId AND (>STRING6<)LEFT.rid<>(>STRING6<)RIGHT.rid,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT37.mac_cluster_breadth(in_matches,rid1,rid2,LocId1,o);
SHARED in_matches1 := o;
missed_linkages := JOIN(in_matches1,Specificities(ih).ClusterSizes(InCluster>1),LEFT.LocId1=RIGHT.LocId,RIGHT ONLY,LOCAL);
missed_linkages1 := JOIN(h,missed_linkages,LEFT.LocId=RIGHT.LocId,TRANSFORM(RECORDOF(missed_linkages),SELF.LocId1:=RIGHT.LocId,SELF.rid1:=LEFT.rid,SELF:=RIGHT),LOCAL);
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.LocId1=RIGHT.LocId,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages1;
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT37.UIDType rid;  //Outcast
  SALT37.UIDType LocId;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT37.UIDType Pref_rid; // Prefers this record
  SALT37.UIDType Pref_LocId; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rid := le.rid1;
  self.LocId := le.LocId1;
  self.Closest := le.Closest;
  self.Pref_rid := ri.rid2;
  self.Pref_LocId := ri.LocId2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rid1=RIGHT.rid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.LocId=RIGHT.LocId1 AND LEFT.Pref_LocId=RIGHT.LocId2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.LocId=RIGHT.LocId2 AND LEFT.Pref_LocId=RIGHT.LocId1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.rid=RIGHT.rid,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(LocId)),LocId,-Pref_Margin,LOCAL),LocId,LOCAL));
// 1024x better in new place
  SALT37.MAC_Avoid_SliceOuts(PossibleMatches,LocId1,LocId2,LocId,Pref_LocId,ToSlice,m); // If LocId is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold);
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rid,LocId});
  SALT37.utMAC_Patch_Id(ih_thin,LocId,BasicMatch(ih).patch_file,LocId1,LocId2,ihbp); // Perform basic matches
  SALT37.MAC_SliceOut_ByRID(ihbp,rid,LocId,ToSlice,rid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  SALT37.utMAC_Patch_Id(sliced,LocId,Matches,LocId1,LocId2,o); // Join Clusters
SHARED Patched_Infile_thin := o;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
SALT37.utMAC_Patch_Id(h,LocId,Matches,LocId1,LocId2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rid := le.rid;
    SELF.LocId_before := le.LocId;
    SELF.LocId_after := ri.LocId;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rid = RIGHT.rid AND (LEFT.LocId<>RIGHT.LocId),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := LocationId_iLink.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := LocationId_iLink.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
