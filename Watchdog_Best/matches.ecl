// Begin code to perform the matching itself

IMPORT Watchdog_Best; // Import modules for  attribute definitions
IMPORT SALT311,std;
EXPORT matches(DATASET(layout_Hdr) ih, UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED IntraMatchThreshold := LowerMatchThreshold - Config.SliceDistance;
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];

SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.did1 := le.did;
  SELF.did2 := ri.did;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  INTEGER2 src_score := MAP(
                        le.src_isnull OR ri.src_isnull => 0,
                        le.src = ri.src  => le.src_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.src_weight100,ri.src_weight100),s.src_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.predir_weight100 + ri.predir_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.suffix_weight100 + ri.suffix_weight100 + le.postdir_weight100 + ri.postdir_weight100 + le.unit_desig_weight100 + ri.unit_desig_weight100 + le.sec_range_weight100 + ri.sec_range_weight100 + le.city_name_weight100 + ri.city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100 + le.zip4_weight100 + ri.zip4_weight100 + le.tnt_weight100 + ri.tnt_weight100 + le.rawaid_weight100 + ri.rawaid_weight100 + le.dt_first_seen_weight100 + ri.dt_first_seen_weight100 + le.dt_last_seen_weight100 + ri.dt_last_seen_weight100 + le.dt_vendor_first_reported_weight100 + ri.dt_vendor_first_reported_weight100 + le.dt_vendor_last_reported_weight100 + ri.dt_vendor_last_reported_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.city_name_isnull AND le.st_isnull AND le.zip_isnull AND le.zip4_isnull AND le.tnt_isnull AND le.rawaid_isnull AND le.dt_first_seen_isnull AND le.dt_last_seen_isnull AND le.dt_vendor_first_reported_isnull AND le.dt_vendor_last_reported_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.city_name_isnull AND ri.st_isnull AND ri.zip_isnull AND ri.zip4_isnull AND ri.tnt_isnull AND ri.rawaid_isnull AND ri.dt_first_seen_isnull AND ri.dt_last_seen_isnull AND ri.dt_vendor_first_reported_isnull AND ri.dt_vendor_last_reported_isnull) => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 rawaid_score := MAP(
                        le.rawaid_isnull OR ri.rawaid_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.rawaid = ri.rawaid  => le.rawaid_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.rawaid_weight100,ri.rawaid_weight100),s.rawaid_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_name_weight100,ri.prim_name_weight100),s.prim_name_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip_weight100,ri.zip_weight100),s.zip_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip4_score := MAP(
                        le.zip4_isnull OR ri.zip4_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip4_weight100,ri.zip4_weight100),s.zip4_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_weight100,ri.prim_range_weight100),s.prim_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 city_name_score := MAP(
                        le.city_name_isnull OR ri.city_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.city_name = ri.city_name  => le.city_name_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.city_name_weight100,ri.city_name_weight100),s.city_name_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_weight100,ri.sec_range_weight100),s.sec_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 tnt_score := MAP(
                        le.tnt_isnull OR ri.tnt_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.tnt = ri.tnt  => le.tnt_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.tnt_weight100,ri.tnt_weight100),s.tnt_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 name_suffix_score := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.name_suffix_weight100,ri.name_suffix_weight100),s.name_suffix_switch));
  INTEGER2 dt_nonglb_last_seen_score := MAP(
                        le.dt_nonglb_last_seen_isnull OR ri.dt_nonglb_last_seen_isnull => 0,
                        le.dt_nonglb_last_seen = ri.dt_nonglb_last_seen  => le.dt_nonglb_last_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_nonglb_last_seen_weight100,ri.dt_nonglb_last_seen_weight100),s.dt_nonglb_last_seen_switch));
  INTEGER2 dt_first_seen_score := MAP(
                        le.dt_first_seen_isnull OR ri.dt_first_seen_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_first_seen_weight100,ri.dt_first_seen_weight100),s.dt_first_seen_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 postdir_score := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.postdir_weight100,ri.postdir_weight100),s.postdir_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 dt_last_seen_score := MAP(
                        le.dt_last_seen_isnull OR ri.dt_last_seen_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_last_seen_weight100,ri.dt_last_seen_weight100),s.dt_last_seen_switch))*IF(address_score_scale=0,1,address_score_scale);
  REAL ssnum_score_scale := ( le.ssnum_weight100 + ri.ssnum_weight100 ) / (le.ssn_weight100 + ri.ssn_weight100 + le.valid_ssn_weight100 + ri.valid_ssn_weight100); // Scaling factor for this concept
  INTEGER2 ssnum_score_pre := MAP( (le.ssnum_isnull OR le.ssn_isnull AND le.valid_ssn_isnull) OR (ri.ssnum_isnull OR ri.ssn_isnull AND ri.valid_ssn_isnull) => 0,
                        le.ssnum = ri.ssnum  => le.ssnum_weight100,
                        0);
  INTEGER2 dodgy_tracking_score := MAP(
                        le.dodgy_tracking_isnull OR ri.dodgy_tracking_isnull => 0,
                        le.dodgy_tracking = ri.dodgy_tracking  => le.dodgy_tracking_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dodgy_tracking_weight100,ri.dodgy_tracking_weight100),s.dodgy_tracking_switch));
  INTEGER2 dt_vendor_first_reported_score := MAP(
                        le.dt_vendor_first_reported_isnull OR ri.dt_vendor_first_reported_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_vendor_first_reported_weight100,ri.dt_vendor_first_reported_weight100),s.dt_vendor_first_reported_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 dt_vendor_last_reported_score := MAP(
                        le.dt_vendor_last_reported_isnull OR ri.dt_vendor_last_reported_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dt_vendor_last_reported_weight100,ri.dt_vendor_last_reported_weight100),s.dt_vendor_last_reported_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.st_weight100,ri.st_weight100),s.st_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 pflag1_score := MAP(
                        le.pflag1_isnull OR ri.pflag1_isnull => 0,
                        le.pflag1 = ri.pflag1  => le.pflag1_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag1_weight100,ri.pflag1_weight100),s.pflag1_switch));
  INTEGER2 pflag2_score := MAP(
                        le.pflag2_isnull OR ri.pflag2_isnull => 0,
                        le.pflag2 = ri.pflag2  => le.pflag2_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag2_weight100,ri.pflag2_weight100),s.pflag2_switch));
  INTEGER2 predir_score := MAP(
                        le.predir_isnull OR ri.predir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.predir_weight100,ri.predir_weight100),s.predir_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 jflag2_score := MAP(
                        le.jflag2_isnull OR ri.jflag2_isnull => 0,
                        le.jflag2 = ri.jflag2  => le.jflag2_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag2_weight100,ri.jflag2_weight100),s.jflag2_switch));
  INTEGER2 suffix_score := MAP(
                        le.suffix_isnull OR ri.suffix_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.suffix = ri.suffix  => le.suffix_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.suffix_weight100,ri.suffix_weight100),s.suffix_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 unit_desig_score := MAP(
                        le.unit_desig_isnull OR ri.unit_desig_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.unit_desig_weight100,ri.unit_desig_weight100),s.unit_desig_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 jflag3_score := MAP(
                        le.jflag3_isnull OR ri.jflag3_isnull => 0,
                        le.jflag3 = ri.jflag3  => le.jflag3_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag3_weight100,ri.jflag3_weight100),s.jflag3_switch));
  INTEGER2 jflag1_score := MAP(
                        le.jflag1_isnull OR ri.jflag1_isnull => 0,
                        le.jflag1 = ri.jflag1  => le.jflag1_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.jflag1_weight100,ri.jflag1_weight100),s.jflag1_switch));
  INTEGER2 valid_ssn_score := MAP(
                        le.valid_ssn_isnull OR ri.valid_ssn_isnull => 0,
                        ssnum_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.valid_ssn = ri.valid_ssn  => le.valid_ssn_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.valid_ssn_weight100,ri.valid_ssn_weight100),s.valid_ssn_switch))*IF(ssnum_score_scale=0,1,ssnum_score_scale);
  INTEGER2 phone_score := MAP(
                        le.phone_isnull OR ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        Config.WithinEditN(le.phone,le.phone_len,ri.phone,ri.phone_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.phone_weight100,le.phone_cnt, le.phone_e1_cnt,ri.phone_weight100,ri.phone_cnt,ri.phone_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.phone_weight100,ri.phone_weight100),s.phone_switch));
  INTEGER2 ssn_score := MAP(
                        le.ssn_isnull OR ri.ssn_isnull => 0,
                        ssnum_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ssn = ri.ssn  => le.ssn_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ssn_weight100,ri.ssn_weight100),s.ssn_switch))*IF(ssnum_score_scale=0,1,ssnum_score_scale);
  INTEGER2 dob_score := MAP(
                        le.dob_isnull OR ri.dob_isnull => 0,
                        le.dob = ri.dob  => le.dob_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.dob_weight100,ri.dob_weight100),s.dob_switch));
  INTEGER2 rec_type_score := MAP(
                        le.rec_type_isnull OR ri.rec_type_isnull => 0,
                        le.rec_type = ri.rec_type  => le.rec_type_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.rec_type_weight100,ri.rec_type_weight100),s.rec_type_switch));
  INTEGER2 pflag3_score := MAP(
                        le.pflag3_isnull OR ri.pflag3_isnull => 0,
                        le.pflag3 = ri.pflag3  => le.pflag3_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.pflag3_weight100,ri.pflag3_weight100),s.pflag3_switch));
  INTEGER2 title_score := MAP(
                        le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.title_weight100,ri.title_weight100),s.title_switch));
  INTEGER2 fname_score := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.fname_weight100,ri.fname_weight100),s.fname_switch));
  INTEGER2 mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.mname,le.mname_len,ri.mname,ri.mname_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.mname_weight100,ri.mname_weight100),s.mname_switch));
  INTEGER2 lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname OR SALT311.HyphenMatch(le.lname,ri.lname,1)<=1  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT311.Fn_Fail_Scale(AVE(le.lname_weight100,ri.lname_weight100),s.lname_switch));
  INTEGER2 address_ind_score := MAP(
                        le.address_ind_isnull OR ri.address_ind_isnull => 0,
                        le.address_ind = ri.address_ind  => le.address_ind_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.address_ind_weight100,ri.address_ind_weight100),s.address_ind_switch));
  INTEGER2 name_ind_score := MAP(
                        le.name_ind_isnull OR ri.name_ind_isnull => 0,
                        le.name_ind = ri.name_ind  => le.name_ind_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.name_ind_weight100,ri.name_ind_weight100),s.name_ind_switch));
  INTEGER2 persistent_record_id_score := MAP(
                        le.persistent_record_id_isnull OR ri.persistent_record_id_isnull => 0,
                        le.persistent_record_id = ri.persistent_record_id  => le.persistent_record_id_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.persistent_record_id_weight100,ri.persistent_record_id_weight100),s.persistent_record_id_switch));
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT311.ClipScore(MAX(address_score_pre,0) + prim_range_score + predir_score + prim_name_score + suffix_score + postdir_score + unit_desig_score + sec_range_score + city_name_score + st_score + zip_score + zip4_score + tnt_score + rawaid_score + dt_first_seen_score + dt_last_seen_score + dt_vendor_first_reported_score + dt_vendor_last_reported_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := address_score_res;
// Compute the score for the concept ssnum
  INTEGER2 ssnum_score_ext := SALT311.ClipScore(MAX(ssnum_score_pre,0) + ssn_score + valid_ssn_score);// Score in surrounding context
  INTEGER2 ssnum_score_res := MAX(0,ssnum_score_pre); // At least nothing
  INTEGER2 ssnum_score := ssnum_score_res;
  // Get propagation scores for individual propagated fields
  INTEGER2 fname_score_prop := (MAX(le.fname_prop,ri.fname_prop)/MAX(LENGTH(TRIM(le.fname)),LENGTH(TRIM(ri.fname))))*fname_score; // Proportion of longest string propogated
  INTEGER2 mname_score_prop := (MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*mname_score; // Proportion of longest string propogated
  SELF.Conf_Prop := (0 + fname_score_prop + mname_score_prop) / 100; // Score based on propogated fields
  iComp := (src_score + IF(address_score>0,MAX(address_score,prim_range_score + predir_score + prim_name_score + suffix_score + postdir_score + unit_desig_score + sec_range_score + city_name_score + st_score + zip_score + zip4_score + tnt_score + rawaid_score + dt_first_seen_score + dt_last_seen_score + dt_vendor_first_reported_score + dt_vendor_last_reported_score),prim_range_score + predir_score + prim_name_score + suffix_score + postdir_score + unit_desig_score + sec_range_score + city_name_score + st_score + zip_score + zip4_score + tnt_score + rawaid_score + dt_first_seen_score + dt_last_seen_score + dt_vendor_first_reported_score + dt_vendor_last_reported_score) + name_suffix_score + dt_nonglb_last_seen_score + IF(ssnum_score>0,MAX(ssnum_score,ssn_score + valid_ssn_score),ssn_score + valid_ssn_score) + dodgy_tracking_score + pflag1_score + pflag2_score + jflag2_score + jflag3_score + jflag1_score + phone_score + dob_score + rec_type_score + pflag3_score + title_score + fname_score + mname_score + lname_score + address_ind_score + name_ind_score + persistent_record_id_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-SELF.Conf_Prop >= LowerMatchThreshold OR (le.did = ri.did AND (iComp >= IntraMatchThreshold OR iComp-SELF.Conf_Prop >= IntraMatchThreshold)),iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':src',
  n = 1 => ':rawaid',
  n = 2 => ':prim_name',
  n = 3 => ':zip',
  n = 4 => ':zip4',
  n = 5 => ':prim_range',
  n = 6 => ':city_name',
  n = 7 => ':sec_range',
  n = 8 => ':tnt',
  n = 9 => ':name_suffix',
  n = 10 => ':dt_nonglb_last_seen',
  n = 11 => ':dt_first_seen',
  n = 12 => ':postdir',
  n = 13 => ':dt_last_seen',
  n = 14 => ':dodgy_tracking',
  n = 15 => ':dt_vendor_first_reported',
  n = 16 => ':dt_vendor_last_reported',
  n = 17 => ':st',
  n = 18 => ':pflag1',
  n = 19 => ':pflag2',
  n = 20 => ':predir',
  n = 21 => ':jflag2',
  n = 22 => ':suffix',
  n = 23 => ':unit_desig',
  n = 24 => ':jflag3',
  n = 25 => ':jflag1:*',
  n = 30 => ':valid_ssn:*',
  n = 34 => ':phone:ssn',
  n = 35 => ':phone:dob',
  n = 36 => ':phone:rec_type',
  n = 37 => ':ssn:dob',
  n = 38 => ':ssn:rec_type','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 39 join conditions of which 7 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO

//Fixed fields ->:src(55)

dn0 := hfile(~src_isnull);
dn0_deduped := dn0(src_weight100>=2500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.did > RIGHT.did
    AND LEFT.src = RIGHT.src
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.src = RIGHT.src,10000),HASH);

//Fixed fields ->:rawaid(-87)

dn1 := hfile(~rawaid_isnull);
dn1_deduped := dn1(rawaid_weight100>=2500); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.did > RIGHT.did
    AND LEFT.rawaid = RIGHT.rawaid
    ,trans(LEFT,RIGHT,1),UNORDERED,
    ATMOST(LEFT.rawaid = RIGHT.rawaid,10000),HASH);

//Fixed fields ->:prim_name(-125)

dn2 := hfile(~prim_name_isnull);
dn2_deduped := dn2(prim_name_weight100>=2500); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.did > RIGHT.did
    AND LEFT.prim_name = RIGHT.prim_name
    ,trans(LEFT,RIGHT,2),UNORDERED,
    ATMOST(LEFT.prim_name = RIGHT.prim_name,10000),HASH);

//Fixed fields ->:zip(-127)

dn3 := hfile(~zip_isnull);
dn3_deduped := dn3(zip_weight100>=2500); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.did > RIGHT.did
    AND LEFT.zip = RIGHT.zip
    ,trans(LEFT,RIGHT,3),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip,10000),HASH);

//Fixed fields ->:zip4(116)

dn4 := hfile(~zip4_isnull);
dn4_deduped := dn4(zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.did > RIGHT.did
    AND LEFT.zip4 = RIGHT.zip4
    ,trans(LEFT,RIGHT,4),UNORDERED,
    ATMOST(LEFT.zip4 = RIGHT.zip4,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT311.mac_select_best_matches(mjs0_t,rid1,rid2,o0);
mjs0 := o0 : PERSIST('~temp::did::Watchdog_best::mj::0',EXPIRE(Watchdog_best.Config.PersistExpire));

//Fixed fields ->:prim_range(115)

dn5 := hfile(~prim_range_isnull);
dn5_deduped := dn5(prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.did > RIGHT.did
    AND LEFT.prim_range = RIGHT.prim_range
    ,trans(LEFT,RIGHT,5),UNORDERED,
    ATMOST(LEFT.prim_range = RIGHT.prim_range,10000),HASH);

//Fixed fields ->:city_name(109)

dn6 := hfile(~city_name_isnull);
dn6_deduped := dn6(city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.did > RIGHT.did
    AND LEFT.city_name = RIGHT.city_name
    ,trans(LEFT,RIGHT,6),UNORDERED,
    ATMOST(LEFT.city_name = RIGHT.city_name,10000),HASH);

//Fixed fields ->:sec_range(103)

dn7 := hfile(~sec_range_isnull);
dn7_deduped := dn7(sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.did > RIGHT.did
    AND LEFT.sec_range = RIGHT.sec_range
    ,trans(LEFT,RIGHT,7),UNORDERED,
    ATMOST(LEFT.sec_range = RIGHT.sec_range,10000),HASH);

//Fixed fields ->:tnt(93)

dn8 := hfile(~tnt_isnull);
dn8_deduped := dn8(tnt_weight100>=2500); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.did > RIGHT.did
    AND LEFT.tnt = RIGHT.tnt
    ,trans(LEFT,RIGHT,8),UNORDERED,
    ATMOST(LEFT.tnt = RIGHT.tnt,10000),HASH);

//Fixed fields ->:name_suffix(70)

dn9 := hfile(~name_suffix_isnull);
dn9_deduped := dn9(name_suffix_weight100>=2500); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.did > RIGHT.did
    AND LEFT.name_suffix = RIGHT.name_suffix
    ,trans(LEFT,RIGHT,9),UNORDERED,
    ATMOST(LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT311.mac_select_best_matches(mjs1_t,rid1,rid2,o1);
mjs1 := o1 : PERSIST('~temp::did::Watchdog_best::mj::1',EXPIRE(Watchdog_best.Config.PersistExpire));

//Fixed fields ->:dt_nonglb_last_seen(64)

dn10 := hfile(~dt_nonglb_last_seen_isnull);
dn10_deduped := dn10(dt_nonglb_last_seen_weight100>=2500); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.did > RIGHT.did
    AND LEFT.dt_nonglb_last_seen = RIGHT.dt_nonglb_last_seen
    ,trans(LEFT,RIGHT,10),UNORDERED,
    ATMOST(LEFT.dt_nonglb_last_seen = RIGHT.dt_nonglb_last_seen,10000),HASH);

//Fixed fields ->:dt_first_seen(61)

dn11 := hfile(~dt_first_seen_isnull);
dn11_deduped := dn11(dt_first_seen_weight100>=2500); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.did > RIGHT.did
    AND LEFT.dt_first_seen = RIGHT.dt_first_seen
    ,trans(LEFT,RIGHT,11),UNORDERED,
    ATMOST(LEFT.dt_first_seen = RIGHT.dt_first_seen,10000),HASH);

//Fixed fields ->:postdir(61)

dn12 := hfile(~postdir_isnull);
dn12_deduped := dn12(postdir_weight100>=2500); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.did > RIGHT.did
    AND LEFT.postdir = RIGHT.postdir
    ,trans(LEFT,RIGHT,12),UNORDERED,
    ATMOST(LEFT.postdir = RIGHT.postdir,10000),HASH);

//Fixed fields ->:dt_last_seen(56)

dn13 := hfile(~dt_last_seen_isnull);
dn13_deduped := dn13(dt_last_seen_weight100>=2500); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.did > RIGHT.did
    AND LEFT.dt_last_seen = RIGHT.dt_last_seen
    ,trans(LEFT,RIGHT,13),UNORDERED,
    ATMOST(LEFT.dt_last_seen = RIGHT.dt_last_seen,10000),HASH);

//Fixed fields ->:dodgy_tracking(53)

dn14 := hfile(~dodgy_tracking_isnull);
dn14_deduped := dn14(dodgy_tracking_weight100>=2500); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.did > RIGHT.did
    AND LEFT.dodgy_tracking = RIGHT.dodgy_tracking
    ,trans(LEFT,RIGHT,14),UNORDERED,
    ATMOST(LEFT.dodgy_tracking = RIGHT.dodgy_tracking,10000),HASH);
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT311.mac_select_best_matches(mjs2_t,rid1,rid2,o2);
mjs2 := o2 : PERSIST('~temp::did::Watchdog_best::mj::2',EXPIRE(Watchdog_best.Config.PersistExpire));

//Fixed fields ->:dt_vendor_first_reported(50)

dn15 := hfile(~dt_vendor_first_reported_isnull);
dn15_deduped := dn15(dt_vendor_first_reported_weight100>=2500); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.did > RIGHT.did
    AND LEFT.dt_vendor_first_reported = RIGHT.dt_vendor_first_reported
    ,trans(LEFT,RIGHT,15),UNORDERED,
    ATMOST(LEFT.dt_vendor_first_reported = RIGHT.dt_vendor_first_reported,10000),HASH);

//Fixed fields ->:dt_vendor_last_reported(48)

dn16 := hfile(~dt_vendor_last_reported_isnull);
dn16_deduped := dn16(dt_vendor_last_reported_weight100>=2500); // Use specificity to flag high-dup counts
mj16 := JOIN( dn16_deduped, dn16_deduped, LEFT.did > RIGHT.did
    AND LEFT.dt_vendor_last_reported = RIGHT.dt_vendor_last_reported
    ,trans(LEFT,RIGHT,16),UNORDERED,
    ATMOST(LEFT.dt_vendor_last_reported = RIGHT.dt_vendor_last_reported,10000),HASH);

//Fixed fields ->:st(48)

dn17 := hfile(~st_isnull);
dn17_deduped := dn17(st_weight100>=2500); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.did > RIGHT.did
    AND LEFT.st = RIGHT.st
    ,trans(LEFT,RIGHT,17),UNORDERED,
    ATMOST(LEFT.st = RIGHT.st,10000),HASH);

//Fixed fields ->:pflag1(44)

dn18 := hfile(~pflag1_isnull);
dn18_deduped := dn18(pflag1_weight100>=2500); // Use specificity to flag high-dup counts
mj18 := JOIN( dn18_deduped, dn18_deduped, LEFT.did > RIGHT.did
    AND LEFT.pflag1 = RIGHT.pflag1
    ,trans(LEFT,RIGHT,18),UNORDERED,
    ATMOST(LEFT.pflag1 = RIGHT.pflag1,10000),HASH);

//Fixed fields ->:pflag2(43)

dn19 := hfile(~pflag2_isnull);
dn19_deduped := dn19(pflag2_weight100>=2500); // Use specificity to flag high-dup counts
mj19 := JOIN( dn19_deduped, dn19_deduped, LEFT.did > RIGHT.did
    AND LEFT.pflag2 = RIGHT.pflag2
    ,trans(LEFT,RIGHT,19),UNORDERED,
    ATMOST(LEFT.pflag2 = RIGHT.pflag2,10000),HASH);
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT311.mac_select_best_matches(mjs3_t,rid1,rid2,o3);
mjs3 := o3 : PERSIST('~temp::did::Watchdog_best::mj::3',EXPIRE(Watchdog_best.Config.PersistExpire));

//Fixed fields ->:predir(38)

dn20 := hfile(~predir_isnull);
dn20_deduped := dn20(predir_weight100>=2500); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.did > RIGHT.did
    AND LEFT.predir = RIGHT.predir
    ,trans(LEFT,RIGHT,20),UNORDERED,
    ATMOST(LEFT.predir = RIGHT.predir,10000),HASH);

//Fixed fields ->:jflag2(37)

dn21 := hfile(~jflag2_isnull);
dn21_deduped := dn21(jflag2_weight100>=2500); // Use specificity to flag high-dup counts
mj21 := JOIN( dn21_deduped, dn21_deduped, LEFT.did > RIGHT.did
    AND LEFT.jflag2 = RIGHT.jflag2
    ,trans(LEFT,RIGHT,21),UNORDERED,
    ATMOST(LEFT.jflag2 = RIGHT.jflag2,10000),HASH);

//Fixed fields ->:suffix(29)

dn22 := hfile(~suffix_isnull);
dn22_deduped := dn22(suffix_weight100>=2500); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.did > RIGHT.did
    AND LEFT.suffix = RIGHT.suffix
    ,trans(LEFT,RIGHT,22),UNORDERED,
    ATMOST(LEFT.suffix = RIGHT.suffix,10000),HASH);

//Fixed fields ->:unit_desig(29)

dn23 := hfile(~unit_desig_isnull);
dn23_deduped := dn23(unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj23 := JOIN( dn23_deduped, dn23_deduped, LEFT.did > RIGHT.did
    AND LEFT.unit_desig = RIGHT.unit_desig
    ,trans(LEFT,RIGHT,23),UNORDERED,
    ATMOST(LEFT.unit_desig = RIGHT.unit_desig,10000),HASH);

//Fixed fields ->:jflag3(25)

dn24 := hfile(~jflag3_isnull);
dn24_deduped := dn24(jflag3_weight100>=2500); // Use specificity to flag high-dup counts
mj24 := JOIN( dn24_deduped, dn24_deduped, LEFT.did > RIGHT.did
    AND LEFT.jflag3 = RIGHT.jflag3
    ,trans(LEFT,RIGHT,24),UNORDERED,
    ATMOST(LEFT.jflag3 = RIGHT.jflag3,10000),HASH);
mjs4_t := mj20+mj21+mj22+mj23+mj24;
SALT311.mac_select_best_matches(mjs4_t,rid1,rid2,o4);
mjs4 := o4 : PERSIST('~temp::did::Watchdog_best::mj::4',EXPIRE(Watchdog_best.Config.PersistExpire));

//First 1 fields shared with following 4 joins - optimization performed
//Fixed fields ->:jflag1(24):valid_ssn(21) also :jflag1(24):phone(17) also :jflag1(24):ssn(17) also :jflag1(24):dob(13) also :jflag1(24):rec_type(12)

dn25 := hfile(~jflag1_isnull);
dn25_deduped := dn25(jflag1_weight100>=2100); // Use specificity to flag high-dup counts
mj25 := JOIN( dn25_deduped, dn25_deduped, LEFT.did > RIGHT.did
    AND LEFT.jflag1 = RIGHT.jflag1
    AND (
          LEFT.valid_ssn = RIGHT.valid_ssn AND ~LEFT.valid_ssn_isnull
    OR    LEFT.phone = RIGHT.phone AND ~LEFT.phone_isnull
    OR    LEFT.ssn = RIGHT.ssn AND ~LEFT.ssn_isnull
    OR    LEFT.dob = RIGHT.dob AND ~LEFT.dob_isnull
    OR    LEFT.rec_type = RIGHT.rec_type AND ~LEFT.rec_type_isnull
        )
    ,trans(LEFT,RIGHT,25),UNORDERED,
    ATMOST(LEFT.jflag1 = RIGHT.jflag1,10000),HASH);
mjs5_t := mj25;
SALT311.mac_select_best_matches(mjs5_t,rid1,rid2,o5);
mjs5 := o5 : PERSIST('~temp::did::Watchdog_best::mj::5',EXPIRE(Watchdog_best.Config.PersistExpire));

//First 1 fields shared with following 3 joins - optimization performed
//Fixed fields ->:valid_ssn(21):phone(17) also :valid_ssn(21):ssn(17) also :valid_ssn(21):dob(13) also :valid_ssn(21):rec_type(12)

dn30 := hfile(~valid_ssn_isnull);
dn30_deduped := dn30(valid_ssn_weight100>=2100); // Use specificity to flag high-dup counts
mj30 := JOIN( dn30_deduped, dn30_deduped, LEFT.did > RIGHT.did
    AND LEFT.valid_ssn = RIGHT.valid_ssn
    AND (
          LEFT.phone = RIGHT.phone AND ~LEFT.phone_isnull
    OR    LEFT.ssn = RIGHT.ssn AND ~LEFT.ssn_isnull
    OR    LEFT.dob = RIGHT.dob AND ~LEFT.dob_isnull
    OR    LEFT.rec_type = RIGHT.rec_type AND ~LEFT.rec_type_isnull
        )
    ,trans(LEFT,RIGHT,30),UNORDERED,
    ATMOST(LEFT.valid_ssn = RIGHT.valid_ssn,10000),HASH);

//Fixed fields ->:phone(17):ssn(17)

dn34 := hfile(~phone_isnull AND ~ssn_isnull);
dn34_deduped := dn34(phone_weight100 + ssn_weight100>=2500); // Use specificity to flag high-dup counts
mj34 := JOIN( dn34_deduped, dn34_deduped, LEFT.did > RIGHT.did
    AND LEFT.phone = RIGHT.phone
    AND LEFT.ssn = RIGHT.ssn
    ,trans(LEFT,RIGHT,34),UNORDERED,
    ATMOST(LEFT.phone = RIGHT.phone
      AND LEFT.ssn = RIGHT.ssn,10000),HASH);
mjs6_t := mj30+mj34;
SALT311.mac_select_best_matches(mjs6_t,rid1,rid2,o6);
mjs6 := o6 : PERSIST('~temp::did::Watchdog_best::mj::6',EXPIRE(Watchdog_best.Config.PersistExpire));

//Fixed fields ->:phone(17):dob(13)

dn35 := hfile(~phone_isnull AND ~dob_isnull);
dn35_deduped := dn35(phone_weight100 + dob_weight100>=2500); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.did > RIGHT.did
    AND LEFT.phone = RIGHT.phone
    AND LEFT.dob = RIGHT.dob
    ,trans(LEFT,RIGHT,35),UNORDERED,
    ATMOST(LEFT.phone = RIGHT.phone
      AND LEFT.dob = RIGHT.dob,10000),HASH);

//Fixed fields ->:phone(17):rec_type(12)

dn36 := hfile(~phone_isnull AND ~rec_type_isnull);
dn36_deduped := dn36(phone_weight100 + rec_type_weight100>=2500); // Use specificity to flag high-dup counts
mj36 := JOIN( dn36_deduped, dn36_deduped, LEFT.did > RIGHT.did
    AND LEFT.phone = RIGHT.phone
    AND LEFT.rec_type = RIGHT.rec_type
    ,trans(LEFT,RIGHT,36),UNORDERED,
    ATMOST(LEFT.phone = RIGHT.phone
      AND LEFT.rec_type = RIGHT.rec_type,10000),HASH);

//Fixed fields ->:ssn(17):dob(13)

dn37 := hfile(~ssn_isnull AND ~dob_isnull);
dn37_deduped := dn37(ssn_weight100 + dob_weight100>=2500); // Use specificity to flag high-dup counts
mj37 := JOIN( dn37_deduped, dn37_deduped, LEFT.did > RIGHT.did
    AND LEFT.ssn = RIGHT.ssn
    AND LEFT.dob = RIGHT.dob
    ,trans(LEFT,RIGHT,37),UNORDERED,
    ATMOST(LEFT.ssn = RIGHT.ssn
      AND LEFT.dob = RIGHT.dob,10000),HASH);

//Fixed fields ->:ssn(17):rec_type(12)

dn38 := hfile(~ssn_isnull AND ~rec_type_isnull);
dn38_deduped := dn38(ssn_weight100 + rec_type_weight100>=2500); // Use specificity to flag high-dup counts
mj38 := JOIN( dn38_deduped, dn38_deduped, LEFT.did > RIGHT.did
    AND LEFT.ssn = RIGHT.ssn
    AND LEFT.rec_type = RIGHT.rec_type
    ,trans(LEFT,RIGHT,38),UNORDERED,
    ATMOST(LEFT.ssn = RIGHT.ssn
      AND LEFT.rec_type = RIGHT.rec_type,10000),HASH);
last_mjs_t :=mj35+mj36+mj37+mj38;
SALT311.mac_select_best_matches(last_mjs_t,rid1,rid2,o);
mjs7 := o : PERSIST('~temp::did::Watchdog_best::mj::7',EXPIRE(Watchdog_best.Config.PersistExpire));

RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::did::Watchdog_best::all_m',EXPIRE(Watchdog_best.Config.PersistExpire)); // To by used by rid and did
SALT311.mac_avoid_transitives(All_Matches,did1,did2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::did::Watchdog_best::mt',EXPIRE(Watchdog_best.Config.PersistExpire));
SALT311.mac_get_BestPerRecord( All_Matches,rid1,did1,rid2,did2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::did::Watchdog_best::mr',EXPIRE(Watchdog_best.Config.PersistExpire));
//Now lets see if any slice-outs are needed
SHARED too_big := TABLE(match_candidates(ih).Candidates_ForSlice,{did, InCluster := COUNT(GROUP)},did,LOCAL)(InCluster>1000); // did that are too big for sliceout
SHARED h_ok := JOIN(match_candidates(ih).Candidates_ForSlice,too_big,LEFT.did=RIGHT.did,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.did=RIGHT.did AND (>STRING6<)LEFT.rid<>(>STRING6<)RIGHT.rid,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT311.mac_cluster_breadth(in_matches,rid1,rid2,did1,o);
SHARED in_matches1 := o;
missed_linkages0 := JOIN(h_ok, in_matches1, LEFT.rid = RIGHT.rid1, TRANSFORM(RECORDOF(in_matches1), SELF.did1 := LEFT.did, SELF.rid1 := LEFT.rid, SELF := []), LEFT ONLY, LOCAL); // get back the records with no close matches
missed_linkages := JOIN(missed_linkages0,Specificities(ih).ClusterSizes(InCluster>1),LEFT.did1=RIGHT.did,LOCAL); // remove singletons
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.did1=RIGHT.did,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages : PERSIST('~temp::did::Watchdog_best::clu',EXPIRE(Watchdog_best.Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT311.UIDType rid;  //Outcast
  SALT311.UIDType did;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT311.UIDType Pref_rid; // Prefers this record
  SALT311.UIDType Pref_did; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rid := le.rid1;
  self.did := le.did1;
  self.Closest := le.Closest;
  self.Pref_rid := ri.rid2;
  self.Pref_did := ri.did2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rid1=RIGHT.rid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.did=RIGHT.did1 AND LEFT.Pref_did=RIGHT.did2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.did=RIGHT.did2 AND LEFT.Pref_did=RIGHT.did1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.rid=RIGHT.rid,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>Config.SliceDistance),HASH(did)),did,-Pref_Margin,rid,pref_did,pref_rid,LOCAL),did,LOCAL)) : PERSIST('~temp::did::Watchdog_best::Matches::ToSlice',EXPIRE(Watchdog_best.Config.PersistExpire));
// 1024x better in new place
  SALT311.MAC_Avoid_SliceOuts(PossibleMatches,did1,did2,did,Pref_did,ToSlice,m); // If did is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::did::Watchdog_best::Matches::Matches',EXPIRE(Watchdog_best.Config.PersistExpire));


//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih, s, MatchThreshold).AnnotateMatches(Full_Sample_Matches);

//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rid,did});
  SALT311.utMAC_Patch_Id(ih_thin,did,BasicMatch(ih).patch_file,did1,did2,ihbp); // Perform basic matches
  SALT311.MAC_SliceOut_ByRID(ihbp,rid,did,ToSlice,rid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  SALT311.utMAC_Patch_Id(sliced,did,Matches,did1,did2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);

EXPORT Patched_Infile := pi1;

//Produced a patched version of match_candidates to get External ADL2 for free.
SALT311.utMAC_Patch_Id(h,did,Matches,did1,did2,o1);
EXPORT Patched_Candidates := o1;

// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rid := le.rid;
    SELF.did_before := le.did;
    SELF.did_after := ri.did;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rid = RIGHT.rid AND (LEFT.did<>RIGHT.did),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := Watchdog_best.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := Watchdog_best.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
