// Logic to handle the matching around UnderLinks
 
IMPORT SALT311,std;
EXPORT MOD_Attr_UnderLinks(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED Cands := match_candidates(ih).UnderLinks_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
 
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support0 = 0) := TRANSFORM
  SELF.rule := 10004; // Signify Attribute File #4
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.source_id := le.Basis;
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_number_weight100,ri.cnp_number_weight100),s.cnp_number_switch));
  INTEGER2 sbfe_id_score := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        0 /* switchN/0 */);
  INTEGER2 company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        /*le.company_inc_state_isnull OR ri.company_inc_state_isnull OR*//*HACK remove inc state isnull check */le.company_inc_state <> ri.company_inc_state  => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_charter_number_weight100,ri.company_charter_number_weight100),s.company_charter_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.active_enterprise_number_weight100,ri.active_enterprise_number_weight100),s.active_enterprise_number_switch));
  INTEGER2 active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.active_duns_number_weight100,ri.active_duns_number_weight100),s.active_duns_number_switch));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        Config.WithinEditN(le.company_fein,le.company_fein_len,ri.company_fein,ri.company_fein_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.company_fein_weight100,ri.company_fein_weight100),s.company_fein_switch));
  INTEGER2 cnp_name_phonetic_score := MAP(
                        le.cnp_name_phonetic_isnull OR ri.cnp_name_phonetic_isnull => 0,
                        le.cnp_name_phonetic = ri.cnp_name_phonetic  => le.cnp_name_phonetic_weight100,
                        metaphonelib.dmetaphone1(le.cnp_name_phonetic) = metaphonelib.dmetaphone1(ri.cnp_name_phonetic) => SALT311.fn_fuzzy_specificity(le.cnp_name_phonetic_weight100,le.cnp_name_phonetic_cnt, le.cnp_name_phonetic_p_cnt,ri.cnp_name_phonetic_weight100,ri.cnp_name_phonetic_cnt,ri.cnp_name_phonetic_p_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_name_phonetic_weight100,ri.cnp_name_phonetic_weight100),s.cnp_name_phonetic_switch));
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (cnp_number_score + sbfe_id_score + company_charter_number_score + active_enterprise_number_score + active_duns_number_score + company_fein_score + cnp_name_phonetic_score) / 100; // Score based on forced fields
  SELF.support_cnp_name := ri.Basis_weight100/100;
END;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);
 
EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match
END;
