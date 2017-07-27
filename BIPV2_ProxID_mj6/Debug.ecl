// Various routines to assist in debugging
 
IMPORT SALT30,ut,std;
EXPORT Debug(DATASET(layout_DOT_Base) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  INTEGER2 Attribute_Conf := 0; // Score provided by attribute files
  SALT30.StrType   Matching_Attributes := ''; // Keys from attribute files which match
  typeof(h.cnp_name) left_cnp_name;
  INTEGER1 cnp_name_match_code;
  INTEGER2 cnp_name_score;
  BOOLEAN cnp_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_number) right_cnp_number;
  typeof(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.prim_name_derived) left_prim_name_derived;
  INTEGER1 prim_name_derived_match_code;
  INTEGER2 prim_name_derived_score;
  BOOLEAN prim_name_derived_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_name_derived) right_prim_name_derived;
  typeof(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  typeof(h.st) right_st;
  typeof(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  BOOLEAN zip_skipped := FALSE; // True if FORCE blocks match
  typeof(h.zip) right_zip;
  typeof(h.hist_duns_number) left_hist_duns_number;
  INTEGER1 hist_duns_number_match_code;
  INTEGER2 hist_duns_number_score;
  typeof(h.hist_duns_number) right_hist_duns_number;
  typeof(h.hist_domestic_corp_key) left_hist_domestic_corp_key;
  INTEGER1 hist_domestic_corp_key_match_code;
  INTEGER2 hist_domestic_corp_key_score;
  typeof(h.hist_domestic_corp_key) right_hist_domestic_corp_key;
  typeof(h.foreign_corp_key) left_foreign_corp_key;
  INTEGER1 foreign_corp_key_match_code;
  INTEGER2 foreign_corp_key_score;
  typeof(h.foreign_corp_key) right_foreign_corp_key;
  typeof(h.unk_corp_key) left_unk_corp_key;
  INTEGER1 unk_corp_key_match_code;
  INTEGER2 unk_corp_key_score;
  typeof(h.unk_corp_key) right_unk_corp_key;
  typeof(h.ebr_file_number) left_ebr_file_number;
  INTEGER1 ebr_file_number_match_code;
  INTEGER2 ebr_file_number_score;
  typeof(h.ebr_file_number) right_ebr_file_number;
  typeof(h.active_duns_number) left_active_duns_number;
  INTEGER1 active_duns_number_match_code;
  INTEGER2 active_duns_number_score;
  typeof(h.active_duns_number) right_active_duns_number;
  typeof(h.active_enterprise_number) left_active_enterprise_number;
  INTEGER1 active_enterprise_number_match_code;
  INTEGER2 active_enterprise_number_score;
  BOOLEAN active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_enterprise_number) right_active_enterprise_number;
  typeof(h.active_domestic_corp_key) left_active_domestic_corp_key;
  INTEGER1 active_domestic_corp_key_match_code;
  INTEGER2 active_domestic_corp_key_score;
  BOOLEAN active_domestic_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_domestic_corp_key) right_active_domestic_corp_key;
  typeof(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.company_phone) left_company_phone;
  INTEGER1 company_phone_match_code;
  INTEGER2 company_phone_score;
  typeof(h.company_phone) right_company_phone;
  typeof(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER1 v_city_name_match_code;
  INTEGER2 v_city_name_score;
  BOOLEAN v_city_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.hist_enterprise_number) left_hist_enterprise_number;
  INTEGER1 hist_enterprise_number_match_code;
  INTEGER2 hist_enterprise_number_score;
  typeof(h.hist_enterprise_number) right_hist_enterprise_number;
  typeof(h.company_csz) left_company_csz;
  INTEGER1 company_csz_match_code;
  INTEGER2 company_csz_score;
  BOOLEAN company_csz_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_csz) right_company_csz;
  typeof(h.company_addr1) left_company_addr1;
  INTEGER1 company_addr1_match_code;
  INTEGER2 company_addr1_score;
  BOOLEAN company_addr1_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_addr1) right_company_addr1;
  typeof(h.company_address) left_company_address;
  INTEGER1 company_address_match_code;
  INTEGER2 company_address_score;
  BOOLEAN company_address_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_address) right_company_address;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_match_code := MAP(
		le.cnp_name_isnull OR ri.cnp_name_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_name(le.cnp_name,ri.cnp_name));
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
		le.cnp_number_isnull OR ri.cnp_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_hist_duns_number := le.hist_duns_number;
  SELF.right_hist_duns_number := ri.hist_duns_number;
  SELF.hist_duns_number_match_code := MAP(
		le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_hist_duns_number(le.hist_duns_number,ri.hist_duns_number));
  SELF.hist_duns_number_score := MAP( le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        0 /* switch0 */);
  SELF.left_hist_domestic_corp_key := le.hist_domestic_corp_key;
  SELF.right_hist_domestic_corp_key := ri.hist_domestic_corp_key;
  SELF.hist_domestic_corp_key_match_code := MAP(
		le.hist_domestic_corp_key_isnull OR ri.hist_domestic_corp_key_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_hist_domestic_corp_key(le.hist_domestic_corp_key,ri.hist_domestic_corp_key));
  SELF.hist_domestic_corp_key_score := MAP( le.hist_domestic_corp_key_isnull OR ri.hist_domestic_corp_key_isnull => 0,
                        le.hist_domestic_corp_key = ri.hist_domestic_corp_key  => le.hist_domestic_corp_key_weight100,
                        0 /* switch0 */);
  SELF.left_foreign_corp_key := le.foreign_corp_key;
  SELF.right_foreign_corp_key := ri.foreign_corp_key;
  SELF.foreign_corp_key_match_code := MAP(
		le.foreign_corp_key_isnull OR ri.foreign_corp_key_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_foreign_corp_key(le.foreign_corp_key,ri.foreign_corp_key));
  SELF.foreign_corp_key_score := MAP( le.foreign_corp_key_isnull OR ri.foreign_corp_key_isnull => 0,
                        le.foreign_corp_key = ri.foreign_corp_key  => le.foreign_corp_key_weight100,
                        0 /* switch0 */);
  SELF.left_unk_corp_key := le.unk_corp_key;
  SELF.right_unk_corp_key := ri.unk_corp_key;
  SELF.unk_corp_key_match_code := MAP(
		le.unk_corp_key_isnull OR ri.unk_corp_key_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_unk_corp_key(le.unk_corp_key,ri.unk_corp_key));
  SELF.unk_corp_key_score := MAP( le.unk_corp_key_isnull OR ri.unk_corp_key_isnull => 0,
                        le.unk_corp_key = ri.unk_corp_key  => le.unk_corp_key_weight100,
                        0 /* switch0 */);
  SELF.left_ebr_file_number := le.ebr_file_number;
  SELF.right_ebr_file_number := ri.ebr_file_number;
  SELF.ebr_file_number_match_code := MAP(
		le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_ebr_file_number(le.ebr_file_number,ri.ebr_file_number));
  SELF.ebr_file_number_score := MAP( le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        0 /* switch0 */);
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.active_duns_number_match_code := MAP(
		le.active_duns_number_isnull OR ri.active_duns_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_active_duns_number(le.active_duns_number,ri.active_duns_number));
  SELF.active_duns_number_score := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        0 /* switch0 */);
  SELF.left_active_enterprise_number := le.active_enterprise_number;
  SELF.right_active_enterprise_number := ri.active_enterprise_number;
  SELF.active_enterprise_number_match_code := MAP(
		le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_active_enterprise_number(le.active_enterprise_number,ri.active_enterprise_number));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
  SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
  SELF.active_domestic_corp_key_match_code := MAP(
		le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_active_domestic_corp_key(le.active_domestic_corp_key,ri.active_domestic_corp_key));
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
		le.company_fein_isnull OR ri.company_fein_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_fein(le.company_fein,ri.company_fein));
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        0 /* switch0 */);
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.company_phone_match_code := MAP(
		le.company_phone_isnull OR ri.company_phone_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_phone(le.company_phone,ri.company_phone));
  SELF.company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switch0 */);
  SELF.left_hist_enterprise_number := le.hist_enterprise_number;
  SELF.right_hist_enterprise_number := ri.hist_enterprise_number;
  SELF.hist_enterprise_number_match_code := MAP(
		le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_hist_enterprise_number(le.hist_enterprise_number,ri.hist_enterprise_number));
  SELF.hist_enterprise_number_score := MAP( le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        0 /* switch0 */);
  SELF.company_address_match_code := MAP(
		(le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_company_address(le.company_address,ri.company_address));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  SELF.left_company_address := le.company_address;
  SELF.right_company_address := ri.company_address;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_name_skipped := SELF.cnp_name_score < -5000;// Enforce FORCE parameter
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
  SELF.active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_enterprise_number_skipped := SELF.active_enterprise_number_score < -5000;// Enforce FORCE parameter
  SELF.active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_domestic_corp_key_skipped := SELF.active_domestic_corp_key_score < -5000;// Enforce FORCE parameter
  SELF.company_csz_match_code := MAP(
		(le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => SALT30.MatchCode.OneSideNull,
		company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_company_csz(le.company_csz,ri.company_csz));
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_company_csz := le.company_csz;
  SELF.right_company_csz := ri.company_csz;
  SELF.company_addr1_match_code := MAP(
		(le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) OR le.company_addr1_weight100 = 0 => SALT30.MatchCode.OneSideNull,
		company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_company_addr1(le.company_addr1,ri.company_addr1));
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_derived_weight100 + ri.prim_name_derived_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) OR le.company_addr1_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_company_addr1 := le.company_addr1;
  SELF.right_company_addr1 := ri.company_addr1;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
		le.prim_range_isnull OR ri.prim_range_isnull => SALT30.MatchCode.OneSideNull,
		company_addr1_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(                         company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_prim_name_derived := le.prim_name_derived;
  SELF.right_prim_name_derived := ri.prim_name_derived;
  SELF.prim_name_derived_match_code := MAP(
		le.prim_name_derived_isnull OR ri.prim_name_derived_isnull => SALT30.MatchCode.OneSideNull,
		company_addr1_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_name_derived(le.prim_name_derived,ri.prim_name_derived));
  INTEGER2 prim_name_derived_score_temp := MAP( le.prim_name_derived_isnull OR ri.prim_name_derived_isnull OR le.prim_name_derived_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_derived = ri.prim_name_derived  => le.prim_name_derived_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_name_derived_weight100,s.prim_name_derived_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
		le.st_isnull OR ri.st_isnull => SALT30.MatchCode.OneSideNull,
		company_csz_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_st(le.st,ri.st));
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT30.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
		le.zip_isnull OR ri.zip_isnull => SALT30.MatchCode.OneSideNull,
		company_csz_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_zip(le.zip,ri.zip));
  INTEGER2 zip_score_temp := MAP( le.zip_isnull OR ri.zip_isnull OR le.zip_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT30.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
		le.sec_range_isnull OR ri.sec_range_isnull => SALT30.MatchCode.OneSideNull,
		company_addr1_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_sec_range(le.sec_range,ri.sec_range));
  SELF.sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        0 /* switch0 */)*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_match_code := MAP(
		le.v_city_name_isnull OR ri.v_city_name_isnull => SALT30.MatchCode.OneSideNull,
		company_csz_score_pre > 0 OR company_address_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		le.st <> ri.st => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_v_city_name(le.v_city_name,ri.v_city_name));
  INTEGER2 v_city_name_score_temp := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT30.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  SELF.prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_derived_score := IF ( prim_name_derived_score_temp > Config.prim_name_derived_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_name_derived_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_derived_skipped := SELF.prim_name_derived_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp > Config.st_Force * 100 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
  SELF.zip_score := IF ( zip_score_temp > Config.zip_Force * 100 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, zip_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.zip_skipped := SELF.zip_score < -5000;// Enforce FORCE parameter
  SELF.v_city_name_score := IF ( v_city_name_score_temp >= Config.v_city_name_Force * 100, v_city_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.v_city_name_skipped := SELF.v_city_name_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := SALT30.ClipScore(MAX(company_csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  SELF.company_csz_score := IF ( company_csz_score_ext > 0,company_csz_score_res,-9999);
  SELF.company_csz_skipped := SELF.company_csz_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := SALT30.ClipScore(MAX(company_addr1_score_pre,0) + self.prim_range_score + self.prim_name_derived_score + self.sec_range_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  SELF.company_addr1_score := IF ( company_addr1_score_ext > 0,company_addr1_score_res,-9999);
  SELF.company_addr1_skipped := SELF.company_addr1_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := SALT30.ClipScore(MAX(company_address_score_pre,0)+ SELF.company_addr1_score + self.prim_range_score + self.prim_name_derived_score + self.sec_range_score+ SELF.company_csz_score + self.v_city_name_score + self.st_score + self.zip_score);// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  SELF.company_address_score := IF ( company_address_score_ext > 0,company_address_score_res,-9999);
  SELF.company_address_skipped := SELF.company_address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*SELF.cnp_number_score // Score if either field propogated
    +MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*SELF.hist_duns_number_score // Score if either field propogated
    +MAX(le.hist_domestic_corp_key_prop,ri.hist_domestic_corp_key_prop)*SELF.hist_domestic_corp_key_score // Score if either field propogated
    +MAX(le.foreign_corp_key_prop,ri.foreign_corp_key_prop)*SELF.foreign_corp_key_score // Score if either field propogated
    +MAX(le.unk_corp_key_prop,ri.unk_corp_key_prop)*SELF.unk_corp_key_score // Score if either field propogated
    +MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*SELF.ebr_file_number_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*SELF.active_enterprise_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*SELF.active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*SELF.company_phone_score // Score if either field propogated
    +MAX(le.sec_range_prop,ri.sec_range_prop)*SELF.sec_range_score // Score if either field propogated
    +MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*SELF.hist_enterprise_number_score // Score if either field propogated
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,self.company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +if(le.company_address_prop+ri.company_address_prop>0,self.company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.cnp_name_score + SELF.cnp_number_score + SELF.hist_duns_number_score + SELF.hist_domestic_corp_key_score + SELF.foreign_corp_key_score + SELF.unk_corp_key_score + SELF.ebr_file_number_score + SELF.active_duns_number_score + SELF.active_enterprise_number_score + SELF.active_domestic_corp_key_score + SELF.company_fein_score + SELF.company_phone_score + SELF.hist_enterprise_number_score + IF(SELF.company_address_score>0,MAX(SELF.company_address_score,IF(SELF.company_addr1_score>0,MAX(SELF.company_addr1_score,SELF.prim_range_score + SELF.prim_name_derived_score + SELF.sec_range_score),SELF.prim_range_score + SELF.prim_name_derived_score + SELF.sec_range_score) + IF(SELF.company_csz_score>0,MAX(SELF.company_csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score)),IF(SELF.company_addr1_score>0,MAX(SELF.company_addr1_score,SELF.prim_range_score + SELF.prim_name_derived_score + SELF.sec_range_score),SELF.prim_range_score + SELF.prim_name_derived_score + SELF.sec_range_score) + IF(SELF.company_csz_score>0,MAX(SELF.company_csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score))) / 100 + outside;
END;
SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM
    SELF.Attribute_Conf := ri.Conf;
    SELF.Matching_Attributes := ri.Source_Id;
    SELF.Conf := le.Conf + ri.Conf;
    SELF := le;
  END;
  RETURN JOIN(am,ia,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join
  RETURN AppendAttribs( d, ia );
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
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION
  RETURN AppendAttribs( AnnotateMatchesFromRecordData(h,im), ia );
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT30.UIDType Proxid;
  DATASET(SALT30.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) foreign_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) unk_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) ebr_file_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_fein_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_phone_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) hist_enterprise_number_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) company_address_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT30.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_name_values := SALT30.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.cnp_number_values := SALT30.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.hist_duns_number_values := SALT30.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
  SELF.hist_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.hist_domestic_corp_key_values,ri.hist_domestic_corp_key_values);
  SELF.foreign_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.foreign_corp_key_values,ri.foreign_corp_key_values);
  SELF.unk_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.unk_corp_key_values,ri.unk_corp_key_values);
  SELF.ebr_file_number_values := SALT30.fn_combine_fieldvaluelist(le.ebr_file_number_values,ri.ebr_file_number_values);
  SELF.active_duns_number_values := SALT30.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  SELF.active_enterprise_number_values := SALT30.fn_combine_fieldvaluelist(le.active_enterprise_number_values,ri.active_enterprise_number_values);
  SELF.active_domestic_corp_key_values := SALT30.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
  SELF.company_fein_values := SALT30.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_phone_values := SALT30.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.hist_enterprise_number_values := SALT30.fn_combine_fieldvaluelist(le.hist_enterprise_number_values,ri.hist_enterprise_number_values);
  SELF.company_address_values := SALT30.fn_combine_fieldvaluelist(le.company_address_values,ri.company_address_values);
  SELF.dt_first_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT30.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
END;
  // RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Proxid) ), Proxid, LOCAL ), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),LOCAL); /* HACK - disable default return*/
rollup1 :=  ROLLUP( SORT( distribute(infile         ) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/
rollup2 :=  ROLLUP( SORT( distribute(rollup1        ) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/
rollup3 :=  ROLLUP( SORT( distribute(rollup2 ,proxid) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/
RETURN rollup3;                                                                                                                    /*HACK, disable default return*/

END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_number)}],SALT30.Layout_FieldValueList));
  SELF.hist_duns_number_Values := IF ( le.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList));
  SELF.hist_domestic_corp_key_Values := IF ( le.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.foreign_corp_key_Values := IF ( le.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.unk_corp_key_Values := IF ( le.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.ebr_file_number_Values := IF ( le.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.ebr_file_number)}],SALT30.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_duns_number)}],SALT30.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_enterprise_number)}],SALT30.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_phone)}],SALT30.Layout_FieldValueList));
  SELF.hist_enterprise_number_Values := IF ( le.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_enterprise_number)}],SALT30.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.prim_range) + ' ' + TRIM((SALT30.StrType)le.prim_name_derived) + ' ' + TRIM((SALT30.StrType)le.sec_range) + ' ' + TRIM((SALT30.StrType)le.v_city_name) + ' ' + TRIM((SALT30.StrType)le.st) + ' ' + TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_name)}],SALT30.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.cnp_number)}],SALT30.Layout_FieldValueList));
  SELF.hist_duns_number_Values := IF ( le.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_duns_number)}],SALT30.Layout_FieldValueList));
  SELF.hist_domestic_corp_key_Values := IF ( le.hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_domestic_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.foreign_corp_key_Values := IF ( le.foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.foreign_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.unk_corp_key_Values := IF ( le.unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.unk_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.ebr_file_number_Values := IF ( le.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.ebr_file_number)}],SALT30.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_duns_number)}],SALT30.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_enterprise_number)}],SALT30.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.active_domestic_corp_key)}],SALT30.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_fein)}],SALT30.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.company_phone)}],SALT30.Layout_FieldValueList));
  SELF.hist_enterprise_number_Values := IF ( le.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.hist_enterprise_number)}],SALT30.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.prim_range) + ' ' + TRIM((SALT30.StrType)le.prim_name_derived) + ' ' + TRIM((SALT30.StrType)le.sec_range) + ' ' + TRIM((SALT30.StrType)le.v_city_name) + ' ' + TRIM((SALT30.StrType)le.st) + ' ' + TRIM((SALT30.StrType)le.zip)}],SALT30.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_first_seen)}],SALT30.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT30.StrType)le.dt_last_seen)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.cnp_number := if ( le.cnp_number_prop>0, (TYPEOF(le.cnp_number))'', le.cnp_number ); // Blank if propogated
    self.cnp_number_isnull := le.cnp_number_prop>0 OR le.cnp_number_isnull;
    self.cnp_number_prop := 0; // Avoid reducing score later
    self.hist_duns_number := if ( le.hist_duns_number_prop>0, (TYPEOF(le.hist_duns_number))'', le.hist_duns_number ); // Blank if propogated
    self.hist_duns_number_isnull := le.hist_duns_number_prop>0 OR le.hist_duns_number_isnull;
    self.hist_duns_number_prop := 0; // Avoid reducing score later
    self.hist_domestic_corp_key := if ( le.hist_domestic_corp_key_prop>0, (TYPEOF(le.hist_domestic_corp_key))'', le.hist_domestic_corp_key ); // Blank if propogated
    self.hist_domestic_corp_key_isnull := le.hist_domestic_corp_key_prop>0 OR le.hist_domestic_corp_key_isnull;
    self.hist_domestic_corp_key_prop := 0; // Avoid reducing score later
    self.foreign_corp_key := if ( le.foreign_corp_key_prop>0, (TYPEOF(le.foreign_corp_key))'', le.foreign_corp_key ); // Blank if propogated
    self.foreign_corp_key_isnull := le.foreign_corp_key_prop>0 OR le.foreign_corp_key_isnull;
    self.foreign_corp_key_prop := 0; // Avoid reducing score later
    self.unk_corp_key := if ( le.unk_corp_key_prop>0, (TYPEOF(le.unk_corp_key))'', le.unk_corp_key ); // Blank if propogated
    self.unk_corp_key_isnull := le.unk_corp_key_prop>0 OR le.unk_corp_key_isnull;
    self.unk_corp_key_prop := 0; // Avoid reducing score later
    self.ebr_file_number := if ( le.ebr_file_number_prop>0, (TYPEOF(le.ebr_file_number))'', le.ebr_file_number ); // Blank if propogated
    self.ebr_file_number_isnull := le.ebr_file_number_prop>0 OR le.ebr_file_number_isnull;
    self.ebr_file_number_prop := 0; // Avoid reducing score later
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.active_enterprise_number := if ( le.active_enterprise_number_prop>0, (TYPEOF(le.active_enterprise_number))'', le.active_enterprise_number ); // Blank if propogated
    self.active_enterprise_number_isnull := le.active_enterprise_number_prop>0 OR le.active_enterprise_number_isnull;
    self.active_enterprise_number_prop := 0; // Avoid reducing score later
    self.active_domestic_corp_key := if ( le.active_domestic_corp_key_prop>0, (TYPEOF(le.active_domestic_corp_key))'', le.active_domestic_corp_key ); // Blank if propogated
    self.active_domestic_corp_key_isnull := le.active_domestic_corp_key_prop>0 OR le.active_domestic_corp_key_isnull;
    self.active_domestic_corp_key_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_phone := if ( le.company_phone_prop>0, (TYPEOF(le.company_phone))'', le.company_phone ); // Blank if propogated
    self.company_phone_isnull := le.company_phone_prop>0 OR le.company_phone_isnull;
    self.company_phone_prop := 0; // Avoid reducing score later
    self.sec_range := if ( le.sec_range_prop>0, (TYPEOF(le.sec_range))'', le.sec_range ); // Blank if propogated
    self.sec_range_isnull := le.sec_range_prop>0 OR le.sec_range_isnull;
    self.sec_range_prop := 0; // Avoid reducing score later
    self.hist_enterprise_number := if ( le.hist_enterprise_number_prop>0, (TYPEOF(le.hist_enterprise_number))'', le.hist_enterprise_number ); // Blank if propogated
    self.hist_enterprise_number_isnull := le.hist_enterprise_number_prop>0 OR le.hist_enterprise_number_isnull;
    self.hist_enterprise_number_prop := 0; // Avoid reducing score later
    self.company_addr1 := if ( le.company_addr1_prop>0, 0, le.company_addr1 ); // Blank if propogated
    self.company_addr1_isnull := true; // Flag as null to scoring
    self.company_addr1_prop := 0; // Avoid reducing score later
    self.company_address := if ( le.company_address_prop>0, 0, le.company_address ); // Blank if propogated
    self.company_address_isnull := true; // Flag as null to scoring
    self.company_address_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 hist_duns_number_size := 0;
  UNSIGNED1 hist_domestic_corp_key_size := 0;
  UNSIGNED1 foreign_corp_key_size := 0;
  UNSIGNED1 unk_corp_key_size := 0;
  UNSIGNED1 ebr_file_number_size := 0;
  UNSIGNED1 active_duns_number_size := 0;
  UNSIGNED1 active_enterprise_number_size := 0;
  UNSIGNED1 active_domestic_corp_key_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_phone_size := 0;
  UNSIGNED1 hist_enterprise_number_size := 0;
  UNSIGNED1 company_address_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.cnp_name_size := SALT30.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.cnp_number_size := SALT30.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.hist_duns_number_size := SALT30.Fn_SwitchSpec(s.hist_duns_number_switch,count(le.hist_duns_number_values));
  SELF.hist_domestic_corp_key_size := SALT30.Fn_SwitchSpec(s.hist_domestic_corp_key_switch,count(le.hist_domestic_corp_key_values));
  SELF.foreign_corp_key_size := SALT30.Fn_SwitchSpec(s.foreign_corp_key_switch,count(le.foreign_corp_key_values));
  SELF.unk_corp_key_size := SALT30.Fn_SwitchSpec(s.unk_corp_key_switch,count(le.unk_corp_key_values));
  SELF.ebr_file_number_size := SALT30.Fn_SwitchSpec(s.ebr_file_number_switch,count(le.ebr_file_number_values));
  SELF.active_duns_number_size := SALT30.Fn_SwitchSpec(s.active_duns_number_switch,count(le.active_duns_number_values));
  SELF.active_enterprise_number_size := SALT30.Fn_SwitchSpec(s.active_enterprise_number_switch,count(le.active_enterprise_number_values));
  SELF.active_domestic_corp_key_size := SALT30.Fn_SwitchSpec(s.active_domestic_corp_key_switch,count(le.active_domestic_corp_key_values));
  SELF.company_fein_size := SALT30.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_phone_size := SALT30.Fn_SwitchSpec(s.company_phone_switch,count(le.company_phone_values));
  SELF.hist_enterprise_number_size := SALT30.Fn_SwitchSpec(s.hist_enterprise_number_switch,count(le.hist_enterprise_number_values));
  SELF.company_address_size := SALT30.Fn_SwitchSpec(s.company_address_switch,count(le.company_address_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.cnp_name_size+t.cnp_number_size+t.hist_duns_number_size+t.hist_domestic_corp_key_size+t.foreign_corp_key_size+t.unk_corp_key_size+t.ebr_file_number_size+t.active_duns_number_size+t.active_enterprise_number_size+t.active_domestic_corp_key_size+t.company_fein_size+t.company_phone_size+t.hist_enterprise_number_size+t.company_address_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
