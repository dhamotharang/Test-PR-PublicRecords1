// Begin code to perform the matching itself
 
IMPORT SALT32,ut,std;
EXPORT matches(DATASET(layout_POWID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 RID_If_Big_Biz_score_temp := MAP(
                        le.RID_If_Big_Biz_isnull OR ri.RID_If_Big_Biz_isnull => 0,
                        le.RID_If_Big_Biz = ri.RID_If_Big_Biz  => le.RID_If_Big_Biz_weight100,
                        SALT32.Fn_Fail_Scale(le.RID_If_Big_Biz_weight100,s.RID_If_Big_Biz_switch));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0));
  INTEGER2 company_name_score_temp := MAP(
                        le.company_name_isnull OR ri.company_name_isnull OR le.company_name_weight100 = 0 => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT32.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT32.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 RID_If_Big_Biz_score := IF ( RID_If_Big_Biz_score_temp >= Config.RID_If_Big_Biz_Force * 100, RID_If_Big_Biz_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, 0 ); // HACK: FORCE only if both company names fail the force test
INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, IF(company_name_score=0,SKIP,0) ); // HACK: FORCE only if both company names fail the force test // Enforce FORCE parameter
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +MAX(le.RID_If_Big_Biz_prop,ri.RID_If_Big_Biz_prop)*RID_If_Big_Biz_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*company_name_score // Score if either field propogated
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (prim_range_score + prim_name_score + RID_If_Big_Biz_score + MAX(company_name_score,cnp_name_score) + zip_score + cnp_number_score) / 100 + outside; // HACK: Change addition to MAX for the two company name scores
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':prim_range:prim_name','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:prim_range(13):prim_name(15)
 
dn0 := hfile(~prim_name_isnull);
dn0_deduped := dn0(prim_range_weight100 + prim_name_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.POWID > RIGHT.POWID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( left.RID_If_Big_Biz = right.RID_If_Big_Biz OR left.RID_If_Big_Biz_isnull OR right.RID_If_Big_Biz_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_name_isnull AND ~right.company_name_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name,10000),HASH);
last_mjs_t :=mj0;
SALT32.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::POWID::BIPV2_POWID_Platform::mj::0',EXPIRE(Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
 
//Now construct candidates based upon attribute & relationship files
 
AllAttrMatches := SORT(Mod_Attr_charter(ih).Match,POWID1,POWID2,Rule,-(Conf+Conf_Prop),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.POWID1=RIGHT.POWID1 AND LEFT.POWID2=RIGHT.POWID2,CombineResults(LEFT,RIGHT),LOCAL);
hd := DISTRIBUTE(h,HASH(POWID));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(POWID2)),hd,LEFT.POWID2=RIGHT.POWID,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(POWID1)),hd,LEFT.POWID1 = RIGHT.POWID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ),match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf),LOCAL); // Will be distributed by DID1
with_attr := attr_match + all_mjs;
all_matches0 := Mod_Attr_charter(ih).ForceFilter(ih,with_attr,POWID1,POWID2); // Restrict to those matches obeying force upon charter
EXPORT All_Matches := all_matches0 : PERSIST('~temp::POWID::BIPV2_POWID_Platform::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and POWID
SALT32.mac_avoid_transitives(All_Matches,POWID1,POWID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::POWID::BIPV2_POWID_Platform::mt',EXPIRE(Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::Matches::Matches',EXPIRE(Config.PersistExpire));
 
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches,All_Attribute_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rcid,POWID,OrgID,UltID});
  ut.MAC_Patch_Id(ih_thin,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
  ut.MAC_Patch_Id(ihbp,POWID,Matches,POWID1,POWID2,o); // Join Clusters
  PatchOrgID := SALT32.MAC_MultiParent_Collapse(o,OrgID,POWID);  // Collapse any OrgID now joined by POWID
  PatchUltID := SALT32.MAC_MultiParent_Collapse(PatchOrgID,UltID,OrgID);  // Collapse any UltID now joined by OrgID
SHARED Patched_Infile_thin := PatchUltID : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR*/);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,POWID,Matches,POWID1,POWID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT32.UIDType rcid;
    SALT32.UIDType POWID_before;
    SALT32.UIDType POWID_after;
    SALT32.UIDType OrgID_before;
    SALT32.UIDType OrgID_after;
    SALT32.UIDType UltID_before;
    SALT32.UIDType UltID_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.POWID_before := le.POWID;
    SELF.POWID_after := ri.POWID;
    SELF.OrgID_before := le.OrgID;
    SELF.OrgID_after := ri.OrgID;
    SELF.UltID_before := le.UltID;
    SELF.UltID_after := ri.UltID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].POWID_cnt - PostIDs.IdCounts[1].POWID_cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) ; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Cnt; // Should be zero
END;
