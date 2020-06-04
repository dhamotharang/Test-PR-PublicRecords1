// Various routines to assist in debugging
 
IMPORT SALT32,ut,std;
EXPORT Debug(DATASET(layout_DOT) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  INTEGER2 Attribute_Conf := 0; // Score provided by attribute files
  SALT32.StrType   Matching_Attributes := ''; // Keys from attribute files which match
  TYPEOF(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cnp_number) right_cnp_number;
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
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.st) right_st;
  TYPEOF(h.isContact) left_isContact;
  INTEGER1 isContact_match_code;
  INTEGER2 isContact_score;
  BOOLEAN isContact_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.isContact) right_isContact;
  TYPEOF(h.contact_ssn) left_contact_ssn;
  INTEGER1 contact_ssn_match_code;
  INTEGER2 contact_ssn_score;
  TYPEOF(h.contact_ssn) right_contact_ssn;
  TYPEOF(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  BOOLEAN company_fein_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.company_fein) right_company_fein;
  TYPEOF(h.active_enterprise_number) left_active_enterprise_number;
  INTEGER1 active_enterprise_number_match_code;
  INTEGER2 active_enterprise_number_score;
  BOOLEAN active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.active_enterprise_number) right_active_enterprise_number;
  TYPEOF(h.active_domestic_corp_key) left_active_domestic_corp_key;
  INTEGER1 active_domestic_corp_key_match_code;
  INTEGER2 active_domestic_corp_key_score;
  BOOLEAN active_domestic_corp_key_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.active_domestic_corp_key) right_active_domestic_corp_key;
  TYPEOF(h.cnp_name) left_cnp_name;
  INTEGER1 cnp_name_match_code;
  INTEGER2 cnp_name_score;
  BOOLEAN cnp_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cnp_name) right_cnp_name;
  TYPEOF(h.corp_legal_name) left_corp_legal_name;
  INTEGER1 corp_legal_name_match_code;
  INTEGER2 corp_legal_name_score;
  BOOLEAN corp_legal_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.corp_legal_name) right_corp_legal_name;
  TYPEOF(h.address) left_address;
  INTEGER1 address_match_code;
  INTEGER2 address_score;
  BOOLEAN address_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.address) right_address;
  TYPEOF(h.active_duns_number) left_active_duns_number;
  INTEGER1 active_duns_number_match_code;
  INTEGER2 active_duns_number_score;
  TYPEOF(h.active_duns_number) right_active_duns_number;
  TYPEOF(h.addr1) left_addr1;
  INTEGER1 addr1_match_code;
  INTEGER2 addr1_score;
  TYPEOF(h.addr1) right_addr1;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.csz) left_csz;
  INTEGER1 csz_match_code;
  INTEGER2 csz_score;
  BOOLEAN csz_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.csz) right_csz;
  TYPEOF(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  BOOLEAN sec_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.v_city_name) left_v_city_name;
  INTEGER1 v_city_name_match_code;
  INTEGER2 v_city_name_score;
  TYPEOF(h.v_city_name) right_v_city_name;
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
  TYPEOF(h.cnp_btype) left_cnp_btype;
  INTEGER1 cnp_btype_match_code;
  INTEGER2 cnp_btype_score;
  TYPEOF(h.cnp_btype) right_cnp_btype;
  TYPEOF(h.cnp_lowv) left_cnp_lowv;
  TYPEOF(h.cnp_lowv) right_cnp_lowv;
  TYPEOF(h.cnp_translated) left_cnp_translated;
  TYPEOF(h.cnp_translated) right_cnp_translated;
  TYPEOF(h.cnp_classid) left_cnp_classid;
  TYPEOF(h.cnp_classid) right_cnp_classid;
  TYPEOF(h.company_bdid) left_company_bdid;
  TYPEOF(h.company_bdid) right_company_bdid;
  TYPEOF(h.company_phone) left_company_phone;
  TYPEOF(h.company_phone) right_company_phone;
  TYPEOF(h.company_name) left_company_name;
  TYPEOF(h.company_name) right_company_name;
  TYPEOF(h.title) left_title;
  TYPEOF(h.title) right_title;
  TYPEOF(h.contact_phone) left_contact_phone;
  TYPEOF(h.contact_phone) right_contact_phone;
  TYPEOF(h.contact_email) left_contact_email;
  TYPEOF(h.contact_email) right_contact_email;
  TYPEOF(h.contact_job_title_raw) left_contact_job_title_raw;
  TYPEOF(h.contact_job_title_raw) right_contact_job_title_raw;
  TYPEOF(h.company_department) left_company_department;
  TYPEOF(h.company_department) right_company_department;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.DOTid1 := le.DOTid;
  SELF.DOTid2 := ri.DOTid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
		le.cnp_number_isnull OR ri.cnp_number_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_isContact := le.isContact;
  SELF.right_isContact := ri.isContact;
  SELF.isContact_match_code := MAP(
		le.isContact_isnull OR ri.isContact_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_isContact(le.isContact,ri.isContact));
  INTEGER2 isContact_score_temp := MAP(
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT32.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
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
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
		le.company_fein_isnull OR ri.company_fein_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_company_fein(le.company_fein,ri.company_fein));
  INTEGER2 company_fein_score_temp := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT32.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_active_enterprise_number := le.active_enterprise_number;
  SELF.right_active_enterprise_number := ri.active_enterprise_number;
  SELF.active_enterprise_number_match_code := MAP(
		le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_active_enterprise_number(le.active_enterprise_number,ri.active_enterprise_number));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT32.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
  SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
  SELF.active_domestic_corp_key_match_code := MAP(
		le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_active_domestic_corp_key(le.active_domestic_corp_key,ri.active_domestic_corp_key));
  INTEGER2 active_domestic_corp_key_score_temp := MAP(
                        le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT32.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_match_code := MAP(
		le.cnp_name_isnull OR ri.cnp_name_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_name(le.cnp_name,ri.cnp_name, le.cnp_name_len, ri.cnp_name_len));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.WithinEditNew(le.cnp_name,le.cnp_name_len,ri.cnp_name,ri.cnp_name_len,1,0) => SALT32.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  SELF.left_corp_legal_name := le.corp_legal_name;
  SELF.right_corp_legal_name := ri.corp_legal_name;
  SELF.corp_legal_name_match_code := MAP(
		le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_corp_legal_name(le.corp_legal_name,ri.corp_legal_name, le.corp_legal_name_len, ri.corp_legal_name_len));
  INTEGER2 corp_legal_name_score_temp := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT32.MatchBagOfWords(le.corp_legal_name,ri.corp_legal_name,31762,1));
  SELF.address_match_code := MAP(
		(le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_address(le.address,ri.address));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.addr1_weight100 + ri.addr1_weight100 + le.csz_weight100 + ri.csz_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  SELF.left_address := le.address;
  SELF.right_address := ri.address;
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.active_duns_number_match_code := MAP(
		le.active_duns_number_isnull OR ri.active_duns_number_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_active_duns_number(le.active_duns_number,ri.active_duns_number));
  SELF.active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT32.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  SELF.addr1_match_code := MAP(
		(le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => SALT32.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_addr1(le.addr1,ri.addr1));
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_addr1 := le.addr1;
  SELF.right_addr1 := ri.addr1;
  SELF.csz_match_code := MAP(
		(le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => SALT32.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_csz(le.csz,ri.csz));
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_csz := le.csz;
  SELF.right_csz := ri.csz;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
		le.sec_range_isnull OR ri.sec_range_isnull => SALT32.MatchCode.OneSideNull,
		addr1_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_sec_range(le.sec_range,ri.sec_range));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT32.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_match_code := MAP(
		le.v_city_name_isnull OR ri.v_city_name_isnull => SALT32.MatchCode.OneSideNull,
		csz_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		le.st <> ri.st => SALT32.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_v_city_name(le.v_city_name,ri.v_city_name));
  SELF.v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT32.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
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
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_match_code := MAP(
		le.cnp_btype_isnull OR ri.cnp_btype_isnull => SALT32.MatchCode.OneSideNull,
		match_methods(ih).match_cnp_btype(le.cnp_btype,ri.cnp_btype));
  SELF.cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_cnp_lowv := le.cnp_lowv;
  SELF.right_cnp_lowv := ri.cnp_lowv;
  SELF.left_cnp_translated := le.cnp_translated;
  SELF.right_cnp_translated := ri.cnp_translated;
  SELF.left_cnp_classid := le.cnp_classid;
  SELF.right_cnp_classid := ri.cnp_classid;
  SELF.left_company_bdid := le.company_bdid;
  SELF.right_company_bdid := ri.company_bdid;
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.left_title := le.title;
  SELF.right_title := ri.title;
  SELF.left_contact_phone := le.contact_phone;
  SELF.right_contact_phone := ri.contact_phone;
  SELF.left_contact_email := le.contact_email;
  SELF.right_contact_email := ri.contact_email;
  SELF.left_contact_job_title_raw := le.contact_job_title_raw;
  SELF.right_contact_job_title_raw := ri.contact_job_title_raw;
  SELF.left_company_department := le.company_department;
  SELF.right_company_department := ri.company_department;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.cnp_number_score := IF ( le.cnp_number = ri.cnp_number, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
		le.prim_range_isnull OR ri.prim_range_isnull => SALT32.MatchCode.OneSideNull,
		addr1_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
		le.prim_name_isnull OR ri.prim_name_isnull => SALT32.MatchCode.OneSideNull,
		addr1_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
		le.st_isnull OR ri.st_isnull => SALT32.MatchCode.OneSideNull,
		csz_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_st(le.st,ri.st));
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT32.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.isContact_score := IF ( le.isContact = ri.isContact, isContact_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.isContact_skipped := SELF.isContact_score < -5000;// Enforce FORCE parameter
  SELF.company_fein_score := IF ( company_fein_score_temp >= Config.company_fein_Force * 100, company_fein_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.company_fein_skipped := SELF.company_fein_score < -5000;// Enforce FORCE parameter
  SELF.active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_enterprise_number_skipped := SELF.active_enterprise_number_score < -5000;// Enforce FORCE parameter
  SELF.active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_domestic_corp_key_skipped := SELF.active_domestic_corp_key_score < -5000;// Enforce FORCE parameter
  SELF.cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_name_skipped := SELF.cnp_name_score < -5000;// Enforce FORCE parameter
  SELF.corp_legal_name_score := IF ( corp_legal_name_score_temp >= Config.corp_legal_name_Force * 100, corp_legal_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.corp_legal_name_skipped := SELF.corp_legal_name_score < -5000;// Enforce FORCE parameter
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
		le.zip_isnull OR ri.zip_isnull => SALT32.MatchCode.OneSideNull,
		csz_score_pre > 0 OR address_score_pre > 0 => SALT32.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT32.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_skipped := SELF.sec_range_score < -5000;// Enforce FORCE parameter
  SELF.lname_score := IF (le.lname = ri.lname or/*HACK*/  lname_score_temp > Config.lname_Force * 100, lname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.lname_skipped := SELF.lname_score < -5000;// Enforce FORCE parameter
  SELF.mname_score := IF ( mname_score_temp >= Config.mname_Force * 100, mname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.mname_skipped := SELF.mname_score < -5000;// Enforce FORCE parameter
  SELF.fname_score := IF (le.fname = ri.fname or/*HACK*/  fname_score_temp > Config.fname_Force * 100, fname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.fname_skipped := SELF.fname_score < -5000;// Enforce FORCE parameter
  SELF.name_suffix_score := IF ( name_suffix_score_temp >= Config.name_suffix_Force * 100, name_suffix_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.name_suffix_skipped := SELF.name_suffix_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_score := IF ( le.prim_range = ri.prim_range OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp > Config.st_Force * 100 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := SALT32.ClipScore(MAX(addr1_score_pre,0) + self.prim_range_score + self.prim_name_score + self.sec_range_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  SELF.addr1_score := addr1_score_res;
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := SALT32.ClipScore(MAX(csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  SELF.csz_score := IF ( csz_score_ext > -200,csz_score_res,-9999);
  SELF.csz_skipped := SELF.csz_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT32.ClipScore(MAX(address_score_pre,0)+ SELF.addr1_score + self.prim_range_score + self.prim_name_score + self.sec_range_score+ SELF.csz_score + self.v_city_name_score + self.st_score + self.zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := IF ( address_score_ext > 0,address_score_res,-9999);
  SELF.address_skipped := SELF.address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_range_prop,ri.prim_range_prop)*SELF.prim_range_score // Score if either field propogated
    +MAX(le.prim_name_prop,ri.prim_name_prop)*SELF.prim_name_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*SELF.active_enterprise_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*SELF.active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.corp_legal_name_prop,ri.corp_legal_name_prop)*SELF.corp_legal_name_score // Score if either field propogated
    +if(le.address_prop+ri.address_prop>0,self.address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,s.addr1_specificity,0))/( s.addr1_specificity),0)
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,self.addr1_score*(0+if(le.prim_range_prop+ri.prim_range_prop>0,s.prim_range_specificity,0)+if(le.prim_name_prop+ri.prim_name_prop>0,s.prim_name_specificity,0)+if(le.sec_range_prop+ri.sec_range_prop>0,s.sec_range_specificity,0))/( s.prim_range_specificity+ s.prim_name_specificity+ s.sec_range_specificity),0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*SELF.sec_range_score // Score if either field propogated
    +(MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*self.mname_score // Proportion of longest string propogated
    +MAX(le.name_suffix_prop,ri.name_suffix_prop)*SELF.name_suffix_score // Score if either field propogated
    +MAX(le.cnp_btype_prop,ri.cnp_btype_prop)*SELF.cnp_btype_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.cnp_number_score + SELF.isContact_score + SELF.contact_ssn_score + SELF.company_fein_score + SELF.active_enterprise_number_score + SELF.active_domestic_corp_key_score + SELF.cnp_name_score + SELF.corp_legal_name_score + IF(SELF.address_score>0,MAX(SELF.address_score,IF(SELF.addr1_score>0,MAX(SELF.addr1_score,SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score),SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score) + IF(SELF.csz_score>0,MAX(SELF.csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score)),IF(SELF.addr1_score>0,MAX(SELF.addr1_score,SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score),SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score) + IF(SELF.csz_score>0,MAX(SELF.csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score)) + SELF.active_duns_number_score + SELF.lname_score + SELF.mname_score + SELF.fname_score + SELF.name_suffix_score + SELF.cnp_btype_score) / 100 + outside;
END;
SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION
  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM
    SELF.Attribute_Conf := ri.Conf;
    SELF.Matching_Attributes := ri.Source_Id;
    SELF.Conf := le.Conf + ri.Conf;
    SELF := le;
  END;
  RETURN JOIN(am,ia,LEFT.DOTid1=RIGHT.DOTid1 AND LEFT.DOTid2=RIGHT.DOTid2,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.DOTid = RIGHT.DOTid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.DOTid2 = RIGHT.DOTid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, DOTid1, DOTid2, -Conf, LOCAL ), DOTid1, DOTid2, LOCAL ); // DOTid2 distributed by join
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
  SALT32.UIDType DOTid;
  DATASET(SALT32.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) isContact_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_fein_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) corp_legal_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) address_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) lname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) mname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) fname_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_phone_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_name_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) title_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_phone_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_email_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) contact_job_title_raw_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) company_department_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
  DATASET(SALT32.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT32.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.DOTid := le.DOTid;
    SELF.cnp_number_values := SALT32.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.isContact_values := SALT32.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
    SELF.contact_ssn_values := SALT32.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
    SELF.company_fein_values := SALT32.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.active_enterprise_number_values := SALT32.fn_combine_fieldvaluelist(le.active_enterprise_number_values,ri.active_enterprise_number_values);
    SELF.active_domestic_corp_key_values := SALT32.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
    SELF.cnp_name_values := SALT32.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.corp_legal_name_values := SALT32.fn_combine_fieldvaluelist(le.corp_legal_name_values,ri.corp_legal_name_values);
    SELF.address_values := SALT32.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
    SELF.active_duns_number_values := SALT32.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
    SELF.lname_values := SALT32.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
    SELF.mname_values := SALT32.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
    SELF.fname_values := SALT32.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
    SELF.name_suffix_values := SALT32.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.cnp_btype_values := SALT32.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.cnp_lowv_values := SALT32.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
    SELF.cnp_translated_values := SALT32.fn_combine_fieldvaluelist(le.cnp_translated_values,ri.cnp_translated_values);
    SELF.cnp_classid_values := SALT32.fn_combine_fieldvaluelist(le.cnp_classid_values,ri.cnp_classid_values);
    SELF.company_bdid_values := SALT32.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
    SELF.company_phone_values := SALT32.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
    SELF.company_name_values := SALT32.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.title_values := SALT32.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
    SELF.contact_phone_values := SALT32.fn_combine_fieldvaluelist(le.contact_phone_values,ri.contact_phone_values);
    SELF.contact_email_values := SALT32.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
    SELF.contact_job_title_raw_values := SALT32.fn_combine_fieldvaluelist(le.contact_job_title_raw_values,ri.contact_job_title_raw_values);
    SELF.company_department_values := SALT32.fn_combine_fieldvaluelist(le.company_department_values,ri.company_department_values);
    SELF.dt_first_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT32.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(DOTid) ), DOTid, LOCAL ), LEFT.DOTid = RIGHT.DOTid, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.DOTid := le.DOTid;
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.isContact_values := SORT(le.isContact_values, -cnt, val, LOCAL);
    SELF.contact_ssn_values := SORT(le.contact_ssn_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.active_enterprise_number_values := SORT(le.active_enterprise_number_values, -cnt, val, LOCAL);
    SELF.active_domestic_corp_key_values := SORT(le.active_domestic_corp_key_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.corp_legal_name_values := SORT(le.corp_legal_name_values, -cnt, val, LOCAL);
    SELF.address_values := SORT(le.address_values, -cnt, val, LOCAL);
    SELF.active_duns_number_values := SORT(le.active_duns_number_values, -cnt, val, LOCAL);
    SELF.lname_values := SORT(le.lname_values, -cnt, val, LOCAL);
    SELF.mname_values := SORT(le.mname_values, -cnt, val, LOCAL);
    SELF.fname_values := SORT(le.fname_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.cnp_lowv_values := SORT(le.cnp_lowv_values, -cnt, val, LOCAL);
    SELF.cnp_translated_values := SORT(le.cnp_translated_values, -cnt, val, LOCAL);
    SELF.cnp_classid_values := SORT(le.cnp_classid_values, -cnt, val, LOCAL);
    SELF.company_bdid_values := SORT(le.company_bdid_values, -cnt, val, LOCAL);
    SELF.company_phone_values := SORT(le.company_phone_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.title_values := SORT(le.title_values, -cnt, val, LOCAL);
    SELF.contact_phone_values := SORT(le.contact_phone_values, -cnt, val, LOCAL);
    SELF.contact_email_values := SORT(le.contact_email_values, -cnt, val, LOCAL);
    SELF.contact_job_title_raw_values := SORT(le.contact_job_title_raw_values, -cnt, val, LOCAL);
    SELF.company_department_values := SORT(le.company_department_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.DOTid := le.DOTid;
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_number)}],SALT32.Layout_FieldValueList));
  SELF.isContact_Values := IF ( le.isContact  IN SET(s.nulls_isContact,isContact) OR le.isContact = (TYPEOF(le.isContact))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.isContact)}],SALT32.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_ssn)}],SALT32.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.company_fein)}],SALT32.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR le.active_enterprise_number = (TYPEOF(le.active_enterprise_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_enterprise_number)}],SALT32.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR le.active_domestic_corp_key = (TYPEOF(le.active_domestic_corp_key))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_name)}],SALT32.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR le.corp_legal_name = (TYPEOF(le.corp_legal_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.corp_legal_name)}],SALT32.Layout_FieldValueList));
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'' AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'' AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))'' AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))'' AND le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'' AND le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'',dataset([],SALT32.Layout_FieldValueList),dataset([{TRIM((SALT32.StrType)le.prim_range) + ' ' + TRIM((SALT32.StrType)le.prim_name) + ' ' + TRIM((SALT32.StrType)le.sec_range) + ' ' + TRIM((SALT32.StrType)le.v_city_name) + ' ' + TRIM((SALT32.StrType)le.st) + ' ' + TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR le.active_duns_number = (TYPEOF(le.active_duns_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.lname)}],SALT32.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.mname)}],SALT32.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.fname)}],SALT32.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.name_suffix)}],SALT32.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_btype)}],SALT32.Layout_FieldValueList));
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_lowv)}],SALT32.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_translated)}],SALT32.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_classid)}],SALT32.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT32.StrType)le.company_bdid)}],SALT32.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT32.StrType)le.company_phone)}],SALT32.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList);
  SELF.title_Values := DATASET([{TRIM((SALT32.StrType)le.title)}],SALT32.Layout_FieldValueList);
  SELF.contact_phone_Values := DATASET([{TRIM((SALT32.StrType)le.contact_phone)}],SALT32.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT32.StrType)le.contact_email)}],SALT32.Layout_FieldValueList);
  SELF.contact_job_title_raw_Values := DATASET([{TRIM((SALT32.StrType)le.contact_job_title_raw)}],SALT32.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT32.StrType)le.company_department)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.DOTid := le.DOTid;
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_number)}],SALT32.Layout_FieldValueList));
  SELF.isContact_Values := IF ( le.isContact  IN SET(s.nulls_isContact,isContact) OR le.isContact = (TYPEOF(le.isContact))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.isContact)}],SALT32.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.contact_ssn)}],SALT32.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.company_fein)}],SALT32.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) OR le.active_enterprise_number = (TYPEOF(le.active_enterprise_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_enterprise_number)}],SALT32.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) OR le.active_domestic_corp_key = (TYPEOF(le.active_domestic_corp_key))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_domestic_corp_key)}],SALT32.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_name)}],SALT32.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR le.corp_legal_name = (TYPEOF(le.corp_legal_name))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.corp_legal_name)}],SALT32.Layout_FieldValueList));
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'' AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'' AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))'' AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))'' AND le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'' AND le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'',dataset([],SALT32.Layout_FieldValueList),dataset([{TRIM((SALT32.StrType)le.prim_range) + ' ' + TRIM((SALT32.StrType)le.prim_name) + ' ' + TRIM((SALT32.StrType)le.sec_range) + ' ' + TRIM((SALT32.StrType)le.v_city_name) + ' ' + TRIM((SALT32.StrType)le.st) + ' ' + TRIM((SALT32.StrType)le.zip)}],SALT32.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR le.active_duns_number = (TYPEOF(le.active_duns_number))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.active_duns_number)}],SALT32.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.lname)}],SALT32.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.mname)}],SALT32.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.fname)}],SALT32.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.name_suffix)}],SALT32.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))'',DATASET([],SALT32.Layout_FieldValueList),DATASET([{TRIM((SALT32.StrType)le.cnp_btype)}],SALT32.Layout_FieldValueList));
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_lowv)}],SALT32.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_translated)}],SALT32.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT32.StrType)le.cnp_classid)}],SALT32.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT32.StrType)le.company_bdid)}],SALT32.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT32.StrType)le.company_phone)}],SALT32.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT32.StrType)le.company_name)}],SALT32.Layout_FieldValueList);
  SELF.title_Values := DATASET([{TRIM((SALT32.StrType)le.title)}],SALT32.Layout_FieldValueList);
  SELF.contact_phone_Values := DATASET([{TRIM((SALT32.StrType)le.contact_phone)}],SALT32.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT32.StrType)le.contact_email)}],SALT32.Layout_FieldValueList);
  SELF.contact_job_title_raw_Values := DATASET([{TRIM((SALT32.StrType)le.contact_job_title_raw)}],SALT32.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT32.StrType)le.company_department)}],SALT32.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_first_seen)}],SALT32.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT32.StrType)le.dt_last_seen)}],SALT32.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.prim_range := if ( le.prim_range_prop>0, (TYPEOF(le.prim_range))'', le.prim_range ); // Blank if propogated
    self.prim_range_isnull := le.prim_range_prop>0 OR le.prim_range_isnull;
    self.prim_range_prop := 0; // Avoid reducing score later
    self.prim_name := if ( le.prim_name_prop>0, (TYPEOF(le.prim_name))'', le.prim_name ); // Blank if propogated
    self.prim_name_isnull := le.prim_name_prop>0 OR le.prim_name_isnull;
    self.prim_name_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.active_enterprise_number := if ( le.active_enterprise_number_prop>0, (TYPEOF(le.active_enterprise_number))'', le.active_enterprise_number ); // Blank if propogated
    self.active_enterprise_number_isnull := le.active_enterprise_number_prop>0 OR le.active_enterprise_number_isnull;
    self.active_enterprise_number_prop := 0; // Avoid reducing score later
    self.active_domestic_corp_key := if ( le.active_domestic_corp_key_prop>0, (TYPEOF(le.active_domestic_corp_key))'', le.active_domestic_corp_key ); // Blank if propogated
    self.active_domestic_corp_key_isnull := le.active_domestic_corp_key_prop>0 OR le.active_domestic_corp_key_isnull;
    self.active_domestic_corp_key_prop := 0; // Avoid reducing score later
    self.corp_legal_name := if ( le.corp_legal_name_prop>0, (TYPEOF(le.corp_legal_name))'', le.corp_legal_name ); // Blank if propogated
    self.corp_legal_name_isnull := le.corp_legal_name_prop>0 OR le.corp_legal_name_isnull;
    self.corp_legal_name_prop := 0; // Avoid reducing score later
    self.address := if ( le.address_prop>0, 0, le.address ); // Blank if propogated
    self.address_isnull := true; // Flag as null to scoring
    self.address_prop := 0; // Avoid reducing score later
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.addr1 := if ( le.addr1_prop>0, 0, le.addr1 ); // Blank if propogated
    self.addr1_isnull := true; // Flag as null to scoring
    self.addr1_prop := 0; // Avoid reducing score later
    self.sec_range := if ( le.sec_range_prop>0, (TYPEOF(le.sec_range))'', le.sec_range ); // Blank if propogated
    self.sec_range_isnull := le.sec_range_prop>0 OR le.sec_range_isnull;
    self.sec_range_prop := 0; // Avoid reducing score later
    self.mname := le.mname[1..LENGTH(TRIM(le.mname))-le.mname_prop]; // Clip propogated chars
    self.mname_isnull := self.mname='' OR le.mname_isnull;
    self.mname_prop := 0; // Avoid reducing score later
    self.name_suffix := if ( le.name_suffix_prop>0, (TYPEOF(le.name_suffix))'', le.name_suffix ); // Blank if propogated
    self.name_suffix_isnull := le.name_suffix_prop>0 OR le.name_suffix_isnull;
    self.name_suffix_prop := 0; // Avoid reducing score later
    self.cnp_btype := if ( le.cnp_btype_prop>0, (TYPEOF(le.cnp_btype))'', le.cnp_btype ); // Blank if propogated
    self.cnp_btype_isnull := le.cnp_btype_prop>0 OR le.cnp_btype_isnull;
    self.cnp_btype_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 isContact_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 active_enterprise_number_size := 0;
  UNSIGNED1 active_domestic_corp_key_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 corp_legal_name_size := 0;
  UNSIGNED1 address_size := 0;
  UNSIGNED1 active_duns_number_size := 0;
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 mname_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 name_suffix_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.cnp_number_size := SALT32.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.isContact_size := SALT32.Fn_SwitchSpec(s.isContact_switch,count(le.isContact_values));
  SELF.contact_ssn_size := SALT32.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.company_fein_size := SALT32.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.active_enterprise_number_size := SALT32.Fn_SwitchSpec(s.active_enterprise_number_switch,count(le.active_enterprise_number_values));
  SELF.active_domestic_corp_key_size := SALT32.Fn_SwitchSpec(s.active_domestic_corp_key_switch,count(le.active_domestic_corp_key_values));
  SELF.cnp_name_size := SALT32.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.corp_legal_name_size := SALT32.Fn_SwitchSpec(s.corp_legal_name_switch,count(le.corp_legal_name_values));
  SELF.address_size := SALT32.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF.active_duns_number_size := SALT32.Fn_SwitchSpec(s.active_duns_number_switch,count(le.active_duns_number_values));
  SELF.lname_size := SALT32.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.mname_size := SALT32.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.fname_size := SALT32.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.name_suffix_size := SALT32.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF.cnp_btype_size := SALT32.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.cnp_number_size+t.isContact_size+t.contact_ssn_size+t.company_fein_size+t.active_enterprise_number_size+t.active_domestic_corp_key_size+t.cnp_name_size+t.corp_legal_name_size+t.address_size+t.active_duns_number_size+t.lname_size+t.mname_size+t.fname_size+t.name_suffix_size+t.cnp_btype_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
