// Various routines to assist in debugging
IMPORT SALT25,ut;
EXPORT Debug(DATASET(layout_DOT_Base) ih, Layout_Specificities.R s, MatchThreshold = 32) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT25.UIDType Proxid1;
  SALT25.UIDType Proxid2;
  SALT25.UIDType rcid1;
  SALT25.UIDType rcid2;
  typeof(h.cnp_hasnumber) left_cnp_hasnumber;
  INTEGER2 cnp_hasnumber_score;
  BOOLEAN cnp_hasnumber_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_hasnumber) right_cnp_hasnumber;
  typeof(h.active_enterprise_number) left_active_enterprise_number;
  INTEGER2 active_enterprise_number_score;
  BOOLEAN active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_enterprise_number) right_active_enterprise_number;
  typeof(h.source_record_id) left_source_record_id;
  INTEGER2 source_record_id_score;
  typeof(h.source_record_id) right_source_record_id;
  typeof(h.contact_ssn) left_contact_ssn;
  INTEGER2 contact_ssn_score;
  typeof(h.contact_ssn) right_contact_ssn;
  typeof(h.company_fein) left_company_fein;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.company_charter_number) left_company_charter_number;
  INTEGER2 company_charter_number_score;
  typeof(h.company_charter_number) right_company_charter_number;
  typeof(h.active_duns_number) left_active_duns_number;
  INTEGER2 active_duns_number_score;
  BOOLEAN active_duns_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_duns_number) right_active_duns_number;
  typeof(h.active_domestic_corp_key) left_active_domestic_corp_key;
  INTEGER2 active_domestic_corp_key_score;
  BOOLEAN active_domestic_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_domestic_corp_key) right_active_domestic_corp_key;
  typeof(h.contact_phone) left_contact_phone;
  INTEGER2 contact_phone_score;
  typeof(h.contact_phone) right_contact_phone;
  typeof(h.cnp_name) left_cnp_name;
  INTEGER2 cnp_name_score;
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.corp_legal_name) left_corp_legal_name;
  INTEGER2 corp_legal_name_score;
  BOOLEAN corp_legal_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.corp_legal_name) right_corp_legal_name;
  typeof(h.company_address) left_company_address;
  INTEGER2 company_address_score;
  typeof(h.company_address) right_company_address;
  typeof(h.company_addr1) left_company_addr1;
  INTEGER2 company_addr1_score;
  typeof(h.company_addr1) right_company_addr1;
  typeof(h.company_csz) left_company_csz;
  INTEGER2 company_csz_score;
  typeof(h.company_csz) right_company_csz;
  typeof(h.prim_name) left_prim_name;
  INTEGER2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.lname) left_lname;
  INTEGER2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.zip) left_zip;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.prim_range) left_prim_range;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.zip4) left_zip4;
  INTEGER2 zip4_score;
  typeof(h.zip4) right_zip4;
  typeof(h.sec_range) left_sec_range;
  INTEGER2 sec_range_score;
  BOOLEAN sec_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.sec_range) right_sec_range;
  typeof(h.cnp_number) left_cnp_number;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_number) right_cnp_number;
  typeof(h.p_city_name) left_p_city_name;
  INTEGER2 p_city_name_score;
  typeof(h.p_city_name) right_p_city_name;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER2 v_city_name_score;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.fname) left_fname;
  INTEGER2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.company_inc_state) left_company_inc_state;
  INTEGER2 company_inc_state_score;
  typeof(h.company_inc_state) right_company_inc_state;
  typeof(h.mname) left_mname;
  INTEGER2 mname_score;
  typeof(h.mname) right_mname;
  typeof(h.postdir) left_postdir;
  INTEGER2 postdir_score;
  typeof(h.postdir) right_postdir;
  typeof(h.st) left_st;
  INTEGER2 st_score;
  typeof(h.st) right_st;
  typeof(h.predir) left_predir;
  INTEGER2 predir_score;
  typeof(h.predir) right_predir;
  typeof(h.addr_suffix) left_addr_suffix;
  INTEGER2 addr_suffix_score;
  typeof(h.addr_suffix) right_addr_suffix;
  typeof(h.cnp_btype) left_cnp_btype;
  INTEGER2 cnp_btype_score;
  BOOLEAN cnp_btype_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_btype) right_cnp_btype;
  typeof(h.source) left_source;
  INTEGER2 source_score;
  typeof(h.source) right_source;
  typeof(h.iscorp) left_iscorp;
  INTEGER2 iscorp_score;
  typeof(h.iscorp) right_iscorp;
  typeof(h.company_name) left_company_name;
  typeof(h.company_name) right_company_name;
  typeof(h.cnp_lowv) left_cnp_lowv;
  typeof(h.cnp_lowv) right_cnp_lowv;
  typeof(h.cnp_translated) left_cnp_translated;
  typeof(h.cnp_translated) right_cnp_translated;
  typeof(h.cnp_classid) left_cnp_classid;
  typeof(h.cnp_classid) right_cnp_classid;
  typeof(h.company_bdid) left_company_bdid;
  typeof(h.company_bdid) right_company_bdid;
  typeof(h.company_phone) left_company_phone;
  typeof(h.company_phone) right_company_phone;
  typeof(h.unit_desig) left_unit_desig;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.Company_RAWAID) left_Company_RAWAID;
  typeof(h.Company_RAWAID) right_Company_RAWAID;
  typeof(h.isContact) left_isContact;
  typeof(h.isContact) right_isContact;
  typeof(h.title) left_title;
  typeof(h.title) right_title;
  typeof(h.name_suffix) left_name_suffix;
  typeof(h.name_suffix) right_name_suffix;
  typeof(h.contact_email) left_contact_email;
  typeof(h.contact_email) right_contact_email;
  typeof(h.contact_job_title_raw) left_contact_job_title_raw;
  typeof(h.contact_job_title_raw) right_contact_job_title_raw;
  typeof(h.company_department) left_company_department;
  typeof(h.company_department) right_company_department;
  typeof(h.contact_email_username) left_contact_email_username;
  INTEGER2 contact_email_username_score;
  typeof(h.contact_email_username) right_contact_email_username;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT25.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_cnp_hasnumber := le.cnp_hasnumber;
  SELF.right_cnp_hasnumber := ri.cnp_hasnumber;
  INTEGER2 cnp_hasnumber_score_temp := MAP( le.cnp_hasnumber_isnull OR ri.cnp_hasnumber_isnull OR le.cnp_hasnumber_weight100 = 0 => 0,
                        le.cnp_hasnumber = ri.cnp_hasnumber  => le.cnp_hasnumber_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_hasnumber_weight100,s.cnp_hasnumber_switch));
  SELF.left_active_enterprise_number := le.active_enterprise_number;
  SELF.right_active_enterprise_number := ri.active_enterprise_number;
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT25.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  SELF.left_source_record_id := le.source_record_id;
  SELF.right_source_record_id := ri.source_record_id;
  SELF.source_record_id_score := MAP( le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT25.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  SELF.left_contact_ssn := le.contact_ssn;
  SELF.right_contact_ssn := ri.contact_ssn;
  SELF.contact_ssn_score := MAP( le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT25.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_company_charter_number := le.company_charter_number;
  SELF.right_company_charter_number := ri.company_charter_number;
  SELF.company_charter_number_score := MAP( le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT25.WithinEditN(le.company_charter_number,ri.company_charter_number,1) => SALT25.fn_fuzzy_specificity(le.company_charter_number_weight100,le.company_charter_number_cnt, le.company_charter_number_e1_cnt,ri.company_charter_number_weight100,ri.company_charter_number_cnt,ri.company_charter_number_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT25.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
  SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT25.WithinEditN(le.active_domestic_corp_key,ri.active_domestic_corp_key,1) => SALT25.fn_fuzzy_specificity(le.active_domestic_corp_key_weight100,le.active_domestic_corp_key_cnt, le.active_domestic_corp_key_e1_cnt,ri.active_domestic_corp_key_weight100,ri.active_domestic_corp_key_cnt,ri.active_domestic_corp_key_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  SELF.left_contact_phone := le.contact_phone;
  SELF.right_contact_phone := ri.contact_phone;
  SELF.contact_phone_score := MAP( le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  SELF.cnp_name_score := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT25.WithinEditN(le.cnp_name,ri.cnp_name,1) => SALT25.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  SELF.left_corp_legal_name := le.corp_legal_name;
  SELF.right_corp_legal_name := ri.corp_legal_name;
  INTEGER2 corp_legal_name_score_temp := MAP( le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT25.WithinEditN(le.corp_legal_name,ri.corp_legal_name,1) => SALT25.fn_fuzzy_specificity(le.corp_legal_name_weight100,le.corp_legal_name_cnt, le.corp_legal_name_e1_cnt,ri.corp_legal_name_weight100,ri.corp_legal_name_cnt,ri.corp_legal_name_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.corp_legal_name_weight100,s.corp_legal_name_switch));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  SELF.left_company_address := le.company_address;
  SELF.right_company_address := ri.company_address;
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_addr1 := le.company_addr1;
  SELF.right_company_addr1 := ri.company_addr1;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_csz := le.company_csz;
  SELF.right_company_csz := ri.company_csz;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT25.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_score := MAP( le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT25.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT25.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  INTEGER2 prim_range_score_temp := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT25.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.zip4_score := MAP( le.zip4_isnull OR ri.zip4_isnull => 0,
                        le.zip <> ri.zip => 0, // Only valid if the context variable is equal
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT25.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  INTEGER2 sec_range_score_temp := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT25.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  INTEGER2 cnp_number_score_temp := MAP( le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_p_city_name := le.p_city_name;
  SELF.right_p_city_name := ri.p_city_name;
  SELF.p_city_name_score := MAP( le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
                        SALT25.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT25.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_score := MAP( le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT25.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  SELF.left_company_inc_state := le.company_inc_state;
  SELF.right_company_inc_state := ri.company_inc_state;
  SELF.company_inc_state_score := MAP( le.company_inc_state_isnull OR ri.company_inc_state_isnull => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT25.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_score := MAP( le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT25.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.postdir_score := MAP( le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT25.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT25.Fn_Fail_Scale(le.st_weight100,s.st_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.predir_score := MAP( le.predir_isnull OR ri.predir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT25.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  SELF.left_addr_suffix := le.addr_suffix;
  SELF.right_addr_suffix := ri.addr_suffix;
  SELF.addr_suffix_score := MAP( le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT25.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  INTEGER2 cnp_btype_score_temp := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_source := le.source;
  SELF.right_source := ri.source;
  SELF.source_score := MAP( le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT25.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  SELF.left_iscorp := le.iscorp;
  SELF.right_iscorp := ri.iscorp;
  SELF.iscorp_score := MAP( le.iscorp_isnull OR ri.iscorp_isnull => 0,
                        le.iscorp = ri.iscorp  => le.iscorp_weight100,
                        SALT25.Fn_Fail_Scale(le.iscorp_weight100,s.iscorp_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
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
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.left_Company_RAWAID := le.Company_RAWAID;
  SELF.right_Company_RAWAID := ri.Company_RAWAID;
  SELF.left_isContact := le.isContact;
  SELF.right_isContact := ri.isContact;
  SELF.left_title := le.title;
  SELF.right_title := ri.title;
  SELF.left_name_suffix := le.name_suffix;
  SELF.right_name_suffix := ri.name_suffix;
  SELF.left_contact_email := le.contact_email;
  SELF.right_contact_email := ri.contact_email;
  SELF.left_contact_job_title_raw := le.contact_job_title_raw;
  SELF.right_contact_job_title_raw := ri.contact_job_title_raw;
  SELF.left_company_department := le.company_department;
  SELF.right_company_department := ri.company_department;
  SELF.left_contact_email_username := le.contact_email_username;
  SELF.right_contact_email_username := ri.contact_email_username;
  SELF.contact_email_username_score := MAP( le.contact_email_username_isnull OR ri.contact_email_username_isnull => 0,
                        le.contact_email_username = ri.contact_email_username  => le.contact_email_username_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_email_username_weight100,s.contact_email_username_switch));
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.cnp_hasnumber_score := IF ( cnp_hasnumber_score_temp > 0, cnp_hasnumber_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_hasnumber_skipped := SELF.cnp_hasnumber_score < -5000;// Enforce FORCE parameter
  SELF.active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_enterprise_number_skipped := SELF.active_enterprise_number_score < -5000;// Enforce FORCE parameter
  SELF.active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_duns_number_skipped := SELF.active_duns_number_score < -5000;// Enforce FORCE parameter
  SELF.active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_domestic_corp_key_skipped := SELF.active_domestic_corp_key_score < -5000;// Enforce FORCE parameter
  SELF.corp_legal_name_score := IF ( corp_legal_name_score_temp >= 0, corp_legal_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.corp_legal_name_skipped := SELF.corp_legal_name_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_score := IF ( prim_range_score_temp >= 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_score := IF ( sec_range_score_temp >= 0, sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_skipped := SELF.sec_range_score < -5000;// Enforce FORCE parameter
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
  SELF.cnp_btype_score := IF ( cnp_btype_score_temp >= 0, cnp_btype_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_btype_skipped := SELF.cnp_btype_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + self.prim_range_score + self.prim_name_score + self.sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  SELF.company_addr1_score := company_addr1_score_res;
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  SELF.company_csz_score := company_csz_score_res;
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ SELF.company_addr1_score + self.prim_range_score + self.prim_name_score + self.sec_range_score+ SELF.company_csz_score + self.v_city_name_score + self.st_score + self.zip_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  SELF.company_address_score := company_address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*SELF.active_enterprise_number_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*SELF.company_charter_number_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*SELF.active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.corp_legal_name_prop,ri.corp_legal_name_prop)*SELF.corp_legal_name_score // Score if either field propogated
    +if(le.company_address_prop+ri.company_address_prop>0,self.company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,self.company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*SELF.sec_range_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*SELF.company_inc_state_score // Score if either field propogated
    +MAX(le.iscorp_prop,ri.iscorp_prop)*SELF.iscorp_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.cnp_hasnumber_score + SELF.active_enterprise_number_score + SELF.source_record_id_score + SELF.contact_ssn_score + SELF.company_fein_score + SELF.company_charter_number_score + SELF.active_duns_number_score + SELF.active_domestic_corp_key_score + SELF.contact_phone_score + SELF.cnp_name_score + SELF.corp_legal_name_score + SELF.company_address_score + SELF.company_addr1_score + SELF.company_csz_score + SELF.prim_name_score + SELF.lname_score + SELF.zip_score + SELF.prim_range_score + SELF.zip4_score + SELF.sec_range_score + SELF.cnp_number_score + SELF.p_city_name_score + SELF.v_city_name_score + SELF.fname_score + SELF.company_inc_state_score + SELF.mname_score + SELF.postdir_score + SELF.st_score + SELF.predir_score + SELF.addr_suffix_score + SELF.cnp_btype_score + SELF.source_score + SELF.iscorp_score + SELF.contact_email_username_score) / 100 + outside;
END;
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join
  RETURN d;
END;
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT25.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
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
  SALT25.UIDType Proxid;
  DATASET(SALT25.Layout_FieldValueList) cnp_hasnumber_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_fein_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_charter_number_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) active_domestic_corp_key_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) contact_phone_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) corp_legal_name_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_address_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) lname_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) zip4_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) p_city_name_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) fname_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_inc_state_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) mname_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) postdir_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) predir_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) addr_suffix_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) source_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) iscorp_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_name_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_phone_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) Company_RAWAID_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) isContact_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) title_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) contact_email_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) contact_job_title_raw_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) company_department_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) contact_email_username_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT25.Layout_FieldValueList);
  DATASET(SALT25.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT25.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_hasnumber_values := SALT25.fn_combine_fieldvaluelist(le.cnp_hasnumber_values,ri.cnp_hasnumber_values);
  SELF.active_enterprise_number_values := SALT25.fn_combine_fieldvaluelist(le.active_enterprise_number_values,ri.active_enterprise_number_values);
  SELF.source_record_id_values := SALT25.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
  SELF.contact_ssn_values := SALT25.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
  SELF.company_fein_values := SALT25.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_charter_number_values := SALT25.fn_combine_fieldvaluelist(le.company_charter_number_values,ri.company_charter_number_values);
  SELF.active_duns_number_values := SALT25.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  SELF.active_domestic_corp_key_values := SALT25.fn_combine_fieldvaluelist(le.active_domestic_corp_key_values,ri.active_domestic_corp_key_values);
  SELF.contact_phone_values := SALT25.fn_combine_fieldvaluelist(le.contact_phone_values,ri.contact_phone_values);
  SELF.cnp_name_values := SALT25.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.corp_legal_name_values := SALT25.fn_combine_fieldvaluelist(le.corp_legal_name_values,ri.corp_legal_name_values);
  SELF.company_address_values := SALT25.fn_combine_fieldvaluelist(le.company_address_values,ri.company_address_values);
  SELF.lname_values := SALT25.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  SELF.zip4_values := SALT25.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  SELF.cnp_number_values := SALT25.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.p_city_name_values := SALT25.fn_combine_fieldvaluelist(le.p_city_name_values,ri.p_city_name_values);
  SELF.fname_values := SALT25.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  SELF.company_inc_state_values := SALT25.fn_combine_fieldvaluelist(le.company_inc_state_values,ri.company_inc_state_values);
  SELF.mname_values := SALT25.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
  SELF.postdir_values := SALT25.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
  SELF.predir_values := SALT25.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
  SELF.addr_suffix_values := SALT25.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
  SELF.cnp_btype_values := SALT25.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.source_values := SALT25.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
  SELF.iscorp_values := SALT25.fn_combine_fieldvaluelist(le.iscorp_values,ri.iscorp_values);
  SELF.company_name_values := SALT25.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.cnp_lowv_values := SALT25.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
  SELF.cnp_translated_values := SALT25.fn_combine_fieldvaluelist(le.cnp_translated_values,ri.cnp_translated_values);
  SELF.cnp_classid_values := SALT25.fn_combine_fieldvaluelist(le.cnp_classid_values,ri.cnp_classid_values);
  SELF.company_bdid_values := SALT25.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
  SELF.company_phone_values := SALT25.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.unit_desig_values := SALT25.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
  SELF.Company_RAWAID_values := SALT25.fn_combine_fieldvaluelist(le.Company_RAWAID_values,ri.Company_RAWAID_values);
  SELF.isContact_values := SALT25.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
  SELF.title_values := SALT25.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
  SELF.name_suffix_values := SALT25.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
  SELF.contact_email_values := SALT25.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
  SELF.contact_job_title_raw_values := SALT25.fn_combine_fieldvaluelist(le.contact_job_title_raw_values,ri.contact_job_title_raw_values);
  SELF.company_department_values := SALT25.fn_combine_fieldvaluelist(le.company_department_values,ri.company_department_values);
  SELF.contact_email_username_values := SALT25.fn_combine_fieldvaluelist(le.contact_email_username_values,ri.contact_email_username_values);
  SELF.dt_first_seen_values := SALT25.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT25.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Proxid) ), Proxid, LOCAL ), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_hasnumber_Values := IF ( le.cnp_hasnumber  IN SET(s.nulls_cnp_hasnumber,cnp_hasnumber),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_hasnumber)}],SALT25.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_enterprise_number)}],SALT25.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.source_record_id)}],SALT25.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_ssn)}],SALT25.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_fein)}],SALT25.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_charter_number)}],SALT25.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_duns_number)}],SALT25.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_domestic_corp_key)}],SALT25.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_phone)}],SALT25.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_name)}],SALT25.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.corp_legal_name)}],SALT25.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT25.Layout_FieldValueList),dataset([{TRIM((SALT25.StrType)le.prim_range) + ' ' + TRIM((SALT25.StrType)le.prim_name) + ' ' + TRIM((SALT25.StrType)le.sec_range) + ' ' + TRIM((SALT25.StrType)le.v_city_name) + ' ' + TRIM((SALT25.StrType)le.st) + ' ' + TRIM((SALT25.StrType)le.zip)}],SALT25.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.lname)}],SALT25.Layout_FieldValueList));
  SELF.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.zip4)}],SALT25.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_number)}],SALT25.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( le.p_city_name  IN SET(s.nulls_p_city_name,p_city_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.p_city_name)}],SALT25.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.fname)}],SALT25.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_inc_state)}],SALT25.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.mname)}],SALT25.Layout_FieldValueList));
  SELF.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.postdir)}],SALT25.Layout_FieldValueList));
  SELF.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.predir)}],SALT25.Layout_FieldValueList));
  SELF.addr_suffix_Values := IF ( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.addr_suffix)}],SALT25.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_btype)}],SALT25.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.source)}],SALT25.Layout_FieldValueList));
  SELF.iscorp_Values := IF ( le.iscorp  IN SET(s.nulls_iscorp,iscorp),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.iscorp)}],SALT25.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT25.StrType)le.company_name)}],SALT25.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_lowv)}],SALT25.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_translated)}],SALT25.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_classid)}],SALT25.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT25.StrType)le.company_bdid)}],SALT25.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT25.StrType)le.company_phone)}],SALT25.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT25.StrType)le.unit_desig)}],SALT25.Layout_FieldValueList);
  SELF.Company_RAWAID_Values := DATASET([{TRIM((SALT25.StrType)le.Company_RAWAID)}],SALT25.Layout_FieldValueList);
  SELF.isContact_Values := DATASET([{TRIM((SALT25.StrType)le.isContact)}],SALT25.Layout_FieldValueList);
  SELF.title_Values := DATASET([{TRIM((SALT25.StrType)le.title)}],SALT25.Layout_FieldValueList);
  SELF.name_suffix_Values := DATASET([{TRIM((SALT25.StrType)le.name_suffix)}],SALT25.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT25.StrType)le.contact_email)}],SALT25.Layout_FieldValueList);
  SELF.contact_job_title_raw_Values := DATASET([{TRIM((SALT25.StrType)le.contact_job_title_raw)}],SALT25.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT25.StrType)le.company_department)}],SALT25.Layout_FieldValueList);
  SELF.contact_email_username_Values := IF ( le.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_email_username)}],SALT25.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT25.StrType)le.dt_first_seen)}],SALT25.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT25.StrType)le.dt_last_seen)}],SALT25.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_hasnumber_Values := IF ( le.cnp_hasnumber  IN SET(s.nulls_cnp_hasnumber,cnp_hasnumber),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_hasnumber)}],SALT25.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_enterprise_number)}],SALT25.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( le.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.source_record_id)}],SALT25.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( le.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_ssn)}],SALT25.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_fein)}],SALT25.Layout_FieldValueList));
  SELF.company_charter_number_Values := IF ( le.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_charter_number)}],SALT25.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_duns_number)}],SALT25.Layout_FieldValueList));
  SELF.active_domestic_corp_key_Values := IF ( le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.active_domestic_corp_key)}],SALT25.Layout_FieldValueList));
  SELF.contact_phone_Values := IF ( le.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_phone)}],SALT25.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_name)}],SALT25.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.corp_legal_name)}],SALT25.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT25.Layout_FieldValueList),dataset([{TRIM((SALT25.StrType)le.prim_range) + ' ' + TRIM((SALT25.StrType)le.prim_name) + ' ' + TRIM((SALT25.StrType)le.sec_range) + ' ' + TRIM((SALT25.StrType)le.v_city_name) + ' ' + TRIM((SALT25.StrType)le.st) + ' ' + TRIM((SALT25.StrType)le.zip)}],SALT25.Layout_FieldValueList));
  SELF.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.lname)}],SALT25.Layout_FieldValueList));
  SELF.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.zip4)}],SALT25.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_number)}],SALT25.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( le.p_city_name  IN SET(s.nulls_p_city_name,p_city_name),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.p_city_name)}],SALT25.Layout_FieldValueList));
  SELF.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.fname)}],SALT25.Layout_FieldValueList));
  SELF.company_inc_state_Values := IF ( le.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.company_inc_state)}],SALT25.Layout_FieldValueList));
  SELF.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.mname)}],SALT25.Layout_FieldValueList));
  SELF.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.postdir)}],SALT25.Layout_FieldValueList));
  SELF.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.predir)}],SALT25.Layout_FieldValueList));
  SELF.addr_suffix_Values := IF ( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.addr_suffix)}],SALT25.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.cnp_btype)}],SALT25.Layout_FieldValueList));
  SELF.source_Values := IF ( le.source  IN SET(s.nulls_source,source),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.source)}],SALT25.Layout_FieldValueList));
  SELF.iscorp_Values := IF ( le.iscorp  IN SET(s.nulls_iscorp,iscorp),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.iscorp)}],SALT25.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT25.StrType)le.company_name)}],SALT25.Layout_FieldValueList);
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_lowv)}],SALT25.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_translated)}],SALT25.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT25.StrType)le.cnp_classid)}],SALT25.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT25.StrType)le.company_bdid)}],SALT25.Layout_FieldValueList);
  SELF.company_phone_Values := DATASET([{TRIM((SALT25.StrType)le.company_phone)}],SALT25.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT25.StrType)le.unit_desig)}],SALT25.Layout_FieldValueList);
  SELF.Company_RAWAID_Values := DATASET([{TRIM((SALT25.StrType)le.Company_RAWAID)}],SALT25.Layout_FieldValueList);
  SELF.isContact_Values := DATASET([{TRIM((SALT25.StrType)le.isContact)}],SALT25.Layout_FieldValueList);
  SELF.title_Values := DATASET([{TRIM((SALT25.StrType)le.title)}],SALT25.Layout_FieldValueList);
  SELF.name_suffix_Values := DATASET([{TRIM((SALT25.StrType)le.name_suffix)}],SALT25.Layout_FieldValueList);
  SELF.contact_email_Values := DATASET([{TRIM((SALT25.StrType)le.contact_email)}],SALT25.Layout_FieldValueList);
  SELF.contact_job_title_raw_Values := DATASET([{TRIM((SALT25.StrType)le.contact_job_title_raw)}],SALT25.Layout_FieldValueList);
  SELF.company_department_Values := DATASET([{TRIM((SALT25.StrType)le.company_department)}],SALT25.Layout_FieldValueList);
  SELF.contact_email_username_Values := IF ( le.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),DATASET([],SALT25.Layout_FieldValueList),DATASET([{TRIM((SALT25.StrType)le.contact_email_username)}],SALT25.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT25.StrType)le.dt_first_seen)}],SALT25.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT25.StrType)le.dt_last_seen)}],SALT25.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.active_enterprise_number := if ( le.active_enterprise_number_prop>0, (TYPEOF(le.active_enterprise_number))'', le.active_enterprise_number ); // Blank if propogated
    self.active_enterprise_number_isnull := le.active_enterprise_number_prop>0 OR le.active_enterprise_number_isnull;
    self.active_enterprise_number_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_charter_number := if ( le.company_charter_number_prop>0, (TYPEOF(le.company_charter_number))'', le.company_charter_number ); // Blank if propogated
    self.company_charter_number_isnull := le.company_charter_number_prop>0 OR le.company_charter_number_isnull;
    self.company_charter_number_prop := 0; // Avoid reducing score later
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.active_domestic_corp_key := if ( le.active_domestic_corp_key_prop>0, (TYPEOF(le.active_domestic_corp_key))'', le.active_domestic_corp_key ); // Blank if propogated
    self.active_domestic_corp_key_isnull := le.active_domestic_corp_key_prop>0 OR le.active_domestic_corp_key_isnull;
    self.active_domestic_corp_key_prop := 0; // Avoid reducing score later
    self.corp_legal_name := if ( le.corp_legal_name_prop>0, (TYPEOF(le.corp_legal_name))'', le.corp_legal_name ); // Blank if propogated
    self.corp_legal_name_isnull := le.corp_legal_name_prop>0 OR le.corp_legal_name_isnull;
    self.corp_legal_name_prop := 0; // Avoid reducing score later
    self.company_address := if ( le.company_address_prop>0, 0, le.company_address ); // Blank if propogated
    self.company_address_isnull := true; // Flag as null to scoring
    self.company_address_prop := 0; // Avoid reducing score later
    self.company_addr1 := if ( le.company_addr1_prop>0, 0, le.company_addr1 ); // Blank if propogated
    self.company_addr1_isnull := true; // Flag as null to scoring
    self.company_addr1_prop := 0; // Avoid reducing score later
    self.sec_range := if ( le.sec_range_prop>0, (TYPEOF(le.sec_range))'', le.sec_range ); // Blank if propogated
    self.sec_range_isnull := le.sec_range_prop>0 OR le.sec_range_isnull;
    self.sec_range_prop := 0; // Avoid reducing score later
    self.company_inc_state := if ( le.company_inc_state_prop>0, (TYPEOF(le.company_inc_state))'', le.company_inc_state ); // Blank if propogated
    self.company_inc_state_isnull := le.company_inc_state_prop>0 OR le.company_inc_state_isnull;
    self.company_inc_state_prop := 0; // Avoid reducing score later
    self.iscorp := if ( le.iscorp_prop>0, (TYPEOF(le.iscorp))'', le.iscorp ); // Blank if propogated
    self.iscorp_isnull := le.iscorp_prop>0 OR le.iscorp_isnull;
    self.iscorp_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 cnp_hasnumber_size := 0;
  UNSIGNED1 active_enterprise_number_size := 0;
  UNSIGNED1 source_record_id_size := 0;
  UNSIGNED1 contact_ssn_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_charter_number_size := 0;
  UNSIGNED1 active_duns_number_size := 0;
  UNSIGNED1 active_domestic_corp_key_size := 0;
  UNSIGNED1 contact_phone_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 corp_legal_name_size := 0;
  UNSIGNED1 company_address_size := 0;
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 zip4_size := 0;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 p_city_name_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 company_inc_state_size := 0;
  UNSIGNED1 mname_size := 0;
  UNSIGNED1 postdir_size := 0;
  UNSIGNED1 predir_size := 0;
  UNSIGNED1 addr_suffix_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
  UNSIGNED1 source_size := 0;
  UNSIGNED1 iscorp_size := 0;
  UNSIGNED1 contact_email_username_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.cnp_hasnumber_size := SALT25.Fn_SwitchSpec(s.cnp_hasnumber_switch,count(le.cnp_hasnumber_values));
  SELF.active_enterprise_number_size := SALT25.Fn_SwitchSpec(s.active_enterprise_number_switch,count(le.active_enterprise_number_values));
  SELF.source_record_id_size := SALT25.Fn_SwitchSpec(s.source_record_id_switch,count(le.source_record_id_values));
  SELF.contact_ssn_size := SALT25.Fn_SwitchSpec(s.contact_ssn_switch,count(le.contact_ssn_values));
  SELF.company_fein_size := SALT25.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_charter_number_size := SALT25.Fn_SwitchSpec(s.company_charter_number_switch,count(le.company_charter_number_values));
  SELF.active_duns_number_size := SALT25.Fn_SwitchSpec(s.active_duns_number_switch,count(le.active_duns_number_values));
  SELF.active_domestic_corp_key_size := SALT25.Fn_SwitchSpec(s.active_domestic_corp_key_switch,count(le.active_domestic_corp_key_values));
  SELF.contact_phone_size := SALT25.Fn_SwitchSpec(s.contact_phone_switch,count(le.contact_phone_values));
  SELF.cnp_name_size := SALT25.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.corp_legal_name_size := SALT25.Fn_SwitchSpec(s.corp_legal_name_switch,count(le.corp_legal_name_values));
  SELF.company_address_size := SALT25.Fn_SwitchSpec(s.company_address_switch,count(le.company_address_values));
  SELF.lname_size := SALT25.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.zip4_size := SALT25.Fn_SwitchSpec(s.zip4_switch,count(le.zip4_values));
  SELF.cnp_number_size := SALT25.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.p_city_name_size := SALT25.Fn_SwitchSpec(s.p_city_name_switch,count(le.p_city_name_values));
  SELF.fname_size := SALT25.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.company_inc_state_size := SALT25.Fn_SwitchSpec(s.company_inc_state_switch,count(le.company_inc_state_values));
  SELF.mname_size := SALT25.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.postdir_size := SALT25.Fn_SwitchSpec(s.postdir_switch,count(le.postdir_values));
  SELF.predir_size := SALT25.Fn_SwitchSpec(s.predir_switch,count(le.predir_values));
  SELF.addr_suffix_size := SALT25.Fn_SwitchSpec(s.addr_suffix_switch,count(le.addr_suffix_values));
  SELF.cnp_btype_size := SALT25.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF.source_size := SALT25.Fn_SwitchSpec(s.source_switch,count(le.source_values));
  SELF.iscorp_size := SALT25.Fn_SwitchSpec(s.iscorp_switch,count(le.iscorp_values));
  SELF.contact_email_username_size := SALT25.Fn_SwitchSpec(s.contact_email_username_switch,count(le.contact_email_username_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.cnp_hasnumber_size+t.active_enterprise_number_size+t.source_record_id_size+t.contact_ssn_size+t.company_fein_size+t.company_charter_number_size+t.active_duns_number_size+t.active_domestic_corp_key_size+t.contact_phone_size+t.cnp_name_size+t.corp_legal_name_size+t.company_address_size+t.lname_size+t.zip4_size+t.cnp_number_size+t.p_city_name_size+t.fname_size+t.company_inc_state_size+t.mname_size+t.postdir_size+t.predir_size+t.addr_suffix_size+t.cnp_btype_size+t.source_size+t.iscorp_size+t.contact_email_username_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
