// Various routines to assist in debugging
 
IMPORT SALT33,ut,std;
EXPORT Debug(DATASET(layout_BizHead) ih, Layout_Specificities.R s, MatchThreshold = Config_BIP.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.parent_proxid) left_parent_proxid;
  INTEGER1 parent_proxid_match_code;
  INTEGER2 parent_proxid_score;
  TYPEOF(h.parent_proxid) right_parent_proxid;
  TYPEOF(h.sele_proxid) left_sele_proxid;
  INTEGER1 sele_proxid_match_code;
  INTEGER2 sele_proxid_score;
  TYPEOF(h.sele_proxid) right_sele_proxid;
  TYPEOF(h.org_proxid) left_org_proxid;
  INTEGER1 org_proxid_match_code;
  INTEGER2 org_proxid_score;
  TYPEOF(h.org_proxid) right_org_proxid;
  TYPEOF(h.ultimate_proxid) left_ultimate_proxid;
  INTEGER1 ultimate_proxid_match_code;
  INTEGER2 ultimate_proxid_score;
  TYPEOF(h.ultimate_proxid) right_ultimate_proxid;
  TYPEOF(h.source_record_id) left_source_record_id;
  INTEGER1 source_record_id_match_code;
  INTEGER2 source_record_id_score;
  TYPEOF(h.source_record_id) right_source_record_id;
  TYPEOF(h.company_url) left_company_url;
  INTEGER1 company_url_match_code;
  INTEGER2 company_url_score;
  TYPEOF(h.company_url) right_company_url;
  TYPEOF(h.contact_ssn) left_contact_ssn;
  INTEGER1 contact_ssn_match_code;
  INTEGER2 contact_ssn_score;
  TYPEOF(h.contact_ssn) right_contact_ssn;
  TYPEOF(h.contact_email) left_contact_email;
  INTEGER1 contact_email_match_code;
  INTEGER2 contact_email_score;
  TYPEOF(h.contact_email) right_contact_email;
  TYPEOF(h.company_name) left_company_name;
  INTEGER1 company_name_match_code;
  INTEGER2 company_name_score;
  TYPEOF(h.company_name) right_company_name;
  TYPEOF(h.cnp_name) left_cnp_name;
  INTEGER1 cnp_name_match_code;
  INTEGER2 cnp_name_score;
  TYPEOF(h.cnp_name) right_cnp_name;
  TYPEOF(h.company_fein) left_company_fein;
  INTEGER1 company_fein_match_code;
  INTEGER2 company_fein_score;
  TYPEOF(h.company_fein) right_company_fein;
  TYPEOF(h.contact_did) left_contact_did;
  INTEGER1 contact_did_match_code;
  INTEGER2 contact_did_score;
  TYPEOF(h.contact_did) right_contact_did;
  TYPEOF(h.company_phone_7) left_company_phone_7;
  INTEGER1 company_phone_7_match_code;
  INTEGER2 company_phone_7_score;
  TYPEOF(h.company_phone_7) right_company_phone_7;
  TYPEOF(h.CONTACTNAME) left_CONTACTNAME;
  INTEGER1 CONTACTNAME_match_code;
  INTEGER2 CONTACTNAME_score;
  TYPEOF(h.CONTACTNAME) right_CONTACTNAME;
  TYPEOF(h.STREETADDRESS) left_STREETADDRESS;
  INTEGER1 STREETADDRESS_match_code;
  INTEGER2 STREETADDRESS_score;
  TYPEOF(h.STREETADDRESS) right_STREETADDRESS;
  TYPEOF(h.company_name_prefix) left_company_name_prefix;
  INTEGER1 company_name_prefix_match_code;
  INTEGER2 company_name_prefix_score;
  TYPEOF(h.company_name_prefix) right_company_name_prefix;
  TYPEOF(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.cnp_number) left_cnp_number;
  INTEGER1 cnp_number_match_code;
  INTEGER2 cnp_number_score;
  TYPEOF(h.cnp_number) right_cnp_number;
  TYPEOF(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.city) left_city;
  INTEGER1 city_match_code;
  INTEGER2 city_score;
  TYPEOF(h.city) right_city;
  TYPEOF(h.city_clean) left_city_clean;
  INTEGER1 city_clean_match_code;
  INTEGER2 city_clean_score;
  TYPEOF(h.city_clean) right_city_clean;
  TYPEOF(h.company_sic_code1) left_company_sic_code1;
  INTEGER1 company_sic_code1_match_code;
  INTEGER2 company_sic_code1_score;
  TYPEOF(h.company_sic_code1) right_company_sic_code1;
  TYPEOF(h.lname) left_lname;
  INTEGER1 lname_match_code;
  INTEGER2 lname_score;
  TYPEOF(h.lname) right_lname;
  TYPEOF(h.company_phone_3) left_company_phone_3;
  INTEGER1 company_phone_3_match_code;
  INTEGER2 company_phone_3_score;
  TYPEOF(h.company_phone_3) right_company_phone_3;
  TYPEOF(h.company_phone_3_ex) left_company_phone_3_ex;
  INTEGER1 company_phone_3_ex_match_code;
  INTEGER2 company_phone_3_ex_score;
  TYPEOF(h.company_phone_3_ex) right_company_phone_3_ex;
  TYPEOF(h.fname_preferred) left_fname_preferred;
  INTEGER1 fname_preferred_match_code;
  INTEGER2 fname_preferred_score;
  TYPEOF(h.fname_preferred) right_fname_preferred;
  TYPEOF(h.mname) left_mname;
  INTEGER1 mname_match_code;
  INTEGER2 mname_score;
  TYPEOF(h.mname) right_mname;
  TYPEOF(h.fname) left_fname;
  INTEGER1 fname_match_code;
  INTEGER2 fname_score;
  TYPEOF(h.fname) right_fname;
  TYPEOF(h.name_suffix) left_name_suffix;
  INTEGER1 name_suffix_match_code;
  INTEGER2 name_suffix_score;
  TYPEOF(h.name_suffix) right_name_suffix;
  TYPEOF(h.cnp_lowv) left_cnp_lowv;
  INTEGER1 cnp_lowv_match_code;
  INTEGER2 cnp_lowv_score;
  TYPEOF(h.cnp_lowv) right_cnp_lowv;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  TYPEOF(h.st) right_st;
  TYPEOF(h.source) left_source;
  INTEGER1 source_match_code;
  INTEGER2 source_score;
  TYPEOF(h.source) right_source;
  TYPEOF(h.cnp_btype) left_cnp_btype;
  INTEGER1 cnp_btype_match_code;
  INTEGER2 cnp_btype_score;
  TYPEOF(h.cnp_btype) right_cnp_btype;
  TYPEOF(h.isContact) left_isContact;
  INTEGER1 isContact_match_code;
  INTEGER2 isContact_score;
  TYPEOF(h.isContact) right_isContact;
  TYPEOF(h.title) left_title;
  INTEGER1 title_match_code;
  INTEGER2 title_score;
  TYPEOF(h.title) right_title;
  TYPEOF(h.sele_flag) left_sele_flag;
  INTEGER1 sele_flag_match_code;
  INTEGER2 sele_flag_score;
  TYPEOF(h.sele_flag) right_sele_flag;
  TYPEOF(h.org_flag) left_org_flag;
  INTEGER1 org_flag_match_code;
  INTEGER2 org_flag_score;
  TYPEOF(h.org_flag) right_org_flag;
  TYPEOF(h.ult_flag) left_ult_flag;
  INTEGER1 ult_flag_match_code;
  INTEGER2 ult_flag_score;
  TYPEOF(h.ult_flag) right_ult_flag;
  TYPEOF(h.fallback_value) left_fallback_value;
  INTEGER1 fallback_value_match_code;
  INTEGER2 fallback_value_score;
  TYPEOF(h.fallback_value) right_fallback_value;
  TYPEOF(h.has_lgid) left_has_lgid;
  TYPEOF(h.has_lgid) right_has_lgid;
  TYPEOF(h.empid) left_empid;
  TYPEOF(h.empid) right_empid;
  TYPEOF(h.source_docid) left_source_docid;
  TYPEOF(h.source_docid) right_source_docid;
  TYPEOF(h.company_phone) left_company_phone;
  TYPEOF(h.company_phone) right_company_phone;
  TYPEOF(h.active_duns_number) left_active_duns_number;
  TYPEOF(h.active_duns_number) right_active_duns_number;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.proxid1 := le.proxid;
  SELF.proxid2 := ri.proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.left_parent_proxid := le.parent_proxid;
  SELF.right_parent_proxid := ri.parent_proxid;
  SELF.parent_proxid_match_code := MAP(
    le.parent_proxid_isnull OR ri.parent_proxid_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_parent_proxid(le.parent_proxid,ri.parent_proxid));
  INTEGER2 parent_proxid_score_temp := MAP(
                        le.parent_proxid_isnull OR ri.parent_proxid_isnull => 0,
                        le.parent_proxid = ri.parent_proxid  => le.parent_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.parent_proxid_weight100,s.parent_proxid_switch));
  SELF.left_sele_proxid := le.sele_proxid;
  SELF.right_sele_proxid := ri.sele_proxid;
  SELF.sele_proxid_match_code := MAP(
    le.sele_proxid_isnull OR ri.sele_proxid_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_sele_proxid(le.sele_proxid,ri.sele_proxid));
  INTEGER2 sele_proxid_score_temp := MAP(
                        le.sele_proxid_isnull OR ri.sele_proxid_isnull => 0,
                        le.sele_proxid = ri.sele_proxid  => le.sele_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.sele_proxid_weight100,s.sele_proxid_switch));
  SELF.left_org_proxid := le.org_proxid;
  SELF.right_org_proxid := ri.org_proxid;
  SELF.org_proxid_match_code := MAP(
    le.org_proxid_isnull OR ri.org_proxid_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_org_proxid(le.org_proxid,ri.org_proxid));
  INTEGER2 org_proxid_score_temp := MAP(
                        le.org_proxid_isnull OR ri.org_proxid_isnull => 0,
                        le.org_proxid = ri.org_proxid  => le.org_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.org_proxid_weight100,s.org_proxid_switch));
  SELF.left_ultimate_proxid := le.ultimate_proxid;
  SELF.right_ultimate_proxid := ri.ultimate_proxid;
  SELF.ultimate_proxid_match_code := MAP(
    le.ultimate_proxid_isnull OR ri.ultimate_proxid_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_ultimate_proxid(le.ultimate_proxid,ri.ultimate_proxid));
  INTEGER2 ultimate_proxid_score_temp := MAP(
                        le.ultimate_proxid_isnull OR ri.ultimate_proxid_isnull => 0,
                        le.ultimate_proxid = ri.ultimate_proxid  => le.ultimate_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.ultimate_proxid_weight100,s.ultimate_proxid_switch));
  SELF.left_source_record_id := le.source_record_id;
  SELF.right_source_record_id := ri.source_record_id;
  SELF.source_record_id_match_code := MAP(
    le.source_record_id_isnull OR ri.source_record_id_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_source_record_id(le.source_record_id,ri.source_record_id));
  SELF.source_record_id_score := MAP(
                        le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT33.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  SELF.left_company_url := le.company_url;
  SELF.right_company_url := ri.company_url;
  SELF.company_url_match_code := MAP(
    le.company_url_isnull OR ri.company_url_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_url(le.company_url,ri.company_url));
  SELF.company_url_score := MAP(
                        le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT33.MatchBagOfWords(le.company_url,ri.company_url,31744,0));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_match_code := MAP(
    le.contact_ssn_isnull OR ri.contact_ssn_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_contact_ssn(le.contact_ssn,ri.contact_ssn));
  SELF.contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_contact_email := le.contact_email;
  SELF.right_contact_email := ri.contact_email;
  SELF.contact_email_match_code := MAP(
    le.contact_email_isnull OR ri.contact_email_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_contact_email(le.contact_email,ri.contact_email));
  SELF.contact_email_score := MAP(
                        le.contact_email_isnull OR ri.contact_email_isnull => 0,
                        le.contact_email = ri.contact_email  => le.contact_email_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_email_weight100,s.contact_email_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_match_code := MAP(
    le.company_name_isnull OR ri.company_name_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_name(le.company_name,ri.company_name));
  SELF.company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT33.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_match_code := MAP(
    le.cnp_name_isnull OR ri.cnp_name_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_cnp_name(le.cnp_name,ri.cnp_name, le.cnp_name_len, ri.cnp_name_len));
  SELF.cnp_name_score := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT33.MatchBagOfWords(le.cnp_name,ri.cnp_name,3177747,1));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_match_code := MAP(
    le.company_fein_isnull OR ri.company_fein_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_fein(le.company_fein,ri.company_fein, le.company_fein_len, ri.company_fein_len));
  SELF.company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT33.WithinEditNew(le.company_fein,le.company_fein_len,ri.company_fein,ri.company_fein_len,1,0) => SALT33.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_contact_did := le.contact_did;
  SELF.right_contact_did := ri.contact_did;
  SELF.contact_did_match_code := MAP(
    le.contact_did_isnull OR ri.contact_did_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_contact_did(le.contact_did,ri.contact_did));
  SELF.contact_did_score := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  SELF.left_company_phone_7 := le.company_phone_7;
  SELF.right_company_phone_7 := ri.company_phone_7;
  SELF.company_phone_7_match_code := MAP(
    le.company_phone_7_isnull OR ri.company_phone_7_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_phone_7(le.company_phone_7,ri.company_phone_7));
  SELF.company_phone_7_score := MAP(
                        le.company_phone_7_isnull OR ri.company_phone_7_isnull => 0,
                        le.company_phone_7 = ri.company_phone_7  => le.company_phone_7_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_7_weight100,s.company_phone_7_switch));
  SELF.CONTACTNAME_match_code := MAP(
    (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_CONTACTNAME(le.CONTACTNAME,ri.CONTACTNAME));
  INTEGER2 CONTACTNAME_score_pre := MAP( (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  SELF.left_CONTACTNAME := le.CONTACTNAME;
  SELF.right_CONTACTNAME := ri.CONTACTNAME;
  SELF.STREETADDRESS_match_code := MAP(
    (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_STREETADDRESS(le.STREETADDRESS,ri.STREETADDRESS));
  INTEGER2 STREETADDRESS_score_pre := MAP( (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  SELF.left_STREETADDRESS := le.STREETADDRESS;
  SELF.right_STREETADDRESS := ri.STREETADDRESS;
  SELF.left_company_name_prefix := le.company_name_prefix;
  SELF.right_company_name_prefix := ri.company_name_prefix;
  SELF.company_name_prefix_match_code := MAP(
    le.company_name_prefix_isnull OR ri.company_name_prefix_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_name_prefix(le.company_name_prefix,ri.company_name_prefix));
  INTEGER2 company_name_prefix_score_temp := MAP(
                        le.company_name_prefix_isnull OR ri.company_name_prefix_isnull => 0,
                        le.company_name_prefix = ri.company_name_prefix  => le.company_name_prefix_weight100,
                        SALT33.Fn_Fail_Scale(le.company_name_prefix_weight100,s.company_name_prefix_switch));
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
    le.prim_name_isnull OR ri.prim_name_isnull => SALT33.MatchCode.OneSideNull,
    STREETADDRESS_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_prim_name(le.prim_name,ri.prim_name, le.prim_name_len, ri.prim_name_len));
  SELF.prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT33.WithinEditNew(le.prim_name,le.prim_name_len,ri.prim_name,ri.prim_name_len,1,0) => SALT33.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
    le.zip_isnull OR ri.zip_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT33.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_match_code := MAP(
    le.cnp_number_isnull OR ri.cnp_number_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_cnp_number(le.cnp_number,ri.cnp_number));
  SELF.cnp_number_score := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
    le.prim_range_isnull OR ri.prim_range_isnull => SALT33.MatchCode.OneSideNull,
    STREETADDRESS_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_prim_range(le.prim_range,ri.prim_range, le.prim_range_len, ri.prim_range_len));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT33.WithinEditNew(le.prim_range,le.prim_range_len,ri.prim_range,ri.prim_range_len,1,0) => SALT33.fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
    le.sec_range_isnull OR ri.sec_range_isnull => SALT33.MatchCode.OneSideNull,
    STREETADDRESS_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_sec_range(le.sec_range,ri.sec_range, le.sec_range_len, ri.sec_range_len));
  SELF.sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT33.WithinEditNew(le.sec_range,le.sec_range_len,ri.sec_range,ri.sec_range_len,1,0) => SALT33.fn_fuzzy_specificity(le.sec_range_weight100,le.sec_range_cnt, le.sec_range_e1_cnt,ri.sec_range_weight100,ri.sec_range_cnt,ri.sec_range_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  SELF.left_city := le.city;
  SELF.right_city := ri.city;
  SELF.city_match_code := MAP(
    le.city_isnull OR ri.city_isnull => SALT33.MatchCode.OneSideNull,
    le.st <> ri.st => SALT33.MatchCode.ContextInvolved, // Only valid if the context variable is equal
    match_methods(ih).match_city(le.city,ri.city, le.city_len, ri.city_len));
  SELF.city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.city = ri.city  => le.city_weight100,
                        SALT33.WithinEditNew(le.city,le.city_len,ri.city,ri.city_len,2,0) and metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2p_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2p_cnt),
                        SALT33.WithinEditNew(le.city,le.city_len,ri.city,ri.city_len,2,0) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2_cnt),
                        metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_p_cnt,ri.city_weight100,ri.city_cnt,ri.city_p_cnt),
                        SALT33.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  SELF.left_city_clean := le.city_clean;
  SELF.right_city_clean := ri.city_clean;
  SELF.city_clean_match_code := MAP(
    le.city_clean_isnull OR ri.city_clean_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_city_clean(le.city_clean,ri.city_clean));
  SELF.city_clean_score := MAP(
                        le.city_clean_isnull OR ri.city_clean_isnull => 0,
                        le.city_clean = ri.city_clean  => le.city_clean_weight100,
                        SALT33.Fn_Fail_Scale(le.city_clean_weight100,s.city_clean_switch));
  SELF.left_company_sic_code1 := le.company_sic_code1;
  SELF.right_company_sic_code1 := ri.company_sic_code1;
  SELF.company_sic_code1_match_code := MAP(
    le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1));
  SELF.company_sic_code1_score := MAP(
                        le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
                        le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
                        SALT33.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_match_code := MAP(
    le.lname_isnull OR ri.lname_isnull => SALT33.MatchCode.OneSideNull,
    CONTACTNAME_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_lname(le.lname,ri.lname, le.lname_len, ri.lname_len));
  SELF.lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.lname = ri.lname OR SALT33.HyphenMatch(le.lname,ri.lname,1)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT33.WithinEditNew(le.lname,le.lname_len,ri.lname,ri.lname_len,2,0) => SALT33.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e2_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e2_cnt),
                        LENGTH(TRIM(le.lname))>0 and le.lname = ri.lname[1..LENGTH(TRIM(le.lname))] => le.lname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.lname))>0 and ri.lname = le.lname[1..LENGTH(TRIM(ri.lname))] => ri.lname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_company_phone_3 := le.company_phone_3;
  SELF.right_company_phone_3 := ri.company_phone_3;
  SELF.company_phone_3_match_code := MAP(
    le.company_phone_3_isnull OR ri.company_phone_3_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_phone_3(le.company_phone_3,ri.company_phone_3));
  SELF.company_phone_3_score := MAP(
                        le.company_phone_3_isnull OR ri.company_phone_3_isnull => 0,
                        le.company_phone_3 = ri.company_phone_3  => le.company_phone_3_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_3_weight100,s.company_phone_3_switch));
  SELF.left_company_phone_3_ex := le.company_phone_3_ex;
  SELF.right_company_phone_3_ex := ri.company_phone_3_ex;
  SELF.company_phone_3_ex_match_code := MAP(
    le.company_phone_3_ex_isnull OR ri.company_phone_3_ex_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_company_phone_3_ex(le.company_phone_3_ex,ri.company_phone_3_ex));
  SELF.company_phone_3_ex_score := MAP(
                        le.company_phone_3_ex_isnull OR ri.company_phone_3_ex_isnull => 0,
                        le.company_phone_3_ex = ri.company_phone_3_ex  => le.company_phone_3_ex_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_3_ex_weight100,s.company_phone_3_ex_switch));
  SELF.left_fname_preferred := le.fname_preferred;
  SELF.right_fname_preferred := ri.fname_preferred;
  SELF.fname_preferred_match_code := MAP(
    le.fname_preferred_isnull OR ri.fname_preferred_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_fname_preferred(le.fname_preferred,ri.fname_preferred));
  SELF.fname_preferred_score := MAP(
                        le.fname_preferred_isnull OR ri.fname_preferred_isnull => 0,
                        le.fname_preferred = ri.fname_preferred  => le.fname_preferred_weight100,
                        SALT33.Fn_Fail_Scale(le.fname_preferred_weight100,s.fname_preferred_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_match_code := MAP(
    le.mname_isnull OR ri.mname_isnull => SALT33.MatchCode.OneSideNull,
    CONTACTNAME_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_mname(le.mname,ri.mname, le.mname_len, ri.mname_len));
  SELF.mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT33.WithinEditNew(le.mname,le.mname_len,ri.mname,ri.mname_len,2,0) => SALT33.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e2_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e2_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_match_code := MAP(
    le.fname_isnull OR ri.fname_isnull => SALT33.MatchCode.OneSideNull,
    CONTACTNAME_score_pre > 0 => SALT33.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
    match_methods(ih).match_fname(le.fname,ri.fname, le.fname_len, ri.fname_len));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT33.WithinEditNew(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) => SALT33.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_name_suffix := le.name_suffix;
  SELF.right_name_suffix := ri.name_suffix;
  SELF.name_suffix_match_code := MAP(
    le.name_suffix_isnull OR ri.name_suffix_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_name_suffix(le.name_suffix,ri.name_suffix));
  SELF.name_suffix_score := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT33.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT33.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  SELF.left_cnp_lowv := le.cnp_lowv;
  SELF.right_cnp_lowv := ri.cnp_lowv;
  SELF.cnp_lowv_match_code := MAP(
    le.cnp_lowv_isnull OR ri.cnp_lowv_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv));
  SELF.cnp_lowv_score := MAP(
                        le.cnp_lowv_isnull OR ri.cnp_lowv_isnull => 0,
                        le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_lowv_weight100,s.cnp_lowv_switch));
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
    le.st_isnull OR ri.st_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_st(le.st,ri.st));
  SELF.st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT33.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  SELF.left_source := le.source;
  SELF.right_source := ri.source;
  SELF.source_match_code := MAP(
    le.source_isnull OR ri.source_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_source(le.source,ri.source));
  SELF.source_score := MAP(
                        le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT33.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_match_code := MAP(
    le.cnp_btype_isnull OR ri.cnp_btype_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_cnp_btype(le.cnp_btype,ri.cnp_btype));
  SELF.cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_isContact := le.isContact;
  SELF.right_isContact := ri.isContact;
  SELF.isContact_match_code := MAP(
    le.isContact_isnull OR ri.isContact_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_isContact(le.isContact,ri.isContact));
  SELF.isContact_score := MAP(
                        le.isContact_isnull OR ri.isContact_isnull => 0,
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT33.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  SELF.left_title := le.title;
  SELF.right_title := ri.title;
  SELF.title_match_code := MAP(
    le.title_isnull OR ri.title_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_title(le.title,ri.title));
  SELF.title_score := MAP(
                        le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT33.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  SELF.left_sele_flag := le.sele_flag;
  SELF.right_sele_flag := ri.sele_flag;
  SELF.sele_flag_match_code := MAP(
    le.sele_flag_isnull OR ri.sele_flag_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_sele_flag(le.sele_flag,ri.sele_flag));
  INTEGER2 sele_flag_score_temp := MAP(
                        le.sele_flag_isnull OR ri.sele_flag_isnull => 0,
                        le.sele_flag = ri.sele_flag  => le.sele_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.sele_flag_weight100,s.sele_flag_switch));
  SELF.left_org_flag := le.org_flag;
  SELF.right_org_flag := ri.org_flag;
  SELF.org_flag_match_code := MAP(
    le.org_flag_isnull OR ri.org_flag_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_org_flag(le.org_flag,ri.org_flag));
  INTEGER2 org_flag_score_temp := MAP(
                        le.org_flag_isnull OR ri.org_flag_isnull => 0,
                        le.org_flag = ri.org_flag  => le.org_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.org_flag_weight100,s.org_flag_switch));
  SELF.left_ult_flag := le.ult_flag;
  SELF.right_ult_flag := ri.ult_flag;
  SELF.ult_flag_match_code := MAP(
    le.ult_flag_isnull OR ri.ult_flag_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_ult_flag(le.ult_flag,ri.ult_flag));
  INTEGER2 ult_flag_score_temp := MAP(
                        le.ult_flag_isnull OR ri.ult_flag_isnull => 0,
                        le.ult_flag = ri.ult_flag  => le.ult_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.ult_flag_weight100,s.ult_flag_switch));
  SELF.left_fallback_value := le.fallback_value;
  SELF.right_fallback_value := ri.fallback_value;
  SELF.fallback_value_match_code := MAP(
    le.fallback_value_isnull OR ri.fallback_value_isnull => SALT33.MatchCode.OneSideNull,
    match_methods(ih).match_fallback_value(le.fallback_value,ri.fallback_value));
  SELF.fallback_value_score := MAP(
                        le.fallback_value_isnull OR ri.fallback_value_isnull => 0,
                        le.fallback_value = ri.fallback_value  => le.fallback_value_weight100,
                        SALT33.Fn_Fail_Scale(le.fallback_value_weight100,s.fallback_value_switch));
  SELF.left_has_lgid := le.has_lgid;
  SELF.right_has_lgid := ri.has_lgid;
  SELF.left_empid := le.empid;
  SELF.right_empid := ri.empid;
  SELF.left_source_docid := le.source_docid;
  SELF.right_source_docid := ri.source_docid;
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  SELF.parent_proxid_score := parent_proxid_score_temp*0.00; 
  SELF.sele_proxid_score := sele_proxid_score_temp*0.00; 
  SELF.org_proxid_score := org_proxid_score_temp*0.00; 
  SELF.ultimate_proxid_score := ultimate_proxid_score_temp*0.00; 
  SELF.company_name_prefix_score := company_name_prefix_score_temp*0.10; 
  SELF.prim_range_score := IF ( prim_range_score_temp >= Config_BIP.prim_range_Force * 100, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.fname_score := fname_score_temp*0.20; 
  SELF.sele_flag_score := sele_flag_score_temp*0.00; 
  SELF.org_flag_score := org_flag_score_temp*0.00; 
  SELF.ult_flag_score := ult_flag_score_temp*0.00; 
// Compute the score for the concept CONTACTNAME
  INTEGER2 CONTACTNAME_score_ext := SALT33.ClipScore(MAX(CONTACTNAME_score_pre,0) + self.fname_score + self.mname_score + self.lname_score);// Score in surrounding context
  INTEGER2 CONTACTNAME_score_res := MAX(0,CONTACTNAME_score_pre); // At least nothing
  SELF.CONTACTNAME_score := CONTACTNAME_score_res;
// Compute the score for the concept STREETADDRESS
  INTEGER2 STREETADDRESS_score_ext := SALT33.ClipScore(MAX(STREETADDRESS_score_pre,0) + self.prim_range_score + self.prim_name_score + self.sec_range_score);// Score in surrounding context
  INTEGER2 STREETADDRESS_score_res := MAX(0,STREETADDRESS_score_pre); // At least nothing
  SELF.STREETADDRESS_score := STREETADDRESS_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.company_sic_code1_prop,ri.company_sic_code1_prop)*SELF.company_sic_code1_score // Score if either field propogated
    +MAX(le.cnp_btype_prop,ri.cnp_btype_prop)*SELF.cnp_btype_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.parent_proxid_score + SELF.sele_proxid_score + SELF.org_proxid_score + SELF.ultimate_proxid_score + SELF.source_record_id_score + SELF.company_url_score + SELF.contact_ssn_score + SELF.contact_email_score + SELF.company_name_score + SELF.cnp_name_score + SELF.company_fein_score + SELF.contact_did_score + SELF.company_phone_7_score + IF(SELF.CONTACTNAME_score>0,MAX(SELF.CONTACTNAME_score,SELF.fname_score + SELF.mname_score + SELF.lname_score),SELF.fname_score + SELF.mname_score + SELF.lname_score) + IF(SELF.STREETADDRESS_score>0,MAX(SELF.STREETADDRESS_score,SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score),SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score) + SELF.company_name_prefix_score + SELF.zip_score + SELF.cnp_number_score + SELF.city_score + SELF.city_clean_score + SELF.company_sic_code1_score + SELF.company_phone_3_score + SELF.company_phone_3_ex_score + SELF.fname_preferred_score + SELF.name_suffix_score + SELF.cnp_lowv_score + SELF.st_score + SELF.source_score + SELF.cnp_btype_score + SELF.isContact_score + SELF.title_score + SELF.sele_flag_score + SELF.org_flag_score + SELF.ult_flag_score + SELF.fallback_value_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.proxid = RIGHT.proxid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.proxid2 = RIGHT.proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, proxid1, proxid2, -Conf, LOCAL ), proxid1, proxid2, LOCAL ); // proxid2 distributed by join
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT33.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
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
  SALT33.UIDType proxid;
  DATASET(SALT33.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) sele_proxid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) org_proxid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_url_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) contact_email_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_name_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_fein_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) contact_did_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_phone_7_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) CONTACTNAME_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) STREETADDRESS_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_name_prefix_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) zip_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) city_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) city_clean_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_sic_code1_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_phone_3_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_phone_3_ex_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) fname_preferred_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) st_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) source_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) isContact_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) title_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) sele_flag_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) org_flag_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) ult_flag_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) fallback_value_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) empid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) source_docid_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) company_phone_Values := DATASET([],SALT33.Layout_FieldValueList);
  DATASET(SALT33.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT33.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SALT33.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
    SELF.sele_proxid_values := SALT33.fn_combine_fieldvaluelist(le.sele_proxid_values,ri.sele_proxid_values);
    SELF.org_proxid_values := SALT33.fn_combine_fieldvaluelist(le.org_proxid_values,ri.org_proxid_values);
    SELF.ultimate_proxid_values := SALT33.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
    SELF.source_record_id_values := SALT33.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
    SELF.company_url_values := SALT33.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
    SELF.contact_ssn_values := SALT33.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
    SELF.contact_email_values := SALT33.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
    SELF.company_name_values := SALT33.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.cnp_name_values := SALT33.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.company_fein_values := SALT33.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.contact_did_values := SALT33.fn_combine_fieldvaluelist(le.contact_did_values,ri.contact_did_values);
    SELF.company_phone_7_values := SALT33.fn_combine_fieldvaluelist(le.company_phone_7_values,ri.company_phone_7_values);
    SELF.CONTACTNAME_values := SALT33.fn_combine_fieldvaluelist(le.CONTACTNAME_values,ri.CONTACTNAME_values);
    SELF.STREETADDRESS_values := SALT33.fn_combine_fieldvaluelist(le.STREETADDRESS_values,ri.STREETADDRESS_values);
    SELF.company_name_prefix_values := SALT33.fn_combine_fieldvaluelist(le.company_name_prefix_values,ri.company_name_prefix_values);
    SELF.zip_values := SALT33.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.cnp_number_values := SALT33.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.city_values := SALT33.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
    SELF.city_clean_values := SALT33.fn_combine_fieldvaluelist(le.city_clean_values,ri.city_clean_values);
    SELF.company_sic_code1_values := SALT33.fn_combine_fieldvaluelist(le.company_sic_code1_values,ri.company_sic_code1_values);
    SELF.company_phone_3_values := SALT33.fn_combine_fieldvaluelist(le.company_phone_3_values,ri.company_phone_3_values);
    SELF.company_phone_3_ex_values := SALT33.fn_combine_fieldvaluelist(le.company_phone_3_ex_values,ri.company_phone_3_ex_values);
    SELF.fname_preferred_values := SALT33.fn_combine_fieldvaluelist(le.fname_preferred_values,ri.fname_preferred_values);
    SELF.name_suffix_values := SALT33.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.cnp_lowv_values := SALT33.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
    SELF.st_values := SALT33.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.source_values := SALT33.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
    SELF.cnp_btype_values := SALT33.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.isContact_values := SALT33.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
    SELF.title_values := SALT33.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
    SELF.sele_flag_values := SALT33.fn_combine_fieldvaluelist(le.sele_flag_values,ri.sele_flag_values);
    SELF.org_flag_values := SALT33.fn_combine_fieldvaluelist(le.org_flag_values,ri.org_flag_values);
    SELF.ult_flag_values := SALT33.fn_combine_fieldvaluelist(le.ult_flag_values,ri.ult_flag_values);
    SELF.fallback_value_values := SALT33.fn_combine_fieldvaluelist(le.fallback_value_values,ri.fallback_value_values);
    SELF.has_lgid_values := SALT33.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
    SELF.empid_values := SALT33.fn_combine_fieldvaluelist(le.empid_values,ri.empid_values);
    SELF.source_docid_values := SALT33.fn_combine_fieldvaluelist(le.source_docid_values,ri.source_docid_values);
    SELF.company_phone_values := SALT33.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
    SELF.active_duns_number_values := SALT33.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(proxid) ), proxid, LOCAL ), LEFT.proxid = RIGHT.proxid, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SORT(le.parent_proxid_values, -cnt, val, LOCAL);
    SELF.sele_proxid_values := SORT(le.sele_proxid_values, -cnt, val, LOCAL);
    SELF.org_proxid_values := SORT(le.org_proxid_values, -cnt, val, LOCAL);
    SELF.ultimate_proxid_values := SORT(le.ultimate_proxid_values, -cnt, val, LOCAL);
    SELF.source_record_id_values := SORT(le.source_record_id_values, -cnt, val, LOCAL);
    SELF.company_url_values := SORT(le.company_url_values, -cnt, val, LOCAL);
    SELF.contact_ssn_values := SORT(le.contact_ssn_values, -cnt, val, LOCAL);
    SELF.contact_email_values := SORT(le.contact_email_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.contact_did_values := SORT(le.contact_did_values, -cnt, val, LOCAL);
    SELF.company_phone_7_values := SORT(le.company_phone_7_values, -cnt, val, LOCAL);
    SELF.CONTACTNAME_values := SORT(le.CONTACTNAME_values, -cnt, val, LOCAL);
    SELF.STREETADDRESS_values := SORT(le.STREETADDRESS_values, -cnt, val, LOCAL);
    SELF.company_name_prefix_values := SORT(le.company_name_prefix_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.city_values := SORT(le.city_values, -cnt, val, LOCAL);
    SELF.city_clean_values := SORT(le.city_clean_values, -cnt, val, LOCAL);
    SELF.company_sic_code1_values := SORT(le.company_sic_code1_values, -cnt, val, LOCAL);
    SELF.company_phone_3_values := SORT(le.company_phone_3_values, -cnt, val, LOCAL);
    SELF.company_phone_3_ex_values := SORT(le.company_phone_3_ex_values, -cnt, val, LOCAL);
    SELF.fname_preferred_values := SORT(le.fname_preferred_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.cnp_lowv_values := SORT(le.cnp_lowv_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.source_values := SORT(le.source_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.isContact_values := SORT(le.isContact_values, -cnt, val, LOCAL);
    SELF.title_values := SORT(le.title_values, -cnt, val, LOCAL);
    SELF.sele_flag_values := SORT(le.sele_flag_values, -cnt, val, LOCAL);
    SELF.org_flag_values := SORT(le.org_flag_values, -cnt, val, LOCAL);
    SELF.ult_flag_values := SORT(le.ult_flag_values, -cnt, val, LOCAL);
    SELF.fallback_value_values := SORT(le.fallback_value_values, -cnt, val, LOCAL);
    SELF.has_lgid_values := SORT(le.has_lgid_values, -cnt, val, LOCAL);
    SELF.empid_values := SORT(le.empid_values, -cnt, val, LOCAL);
    SELF.source_docid_values := SORT(le.source_docid_values, -cnt, val, LOCAL);
    SELF.company_phone_values := SORT(le.company_phone_values, -cnt, val, LOCAL);
    SELF.active_duns_number_values := SORT(le.active_duns_number_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_Values := IF ( (le.parent_proxid  IN SET(s.nulls_parent_proxid,parent_proxid) OR le.parent_proxid = (TYPEOF(le.parent_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.parent_proxid)}],SALT33.Layout_FieldValueList));
  SELF.sele_proxid_Values := IF ( (le.sele_proxid  IN SET(s.nulls_sele_proxid,sele_proxid) OR le.sele_proxid = (TYPEOF(le.sele_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.sele_proxid)}],SALT33.Layout_FieldValueList));
  SELF.org_proxid_Values := IF ( (le.org_proxid  IN SET(s.nulls_org_proxid,org_proxid) OR le.org_proxid = (TYPEOF(le.org_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.org_proxid)}],SALT33.Layout_FieldValueList));
  SELF.ultimate_proxid_Values := IF ( (le.ultimate_proxid  IN SET(s.nulls_ultimate_proxid,ultimate_proxid) OR le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ultimate_proxid)}],SALT33.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( (le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR le.source_record_id = (TYPEOF(le.source_record_id))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.source_record_id)}],SALT33.Layout_FieldValueList));
  SELF.company_url_Values := IF ( (le.company_url  IN SET(s.nulls_company_url,company_url) OR le.company_url = (TYPEOF(le.company_url))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_url)}],SALT33.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( (le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_ssn)}],SALT33.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( (le.contact_email  IN SET(s.nulls_contact_email,contact_email) OR le.contact_email = (TYPEOF(le.contact_email))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_email)}],SALT33.Layout_FieldValueList));
  SELF.company_name_Values := IF ( (le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_name)}],SALT33.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( (le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_name)}],SALT33.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_fein)}],SALT33.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( (le.contact_did  IN SET(s.nulls_contact_did,contact_did) OR le.contact_did = (TYPEOF(le.contact_did))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_did)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_7_Values := IF ( (le.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7) OR le.company_phone_7 = (TYPEOF(le.company_phone_7))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_7)}],SALT33.Layout_FieldValueList));
  self.CONTACTNAME_Values := IF ( (le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'') AND (le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'') AND (le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))''),dataset([],SALT33.Layout_FieldValueList),dataset([{TRIM((SALT33.StrType)le.fname) + ' ' + TRIM((SALT33.StrType)le.mname) + ' ' + TRIM((SALT33.StrType)le.lname)}],SALT33.Layout_FieldValueList));
  self.STREETADDRESS_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))''),dataset([],SALT33.Layout_FieldValueList),dataset([{TRIM((SALT33.StrType)le.prim_range) + ' ' + TRIM((SALT33.StrType)le.prim_name) + ' ' + TRIM((SALT33.StrType)le.sec_range)}],SALT33.Layout_FieldValueList));
  SELF.company_name_prefix_Values := IF ( (le.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix) OR le.company_name_prefix = (TYPEOF(le.company_name_prefix))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_name_prefix)}],SALT33.Layout_FieldValueList));
  SELF.zip_Values := IF ( (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.zip)}],SALT33.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_number)}],SALT33.Layout_FieldValueList));
  SELF.city_Values := IF ( (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.city)}],SALT33.Layout_FieldValueList));
  SELF.city_clean_Values := IF ( (le.city_clean  IN SET(s.nulls_city_clean,city_clean) OR le.city_clean = (TYPEOF(le.city_clean))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.city_clean)}],SALT33.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( (le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR le.company_sic_code1 = (TYPEOF(le.company_sic_code1))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_sic_code1)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_3_Values := IF ( (le.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3) OR le.company_phone_3 = (TYPEOF(le.company_phone_3))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_3)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_3_ex_Values := IF ( (le.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex) OR le.company_phone_3_ex = (TYPEOF(le.company_phone_3_ex))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_3_ex)}],SALT33.Layout_FieldValueList));
  SELF.fname_preferred_Values := IF ( (le.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred) OR le.fname_preferred = (TYPEOF(le.fname_preferred))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.fname_preferred)}],SALT33.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.name_suffix)}],SALT33.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( (le.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR le.cnp_lowv = (TYPEOF(le.cnp_lowv))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_lowv)}],SALT33.Layout_FieldValueList));
  SELF.st_Values := IF ( (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.st)}],SALT33.Layout_FieldValueList));
  SELF.source_Values := IF ( (le.source  IN SET(s.nulls_source,source) OR le.source = (TYPEOF(le.source))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.source)}],SALT33.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_btype)}],SALT33.Layout_FieldValueList));
  SELF.isContact_Values := IF ( (le.isContact  IN SET(s.nulls_isContact,isContact) OR le.isContact = (TYPEOF(le.isContact))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.isContact)}],SALT33.Layout_FieldValueList));
  SELF.title_Values := IF ( (le.title  IN SET(s.nulls_title,title) OR le.title = (TYPEOF(le.title))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.title)}],SALT33.Layout_FieldValueList));
  SELF.sele_flag_Values := IF ( (le.sele_flag  IN SET(s.nulls_sele_flag,sele_flag) OR le.sele_flag = (TYPEOF(le.sele_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.sele_flag)}],SALT33.Layout_FieldValueList));
  SELF.org_flag_Values := IF ( (le.org_flag  IN SET(s.nulls_org_flag,org_flag) OR le.org_flag = (TYPEOF(le.org_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.org_flag)}],SALT33.Layout_FieldValueList));
  SELF.ult_flag_Values := IF ( (le.ult_flag  IN SET(s.nulls_ult_flag,ult_flag) OR le.ult_flag = (TYPEOF(le.ult_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ult_flag)}],SALT33.Layout_FieldValueList));
  SELF.fallback_value_Values := IF ( (le.fallback_value  IN SET(s.nulls_fallback_value,fallback_value) OR le.fallback_value = (TYPEOF(le.fallback_value))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.fallback_value)}],SALT33.Layout_FieldValueList));
  SELF.has_lgid_Values := DATASET([{TRIM((SALT33.StrType)le.has_lgid)}],SALT33.Layout_FieldValueList);
  SELF.empid_Values := DATASET([{TRIM((SALT33.StrType)le.empid)}],SALT33.Layout_FieldValueList);
  SELF.source_docid_Values := DATASET([{TRIM((SALT33.StrType)le.source_docid)}],SALT33.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT33.StrType)le.company_phone)}],SALT33.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT33.StrType)le.active_duns_number)}],SALT33.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_Values := IF ( (le.parent_proxid  IN SET(s.nulls_parent_proxid,parent_proxid) OR le.parent_proxid = (TYPEOF(le.parent_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.parent_proxid)}],SALT33.Layout_FieldValueList));
  SELF.sele_proxid_Values := IF ( (le.sele_proxid  IN SET(s.nulls_sele_proxid,sele_proxid) OR le.sele_proxid = (TYPEOF(le.sele_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.sele_proxid)}],SALT33.Layout_FieldValueList));
  SELF.org_proxid_Values := IF ( (le.org_proxid  IN SET(s.nulls_org_proxid,org_proxid) OR le.org_proxid = (TYPEOF(le.org_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.org_proxid)}],SALT33.Layout_FieldValueList));
  SELF.ultimate_proxid_Values := IF ( (le.ultimate_proxid  IN SET(s.nulls_ultimate_proxid,ultimate_proxid) OR le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ultimate_proxid)}],SALT33.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( (le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR le.source_record_id = (TYPEOF(le.source_record_id))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.source_record_id)}],SALT33.Layout_FieldValueList));
  SELF.company_url_Values := IF ( (le.company_url  IN SET(s.nulls_company_url,company_url) OR le.company_url = (TYPEOF(le.company_url))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_url)}],SALT33.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( (le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR le.contact_ssn = (TYPEOF(le.contact_ssn))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_ssn)}],SALT33.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( (le.contact_email  IN SET(s.nulls_contact_email,contact_email) OR le.contact_email = (TYPEOF(le.contact_email))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_email)}],SALT33.Layout_FieldValueList));
  SELF.company_name_Values := IF ( (le.company_name  IN SET(s.nulls_company_name,company_name) OR le.company_name = (TYPEOF(le.company_name))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_name)}],SALT33.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( (le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR le.cnp_name = (TYPEOF(le.cnp_name))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_name)}],SALT33.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (le.company_fein  IN SET(s.nulls_company_fein,company_fein) OR le.company_fein = (TYPEOF(le.company_fein))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_fein)}],SALT33.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( (le.contact_did  IN SET(s.nulls_contact_did,contact_did) OR le.contact_did = (TYPEOF(le.contact_did))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.contact_did)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_7_Values := IF ( (le.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7) OR le.company_phone_7 = (TYPEOF(le.company_phone_7))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_7)}],SALT33.Layout_FieldValueList));
  self.CONTACTNAME_Values := IF ( (le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))'') AND (le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))'') AND (le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))''),dataset([],SALT33.Layout_FieldValueList),dataset([{TRIM((SALT33.StrType)le.fname) + ' ' + TRIM((SALT33.StrType)le.mname) + ' ' + TRIM((SALT33.StrType)le.lname)}],SALT33.Layout_FieldValueList));
  self.STREETADDRESS_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))''),dataset([],SALT33.Layout_FieldValueList),dataset([{TRIM((SALT33.StrType)le.prim_range) + ' ' + TRIM((SALT33.StrType)le.prim_name) + ' ' + TRIM((SALT33.StrType)le.sec_range)}],SALT33.Layout_FieldValueList));
  SELF.company_name_prefix_Values := IF ( (le.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix) OR le.company_name_prefix = (TYPEOF(le.company_name_prefix))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_name_prefix)}],SALT33.Layout_FieldValueList));
  SELF.zip_Values := IF ( (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.zip)}],SALT33.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR le.cnp_number = (TYPEOF(le.cnp_number))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_number)}],SALT33.Layout_FieldValueList));
  SELF.city_Values := IF ( (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.city)}],SALT33.Layout_FieldValueList));
  SELF.city_clean_Values := IF ( (le.city_clean  IN SET(s.nulls_city_clean,city_clean) OR le.city_clean = (TYPEOF(le.city_clean))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.city_clean)}],SALT33.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( (le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR le.company_sic_code1 = (TYPEOF(le.company_sic_code1))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_sic_code1)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_3_Values := IF ( (le.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3) OR le.company_phone_3 = (TYPEOF(le.company_phone_3))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_3)}],SALT33.Layout_FieldValueList));
  SELF.company_phone_3_ex_Values := IF ( (le.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex) OR le.company_phone_3_ex = (TYPEOF(le.company_phone_3_ex))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.company_phone_3_ex)}],SALT33.Layout_FieldValueList));
  SELF.fname_preferred_Values := IF ( (le.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred) OR le.fname_preferred = (TYPEOF(le.fname_preferred))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.fname_preferred)}],SALT33.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.name_suffix)}],SALT33.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( (le.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR le.cnp_lowv = (TYPEOF(le.cnp_lowv))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_lowv)}],SALT33.Layout_FieldValueList));
  SELF.st_Values := IF ( (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.st)}],SALT33.Layout_FieldValueList));
  SELF.source_Values := IF ( (le.source  IN SET(s.nulls_source,source) OR le.source = (TYPEOF(le.source))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.source)}],SALT33.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR le.cnp_btype = (TYPEOF(le.cnp_btype))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.cnp_btype)}],SALT33.Layout_FieldValueList));
  SELF.isContact_Values := IF ( (le.isContact  IN SET(s.nulls_isContact,isContact) OR le.isContact = (TYPEOF(le.isContact))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.isContact)}],SALT33.Layout_FieldValueList));
  SELF.title_Values := IF ( (le.title  IN SET(s.nulls_title,title) OR le.title = (TYPEOF(le.title))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.title)}],SALT33.Layout_FieldValueList));
  SELF.sele_flag_Values := IF ( (le.sele_flag  IN SET(s.nulls_sele_flag,sele_flag) OR le.sele_flag = (TYPEOF(le.sele_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.sele_flag)}],SALT33.Layout_FieldValueList));
  SELF.org_flag_Values := IF ( (le.org_flag  IN SET(s.nulls_org_flag,org_flag) OR le.org_flag = (TYPEOF(le.org_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.org_flag)}],SALT33.Layout_FieldValueList));
  SELF.ult_flag_Values := IF ( (le.ult_flag  IN SET(s.nulls_ult_flag,ult_flag) OR le.ult_flag = (TYPEOF(le.ult_flag))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.ult_flag)}],SALT33.Layout_FieldValueList));
  SELF.fallback_value_Values := IF ( (le.fallback_value  IN SET(s.nulls_fallback_value,fallback_value) OR le.fallback_value = (TYPEOF(le.fallback_value))''),DATASET([],SALT33.Layout_FieldValueList),DATASET([{TRIM((SALT33.StrType)le.fallback_value)}],SALT33.Layout_FieldValueList));
  SELF.has_lgid_Values := DATASET([{TRIM((SALT33.StrType)le.has_lgid)}],SALT33.Layout_FieldValueList);
  SELF.empid_Values := DATASET([{TRIM((SALT33.StrType)le.empid)}],SALT33.Layout_FieldValueList);
  SELF.source_docid_Values := DATASET([{TRIM((SALT33.StrType)le.source_docid)}],SALT33.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT33.StrType)le.company_phone)}],SALT33.Layout_FieldValueList);
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT33.StrType)le.active_duns_number)}],SALT33.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_sic_code1 := if ( le.company_sic_code1_prop>0, (TYPEOF(le.company_sic_code1))'', le.company_sic_code1 ); // Blank if propogated
    self.company_sic_code1_isnull := le.company_sic_code1_prop>0 OR le.company_sic_code1_isnull;
    self.company_sic_code1_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 parent_proxid_size := 0;
  UNSIGNED1 sele_proxid_size := 0;
  UNSIGNED1 org_proxid_size := 0;
  UNSIGNED1 ultimate_proxid_size := 0;
  UNSIGNED1 source_record_id_size := 0;
  UNSIGNED1 company_url_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 contact_email_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 contact_did_size := 0;
  UNSIGNED1 company_phone_7_size := 0;
  UNSIGNED1 CONTACTNAME_size := 0;
  UNSIGNED1 STREETADDRESS_size := 0;
  UNSIGNED1 company_name_prefix_size := 0;
  UNSIGNED1 zip_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 city_size := 0;
  UNSIGNED1 city_clean_size := 0;
  UNSIGNED1 company_sic_code1_size := 0;
  UNSIGNED1 company_phone_3_size := 0;
  UNSIGNED1 company_phone_3_ex_size := 0;
  UNSIGNED1 fname_preferred_size := 0;
  UNSIGNED1 name_suffix_size := 0;
  UNSIGNED1 cnp_lowv_size := 0;
  UNSIGNED1 st_size := 0;
  UNSIGNED1 source_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
  UNSIGNED1 isContact_size := 0;
  UNSIGNED1 title_size := 0;
  UNSIGNED1 sele_flag_size := 0;
  UNSIGNED1 org_flag_size := 0;
  UNSIGNED1 ult_flag_size := 0;
  UNSIGNED1 fallback_value_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.parent_proxid_size := SALT33.Fn_SwitchSpec(s.parent_proxid_switch,count(le.parent_proxid_values));
  SELF.sele_proxid_size := SALT33.Fn_SwitchSpec(s.sele_proxid_switch,count(le.sele_proxid_values));
  SELF.org_proxid_size := SALT33.Fn_SwitchSpec(s.org_proxid_switch,count(le.org_proxid_values));
  SELF.ultimate_proxid_size := SALT33.Fn_SwitchSpec(s.ultimate_proxid_switch,count(le.ultimate_proxid_values));
  SELF.source_record_id_size := SALT33.Fn_SwitchSpec(s.source_record_id_switch,count(le.source_record_id_values));
  SELF.company_url_size := SALT33.Fn_SwitchSpec(s.company_url_switch,count(le.company_url_values));
  SELF.contact_ssn_size := SALT33.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.contact_email_size := SALT33.Fn_SwitchSpec(s.contact_email_switch,count(le.contact_email_values));
  SELF.company_name_size := SALT33.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.cnp_name_size := SALT33.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.company_fein_size := SALT33.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.contact_did_size := SALT33.Fn_SwitchSpec(s.contact_did_switch,count(le.contact_did_values));
  SELF.company_phone_7_size := SALT33.Fn_SwitchSpec(s.company_phone_7_switch,count(le.company_phone_7_values));
  SELF.CONTACTNAME_size := SALT33.Fn_SwitchSpec(s.CONTACTNAME_switch,count(le.CONTACTNAME_values));
  SELF.STREETADDRESS_size := SALT33.Fn_SwitchSpec(s.STREETADDRESS_switch,count(le.STREETADDRESS_values));
  SELF.company_name_prefix_size := SALT33.Fn_SwitchSpec(s.company_name_prefix_switch,count(le.company_name_prefix_values));
  SELF.zip_size := SALT33.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.cnp_number_size := SALT33.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.city_size := SALT33.Fn_SwitchSpec(s.city_switch,count(le.city_values));
  SELF.city_clean_size := SALT33.Fn_SwitchSpec(s.city_clean_switch,count(le.city_clean_values));
  SELF.company_sic_code1_size := SALT33.Fn_SwitchSpec(s.company_sic_code1_switch,count(le.company_sic_code1_values));
  SELF.company_phone_3_size := SALT33.Fn_SwitchSpec(s.company_phone_3_switch,count(le.company_phone_3_values));
  SELF.company_phone_3_ex_size := SALT33.Fn_SwitchSpec(s.company_phone_3_ex_switch,count(le.company_phone_3_ex_values));
  SELF.fname_preferred_size := SALT33.Fn_SwitchSpec(s.fname_preferred_switch,count(le.fname_preferred_values));
  SELF.name_suffix_size := SALT33.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF.cnp_lowv_size := SALT33.Fn_SwitchSpec(s.cnp_lowv_switch,count(le.cnp_lowv_values));
  SELF.st_size := SALT33.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.source_size := SALT33.Fn_SwitchSpec(s.source_switch,count(le.source_values));
  SELF.cnp_btype_size := SALT33.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF.isContact_size := SALT33.Fn_SwitchSpec(s.isContact_switch,count(le.isContact_values));
  SELF.title_size := SALT33.Fn_SwitchSpec(s.title_switch,count(le.title_values));
  SELF.sele_flag_size := SALT33.Fn_SwitchSpec(s.sele_flag_switch,count(le.sele_flag_values));
  SELF.org_flag_size := SALT33.Fn_SwitchSpec(s.org_flag_switch,count(le.org_flag_values));
  SELF.ult_flag_size := SALT33.Fn_SwitchSpec(s.ult_flag_switch,count(le.ult_flag_values));
  SELF.fallback_value_size := SALT33.Fn_SwitchSpec(s.fallback_value_switch,count(le.fallback_value_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.parent_proxid_size+t.sele_proxid_size+t.org_proxid_size+t.ultimate_proxid_size+t.source_record_id_size+t.company_url_size+t.contact_ssn_size+t.contact_email_size+t.company_name_size+t.cnp_name_size+t.company_fein_size+t.contact_did_size+t.company_phone_7_size+t.CONTACTNAME_size+t.STREETADDRESS_size+t.company_name_prefix_size+t.zip_size+t.cnp_number_size+t.city_size+t.city_clean_size+t.company_sic_code1_size+t.company_phone_3_size+t.company_phone_3_ex_size+t.fname_preferred_size+t.name_suffix_size+t.cnp_lowv_size+t.st_size+t.source_size+t.cnp_btype_size+t.isContact_size+t.title_size+t.sele_flag_size+t.org_flag_size+t.ult_flag_size+t.fallback_value_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;

