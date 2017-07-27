// Various routines to assist in debugging
IMPORT SALT31,ut,std;
EXPORT Debug(DATASET(layout_Base) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  typeof(h.active_duns_number) left_active_duns_number;
  INTEGER1 active_duns_number_match_code;
  INTEGER2 active_duns_number_score;
  BOOLEAN active_duns_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_duns_number) right_active_duns_number;
  typeof(h.active_enterprise_number) left_active_enterprise_number;
  INTEGER1 active_enterprise_number_match_code;
  INTEGER2 active_enterprise_number_score;
  BOOLEAN active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_enterprise_number) right_active_enterprise_number;
  typeof(h.company_charter_number) left_company_charter_number;
  INTEGER1 company_charter_number_match_code;
  INTEGER2 company_charter_number_score;
  typeof(h.company_charter_number) right_company_charter_number;
  typeof(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.source_record_id) left_source_record_id;
  INTEGER1 source_record_id_match_code;
  INTEGER2 source_record_id_score;
  typeof(h.source_record_id) right_source_record_id;
  typeof(h.contact_ssn) left_contact_ssn;
  INTEGER1 contact_ssn_match_code;
  INTEGER2 contact_ssn_score;
  typeof(h.contact_ssn) right_contact_ssn;
  typeof(h.contact_phone) left_contact_phone;
  INTEGER1 contact_phone_match_code;
  INTEGER2 contact_phone_score;
  typeof(h.contact_phone) right_contact_phone;
  typeof(h.contact_email_username) left_contact_email_username;
  INTEGER1 contact_email_username_match_code;
  INTEGER2 contact_email_username_score;
  typeof(h.contact_email_username) right_contact_email_username;
  typeof(h.cnp_name) left_cnp_name;
  INTEGER1 cnp_name_match_code;
  INTEGER2 cnp_name_score;
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.lname) left_lname;
  INTEGER1 lname_match_code;
  INTEGER2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  BOOLEAN sec_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.sec_range) right_sec_range;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER1 v_city_name_match_code;
  INTEGER2 v_city_name_score;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.fname) left_fname;
  INTEGER1 fname_match_code;
  INTEGER2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.mname) left_mname;
  INTEGER1 mname_match_code;
  INTEGER2 mname_score;
  typeof(h.mname) right_mname;
  typeof(h.company_inc_state) left_company_inc_state;
  INTEGER1 company_inc_state_match_code;
  INTEGER2 company_inc_state_score;
  typeof(h.company_inc_state) right_company_inc_state;
  typeof(h.postdir) left_postdir;
  INTEGER1 postdir_match_code;
  INTEGER2 postdir_score;
  typeof(h.postdir) right_postdir;
  typeof(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  typeof(h.st) right_st;
  typeof(h.source) left_source;
  INTEGER1 source_match_code;
  INTEGER2 source_score;
  typeof(h.source) right_source;
  typeof(h.unit_desig) left_unit_desig;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.company_department) left_company_department;
  typeof(h.company_department) right_company_department;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.dt_first_seen_contact) left_dt_first_seen_contact;
  typeof(h.dt_first_seen_contact) right_dt_first_seen_contact;
  typeof(h.dt_last_seen_contact) left_dt_last_seen_contact;
  typeof(h.dt_last_seen_contact) right_dt_last_seen_contact;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Seleid1 := le.Seleid;
  SELF.Seleid2 := ri.Seleid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT31.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen_contact),((UNSIGNED)le.dt_last_seen_contact),((UNSIGNED)ri.dt_first_seen_contact),((UNSIGNED)ri.dt_last_seen_contact));
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.active_duns_number_match_code := MAP(
		le.active_duns_number_isnull OR ri.active_duns_number_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_active_duns_number(le.active_duns_number,ri.active_duns_number));
  INTEGER2 active_duns_number_score_temp := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT31.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  SELF.left_active_enterprise_number := le.active_enterprise_number;
  SELF.right_active_enterprise_number := ri.active_enterprise_number;
  SELF.active_enterprise_number_match_code := MAP(
		le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_active_enterprise_number(le.active_enterprise_number,ri.active_enterprise_number));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT31.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  SELF.left_company_charter_number := le.company_charter_number;
  SELF.right_company_charter_number := ri.company_charter_number;
  SELF.company_charter_number_match_code := MAP(
		le.company_charter_number_isnull OR ri.company_charter_number_isnull => SALT31.MatchCode.OneSideNull,
		le.company_inc_state <> ri.company_inc_state => SALT31.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_company_charter_number(le.company_charter_number,ri.company_charter_number));
  SELF.company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT31.WithinEditN(le.company_charter_number,ri.company_charter_number,1,0) => SALT31.fn_fuzzy_specificity(le.company_charter_number_weight100,le.company_charter_number_cnt, le.company_charter_number_e1_cnt,ri.company_charter_number_weight100,ri.company_charter_number_cnt,ri.company_charter_number_e1_cnt),
                        SALT31.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
		le.company_fein_isnull OR ri.company_fein_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_company_fein(le.company_fein,ri.company_fein));
  SELF.company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT31.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_source_record_id := le.source_record_id;
  SELF.right_source_record_id := ri.source_record_id;
  SELF.source_record_id_match_code := MAP(
		le.source_record_id_isnull OR ri.source_record_id_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_source_record_id(le.source_record_id,ri.source_record_id));
  SELF.source_record_id_score := MAP(
                        le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT31.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_match_code := MAP(
		le.contact_ssn_isnull OR ri.contact_ssn_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_ssn(le.contact_ssn,ri.contact_ssn));
  SELF.contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_contact_phone := le.contact_phone;
  SELF.right_contact_phone := ri.contact_phone;
  SELF.contact_phone_match_code := MAP(
		le.contact_phone_isnull OR ri.contact_phone_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_phone(le.contact_phone,ri.contact_phone));
  SELF.contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  SELF.left_contact_email_username := le.contact_email_username;
  SELF.right_contact_email_username := ri.contact_email_username;
  SELF.contact_email_username_match_code := MAP(
		le.contact_email_username_isnull OR ri.contact_email_username_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_email_username(le.contact_email_username,ri.contact_email_username));
  SELF.contact_email_username_score := MAP(
                        le.contact_email_username_isnull OR ri.contact_email_username_isnull => 0,
                        le.contact_email_username = ri.contact_email_username  => le.contact_email_username_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_email_username_weight100,s.contact_email_username_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_match_code := MAP(
		le.cnp_name_isnull OR ri.cnp_name_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_name(le.cnp_name,ri.cnp_name));
  SELF.cnp_name_score := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT31.WithinEditN(le.cnp_name,ri.cnp_name,1,0) => SALT31.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT31.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_match_code := MAP(
		le.lname_isnull OR ri.lname_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_lname(le.lname,ri.lname));
  SELF.lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT31.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
		le.prim_name_isnull OR ri.prim_name_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  SELF.prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT31.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
		le.prim_range_isnull OR ri.prim_range_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT31.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
		le.sec_range_isnull OR ri.sec_range_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_sec_range(le.sec_range,ri.sec_range));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT31.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_match_code := MAP(
		le.v_city_name_isnull OR ri.v_city_name_isnull => SALT31.MatchCode.OneSideNull,
		le.st <> ri.st => SALT31.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_v_city_name(le.v_city_name,ri.v_city_name));
  SELF.v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT31.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_match_code := MAP(
		le.fname_isnull OR ri.fname_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_fname(le.fname,ri.fname));
  SELF.fname_score := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT31.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_match_code := MAP(
		le.mname_isnull OR ri.mname_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_mname(le.mname,ri.mname));
  SELF.mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT31.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  SELF.left_company_inc_state := le.company_inc_state;
  SELF.right_company_inc_state := ri.company_inc_state;
  SELF.company_inc_state_match_code := MAP(
		le.company_inc_state_isnull OR ri.company_inc_state_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_company_inc_state(le.company_inc_state,ri.company_inc_state));
  SELF.company_inc_state_score := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT31.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.postdir_match_code := MAP(
		le.postdir_isnull OR ri.postdir_isnull => SALT31.MatchCode.OneSideNull,
		le.prim_name <> ri.prim_name => SALT31.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_postdir(le.postdir,ri.postdir));
  SELF.postdir_score := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT31.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
		le.st_isnull OR ri.st_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_st(le.st,ri.st));
  SELF.st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT31.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  SELF.left_source := le.source;
  SELF.right_source := ri.source;
  SELF.source_match_code := MAP(
		le.source_isnull OR ri.source_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_source(le.source,ri.source));
  SELF.source_score := MAP(
                        le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT31.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.left_company_department := le.company_department;
  SELF.right_company_department := ri.company_department;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_dt_first_seen_contact := le.dt_first_seen_contact;
  SELF.right_dt_first_seen_contact := ri.dt_first_seen_contact;
  SELF.left_dt_last_seen_contact := le.dt_last_seen_contact;
  SELF.right_dt_last_seen_contact := ri.dt_last_seen_contact;
  SELF.active_duns_number_score := IF ( active_duns_number_score_temp >= Config.active_duns_number_Force * 100, active_duns_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_duns_number_skipped := SELF.active_duns_number_score < -5000;// Enforce FORCE parameter
  SELF.active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_enterprise_number_skipped := SELF.active_enterprise_number_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_skipped := SELF.sec_range_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*SELF.company_charter_number_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.sec_range_prop,ri.sec_range_prop)*SELF.sec_range_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*SELF.company_inc_state_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.active_duns_number_score + SELF.active_enterprise_number_score + SELF.company_charter_number_score + SELF.company_fein_score + SELF.source_record_id_score + SELF.contact_ssn_score + SELF.contact_phone_score + SELF.contact_email_username_score + SELF.cnp_name_score + SELF.lname_score + SELF.prim_name_score + SELF.prim_range_score + SELF.sec_range_score + SELF.v_city_name_score + SELF.fname_score + SELF.mname_score + SELF.company_inc_state_score + SELF.postdir_score + SELF.st_score + SELF.source_score) / 100 + outside;
END;
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.Seleid = RIGHT.Seleid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.Seleid2 = RIGHT.Seleid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, Seleid1, Seleid2, -Conf, LOCAL ), Seleid1, Seleid2, LOCAL ); // Seleid2 distributed by join
  RETURN d;
END;
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT31.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
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
  SALT31.UIDType Seleid;
  DATASET(SALT31.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) company_fein_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) contact_phone_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) contact_email_username_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) lname_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) prim_name_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) prim_range_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) sec_range_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) fname_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) mname_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) postdir_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) st_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) source_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) company_department_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) dt_first_seen_contact_Values := DATASET([],SALT31.Layout_FieldValueList);
  DATASET(SALT31.Layout_FieldValueList) dt_last_seen_contact_Values := DATASET([],SALT31.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Seleid := le.Seleid;
  SELF.active_duns_number_values := SALT31.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  SELF.active_enterprise_number_values := SALT31.fn_combine_fieldvaluelist(le.active_enterprise_number_values,ri.active_enterprise_number_values);
  SELF.company_charter_number_values := SALT31.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
  SELF.company_fein_values := SALT31.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.source_record_id_values := SALT31.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
  SELF.contact_ssn_values := SALT31.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
  SELF.contact_phone_values := SALT31.fn_combine_fieldvaluelist(le.contact_phone_values,ri.contact_phone_values);
  SELF.contact_email_username_values := SALT31.fn_combine_fieldvaluelist(le.contact_email_username_values,ri.contact_email_username_values);
  SELF.cnp_name_values := SALT31.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.lname_values := SALT31.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  SELF.prim_name_values := SALT31.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
  SELF.prim_range_values := SALT31.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
  SELF.sec_range_values := SALT31.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
  SELF.v_city_name_values := SALT31.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
  SELF.fname_values := SALT31.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  SELF.mname_values := SALT31.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
  SELF.company_inc_state_values := SALT31.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
  SELF.postdir_values := SALT31.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
  SELF.st_values := SALT31.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  SELF.source_values := SALT31.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
  SELF.unit_desig_values := SALT31.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
  SELF.company_department_values := SALT31.fn_combine_fieldvaluelist(le.company_department_values,ri.company_department_values);
  SELF.dt_first_seen_values := SALT31.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT31.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  SELF.dt_first_seen_contact_values := SALT31.fn_combine_fieldvaluelist(le.dt_first_seen_contact_values,ri.dt_first_seen_contact_values);
  SELF.dt_last_seen_contact_values := SALT31.fn_combine_fieldvaluelist(le.dt_last_seen_contact_values,ri.dt_last_seen_contact_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Seleid) ), Seleid, LOCAL ), LEFT.Seleid = RIGHT.Seleid, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Seleid := le.Seleid;
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.active_duns_number)}],SALT31.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.active_enterprise_number)}],SALT31.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_charter_number)}],SALT31.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_fein)}],SALT31.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.source_record_id)}],SALT31.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_ssn)}],SALT31.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_phone)}],SALT31.Layout_FieldValueList));
  SELF.contact_email_username_Values := IF ( le.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_email_username)}],SALT31.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.cnp_name)}],SALT31.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.lname)}],SALT31.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.prim_name)}],SALT31.Layout_FieldValueList));
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.prim_range)}],SALT31.Layout_FieldValueList));
  SELF.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.sec_range)}],SALT31.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.v_city_name)}],SALT31.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.fname)}],SALT31.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.mname)}],SALT31.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_inc_state)}],SALT31.Layout_FieldValueList));
  SELF.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.postdir)}],SALT31.Layout_FieldValueList));
  SELF.st_Values := IF ( le.st  IN SET(s.nulls_st,st),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.st)}],SALT31.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.source)}],SALT31.Layout_FieldValueList));
  SELF.unit_desig_Values := DATASET([{TRIM((SALT31.StrType)le.unit_desig)}],SALT31.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT31.StrType)le.company_department)}],SALT31.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT31.StrType)le.dt_first_seen)}],SALT31.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT31.StrType)le.dt_last_seen)}],SALT31.Layout_FieldValueList);
  SELF.dt_first_seen_contact_Values := DATASET([{TRIM((SALT31.StrType)le.dt_first_seen_contact)}],SALT31.Layout_FieldValueList);
  SELF.dt_last_seen_contact_Values := DATASET([{TRIM((SALT31.StrType)le.dt_last_seen_contact)}],SALT31.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.Seleid := le.Seleid;
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.active_duns_number)}],SALT31.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.active_enterprise_number)}],SALT31.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_charter_number)}],SALT31.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_fein)}],SALT31.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.source_record_id)}],SALT31.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_ssn)}],SALT31.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_phone)}],SALT31.Layout_FieldValueList));
  SELF.contact_email_username_Values := IF ( le.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.contact_email_username)}],SALT31.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.cnp_name)}],SALT31.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.lname)}],SALT31.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.prim_name)}],SALT31.Layout_FieldValueList));
  SELF.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.prim_range)}],SALT31.Layout_FieldValueList));
  SELF.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.sec_range)}],SALT31.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.v_city_name)}],SALT31.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.fname)}],SALT31.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.mname)}],SALT31.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.company_inc_state)}],SALT31.Layout_FieldValueList));
  SELF.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.postdir)}],SALT31.Layout_FieldValueList));
  SELF.st_Values := IF ( le.st  IN SET(s.nulls_st,st),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.st)}],SALT31.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT31.Layout_FieldValueList),DATASET([{TRIM((SALT31.StrType)le.source)}],SALT31.Layout_FieldValueList));
  SELF.unit_desig_Values := DATASET([{TRIM((SALT31.StrType)le.unit_desig)}],SALT31.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT31.StrType)le.company_department)}],SALT31.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT31.StrType)le.dt_first_seen)}],SALT31.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT31.StrType)le.dt_last_seen)}],SALT31.Layout_FieldValueList);
  SELF.dt_first_seen_contact_Values := DATASET([{TRIM((SALT31.StrType)le.dt_first_seen_contact)}],SALT31.Layout_FieldValueList);
  SELF.dt_last_seen_contact_Values := DATASET([{TRIM((SALT31.StrType)le.dt_last_seen_contact)}],SALT31.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.company_charter_number := if ( le.company_charter_number_prop>0, (TYPEOF(le.company_charter_number))'', le.company_charter_number ); // Blank if propogated
    self.company_charter_number_isnull := le.company_charter_number_prop>0 OR le.company_charter_number_isnull;
    self.company_charter_number_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.sec_range := if ( le.sec_range_prop>0, (TYPEOF(le.sec_range))'', le.sec_range ); // Blank if propogated
    self.sec_range_isnull := le.sec_range_prop>0 OR le.sec_range_isnull;
    self.sec_range_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 active_duns_number_size := 0;
  UNSIGNED1 active_enterprise_number_size := 0;
  UNSIGNED1 company_charter_number_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 source_record_id_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 contact_phone_size := 0;
  UNSIGNED1 contact_email_username_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 prim_name_size := 0;
  UNSIGNED1 prim_range_size := 0;
  UNSIGNED1 sec_range_size := 0;
  UNSIGNED1 v_city_name_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 mname_size := 0;
  UNSIGNED1 company_inc_state_size := 0;
  UNSIGNED1 postdir_size := 0;
  UNSIGNED1 st_size := 0;
  UNSIGNED1 source_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.active_duns_number_size := SALT31.Fn_SwitchSpec(s.active_duns_number_switch,count(le.active_duns_number_values));
  SELF.active_enterprise_number_size := SALT31.Fn_SwitchSpec(s.active_enterprise_number_switch,count(le.active_enterprise_number_values));
  SELF.company_charter_number_size := SALT31.Fn_SwitchSpec(s.company_charter_number_switch,count(le.company_charter_number_values));
  SELF.company_fein_size := SALT31.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.source_record_id_size := SALT31.Fn_SwitchSpec(s.source_record_id_switch,count(le.source_record_id_values));
  SELF.contact_ssn_size := SALT31.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.contact_phone_size := SALT31.Fn_SwitchSpec(s.contact_phone_switch,count(le.contact_phone_values));
  SELF.contact_email_username_size := SALT31.Fn_SwitchSpec(s.contact_email_username_switch,count(le.contact_email_username_values));
  SELF.cnp_name_size := SALT31.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.lname_size := SALT31.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.prim_name_size := SALT31.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.prim_range_size := SALT31.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.sec_range_size := SALT31.Fn_SwitchSpec(s.sec_range_switch,count(le.sec_range_values));
  SELF.v_city_name_size := SALT31.Fn_SwitchSpec(s.v_city_name_switch,count(le.v_city_name_values));
  SELF.fname_size := SALT31.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.mname_size := SALT31.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.company_inc_state_size := SALT31.Fn_SwitchSpec(s.company_inc_state_switch,count(le.company_inc_state_values));
  SELF.postdir_size := SALT31.Fn_SwitchSpec(s.postdir_switch,count(le.postdir_values));
  SELF.st_size := SALT31.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.source_size := SALT31.Fn_SwitchSpec(s.source_switch,count(le.source_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.active_duns_number_size+t.active_enterprise_number_size+t.company_charter_number_size+t.company_fein_size+t.source_record_id_size+t.contact_ssn_size+t.contact_phone_size+t.contact_email_username_size+t.cnp_name_size+t.lname_size+t.prim_name_size+t.prim_range_size+t.sec_range_size+t.v_city_name_size+t.fname_size+t.mname_size+t.company_inc_state_size+t.postdir_size+t.st_size+t.source_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;