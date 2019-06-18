// Various routines to assist in debugging
 
IMPORT SALT311,std;
EXPORT Debug(DATASET(layout_LGID3) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  INTEGER2 Attribute_Conf := 0; // Score provided by attribute files
  SALT311.StrType   Matching_Attributes := ''; // Keys from attribute files which match
  TYPEOF(h.company_inc_state) left_company_inc_state;
  INTEGER1 company_inc_state_match_code;
  INTEGER2 company_inc_state_score;
  INTEGER2 company_inc_state_score_prop;
  BOOLEAN company_inc_state_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.company_inc_state) right_company_inc_state;
  TYPEOF(h.Lgid3IfHrchy) left_Lgid3IfHrchy;
  INTEGER1 Lgid3IfHrchy_match_code;
  INTEGER2 Lgid3IfHrchy_score;
  INTEGER2 Lgid3IfHrchy_score_prop;
  BOOLEAN Lgid3IfHrchy_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.Lgid3IfHrchy) right_Lgid3IfHrchy;
  TYPEOF(h.active_duns_number) left_active_duns_number;
  INTEGER1 active_duns_number_match_code;
  INTEGER2 active_duns_number_score;
  INTEGER2 active_duns_number_score_prop;
  TYPEOF(h.active_duns_number) right_active_duns_number;
  TYPEOF(h.duns_number) left_duns_number;
  INTEGER1 duns_number_match_code;
  INTEGER2 duns_number_score;
  INTEGER2 duns_number_score_prop;
  TYPEOF(h.duns_number) right_duns_number;
  TYPEOF(h.duns_number_concept) left_duns_number_concept;
  INTEGER1 duns_number_concept_match_code;
  INTEGER2 duns_number_concept_score;
  INTEGER2 duns_number_concept_score_prop;
  TYPEOF(h.duns_number_concept) right_duns_number_concept;
  TYPEOF(h.sbfe_id) left_sbfe_id;
  INTEGER1 sbfe_id_match_code;
  INTEGER2 sbfe_id_score;
  TYPEOF(h.sbfe_id) right_sbfe_id;
  TYPEOF(h.company_name) left_company_name;
  INTEGER1 company_name_match_code;
  INTEGER2 company_name_score;
  INTEGER2 company_name_score_prop;
  TYPEOF(h.company_name) right_company_name;
  TYPEOF(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  TYPEOF(h.company_fein) right_company_fein;
  TYPEOF(h.company_charter_number) left_company_charter_number;
  INTEGER1 company_charter_number_match_code;
  INTEGER2 company_charter_number_score;
  INTEGER2 company_charter_number_score_prop;
  TYPEOF(h.company_charter_number) right_company_charter_number;
  TYPEOF(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  INTEGER2 cnp_number_score_prop;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cnp_number) right_cnp_number;
  TYPEOF(h.cnp_btype) left_cnp_btype;
  INTEGER1 cnp_btype_match_code;
  INTEGER2 cnp_btype_score;
  TYPEOF(h.cnp_btype) right_cnp_btype;
  TYPEOF(h.nodes_below_st) left_nodes_below_st;
  TYPEOF(h.nodes_below_st) right_nodes_below_st;
  TYPEOF(h.OriginalSeleId) left_OriginalSeleId;
  TYPEOF(h.OriginalSeleId) right_OriginalSeleId;
  TYPEOF(h.OriginalOrgId) left_OriginalOrgId;
  TYPEOF(h.OriginalOrgId) right_OriginalOrgId;
  TYPEOF(h.company_name_type_derived) left_company_name_type_derived;
  TYPEOF(h.company_name_type_derived) right_company_name_type_derived;
  TYPEOF(h.hist_duns_number) left_hist_duns_number;
  TYPEOF(h.hist_duns_number) right_hist_duns_number;
  TYPEOF(h.active_domestic_corp_key) left_active_domestic_corp_key;
  TYPEOF(h.active_domestic_corp_key) right_active_domestic_corp_key;
  TYPEOF(h.hist_domestic_corp_key) left_hist_domestic_corp_key;
  TYPEOF(h.hist_domestic_corp_key) right_hist_domestic_corp_key;
  TYPEOF(h.foreign_corp_key) left_foreign_corp_key;
  TYPEOF(h.foreign_corp_key) right_foreign_corp_key;
  TYPEOF(h.unk_corp_key) left_unk_corp_key;
  TYPEOF(h.unk_corp_key) right_unk_corp_key;
  TYPEOF(h.cnp_name) left_cnp_name;
  TYPEOF(h.cnp_name) right_cnp_name;
  TYPEOF(h.cnp_hasNumber) left_cnp_hasNumber;
  TYPEOF(h.cnp_hasNumber) right_cnp_hasNumber;
  TYPEOF(h.cnp_lowv) left_cnp_lowv;
  TYPEOF(h.cnp_lowv) right_cnp_lowv;
  TYPEOF(h.cnp_translated) left_cnp_translated;
  TYPEOF(h.cnp_translated) right_cnp_translated;
  TYPEOF(h.cnp_classid) left_cnp_classid;
  TYPEOF(h.cnp_classid) right_cnp_classid;
  TYPEOF(h.prim_range) left_prim_range;
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.prim_name) left_prim_name;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.sec_range) left_sec_range;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.v_city_name) left_v_city_name;
  TYPEOF(h.v_city_name) right_v_city_name;
  TYPEOF(h.st) left_st;
  TYPEOF(h.st) right_st;
  TYPEOF(h.zip) left_zip;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.has_lgid) left_has_lgid;
  TYPEOF(h.has_lgid) right_has_lgid;
  TYPEOF(h.is_sele_level) left_is_sele_level;
  TYPEOF(h.is_sele_level) right_is_sele_level;
  TYPEOF(h.is_org_level) left_is_org_level;
  TYPEOF(h.is_org_level) right_is_org_level;
  TYPEOF(h.is_ult_level) left_is_ult_level;
  TYPEOF(h.is_ult_level) right_is_ult_level;
  TYPEOF(h.parent_proxid) left_parent_proxid;
  TYPEOF(h.parent_proxid) right_parent_proxid;
  TYPEOF(h.sele_proxid) left_sele_proxid;
  TYPEOF(h.sele_proxid) right_sele_proxid;
  TYPEOF(h.org_proxid) left_org_proxid;
  TYPEOF(h.org_proxid) right_org_proxid;
  TYPEOF(h.ultimate_proxid) left_ultimate_proxid;
  TYPEOF(h.ultimate_proxid) right_ultimate_proxid;
  TYPEOF(h.levels_from_top) left_levels_from_top;
  TYPEOF(h.levels_from_top) right_levels_from_top;
  TYPEOF(h.nodes_total) left_nodes_total;
  TYPEOF(h.nodes_total) right_nodes_total;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LGID31 := le.LGID3;
  SELF.LGID32 := ri.LGID3;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT311.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_Lgid3IfHrchy := le.Lgid3IfHrchy;
  SELF.right_Lgid3IfHrchy := ri.Lgid3IfHrchy;
  SELF.Lgid3IfHrchy_match_code := MAP(
                        le.Lgid3IfHrchy_isnull OR ri.Lgid3IfHrchy_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_Lgid3IfHrchy(le.Lgid3IfHrchy,ri.Lgid3IfHrchy));
  INTEGER2 Lgid3IfHrchy_score_temp := MAP(
                        le.Lgid3IfHrchy_isnull OR ri.Lgid3IfHrchy_isnull => 0,
                        le.Lgid3IfHrchy = ri.Lgid3IfHrchy  => le.Lgid3IfHrchy_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.Lgid3IfHrchy_weight100,ri.Lgid3IfHrchy_weight100),s.Lgid3IfHrchy_switch));
  REAL duns_number_concept_score_scale := ( le.duns_number_concept_weight100 + ri.duns_number_concept_weight100 ) / (le.active_duns_number_weight100 + ri.active_duns_number_weight100 + le.duns_number_weight100 + ri.duns_number_weight100); // Scaling factor for this concept
  SELF.duns_number_concept_match_code := MAP(
                        (le.duns_number_concept_isnull OR le.active_duns_number_isnull AND le.duns_number_isnull) OR (ri.duns_number_concept_isnull OR ri.active_duns_number_isnull AND ri.duns_number_isnull) => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_duns_number_concept(le.duns_number_concept,ri.duns_number_concept,FALSE));
  INTEGER2 duns_number_concept_score_pre := MAP( (le.duns_number_concept_isnull OR le.active_duns_number_isnull AND le.duns_number_isnull) OR (ri.duns_number_concept_isnull OR ri.active_duns_number_isnull AND ri.duns_number_isnull) => 0,
                        le.duns_number_concept = ri.duns_number_concept  => le.duns_number_concept_weight100,
                        0);
  SELF.left_duns_number_concept := le.duns_number_concept;
  SELF.right_duns_number_concept := ri.duns_number_concept;
  SELF.left_sbfe_id := le.sbfe_id;
  SELF.right_sbfe_id := ri.sbfe_id;
  SELF.sbfe_id_match_code := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_sbfe_id(le.sbfe_id,ri.sbfe_id));
  SELF.sbfe_id_score := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.sbfe_id_weight100,ri.sbfe_id_weight100),s.sbfe_id_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_match_code := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_company_name(le.company_name,ri.company_name));
  SELF.company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        SALT311.WordBagsEqual(le.company_name,ri.company_name)  => le.company_name_weight100,
                        SALT311.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_company_fein(le.company_fein,ri.company_fein));
  SELF.company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_fein_weight100,ri.company_fein_weight100),s.company_fein_switch));
  SELF.left_company_charter_number := le.company_charter_number;
  SELF.right_company_charter_number := ri.company_charter_number;
  SELF.company_charter_number_match_code := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => SALT311.MatchCode.OneSideNull,
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state <> ri.company_inc_state  => SALT311.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_company_charter_number(le.company_charter_number,ri.company_charter_number));
  SELF.company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state <> ri.company_inc_state  => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_charter_number_weight100,ri.company_charter_number_weight100),s.company_charter_number_switch));
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_match_code := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_cnp_btype(le.cnp_btype,ri.cnp_btype));
  SELF.cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_btype_weight100,ri.cnp_btype_weight100),s.cnp_btype_switch));
  SELF.left_nodes_below_st := le.nodes_below_st;
  SELF.right_nodes_below_st := ri.nodes_below_st;
  SELF.left_OriginalSeleId := le.OriginalSeleId;
  SELF.right_OriginalSeleId := ri.OriginalSeleId;
  SELF.left_OriginalOrgId := le.OriginalOrgId;
  SELF.right_OriginalOrgId := ri.OriginalOrgId;
  SELF.left_company_name_type_derived := le.company_name_type_derived;
  SELF.right_company_name_type_derived := ri.company_name_type_derived;
  SELF.left_hist_duns_number := le.hist_duns_number;
  SELF.right_hist_duns_number := ri.hist_duns_number;
  SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
  SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
  SELF.left_hist_domestic_corp_key := le.hist_domestic_corp_key;
  SELF.right_hist_domestic_corp_key := ri.hist_domestic_corp_key;
  SELF.left_foreign_corp_key := le.foreign_corp_key;
  SELF.right_foreign_corp_key := ri.foreign_corp_key;
  SELF.left_unk_corp_key := le.unk_corp_key;
  SELF.right_unk_corp_key := ri.unk_corp_key;
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.left_cnp_hasNumber := le.cnp_hasNumber;
  SELF.right_cnp_hasNumber := ri.cnp_hasNumber;
  SELF.left_cnp_lowv := le.cnp_lowv;
  SELF.right_cnp_lowv := ri.cnp_lowv;
  SELF.left_cnp_translated := le.cnp_translated;
  SELF.right_cnp_translated := ri.cnp_translated;
  SELF.left_cnp_classid := le.cnp_classid;
  SELF.right_cnp_classid := ri.cnp_classid;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.left_has_lgid := le.has_lgid;
  SELF.right_has_lgid := ri.has_lgid;
  SELF.left_is_sele_level := le.is_sele_level;
  SELF.right_is_sele_level := ri.is_sele_level;
  SELF.left_is_org_level := le.is_org_level;
  SELF.right_is_org_level := ri.is_org_level;
  SELF.left_is_ult_level := le.is_ult_level;
  SELF.right_is_ult_level := ri.is_ult_level;
  SELF.left_parent_proxid := le.parent_proxid;
  SELF.right_parent_proxid := ri.parent_proxid;
  SELF.left_sele_proxid := le.sele_proxid;
  SELF.right_sele_proxid := ri.sele_proxid;
  SELF.left_org_proxid := le.org_proxid;
  SELF.right_org_proxid := ri.org_proxid;
  SELF.left_ultimate_proxid := le.ultimate_proxid;
  SELF.right_ultimate_proxid := ri.ultimate_proxid;
  SELF.left_levels_from_top := le.levels_from_top;
  SELF.right_levels_from_top := ri.levels_from_top;
  SELF.left_nodes_total := le.nodes_total;
  SELF.right_nodes_total := ri.nodes_total;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.Lgid3IfHrchy_score := IF ( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force * 100, Lgid3IfHrchy_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.Lgid3IfHrchy_skipped := SELF.Lgid3IfHrchy_score < -5000;// Enforce FORCE parameter
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.active_duns_number_match_code := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => SALT311.MatchCode.OneSideNull,
                        duns_number_concept_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_active_duns_number(le.active_duns_number,ri.active_duns_number));
  SELF.active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        0 /* switchN/0 */)*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  SELF.left_duns_number := le.duns_number;
  SELF.right_duns_number := ri.duns_number;
  SELF.duns_number_match_code := MAP(
                        le.duns_number_isnull OR ri.duns_number_isnull => SALT311.MatchCode.OneSideNull,
                        duns_number_concept_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_duns_number(le.duns_number,ri.duns_number));
  SELF.duns_number_score := MAP(
                        le.duns_number_isnull OR ri.duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.duns_number = ri.duns_number  => le.duns_number_weight100,
                        0 /* switchN/0 */)*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_number_weight100,ri.cnp_number_weight100),s.cnp_number_switch));
// Compute the score for the concept duns_number_concept
  INTEGER2 duns_number_concept_score_ext := SALT311.ClipScore(MAX(duns_number_concept_score_pre,0) + self.active_duns_number_score + self.duns_number_score);// Score in surrounding context
  INTEGER2 duns_number_concept_score_res := MAX(0,duns_number_concept_score_pre); // At least nothing
  SELF.duns_number_concept_score := duns_number_concept_score_res;
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR SELF.sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
  SELF.left_company_inc_state := le.company_inc_state;
  SELF.right_company_inc_state := ri.company_inc_state;
  SELF.company_inc_state_match_code := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_company_inc_state(le.company_inc_state,ri.company_inc_state));
  INTEGER2 company_inc_state_score_temp := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state_weight100 = 0 => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_inc_state_weight100,ri.company_inc_state_weight100),s.company_inc_state_switch));
  SELF.company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR SELF.active_duns_number_score > Config.company_inc_state_OR1_active_duns_number_Force*100 OR SELF.duns_number_score > Config.company_inc_state_OR2_duns_number_Force*100 OR SELF.duns_number_concept_score > Config.company_inc_state_OR3_duns_number_concept_Force*100 OR SELF.company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100 OR SELF.sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100, company_inc_state_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.company_inc_state_skipped := SELF.company_inc_state_score < -5000;// Enforce FORCE parameter
  // Get propagation scores for individual propagated fields
  SELF.company_inc_state_score_prop := MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*SELF.company_inc_state_score; // Score if either field propogated
  SELF.Lgid3IfHrchy_score_prop := MAX(le.Lgid3IfHrchy_prop,ri.Lgid3IfHrchy_prop)*SELF.Lgid3IfHrchy_score; // Score if either field propogated
  SELF.active_duns_number_score_prop := MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score; // Score if either field propogated
  SELF.duns_number_score_prop := MAX(le.duns_number_prop,ri.duns_number_prop)*SELF.duns_number_score; // Score if either field propogated
  SELF.duns_number_concept_score_prop := IF(le.duns_number_concept_prop+ri.duns_number_concept_prop>0,SELF.duns_number_concept_score*(0+IF(le.active_duns_number_prop+ri.active_duns_number_prop>0,s.active_duns_number_specificity,0)+IF(le.duns_number_prop+ri.duns_number_prop>0,s.duns_number_specificity,0))/( s.active_duns_number_specificity+ s.duns_number_specificity),0);
  SELF.company_name_score_prop := MAX(le.company_name_prop,ri.company_name_prop)*SELF.company_name_score; // Score if either field propogated
  SELF.company_charter_number_score_prop := MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*SELF.company_charter_number_score; // Score if either field propogated
  SELF.cnp_number_score_prop := MAX(le.cnp_number_prop,ri.cnp_number_prop)*SELF.cnp_number_score; // Score if either field propogated
  SELF.Conf_Prop := (0 + SELF.company_inc_state_score_prop + SELF.Lgid3IfHrchy_score_prop + SELF.active_duns_number_score_prop + SELF.duns_number_score_prop + SELF.duns_number_concept_score_prop + SELF.company_name_score_prop + SELF.company_charter_number_score_prop + SELF.cnp_number_score_prop) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.company_inc_state_score + SELF.Lgid3IfHrchy_score + IF(SELF.duns_number_concept_score>0,MAX(SELF.duns_number_concept_score,SELF.active_duns_number_score + SELF.duns_number_score),SELF.active_duns_number_score + SELF.duns_number_score) + SELF.sbfe_id_score + SELF.company_name_score + SELF.company_fein_score + SELF.company_charter_number_score + SELF.cnp_number_score + SELF.cnp_btype_score) / 100 + outside;
END;
SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM
    SELF.Attribute_Conf := ri.Conf;
    SELF.Matching_Attributes := ri.Source_Id;
    SELF.Conf := le.Conf + ri.Conf;
    SELF := le;
  END;
  RETURN JOIN(am,ia,LEFT.LGID31=RIGHT.LGID31 AND LEFT.LGID32=RIGHT.LGID32,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.LGID3 = RIGHT.LGID31,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.LGID32 = RIGHT.LGID3,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(rcid1 <> rcid2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN AppendAttribs( d, ia );
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT311.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im,dataset(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rcid1=RIGHT.rcid1 AND LEFT.rcid2=RIGHT.rcid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN AppendAttribs( annotated_matches, ia );
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType LGID3;
  DATASET(SALT311.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) Lgid3IfHrchy_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) duns_number_concept_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) sbfe_id_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) company_name_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) company_fein_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) nodes_below_st_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) OriginalSeleId_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) OriginalOrgId_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) company_name_type_derived_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_hasNumber_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) prim_range_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) prim_name_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) sec_range_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) st_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) zip_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) is_sele_level_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) is_org_level_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) is_ult_level_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) sele_proxid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) org_proxid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) levels_from_top_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) nodes_total_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT311.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LGID3 := le.LGID3;
    SELF.company_inc_state_values := SALT311.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
    SELF.Lgid3IfHrchy_values := SALT311.fn_combine_fieldvaluelist(le.Lgid3IfHrchy_values,ri.Lgid3IfHrchy_values);
    SELF.duns_number_concept_values := SALT311.fn_combine_fieldvaluelist(le.duns_number_concept_values,ri.duns_number_concept_values);
    SELF.sbfe_id_values := SALT311.fn_combine_fieldvaluelist(le.sbfe_id_values,ri.sbfe_id_values);
    SELF.company_name_values := SALT311.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.company_fein_values := SALT311.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.company_charter_number_values := SALT311.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
    SELF.cnp_number_values := SALT311.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.cnp_btype_values := SALT311.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.nodes_below_st_values := SALT311.fn_combine_fieldvaluelist(le.nodes_below_st_values,ri.nodes_below_st_values);
    SELF.OriginalSeleId_values := SALT311.fn_combine_fieldvaluelist(le.OriginalSeleId_values,ri.OriginalSeleId_values);
    SELF.OriginalOrgId_values := SALT311.fn_combine_fieldvaluelist(le.OriginalOrgId_values,ri.OriginalOrgId_values);
    SELF.company_name_type_derived_values := SALT311.fn_combine_fieldvaluelist(le.company_name_type_derived_values,ri.company_name_type_derived_values);
    SELF.hist_duns_number_values := SALT311.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
    SELF.active_domestic_corp_key_values := SALT311.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
    SELF.hist_domestic_corp_key_values := SALT311.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
    SELF.foreign_corp_key_values := SALT311.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
    SELF.unk_corp_key_values := SALT311.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
    SELF.cnp_name_values := SALT311.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.cnp_hasNumber_values := SALT311.fn_combine_fieldvaluelist(le.cnp_hasNumber_values,ri.cnp_hasNumber_values);
    SELF.cnp_lowv_values := SALT311.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
    SELF.cnp_translated_values := SALT311.fn_combine_fieldvaluelist(le.cnp_translated_values,ri.cnp_translated_values);
    SELF.cnp_classid_values := SALT311.fn_combine_fieldvaluelist(le.cnp_classid_values,ri.cnp_classid_values);
    SELF.prim_range_values := SALT311.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.prim_name_values := SALT311.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.sec_range_values := SALT311.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.v_city_name_values := SALT311.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
    SELF.st_values := SALT311.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip_values := SALT311.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.has_lgid_values := SALT311.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
    SELF.is_sele_level_values := SALT311.fn_combine_fieldvaluelist(le.is_sele_level_values,ri.is_sele_level_values);
    SELF.is_org_level_values := SALT311.fn_combine_fieldvaluelist(le.is_org_level_values,ri.is_org_level_values);
    SELF.is_ult_level_values := SALT311.fn_combine_fieldvaluelist(le.is_ult_level_values,ri.is_ult_level_values);
    SELF.parent_proxid_values := SALT311.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
    SELF.sele_proxid_values := SALT311.fn_combine_fieldvaluelist(le.sele_proxid_values,ri.sele_proxid_values);
    SELF.org_proxid_values := SALT311.fn_combine_fieldvaluelist(le.org_proxid_values,ri.org_proxid_values);
    SELF.ultimate_proxid_values := SALT311.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
    SELF.levels_from_top_values := SALT311.fn_combine_fieldvaluelist(le.levels_from_top_values,ri.levels_from_top_values);
    SELF.nodes_total_values := SALT311.fn_combine_fieldvaluelist(le.nodes_total_values,ri.nodes_total_values);
    SELF.dt_first_seen_values := SALT311.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT311.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(LGID3) ), LGID3, LOCAL ), LEFT.LGID3 = RIGHT.LGID3, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.LGID3 := le.LGID3;
    SELF.company_inc_state_values := SORT(le.company_inc_state_values, -cnt, val, LOCAL);
    SELF.Lgid3IfHrchy_values := SORT(le.Lgid3IfHrchy_values, -cnt, val, LOCAL);
    SELF.duns_number_concept_values := SORT(le.duns_number_concept_values, -cnt, val, LOCAL);
    SELF.sbfe_id_values := SORT(le.sbfe_id_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.company_charter_number_values := SORT(le.company_charter_number_values, -cnt, val, LOCAL);
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.nodes_below_st_values := SORT(le.nodes_below_st_values, -cnt, val, LOCAL);
    SELF.OriginalSeleId_values := SORT(le.OriginalSeleId_values, -cnt, val, LOCAL);
    SELF.OriginalOrgId_values := SORT(le.OriginalOrgId_values, -cnt, val, LOCAL);
    SELF.company_name_type_derived_values := SORT(le.company_name_type_derived_values, -cnt, val, LOCAL);
    SELF.hist_duns_number_values := SORT(le.hist_duns_number_values, -cnt, val, LOCAL);
    SELF.active_domestic_corp_key_values := SORT(le.active_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.hist_domestic_corp_key_values := SORT(le.hist_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.foreign_corp_key_values := SORT(le.foreign_corp_key_values, -cnt, val, LOCAL);
    SELF.unk_corp_key_values := SORT(le.unk_corp_key_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.cnp_hasNumber_values := SORT(le.cnp_hasNumber_values, -cnt, val, LOCAL);
    SELF.cnp_lowv_values := SORT(le.cnp_lowv_values, -cnt, val, LOCAL);
    SELF.cnp_translated_values := SORT(le.cnp_translated_values, -cnt, val, LOCAL);
    SELF.cnp_classid_values := SORT(le.cnp_classid_values, -cnt, val, LOCAL);
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.v_city_name_values := SORT(le.v_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.has_lgid_values := SORT(le.has_lgid_values, -cnt, val, LOCAL);
    SELF.is_sele_level_values := SORT(le.is_sele_level_values, -cnt, val, LOCAL);
    SELF.is_org_level_values := SORT(le.is_org_level_values, -cnt, val, LOCAL);
    SELF.is_ult_level_values := SORT(le.is_ult_level_values, -cnt, val, LOCAL);
    SELF.parent_proxid_values := SORT(le.parent_proxid_values, -cnt, val, LOCAL);
    SELF.sele_proxid_values := SORT(le.sele_proxid_values, -cnt, val, LOCAL);
    SELF.org_proxid_values := SORT(le.org_proxid_values, -cnt, val, LOCAL);
    SELF.ultimate_proxid_values := SORT(le.ultimate_proxid_values, -cnt, val, LOCAL);
    SELF.levels_from_top_values := SORT(le.levels_from_top_values, -cnt, val, LOCAL);
    SELF.nodes_total_values := SORT(le.nodes_total_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LGID3 := le.LGID3;
  SELF.company_inc_state_Values := IF ( (le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR le.company_inc_state = (TYPEOF(le.company_inc_state))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_inc_state)}],SALT311.Layout_FieldValueList));
  SELF.Lgid3IfHrchy_Values := IF ( (le.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR le.Lgid3IfHrchy = (TYPEOF(le.Lgid3IfHrchy))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.Lgid3IfHrchy)}],SALT311.Layout_FieldValueList));
  SELF.duns_number_concept_Values := IF ( (le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR le.active_duns_number = (TYPEOF(le.active_duns_number))'') AND (le.duns_number  IN SET(s.nulls_duns_number,duns_number) OR le.duns_number = (TYPEOF(le.duns_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.active_duns_number) + ' ' + TRIM((SALT311.StrType)le.duns_number)}],SALT311.Layout_FieldValueList));
  SELF.sbfe_id_Values := IF ( (le.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR le.sbfe_id = (TYPEOF(le.sbfe_id))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.sbfe_id)}],SALT311.Layout_FieldValueList));
  SELF.company_name_Values := IF ( (le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_name)}],SALT311.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_fein)}],SALT311.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( (le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR le.company_charter_number = (TYPEOF(le.company_charter_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_charter_number)}],SALT311.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.cnp_number)}],SALT311.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.cnp_btype)}],SALT311.Layout_FieldValueList));
  SELF.nodes_below_st_Values := DATASET([{TRIM((SALT311.StrType)le.nodes_below_st)}],SALT311.Layout_FieldValueList);
  SELF.OriginalSeleId_Values := DATASET([{TRIM((SALT311.StrType)le.OriginalSeleId)}],SALT311.Layout_FieldValueList);
  SELF.OriginalOrgId_Values := DATASET([{TRIM((SALT311.StrType)le.OriginalOrgId)}],SALT311.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT311.StrType)le.company_name_type_derived)}],SALT311.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT311.StrType)le.hist_duns_number)}],SALT311.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.active_domestic_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.hist_domestic_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.foreign_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.unk_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_name)}],SALT311.Layout_FieldValueList);
  SELF.cnp_hasNumber_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_hasNumber)}],SALT311.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_lowv)}],SALT311.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_translated)}],SALT311.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_classid)}],SALT311.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT311.StrType)le.prim_range)}],SALT311.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT311.StrType)le.prim_name)}],SALT311.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT311.StrType)le.sec_range)}],SALT311.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT311.StrType)le.v_city_name)}],SALT311.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT311.StrType)le.st)}],SALT311.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT311.StrType)le.zip)}],SALT311.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT311.StrType)le.has_lgid)}],SALT311.Layout_FieldValueList);
  SELF.is_sele_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_sele_level)}],SALT311.Layout_FieldValueList);
  SELF.is_org_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_org_level)}],SALT311.Layout_FieldValueList);
  SELF.is_ult_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_ult_level)}],SALT311.Layout_FieldValueList);
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.parent_proxid)}],SALT311.Layout_FieldValueList);
  SELF.sele_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.sele_proxid)}],SALT311.Layout_FieldValueList);
  SELF.org_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.org_proxid)}],SALT311.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.ultimate_proxid)}],SALT311.Layout_FieldValueList);
  SELF.levels_from_top_Values := DATASET([{TRIM((SALT311.StrType)le.levels_from_top)}],SALT311.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT311.StrType)le.nodes_total)}],SALT311.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_first_seen)}],SALT311.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_last_seen)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.LGID3 := le.LGID3;
  SELF.company_inc_state_Values := IF ( (le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR le.company_inc_state = (TYPEOF(le.company_inc_state))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_inc_state)}],SALT311.Layout_FieldValueList));
  SELF.Lgid3IfHrchy_Values := IF ( (le.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR le.Lgid3IfHrchy = (TYPEOF(le.Lgid3IfHrchy))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.Lgid3IfHrchy)}],SALT311.Layout_FieldValueList));
  SELF.duns_number_concept_Values := IF ( (le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR le.active_duns_number = (TYPEOF(le.active_duns_number))'') AND (le.duns_number  IN SET(s.nulls_duns_number,duns_number) OR le.duns_number = (TYPEOF(le.duns_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.active_duns_number) + ' ' + TRIM((SALT311.StrType)le.duns_number)}],SALT311.Layout_FieldValueList));
  SELF.sbfe_id_Values := IF ( (le.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR le.sbfe_id = (TYPEOF(le.sbfe_id))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.sbfe_id)}],SALT311.Layout_FieldValueList));
  SELF.company_name_Values := IF ( (le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_name)}],SALT311.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_fein)}],SALT311.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( (le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR le.company_charter_number = (TYPEOF(le.company_charter_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.company_charter_number)}],SALT311.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.cnp_number)}],SALT311.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.cnp_btype)}],SALT311.Layout_FieldValueList));
  SELF.nodes_below_st_Values := DATASET([{TRIM((SALT311.StrType)le.nodes_below_st)}],SALT311.Layout_FieldValueList);
  SELF.OriginalSeleId_Values := DATASET([{TRIM((SALT311.StrType)le.OriginalSeleId)}],SALT311.Layout_FieldValueList);
  SELF.OriginalOrgId_Values := DATASET([{TRIM((SALT311.StrType)le.OriginalOrgId)}],SALT311.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT311.StrType)le.company_name_type_derived)}],SALT311.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT311.StrType)le.hist_duns_number)}],SALT311.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.active_domestic_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.hist_domestic_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.foreign_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT311.StrType)le.unk_corp_key)}],SALT311.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_name)}],SALT311.Layout_FieldValueList);
  SELF.cnp_hasNumber_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_hasNumber)}],SALT311.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_lowv)}],SALT311.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_translated)}],SALT311.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT311.StrType)le.cnp_classid)}],SALT311.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT311.StrType)le.prim_range)}],SALT311.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT311.StrType)le.prim_name)}],SALT311.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT311.StrType)le.sec_range)}],SALT311.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT311.StrType)le.v_city_name)}],SALT311.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT311.StrType)le.st)}],SALT311.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT311.StrType)le.zip)}],SALT311.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT311.StrType)le.has_lgid)}],SALT311.Layout_FieldValueList);
  SELF.is_sele_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_sele_level)}],SALT311.Layout_FieldValueList);
  SELF.is_org_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_org_level)}],SALT311.Layout_FieldValueList);
  SELF.is_ult_level_Values := DATASET([{TRIM((SALT311.StrType)le.is_ult_level)}],SALT311.Layout_FieldValueList);
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.parent_proxid)}],SALT311.Layout_FieldValueList);
  SELF.sele_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.sele_proxid)}],SALT311.Layout_FieldValueList);
  SELF.org_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.org_proxid)}],SALT311.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT311.StrType)le.ultimate_proxid)}],SALT311.Layout_FieldValueList);
  SELF.levels_from_top_Values := DATASET([{TRIM((SALT311.StrType)le.levels_from_top)}],SALT311.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT311.StrType)le.nodes_total)}],SALT311.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_first_seen)}],SALT311.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_last_seen)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.company_inc_state := if ( le.company_inc_state_prop>0, (TYPEOF(le.company_inc_state))'', le.company_inc_state ); // Blank if propogated
    self.company_inc_state_isnull := le.company_inc_state_prop>0 OR le.company_inc_state_isnull;
    self.company_inc_state_prop := 0; // Avoid reducing score later
    self.Lgid3IfHrchy := if ( le.Lgid3IfHrchy_prop>0, (TYPEOF(le.Lgid3IfHrchy))'', le.Lgid3IfHrchy ); // Blank if propogated
    self.Lgid3IfHrchy_isnull := le.Lgid3IfHrchy_prop>0 OR le.Lgid3IfHrchy_isnull;
    self.Lgid3IfHrchy_prop := 0; // Avoid reducing score later
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.duns_number := if ( le.duns_number_prop>0, (TYPEOF(le.duns_number))'', le.duns_number ); // Blank if propogated
    self.duns_number_isnull := le.duns_number_prop>0 OR le.duns_number_isnull;
    self.duns_number_prop := 0; // Avoid reducing score later
    self.duns_number_concept := if ( le.duns_number_concept_prop>0, 0, le.duns_number_concept ); // Blank if propogated
    self.duns_number_concept_isnull := true; // Flag as null to scoring
    self.duns_number_concept_prop := 0; // Avoid reducing score later
    self.company_name := if ( le.company_name_prop>0, (TYPEOF(le.company_name))'', le.company_name ); // Blank if propogated
    self.company_name_isnull := le.company_name_prop>0 OR le.company_name_isnull;
    self.company_name_prop := 0; // Avoid reducing score later
    self.company_charter_number := if ( le.company_charter_number_prop>0, (TYPEOF(le.company_charter_number))'', le.company_charter_number ); // Blank if propogated
    self.company_charter_number_isnull := le.company_charter_number_prop>0 OR le.company_charter_number_isnull;
    self.company_charter_number_prop := 0; // Avoid reducing score later
    self.cnp_number := if ( le.cnp_number_prop>0, (TYPEOF(le.cnp_number))'', le.cnp_number ); // Blank if propogated
    self.cnp_number_isnull := le.cnp_number_prop>0 OR le.cnp_number_isnull;
    self.cnp_number_prop := 0; // Avoid reducing score later
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 company_inc_state_size := 0;
  UNSIGNED1 Lgid3IfHrchy_size := 0;
  UNSIGNED1 duns_number_concept_size := 0;
  UNSIGNED1 sbfe_id_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_charter_number_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.company_inc_state_size := SALT311.Fn_SwitchSpec(s.company_inc_state_switch,count(le.company_inc_state_values));
  SELF.Lgid3IfHrchy_size := SALT311.Fn_SwitchSpec(s.Lgid3IfHrchy_switch,count(le.Lgid3IfHrchy_values));
  SELF.duns_number_concept_size := SALT311.Fn_SwitchSpec(s.duns_number_concept_switch,count(le.duns_number_concept_values));
  SELF.sbfe_id_size := SALT311.Fn_SwitchSpec(s.sbfe_id_switch,count(le.sbfe_id_values));
  SELF.company_name_size := SALT311.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.company_fein_size := SALT311.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_charter_number_size := SALT311.Fn_SwitchSpec(s.company_charter_number_switch,count(le.company_charter_number_values));
  SELF.cnp_number_size := SALT311.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.cnp_btype_size := SALT311.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.company_inc_state_size+t.Lgid3IfHrchy_size+t.duns_number_concept_size+t.sbfe_id_size+t.company_name_size+t.company_fein_size+t.company_charter_number_size+t.cnp_number_size+t.cnp_btype_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
