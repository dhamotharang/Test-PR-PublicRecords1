// Various routines to assist in debugging
 
IMPORT SALT30,ut,std;
EXPORT Debug(DATASET(layout_LGID3) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  typeof(h.active_duns_number) left_active_duns_number;
  INTEGER1 active_duns_number_match_code;
  INTEGER2 active_duns_number_score;
  typeof(h.active_duns_number) right_active_duns_number;
  typeof(h.sbfe_id) left_sbfe_id;
  INTEGER1 sbfe_id_match_code;
  INTEGER2 sbfe_id_score;
  typeof(h.sbfe_id) right_sbfe_id;
  typeof(h.source_record_id) left_source_record_id;
  INTEGER1 source_record_id_match_code;
  INTEGER2 source_record_id_score;
  typeof(h.source_record_id) right_source_record_id;
  typeof(h.company_name) left_company_name;
  INTEGER1 company_name_match_code;
  INTEGER2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.duns_number) left_duns_number;
  INTEGER1 duns_number_match_code;
  INTEGER2 duns_number_score;
  typeof(h.duns_number) right_duns_number;
  typeof(h.duns_number_concept) left_duns_number_concept;
  INTEGER1 duns_number_concept_match_code;
  INTEGER2 duns_number_concept_score;
  typeof(h.duns_number_concept) right_duns_number_concept;
  typeof(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.company_charter_number) left_company_charter_number;
  INTEGER1 company_charter_number_match_code;
  INTEGER2 company_charter_number_score;
  typeof(h.company_charter_number) right_company_charter_number;
  typeof(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_number) right_cnp_number;
  typeof(h.company_inc_state) left_company_inc_state;
  INTEGER1 company_inc_state_match_code;
  INTEGER2 company_inc_state_score;
  BOOLEAN company_inc_state_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_inc_state) right_company_inc_state;
  typeof(h.cnp_btype) left_cnp_btype;
  INTEGER1 cnp_btype_match_code;
  INTEGER2 cnp_btype_score;
  typeof(h.cnp_btype) right_cnp_btype;
  typeof(h.nodes_total) left_nodes_total;
  typeof(h.nodes_total) right_nodes_total;
  typeof(h.company_name_type_derived) left_company_name_type_derived;
  typeof(h.company_name_type_derived) right_company_name_type_derived;
  typeof(h.hist_duns_number) left_hist_duns_number;
  typeof(h.hist_duns_number) right_hist_duns_number;
  typeof(h.active_domestic_corp_key) left_active_domestic_corp_key;
  typeof(h.active_domestic_corp_key) right_active_domestic_corp_key;
  typeof(h.hist_domestic_corp_key) left_hist_domestic_corp_key;
  typeof(h.hist_domestic_corp_key) right_hist_domestic_corp_key;
  typeof(h.foreign_corp_key) left_foreign_corp_key;
  typeof(h.foreign_corp_key) right_foreign_corp_key;
  typeof(h.unk_corp_key) left_unk_corp_key;
  typeof(h.unk_corp_key) right_unk_corp_key;
  typeof(h.cnp_name) left_cnp_name;
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.cnp_hasNumber) left_cnp_hasNumber;
  typeof(h.cnp_hasNumber) right_cnp_hasNumber;
  typeof(h.cnp_lowv) left_cnp_lowv;
  typeof(h.cnp_lowv) right_cnp_lowv;
  typeof(h.cnp_translated) left_cnp_translated;
  typeof(h.cnp_translated) right_cnp_translated;
  typeof(h.cnp_classid) left_cnp_classid;
  typeof(h.cnp_classid) right_cnp_classid;
  typeof(h.prim_range) left_prim_range;
  typeof(h.prim_range) right_prim_range;
  typeof(h.prim_name) left_prim_name;
  typeof(h.prim_name) right_prim_name;
  typeof(h.sec_range) left_sec_range;
  typeof(h.sec_range) right_sec_range;
  typeof(h.v_city_name) left_v_city_name;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.st) left_st;
  typeof(h.st) right_st;
  typeof(h.zip) left_zip;
  typeof(h.zip) right_zip;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LGID31 := le.LGID3;
  SELF.LGID32 := ri.LGID3;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_sbfe_id := le.sbfe_id;
  SELF.right_sbfe_id := ri.sbfe_id;
  SELF.sbfe_id_match_code := MAP(
		le.sbfe_id_isnull OR ri.sbfe_id_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_sbfe_id(le.sbfe_id,ri.sbfe_id));
  INTEGER2 sbfe_id_score_temp := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        SALT30.Fn_Fail_Scale(le.sbfe_id_weight100,s.sbfe_id_switch));
  SELF.left_source_record_id := le.source_record_id;
  SELF.right_source_record_id := ri.source_record_id;
  SELF.source_record_id_match_code := MAP(
		le.source_record_id_isnull OR ri.source_record_id_isnull => SALT30.MatchCode.OneSideNull,
		le.sbfe_id <> ri.sbfe_id => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_source_record_id(le.source_record_id,ri.source_record_id));
  INTEGER2 source_record_id_score_temp := MAP(
                        le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.sbfe_id <> ri.sbfe_id => 0, // Only valid if the context variable is equal
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        0 /* switch0 */);
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_match_code := MAP(
		le.company_name_isnull OR ri.company_name_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_name(le.company_name,ri.company_name));
  SELF.company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT30.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  SELF.duns_number_concept_match_code := MAP(
		(le.duns_number_concept_isnull OR le.active_duns_number_isnull AND le.duns_number_isnull) OR (ri.duns_number_concept_isnull OR ri.active_duns_number_isnull AND ri.duns_number_isnull) => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_duns_number_concept(le.duns_number_concept,ri.duns_number_concept));
  REAL duns_number_concept_score_scale := ( le.duns_number_concept_weight100 + ri.duns_number_concept_weight100 ) / (le.active_duns_number_weight100 + ri.active_duns_number_weight100 + le.duns_number_weight100 + ri.duns_number_weight100); // Scaling factor for this concept
  INTEGER2 duns_number_concept_score_pre := MAP( (le.duns_number_concept_isnull OR le.active_duns_number_isnull AND le.duns_number_isnull) OR (ri.duns_number_concept_isnull OR ri.active_duns_number_isnull AND ri.duns_number_isnull) => 0,
                        le.duns_number_concept = ri.duns_number_concept  => le.duns_number_concept_weight100,
                        0);
  SELF.left_duns_number_concept := le.duns_number_concept;
  SELF.right_duns_number_concept := ri.duns_number_concept;
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
		le.company_fein_isnull OR ri.company_fein_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_fein(le.company_fein,ri.company_fein));
  SELF.company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT30.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_company_charter_number := le.company_charter_number;
  SELF.right_company_charter_number := ri.company_charter_number;
  SELF.company_charter_number_match_code := MAP(
		le.company_charter_number_isnull OR ri.company_charter_number_isnull => SALT30.MatchCode.OneSideNull,
		le.company_inc_state <> ri.company_inc_state => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_company_charter_number(le.company_charter_number,ri.company_charter_number));
  SELF.company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT30.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
		le.cnp_number_isnull OR ri.cnp_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_company_inc_state := le.company_inc_state;
  SELF.right_company_inc_state := ri.company_inc_state;
  SELF.company_inc_state_match_code := MAP(
		le.company_inc_state_isnull OR ri.company_inc_state_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_inc_state(le.company_inc_state,ri.company_inc_state));
  INTEGER2 company_inc_state_score_temp := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state_weight100 = 0 => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT30.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_match_code := MAP(
		le.cnp_btype_isnull OR ri.cnp_btype_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_btype(le.cnp_btype,ri.cnp_btype));
  SELF.cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_nodes_total := le.nodes_total;
  SELF.right_nodes_total := ri.nodes_total;
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
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.active_duns_number_match_code := MAP(
		le.active_duns_number_isnull OR ri.active_duns_number_isnull => SALT30.MatchCode.OneSideNull,
		duns_number_concept_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_active_duns_number(le.active_duns_number,ri.active_duns_number));
  SELF.active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT30.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch))*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  SELF.sbfe_id_score := sbfe_id_score_temp*2.00; 
  SELF.source_record_id_score := source_record_id_score_temp*2.00; 
  SELF.left_duns_number := le.duns_number;
  SELF.right_duns_number := ri.duns_number;
  SELF.duns_number_match_code := MAP(
		le.duns_number_isnull OR ri.duns_number_isnull => SALT30.MatchCode.OneSideNull,
		duns_number_concept_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_duns_number(le.duns_number,ri.duns_number));
  SELF.duns_number_score := MAP(
                        le.duns_number_isnull OR ri.duns_number_isnull => 0,
                        duns_number_concept_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.duns_number = ri.duns_number  => le.duns_number_weight100,
                        0 /* switch0 */)*IF(duns_number_concept_score_scale=0,1,duns_number_concept_score_scale);
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR (SELF.sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100), cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept duns_number_concept
  INTEGER2 duns_number_concept_score_ext := SALT30.ClipScore(MAX(duns_number_concept_score_pre,0) + self.active_duns_number_score + self.duns_number_score);// Score in surrounding context
  INTEGER2 duns_number_concept_score_res := MAX(0,duns_number_concept_score_pre); // At least nothing
  SELF.duns_number_concept_score := duns_number_concept_score_res;
  SELF.company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR (SELF.active_duns_number_score > Config.company_inc_state_OR1_active_duns_number_Force*100) OR (SELF.duns_number_score > Config.company_inc_state_OR2_duns_number_Force*100) OR (SELF.duns_number_concept_score > Config.company_inc_state_OR3_duns_number_concept_Force*100) OR (SELF.company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100) OR (SELF.sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100), company_inc_state_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.company_inc_state_skipped := SELF.company_inc_state_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*SELF.company_name_score // Score if either field propogated
    +MAX(le.duns_number_prop,ri.duns_number_prop)*SELF.duns_number_score // Score if either field propogated
    +if(le.duns_number_concept_prop+ri.duns_number_concept_prop>0,self.duns_number_concept_score*(0+if(le.active_duns_number_prop+ri.active_duns_number_prop>0,1,0)+if(le.duns_number_prop+ri.duns_number_prop>0,1,0))/2,0)
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*SELF.company_charter_number_score // Score if either field propogated
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*SELF.cnp_number_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*SELF.company_inc_state_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.sbfe_id_score + SELF.source_record_id_score + SELF.company_name_score + IF(SELF.duns_number_concept_score>0,MAX(SELF.duns_number_concept_score,SELF.active_duns_number_score + SELF.duns_number_score),SELF.active_duns_number_score + SELF.duns_number_score) + SELF.company_fein_score + SELF.company_charter_number_score + SELF.cnp_number_score + SELF.company_inc_state_score + SELF.cnp_btype_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.LGID3 = RIGHT.LGID31,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.LGID32 = RIGHT.LGID3,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, LGID31, LGID32, -Conf, LOCAL ), LGID31, LGID32, LOCAL ); // LGID32 distributed by join
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT30.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  RETURN AnnotateMatchesFromRecordData(h,im);
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT30.UIDType LGID3;
  DATASET(SALT30.Layout_FieldValueList) sbfe_id_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) duns_number_concept_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_fein_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) nodes_total_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_name_type_derived_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_hasNumber_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) prim_range_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) prim_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) sec_range_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) st_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) zip_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LGID3 := le.LGID3;
  SELF.sbfe_id_values := SALT30.fn_combine_fieldvaluelist(le.sbfe_id_values,ri.sbfe_id_values);
  SELF.source_record_id_values := SALT30.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
  SELF.company_name_values := SALT30.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.duns_number_concept_values := SALT30.fn_combine_fieldvaluelist(le.duns_number_concept_values,ri.duns_number_concept_values);
  SELF.company_fein_values := SALT30.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_charter_number_values := SALT30.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
  SELF.cnp_number_values := SALT30.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.company_inc_state_values := SALT30.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
  SELF.cnp_btype_values := SALT30.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.nodes_total_values := SALT30.fn_combine_fieldvaluelist(le.nodes_total_values,ri.nodes_total_values);
  SELF.company_name_type_derived_values := SALT30.fn_combine_fieldvaluelist(le.company_name_type_derived_values,ri.company_name_type_derived_values);
  SELF.hist_duns_number_values := SALT30.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
  SELF.active_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
  SELF.hist_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
  SELF.foreign_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
  SELF.unk_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
  SELF.cnp_name_values := SALT30.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.cnp_hasNumber_values := SALT30.fn_combine_fieldvaluelist(le.cnp_hasNumber_values,ri.cnp_hasNumber_values);
  SELF.cnp_lowv_values := SALT30.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
  SELF.cnp_translated_values := SALT30.fn_combine_fieldvaluelist(le.cnp_translated_values,ri.cnp_translated_values);
  SELF.cnp_classid_values := SALT30.fn_combine_fieldvaluelist(le.cnp_classid_values,ri.cnp_classid_values);
  SELF.prim_range_values := SALT30.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
  SELF.prim_name_values := SALT30.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
  SELF.sec_range_values := SALT30.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
  SELF.v_city_name_values := SALT30.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
  SELF.st_values := SALT30.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  SELF.zip_values := SALT30.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  SELF.dt_first_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(LGID3) ), LGID3, LOCAL ), LEFT.LGID3 = RIGHT.LGID3, RollValues(LEFT,RIGHT),LOCAL);
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LGID3 := le.LGID3;
  SELF.sbfe_id_Values := IF ( le.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.sbfe_id)}],SALT30.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.source_record_id)}],SALT30.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_name)}],SALT30.Layout_FieldValueList));
  self.duns_number_concept_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) AND le.duns_number  IN SET(s.nulls_duns_number,duns_number),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.active_duns_number) + ' ' + TRIM((SALT30.StrType)le.duns_number)}],SALT30.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_charter_number)}],SALT30.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_number)}],SALT30.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_inc_state)}],SALT30.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_btype)}],SALT30.Layout_FieldValueList));
  SELF.nodes_total_Values := DATASET([{TRIM((SALT30.StrType)le.nodes_total)}],SALT30.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT30.StrType)le.company_name_type_derived)}],SALT30.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList);
  SELF.cnp_hasNumber_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_hasNumber)}],SALT30.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_lowv)}],SALT30.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_translated)}],SALT30.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_classid)}],SALT30.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT30.StrType)le.prim_range)}],SALT30.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT30.StrType)le.prim_name)}],SALT30.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT30.StrType)le.sec_range)}],SALT30.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT30.StrType)le.v_city_name)}],SALT30.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT30.StrType)le.st)}],SALT30.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.LGID3 := le.LGID3;
  SELF.sbfe_id_Values := IF ( le.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.sbfe_id)}],SALT30.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.source_record_id)}],SALT30.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_name)}],SALT30.Layout_FieldValueList));
  self.duns_number_concept_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) AND le.duns_number  IN SET(s.nulls_duns_number,duns_number),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.active_duns_number) + ' ' + TRIM((SALT30.StrType)le.duns_number)}],SALT30.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_charter_number)}],SALT30.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_number)}],SALT30.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_inc_state)}],SALT30.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_btype)}],SALT30.Layout_FieldValueList));
  SELF.nodes_total_Values := DATASET([{TRIM((SALT30.StrType)le.nodes_total)}],SALT30.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT30.StrType)le.company_name_type_derived)}],SALT30.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList);
  SELF.cnp_hasNumber_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_hasNumber)}],SALT30.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_lowv)}],SALT30.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_translated)}],SALT30.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_classid)}],SALT30.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT30.StrType)le.prim_range)}],SALT30.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT30.StrType)le.prim_name)}],SALT30.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT30.StrType)le.sec_range)}],SALT30.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT30.StrType)le.v_city_name)}],SALT30.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT30.StrType)le.st)}],SALT30.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.company_name := if ( le.company_name_prop>0, (TYPEOF(le.company_name))'', le.company_name ); // Blank if propogated
    self.company_name_isnull := le.company_name_prop>0 OR le.company_name_isnull;
    self.company_name_prop := 0; // Avoid reducing score later
    self.duns_number := if ( le.duns_number_prop>0, (TYPEOF(le.duns_number))'', le.duns_number ); // Blank if propogated
    self.duns_number_isnull := le.duns_number_prop>0 OR le.duns_number_isnull;
    self.duns_number_prop := 0; // Avoid reducing score later
    self.duns_number_concept := if ( le.duns_number_concept_prop>0, 0, le.duns_number_concept ); // Blank if propogated
    self.duns_number_concept_isnull := true; // Flag as null to scoring
    self.duns_number_concept_prop := 0; // Avoid reducing score later
    self.company_charter_number := if ( le.company_charter_number_prop>0, (TYPEOF(le.company_charter_number))'', le.company_charter_number ); // Blank if propogated
    self.company_charter_number_isnull := le.company_charter_number_prop>0 OR le.company_charter_number_isnull;
    self.company_charter_number_prop := 0; // Avoid reducing score later
    self.cnp_number := if ( le.cnp_number_prop>0, (TYPEOF(le.cnp_number))'', le.cnp_number ); // Blank if propogated
    self.cnp_number_isnull := le.cnp_number_prop>0 OR le.cnp_number_isnull;
    self.cnp_number_prop := 0; // Avoid reducing score later
    self.company_inc_state := if ( le.company_inc_state_prop>0, (TYPEOF(le.company_inc_state))'', le.company_inc_state ); // Blank if propogated
    self.company_inc_state_isnull := le.company_inc_state_prop>0 OR le.company_inc_state_isnull;
    self.company_inc_state_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 sbfe_id_size := 0;
  UNSIGNED1 source_record_id_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 duns_number_concept_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_charter_number_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 company_inc_state_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.sbfe_id_size := SALT30.Fn_SwitchSpec(s.sbfe_id_switch,count(le.sbfe_id_values));
  SELF.source_record_id_size := SALT30.Fn_SwitchSpec(s.source_record_id_switch,count(le.source_record_id_values));
  SELF.company_name_size := SALT30.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.duns_number_concept_size := SALT30.Fn_SwitchSpec(s.duns_number_concept_switch,count(le.duns_number_concept_values));
  SELF.company_fein_size := SALT30.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_charter_number_size := SALT30.Fn_SwitchSpec(s.company_charter_number_switch,count(le.company_charter_number_values));
  SELF.cnp_number_size := SALT30.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.company_inc_state_size := SALT30.Fn_SwitchSpec(s.company_inc_state_switch,count(le.company_inc_state_values));
  SELF.cnp_btype_size := SALT30.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.sbfe_id_size+t.source_record_id_size+t.company_name_size+t.duns_number_concept_size+t.company_fein_size+t.company_charter_number_size+t.cnp_number_size+t.company_inc_state_size+t.cnp_btype_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;

