// Various routines to assist in debugging
 
IMPORT SALT32,ut,std;
EXPORT Debug(DATASET(layout_POWID) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  INTEGER2 Attribute_Conf := 0; // Score provided by attribute files
  SALT32.StrType   Matching_Attributes := ''; // Keys from attribute files which match
  TYPEOF(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  BOOLEAN prim_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.RID_If_Big_Biz) left_RID_If_Big_Biz;
  INTEGER1 RID_If_Big_Biz_match_code;
  INTEGER2 RID_If_Big_Biz_score;
  BOOLEAN RID_If_Big_Biz_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.RID_If_Big_Biz) right_RID_If_Big_Biz;
  TYPEOF(h.cnp_name) left_cnp_name;
  INTEGER1 cnp_name_match_code;
  INTEGER2 cnp_name_score;
  BOOLEAN cnp_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cnp_name) right_cnp_name;
  TYPEOF(h.company_name) left_company_name;
  INTEGER1 company_name_match_code;
  INTEGER2 company_name_score;
  BOOLEAN company_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.company_name) right_company_name;
  TYPEOF(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cnp_number) right_cnp_number;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.num_legal_names) left_num_legal_names;
  TYPEOF(h.num_legal_names) right_num_legal_names;
  TYPEOF(h.num_incs) left_num_incs;
  TYPEOF(h.num_incs) right_num_incs;
  TYPEOF(h.nodes_total) left_nodes_total;
  TYPEOF(h.nodes_total) right_nodes_total;
  TYPEOF(h.zip4) left_zip4;
  TYPEOF(h.zip4) right_zip4;
  TYPEOF(h.sec_range) left_sec_range;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.v_city_name) left_v_city_name;
  TYPEOF(h.v_city_name) right_v_city_name;
  TYPEOF(h.st) left_st;
  TYPEOF(h.st) right_st;
  TYPEOF(h.company_inc_state) left_company_inc_state;
  TYPEOF(h.company_inc_state) right_company_inc_state;
  TYPEOF(h.company_charter_number) left_company_charter_number;
  TYPEOF(h.company_charter_number) right_company_charter_number;
  TYPEOF(h.active_duns_number) left_active_duns_number;
  TYPEOF(h.active_duns_number) right_active_duns_number;
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
  TYPEOF(h.company_fein) left_company_fein;
  TYPEOF(h.company_fein) right_company_fein;
  TYPEOF(h.cnp_btype) left_cnp_btype;
  TYPEOF(h.cnp_btype) right_cnp_btype;
  TYPEOF(h.company_name_type_derived) left_company_name_type_derived;
  TYPEOF(h.company_name_type_derived) right_company_name_type_derived;
  TYPEOF(h.company_bdid) left_company_bdid;
  TYPEOF(h.company_bdid) right_company_bdid;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
		le.prim_range_isnull OR ri.prim_range_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
		le.prim_name_isnull OR ri.prim_name_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_RID_If_Big_Biz := le.RID_If_Big_Biz;
  SELF.right_RID_If_Big_Biz := ri.RID_If_Big_Biz;
  SELF.RID_If_Big_Biz_match_code := MAP(
		le.RID_If_Big_Biz_isnull OR ri.RID_If_Big_Biz_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_RID_If_Big_Biz(le.RID_If_Big_Biz,ri.RID_If_Big_Biz));
  INTEGER2 RID_If_Big_Biz_score_temp := MAP(
                        le.RID_If_Big_Biz_isnull OR ri.RID_If_Big_Biz_isnull => 0,
                        le.RID_If_Big_Biz = ri.RID_If_Big_Biz  => le.RID_If_Big_Biz_weight100,
                        SALT32.Fn_Fail_Scale(le.RID_If_Big_Biz_weight100,s.RID_If_Big_Biz_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_match_code := MAP(
		le.cnp_name_isnull OR ri.cnp_name_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_name(le.cnp_name,ri.cnp_name));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_match_code := MAP(
		le.company_name_isnull OR ri.company_name_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_company_name(le.company_name,ri.company_name, le.company_name_len, ri.company_name_len));
  INTEGER2 company_name_score_temp := MAP(
                        le.company_name_isnull OR ri.company_name_isnull OR le.company_name_weight100 = 0 => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT32.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
		le.cnp_number_isnull OR ri.cnp_number_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
		le.zip_isnull OR ri.zip_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT32.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  SELF.left_num_legal_names := le.num_legal_names;
  SELF.right_num_legal_names := ri.num_legal_names;
  SELF.left_num_incs := le.num_incs;
  SELF.right_num_incs := ri.num_incs;
  SELF.left_nodes_total := le.nodes_total;
  SELF.right_nodes_total := ri.nodes_total;
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.left_company_inc_state := le.company_inc_state;
  SELF.right_company_inc_state := ri.company_inc_state;
  SELF.left_company_charter_number := le.company_charter_number;
  SELF.right_company_charter_number := ri.company_charter_number;
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
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
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.left_company_name_type_derived := le.company_name_type_derived;
  SELF.right_company_name_type_derived := ri.company_name_type_derived;
  SELF.left_company_bdid := le.company_bdid;
  SELF.right_company_bdid := ri.company_bdid;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.prim_range_score := IF ( le.prim_range = ri.prim_range, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
  SELF.RID_If_Big_Biz_score := IF ( RID_If_Big_Biz_score_temp >= Config.RID_If_Big_Biz_Force * 100, RID_If_Big_Biz_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.RID_If_Big_Biz_skipped := SELF.RID_If_Big_Biz_score < -5000;// Enforce FORCE parameter
  SELF.cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_name_skipped := SELF.cnp_name_score < -5000;// Enforce FORCE parameter
  SELF.company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.company_name_skipped := SELF.company_name_score < -5000;// Enforce FORCE parameter
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*SELF.prim_name_score // Score if either field propogated
    +MAX(le.RID_If_Big_Biz_prop,ri.RID_If_Big_Biz_prop)*SELF.RID_If_Big_Biz_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*SELF.company_name_score // Score if either field propogated
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*SELF.cnp_number_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.prim_range_score + SELF.prim_name_score + SELF.RID_If_Big_Biz_score + SELF.cnp_name_score + SELF.company_name_score + SELF.cnp_number_score + SELF.zip_score) / 100 + outside;
END;
SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM
    SELF.Attribute_Conf := ri.Conf;
    SELF.Matching_Attributes := ri.Source_Id;
    SELF.Conf := le.Conf + ri.Conf;
    SELF := le;
  END;
  RETURN JOIN(am,ia,LEFT.POWID1=RIGHT.POWID1 AND LEFT.POWID2=RIGHT.POWID2,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.POWID = RIGHT.POWID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.POWID2 = RIGHT.POWID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, POWID1, POWID2, -Conf, LOCAL ), POWID1, POWID2, LOCAL ); // POWID2 distributed by join
  RETURN AppendAttribs( d, ia );
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT32.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rcid1=RIGHT.rcid1 AND LEFT.rcid2=RIGHT.rcid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN AppendAttribs( annotated_matches, ia );
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT32.UIDType POWID;
  DATASET(SALT32.Layout_FieldValueList) prim_range_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) prim_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) RID_If_Big_Biz_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) zip_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) num_legal_names_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) num_incs_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) nodes_total_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) zip4_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) sec_range_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) st_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_fein_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_name_type_derived_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.POWID := le.POWID;
    SELF.prim_range_values := SALT32.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.prim_name_values := SALT32.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.RID_If_Big_Biz_values := SALT32.fn_combine_fieldvaluelist(le.RID_If_Big_Biz_values,ri.RID_If_Big_Biz_values);
    SELF.cnp_name_values := SALT32.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.company_name_values := SALT32.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.cnp_number_values := SALT32.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.zip_values := SALT32.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.num_legal_names_values := SALT32.fn_combine_fieldvaluelist(le.num_legal_names_values,ri.num_legal_names_values);
    SELF.num_incs_values := SALT32.fn_combine_fieldvaluelist(le.num_incs_values,ri.num_incs_values);
    SELF.nodes_total_values := SALT32.fn_combine_fieldvaluelist(le.nodes_total_values,ri.nodes_total_values);
    SELF.zip4_values := SALT32.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
    SELF.sec_range_values := SALT32.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.v_city_name_values := SALT32.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
    SELF.st_values := SALT32.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.company_inc_state_values := SALT32.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
    SELF.company_charter_number_values := SALT32.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
    SELF.active_duns_number_values := SALT32.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
    SELF.hist_duns_number_values := SALT32.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
    SELF.active_domestic_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
    SELF.hist_domestic_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
    SELF.foreign_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
    SELF.unk_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
    SELF.company_fein_values := SALT32.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.cnp_btype_values := SALT32.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.company_name_type_derived_values := SALT32.fn_combine_fieldvaluelist(le.company_name_type_derived_values,ri.company_name_type_derived_values);
    SELF.company_bdid_values := SALT32.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
    SELF.dt_first_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(POWID) ), POWID, LOCAL ), LEFT.POWID = RIGHT.POWID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.POWID := le.POWID;
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.RID_If_Big_Biz_values := SORT(le.RID_If_Big_Biz_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.num_legal_names_values := SORT(le.num_legal_names_values, -cnt, val, LOCAL);
    SELF.num_incs_values := SORT(le.num_incs_values, -cnt, val, LOCAL);
    SELF.nodes_total_values := SORT(le.nodes_total_values, -cnt, val, LOCAL);
    SELF.zip4_values := SORT(le.zip4_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.v_city_name_values := SORT(le.v_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.company_inc_state_values := SORT(le.company_inc_state_values, -cnt, val, LOCAL);
    SELF.company_charter_number_values := SORT(le.company_charter_number_values, -cnt, val, LOCAL);
    SELF.active_duns_number_values := SORT(le.active_duns_number_values, -cnt, val, LOCAL);
    SELF.hist_duns_number_values := SORT(le.hist_duns_number_values, -cnt, val, LOCAL);
    SELF.active_domestic_corp_key_values := SORT(le.active_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.hist_domestic_corp_key_values := SORT(le.hist_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.foreign_corp_key_values := SORT(le.foreign_corp_key_values, -cnt, val, LOCAL);
    SELF.unk_corp_key_values := SORT(le.unk_corp_key_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.company_name_type_derived_values := SORT(le.company_name_type_derived_values, -cnt, val, LOCAL);
    SELF.company_bdid_values := SORT(le.company_bdid_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.prim_range)}],SALT32.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.prim_name)}],SALT32.Layout_FieldValueList));
  SELF.RID_If_Big_Biz_Values := IF ( le.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR le.RID_If_Big_Biz = (TYPEOF(le.RID_If_Big_Biz))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.RID_If_Big_Biz)}],SALT32.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_name)}],SALT32.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_number)}],SALT32.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList));
  SELF.num_legal_names_Values := DATASET([{TRIM((SALT32.StrType)le.num_legal_names)}],SALT32.Layout_FieldValueList);
  SELF.num_incs_Values := DATASET([{TRIM((SALT32.StrType)le.num_incs)}],SALT32.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT32.StrType)le.nodes_total)}],SALT32.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT32.StrType)le.zip4)}],SALT32.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT32.StrType)le.sec_range)}],SALT32.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT32.StrType)le.v_city_name)}],SALT32.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT32.StrType)le.st)}],SALT32.Layout_FieldValueList);
  SELF.company_inc_state_Values := DATASET([{TRIM((SALT32.StrType)le.company_inc_state)}],SALT32.Layout_FieldValueList);
  SELF.company_charter_number_Values := DATASET([{TRIM((SALT32.StrType)le.company_charter_number)}],SALT32.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.hist_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.hist_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.foreign_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.unk_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.company_fein_Values := DATASET([{TRIM((SALT32.StrType)le.company_fein)}],SALT32.Layout_FieldValueList);
  SELF.cnp_btype_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_btype)}],SALT32.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT32.StrType)le.company_name_type_derived)}],SALT32.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT32.StrType)le.company_bdid)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.prim_range)}],SALT32.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.prim_name)}],SALT32.Layout_FieldValueList));
  SELF.RID_If_Big_Biz_Values := IF ( le.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR le.RID_If_Big_Biz = (TYPEOF(le.RID_If_Big_Biz))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.RID_If_Big_Biz)}],SALT32.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_name)}],SALT32.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_number)}],SALT32.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList));
  SELF.num_legal_names_Values := DATASET([{TRIM((SALT32.StrType)le.num_legal_names)}],SALT32.Layout_FieldValueList);
  SELF.num_incs_Values := DATASET([{TRIM((SALT32.StrType)le.num_incs)}],SALT32.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT32.StrType)le.nodes_total)}],SALT32.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT32.StrType)le.zip4)}],SALT32.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT32.StrType)le.sec_range)}],SALT32.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT32.StrType)le.v_city_name)}],SALT32.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT32.StrType)le.st)}],SALT32.Layout_FieldValueList);
  SELF.company_inc_state_Values := DATASET([{TRIM((SALT32.StrType)le.company_inc_state)}],SALT32.Layout_FieldValueList);
  SELF.company_charter_number_Values := DATASET([{TRIM((SALT32.StrType)le.company_charter_number)}],SALT32.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.hist_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.hist_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.foreign_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.unk_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.company_fein_Values := DATASET([{TRIM((SALT32.StrType)le.company_fein)}],SALT32.Layout_FieldValueList);
  SELF.cnp_btype_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_btype)}],SALT32.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT32.StrType)le.company_name_type_derived)}],SALT32.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT32.StrType)le.company_bdid)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.prim_name := if ( le.prim_name_prop>0, (TYPEOF(le.prim_name))'', le.prim_name ); // Blank if propogated
    self.prim_name_isnull := le.prim_name_prop>0 OR le.prim_name_isnull;
    self.prim_name_prop := 0; // Avoid reducing score later
    self.RID_If_Big_Biz := if ( le.RID_If_Big_Biz_prop>0, (TYPEOF(le.RID_If_Big_Biz))'', le.RID_If_Big_Biz ); // Blank if propogated
    self.RID_If_Big_Biz_isnull := le.RID_If_Big_Biz_prop>0 OR le.RID_If_Big_Biz_isnull;
    self.RID_If_Big_Biz_prop := 0; // Avoid reducing score later
    self.company_name := if ( le.company_name_prop>0, (TYPEOF(le.company_name))'', le.company_name ); // Blank if propogated
    self.company_name_isnull := le.company_name_prop>0 OR le.company_name_isnull;
    self.company_name_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 prim_range_size := 0;
  UNSIGNED1 prim_name_size := 0;
  UNSIGNED1 RID_If_Big_Biz_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 zip_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.prim_range_size := SALT32.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.prim_name_size := SALT32.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.RID_If_Big_Biz_size := SALT32.Fn_SwitchSpec(s.RID_If_Big_Biz_switch,count(le.RID_If_Big_Biz_values));
  SELF.cnp_name_size := SALT32.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.company_name_size := SALT32.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.cnp_number_size := SALT32.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.zip_size := SALT32.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.prim_range_size+t.prim_name_size+t.RID_If_Big_Biz_size+t.cnp_name_size+t.company_name_size+t.cnp_number_size+t.zip_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
