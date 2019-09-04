// Begin code to perform the matching itself
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT30,ut,std;
EXPORT matches(DATASET(layout_EmpID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED ih_thin := TABLE(ih,{ultid,orgid,seleid,empid,rcid}); // HACK
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.EmpID1 := le.EmpID;
  SELF.EmpID2 := ri.EmpID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT30.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  INTEGER2 contact_did_score_temp := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  INTEGER2 cname_devanitize_score_temp := MAP(
                        le.cname_devanitize_isnull OR ri.cname_devanitize_isnull OR le.cname_devanitize_weight100 = 0 => 0,
                        le.cname_devanitize = ri.cname_devanitize  => le.cname_devanitize_weight100,
                        SALT30.MatchBagOfWords(le.cname_devanitize,ri.cname_devanitize,2128912,1));
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT30.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT30.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT30.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 contact_ssn_score_temp := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 lname_score := IF ( lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 contact_did_score := IF ( contact_did_score_temp >= Config.contact_did_Force * 100, contact_did_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cname_devanitize_score := IF ( cname_devanitize_score_temp > Config.cname_devanitize_Force * 100, cname_devanitize_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := IF ( fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 contact_ssn_score := IF ( contact_ssn_score_temp >= Config.contact_ssn_Force * 100, contact_ssn_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +MAX(le.cname_devanitize_prop,ri.cname_devanitize_prop)*cname_devanitize_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (prim_range_score + prim_name_score + lname_score + contact_phone_score + contact_did_score + cname_devanitize_score + zip_score + fname_score + contact_ssn_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':prim_range:prim_name:lname','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:prim_range(13):prim_name(15):lname(15)
 
dn0 := hfile(~prim_name_isnull AND ~lname_isnull);
dn0_deduped := dn0(prim_range_weight100 + prim_name_weight100 + lname_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.EmpID > RIGHT.EmpID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.lname_isnull AND ~right.lname_isnull ) AND ( left.contact_did = right.contact_did OR left.contact_did_isnull OR right.contact_did_isnull ) AND ( ~left.cname_devanitize_isnull AND ~right.cname_devanitize_isnull ) AND ( ~left.fname_isnull AND ~right.fname_isnull ) AND ( left.contact_ssn = right.contact_ssn OR left.contact_ssn_isnull OR right.contact_ssn_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname,10000),HASH);
last_mjs_t :=mj0;
SALT30.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
RETURN o;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and EmpID
BIPV2_Tools.mac_avoid_transitives(All_Matches,EmpID1,EmpID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::mt',EXPIRE(Config.PersistExpire));
SALT30.mac_get_BestPerRecord( All_Matches,rcid1,EmpID1,rcid2,EmpID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{EmpID, InCluster := COUNT(GROUP)},EmpID,MERGE)(InCluster>1000); // EmpID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.EmpID=RIGHT.EmpID,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.EmpID=RIGHT.EmpID AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT30.mac_cluster_breadth(in_matches,rcid1,rcid2,EmpID1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.EmpID1=RIGHT.EmpID,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT30.UIDType rcid;  //Outcast
  SALT30.UIDType EmpID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT30.UIDType Pref_rcid; // Prefers this record
  SALT30.UIDType Pref_EmpID; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.EmpID := le.EmpID1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_EmpID := ri.EmpID2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.EmpID=RIGHT.EmpID1 AND LEFT.Pref_EmpID=RIGHT.EmpID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.EmpID=RIGHT.EmpID2 AND LEFT.Pref_EmpID=RIGHT.EmpID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(EmpID)),EmpID,-Pref_Margin,LOCAL),EmpID,LOCAL)) : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT30.MAC_Avoid_SliceOuts(PossibleMatches,EmpID1,EmpID2,EmpID,Pref_EmpID,ToSlice,m); // If EmpID is slice target - don't use in match
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
ut.MAC_Patch_Id(ih_thin,EmpID,BasicMatch(ih).patch_file,EmpID1,EmpID2,ihbp); // Perform basic matches
SALT30.MAC_SliceOut_ByRID(ihbp,rcid,EmpID,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,EmpID,Matches,EmpID1,EmpID2,o); // Join Clusters
  PatchSeleID := BIPV2_Tools.MAC_MultiParent_Collapse(o,SeleID,EmpID);  // Collapse any SeleID now joined by EmpID
  PatchOrgID := BIPV2_Tools.MAC_MultiParent_Collapse(PatchSeleID,OrgID,SeleID);  // Collapse any OrgID now joined by SeleID
  PatchUltID := BIPV2_Tools.MAC_MultiParent_Collapse(PatchOrgID,UltID,OrgID);  // Collapse any UltID now joined by OrgID
EXPORT Patched_Infile_thin := PatchUltID;
EXPORT Patched_Infile := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,EmpID,Matches,EmpID1,EmpID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT30.UIDType rcid;
    SALT30.UIDType EmpID_before;
    SALT30.UIDType EmpID_after;
    SALT30.UIDType SeleID_before;
    SALT30.UIDType SeleID_after;
    SALT30.UIDType OrgID_before;
    SALT30.UIDType OrgID_after;
    SALT30.UIDType UltID_before;
    SALT30.UIDType UltID_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.EmpID_before := le.EmpID;
    SELF.EmpID_after := ri.EmpID;
    SELF.SeleID_before := le.SeleID;
    SELF.SeleID_after := ri.SeleID;
    SELF.OrgID_before := le.OrgID;
    SELF.OrgID_after := ri.OrgID;
    SELF.UltID_before := le.UltID;
    SELF.UltID_after := ri.UltID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.EmpID<>RIGHT.EmpID OR LEFT.SeleID<>RIGHT.SeleID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_EMPID_Platform.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_EMPID_Platform.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].EmpID_count - PostIDs.IdCounts[1].EmpID_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;
