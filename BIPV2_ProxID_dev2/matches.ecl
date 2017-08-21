// Begin code to perform the matching itself
 
IMPORT SALT27,ut;
EXPORT matches(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 21) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0,UNSIGNED company_address_support = 0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT27.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT27.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 hist_enterprise_number_score := MAP( le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        0 /* switch0 */);
  INTEGER2 hist_duns_number_score := MAP( le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        0 /* switch0 */);
  INTEGER2 hist_domestic_corp_key_score := MAP( le.hist_domestic_corp_key_isnull OR ri.hist_domestic_corp_key_isnull => 0,
                        le.hist_domestic_corp_key = ri.hist_domestic_corp_key  => le.hist_domestic_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 unk_corp_key_score := MAP( le.unk_corp_key_isnull OR ri.unk_corp_key_isnull => 0,
                        le.unk_corp_key = ri.unk_corp_key  => le.unk_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 ebr_file_number_score := MAP( le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        0 /* switch0 */);
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT27.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 foreign_corp_key_score := MAP( le.foreign_corp_key_isnull OR ri.foreign_corp_key_isnull => 0,
                        le.foreign_corp_key = ri.foreign_corp_key  => le.foreign_corp_key_weight100,
                        0 /* switch0 */);
  INTEGER2 company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switch0 */);
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT27.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT27.MatchBagOfWords(le.cnp_name,ri.cnp_name,0,1,1,1,0));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT27.WithinEditN(le.company_fein,ri.company_fein,1) => SALT27.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT27.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  INTEGER2 sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        0 /* switch0 */)* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 cnp_btype_score := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT27.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 iscorp_score := MAP( le.iscorp_isnull OR ri.iscorp_isnull => 0,
                        le.iscorp = ri.iscorp  => le.iscorp_weight100,
                        0 /* switch0 */);
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 prim_range_score_temp := MAP(                         company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 prim_name_score_temp := MAP( le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT27.Fn_Fail_Scale(le.st_weight100,s.st_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
 
 
 
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
 
 
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= 1300, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT27.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* company_csz_score_scale* company_address_score_scale;
 
 
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0 OR company_address_support > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0 OR company_address_support > 0, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 st_score := IF ( st_score_temp > 0 OR company_csz_score_pre > 0 OR company_address_score_pre > 0 OR company_address_support > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
 
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + prim_range_score + prim_name_score + sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := company_addr1_score_res;
 
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := IF ( company_csz_score_ext > -200,company_csz_score_res,SKIP);
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ company_addr1_score + prim_range_score + prim_name_score + sec_range_score+ company_csz_score + v_city_name_score + st_score + zip_score;// Score in surrounding context
  INTEGER2 company_address_score_sp := MAX(0,MIN(company_address_support,s.company_address_max*100)-company_address_score_ext); // Support provided
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre)+company_address_score_sp; // Supported score for this concept
  INTEGER2 company_address_score_eext := company_address_score_ext+company_address_score_sp; // Score to use for force checking
  INTEGER2 company_address_score := IF ( company_address_score_eext > 0,company_address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score // Score if either field propogated
    +MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*hist_enterprise_number_score // Score if either field propogated
    +MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*hist_duns_number_score // Score if either field propogated
    +MAX(le.hist_domestic_corp_key_prop,ri.hist_domestic_corp_key_prop)*hist_domestic_corp_key_score // Score if either field propogated
    +MAX(le.unk_corp_key_prop,ri.unk_corp_key_prop)*unk_corp_key_score // Score if either field propogated
    +MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*ebr_file_number_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +MAX(le.foreign_corp_key_prop,ri.foreign_corp_key_prop)*foreign_corp_key_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +if(le.company_address_prop+ri.company_address_prop>0,company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +MAX(le.iscorp_prop,ri.iscorp_prop)*iscorp_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (cnp_number_score + prim_range_score + prim_name_score + st_score + active_enterprise_number_score + hist_enterprise_number_score + hist_duns_number_score + hist_domestic_corp_key_score + unk_corp_key_score + ebr_file_number_score + active_duns_number_score + foreign_corp_key_score + company_phone_score + active_domestic_corp_key_score + cnp_name_score + company_fein_score + company_address_score + company_addr1_score + zip_score + company_csz_score + sec_range_score + v_city_name_score + cnp_btype_score + iscorp_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':cnp_number:prim_range:prim_name:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
 
//Fixed fields ->:cnp_number(12):prim_range(13):prim_name(15):st(5)
 
dn0 := h(~prim_name_isnull AND ~st_isnull);
dn0_deduped := dn0(cnp_number_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st,20000),SKEW(1));
last_mjs_t :=mj0;
SALT27.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs := o;
 
//Now construct candidates based upon attribute & relationship files
 
match_candidates(ih).Layout_Attribute_Matches ScoreSrcRidVlid(match_candidates(ih).SrcRidVlid_candidates le,match_candidates(ih).SrcRidVlid_candidates ri,UNSIGNED company_address_support = 0) := TRANSFORM
  SELF.rule := 10000; // Signify Attribute File #0
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.source_id := le.Basis;
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT27.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT27.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT27.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT27.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT27.MatchBagOfWords(le.cnp_name,ri.cnp_name,0,1,1,1,0));
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= 1300, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
 
  SELF.Conf_Prop := (cnp_number_score + active_enterprise_number_score + active_duns_number_score + active_domestic_corp_key_score + cnp_name_score) / 100; // Score based on forced fields
  SELF.support_company_address := ri.Basis_weight100 *  1.00;
end;
SrcRidVlid_matches0 := DISTRIBUTE(JOIN(match_candidates(ih).SrcRidVlid_candidates,match_candidates(ih).SrcRidVlid_candidates,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,ScoreSrcRidVlid(LEFT,RIGHT)),Proxid1+Proxid2);
 
SrcRidVlid_matches := DEDUP( SORT(SrcRidVlid_matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_company_address),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match
 
AllAttrMatches := SORT(SrcRidVlid_Matches,Proxid1,Proxid2,Rule,-(Conf+Conf_Prop+support_company_address),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.support_company_address := le.support_company_address+ri.support_company_address;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,CombineResults(LEFT,RIGHT),LOCAL):PERSIST('~temp::attribute_matches::Proxid::BIPV2_ProxID_dev2');
hd := DISTRIBUTE(h,HASH(Proxid));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(Proxid2)),hd,LEFT.Proxid2=RIGHT.Proxid,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(Proxid1)),hd,LEFT.Proxid1 = RIGHT.Proxid,match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf,LEFT.support_company_address),LOCAL); // Will be distributed by DID1
with_attr := attr_match + all_mjs;
export All_Matches := with_attr : persist('~temp::BIPV2_ProxID_dev2_Proxid_DOT_Base_all_m'); // To by used by rcid and Proxid
SALT27.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('~temp::BIPV2_ProxID_dev2_Proxid_DOT_Base_mt');
SALT27.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::BIPV2_ProxID_dev2_Proxid_DOT_Base_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT27.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::BIPV2_ProxID_dev2_Proxid_DOT_Base_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT27.UIDType rcid;  //Outcast
  SALT27.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT27.UIDType Pref_rcid; // Prefers this record
  SALT27.UIDType Pref_Proxid; // Prefers this cluster
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
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Proxid)),Proxid,-Pref_Margin,LOCAL),Proxid,LOCAL); // 1024x better in new place
SALT27.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches,All_Attribute_Matches);
 
//Now actually produce the new file
ut.MAC_Patch_Id(ih,Proxid,BasicMatch(ih).patch_file,Proxid1,Proxid2,ihbp); // Perform basic matches
SALT27.MAC_SliceOut_ByRID(ihbp,rcid,Proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
EXPORT Patched_Infile := o;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Proxid,Matches,Proxid1,Proxid2,o1);
export Patched_Candidates := o1;
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
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(Proxid=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(Proxid>rcid)); // Should be zero
END;
