// Begin code to perform the matching itself
 
IMPORT SALT27,ut,std;
EXPORT matches(DATASET(layout_POWID_Down) ih,UNSIGNED MatchThreshold = 38) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 orgid_score_temp := MAP(                         le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT27.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.addr1_weight100 + ri.addr1_weight100 + le.csz_weight100 + ri.csz_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 orgid_score := IF ( orgid_score_temp >= 0, orgid_score_temp, SKIP ); // Enforce FORCE parameter
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score_temp := MAP(                         addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_score_temp := MAP( le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT27.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT27.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= 0 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > 0 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > 0 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := MAX(csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(address_score_pre,0);// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  INTEGER2 csz_score := IF ( csz_score_ext > -200,csz_score_res,SKIP);
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := MAX(addr1_score_pre,0) + prim_range_score + prim_name_score + MAX(address_score_pre,0);// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  INTEGER2 addr1_score := addr1_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := MAX(address_score_pre,0)+ addr1_score + prim_range_score + prim_name_score+ csz_score + v_city_name_score + st_score + zip_score;// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := IF ( address_score_ext > 0,address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,addr1_score*(0+if(le.prim_name_prop+ri.prim_name_prop>0,1,0))/2,0)
    +if(le.address_prop+ri.address_prop>0,address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,1,0))/2,0)
  ) / 100; // Score based on propogated fields
  iComp := (orgid_score + MAX(address_score,MAX(addr1_score,prim_range_score + prim_name_score) + MAX(csz_score,v_city_name_score + st_score + zip_score))) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':orgid:prim_range:prim_name:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
 
//Fixed fields ->:orgid(28):prim_range(13):prim_name(14):st(5)
 
dn0 := h(~prim_name_isnull AND ~st_isnull);
dn0_deduped := dn0(orgid_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.POWID > RIGHT.POWID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.orgid = RIGHT.orgid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.orgid = RIGHT.orgid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st,10000),HASH);
last_mjs_t :=mj0;
SALT27.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs := o;
export All_Matches := all_mjs : PERSIST('~temp::BIPV2_POWID_DOWN_Platform_POWID_POWID_Down_all_m'); // To by used by rcid and POWID
import bipv2_tools;
BIPV2_Tools.mac_avoid_transitives(All_Matches,POWID1,POWID2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : PERSIST('~temp::BIPV2_POWID_DOWN_Platform_POWID_POWID_Down_mt');
SALT27.mac_get_BestPerRecord( All_Matches,rcid1,POWID1,rcid2,POWID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::BIPV2_POWID_DOWN_Platform_POWID_POWID_Down_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // POWID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.POWID=RIGHT.POWID,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.POWID=RIGHT.POWID AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(Parallel_Match));
SALT27.mac_cluster_breadth(in_matches,rcid1,rcid2,POWID1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.POWID1=RIGHT.POWID,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::BIPV2_POWID_DOWN_Platform_POWID_POWID_Down_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT27.UIDType rcid;  //Outcast
  SALT27.UIDType POWID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT27.UIDType Pref_rcid; // Prefers this record
  SALT27.UIDType Pref_POWID; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.POWID := le.POWID1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_POWID := ri.POWID2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.POWID=RIGHT.POWID1 AND LEFT.Pref_POWID=RIGHT.POWID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.POWID=RIGHT.POWID2 AND LEFT.Pref_POWID=RIGHT.POWID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(POWID)),POWID,-Pref_Margin,LOCAL),POWID,LOCAL); // 1024x better in new place
SALT27.MAC_Avoid_SliceOuts(PossibleMatches,POWID1,POWID2,POWID,Pref_POWID,ToSlice,m); // If POWID is slice target - don't use in match
EXPORT Matches := m(Conf>=MatchThreshold);
 
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
ut.MAC_Patch_Id(ih,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
SALT27.MAC_SliceOut_ByRID(ihbp,rcid,POWID,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,POWID,Matches,POWID1,POWID2,o); // Join Clusters
EXPORT Patched_Infile := o;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,POWID,Matches,POWID1,POWID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  id_shift_r := RECORD
    SALT27.UIDType rcid;
    SALT27.UIDType POWID_before;
    SALT27.UIDType POWID_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.POWID_before := le.POWID;
    SELF.POWID_after := ri.POWID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreClusters := hygiene(ih).ClusterCounts;
EXPORT PostClusters := hygiene(Patched_Infile).ClusterCounts;
EXPORT PrePatchIdCount := SUM( PreClusters, NumberOfClusters );
EXPORT PostPatchIdCount := SUM( PostClusters, NumberOfClusters );
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rcid,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(POWID=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(POWID>rcid)); // Should be zero
END;
