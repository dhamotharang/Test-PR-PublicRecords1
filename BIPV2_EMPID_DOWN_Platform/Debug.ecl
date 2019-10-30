// Various routines to assist in debugging
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT32,ut,std;
EXPORT Debug(DATASET(layout_EmpID) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.orgid) left_orgid;
  INTEGER1 orgid_match_code;
  INTEGER2 orgid_score;
  BOOLEAN orgid_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.orgid) right_orgid;
  TYPEOF(h.contact_ssn) left_contact_ssn;
  INTEGER1 contact_ssn_match_code;
  INTEGER2 contact_ssn_score;
  TYPEOF(h.contact_ssn) right_contact_ssn;
  TYPEOF(h.contact_did) left_contact_did;
  INTEGER1 contact_did_match_code;
  INTEGER2 contact_did_score;
  TYPEOF(h.contact_did) right_contact_did;
  TYPEOF(h.lname) left_lname;
  INTEGER1 lname_match_code;
  INTEGER2 lname_score;
  BOOLEAN lname_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.lname) right_lname;
  TYPEOF(h.mname) left_mname;
  INTEGER1 mname_match_code;
  INTEGER2 mname_score;
  BOOLEAN mname_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.mname) right_mname;
  TYPEOF(h.fname) left_fname;
  INTEGER1 fname_match_code;
  INTEGER2 fname_score;
  BOOLEAN fname_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.fname) right_fname;
  TYPEOF(h.name_suffix) left_name_suffix;
  INTEGER1 name_suffix_match_code;
  INTEGER2 name_suffix_score;
  BOOLEAN name_suffix_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.name_suffix) right_name_suffix;
  TYPEOF(h.isContact) left_isContact;
  TYPEOF(h.isContact) right_isContact;
  TYPEOF(h.contact_phone) left_contact_phone;
  TYPEOF(h.contact_phone) right_contact_phone;
  TYPEOF(h.contact_email) left_contact_email;
  TYPEOF(h.contact_email) right_contact_email;
  TYPEOF(h.company_name) left_company_name;
  TYPEOF(h.company_name) right_company_name;
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
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.EmpID1 := le.EmpID;
  SELF.EmpID2 := ri.EmpID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_orgid := le.orgid;
  SELF.right_orgid := ri.orgid;
  SELF.orgid_match_code := MAP(
		le.orgid_isnull OR ri.orgid_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_orgid(le.orgid,ri.orgid));
  INTEGER2 orgid_score_temp := MAP(
                        le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT32.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_match_code := MAP(
		le.contact_ssn_isnull OR ri.contact_ssn_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_contact_ssn(le.contact_ssn,ri.contact_ssn, le.contact_ssn_len, ri.contact_ssn_len));
  SELF.contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT32.WithinEditNew(le.contact_ssn,le.contact_ssn_len,ri.contact_ssn,ri.contact_ssn_len,1,0) => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_e1_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_e1_cnt),
                        le.contact_ssn_Right4 = ri.contact_ssn_Right4 => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_Right4_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_Right4_cnt),
                        SALT32.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_contact_did := le.contact_did;
  SELF.right_contact_did := ri.contact_did;
  SELF.contact_did_match_code := MAP(
		le.contact_did_isnull OR ri.contact_did_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_contact_did(le.contact_did,ri.contact_did));
  SELF.contact_did_score := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT32.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_match_code := MAP(
		le.lname_isnull OR ri.lname_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_lname(le.lname,ri.lname, le.lname_len, ri.lname_len));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname OR SALT32.HyphenMatch(le.lname,ri.lname,3)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT32.WithinEditNew(le.lname,le.lname_len,ri.lname,ri.lname_len,1,0) => SALT32.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e1_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_match_code := MAP(
		le.mname_isnull OR ri.mname_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_mname(le.mname,ri.mname, le.mname_len, ri.mname_len));
  INTEGER2 mname_score_temp := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT32.WithinEditNew(le.mname,le.mname_len,ri.mname,ri.mname_len,1,0) => SALT32.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT32.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_match_code := MAP(
		le.fname_isnull OR ri.fname_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_fname(le.fname,ri.fname, le.fname_len, ri.fname_len));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT32.WithinEditNew(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT32.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_name_suffix := le.name_suffix;
  SELF.right_name_suffix := ri.name_suffix;
  SELF.name_suffix_match_code := MAP(
		le.name_suffix_isnull OR ri.name_suffix_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_name_suffix(le.name_suffix,ri.name_suffix));
  INTEGER2 name_suffix_score_temp := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT32.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT32.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  SELF.left_isContact := le.isContact;
  SELF.right_isContact := ri.isContact;
  SELF.left_contact_phone := le.contact_phone;
  SELF.right_contact_phone := ri.contact_phone;
  SELF.left_contact_email := le.contact_email;
  SELF.right_contact_email := ri.contact_email;
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
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
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.orgid_score := IF ( le.orgid = ri.orgid, orgid_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.orgid_skipped := SELF.orgid_score < -5000;// Enforce FORCE parameter
  SELF.lname_score := IF (le.lname = ri.lname or/*HACK*/  lname_score_temp > Config.lname_Force * 100, lname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.lname_skipped := SELF.lname_score < -5000;// Enforce FORCE parameter
  SELF.mname_score := IF ( mname_score_temp >= Config.mname_Force * 100, mname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.mname_skipped := SELF.mname_score < -5000;// Enforce FORCE parameter
  SELF.fname_score := IF (le.fname = ri.fname or/*HACK*/  fname_score_temp > Config.fname_Force * 100, fname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.fname_skipped := SELF.fname_score < -5000;// Enforce FORCE parameter
  SELF.name_suffix_score := IF ( name_suffix_score_temp >= Config.name_suffix_Force * 100, name_suffix_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.name_suffix_skipped := SELF.name_suffix_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +(MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*self.mname_score // Proportion of longest string propogated
    +MAX(le.name_suffix_prop,ri.name_suffix_prop)*SELF.name_suffix_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.orgid_score + SELF.contact_ssn_score + SELF.contact_did_score + SELF.lname_score + SELF.mname_score + SELF.fname_score + SELF.name_suffix_score) / 100 + outside;
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
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT32.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rcid1=RIGHT.rcid1 AND LEFT.rcid2=RIGHT.rcid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT32.UIDType EmpID;
  DATASET(SALT32.Layout_FieldValueList) orgid_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_did_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) lname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) mname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) fname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) isContact_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_phone_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_email_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) prim_range_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) prim_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) sec_range_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) st_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) zip_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.EmpID := le.EmpID;
    SELF.orgid_values := SALT32.fn_combine_fieldvaluelist(le.orgid_values,ri.orgid_values);
    SELF.contact_ssn_values := SALT32.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
    SELF.contact_did_values := SALT32.fn_combine_fieldvaluelist(le.contact_did_values,ri.contact_did_values);
    SELF.lname_values := SALT32.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
    SELF.mname_values := SALT32.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
    SELF.fname_values := SALT32.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
    SELF.name_suffix_values := SALT32.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.isContact_values := SALT32.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
    SELF.contact_phone_values := SALT32.fn_combine_fieldvaluelist(le.contact_phone_values,ri.contact_phone_values);
    SELF.contact_email_values := SALT32.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
    SELF.company_name_values := SALT32.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.prim_range_values := SALT32.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.prim_name_values := SALT32.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.sec_range_values := SALT32.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.v_city_name_values := SALT32.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
    SELF.st_values := SALT32.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip_values := SALT32.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.active_duns_number_values := SALT32.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
    SELF.hist_duns_number_values := SALT32.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
    SELF.active_domestic_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
    SELF.hist_domestic_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
    SELF.foreign_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
    SELF.unk_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
    SELF.dt_first_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(EmpID) ), EmpID, LOCAL ), LEFT.EmpID = RIGHT.EmpID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.EmpID := le.EmpID;
    SELF.orgid_values := SORT(le.orgid_values, -cnt, val, LOCAL);
    SELF.contact_ssn_values := SORT(le.contact_ssn_values, -cnt, val, LOCAL);
    SELF.contact_did_values := SORT(le.contact_did_values, -cnt, val, LOCAL);
    SELF.lname_values := SORT(le.lname_values, -cnt, val, LOCAL);
    SELF.mname_values := SORT(le.mname_values, -cnt, val, LOCAL);
    SELF.fname_values := SORT(le.fname_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.isContact_values := SORT(le.isContact_values, -cnt, val, LOCAL);
    SELF.contact_phone_values := SORT(le.contact_phone_values, -cnt, val, LOCAL);
    SELF.contact_email_values := SORT(le.contact_email_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.v_city_name_values := SORT(le.v_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.active_duns_number_values := SORT(le.active_duns_number_values, -cnt, val, LOCAL);
    SELF.hist_duns_number_values := SORT(le.hist_duns_number_values, -cnt, val, LOCAL);
    SELF.active_domestic_corp_key_values := SORT(le.active_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.hist_domestic_corp_key_values := SORT(le.hist_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.foreign_corp_key_values := SORT(le.foreign_corp_key_values, -cnt, val, LOCAL);
    SELF.unk_corp_key_values := SORT(le.unk_corp_key_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.EmpID := le.EmpID;
  SELF.orgid_Values := IF ( le.orgid  IN SET(s.nulls_orgid,orgid) OR le.orgid = (TYPEOF(le.orgid))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.orgid)}],SALT32.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_ssn)}],SALT32.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( le.contact_did  IN SET(s.nulls_contact_did,contact_did) OR le.contact_did = (TYPEOF(le.contact_did))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_did)}],SALT32.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.lname)}],SALT32.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.mname)}],SALT32.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.fname)}],SALT32.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.name_suffix)}],SALT32.Layout_FieldValueList));
  SELF.isContact_Values := DATASET([{TRIM((SALT32.StrType)le.isContact)}],SALT32.Layout_FieldValueList);
  SELF.contact_phone_Values := DATASET([{TRIM((SALT32.StrType)le.contact_phone)}],SALT32.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT32.StrType)le.contact_email)}],SALT32.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT32.StrType)le.prim_range)}],SALT32.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT32.StrType)le.prim_name)}],SALT32.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT32.StrType)le.sec_range)}],SALT32.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT32.StrType)le.v_city_name)}],SALT32.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT32.StrType)le.st)}],SALT32.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.hist_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.hist_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.foreign_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.unk_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.EmpID := le.EmpID;
  SELF.orgid_Values := IF ( le.orgid  IN SET(s.nulls_orgid,orgid) OR le.orgid = (TYPEOF(le.orgid))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.orgid)}],SALT32.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_ssn)}],SALT32.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( le.contact_did  IN SET(s.nulls_contact_did,contact_did) OR le.contact_did = (TYPEOF(le.contact_did))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_did)}],SALT32.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.lname)}],SALT32.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.mname)}],SALT32.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.fname)}],SALT32.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.name_suffix)}],SALT32.Layout_FieldValueList));
  SELF.isContact_Values := DATASET([{TRIM((SALT32.StrType)le.isContact)}],SALT32.Layout_FieldValueList);
  SELF.contact_phone_Values := DATASET([{TRIM((SALT32.StrType)le.contact_phone)}],SALT32.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT32.StrType)le.contact_email)}],SALT32.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT32.StrType)le.prim_range)}],SALT32.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT32.StrType)le.prim_name)}],SALT32.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT32.StrType)le.sec_range)}],SALT32.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT32.StrType)le.v_city_name)}],SALT32.Layout_FieldValueList);
  SELF.st_Values := DATASET([{TRIM((SALT32.StrType)le.st)}],SALT32.Layout_FieldValueList);
  SELF.zip_Values := DATASET([{TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.hist_duns_number_Values := DATASET([{TRIM((SALT32.StrType)le.hist_duns_number)}],SALT32.Layout_FieldValueList);
  SELF.active_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.hist_domestic_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.hist_domestic_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.foreign_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.foreign_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.unk_corp_key_Values := DATASET([{TRIM((SALT32.StrType)le.unk_corp_key)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.mname := le.mname[1..LENGTH(TRIM(le.mname))-le.mname_prop]; // Clip propogated chars
    self.mname_isnull := self.mname='' OR le.mname_isnull;
    self.mname_prop := 0; // Avoid reducing score later
    self.name_suffix := if ( le.name_suffix_prop>0, (TYPEOF(le.name_suffix))'', le.name_suffix ); // Blank if propogated
    self.name_suffix_isnull := le.name_suffix_prop>0 OR le.name_suffix_isnull;
    self.name_suffix_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 orgid_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 contact_did_size := 0;
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 mname_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 name_suffix_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.orgid_size := SALT32.Fn_SwitchSpec(s.orgid_switch,count(le.orgid_values));
  SELF.contact_ssn_size := SALT32.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.contact_did_size := SALT32.Fn_SwitchSpec(s.contact_did_switch,count(le.contact_did_values));
  SELF.lname_size := SALT32.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.mname_size := SALT32.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.fname_size := SALT32.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.name_suffix_size := SALT32.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.orgid_size+t.contact_ssn_size+t.contact_did_size+t.lname_size+t.mname_size+t.fname_size+t.name_suffix_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
