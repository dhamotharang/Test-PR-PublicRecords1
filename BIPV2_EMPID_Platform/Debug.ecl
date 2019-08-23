// Various routines to assist in debugging
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT30,ut,std;
EXPORT Debug(DATASET(layout_EmpID) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  typeof(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  BOOLEAN prim_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_name) right_prim_name;
  typeof(h.lname) left_lname;
  INTEGER1 lname_match_code;
  INTEGER2 lname_score;
  BOOLEAN lname_skipped := FALSE; // True if FORCE blocks match
  typeof(h.lname) right_lname;
  typeof(h.contact_phone) left_contact_phone;
  INTEGER1 contact_phone_match_code;
  INTEGER2 contact_phone_score;
  typeof(h.contact_phone) right_contact_phone;
  typeof(h.contact_did) left_contact_did;
  INTEGER1 contact_did_match_code;
  INTEGER2 contact_did_score;
  BOOLEAN contact_did_skipped := FALSE; // True if FORCE blocks match
  typeof(h.contact_did) right_contact_did;
  typeof(h.cname_devanitize) left_cname_devanitize;
  INTEGER1 cname_devanitize_match_code;
  INTEGER2 cname_devanitize_score;
  BOOLEAN cname_devanitize_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cname_devanitize) right_cname_devanitize;
  typeof(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.fname) left_fname;
  INTEGER1 fname_match_code;
  INTEGER2 fname_score;
  BOOLEAN fname_skipped := FALSE; // True if FORCE blocks match
  typeof(h.fname) right_fname;
  typeof(h.contact_ssn) left_contact_ssn;
  INTEGER1 contact_ssn_match_code;
  INTEGER2 contact_ssn_score;
  BOOLEAN contact_ssn_skipped := FALSE; // True if FORCE blocks match
  typeof(h.contact_ssn) right_contact_ssn;
  typeof(h.isCorpEnhanced) left_isCorpEnhanced;
  typeof(h.isCorpEnhanced) right_isCorpEnhanced;
  typeof(h.contact_job_title_derived) left_contact_job_title_derived;
  typeof(h.contact_job_title_derived) right_contact_job_title_derived;
  typeof(h.zip4) left_zip4;
  typeof(h.zip4) right_zip4;
  typeof(h.company_name) left_company_name;
  typeof(h.company_name) right_company_name;
  typeof(h.sec_range) left_sec_range;
  typeof(h.sec_range) right_sec_range;
  typeof(h.v_city_name) left_v_city_name;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.st) left_st;
  typeof(h.st) right_st;
  typeof(h.company_inc_state) left_company_inc_state;
  typeof(h.company_inc_state) right_company_inc_state;
  typeof(h.company_charter_number) left_company_charter_number;
  typeof(h.company_charter_number) right_company_charter_number;
  typeof(h.active_duns_number) left_active_duns_number;
  typeof(h.active_duns_number) right_active_duns_number;
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
  typeof(h.company_fein) left_company_fein;
  typeof(h.company_fein) right_company_fein;
  typeof(h.cnp_btype) left_cnp_btype;
  typeof(h.cnp_btype) right_cnp_btype;
  typeof(h.cnp_name) left_cnp_name;
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.company_name_type_derived) left_company_name_type_derived;
  typeof(h.company_name_type_derived) right_company_name_type_derived;
  typeof(h.company_bdid) left_company_bdid;
  typeof(h.company_bdid) right_company_bdid;
  typeof(h.nodes_total) left_nodes_total;
  typeof(h.nodes_total) right_nodes_total;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.EmpID1 := le.EmpID;
  SELF.EmpID2 := ri.EmpID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
		le.prim_range_isnull OR ri.prim_range_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
		le.prim_name_isnull OR ri.prim_name_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_match_code := MAP(
		le.lname_isnull OR ri.lname_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_lname(le.lname,ri.lname));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT30.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_contact_phone := le.contact_phone;
  SELF.right_contact_phone := ri.contact_phone;
  SELF.contact_phone_match_code := MAP(
		le.contact_phone_isnull OR ri.contact_phone_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_contact_phone(le.contact_phone,ri.contact_phone));
  SELF.contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  SELF.left_contact_did := le.contact_did;
  SELF.right_contact_did := ri.contact_did;
  SELF.contact_did_match_code := MAP(
		le.contact_did_isnull OR ri.contact_did_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_contact_did(le.contact_did,ri.contact_did));
  INTEGER2 contact_did_score_temp := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  SELF.left_cname_devanitize := le.cname_devanitize;
  SELF.right_cname_devanitize := ri.cname_devanitize;
  SELF.cname_devanitize_match_code := MAP(
		le.cname_devanitize_isnull OR ri.cname_devanitize_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_cname_devanitize(le.cname_devanitize,ri.cname_devanitize));
  INTEGER2 cname_devanitize_score_temp := MAP(
                        le.cname_devanitize_isnull OR ri.cname_devanitize_isnull OR le.cname_devanitize_weight100 = 0 => 0,
                        le.cname_devanitize = ri.cname_devanitize  => le.cname_devanitize_weight100,
                        SALT30.MatchBagOfWords(le.cname_devanitize,ri.cname_devanitize,2128912,1));
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
		le.zip_isnull OR ri.zip_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT30.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_match_code := MAP(
		le.fname_isnull OR ri.fname_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_fname(le.fname,ri.fname));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT30.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT30.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_match_code := MAP(
		le.contact_ssn_isnull OR ri.contact_ssn_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_contact_ssn(le.contact_ssn,ri.contact_ssn));
  INTEGER2 contact_ssn_score_temp := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT30.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_isCorpEnhanced := le.isCorpEnhanced;
  SELF.right_isCorpEnhanced := ri.isCorpEnhanced;
  SELF.left_contact_job_title_derived := le.contact_job_title_derived;
  SELF.right_contact_job_title_derived := ri.contact_job_title_derived;
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
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
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.left_company_name_type_derived := le.company_name_type_derived;
  SELF.right_company_name_type_derived := ri.company_name_type_derived;
  SELF.left_company_bdid := le.company_bdid;
  SELF.right_company_bdid := ri.company_bdid;
  SELF.left_nodes_total := le.nodes_total;
  SELF.right_nodes_total := ri.nodes_total;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
  SELF.lname_score := IF ( lname_score_temp > Config.lname_Force * 100, lname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.lname_skipped := SELF.lname_score < -5000;// Enforce FORCE parameter
  SELF.contact_did_score := IF ( contact_did_score_temp >= Config.contact_did_Force * 100, contact_did_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.contact_did_skipped := SELF.contact_did_score < -5000;// Enforce FORCE parameter
  SELF.cname_devanitize_score := IF ( cname_devanitize_score_temp > Config.cname_devanitize_Force * 100, cname_devanitize_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cname_devanitize_skipped := SELF.cname_devanitize_score < -5000;// Enforce FORCE parameter
  SELF.fname_score := IF ( fname_score_temp > Config.fname_Force * 100, fname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.fname_skipped := SELF.fname_score < -5000;// Enforce FORCE parameter
  SELF.contact_ssn_score := IF ( contact_ssn_score_temp >= Config.contact_ssn_Force * 100, contact_ssn_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.contact_ssn_skipped := SELF.contact_ssn_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*SELF.prim_name_score // Score if either field propogated
    +MAX(le.cname_devanitize_prop,ri.cname_devanitize_prop)*SELF.cname_devanitize_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.prim_range_score + SELF.prim_name_score + SELF.lname_score + SELF.contact_phone_score + SELF.contact_did_score + SELF.cname_devanitize_score + SELF.zip_score + SELF.fname_score + SELF.contact_ssn_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.EmpID = RIGHT.EmpID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.EmpID2 = RIGHT.EmpID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, EmpID1, EmpID2, -Conf, LOCAL ), EmpID1, EmpID2, LOCAL ); // EmpID2 distributed by join
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
  SALT30.UIDType EmpID;
  DATASET(SALT30.Layout_FieldValueList) prim_range_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) prim_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) lname_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) contact_phone_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) contact_did_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cname_devanitize_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) zip_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) fname_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) isCorpEnhanced_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) contact_job_title_derived_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) zip4_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) sec_range_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) st_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_fein_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_name_type_derived_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) nodes_total_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.EmpID := le.EmpID;
  SELF.prim_range_values := SALT30.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
  SELF.prim_name_values := SALT30.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
  SELF.lname_values := SALT30.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  SELF.contact_phone_values := SALT30.fn_combine_fieldvaluelist(le.contact_phone_values,ri.contact_phone_values);
  SELF.contact_did_values := SALT30.fn_combine_fieldvaluelist(le.contact_did_values,ri.contact_did_values);
  SELF.cname_devanitize_values := SALT30.fn_combine_fieldvaluelist(le.cname_devanitize_values,ri.cname_devanitize_values);
  SELF.zip_values := SALT30.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  SELF.fname_values := SALT30.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  SELF.contact_ssn_values := SALT30.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
  SELF.isCorpEnhanced_values := SALT30.fn_combine_fieldvaluelist(le.isCorpEnhanced_values,ri.isCorpEnhanced_values);
  SELF.contact_job_title_derived_values := SALT30.fn_combine_fieldvaluelist(le.contact_job_title_derived_values,ri.contact_job_title_derived_values);
  SELF.zip4_values := SALT30.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  SELF.company_name_values := SALT30.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.sec_range_values := SALT30.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
  SELF.v_city_name_values := SALT30.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
  SELF.st_values := SALT30.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  SELF.company_inc_state_values := SALT30.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
  SELF.company_charter_number_values := SALT30.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
  SELF.active_duns_number_values := SALT30.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  SELF.hist_duns_number_values := SALT30.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
  SELF.active_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
  SELF.hist_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
  SELF.foreign_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
  SELF.unk_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
  SELF.company_fein_values := SALT30.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.cnp_btype_values := SALT30.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.cnp_name_values := SALT30.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.company_name_type_derived_values := SALT30.fn_combine_fieldvaluelist(le.company_name_type_derived_values,ri.company_name_type_derived_values);
  SELF.company_bdid_values := SALT30.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
  SELF.nodes_total_values := SALT30.fn_combine_fieldvaluelist(le.nodes_total_values,ri.nodes_total_values);
  SELF.dt_first_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(EmpID) ), EmpID, LOCAL ), LEFT.EmpID = RIGHT.EmpID, RollValues(LEFT,RIGHT),LOCAL);
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.EmpID := le.EmpID;
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.prim_range)}],SALT30.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.prim_name)}],SALT30.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.lname)}],SALT30.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_phone)}],SALT30.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( le.contact_did  IN SET(s.nulls_contact_did,contact_did),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_did)}],SALT30.Layout_FieldValueList));
  SELF.cname_devanitize_Values := IF ( le.cname_devanitize  IN SET(s.nulls_cname_devanitize,cname_devanitize),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cname_devanitize)}],SALT30.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.fname)}],SALT30.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_ssn)}],SALT30.Layout_FieldValueList));
  SELF.isCorpEnhanced_Values := DATASET([{TRIM((SALT30.StrType)le.isCorpEnhanced)}],SALT30.Layout_FieldValueList);
  SELF.contact_job_title_derived_Values := DATASET([{TRIM((SALT30.StrType)le.contact_job_title_derived)}],SALT30.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT30.StrType)le.zip4)}],SALT30.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT30.StrType)le.company_name)}],SALT30.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT30.StrType)le.sec_range)}],SALT30.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT30.StrType)le.v_city_name)}],SALT30.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT30.StrType)le.st)}],SALT30.Layout_FieldValueList);
  SELF.company_inc_state_Values := DATASET([{TRIM((SALT30.StrType)le.company_inc_state)}],SALT30.Layout_FieldValueList);
  SELF.company_charter_number_Values := DATASET([{TRIM((SALT30.StrType)le.company_charter_number)}],SALT30.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.active_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.company_fein_Values := DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList);
  SELF.cnp_btype_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_btype)}],SALT30.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT30.StrType)le.company_name_type_derived)}],SALT30.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT30.StrType)le.company_bdid)}],SALT30.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT30.StrType)le.nodes_total)}],SALT30.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.EmpID := le.EmpID;
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.prim_range)}],SALT30.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.prim_name)}],SALT30.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.lname)}],SALT30.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_phone)}],SALT30.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( le.contact_did  IN SET(s.nulls_contact_did,contact_did),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_did)}],SALT30.Layout_FieldValueList));
  SELF.cname_devanitize_Values := IF ( le.cname_devanitize  IN SET(s.nulls_cname_devanitize,cname_devanitize),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cname_devanitize)}],SALT30.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.fname)}],SALT30.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.contact_ssn)}],SALT30.Layout_FieldValueList));
  SELF.isCorpEnhanced_Values := DATASET([{TRIM((SALT30.StrType)le.isCorpEnhanced)}],SALT30.Layout_FieldValueList);
  SELF.contact_job_title_derived_Values := DATASET([{TRIM((SALT30.StrType)le.contact_job_title_derived)}],SALT30.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT30.StrType)le.zip4)}],SALT30.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT30.StrType)le.company_name)}],SALT30.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT30.StrType)le.sec_range)}],SALT30.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT30.StrType)le.v_city_name)}],SALT30.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT30.StrType)le.st)}],SALT30.Layout_FieldValueList);
  SELF.company_inc_state_Values := DATASET([{TRIM((SALT30.StrType)le.company_inc_state)}],SALT30.Layout_FieldValueList);
  SELF.company_charter_number_Values := DATASET([{TRIM((SALT30.StrType)le.company_charter_number)}],SALT30.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.active_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList);
  SELF.company_fein_Values := DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList);
  SELF.cnp_btype_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_btype)}],SALT30.Layout_FieldValueList);
  SELF.cnp_name_Values := DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList);
  SELF.company_name_type_derived_Values := DATASET([{TRIM((SALT30.StrType)le.company_name_type_derived)}],SALT30.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT30.StrType)le.company_bdid)}],SALT30.Layout_FieldValueList);
  SELF.nodes_total_Values := DATASET([{TRIM((SALT30.StrType)le.nodes_total)}],SALT30.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.prim_name := if ( le.prim_name_prop>0, (TYPEOF(le.prim_name))'', le.prim_name ); // Blank if propogated
    self.prim_name_isnull := le.prim_name_prop>0 OR le.prim_name_isnull;
    self.prim_name_prop := 0; // Avoid reducing score later
    self.cname_devanitize := if ( le.cname_devanitize_prop>0, (TYPEOF(le.cname_devanitize))'', le.cname_devanitize ); // Blank if propogated
    self.cname_devanitize_isnull := le.cname_devanitize_prop>0 OR le.cname_devanitize_isnull;
    self.cname_devanitize_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 contact_phone_size := 0;
  UNSIGNED1 contact_did_size := 0;
  UNSIGNED1 cname_devanitize_size := 0;
  UNSIGNED1 zip_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.prim_range_size := SALT30.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.prim_name_size := SALT30.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.lname_size := SALT30.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.contact_phone_size := SALT30.Fn_SwitchSpec(s.contact_phone_switch,count(le.contact_phone_values));
  SELF.contact_did_size := SALT30.Fn_SwitchSpec(s.contact_did_switch,count(le.contact_did_values));
  SELF.cname_devanitize_size := SALT30.Fn_SwitchSpec(s.cname_devanitize_switch,count(le.cname_devanitize_values));
  SELF.zip_size := SALT30.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.fname_size := SALT30.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.contact_ssn_size := SALT30.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.prim_range_size+t.prim_name_size+t.lname_size+t.contact_phone_size+t.contact_did_size+t.cname_devanitize_size+t.zip_size+t.fname_size+t.contact_ssn_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;

