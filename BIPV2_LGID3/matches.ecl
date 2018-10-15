// Begin code to perform the matching itself
 
IMPORT SALT30,ut,std;
EXPORT matches(DATASET(layout_LGID3) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED ih_thin := TABLE(ih,{ultid,orgid,seleid,lgid3,proxid,dotid,rcid}); // HACK - slim layout for ut.MAC_Patch_Id, etc later on.

SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED split_patch := LinkBlockers(ih).Patches;
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LGID31 := le.LGID3;
  SELF.LGID32 := ri.LGID3;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 sbfe_id_score := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        SALT30.Fn_Fail_Scale(le.sbfe_id_weight100,s.sbfe_id_switch));
  INTEGER2 Lgid3IfHrchy_score_temp := MAP(
                        le.Lgid3IfHrchy_isnull OR ri.Lgid3IfHrchy_isnull => 0,
                        le.Lgid3IfHrchy = ri.Lgid3IfHrchy  => le.Lgid3IfHrchy_weight100,
                        SALT30.Fn_Fail_Scale(le.Lgid3IfHrchy_weight100,s.Lgid3IfHrchy_switch));
  REAL duns_number_concept_score_scale := ( le.duns_number_concept_weight100 + ri.duns_number_concept_weight100 ) / (le.active_duns_number_weight100 + ri.active_duns_number_weight100 + le.duns_number_weight100 + ri.duns_number_weight100); // Scaling factor for this concept
  INTEGER2 duns_number_concept_score_pre := MAP( (le.duns_number_concept_isnull OR le.active_duns_number_isnull AND le.duns_number_isnull) OR (ri.duns_number_concept_isnull OR ri.active_duns_number_isnull AND ri.duns_number_isnull) => 0,
                        le.duns_number_concept = ri.duns_number_concept  => le.duns_number_concept_weight100,
                        0);
  INTEGER2 company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT30.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT30.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT30.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 company_inc_state_score_temp := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state_weight100 = 0 => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT30.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  INTEGER2 cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 Lgid3IfHrchy_score := IF ( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force * 100, Lgid3IfHrchy_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        0 /* switch0 */)*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  INTEGER2 duns_number_score := MAP(
                        le.duns_number_isnull OR ri.duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.duns_number = ri.duns_number  => le.duns_number_weight100,
                        0 /* switch0 */)*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR ( sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100), cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept duns_number_concept
  INTEGER2 duns_number_concept_score_ext := SALT30.ClipScore(MAX(duns_number_concept_score_pre,0) + active_duns_number_score + duns_number_score);// Score in surrounding context
  INTEGER2 duns_number_concept_score_res := MAX(0,duns_number_concept_score_pre); // At least nothing
  INTEGER2 duns_number_concept_score := duns_number_concept_score_res;
  INTEGER2 company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR ( active_duns_number_score > Config.company_inc_state_OR1_active_duns_number_Force*100) OR ( duns_number_score > Config.company_inc_state_OR2_duns_number_Force*100) OR ( duns_number_concept_score > Config.company_inc_state_OR3_duns_number_concept_Force*100) OR ( company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100) OR ( sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100), company_inc_state_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.Lgid3IfHrchy_prop,ri.Lgid3IfHrchy_prop)*Lgid3IfHrchy_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +MAX(le.duns_number_prop,ri.duns_number_prop)*duns_number_score // Score if either field propogated
    +if(le.duns_number_concept_prop+ri.duns_number_concept_prop>0,duns_number_concept_score*(0+if(le.active_duns_number_prop+ri.active_duns_number_prop>0,1,0)+if(le.duns_number_prop+ri.duns_number_prop>0,1,0))/2,0)
    +MAX(le.company_name_prop,ri.company_name_prop)*company_name_score // Score if either field propogated
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*company_charter_number_score // Score if either field propogated
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*company_inc_state_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (sbfe_id_score + Lgid3IfHrchy_score + IF(duns_number_concept_score>0,MAX(duns_number_concept_score,active_duns_number_score + duns_number_score),active_duns_number_score + duns_number_score) + company_name_score + company_fein_score + company_charter_number_score + cnp_number_score + company_inc_state_score + cnp_btype_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':sbfe_id',
  n = 1 => ':Lgid3IfHrchy',
  n = 2 => ':active_duns_number',
  n = 3 => ':duns_number',
  n = 4 => ':company_name',
  n = 5 => ':company_fein',
  n = 6 => ':company_charter_number'
,n = 100 => ':duns_number'
,n = 101 => ':company_fein'
,'AttributeFile:'+(STRING)(n-10000));

//Now execute each of the 7 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:sbfe_id(27)
 
dn0 := hfile(~sbfe_id_isnull);
dn0_deduped := dn0(sbfe_id_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.sbfe_id = RIGHT.sbfe_id AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.sbfe_id = RIGHT.sbfe_id,10000),HASH);
 
//Fixed fields ->:Lgid3IfHrchy(27)
 
dn1 := hfile(~Lgid3IfHrchy_isnull);
dn1_deduped := dn1(Lgid3IfHrchy_weight100>=500); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.Lgid3IfHrchy = RIGHT.Lgid3IfHrchy AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,1),HINT(unsorted_output),ATMOST(LEFT.Lgid3IfHrchy = RIGHT.Lgid3IfHrchy,10000),HASH);
 
//Fixed fields ->:active_duns_number(27)
 
dn2 := hfile(~active_duns_number_isnull);
dn2_deduped := dn2(active_duns_number_weight100>=500); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.active_duns_number = RIGHT.active_duns_number AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,2),HINT(unsorted_output),ATMOST(LEFT.active_duns_number = RIGHT.active_duns_number,10000),HASH);
 
//Fixed fields ->:duns_number(27)
 
dn3 := hfile(~duns_number_isnull);
dn3_deduped := dn3(duns_number_weight100>=500); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.duns_number = RIGHT.duns_number AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,3),HINT(unsorted_output),ATMOST(LEFT.duns_number = RIGHT.duns_number,10000),HASH);
 
//Fixed fields ->:company_name(26)
 
dn4 := hfile(~company_name_isnull);
dn4_deduped := dn4(company_name_weight100>=500); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.company_name = RIGHT.company_name AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,4),HINT(unsorted_output),ATMOST(LEFT.company_name = RIGHT.company_name,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT30.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::LGID3::BIPV2_LGID3::mj::0',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:company_fein(26)
 
dn5 := hfile(~company_fein_isnull);
dn5_deduped := dn5(company_fein_weight100>=500); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.company_fein = RIGHT.company_fein AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,5),HINT(unsorted_output),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
 
//Fixed fields ->:company_charter_number(26)
 
dn6 := hfile(~company_charter_number_isnull);
dn6_deduped := dn6(company_charter_number_weight100>=500); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.Lgid3IfHrchy = right.Lgid3IfHrchy OR left.Lgid3IfHrchy_isnull OR right.Lgid3IfHrchy_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND (( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.duns_number_isnull AND ~right.duns_number_isnull ) OR ( ~left.duns_number_concept_isnull AND ~right.duns_number_concept_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull )),trans(LEFT,RIGHT,6),HINT(unsorted_output),ATMOST(LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
last_mjs_t :=_mj_extra(hfile,trans) + mj5+mj6;
SALT30.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
RETURN  mjs0 +o;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
//Now construct candidates based upon attribute & relationship files
AllAttrMatches := SORT(Mod_Attr_UnderLinks(ih).Match,LGID31,LGID32,Rule,-(Conf+Conf_Prop),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.LGID31=RIGHT.LGID31 AND LEFT.LGID32=RIGHT.LGID32,CombineResults(LEFT,RIGHT),LOCAL);
hd := DISTRIBUTE(h,HASH(LGID3));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(LGID32)),hd,LEFT.LGID32=RIGHT.LGID3,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(LGID31)),hd,LEFT.LGID31 = RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ),match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf),LOCAL); // Will be distributed by DID1
with_attr := attr_match + all_mjs;
not_blocked := JOIN(with_attr,LinkBlockers(ih).Block,left.LGID31=right.LGID31 and left.LGID32=right.LGID32,TRANSFORM(LEFT),LEFT ONLY, SMART); // Remove all blocked links
EXPORT All_Matches := not_blocked : PERSIST('~temp::LGID3::BIPV2_LGID3::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and LGID3
//  /* HACK - disable default salt mac_avoid_transitives*/
import BIPV2_Tools; /*HACK - import for new transitives macro*/
BIPV2_Tools.mac_avoid_transitives(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o); // HACK - Use new transitives macro*/

EXPORT PossibleMatches := o : PERSIST('~temp::LGID3::BIPV2_LGID3::mt',EXPIRE(Config.PersistExpire));
SALT30.mac_get_BestPerRecord( All_Matches,rcid1,LGID31,rcid2,LGID32,o );
EXPORT BestPerRecord := o : PERSIST('~temp::LGID3::BIPV2_LGID3::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{LGID3, InCluster := COUNT(GROUP)},LGID3,MERGE)(InCluster>1); // LGID3 that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.LGID3=RIGHT.LGID3 AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT30.mac_cluster_breadth(in_matches,rcid1,rcid2,LGID31,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.LGID31=RIGHT.LGID3,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::LGID3::BIPV2_LGID3::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT30.UIDType rcid;  //Outcast
  SALT30.UIDType LGID3;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT30.UIDType Pref_rcid; // Prefers this record
  SALT30.UIDType Pref_LGID3; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.LGID3 := le.LGID31;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_LGID3 := ri.LGID32;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.LGID3=RIGHT.LGID31 AND LEFT.Pref_LGID3=RIGHT.LGID32,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.LGID3=RIGHT.LGID32 AND LEFT.Pref_LGID3=RIGHT.LGID31,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(LGID3)),LGID3,-Pref_Margin,LOCAL),LGID3,LOCAL)) : PERSIST('~temp::LGID3::BIPV2_LGID3::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT30.MAC_Avoid_SliceOuts(PossibleMatches,LGID31,LGID32,LGID3,Pref_LGID3,ToSlice,m); // If LGID3 is slice target - don't use in match
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches,All_Attribute_Matches);
 
//Now actually produce the new file
SALT30.MAC_Reassign_UID(ih_thin,split_patch,LGID3,rcid,ih0); // Perform splits
ut.MAC_Patch_Id(ih0,LGID3,BasicMatch(ih).patch_file,LGID31,LGID32,ihbp); // Perform basic matches
SALT30.MAC_SliceOut_ByRID(ihbp,rcid,LGID3,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,LGID3,Matches,LGID31,LGID32,o); // Join Clusters
  Patchseleid := BIPV2_Tools.MAC_ParentId_Patch(o,seleid,LGID3);  // Collapse any seleid now joined by LGID3
  Patchorgid := BIPV2_Tools.MAC_ParentId_Patch(Patchseleid,orgid,seleid);  // Collapse any orgid now joined by seleid
  Patchultid := BIPV2_Tools.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
  Patchproxid := BIPV2_Tools.MAC_ChildId_Patch(Patchultid,LGID3,proxid,rcid); // Explode any proxid that need to because of splits in LGID3
  Patchdotid := BIPV2_Tools.MAC_ChildId_Patch(Patchproxid,proxid,dotid,rcid); // Explode any dotid that need to because of splits in proxid
SHARED Patched_Infile_thin := PatchDotID : INDEPENDENT; // HACK
EXPORT Patched_Infile := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK

 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,LGID3,Matches,LGID31,LGID32,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT30.UIDType rcid;
    SALT30.UIDType LGID3_before;
    SALT30.UIDType LGID3_after;
    SALT30.UIDType seleid_before;
    SALT30.UIDType seleid_after;
    SALT30.UIDType orgid_before;
    SALT30.UIDType orgid_after;
    SALT30.UIDType ultid_before;
    SALT30.UIDType ultid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM // HACK
    SELF.rcid := le.rcid;
    SELF.LGID3_before := le.LGID3;
    SELF.LGID3_after := ri.LGID3;
    SELF.seleid_before := le.seleid;
    SELF.seleid_after := ri.seleid;
    SELF.orgid_before := le.orgid;
    SELF.orgid_after := ri.orgid;
    SELF.ultid_before := le.ultid;
    SELF.ultid_after := ri.ultid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin/*HACK*/,patched_infile_thin/*HACK*/,LEFT.rcid = RIGHT.rcid AND (LEFT.LGID3<>RIGHT.LGID3 OR LEFT.seleid<>RIGHT.seleid OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT LinkBlocksPerformed := COUNT(LinkBlockers(ih).New); // Count dids created
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_LGID3.Fields.UIDConsistency(ih_thin/*HACK*/); // Export whole consistency module
EXPORT PostIDs := BIPV2_LGID3.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].LGID3_count - PostIDs.IdCounts[1].LGID3_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed + LinkBlocksPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;
