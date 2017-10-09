// Various routines to assist in debugging
IMPORT SALT28,ut,std;
EXPORT Debug(DATASET(layout_BizHead) ih, Layout_Specificities.R s, MatchThreshold = 38) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT28.UIDType proxid1;
  SALT28.UIDType proxid2;
  SALT28.UIDType rcid1;
  SALT28.UIDType rcid2;
  typeof(h.company_url) left_company_url;
  INTEGER2 company_url_score;
  typeof(h.company_url) right_company_url;
  typeof(h.contact_email) left_contact_email;
  INTEGER2 contact_email_score;
  typeof(h.contact_email) right_contact_email;
  typeof(h.source_record_id) left_source_record_id;
  INTEGER2 source_record_id_score;
  typeof(h.source_record_id) right_source_record_id;
  typeof(h.contact_ssn) left_contact_ssn;
  INTEGER2 contact_ssn_score;
  typeof(h.contact_ssn) right_contact_ssn;
  typeof(h.company_name) left_company_name;
  INTEGER2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.company_name_prefix) left_company_name_prefix;
  INTEGER2 company_name_prefix_score;
  typeof(h.company_name_prefix) right_company_name_prefix;
  typeof(h.company_fein) left_company_fein;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.cnp_name) left_cnp_name;
  INTEGER2 cnp_name_score;
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.company_phone_7) left_company_phone_7;
  INTEGER2 company_phone_7_score;
  typeof(h.company_phone_7) right_company_phone_7;
  typeof(h.CONTACTNAME) left_CONTACTNAME;
  INTEGER2 CONTACTNAME_score;
  typeof(h.CONTACTNAME) right_CONTACTNAME;
  typeof(h.STREETADDRESS) left_STREETADDRESS;
  INTEGER2 STREETADDRESS_score;
  typeof(h.STREETADDRESS) right_STREETADDRESS;
  typeof(h.prim_name) left_prim_name;
  INTEGER2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.zip) left_zip;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.cnp_number) left_cnp_number;
  INTEGER2 cnp_number_score;
  typeof(h.cnp_number) right_cnp_number;
  typeof(h.prim_range) left_prim_range;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.sec_range) left_sec_range;
  INTEGER2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.city) left_city;
  INTEGER2 city_score;
  typeof(h.city) right_city;
  typeof(h.city_clean) left_city_clean;
  INTEGER2 city_clean_score;
  typeof(h.city_clean) right_city_clean;
  typeof(h.company_sic_code1) left_company_sic_code1;
  INTEGER2 company_sic_code1_score;
  typeof(h.company_sic_code1) right_company_sic_code1;
  typeof(h.lname) left_lname;
  INTEGER2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.company_phone_3) left_company_phone_3;
  INTEGER2 company_phone_3_score;
  typeof(h.company_phone_3) right_company_phone_3;
  typeof(h.company_phone_3_ex) left_company_phone_3_ex;
  INTEGER2 company_phone_3_ex_score;
  typeof(h.company_phone_3_ex) right_company_phone_3_ex;
  typeof(h.mname) left_mname;
  INTEGER2 mname_score;
  typeof(h.mname) right_mname;
  typeof(h.fname) left_fname;
  INTEGER2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.fname_preferred) left_fname_preferred;
  INTEGER2 fname_preferred_score;
  typeof(h.fname_preferred) right_fname_preferred;
  typeof(h.name_suffix) left_name_suffix;
  INTEGER2 name_suffix_score;
  typeof(h.name_suffix) right_name_suffix;
  typeof(h.cnp_lowv) left_cnp_lowv;
  INTEGER2 cnp_lowv_score;
  typeof(h.cnp_lowv) right_cnp_lowv;
  typeof(h.st) left_st;
  INTEGER2 st_score;
  typeof(h.st) right_st;
  typeof(h.source) left_source;
  INTEGER2 source_score;
  typeof(h.source) right_source;
  typeof(h.cnp_btype) left_cnp_btype;
  INTEGER2 cnp_btype_score;
  typeof(h.cnp_btype) right_cnp_btype;
  typeof(h.isContact) left_isContact;
  INTEGER2 isContact_score;
  typeof(h.isContact) right_isContact;
  typeof(h.title) left_title;
  INTEGER2 title_score;
  typeof(h.title) right_title;
  typeof(h.rcid) left_rcid;
  INTEGER2 rcid_score;
  typeof(h.rcid) right_rcid;
  typeof(h.rcid2) left_rcid2;
  INTEGER2 rcid2_score;
  typeof(h.rcid2) right_rcid2;
  typeof(h.empid) left_empid;
  INTEGER2 empid_score;
  typeof(h.empid) right_empid;
  typeof(h.powid) left_powid;
  INTEGER2 powid_score;
  typeof(h.powid) right_powid;
  typeof(h.sele_flag) left_sele_flag;
  INTEGER2 sele_flag_score;
  typeof(h.sele_flag) right_sele_flag;
  typeof(h.org_flag) left_org_flag;
  INTEGER2 org_flag_score;
  typeof(h.org_flag) right_org_flag;
  typeof(h.ult_flag) left_ult_flag;
  INTEGER2 ult_flag_score;
  typeof(h.ult_flag) right_ult_flag;
  typeof(h.dotid) left_dotid;
  typeof(h.dotid) right_dotid;
  typeof(h.parent_proxid) left_parent_proxid;
  typeof(h.parent_proxid) right_parent_proxid;
  typeof(h.ultimate_proxid) left_ultimate_proxid;
  typeof(h.ultimate_proxid) right_ultimate_proxid;
  typeof(h.has_lgid) left_has_lgid;
  typeof(h.has_lgid) right_has_lgid;
  typeof(h.company_phone) left_company_phone;
  typeof(h.company_phone) right_company_phone;
  typeof(h.company_rawaid) left_company_rawaid;
  typeof(h.company_rawaid) right_company_rawaid;
  typeof(h.company_aceaid) left_company_aceaid;
  typeof(h.company_aceaid) right_company_aceaid;
  typeof(h.predir) left_predir;
  typeof(h.predir) right_predir;
  typeof(h.addr_suffix) left_addr_suffix;
  typeof(h.addr_suffix) right_addr_suffix;
  typeof(h.postdir) left_postdir;
  typeof(h.postdir) right_postdir;
  typeof(h.unit_desig) left_unit_desig;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.p_city_name) left_p_city_name;
  typeof(h.p_city_name) right_p_city_name;
  typeof(h.v_city_name) left_v_city_name;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.zip4) left_zip4;
  typeof(h.zip4) right_zip4;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.dt_vendor_last_reported) left_dt_vendor_last_reported;
  typeof(h.dt_vendor_last_reported) right_dt_vendor_last_reported;
  typeof(h.company_bdid) left_company_bdid;
  typeof(h.company_bdid) right_company_bdid;
  typeof(h.phone_type) left_phone_type;
  typeof(h.phone_type) right_phone_type;
  typeof(h.vl_id) left_vl_id;
  typeof(h.vl_id) right_vl_id;
  typeof(h.contact_did) left_contact_did;
  typeof(h.contact_did) right_contact_did;
  typeof(h.contact_email_domain) left_contact_email_domain;
  typeof(h.contact_email_domain) right_contact_email_domain;
  typeof(h.contact_job_title_derived) left_contact_job_title_derived;
  typeof(h.contact_job_title_derived) right_contact_job_title_derived;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.proxid1 := le.proxid;
  SELF.proxid2 := ri.proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.left_company_url := le.company_url;
  SELF.right_company_url := ri.company_url;
  SELF.company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT28.MatchBagOfWords(le.company_url,ri.company_url,0,0));
  SELF.left_contact_email := le.contact_email;
  SELF.right_contact_email := ri.contact_email;
  SELF.contact_email_score := MAP( le.contact_email_isnull OR ri.contact_email_isnull => 0,
                        le.contact_email = ri.contact_email  => le.contact_email_weight100,
                        SALT28.Fn_Fail_Scale(le.contact_email_weight100,s.contact_email_switch));
  SELF.left_source_record_id := le.source_record_id;
  SELF.right_source_record_id := ri.source_record_id;
  SELF.source_record_id_score := MAP( le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT28.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_score := MAP( le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT28.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT28.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  SELF.left_company_name_prefix := le.company_name_prefix;
  SELF.right_company_name_prefix := ri.company_name_prefix;
  SELF.company_name_prefix_score := MAP( le.company_name_prefix_isnull OR ri.company_name_prefix_isnull => 0,
                        le.company_name_prefix = ri.company_name_prefix  => le.company_name_prefix_weight100,
                        SALT28.Fn_Fail_Scale(le.company_name_prefix_weight100,s.company_name_prefix_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT28.WithinEditN(le.company_fein,ri.company_fein,1) => SALT28.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_score := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT28.MatchBagOfWords(le.cnp_name,ri.cnp_name,98323,1));
  SELF.left_company_phone_7 := le.company_phone_7;
  SELF.right_company_phone_7 := ri.company_phone_7;
  SELF.company_phone_7_score := MAP( le.company_phone_7_isnull OR ri.company_phone_7_isnull => 0,
                        le.company_phone_7 = ri.company_phone_7  => le.company_phone_7_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_7_weight100,s.company_phone_7_switch));
  INTEGER2 CONTACTNAME_score_pre := MAP( (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  SELF.left_CONTACTNAME := le.CONTACTNAME;
  SELF.right_CONTACTNAME := ri.CONTACTNAME;
  INTEGER2 STREETADDRESS_score_pre := MAP( (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  SELF.left_STREETADDRESS := le.STREETADDRESS;
  SELF.right_STREETADDRESS := ri.STREETADDRESS;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT28.WithinEditN(le.prim_name,ri.prim_name,1) => SALT28.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT28.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  SELF.cnp_number_score := MAP( le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  INTEGER2 prim_range_score_temp := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT28.WithinEditN(le.prim_range,ri.prim_range,1) => SALT28.fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT28.WithinEditN(le.sec_range,ri.sec_range,1) => SALT28.fn_fuzzy_specificity(le.sec_range_weight100,le.sec_range_cnt, le.sec_range_e1_cnt,ri.sec_range_weight100,ri.sec_range_cnt,ri.sec_range_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  SELF.left_city := le.city;
  SELF.right_city := ri.city;
  SELF.city_score := MAP( le.city_isnull OR ri.city_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.city = ri.city  => le.city_weight100,
                        SALT28.WithinEditN(le.city,ri.city,2) and metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2p_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2p_cnt),
                        SALT28.WithinEditN(le.city,ri.city,2) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2_cnt),
                        metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_p_cnt,ri.city_weight100,ri.city_cnt,ri.city_p_cnt),
                        SALT28.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  SELF.left_city_clean := le.city_clean;
  SELF.right_city_clean := ri.city_clean;
  SELF.city_clean_score := MAP( le.city_clean_isnull OR ri.city_clean_isnull => 0,
                        le.city_clean = ri.city_clean  => le.city_clean_weight100,
                        SALT28.Fn_Fail_Scale(le.city_clean_weight100,s.city_clean_switch));
  SELF.left_company_sic_code1 := le.company_sic_code1;
  SELF.right_company_sic_code1 := ri.company_sic_code1;
  SELF.company_sic_code1_score := MAP( le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
                        le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
                        SALT28.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_score := MAP( le.lname_isnull OR ri.lname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.lname = ri.lname OR SALT28.fn_hyphen_match(le.lname,ri.lname,1)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT28.WithinEditN(le.lname,ri.lname,2) => SALT28.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e2_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e2_cnt),
                        LENGTH(TRIM(le.lname))>0 and le.lname = ri.lname[1..LENGTH(TRIM(le.lname))] => le.lname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.lname))>0 and ri.lname = le.lname[1..LENGTH(TRIM(ri.lname))] => ri.lname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_company_phone_3 := le.company_phone_3;
  SELF.right_company_phone_3 := ri.company_phone_3;
  SELF.company_phone_3_score := MAP( le.company_phone_3_isnull OR ri.company_phone_3_isnull => 0,
                        le.company_phone_3 = ri.company_phone_3  => le.company_phone_3_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_3_weight100,s.company_phone_3_switch));
  SELF.left_company_phone_3_ex := le.company_phone_3_ex;
  SELF.right_company_phone_3_ex := ri.company_phone_3_ex;
  SELF.company_phone_3_ex_score := MAP( le.company_phone_3_ex_isnull OR ri.company_phone_3_ex_isnull => 0,
                        le.company_phone_3_ex = ri.company_phone_3_ex  => le.company_phone_3_ex_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_3_ex_weight100,s.company_phone_3_ex_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_score := MAP( le.mname_isnull OR ri.mname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT28.WithinEditN(le.mname,ri.mname,2) => SALT28.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e2_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e2_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  INTEGER2 fname_score_temp := MAP( le.fname_isnull OR ri.fname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT28.WithinEditN(le.fname,ri.fname,1) => SALT28.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_fname_preferred := le.fname_preferred;
  SELF.right_fname_preferred := ri.fname_preferred;
  SELF.fname_preferred_score := MAP( le.fname_preferred_isnull OR ri.fname_preferred_isnull => 0,
                        le.fname_preferred = ri.fname_preferred  => le.fname_preferred_weight100,
                        SALT28.Fn_Fail_Scale(le.fname_preferred_weight100,s.fname_preferred_switch));
  SELF.left_name_suffix := le.name_suffix;
  SELF.right_name_suffix := ri.name_suffix;
  SELF.name_suffix_score := MAP( le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT28.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT28.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  SELF.left_cnp_lowv := le.cnp_lowv;
  SELF.right_cnp_lowv := ri.cnp_lowv;
  SELF.cnp_lowv_score := MAP( le.cnp_lowv_isnull OR ri.cnp_lowv_isnull => 0,
                        le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_lowv_weight100,s.cnp_lowv_switch));
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT28.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  SELF.left_source := le.source;
  SELF.right_source := ri.source;
  SELF.source_score := MAP( le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT28.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_score := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_isContact := le.isContact;
  SELF.right_isContact := ri.isContact;
  SELF.isContact_score := MAP( le.isContact_isnull OR ri.isContact_isnull => 0,
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT28.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  SELF.left_title := le.title;
  SELF.right_title := ri.title;
  SELF.title_score := MAP( le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT28.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  SELF.left_rcid := le.rcid;
  SELF.right_rcid := ri.rcid;
  SELF.rcid_score := MAP( le.rcid_isnull OR ri.rcid_isnull => 0,
                        le.rcid = ri.rcid  => le.rcid_weight100,
                        SALT28.Fn_Fail_Scale(le.rcid_weight100,s.rcid_switch));
  SELF.left_rcid2 := le.rcid2;
  SELF.right_rcid2 := ri.rcid2;
  SELF.rcid2_score := MAP( le.rcid2_isnull OR ri.rcid2_isnull => 0,
                        le.rcid2 = ri.rcid2  => le.rcid2_weight100,
                        SALT28.Fn_Fail_Scale(le.rcid2_weight100,s.rcid2_switch));
  SELF.left_empid := le.empid;
  SELF.right_empid := ri.empid;
  SELF.empid_score := MAP( le.empid_isnull OR ri.empid_isnull => 0,
                        le.empid = ri.empid  => le.empid_weight100,
                        SALT28.Fn_Fail_Scale(le.empid_weight100,s.empid_switch));
  SELF.left_powid := le.powid;
  SELF.right_powid := ri.powid;
  SELF.powid_score := MAP( le.powid_isnull OR ri.powid_isnull => 0,
                        le.powid = ri.powid  => le.powid_weight100,
                        SALT28.Fn_Fail_Scale(le.powid_weight100,s.powid_switch));
  SELF.left_sele_flag := le.sele_flag;
  SELF.right_sele_flag := ri.sele_flag;
  SELF.sele_flag_score := MAP( le.sele_flag_isnull OR ri.sele_flag_isnull => 0,
                        le.sele_flag = ri.sele_flag  => le.sele_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.sele_flag_weight100,s.sele_flag_switch));
  SELF.left_org_flag := le.org_flag;
  SELF.right_org_flag := ri.org_flag;
  SELF.org_flag_score := MAP( le.org_flag_isnull OR ri.org_flag_isnull => 0,
                        le.org_flag = ri.org_flag  => le.org_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.org_flag_weight100,s.org_flag_switch));
  SELF.left_ult_flag := le.ult_flag;
  SELF.right_ult_flag := ri.ult_flag;
  SELF.ult_flag_score := MAP( le.ult_flag_isnull OR ri.ult_flag_isnull => 0,
                        le.ult_flag = ri.ult_flag  => le.ult_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.ult_flag_weight100,s.ult_flag_switch));
  SELF.left_dotid := le.dotid;
  SELF.right_dotid := ri.dotid;
  SELF.left_parent_proxid := le.parent_proxid;
  SELF.right_parent_proxid := ri.parent_proxid;
  SELF.left_ultimate_proxid := le.ultimate_proxid;
  SELF.right_ultimate_proxid := ri.ultimate_proxid;
  SELF.left_has_lgid := le.has_lgid;
  SELF.right_has_lgid := ri.has_lgid;
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.left_company_rawaid := le.company_rawaid;
  SELF.right_company_rawaid := ri.company_rawaid;
  SELF.left_company_aceaid := le.company_aceaid;
  SELF.right_company_aceaid := ri.company_aceaid;
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.left_addr_suffix := le.addr_suffix;
  SELF.right_addr_suffix := ri.addr_suffix;
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.left_p_city_name := le.p_city_name;
  SELF.right_p_city_name := ri.p_city_name;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_dt_vendor_last_reported := le.dt_vendor_last_reported;
  SELF.right_dt_vendor_last_reported := ri.dt_vendor_last_reported;
  SELF.left_company_bdid := le.company_bdid;
  SELF.right_company_bdid := ri.company_bdid;
  SELF.left_phone_type := le.phone_type;
  SELF.right_phone_type := ri.phone_type;
  SELF.left_vl_id := le.vl_id;
  SELF.right_vl_id := ri.vl_id;
  SELF.left_contact_did := le.contact_did;
  SELF.right_contact_did := ri.contact_did;
  SELF.left_contact_email_domain := le.contact_email_domain;
  SELF.right_contact_email_domain := ri.contact_email_domain;
  SELF.left_contact_job_title_derived := le.contact_job_title_derived;
  SELF.right_contact_job_title_derived := ri.contact_job_title_derived;
  SELF.prim_range_score := IF ( prim_range_score_temp >= 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.fname_score := fname_score_temp*0.20; 
// Compute the score for the concept CONTACTNAME
  INTEGER2 CONTACTNAME_score_ext := MAX(CONTACTNAME_score_pre,0) + self.fname_score + self.mname_score + self.lname_score;// Score in surrounding context
  INTEGER2 CONTACTNAME_score_res := MAX(0,CONTACTNAME_score_pre); // At least nothing
  SELF.CONTACTNAME_score := CONTACTNAME_score_res;
// Compute the score for the concept STREETADDRESS
  INTEGER2 STREETADDRESS_score_ext := MAX(STREETADDRESS_score_pre,0) + self.prim_range_score + self.prim_name_score + self.sec_range_score;// Score in surrounding context
  INTEGER2 STREETADDRESS_score_res := MAX(0,STREETADDRESS_score_pre); // At least nothing
  SELF.STREETADDRESS_score := STREETADDRESS_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.company_url_score + SELF.contact_email_score + SELF.source_record_id_score + SELF.contact_ssn_score + SELF.company_name_score + SELF.company_name_prefix_score + SELF.company_fein_score + SELF.cnp_name_score + SELF.company_phone_7_score + MAX(SELF.CONTACTNAME_score,SELF.fname_score + SELF.mname_score + SELF.lname_score) + MAX(SELF.STREETADDRESS_score,SELF.prim_range_score + SELF.prim_name_score + SELF.sec_range_score) + SELF.zip_score + SELF.cnp_number_score + SELF.city_score + SELF.city_clean_score + SELF.company_sic_code1_score + SELF.company_phone_3_score + SELF.company_phone_3_ex_score + SELF.fname_preferred_score + SELF.name_suffix_score + SELF.cnp_lowv_score + SELF.st_score + SELF.source_score + SELF.cnp_btype_score + SELF.isContact_score + SELF.title_score + SELF.rcid_score + SELF.rcid2_score + SELF.empid_score + SELF.powid_score + SELF.sele_flag_score + SELF.org_flag_score + SELF.ult_flag_score) / 100 + outside;
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
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT28.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
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
  SALT28.UIDType proxid;
  DATASET(SALT28.Layout_FieldValueList) company_url_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) contact_email_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_name_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_name_prefix_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_fein_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_phone_7_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) CONTACTNAME_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) STREETADDRESS_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) zip_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) city_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) city_clean_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_sic_code1_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_phone_3_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_phone_3_ex_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) fname_preferred_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) st_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) source_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) isContact_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) title_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) rcid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) rcid2_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) empid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) powid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) sele_flag_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) org_flag_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) ult_flag_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) dotid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_phone_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_rawaid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_aceaid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) predir_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) addr_suffix_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) postdir_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) p_city_name_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) zip4_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) dt_vendor_last_reported_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) phone_type_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) vl_id_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) contact_did_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) contact_email_domain_Values := DATASET([],SALT28.Layout_FieldValueList);
  DATASET(SALT28.Layout_FieldValueList) contact_job_title_derived_Values := DATASET([],SALT28.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.company_url_values := SALT28.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
  SELF.contact_email_values := SALT28.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
  SELF.source_record_id_values := SALT28.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
  SELF.contact_ssn_values := SALT28.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
  SELF.company_name_values := SALT28.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.company_name_prefix_values := SALT28.fn_combine_fieldvaluelist(le.company_name_prefix_values,ri.company_name_prefix_values);
  SELF.company_fein_values := SALT28.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.cnp_name_values := SALT28.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.company_phone_7_values := SALT28.fn_combine_fieldvaluelist(le.company_phone_7_values,ri.company_phone_7_values);
  SELF.CONTACTNAME_values := SALT28.fn_combine_fieldvaluelist(le.CONTACTNAME_values,ri.CONTACTNAME_values);
  SELF.STREETADDRESS_values := SALT28.fn_combine_fieldvaluelist(le.STREETADDRESS_values,ri.STREETADDRESS_values);
  SELF.zip_values := SALT28.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  SELF.cnp_number_values := SALT28.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.city_values := SALT28.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
  SELF.city_clean_values := SALT28.fn_combine_fieldvaluelist(le.city_clean_values,ri.city_clean_values);
  SELF.company_sic_code1_values := SALT28.fn_combine_fieldvaluelist(le.company_sic_code1_values,ri.company_sic_code1_values);
  SELF.company_phone_3_values := SALT28.fn_combine_fieldvaluelist(le.company_phone_3_values,ri.company_phone_3_values);
  SELF.company_phone_3_ex_values := SALT28.fn_combine_fieldvaluelist(le.company_phone_3_ex_values,ri.company_phone_3_ex_values);
  SELF.fname_preferred_values := SALT28.fn_combine_fieldvaluelist(le.fname_preferred_values,ri.fname_preferred_values);
  SELF.name_suffix_values := SALT28.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
  SELF.cnp_lowv_values := SALT28.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
  SELF.st_values := SALT28.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  SELF.source_values := SALT28.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
  SELF.cnp_btype_values := SALT28.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.isContact_values := SALT28.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
  SELF.title_values := SALT28.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
  SELF.rcid_values := SALT28.fn_combine_fieldvaluelist(le.rcid_values,ri.rcid_values);
  SELF.rcid2_values := SALT28.fn_combine_fieldvaluelist(le.rcid2_values,ri.rcid2_values);
  SELF.empid_values := SALT28.fn_combine_fieldvaluelist(le.empid_values,ri.empid_values);
  SELF.powid_values := SALT28.fn_combine_fieldvaluelist(le.powid_values,ri.powid_values);
  SELF.sele_flag_values := SALT28.fn_combine_fieldvaluelist(le.sele_flag_values,ri.sele_flag_values);
  SELF.org_flag_values := SALT28.fn_combine_fieldvaluelist(le.org_flag_values,ri.org_flag_values);
  SELF.ult_flag_values := SALT28.fn_combine_fieldvaluelist(le.ult_flag_values,ri.ult_flag_values);
  SELF.dotid_values := SALT28.fn_combine_fieldvaluelist(le.dotid_values,ri.dotid_values);
  SELF.parent_proxid_values := SALT28.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
  SELF.ultimate_proxid_values := SALT28.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
  SELF.has_lgid_values := SALT28.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
  SELF.company_phone_values := SALT28.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.company_rawaid_values := SALT28.fn_combine_fieldvaluelist(le.company_rawaid_values,ri.company_rawaid_values);
  SELF.company_aceaid_values := SALT28.fn_combine_fieldvaluelist(le.company_aceaid_values,ri.company_aceaid_values);
  SELF.predir_values := SALT28.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
  SELF.addr_suffix_values := SALT28.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
  SELF.postdir_values := SALT28.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
  SELF.unit_desig_values := SALT28.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
  SELF.p_city_name_values := SALT28.fn_combine_fieldvaluelist(le.p_city_name_values,ri.p_city_name_values);
  SELF.v_city_name_values := SALT28.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
  SELF.zip4_values := SALT28.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  SELF.dt_first_seen_values := SALT28.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT28.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  SELF.dt_vendor_last_reported_values := SALT28.fn_combine_fieldvaluelist(le.dt_vendor_last_reported_values,ri.dt_vendor_last_reported_values);
  SELF.company_bdid_values := SALT28.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
  SELF.phone_type_values := SALT28.fn_combine_fieldvaluelist(le.phone_type_values,ri.phone_type_values);
  SELF.vl_id_values := SALT28.fn_combine_fieldvaluelist(le.vl_id_values,ri.vl_id_values);
  SELF.contact_did_values := SALT28.fn_combine_fieldvaluelist(le.contact_did_values,ri.contact_did_values);
  SELF.contact_email_domain_values := SALT28.fn_combine_fieldvaluelist(le.contact_email_domain_values,ri.contact_email_domain_values);
  SELF.contact_job_title_derived_values := SALT28.fn_combine_fieldvaluelist(le.contact_job_title_derived_values,ri.contact_job_title_derived_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(proxid) ), proxid, LOCAL ), LEFT.proxid = RIGHT.proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_url)}],SALT28.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( le.contact_email  IN SET(s.nulls_contact_email,contact_email),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.contact_email)}],SALT28.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.source_record_id)}],SALT28.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.contact_ssn)}],SALT28.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_name)}],SALT28.Layout_FieldValueList));
  SELF.company_name_prefix_Values := IF ( le.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_name_prefix)}],SALT28.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_fein)}],SALT28.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_name)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_7_Values := IF ( le.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_7)}],SALT28.Layout_FieldValueList));
  self.CONTACTNAME_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) AND le.mname  IN SET(s.nulls_mname,mname) AND le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT28.Layout_FieldValueList),dataset([{TRIM((SALT28.StrType)le.fname) + ' ' + TRIM((SALT28.StrType)le.mname) + ' ' + TRIM((SALT28.StrType)le.lname)}],SALT28.Layout_FieldValueList));
  self.STREETADDRESS_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT28.Layout_FieldValueList),dataset([{TRIM((SALT28.StrType)le.prim_range) + ' ' + TRIM((SALT28.StrType)le.prim_name) + ' ' + TRIM((SALT28.StrType)le.sec_range)}],SALT28.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.zip)}],SALT28.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_number)}],SALT28.Layout_FieldValueList));
  SELF.city_Values := IF ( le.city  IN SET(s.nulls_city,city),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.city)}],SALT28.Layout_FieldValueList));
  SELF.city_clean_Values := IF ( le.city_clean  IN SET(s.nulls_city_clean,city_clean),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.city_clean)}],SALT28.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_sic_code1)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_3_Values := IF ( le.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_3)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_3_ex_Values := IF ( le.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_3_ex)}],SALT28.Layout_FieldValueList));
  SELF.fname_preferred_Values := IF ( le.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.fname_preferred)}],SALT28.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.name_suffix)}],SALT28.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( le.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_lowv)}],SALT28.Layout_FieldValueList));
  SELF.st_Values := IF ( le.st  IN SET(s.nulls_st,st),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.st)}],SALT28.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.source)}],SALT28.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_btype)}],SALT28.Layout_FieldValueList));
  SELF.isContact_Values := IF ( le.isContact  IN SET(s.nulls_isContact,isContact),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.isContact)}],SALT28.Layout_FieldValueList));
  SELF.title_Values := IF ( le.title  IN SET(s.nulls_title,title),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.title)}],SALT28.Layout_FieldValueList));
  SELF.rcid_Values := IF ( le.rcid  IN SET(s.nulls_rcid,rcid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.rcid)}],SALT28.Layout_FieldValueList));
  SELF.rcid2_Values := IF ( le.rcid2  IN SET(s.nulls_rcid2,rcid2),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.rcid2)}],SALT28.Layout_FieldValueList));
  SELF.empid_Values := IF ( le.empid  IN SET(s.nulls_empid,empid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.empid)}],SALT28.Layout_FieldValueList));
  SELF.powid_Values := IF ( le.powid  IN SET(s.nulls_powid,powid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.powid)}],SALT28.Layout_FieldValueList));
  SELF.sele_flag_Values := IF ( le.sele_flag  IN SET(s.nulls_sele_flag,sele_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.sele_flag)}],SALT28.Layout_FieldValueList));
  SELF.org_flag_Values := IF ( le.org_flag  IN SET(s.nulls_org_flag,org_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.org_flag)}],SALT28.Layout_FieldValueList));
  SELF.ult_flag_Values := IF ( le.ult_flag  IN SET(s.nulls_ult_flag,ult_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.ult_flag)}],SALT28.Layout_FieldValueList));
  SELF.dotid_Values := DATASET([{TRIM((SALT28.StrType)le.dotid)}],SALT28.Layout_FieldValueList);
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT28.StrType)le.parent_proxid)}],SALT28.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT28.StrType)le.ultimate_proxid)}],SALT28.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT28.StrType)le.has_lgid)}],SALT28.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT28.StrType)le.company_phone)}],SALT28.Layout_FieldValueList);
  SELF.company_rawaid_Values := DATASET([{TRIM((SALT28.StrType)le.company_rawaid)}],SALT28.Layout_FieldValueList);
  SELF.company_aceaid_Values := DATASET([{TRIM((SALT28.StrType)le.company_aceaid)}],SALT28.Layout_FieldValueList);
  SELF.predir_Values := DATASET([{TRIM((SALT28.StrType)le.predir)}],SALT28.Layout_FieldValueList);
  SELF.addr_suffix_Values := DATASET([{TRIM((SALT28.StrType)le.addr_suffix)}],SALT28.Layout_FieldValueList);
  SELF.postdir_Values := DATASET([{TRIM((SALT28.StrType)le.postdir)}],SALT28.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT28.StrType)le.unit_desig)}],SALT28.Layout_FieldValueList);
  SELF.p_city_name_Values := DATASET([{TRIM((SALT28.StrType)le.p_city_name)}],SALT28.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT28.StrType)le.v_city_name)}],SALT28.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT28.StrType)le.zip4)}],SALT28.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT28.StrType)le.dt_first_seen)}],SALT28.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT28.StrType)le.dt_last_seen)}],SALT28.Layout_FieldValueList);
  SELF.dt_vendor_last_reported_Values := DATASET([{TRIM((SALT28.StrType)le.dt_vendor_last_reported)}],SALT28.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT28.StrType)le.company_bdid)}],SALT28.Layout_FieldValueList);
  SELF.phone_type_Values := DATASET([{TRIM((SALT28.StrType)le.phone_type)}],SALT28.Layout_FieldValueList);
  SELF.vl_id_Values := DATASET([{TRIM((SALT28.StrType)le.vl_id)}],SALT28.Layout_FieldValueList);
  SELF.contact_did_Values := DATASET([{TRIM((SALT28.StrType)le.contact_did)}],SALT28.Layout_FieldValueList);
  SELF.contact_email_domain_Values := DATASET([{TRIM((SALT28.StrType)le.contact_email_domain)}],SALT28.Layout_FieldValueList);
  SELF.contact_job_title_derived_Values := DATASET([{TRIM((SALT28.StrType)le.contact_job_title_derived)}],SALT28.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_url)}],SALT28.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( le.contact_email  IN SET(s.nulls_contact_email,contact_email),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.contact_email)}],SALT28.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.source_record_id)}],SALT28.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.contact_ssn)}],SALT28.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_name)}],SALT28.Layout_FieldValueList));
  SELF.company_name_prefix_Values := IF ( le.company_name_prefix  IN SET(s.nulls_company_name_prefix,company_name_prefix),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_name_prefix)}],SALT28.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_fein)}],SALT28.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_name)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_7_Values := IF ( le.company_phone_7  IN SET(s.nulls_company_phone_7,company_phone_7),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_7)}],SALT28.Layout_FieldValueList));
  self.CONTACTNAME_Values := IF ( le.fname  IN SET(s.nulls_fname,fname) AND le.mname  IN SET(s.nulls_mname,mname) AND le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT28.Layout_FieldValueList),dataset([{TRIM((SALT28.StrType)le.fname) + ' ' + TRIM((SALT28.StrType)le.mname) + ' ' + TRIM((SALT28.StrType)le.lname)}],SALT28.Layout_FieldValueList));
  self.STREETADDRESS_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT28.Layout_FieldValueList),dataset([{TRIM((SALT28.StrType)le.prim_range) + ' ' + TRIM((SALT28.StrType)le.prim_name) + ' ' + TRIM((SALT28.StrType)le.sec_range)}],SALT28.Layout_FieldValueList));
  SELF.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.zip)}],SALT28.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_number)}],SALT28.Layout_FieldValueList));
  SELF.city_Values := IF ( le.city  IN SET(s.nulls_city,city),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.city)}],SALT28.Layout_FieldValueList));
  SELF.city_clean_Values := IF ( le.city_clean  IN SET(s.nulls_city_clean,city_clean),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.city_clean)}],SALT28.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_sic_code1)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_3_Values := IF ( le.company_phone_3  IN SET(s.nulls_company_phone_3,company_phone_3),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_3)}],SALT28.Layout_FieldValueList));
  SELF.company_phone_3_ex_Values := IF ( le.company_phone_3_ex  IN SET(s.nulls_company_phone_3_ex,company_phone_3_ex),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.company_phone_3_ex)}],SALT28.Layout_FieldValueList));
  SELF.fname_preferred_Values := IF ( le.fname_preferred  IN SET(s.nulls_fname_preferred,fname_preferred),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.fname_preferred)}],SALT28.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.name_suffix)}],SALT28.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( le.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_lowv)}],SALT28.Layout_FieldValueList));
  SELF.st_Values := IF ( le.st  IN SET(s.nulls_st,st),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.st)}],SALT28.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.source)}],SALT28.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.cnp_btype)}],SALT28.Layout_FieldValueList));
  SELF.isContact_Values := IF ( le.isContact  IN SET(s.nulls_isContact,isContact),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.isContact)}],SALT28.Layout_FieldValueList));
  SELF.title_Values := IF ( le.title  IN SET(s.nulls_title,title),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.title)}],SALT28.Layout_FieldValueList));
  SELF.rcid_Values := IF ( le.rcid  IN SET(s.nulls_rcid,rcid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.rcid)}],SALT28.Layout_FieldValueList));
  SELF.rcid2_Values := IF ( le.rcid2  IN SET(s.nulls_rcid2,rcid2),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.rcid2)}],SALT28.Layout_FieldValueList));
  SELF.empid_Values := IF ( le.empid  IN SET(s.nulls_empid,empid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.empid)}],SALT28.Layout_FieldValueList));
  SELF.powid_Values := IF ( le.powid  IN SET(s.nulls_powid,powid),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.powid)}],SALT28.Layout_FieldValueList));
  SELF.sele_flag_Values := IF ( le.sele_flag  IN SET(s.nulls_sele_flag,sele_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.sele_flag)}],SALT28.Layout_FieldValueList));
  SELF.org_flag_Values := IF ( le.org_flag  IN SET(s.nulls_org_flag,org_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.org_flag)}],SALT28.Layout_FieldValueList));
  SELF.ult_flag_Values := IF ( le.ult_flag  IN SET(s.nulls_ult_flag,ult_flag),DATASET([],SALT28.Layout_FieldValueList),DATASET([{TRIM((SALT28.StrType)le.ult_flag)}],SALT28.Layout_FieldValueList));
  SELF.dotid_Values := DATASET([{TRIM((SALT28.StrType)le.dotid)}],SALT28.Layout_FieldValueList);
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT28.StrType)le.parent_proxid)}],SALT28.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT28.StrType)le.ultimate_proxid)}],SALT28.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT28.StrType)le.has_lgid)}],SALT28.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT28.StrType)le.company_phone)}],SALT28.Layout_FieldValueList);
  SELF.company_rawaid_Values := DATASET([{TRIM((SALT28.StrType)le.company_rawaid)}],SALT28.Layout_FieldValueList);
  SELF.company_aceaid_Values := DATASET([{TRIM((SALT28.StrType)le.company_aceaid)}],SALT28.Layout_FieldValueList);
  SELF.predir_Values := DATASET([{TRIM((SALT28.StrType)le.predir)}],SALT28.Layout_FieldValueList);
  SELF.addr_suffix_Values := DATASET([{TRIM((SALT28.StrType)le.addr_suffix)}],SALT28.Layout_FieldValueList);
  SELF.postdir_Values := DATASET([{TRIM((SALT28.StrType)le.postdir)}],SALT28.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT28.StrType)le.unit_desig)}],SALT28.Layout_FieldValueList);
  SELF.p_city_name_Values := DATASET([{TRIM((SALT28.StrType)le.p_city_name)}],SALT28.Layout_FieldValueList);
  SELF.v_city_name_Values := DATASET([{TRIM((SALT28.StrType)le.v_city_name)}],SALT28.Layout_FieldValueList);
  SELF.zip4_Values := DATASET([{TRIM((SALT28.StrType)le.zip4)}],SALT28.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT28.StrType)le.dt_first_seen)}],SALT28.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT28.StrType)le.dt_last_seen)}],SALT28.Layout_FieldValueList);
  SELF.dt_vendor_last_reported_Values := DATASET([{TRIM((SALT28.StrType)le.dt_vendor_last_reported)}],SALT28.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT28.StrType)le.company_bdid)}],SALT28.Layout_FieldValueList);
  SELF.phone_type_Values := DATASET([{TRIM((SALT28.StrType)le.phone_type)}],SALT28.Layout_FieldValueList);
  SELF.vl_id_Values := DATASET([{TRIM((SALT28.StrType)le.vl_id)}],SALT28.Layout_FieldValueList);
  SELF.contact_did_Values := DATASET([{TRIM((SALT28.StrType)le.contact_did)}],SALT28.Layout_FieldValueList);
  SELF.contact_email_domain_Values := DATASET([{TRIM((SALT28.StrType)le.contact_email_domain)}],SALT28.Layout_FieldValueList);
  SELF.contact_job_title_derived_Values := DATASET([{TRIM((SALT28.StrType)le.contact_job_title_derived)}],SALT28.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 company_url_size := 0;
  UNSIGNED1 contact_email_size := 0;
  UNSIGNED1 source_record_id_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 company_name_prefix_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 company_phone_7_size := 0;
  UNSIGNED1 CONTACTNAME_size := 0;
  UNSIGNED1 STREETADDRESS_size := 0;
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
  UNSIGNED1 rcid_size := 0;
  UNSIGNED1 rcid2_size := 0;
  UNSIGNED1 empid_size := 0;
  UNSIGNED1 powid_size := 0;
  UNSIGNED1 sele_flag_size := 0;
  UNSIGNED1 org_flag_size := 0;
  UNSIGNED1 ult_flag_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.company_url_size := SALT28.Fn_SwitchSpec(s.company_url_switch,count(le.company_url_values));
  SELF.contact_email_size := SALT28.Fn_SwitchSpec(s.contact_email_switch,count(le.contact_email_values));
  SELF.source_record_id_size := SALT28.Fn_SwitchSpec(s.source_record_id_switch,count(le.source_record_id_values));
  SELF.contact_ssn_size := SALT28.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.company_name_size := SALT28.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.company_name_prefix_size := SALT28.Fn_SwitchSpec(s.company_name_prefix_switch,count(le.company_name_prefix_values));
  SELF.company_fein_size := SALT28.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.cnp_name_size := SALT28.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.company_phone_7_size := SALT28.Fn_SwitchSpec(s.company_phone_7_switch,count(le.company_phone_7_values));
  SELF.CONTACTNAME_size := SALT28.Fn_SwitchSpec(s.CONTACTNAME_switch,count(le.CONTACTNAME_values));
  SELF.STREETADDRESS_size := SALT28.Fn_SwitchSpec(s.STREETADDRESS_switch,count(le.STREETADDRESS_values));
  SELF.zip_size := SALT28.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.cnp_number_size := SALT28.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.city_size := SALT28.Fn_SwitchSpec(s.city_switch,count(le.city_values));
  SELF.city_clean_size := SALT28.Fn_SwitchSpec(s.city_clean_switch,count(le.city_clean_values));
  SELF.company_sic_code1_size := SALT28.Fn_SwitchSpec(s.company_sic_code1_switch,count(le.company_sic_code1_values));
  SELF.company_phone_3_size := SALT28.Fn_SwitchSpec(s.company_phone_3_switch,count(le.company_phone_3_values));
  SELF.company_phone_3_ex_size := SALT28.Fn_SwitchSpec(s.company_phone_3_ex_switch,count(le.company_phone_3_ex_values));
  SELF.fname_preferred_size := SALT28.Fn_SwitchSpec(s.fname_preferred_switch,count(le.fname_preferred_values));
  SELF.name_suffix_size := SALT28.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF.cnp_lowv_size := SALT28.Fn_SwitchSpec(s.cnp_lowv_switch,count(le.cnp_lowv_values));
  SELF.st_size := SALT28.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.source_size := SALT28.Fn_SwitchSpec(s.source_switch,count(le.source_values));
  SELF.cnp_btype_size := SALT28.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF.isContact_size := SALT28.Fn_SwitchSpec(s.isContact_switch,count(le.isContact_values));
  SELF.title_size := SALT28.Fn_SwitchSpec(s.title_switch,count(le.title_values));
  SELF.rcid_size := SALT28.Fn_SwitchSpec(s.rcid_switch,count(le.rcid_values));
  SELF.rcid2_size := SALT28.Fn_SwitchSpec(s.rcid2_switch,count(le.rcid2_values));
  SELF.empid_size := SALT28.Fn_SwitchSpec(s.empid_switch,count(le.empid_values));
  SELF.powid_size := SALT28.Fn_SwitchSpec(s.powid_switch,count(le.powid_values));
  SELF.sele_flag_size := SALT28.Fn_SwitchSpec(s.sele_flag_switch,count(le.sele_flag_values));
  SELF.org_flag_size := SALT28.Fn_SwitchSpec(s.org_flag_switch,count(le.org_flag_values));
  SELF.ult_flag_size := SALT28.Fn_SwitchSpec(s.ult_flag_switch,count(le.ult_flag_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.company_url_size+t.contact_email_size+t.source_record_id_size+t.contact_ssn_size+t.company_name_size+t.company_name_prefix_size+t.company_fein_size+t.cnp_name_size+t.company_phone_7_size+t.CONTACTNAME_size+t.STREETADDRESS_size+t.zip_size+t.cnp_number_size+t.city_size+t.city_clean_size+t.company_sic_code1_size+t.company_phone_3_size+t.company_phone_3_ex_size+t.fname_preferred_size+t.name_suffix_size+t.cnp_lowv_size+t.st_size+t.source_size+t.cnp_btype_size+t.isContact_size+t.title_size+t.rcid_size+t.rcid2_size+t.empid_size+t.powid_size+t.sele_flag_size+t.org_flag_size+t.ult_flag_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;

