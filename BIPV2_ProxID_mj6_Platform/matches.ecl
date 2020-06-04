// Begin code to perform the matching itself
 
IMPORT SALT30,ut,std;
EXPORT matches(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 ebr_file_number_score := MAP(
                        le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        0 /* switch0 */);
  INTEGER2 hist_duns_number_score := MAP(
                        le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        0 /* switch0 */);
  INTEGER2 hist_domestic_corp_key_score := MAP(
                        le.hist_domestic_corp_key_isnull OR ri.hist_domestic_corp_key_isnull => 0,
                        le.hist_domestic_corp_key = ri.hist_domestic_corp_key  => le.hist_domestic_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 foreign_corp_key_score := MAP(
                        le.foreign_corp_key_isnull OR ri.foreign_corp_key_isnull => 0,
                        le.foreign_corp_key = ri.foreign_corp_key  => le.foreign_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 unk_corp_key_score := MAP(
                        le.unk_corp_key_isnull OR ri.unk_corp_key_isnull => 0,
                        le.unk_corp_key = ri.unk_corp_key  => le.unk_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 company_phone_score := MAP(
                        le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switch0 */);
  INTEGER2 active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        0 /* switch0 */);
  INTEGER2 active_domestic_corp_key_score_temp := MAP(
                        le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        0 /* switch0 */);
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 hist_enterprise_number_score := MAP(
                        le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        0 /* switch0 */);
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_derived_weight100 + ri.prim_name_derived_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) OR le.company_addr1_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 prim_range_score_temp := MAP(
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 prim_name_derived_score_temp := MAP(
                        le.prim_name_derived_isnull OR ri.prim_name_derived_isnull OR le.prim_name_derived_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_derived = ri.prim_name_derived  => le.prim_name_derived_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_name_derived_weight100,s.prim_name_derived_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT30.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 zip_score_temp := MAP(
                        le.zip_isnull OR ri.zip_isnull OR le.zip_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT30.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        0 /* switch0 */)*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 v_city_name_score_temp := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT30.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_derived_score := IF ( prim_name_derived_score_temp > Config.prim_name_derived_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_name_derived_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > Config.st_Force * 100 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 zip_score := IF ( zip_score_temp > Config.zip_Force * 100 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, zip_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 v_city_name_score := IF ( v_city_name_score_temp >= Config.v_city_name_Force * 100, v_city_name_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := SALT30.ClipScore(MAX(company_csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := IF ( company_csz_score_ext > 0,company_csz_score_res,SKIP);
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := SALT30.ClipScore(MAX(company_addr1_score_pre,0) + prim_range_score + prim_name_derived_score + sec_range_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := IF ( company_addr1_score_ext > 0,company_addr1_score_res,SKIP);
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := SALT30.ClipScore(MAX(company_address_score_pre,0)+ company_addr1_score + prim_range_score + prim_name_derived_score + sec_range_score+ company_csz_score + v_city_name_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  INTEGER2 company_address_score := IF ( company_address_score_ext > 0,company_address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score // Score if either field propogated
    +MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*ebr_file_number_score // Score if either field propogated
    +MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*hist_duns_number_score // Score if either field propogated
    +MAX(le.hist_domestic_corp_key_prop,ri.hist_domestic_corp_key_prop)*hist_domestic_corp_key_score // Score if either field propogated
    +MAX(le.foreign_corp_key_prop,ri.foreign_corp_key_prop)*foreign_corp_key_score // Score if either field propogated
    +MAX(le.unk_corp_key_prop,ri.unk_corp_key_prop)*unk_corp_key_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score // Score if either field propogated
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*hist_enterprise_number_score // Score if either field propogated
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +if(le.company_address_prop+ri.company_address_prop>0,company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
  ) / 100; // Score based on propogated fields
  iComp := (cnp_name_score + cnp_number_score + ebr_file_number_score + hist_duns_number_score + hist_domestic_corp_key_score + foreign_corp_key_score + unk_corp_key_score + company_phone_score + active_duns_number_score + active_domestic_corp_key_score + company_fein_score + active_enterprise_number_score + hist_enterprise_number_score + IF(company_address_score>0,MAX(company_address_score,IF(company_addr1_score>0,MAX(company_addr1_score,prim_range_score + prim_name_derived_score + sec_range_score),prim_range_score + prim_name_derived_score + sec_range_score) + IF(company_csz_score>0,MAX(company_csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score)),IF(company_addr1_score>0,MAX(company_addr1_score,prim_range_score + prim_name_derived_score + sec_range_score),prim_range_score + prim_name_derived_score + sec_range_score) + IF(company_csz_score>0,MAX(company_csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score))) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':cnp_name:cnp_number:prim_range:prim_name_derived:st:zip','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:cnp_name(25):cnp_number(14):prim_range(13):prim_name_derived(15):st(5):zip(14)
 
dn0 := hfile(~cnp_name_isnull AND ~prim_name_derived_isnull AND ~st_isnull AND ~zip_isnull);
dn0_deduped := dn0(cnp_name_weight100 + cnp_number_weight100 + prim_range_weight100 + prim_name_derived_weight100 + st_weight100 + zip_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_name = RIGHT.cnp_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name_derived = RIGHT.prim_name_derived AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( ~left.zip_isnull AND ~right.zip_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( ~left.company_csz_isnull AND ~right.company_csz_isnull ) AND ( ~left.company_addr1_isnull AND ~right.company_addr1_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.cnp_name = RIGHT.cnp_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name_derived = RIGHT.prim_name_derived AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip,20000),HASH);
last_mjs_t :=mj0;
SALT30.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
RETURN o;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
 
//Now construct candidates based upon attribute & relationship files
 
AllAttrMatches := SORT(Mod_Attr_ForeignCorpkey(ih).Match,Proxid1,Proxid2,Rule,-(Conf+Conf_Prop),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,CombineResults(LEFT,RIGHT),LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::attribute_matches',EXPIRE(Config.PersistExpire));
hd := DISTRIBUTE(h,HASH(Proxid));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(Proxid2)),hd,LEFT.Proxid2=RIGHT.Proxid,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(Proxid1)),hd,LEFT.Proxid1 = RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ),match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf),LOCAL); // Will be distributed by DID1
with_attr := /*attr_match + */ all_mjs;// HACK
all_matches0 := Mod_Attr_ForeignCorpkey(ih).ForceFilter(ih,with_attr,Proxid1,Proxid2); // Restrict to those matches obeying force upon ForeignCorpkey
EXPORT All_Matches := all_matches0 : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and Proxid
// SALT30.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o); /* HACK - disable default salt mac_avoid_transitives*/
import BIPV2_Tools;
 /*HACK, import module for new transitives macro*/
o := BIPV2_ProxID_mj6_PlatForm.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACK - Use new transitives macro, bucket size 10*/

EXPORT PossibleMatches := o : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::mt',EXPIRE(Config.PersistExpire));
SALT30.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{Proxid, InCluster := COUNT(GROUP)},Proxid,MERGE)(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT30.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT30.UIDType rcid;  //Outcast
  SALT30.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT30.UIDType Pref_rcid; // Prefers this record
  SALT30.UIDType Pref_Proxid; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.Proxid := le.Proxid1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_Proxid := ri.Proxid2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid1 AND LEFT.Pref_Proxid=RIGHT.Proxid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid2 AND LEFT.Pref_Proxid=RIGHT.Proxid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Proxid)),Proxid,-Pref_Margin,LOCAL),Proxid,LOCAL)) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT30.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
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
ut.MAC_Patch_Id(ih,Proxid,BasicMatch(ih).patch_file,Proxid1,Proxid2,ihbp); // Perform basic matches
SALT30.MAC_SliceOut_ByRID(ihbp,rcid,Proxid,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
   o_thin := TABLE(o,{ultid,orgid,lgid3,proxid,dotid,rcid}); // HACK
Patchlgid3 := BIPV2_Tools.MAC_ParentId_Patch( o_thin ,lgid3,Proxid);  // Collapse any lgid3 now joined by Proxid/* HACK - slim dataset*/

  Patchorgid := BIPV2_Tools.MAC_ParentId_Patch(Patchlgid3,orgid,lgid3);  // Collapse any orgid now joined by lgid3
  Patchultid := BIPV2_Tools.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
  Patchdotid := SALT30.MAC_ChildId_Patch(Patchultid,Proxid,dotid,rcid); // Explode any dotid that need to because of splits in Proxid
EXPORT Patched_Infile := JOIN(o, Patchdotid, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(o),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Proxid,Matches,Proxid1,Proxid2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT30.UIDType rcid;
    SALT30.UIDType Proxid_before;
    SALT30.UIDType Proxid_after;
    SALT30.UIDType lgid3_before;
    SALT30.UIDType lgid3_after;
    SALT30.UIDType orgid_before;
    SALT30.UIDType orgid_after;
    SALT30.UIDType ultid_before;
    SALT30.UIDType ultid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.Proxid_before := le.Proxid;
    SELF.Proxid_after := ri.Proxid;
    SELF.lgid3_before := le.lgid3;
    SELF.lgid3_after := ri.lgid3;
    SELF.orgid_before := le.orgid;
    SELF.orgid_after := ri.orgid;
    SELF.ultid_before := le.ultid;
    SELF.ultid_after := ri.ultid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.Proxid<>RIGHT.Proxid OR LEFT.lgid3<>RIGHT.lgid3 OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_ProxID_mj6_PlatForm.Fields.UIDConsistency(ih); // Export whole consistency module
EXPORT PostIDs := BIPV2_ProxID_mj6_PlatForm.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].Proxid_count - PostIDs.IdCounts[1].Proxid_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;
