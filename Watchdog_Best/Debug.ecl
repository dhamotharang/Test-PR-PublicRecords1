// Various routines to assist in debugging

IMPORT Watchdog_Best; // Import modules for  attribute definitions
IMPORT SALT311,std;
EXPORT Debug(DATASET(layout_Hdr) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes

EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.src) left_src;
  INTEGER1 src_match_code;
  INTEGER2 src_score;
  TYPEOF(h.src) right_src;
  TYPEOF(h.address) left_address;
  INTEGER1 address_match_code;
  INTEGER2 address_score;
  TYPEOF(h.address) right_address;
  TYPEOF(h.rawaid) left_rawaid;
  INTEGER1 rawaid_match_code;
  INTEGER2 rawaid_score;
  TYPEOF(h.rawaid) right_rawaid;
  TYPEOF(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.zip4) left_zip4;
  INTEGER1 zip4_match_code;
  INTEGER2 zip4_score;
  TYPEOF(h.zip4) right_zip4;
  TYPEOF(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.city_name) left_city_name;
  INTEGER1 city_name_match_code;
  INTEGER2 city_name_score;
  TYPEOF(h.city_name) right_city_name;
  TYPEOF(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.tnt) left_tnt;
  INTEGER1 tnt_match_code;
  INTEGER2 tnt_score;
  TYPEOF(h.tnt) right_tnt;
  TYPEOF(h.name_suffix) left_name_suffix;
  INTEGER1 name_suffix_match_code;
  INTEGER2 name_suffix_score;
  TYPEOF(h.name_suffix) right_name_suffix;
  TYPEOF(h.dt_nonglb_last_seen) left_dt_nonglb_last_seen;
  INTEGER1 dt_nonglb_last_seen_match_code;
  INTEGER2 dt_nonglb_last_seen_score;
  TYPEOF(h.dt_nonglb_last_seen) right_dt_nonglb_last_seen;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  INTEGER1 dt_first_seen_match_code;
  INTEGER2 dt_first_seen_score;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.postdir) left_postdir;
  INTEGER1 postdir_match_code;
  INTEGER2 postdir_score;
  TYPEOF(h.postdir) right_postdir;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  INTEGER1 dt_last_seen_match_code;
  INTEGER2 dt_last_seen_score;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
  TYPEOF(h.ssnum) left_ssnum;
  INTEGER1 ssnum_match_code;
  INTEGER2 ssnum_score;
  TYPEOF(h.ssnum) right_ssnum;
  TYPEOF(h.dodgy_tracking) left_dodgy_tracking;
  INTEGER1 dodgy_tracking_match_code;
  INTEGER2 dodgy_tracking_score;
  TYPEOF(h.dodgy_tracking) right_dodgy_tracking;
  TYPEOF(h.dt_vendor_first_reported) left_dt_vendor_first_reported;
  INTEGER1 dt_vendor_first_reported_match_code;
  INTEGER2 dt_vendor_first_reported_score;
  TYPEOF(h.dt_vendor_first_reported) right_dt_vendor_first_reported;
  TYPEOF(h.dt_vendor_last_reported) left_dt_vendor_last_reported;
  INTEGER1 dt_vendor_last_reported_match_code;
  INTEGER2 dt_vendor_last_reported_score;
  TYPEOF(h.dt_vendor_last_reported) right_dt_vendor_last_reported;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  TYPEOF(h.st) right_st;
  TYPEOF(h.pflag1) left_pflag1;
  INTEGER1 pflag1_match_code;
  INTEGER2 pflag1_score;
  TYPEOF(h.pflag1) right_pflag1;
  TYPEOF(h.pflag2) left_pflag2;
  INTEGER1 pflag2_match_code;
  INTEGER2 pflag2_score;
  TYPEOF(h.pflag2) right_pflag2;
  TYPEOF(h.predir) left_predir;
  INTEGER1 predir_match_code;
  INTEGER2 predir_score;
  TYPEOF(h.predir) right_predir;
  TYPEOF(h.jflag2) left_jflag2;
  INTEGER1 jflag2_match_code;
  INTEGER2 jflag2_score;
  TYPEOF(h.jflag2) right_jflag2;
  TYPEOF(h.suffix) left_suffix;
  INTEGER1 suffix_match_code;
  INTEGER2 suffix_score;
  TYPEOF(h.suffix) right_suffix;
  TYPEOF(h.unit_desig) left_unit_desig;
  INTEGER1 unit_desig_match_code;
  INTEGER2 unit_desig_score;
  TYPEOF(h.unit_desig) right_unit_desig;
  TYPEOF(h.jflag3) left_jflag3;
  INTEGER1 jflag3_match_code;
  INTEGER2 jflag3_score;
  TYPEOF(h.jflag3) right_jflag3;
  TYPEOF(h.jflag1) left_jflag1;
  INTEGER1 jflag1_match_code;
  INTEGER2 jflag1_score;
  TYPEOF(h.jflag1) right_jflag1;
  TYPEOF(h.valid_ssn) left_valid_ssn;
  INTEGER1 valid_ssn_match_code;
  INTEGER2 valid_ssn_score;
  TYPEOF(h.valid_ssn) right_valid_ssn;
  TYPEOF(h.phone) left_phone;
  INTEGER1 phone_match_code;
  INTEGER2 phone_score;
  TYPEOF(h.phone) right_phone;
  TYPEOF(h.ssn) left_ssn;
  INTEGER1 ssn_match_code;
  INTEGER2 ssn_score;
  TYPEOF(h.ssn) right_ssn;
  TYPEOF(h.dob) left_dob;
  INTEGER1 dob_match_code;
  INTEGER2 dob_score;
  TYPEOF(h.dob) right_dob;
  TYPEOF(h.rec_type) left_rec_type;
  INTEGER1 rec_type_match_code;
  INTEGER2 rec_type_score;
  TYPEOF(h.rec_type) right_rec_type;
  TYPEOF(h.pflag3) left_pflag3;
  INTEGER1 pflag3_match_code;
  INTEGER2 pflag3_score;
  TYPEOF(h.pflag3) right_pflag3;
  TYPEOF(h.title) left_title;
  INTEGER1 title_match_code;
  INTEGER2 title_score;
  TYPEOF(h.title) right_title;
  TYPEOF(h.fname) left_fname;
  INTEGER1 fname_match_code;
  INTEGER2 fname_score;
  INTEGER2 fname_score_prop;
  TYPEOF(h.fname) right_fname;
  TYPEOF(h.mname) left_mname;
  INTEGER1 mname_match_code;
  INTEGER2 mname_score;
  INTEGER2 mname_score_prop;
  TYPEOF(h.mname) right_mname;
  TYPEOF(h.lname) left_lname;
  INTEGER1 lname_match_code;
  INTEGER2 lname_score;
  TYPEOF(h.lname) right_lname;
  TYPEOF(h.address_ind) left_address_ind;
  INTEGER1 address_ind_match_code;
  INTEGER2 address_ind_score;
  TYPEOF(h.address_ind) right_address_ind;
  TYPEOF(h.name_ind) left_name_ind;
  INTEGER1 name_ind_match_code;
  INTEGER2 name_ind_score;
  TYPEOF(h.name_ind) right_name_ind;
  TYPEOF(h.persistent_record_id) left_persistent_record_id;
  INTEGER1 persistent_record_id_match_code;
  INTEGER2 persistent_record_id_score;
  TYPEOF(h.persistent_record_id) right_persistent_record_id;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.did1 := le.did;
  SELF.did2 := ri.did;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  SELF.left_src := le.src;
  SELF.right_src := ri.src;
  SELF.src_match_code := MAP(
                        le.src_isnull OR ri.src_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_src(le.src,ri.src));
  SELF.src_score := MAP(
                        le.src_isnull OR ri.src_isnull => 0,
                        le.src = ri.src  => le.src_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.src_weight100,ri.src_weight100),s.src_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.predir_weight100 + ri.predir_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.suffix_weight100 + ri.suffix_weight100 + le.postdir_weight100 + ri.postdir_weight100 + le.unit_desig_weight100 + ri.unit_desig_weight100 + le.sec_range_weight100 + ri.sec_range_weight100 + le.city_name_weight100 + ri.city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100 + le.zip4_weight100 + ri.zip4_weight100 + le.tnt_weight100 + ri.tnt_weight100 + le.rawaid_weight100 + ri.rawaid_weight100 + le.dt_first_seen_weight100 + ri.dt_first_seen_weight100 + le.dt_last_seen_weight100 + ri.dt_last_seen_weight100 + le.dt_vendor_first_reported_weight100 + ri.dt_vendor_first_reported_weight100 + le.dt_vendor_last_reported_weight100 + ri.dt_vendor_last_reported_weight100); // Scaling factor for this concept
  SELF.address_match_code := MAP(
                        (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.city_name_isnull AND le.st_isnull AND le.zip_isnull AND le.zip4_isnull AND le.tnt_isnull AND le.rawaid_isnull AND le.dt_first_seen_isnull AND le.dt_last_seen_isnull AND le.dt_vendor_first_reported_isnull AND le.dt_vendor_last_reported_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.city_name_isnull AND ri.st_isnull AND ri.zip_isnull AND ri.zip4_isnull AND ri.tnt_isnull AND ri.rawaid_isnull AND ri.dt_first_seen_isnull AND ri.dt_last_seen_isnull AND ri.dt_vendor_first_reported_isnull AND ri.dt_vendor_last_reported_isnull) => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_address(le.address,ri.address,FALSE));
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.city_name_isnull AND le.st_isnull AND le.zip_isnull AND le.zip4_isnull AND le.tnt_isnull AND le.rawaid_isnull AND le.dt_first_seen_isnull AND le.dt_last_seen_isnull AND le.dt_vendor_first_reported_isnull AND le.dt_vendor_last_reported_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.city_name_isnull AND ri.st_isnull AND ri.zip_isnull AND ri.zip4_isnull AND ri.tnt_isnull AND ri.rawaid_isnull AND ri.dt_first_seen_isnull AND ri.dt_last_seen_isnull AND ri.dt_vendor_first_reported_isnull AND ri.dt_vendor_last_reported_isnull) => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  SELF.left_address := le.address;
  SELF.right_address := ri.address;
  SELF.left_rawaid := le.rawaid;
  SELF.right_rawaid := ri.rawaid;
  SELF.rawaid_match_code := MAP(
                        le.rawaid_isnull OR ri.rawaid_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_rawaid(le.rawaid,ri.rawaid));
  SELF.rawaid_score := MAP(
                        le.rawaid_isnull OR ri.rawaid_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.rawaid = ri.rawaid  => le.rawaid_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.rawaid_weight100,ri.rawaid_weight100),s.rawaid_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  SELF.prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_name_weight100,ri.prim_name_weight100),s.prim_name_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
                        le.zip_isnull OR ri.zip_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip_weight100,ri.zip_weight100),s.zip_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.zip4_match_code := MAP(
                        le.zip4_isnull OR ri.zip4_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_zip4(le.zip4,ri.zip4));
  SELF.zip4_score := MAP(
                        le.zip4_isnull OR ri.zip4_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip4_weight100,ri.zip4_weight100),s.zip4_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  SELF.prim_range_score := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_weight100,ri.prim_range_weight100),s.prim_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_city_name := le.city_name;
  SELF.right_city_name := ri.city_name;
  SELF.city_name_match_code := MAP(
                        le.city_name_isnull OR ri.city_name_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_city_name(le.city_name,ri.city_name));
  SELF.city_name_score := MAP(
                        le.city_name_isnull OR ri.city_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.city_name = ri.city_name  => le.city_name_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.city_name_weight100,ri.city_name_weight100),s.city_name_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_sec_range(le.sec_range,ri.sec_range));
  SELF.sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_weight100,ri.sec_range_weight100),s.sec_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_tnt := le.tnt;
  SELF.right_tnt := ri.tnt;
  SELF.tnt_match_code := MAP(
                        le.tnt_isnull OR ri.tnt_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_tnt(le.tnt,ri.tnt));
  SELF.tnt_score := MAP(
                        le.tnt_isnull OR ri.tnt_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.tnt = ri.tnt  => le.tnt_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.tnt_weight100,ri.tnt_weight100),s.tnt_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_name_suffix := le.name_suffix;
  SELF.right_name_suffix := ri.name_suffix;
  SELF.name_suffix_match_code := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_name_suffix(le.name_suffix,ri.name_suffix));
  SELF.name_suffix_score := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.name_suffix_weight100,ri.name_suffix_weight100),s.name_suffix_switch));
  SELF.left_dt_nonglb_last_seen := le.dt_nonglb_last_seen;
  SELF.right_dt_nonglb_last_seen := ri.dt_nonglb_last_seen;
  SELF.dt_nonglb_last_seen_match_code := MAP(
                        le.dt_nonglb_last_seen_isnull OR ri.dt_nonglb_last_seen_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_nonglb_last_seen(le.dt_nonglb_last_seen,ri.dt_nonglb_last_seen));
  SELF.dt_nonglb_last_seen_score := MAP(
                        le.dt_nonglb_last_seen_isnull OR ri.dt_nonglb_last_seen_isnull => 0,
                        le.dt_nonglb_last_seen = ri.dt_nonglb_last_seen  => le.dt_nonglb_last_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_nonglb_last_seen_weight100,ri.dt_nonglb_last_seen_weight100),s.dt_nonglb_last_seen_switch));
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.dt_first_seen_match_code := MAP(
                        le.dt_first_seen_isnull OR ri.dt_first_seen_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_dt_first_seen(le.dt_first_seen,ri.dt_first_seen));
  SELF.dt_first_seen_score := MAP(
                        le.dt_first_seen_isnull OR ri.dt_first_seen_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_first_seen_weight100,ri.dt_first_seen_weight100),s.dt_first_seen_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.postdir_match_code := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_postdir(le.postdir,ri.postdir));
  SELF.postdir_score := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.postdir_weight100,ri.postdir_weight100),s.postdir_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.dt_last_seen_match_code := MAP(
                        le.dt_last_seen_isnull OR ri.dt_last_seen_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_dt_last_seen(le.dt_last_seen,ri.dt_last_seen));
  SELF.dt_last_seen_score := MAP(
                        le.dt_last_seen_isnull OR ri.dt_last_seen_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_last_seen_weight100,ri.dt_last_seen_weight100),s.dt_last_seen_switch))*IF(address_score_scale=0,1,address_score_scale);
  REAL ssnum_score_scale := ( le.ssnum_weight100 + ri.ssnum_weight100 ) / (le.ssn_weight100 + ri.ssn_weight100 + le.valid_ssn_weight100 + ri.valid_ssn_weight100); // Scaling factor for this concept
  SELF.ssnum_match_code := MAP(
                        (le.ssnum_isnull OR le.ssn_isnull AND le.valid_ssn_isnull) OR (ri.ssnum_isnull OR ri.ssn_isnull AND ri.valid_ssn_isnull) => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_ssnum(le.ssnum,ri.ssnum,FALSE));
  INTEGER2 ssnum_score_pre := MAP( (le.ssnum_isnull OR le.ssn_isnull AND le.valid_ssn_isnull) OR (ri.ssnum_isnull OR ri.ssn_isnull AND ri.valid_ssn_isnull) => 0,
                        le.ssnum = ri.ssnum  => le.ssnum_weight100,
                        0);
  SELF.left_ssnum := le.ssnum;
  SELF.right_ssnum := ri.ssnum;
  SELF.left_dodgy_tracking := le.dodgy_tracking;
  SELF.right_dodgy_tracking := ri.dodgy_tracking;
  SELF.dodgy_tracking_match_code := MAP(
                        le.dodgy_tracking_isnull OR ri.dodgy_tracking_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_dodgy_tracking(le.dodgy_tracking,ri.dodgy_tracking));
  SELF.dodgy_tracking_score := MAP(
                        le.dodgy_tracking_isnull OR ri.dodgy_tracking_isnull => 0,
                        le.dodgy_tracking = ri.dodgy_tracking  => le.dodgy_tracking_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dodgy_tracking_weight100,ri.dodgy_tracking_weight100),s.dodgy_tracking_switch));
  SELF.left_dt_vendor_first_reported := le.dt_vendor_first_reported;
  SELF.right_dt_vendor_first_reported := ri.dt_vendor_first_reported;
  SELF.dt_vendor_first_reported_match_code := MAP(
                        le.dt_vendor_first_reported_isnull OR ri.dt_vendor_first_reported_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_dt_vendor_first_reported(le.dt_vendor_first_reported,ri.dt_vendor_first_reported));
  SELF.dt_vendor_first_reported_score := MAP(
                        le.dt_vendor_first_reported_isnull OR ri.dt_vendor_first_reported_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_vendor_first_reported_weight100,ri.dt_vendor_first_reported_weight100),s.dt_vendor_first_reported_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_dt_vendor_last_reported := le.dt_vendor_last_reported;
  SELF.right_dt_vendor_last_reported := ri.dt_vendor_last_reported;
  SELF.dt_vendor_last_reported_match_code := MAP(
                        le.dt_vendor_last_reported_isnull OR ri.dt_vendor_last_reported_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_dt_vendor_last_reported(le.dt_vendor_last_reported,ri.dt_vendor_last_reported));
  SELF.dt_vendor_last_reported_score := MAP(
                        le.dt_vendor_last_reported_isnull OR ri.dt_vendor_last_reported_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_vendor_last_reported_weight100,ri.dt_vendor_last_reported_weight100),s.dt_vendor_last_reported_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
                        le.st_isnull OR ri.st_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_st(le.st,ri.st));
  SELF.st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.st_weight100,ri.st_weight100),s.st_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_pflag1 := le.pflag1;
  SELF.right_pflag1 := ri.pflag1;
  SELF.pflag1_match_code := MAP(
                        le.pflag1_isnull OR ri.pflag1_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_pflag1(le.pflag1,ri.pflag1));
  SELF.pflag1_score := MAP(
                        le.pflag1_isnull OR ri.pflag1_isnull => 0,
                        le.pflag1 = ri.pflag1  => le.pflag1_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag1_weight100,ri.pflag1_weight100),s.pflag1_switch));
  SELF.left_pflag2 := le.pflag2;
  SELF.right_pflag2 := ri.pflag2;
  SELF.pflag2_match_code := MAP(
                        le.pflag2_isnull OR ri.pflag2_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_pflag2(le.pflag2,ri.pflag2));
  SELF.pflag2_score := MAP(
                        le.pflag2_isnull OR ri.pflag2_isnull => 0,
                        le.pflag2 = ri.pflag2  => le.pflag2_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag2_weight100,ri.pflag2_weight100),s.pflag2_switch));
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.predir_match_code := MAP(
                        le.predir_isnull OR ri.predir_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_predir(le.predir,ri.predir));
  SELF.predir_score := MAP(
                        le.predir_isnull OR ri.predir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.predir_weight100,ri.predir_weight100),s.predir_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_jflag2 := le.jflag2;
  SELF.right_jflag2 := ri.jflag2;
  SELF.jflag2_match_code := MAP(
                        le.jflag2_isnull OR ri.jflag2_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_jflag2(le.jflag2,ri.jflag2));
  SELF.jflag2_score := MAP(
                        le.jflag2_isnull OR ri.jflag2_isnull => 0,
                        le.jflag2 = ri.jflag2  => le.jflag2_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag2_weight100,ri.jflag2_weight100),s.jflag2_switch));
  SELF.left_suffix := le.suffix;
  SELF.right_suffix := ri.suffix;
  SELF.suffix_match_code := MAP(
                        le.suffix_isnull OR ri.suffix_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_suffix(le.suffix,ri.suffix));
  SELF.suffix_score := MAP(
                        le.suffix_isnull OR ri.suffix_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.suffix = ri.suffix  => le.suffix_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.suffix_weight100,ri.suffix_weight100),s.suffix_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.unit_desig_match_code := MAP(
                        le.unit_desig_isnull OR ri.unit_desig_isnull => SALT311.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_unit_desig(le.unit_desig,ri.unit_desig));
  SELF.unit_desig_score := MAP(
                        le.unit_desig_isnull OR ri.unit_desig_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.unit_desig_weight100,ri.unit_desig_weight100),s.unit_desig_switch))*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_jflag3 := le.jflag3;
  SELF.right_jflag3 := ri.jflag3;
  SELF.jflag3_match_code := MAP(
                        le.jflag3_isnull OR ri.jflag3_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_jflag3(le.jflag3,ri.jflag3));
  SELF.jflag3_score := MAP(
                        le.jflag3_isnull OR ri.jflag3_isnull => 0,
                        le.jflag3 = ri.jflag3  => le.jflag3_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag3_weight100,ri.jflag3_weight100),s.jflag3_switch));
  SELF.left_jflag1 := le.jflag1;
  SELF.right_jflag1 := ri.jflag1;
  SELF.jflag1_match_code := MAP(
                        le.jflag1_isnull OR ri.jflag1_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_jflag1(le.jflag1,ri.jflag1));
  SELF.jflag1_score := MAP(
                        le.jflag1_isnull OR ri.jflag1_isnull => 0,
                        le.jflag1 = ri.jflag1  => le.jflag1_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag1_weight100,ri.jflag1_weight100),s.jflag1_switch));
  SELF.left_valid_ssn := le.valid_ssn;
  SELF.right_valid_ssn := ri.valid_ssn;
  SELF.valid_ssn_match_code := MAP(
                        le.valid_ssn_isnull OR ri.valid_ssn_isnull => SALT311.MatchCode.OneSideNull,
                        ssnum_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_valid_ssn(le.valid_ssn,ri.valid_ssn));
  SELF.valid_ssn_score := MAP(
                        le.valid_ssn_isnull OR ri.valid_ssn_isnull => 0,
                        ssnum_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.valid_ssn = ri.valid_ssn  => le.valid_ssn_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.valid_ssn_weight100,ri.valid_ssn_weight100),s.valid_ssn_switch))*IF(ssnum_score_scale=0,1,ssnum_score_scale);
  SELF.left_phone := le.phone;
  SELF.right_phone := ri.phone;
  SELF.phone_match_code := MAP(
                        le.phone_isnull OR ri.phone_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_phone(le.phone,ri.phone, le.phone_len, ri.phone_len));
  SELF.phone_score := MAP(
                        le.phone_isnull OR ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        Config.WithinEditN(le.phone,le.phone_len,ri.phone,ri.phone_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.phone_weight100,le.phone_cnt, le.phone_e1_cnt,ri.phone_weight100,ri.phone_cnt,ri.phone_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.phone_weight100,ri.phone_weight100),s.phone_switch));
  SELF.left_ssn := le.ssn;
  SELF.right_ssn := ri.ssn;
  SELF.ssn_match_code := MAP(
                        le.ssn_isnull OR ri.ssn_isnull => SALT311.MatchCode.OneSideNull,
                        ssnum_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_ssn(le.ssn,ri.ssn));
  SELF.ssn_score := MAP(
                        le.ssn_isnull OR ri.ssn_isnull => 0,
                        ssnum_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ssn = ri.ssn  => le.ssn_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ssn_weight100,ri.ssn_weight100),s.ssn_switch))*IF(ssnum_score_scale=0,1,ssnum_score_scale);
  SELF.left_dob := le.dob;
  SELF.right_dob := ri.dob;
  SELF.dob_match_code := MAP(
                        le.dob_isnull OR ri.dob_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_dob(le.dob,ri.dob));
  SELF.dob_score := MAP(
                        le.dob_isnull OR ri.dob_isnull => 0,
                        le.dob = ri.dob  => le.dob_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dob_weight100,ri.dob_weight100),s.dob_switch));
  SELF.left_rec_type := le.rec_type;
  SELF.right_rec_type := ri.rec_type;
  SELF.rec_type_match_code := MAP(
                        le.rec_type_isnull OR ri.rec_type_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_rec_type(le.rec_type,ri.rec_type));
  SELF.rec_type_score := MAP(
                        le.rec_type_isnull OR ri.rec_type_isnull => 0,
                        le.rec_type = ri.rec_type  => le.rec_type_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.rec_type_weight100,ri.rec_type_weight100),s.rec_type_switch));
  SELF.left_pflag3 := le.pflag3;
  SELF.right_pflag3 := ri.pflag3;
  SELF.pflag3_match_code := MAP(
                        le.pflag3_isnull OR ri.pflag3_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_pflag3(le.pflag3,ri.pflag3));
  SELF.pflag3_score := MAP(
                        le.pflag3_isnull OR ri.pflag3_isnull => 0,
                        le.pflag3 = ri.pflag3  => le.pflag3_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag3_weight100,ri.pflag3_weight100),s.pflag3_switch));
  SELF.left_title := le.title;
  SELF.right_title := ri.title;
  SELF.title_match_code := MAP(
                        le.title_isnull OR ri.title_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_title(le.title,ri.title));
  SELF.title_score := MAP(
                        le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.title_weight100,ri.title_weight100),s.title_switch));
  SELF.left_fname := le.fname;
  SELF.right_fname := ri.fname;
  SELF.fname_match_code := MAP(
                        le.fname_isnull OR ri.fname_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_fname(le.fname,ri.fname, le.fname_len, ri.fname_len));
  SELF.fname_score := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.fname_weight100,ri.fname_weight100),s.fname_switch));
  SELF.left_mname := le.mname;
  SELF.right_mname := ri.mname;
  SELF.mname_match_code := MAP(
                        le.mname_isnull OR ri.mname_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_mname(le.mname,ri.mname, le.mname_len, ri.mname_len));
  SELF.mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.mname,le.mname_len,ri.mname,ri.mname_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.mname_weight100,ri.mname_weight100),s.mname_switch));
  SELF.left_lname := le.lname;
  SELF.right_lname := ri.lname;
  SELF.lname_match_code := MAP(
                        le.lname_isnull OR ri.lname_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_lname(le.lname,ri.lname));
  SELF.lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname OR SALT311.HyphenMatch(le.lname,ri.lname,1)<=1  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT311.Fn_Fail_Scale(AVE(le.lname_weight100,ri.lname_weight100),s.lname_switch));
  SELF.left_address_ind := le.address_ind;
  SELF.right_address_ind := ri.address_ind;
  SELF.address_ind_match_code := MAP(
                        le.address_ind_isnull OR ri.address_ind_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_address_ind(le.address_ind,ri.address_ind));
  SELF.address_ind_score := MAP(
                        le.address_ind_isnull OR ri.address_ind_isnull => 0,
                        le.address_ind = ri.address_ind  => le.address_ind_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.address_ind_weight100,ri.address_ind_weight100),s.address_ind_switch));
  SELF.left_name_ind := le.name_ind;
  SELF.right_name_ind := ri.name_ind;
  SELF.name_ind_match_code := MAP(
                        le.name_ind_isnull OR ri.name_ind_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_name_ind(le.name_ind,ri.name_ind));
  SELF.name_ind_score := MAP(
                        le.name_ind_isnull OR ri.name_ind_isnull => 0,
                        le.name_ind = ri.name_ind  => le.name_ind_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.name_ind_weight100,ri.name_ind_weight100),s.name_ind_switch));
  SELF.left_persistent_record_id := le.persistent_record_id;
  SELF.right_persistent_record_id := ri.persistent_record_id;
  SELF.persistent_record_id_match_code := MAP(
                        le.persistent_record_id_isnull OR ri.persistent_record_id_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_persistent_record_id(le.persistent_record_id,ri.persistent_record_id));
  SELF.persistent_record_id_score := MAP(
                        le.persistent_record_id_isnull OR ri.persistent_record_id_isnull => 0,
                        le.persistent_record_id = ri.persistent_record_id  => le.persistent_record_id_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.persistent_record_id_weight100,ri.persistent_record_id_weight100),s.persistent_record_id_switch));
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT311.ClipScore(MAX(address_score_pre,0) + self.prim_range_score + self.predir_score + self.prim_name_score + self.suffix_score + self.postdir_score + self.unit_desig_score + self.sec_range_score + self.city_name_score + self.st_score + self.zip_score + self.zip4_score + self.tnt_score + self.rawaid_score + self.dt_first_seen_score + self.dt_last_seen_score + self.dt_vendor_first_reported_score + self.dt_vendor_last_reported_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := address_score_res;
// Compute the score for the concept ssnum
  INTEGER2 ssnum_score_ext := SALT311.ClipScore(MAX(ssnum_score_pre,0) + self.ssn_score + self.valid_ssn_score);// Score in surrounding context
  INTEGER2 ssnum_score_res := MAX(0,ssnum_score_pre); // At least nothing
  SELF.ssnum_score := ssnum_score_res;
  // Get propagation scores for individual propagated fields
  SELF.fname_score_prop := (MAX(le.fname_prop,ri.fname_prop)/MAX(LENGTH(TRIM(le.fname)),LENGTH(TRIM(ri.fname))))*SELF.fname_score; // Proportion of longest string propogated
  SELF.mname_score_prop := (MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*SELF.mname_score; // Proportion of longest string propogated
  SELF.Conf_Prop := (0 + SELF.fname_score_prop + SELF.mname_score_prop) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.src_score + IF(SELF.address_score>0,MAX(SELF.address_score,SELF.prim_range_score + SELF.predir_score + SELF.prim_name_score + SELF.suffix_score + SELF.postdir_score + SELF.unit_desig_score + SELF.sec_range_score + SELF.city_name_score + SELF.st_score + SELF.zip_score + SELF.zip4_score + SELF.tnt_score + SELF.rawaid_score + SELF.dt_first_seen_score + SELF.dt_last_seen_score + SELF.dt_vendor_first_reported_score + SELF.dt_vendor_last_reported_score),SELF.prim_range_score + SELF.predir_score + SELF.prim_name_score + SELF.suffix_score + SELF.postdir_score + SELF.unit_desig_score + SELF.sec_range_score + SELF.city_name_score + SELF.st_score + SELF.zip_score + SELF.zip4_score + SELF.tnt_score + SELF.rawaid_score + SELF.dt_first_seen_score + SELF.dt_last_seen_score + SELF.dt_vendor_first_reported_score + SELF.dt_vendor_last_reported_score) + SELF.name_suffix_score + SELF.dt_nonglb_last_seen_score + IF(SELF.ssnum_score>0,MAX(SELF.ssnum_score,SELF.ssn_score + SELF.valid_ssn_score),SELF.ssn_score + SELF.valid_ssn_score) + SELF.dodgy_tracking_score + SELF.pflag1_score + SELF.pflag2_score + SELF.jflag2_score + SELF.jflag3_score + SELF.jflag1_score + SELF.phone_score + SELF.dob_score + SELF.rec_type_score + SELF.pflag3_score + SELF.title_score + SELF.fname_score + SELF.mname_score + SELF.lname_score + SELF.address_ind_score + SELF.name_ind_score + SELF.persistent_record_id_score) / 100 + outside;
END;

EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.did = RIGHT.did1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.did2 = RIGHT.did,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(rid1 <> rid2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN d;
END;

EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rid known
  j1 := JOIN(in_data,im,LEFT.rid = RIGHT.rid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rid2 = RIGHT.rid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;


EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT311.UIDType BaseRecord) := FUNCTION//Faster form when rid known
  j1 := in_data(rid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;

EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rid1=RIGHT.rid1 AND LEFT.rid2=RIGHT.rid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType did;
  DATASET(SALT311.Layout_FieldValueList) src_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) address_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dt_nonglb_last_seen_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) ssnum_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dodgy_tracking_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) pflag1_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) pflag2_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) jflag2_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) jflag3_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) jflag1_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) phone_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dob_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) rec_type_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) pflag3_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) title_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) fname_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) mname_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) lname_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) address_ind_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) name_ind_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) persistent_record_id_Values := DATASET([],SALT311.Layout_FieldValueList);
END;

SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.did := le.did;
    SELF.src_values := SALT311.fn_combine_fieldvaluelist(le.src_values,ri.src_values);
    SELF.address_values := SALT311.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
    SELF.name_suffix_values := SALT311.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.dt_nonglb_last_seen_values := SALT311.fn_combine_fieldvaluelist(le.dt_nonglb_last_seen_values,ri.dt_nonglb_last_seen_values);
    SELF.ssnum_values := SALT311.fn_combine_fieldvaluelist(le.ssnum_values,ri.ssnum_values);
    SELF.dodgy_tracking_values := SALT311.fn_combine_fieldvaluelist(le.dodgy_tracking_values,ri.dodgy_tracking_values);
    SELF.pflag1_values := SALT311.fn_combine_fieldvaluelist(le.pflag1_values,ri.pflag1_values);
    SELF.pflag2_values := SALT311.fn_combine_fieldvaluelist(le.pflag2_values,ri.pflag2_values);
    SELF.jflag2_values := SALT311.fn_combine_fieldvaluelist(le.jflag2_values,ri.jflag2_values);
    SELF.jflag3_values := SALT311.fn_combine_fieldvaluelist(le.jflag3_values,ri.jflag3_values);
    SELF.jflag1_values := SALT311.fn_combine_fieldvaluelist(le.jflag1_values,ri.jflag1_values);
    SELF.phone_values := SALT311.fn_combine_fieldvaluelist(le.phone_values,ri.phone_values);
    SELF.dob_values := SALT311.fn_combine_fieldvaluelist(le.dob_values,ri.dob_values);
    SELF.rec_type_values := SALT311.fn_combine_fieldvaluelist(le.rec_type_values,ri.rec_type_values);
    SELF.pflag3_values := SALT311.fn_combine_fieldvaluelist(le.pflag3_values,ri.pflag3_values);
    SELF.title_values := SALT311.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
    SELF.fname_values := SALT311.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
    SELF.mname_values := SALT311.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
    SELF.lname_values := SALT311.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
    SELF.address_ind_values := SALT311.fn_combine_fieldvaluelist(le.address_ind_values,ri.address_ind_values);
    SELF.name_ind_values := SALT311.fn_combine_fieldvaluelist(le.name_ind_values,ri.name_ind_values);
    SELF.persistent_record_id_values := SALT311.fn_combine_fieldvaluelist(le.persistent_record_id_values,ri.persistent_record_id_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(did) ), did, LOCAL ), LEFT.did = RIGHT.did, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.did := le.did;
    SELF.src_values := SORT(le.src_values, -cnt, val, LOCAL);
    SELF.address_values := SORT(le.address_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.dt_nonglb_last_seen_values := SORT(le.dt_nonglb_last_seen_values, -cnt, val, LOCAL);
    SELF.ssnum_values := SORT(le.ssnum_values, -cnt, val, LOCAL);
    SELF.dodgy_tracking_values := SORT(le.dodgy_tracking_values, -cnt, val, LOCAL);
    SELF.pflag1_values := SORT(le.pflag1_values, -cnt, val, LOCAL);
    SELF.pflag2_values := SORT(le.pflag2_values, -cnt, val, LOCAL);
    SELF.jflag2_values := SORT(le.jflag2_values, -cnt, val, LOCAL);
    SELF.jflag3_values := SORT(le.jflag3_values, -cnt, val, LOCAL);
    SELF.jflag1_values := SORT(le.jflag1_values, -cnt, val, LOCAL);
    SELF.phone_values := SORT(le.phone_values, -cnt, val, LOCAL);
    SELF.dob_values := SORT(le.dob_values, -cnt, val, LOCAL);
    SELF.rec_type_values := SORT(le.rec_type_values, -cnt, val, LOCAL);
    SELF.pflag3_values := SORT(le.pflag3_values, -cnt, val, LOCAL);
    SELF.title_values := SORT(le.title_values, -cnt, val, LOCAL);
    SELF.fname_values := SORT(le.fname_values, -cnt, val, LOCAL);
    SELF.mname_values := SORT(le.mname_values, -cnt, val, LOCAL);
    SELF.lname_values := SORT(le.lname_values, -cnt, val, LOCAL);
    SELF.address_ind_values := SORT(le.address_ind_values, -cnt, val, LOCAL);
    SELF.name_ind_values := SORT(le.name_ind_values, -cnt, val, LOCAL);
    SELF.persistent_record_id_values := SORT(le.persistent_record_id_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;

EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION

Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.did := le.did;
  SELF.src_Values := IF ( (le.src  IN SET(s.nulls_src,src) OR le.src = (TYPEOF(le.src))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.src)}],SALT311.Layout_FieldValueList));
  SELF.address_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.predir  IN SET(s.nulls_predir,predir) OR le.predir = (TYPEOF(le.predir))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.suffix  IN SET(s.nulls_suffix,suffix) OR le.suffix = (TYPEOF(le.suffix))'') AND (le.postdir  IN SET(s.nulls_postdir,postdir) OR le.postdir = (TYPEOF(le.postdir))'') AND (le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR le.unit_desig = (TYPEOF(le.unit_desig))'') AND (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))'') AND (le.city_name  IN SET(s.nulls_city_name,city_name) OR le.city_name = (TYPEOF(le.city_name))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'') AND (le.zip4  IN SET(s.nulls_zip4,zip4) OR le.zip4 = (TYPEOF(le.zip4))'') AND (le.tnt  IN SET(s.nulls_tnt,tnt) OR le.tnt = (TYPEOF(le.tnt))'') AND (le.rawaid  IN SET(s.nulls_rawaid,rawaid) OR le.rawaid = (TYPEOF(le.rawaid))'') AND (le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR le.dt_first_seen = (TYPEOF(le.dt_first_seen))'') AND (le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR le.dt_last_seen = (TYPEOF(le.dt_last_seen))'') AND (le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR le.dt_vendor_first_reported = (TYPEOF(le.dt_vendor_first_reported))'') AND (le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR le.dt_vendor_last_reported = (TYPEOF(le.dt_vendor_last_reported))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.prim_range) + ' ' + TRIM((SALT311.StrType)le.predir) + ' ' + TRIM((SALT311.StrType)le.prim_name) + ' ' + TRIM((SALT311.StrType)le.suffix) + ' ' + TRIM((SALT311.StrType)le.postdir) + ' ' + TRIM((SALT311.StrType)le.unit_desig) + ' ' + TRIM((SALT311.StrType)le.sec_range) + ' ' + TRIM((SALT311.StrType)le.city_name) + ' ' + TRIM((SALT311.StrType)le.st) + ' ' + TRIM((SALT311.StrType)le.zip) + ' ' + TRIM((SALT311.StrType)le.zip4) + ' ' + TRIM((SALT311.StrType)le.tnt) + ' ' + TRIM((SALT311.StrType)le.rawaid) + ' ' + TRIM((SALT311.StrType)le.dt_first_seen) + ' ' + TRIM((SALT311.StrType)le.dt_last_seen) + ' ' + TRIM((SALT311.StrType)le.dt_vendor_first_reported) + ' ' + TRIM((SALT311.StrType)le.dt_vendor_last_reported)}],SALT311.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.name_suffix)}],SALT311.Layout_FieldValueList));
  SELF.dt_nonglb_last_seen_Values := IF ( (le.dt_nonglb_last_seen  IN SET(s.nulls_dt_nonglb_last_seen,dt_nonglb_last_seen) OR le.dt_nonglb_last_seen = (TYPEOF(le.dt_nonglb_last_seen))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dt_nonglb_last_seen)}],SALT311.Layout_FieldValueList));
  SELF.ssnum_Values := IF ( (le.ssn  IN SET(s.nulls_ssn,ssn) OR le.ssn = (TYPEOF(le.ssn))'') AND (le.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR le.valid_ssn = (TYPEOF(le.valid_ssn))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.ssn) + ' ' + TRIM((SALT311.StrType)le.valid_ssn)}],SALT311.Layout_FieldValueList));
  SELF.dodgy_tracking_Values := IF ( (le.dodgy_tracking  IN SET(s.nulls_dodgy_tracking,dodgy_tracking) OR le.dodgy_tracking = (TYPEOF(le.dodgy_tracking))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dodgy_tracking)}],SALT311.Layout_FieldValueList));
  SELF.pflag1_Values := IF ( (le.pflag1  IN SET(s.nulls_pflag1,pflag1) OR le.pflag1 = (TYPEOF(le.pflag1))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag1)}],SALT311.Layout_FieldValueList));
  SELF.pflag2_Values := IF ( (le.pflag2  IN SET(s.nulls_pflag2,pflag2) OR le.pflag2 = (TYPEOF(le.pflag2))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag2)}],SALT311.Layout_FieldValueList));
  SELF.jflag2_Values := IF ( (le.jflag2  IN SET(s.nulls_jflag2,jflag2) OR le.jflag2 = (TYPEOF(le.jflag2))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag2)}],SALT311.Layout_FieldValueList));
  SELF.jflag3_Values := IF ( (le.jflag3  IN SET(s.nulls_jflag3,jflag3) OR le.jflag3 = (TYPEOF(le.jflag3))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag3)}],SALT311.Layout_FieldValueList));
  SELF.jflag1_Values := IF ( (le.jflag1  IN SET(s.nulls_jflag1,jflag1) OR le.jflag1 = (TYPEOF(le.jflag1))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag1)}],SALT311.Layout_FieldValueList));
  SELF.phone_Values := IF ( (le.phone  IN SET(s.nulls_phone,phone) OR le.phone = (TYPEOF(le.phone))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.phone)}],SALT311.Layout_FieldValueList));
  SELF.dob_Values := IF ( (le.dob  IN SET(s.nulls_dob,dob) OR le.dob = (TYPEOF(le.dob))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dob)}],SALT311.Layout_FieldValueList));
  SELF.rec_type_Values := IF ( (le.rec_type  IN SET(s.nulls_rec_type,rec_type) OR le.rec_type = (TYPEOF(le.rec_type))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.rec_type)}],SALT311.Layout_FieldValueList));
  SELF.pflag3_Values := IF ( (le.pflag3  IN SET(s.nulls_pflag3,pflag3) OR le.pflag3 = (TYPEOF(le.pflag3))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag3)}],SALT311.Layout_FieldValueList));
  SELF.title_Values := IF ( (le.title  IN SET(s.nulls_title,title) OR le.title = (TYPEOF(le.title))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.title)}],SALT311.Layout_FieldValueList));
  SELF.fname_Values := IF ( (le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.fname)}],SALT311.Layout_FieldValueList));
  SELF.mname_Values := IF ( (le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.mname)}],SALT311.Layout_FieldValueList));
  SELF.lname_Values := IF ( (le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.lname)}],SALT311.Layout_FieldValueList));
  SELF.address_ind_Values := IF ( (le.address_ind  IN SET(s.nulls_address_ind,address_ind) OR le.address_ind = (TYPEOF(le.address_ind))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.address_ind)}],SALT311.Layout_FieldValueList));
  SELF.name_ind_Values := IF ( (le.name_ind  IN SET(s.nulls_name_ind,name_ind) OR le.name_ind = (TYPEOF(le.name_ind))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.name_ind)}],SALT311.Layout_FieldValueList));
  SELF.persistent_record_id_Values := IF ( (le.persistent_record_id  IN SET(s.nulls_persistent_record_id,persistent_record_id) OR le.persistent_record_id = (TYPEOF(le.persistent_record_id))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.persistent_record_id)}],SALT311.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;

Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.did := le.did;
  SELF.src_Values := IF ( (le.src  IN SET(s.nulls_src,src) OR le.src = (TYPEOF(le.src))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.src)}],SALT311.Layout_FieldValueList));
  SELF.address_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.predir  IN SET(s.nulls_predir,predir) OR le.predir = (TYPEOF(le.predir))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.suffix  IN SET(s.nulls_suffix,suffix) OR le.suffix = (TYPEOF(le.suffix))'') AND (le.postdir  IN SET(s.nulls_postdir,postdir) OR le.postdir = (TYPEOF(le.postdir))'') AND (le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR le.unit_desig = (TYPEOF(le.unit_desig))'') AND (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))'') AND (le.city_name  IN SET(s.nulls_city_name,city_name) OR le.city_name = (TYPEOF(le.city_name))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))'') AND (le.zip4  IN SET(s.nulls_zip4,zip4) OR le.zip4 = (TYPEOF(le.zip4))'') AND (le.tnt  IN SET(s.nulls_tnt,tnt) OR le.tnt = (TYPEOF(le.tnt))'') AND (le.rawaid  IN SET(s.nulls_rawaid,rawaid) OR le.rawaid = (TYPEOF(le.rawaid))'') AND (le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR le.dt_first_seen = (TYPEOF(le.dt_first_seen))'') AND (le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR le.dt_last_seen = (TYPEOF(le.dt_last_seen))'') AND (le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR le.dt_vendor_first_reported = (TYPEOF(le.dt_vendor_first_reported))'') AND (le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR le.dt_vendor_last_reported = (TYPEOF(le.dt_vendor_last_reported))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.prim_range) + ' ' + TRIM((SALT311.StrType)le.predir) + ' ' + TRIM((SALT311.StrType)le.prim_name) + ' ' + TRIM((SALT311.StrType)le.suffix) + ' ' + TRIM((SALT311.StrType)le.postdir) + ' ' + TRIM((SALT311.StrType)le.unit_desig) + ' ' + TRIM((SALT311.StrType)le.sec_range) + ' ' + TRIM((SALT311.StrType)le.city_name) + ' ' + TRIM((SALT311.StrType)le.st) + ' ' + TRIM((SALT311.StrType)le.zip) + ' ' + TRIM((SALT311.StrType)le.zip4) + ' ' + TRIM((SALT311.StrType)le.tnt) + ' ' + TRIM((SALT311.StrType)le.rawaid) + ' ' + TRIM((SALT311.StrType)le.dt_first_seen) + ' ' + TRIM((SALT311.StrType)le.dt_last_seen) + ' ' + TRIM((SALT311.StrType)le.dt_vendor_first_reported) + ' ' + TRIM((SALT311.StrType)le.dt_vendor_last_reported)}],SALT311.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR le.name_suffix = (TYPEOF(le.name_suffix))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.name_suffix)}],SALT311.Layout_FieldValueList));
  SELF.dt_nonglb_last_seen_Values := IF ( (le.dt_nonglb_last_seen  IN SET(s.nulls_dt_nonglb_last_seen,dt_nonglb_last_seen) OR le.dt_nonglb_last_seen = (TYPEOF(le.dt_nonglb_last_seen))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dt_nonglb_last_seen)}],SALT311.Layout_FieldValueList));
  SELF.ssnum_Values := IF ( (le.ssn  IN SET(s.nulls_ssn,ssn) OR le.ssn = (TYPEOF(le.ssn))'') AND (le.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR le.valid_ssn = (TYPEOF(le.valid_ssn))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.ssn) + ' ' + TRIM((SALT311.StrType)le.valid_ssn)}],SALT311.Layout_FieldValueList));
  SELF.dodgy_tracking_Values := IF ( (le.dodgy_tracking  IN SET(s.nulls_dodgy_tracking,dodgy_tracking) OR le.dodgy_tracking = (TYPEOF(le.dodgy_tracking))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dodgy_tracking)}],SALT311.Layout_FieldValueList));
  SELF.pflag1_Values := IF ( (le.pflag1  IN SET(s.nulls_pflag1,pflag1) OR le.pflag1 = (TYPEOF(le.pflag1))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag1)}],SALT311.Layout_FieldValueList));
  SELF.pflag2_Values := IF ( (le.pflag2  IN SET(s.nulls_pflag2,pflag2) OR le.pflag2 = (TYPEOF(le.pflag2))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag2)}],SALT311.Layout_FieldValueList));
  SELF.jflag2_Values := IF ( (le.jflag2  IN SET(s.nulls_jflag2,jflag2) OR le.jflag2 = (TYPEOF(le.jflag2))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag2)}],SALT311.Layout_FieldValueList));
  SELF.jflag3_Values := IF ( (le.jflag3  IN SET(s.nulls_jflag3,jflag3) OR le.jflag3 = (TYPEOF(le.jflag3))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag3)}],SALT311.Layout_FieldValueList));
  SELF.jflag1_Values := IF ( (le.jflag1  IN SET(s.nulls_jflag1,jflag1) OR le.jflag1 = (TYPEOF(le.jflag1))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.jflag1)}],SALT311.Layout_FieldValueList));
  SELF.phone_Values := IF ( (le.phone  IN SET(s.nulls_phone,phone) OR le.phone = (TYPEOF(le.phone))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.phone)}],SALT311.Layout_FieldValueList));
  SELF.dob_Values := IF ( (le.dob  IN SET(s.nulls_dob,dob) OR le.dob = (TYPEOF(le.dob))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.dob)}],SALT311.Layout_FieldValueList));
  SELF.rec_type_Values := IF ( (le.rec_type  IN SET(s.nulls_rec_type,rec_type) OR le.rec_type = (TYPEOF(le.rec_type))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.rec_type)}],SALT311.Layout_FieldValueList));
  SELF.pflag3_Values := IF ( (le.pflag3  IN SET(s.nulls_pflag3,pflag3) OR le.pflag3 = (TYPEOF(le.pflag3))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.pflag3)}],SALT311.Layout_FieldValueList));
  SELF.title_Values := IF ( (le.title  IN SET(s.nulls_title,title) OR le.title = (TYPEOF(le.title))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.title)}],SALT311.Layout_FieldValueList));
  SELF.fname_Values := IF ( (le.fname  IN SET(s.nulls_fname,fname) OR le.fname = (TYPEOF(le.fname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.fname)}],SALT311.Layout_FieldValueList));
  SELF.mname_Values := IF ( (le.mname  IN SET(s.nulls_mname,mname) OR le.mname = (TYPEOF(le.mname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.mname)}],SALT311.Layout_FieldValueList));
  SELF.lname_Values := IF ( (le.lname  IN SET(s.nulls_lname,lname) OR le.lname = (TYPEOF(le.lname))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.lname)}],SALT311.Layout_FieldValueList));
  SELF.address_ind_Values := IF ( (le.address_ind  IN SET(s.nulls_address_ind,address_ind) OR le.address_ind = (TYPEOF(le.address_ind))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.address_ind)}],SALT311.Layout_FieldValueList));
  SELF.name_ind_Values := IF ( (le.name_ind  IN SET(s.nulls_name_ind,name_ind) OR le.name_ind = (TYPEOF(le.name_ind))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.name_ind)}],SALT311.Layout_FieldValueList));
  SELF.persistent_record_id_Values := IF ( (le.persistent_record_id  IN SET(s.nulls_persistent_record_id,persistent_record_id) OR le.persistent_record_id = (TYPEOF(le.persistent_record_id))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.persistent_record_id)}],SALT311.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION

  im rem(im le) := TRANSFORM
    self.fname := le.fname[1..LENGTH(TRIM(le.fname))-le.fname_prop]; // Clip propogated chars
    self.fname_isnull := self.fname='' OR le.fname_isnull;
    self.fname_prop := 0; // Avoid reducing score later
    self.mname := le.mname[1..LENGTH(TRIM(le.mname))-le.mname_prop]; // Clip propogated chars
    self.mname_isnull := self.mname='' OR le.mname_isnull;
    self.mname_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 src_size := 0;
  UNSIGNED1 address_size := 0;
  UNSIGNED1 name_suffix_size := 0;
  UNSIGNED1 dt_nonglb_last_seen_size := 0;
  UNSIGNED1 ssnum_size := 0;
  UNSIGNED1 dodgy_tracking_size := 0;
  UNSIGNED1 pflag1_size := 0;
  UNSIGNED1 pflag2_size := 0;
  UNSIGNED1 jflag2_size := 0;
  UNSIGNED1 jflag3_size := 0;
  UNSIGNED1 jflag1_size := 0;
  UNSIGNED1 phone_size := 0;
  UNSIGNED1 dob_size := 0;
  UNSIGNED1 rec_type_size := 0;
  UNSIGNED1 pflag3_size := 0;
  UNSIGNED1 title_size := 0;
  UNSIGNED1 fname_size := 0;
  UNSIGNED1 mname_size := 0;
  UNSIGNED1 lname_size := 0;
  UNSIGNED1 address_ind_size := 0;
  UNSIGNED1 name_ind_size := 0;
  UNSIGNED1 persistent_record_id_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.src_size := SALT311.Fn_SwitchSpec(s.src_switch,count(le.src_values));
  SELF.address_size := SALT311.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF.name_suffix_size := SALT311.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF.dt_nonglb_last_seen_size := SALT311.Fn_SwitchSpec(s.dt_nonglb_last_seen_switch,count(le.dt_nonglb_last_seen_values));
  SELF.ssnum_size := SALT311.Fn_SwitchSpec(s.ssnum_switch,count(le.ssnum_values));
  SELF.dodgy_tracking_size := SALT311.Fn_SwitchSpec(s.dodgy_tracking_switch,count(le.dodgy_tracking_values));
  SELF.pflag1_size := SALT311.Fn_SwitchSpec(s.pflag1_switch,count(le.pflag1_values));
  SELF.pflag2_size := SALT311.Fn_SwitchSpec(s.pflag2_switch,count(le.pflag2_values));
  SELF.jflag2_size := SALT311.Fn_SwitchSpec(s.jflag2_switch,count(le.jflag2_values));
  SELF.jflag3_size := SALT311.Fn_SwitchSpec(s.jflag3_switch,count(le.jflag3_values));
  SELF.jflag1_size := SALT311.Fn_SwitchSpec(s.jflag1_switch,count(le.jflag1_values));
  SELF.phone_size := SALT311.Fn_SwitchSpec(s.phone_switch,count(le.phone_values));
  SELF.dob_size := SALT311.Fn_SwitchSpec(s.dob_switch,count(le.dob_values));
  SELF.rec_type_size := SALT311.Fn_SwitchSpec(s.rec_type_switch,count(le.rec_type_values));
  SELF.pflag3_size := SALT311.Fn_SwitchSpec(s.pflag3_switch,count(le.pflag3_values));
  SELF.title_size := SALT311.Fn_SwitchSpec(s.title_switch,count(le.title_values));
  SELF.fname_size := SALT311.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.mname_size := SALT311.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.lname_size := SALT311.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.address_ind_size := SALT311.Fn_SwitchSpec(s.address_ind_switch,count(le.address_ind_values));
  SELF.name_ind_size := SALT311.Fn_SwitchSpec(s.name_ind_switch,count(le.name_ind_values));
  SELF.persistent_record_id_size := SALT311.Fn_SwitchSpec(s.persistent_record_id_switch,count(le.persistent_record_id_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.src_size+t.address_size+t.name_suffix_size+t.dt_nonglb_last_seen_size+t.ssnum_size+t.dodgy_tracking_size+t.pflag1_size+t.pflag2_size+t.jflag2_size+t.jflag3_size+t.jflag1_size+t.phone_size+t.dob_size+t.rec_type_size+t.pflag3_size+t.title_size+t.fname_size+t.mname_size+t.lname_size+t.address_ind_size+t.name_ind_size+t.persistent_record_id_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
