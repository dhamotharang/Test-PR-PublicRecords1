// Various routines to assist in debugging
 
IMPORT SALT311,std,ut/*HACK01c*/;
EXPORT Debug(DATASET(layout_Address_Link) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.DID) left_DID;
  INTEGER1 DID_match_code;
  INTEGER2 DID_score;
  BOOLEAN DID_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.DID) right_DID;
  TYPEOF(h.addr) left_addr;
  INTEGER1 addr_match_code;
  INTEGER2 addr_score;
  INTEGER2 addr_score_prop;
  BOOLEAN addr_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.addr) right_addr;
  TYPEOF(h.locale) left_locale;
  INTEGER1 locale_match_code;
  INTEGER2 locale_score;
  TYPEOF(h.locale) right_locale;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.prim_range_num) left_prim_range_num;
  INTEGER1 prim_range_num_match_code;
  INTEGER2 prim_range_num_score;
  INTEGER2 prim_range_num_score_prop;
  BOOLEAN prim_range_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range_num) right_prim_range_num;
  TYPEOF(h.prim_name_num) left_prim_name_num;
  INTEGER1 prim_name_num_match_code;
  INTEGER2 prim_name_num_score;
  BOOLEAN prim_name_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name_num) right_prim_name_num;
  TYPEOF(h.prim_range_alpha) left_prim_range_alpha;
  INTEGER1 prim_range_alpha_match_code;
  INTEGER2 prim_range_alpha_score;
  INTEGER2 prim_range_alpha_score_prop;
  BOOLEAN prim_range_alpha_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range_alpha) right_prim_range_alpha;
  TYPEOF(h.prim_name_alpha) left_prim_name_alpha;
  INTEGER1 prim_name_alpha_match_code;
  INTEGER2 prim_name_alpha_score;
  BOOLEAN prim_name_alpha_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name_alpha) right_prim_name_alpha;
  TYPEOF(h.prim_range_fract) left_prim_range_fract;
  INTEGER1 prim_range_fract_match_code;
  INTEGER2 prim_range_fract_score;
  INTEGER2 prim_range_fract_score_prop;
  BOOLEAN prim_range_fract_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range_fract) right_prim_range_fract;
  TYPEOF(h.sec_range_alpha) left_sec_range_alpha;
  INTEGER1 sec_range_alpha_match_code;
  INTEGER2 sec_range_alpha_score;
  INTEGER2 sec_range_alpha_score_prop;
  BOOLEAN sec_range_alpha_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range_alpha) right_sec_range_alpha;
  TYPEOF(h.sec_range_num) left_sec_range_num;
  INTEGER1 sec_range_num_match_code;
  INTEGER2 sec_range_num_score;
  INTEGER2 sec_range_num_score_prop;
  BOOLEAN sec_range_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range_num) right_sec_range_num;
  TYPEOF(h.city) left_city;
  INTEGER1 city_match_code;
  INTEGER2 city_score;
  TYPEOF(h.city) right_city;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.st) right_st;
  TYPEOF(h.src) left_src;
  TYPEOF(h.src) right_src;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
  TYPEOF(h.prim_range) left_prim_range;
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.predir) left_predir;
  TYPEOF(h.predir) right_predir;
  TYPEOF(h.prim_name) left_prim_name;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.addr_suffix) left_addr_suffix;
  TYPEOF(h.addr_suffix) right_addr_suffix;
  TYPEOF(h.addr_ind) left_addr_ind;
  TYPEOF(h.addr_ind) right_addr_ind;
  TYPEOF(h.postdir) left_postdir;
  TYPEOF(h.postdir) right_postdir;
  TYPEOF(h.unit_desig) left_unit_desig;
  TYPEOF(h.unit_desig) right_unit_desig;
  TYPEOF(h.sec_range) left_sec_range;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.rec_cnt) left_rec_cnt;
  TYPEOF(h.rec_cnt) right_rec_cnt;
  TYPEOF(h.src_cnt) left_src_cnt;
  TYPEOF(h.src_cnt) right_src_cnt;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  		 /*BEGIN HACK01a*/
	  nbrsOnly (string str) := REGEXREPLACE('[^0-9]',str,'');
    notNull  (string str) := nbrsOnly(str) <> '';
		isNullx  (string str) := nbrsOnly(str) =  '';
		hasMatch (string str1, string str2) := IF(ut.nowords(str2) = 1 AND length(nbrsOnly(str2)) > 1,datalib.stringfind(str1,nbrsOnly(str2),1) > 0,FALSE);
		isRangeNameMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.prim_name,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.prim_name,le.prim_range));
		isRangeSecMatch  := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.sec_range_num,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.sec_range_num,le.prim_range));
		isSecNameMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and hasMatch(le.prim_name,ri.sec_range_num))  OR 
		                    (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and hasMatch(ri.prim_name,le.sec_range_num));
		isRangeNameMisMatch := (isNullx(le.prim_range)  and notNull(ri.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and 
		                            notNull(le.prim_name) and datalib.stringfind(le.prim_name,nbrsOnly(ri.prim_range),1) = 0) OR
		                       (isNullx(ri.prim_range)    and notNull(le.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and 
													      notNull(ri.prim_name) and datalib.stringfind(ri.prim_name,nbrsOnly(le.prim_range),1) = 0);
		isRangeSecMisMatch  := (isNullx(le.prim_range)        and notNull(ri.prim_range) and isNullx(nbrsOnly(le.prim_name)) and isNullx(nbrsOnly(ri.prim_name)) and
		                            notNull(le.sec_range_num) and datalib.stringfind(le.sec_range_num,nbrsOnly(ri.prim_range),1) = 0) OR
		                       (isNullx(ri.prim_range)        and notNull(le.prim_range) and 
													      notNull(ri.sec_range_num) and datalib.stringfind(ri.sec_range_num,nbrsOnly(le.prim_range),1) = 0);
		isSecNameMisMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
		                            notNull(le.prim_name)  and datalib.stringfind(le.prim_name,nbrsOnly(ri.sec_range_num),1) = 0) OR
		                       (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
													      notNull(ri.prim_name)  and datalib.stringfind(ri.prim_name,nbrsOnly(le.sec_range_num),1) = 0);
		bonus := MAP(isRangeNameMatch    or isRangeSecMatch or isSecNameMatch       =>  3,
                 isRangeNameMisMatch or isRangeSecMisMatch or isSecNameMisMatch => -9999,
								 0);
    /*END HACK01a*/
		SELF.Rule := c;
  SELF.ADDRESS_GROUP_ID1 := le.ADDRESS_GROUP_ID;
  SELF.ADDRESS_GROUP_ID2 := ri.ADDRESS_GROUP_ID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.left_DID := le.DID;
  SELF.right_DID := ri.DID;
  SELF.DID_match_code := MAP(
                        le.DID_isnull OR ri.DID_isnull => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_DID(le.DID,ri.DID));
  INTEGER2 DID_score_temp := MAP(
                        le.DID_isnull OR ri.DID_isnull => 0,
                        le.DID = ri.DID  => le.DID_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.DID_weight100,ri.DID_weight100),s.DID_switch));
  REAL addr_score_scale := ( le.addr_weight100 + ri.addr_weight100 ) / (le.prim_range_num_weight100 + ri.prim_range_num_weight100 + le.prim_range_alpha_weight100 + ri.prim_range_alpha_weight100 + le.prim_range_fract_weight100 + ri.prim_range_fract_weight100 + le.prim_name_num_weight100 + ri.prim_name_num_weight100 + le.prim_name_alpha_weight100 + ri.prim_name_alpha_weight100 + le.sec_range_num_weight100 + ri.sec_range_num_weight100 + le.sec_range_alpha_weight100 + ri.sec_range_alpha_weight100); // Scaling factor for this concept
  SELF.addr_match_code := MAP(
                        (le.addr_isnull OR le.prim_range_num_isnull AND le.prim_range_alpha_isnull AND le.prim_range_fract_isnull AND le.prim_name_num_isnull AND le.prim_name_alpha_isnull AND le.sec_range_num_isnull AND le.sec_range_alpha_isnull) OR (ri.addr_isnull OR ri.prim_range_num_isnull AND ri.prim_range_alpha_isnull AND ri.prim_range_fract_isnull AND ri.prim_name_num_isnull AND ri.prim_name_alpha_isnull AND ri.sec_range_num_isnull AND ri.sec_range_alpha_isnull) => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_addr(le.addr,ri.addr,FALSE));
  INTEGER2 addr_score_pre := MAP( (le.addr_isnull OR le.prim_range_num_isnull AND le.prim_range_alpha_isnull AND le.prim_range_fract_isnull AND le.prim_name_num_isnull AND le.prim_name_alpha_isnull AND le.sec_range_num_isnull AND le.sec_range_alpha_isnull) OR (ri.addr_isnull OR ri.prim_range_num_isnull AND ri.prim_range_alpha_isnull AND ri.prim_range_fract_isnull AND ri.prim_name_num_isnull AND ri.prim_name_alpha_isnull AND ri.sec_range_num_isnull AND ri.sec_range_alpha_isnull) => 0,
                        le.addr = ri.addr  => le.addr_weight100,
                        0);
  SELF.left_addr := le.addr;
  SELF.right_addr := ri.addr;
  REAL locale_score_scale := ( le.locale_weight100 + ri.locale_weight100 ) / (le.city_weight100 + ri.city_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  SELF.locale_match_code := MAP(
                        (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => SALT311.MatchCode.OneSideNull,
                        match_methods(ih).match_locale(le.locale,ri.locale,FALSE));
  INTEGER2 locale_score_pre := MAP( (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        le.locale = ri.locale  => le.locale_weight100,
                        0);
  SELF.left_locale := le.locale;
  SELF.right_locale := ri.locale;
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
                        le.zip_isnull OR ri.zip_isnull => SALT311.MatchCode.OneSideNull,
                        locale_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip_weight100,ri.zip_weight100),s.zip_switch))*IF(locale_score_scale=0,1,locale_score_scale);
  SELF.left_prim_range_num := le.prim_range_num;
  SELF.right_prim_range_num := ri.prim_range_num;
  SELF.prim_range_num_match_code := MAP(
                        le.prim_range_num_isnull OR ri.prim_range_num_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_range_num(le.prim_range_num,ri.prim_range_num));
  INTEGER2 prim_range_num_score_temp := MAP(
                        le.prim_range_num_isnull OR ri.prim_range_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_range_num,ri.prim_range_num)  => le.prim_range_num_weight100,
                        SALT311.MatchBagOfWords(le.prim_range_num,ri.prim_range_num,31744,1))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_prim_name_num := le.prim_name_num;
  SELF.right_prim_name_num := ri.prim_name_num;
  SELF.prim_name_num_match_code := MAP(
                        le.prim_name_num_isnull OR ri.prim_name_num_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_name_num(le.prim_name_num,ri.prim_name_num));
  INTEGER2 prim_name_num_score_temp := MAP(
                        le.prim_name_num_isnull OR ri.prim_name_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_name_num,ri.prim_name_num)  => le.prim_name_num_weight100,
                        SALT311.MatchBagOfWords(le.prim_name_num,ri.prim_name_num,31744,1))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_prim_range_alpha := le.prim_range_alpha;
  SELF.right_prim_range_alpha := ri.prim_range_alpha;
  SELF.prim_range_alpha_match_code := MAP(
                        le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_range_alpha(le.prim_range_alpha,ri.prim_range_alpha));
  INTEGER2 prim_range_alpha_score_temp := MAP(
                        le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_alpha = ri.prim_range_alpha  => le.prim_range_alpha_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_alpha_weight100,ri.prim_range_alpha_weight100),s.prim_range_alpha_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_prim_name_alpha := le.prim_name_alpha;
  SELF.right_prim_name_alpha := ri.prim_name_alpha;
  SELF.prim_name_alpha_match_code := MAP(
                        le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_name_alpha(le.prim_name_alpha,ri.prim_name_alpha));
  INTEGER2 prim_name_alpha_score_temp := MAP(
                        le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_name_alpha,ri.prim_name_alpha) OR SALT311.HyphenMatch(le.prim_name_alpha,ri.prim_name_alpha,1)<=2  => MIN(le.prim_name_alpha_weight100,ri.prim_name_alpha_weight100),
                        SALT311.MatchBagOfWords(le.prim_name_alpha,ri.prim_name_alpha,31755,1))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_prim_range_fract := le.prim_range_fract;
  SELF.right_prim_range_fract := ri.prim_range_fract;
  SELF.prim_range_fract_match_code := MAP(
                        le.prim_range_fract_isnull OR ri.prim_range_fract_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_range_fract(le.prim_range_fract,ri.prim_range_fract));
  INTEGER2 prim_range_fract_score_temp := MAP(
                        le.prim_range_fract_isnull OR ri.prim_range_fract_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_fract = ri.prim_range_fract  => le.prim_range_fract_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_fract_weight100,ri.prim_range_fract_weight100),s.prim_range_fract_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_sec_range_alpha := le.sec_range_alpha;
  SELF.right_sec_range_alpha := ri.sec_range_alpha;
  SELF.sec_range_alpha_match_code := MAP(
                        le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_sec_range_alpha(le.sec_range_alpha,ri.sec_range_alpha));
  INTEGER2 sec_range_alpha_score_temp := MAP(
                        le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_alpha = ri.sec_range_alpha  => le.sec_range_alpha_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_alpha_weight100,ri.sec_range_alpha_weight100),s.sec_range_alpha_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_sec_range_num := le.sec_range_num;
  SELF.right_sec_range_num := ri.sec_range_num;
  SELF.sec_range_num_match_code := MAP(
                        le.sec_range_num_isnull OR ri.sec_range_num_isnull => SALT311.MatchCode.OneSideNull,
                        addr_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_sec_range_num(le.sec_range_num,ri.sec_range_num));
  INTEGER2 sec_range_num_score_temp := MAP(
                        le.sec_range_num_isnull OR ri.sec_range_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_num = ri.sec_range_num  => le.sec_range_num_weight100,
                        LENGTH(TRIM(le.sec_range_num))>0 and le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))] => le.sec_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.sec_range_num))>0 and ri.sec_range_num = le.sec_range_num[1..LENGTH(TRIM(ri.sec_range_num))] => ri.sec_range_num_weight100, // An initial match - take initial specificity
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_num_weight100,ri.sec_range_num_weight100),s.sec_range_num_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  SELF.left_city := le.city;
  SELF.right_city := ri.city;
  SELF.city_match_code := MAP(
                        le.city_isnull OR ri.city_isnull => SALT311.MatchCode.OneSideNull,
                        locale_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_city(le.city,ri.city));
  SELF.city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.city,ri.city) OR SALT311.HyphenMatch(le.city,ri.city,1)<=2  => MIN(le.city_weight100,ri.city_weight100),
                        SALT311.MatchBagOfWords(le.city,ri.city,31768,1))*IF(locale_score_scale=0,1,locale_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
                        le.st_isnull OR ri.st_isnull => SALT311.MatchCode.OneSideNull,
                        locale_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_st(le.st,ri.st));
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.st_weight100,ri.st_weight100),s.st_switch))*IF(locale_score_scale=0,1,locale_score_scale);
  SELF.left_src := le.src;
  SELF.right_src := ri.src;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.left_addr_suffix := le.addr_suffix;
  SELF.right_addr_suffix := ri.addr_suffix;
  SELF.left_addr_ind := le.addr_ind;
  SELF.right_addr_ind := ri.addr_ind;
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.left_rec_cnt := le.rec_cnt;
  SELF.right_rec_cnt := ri.rec_cnt;
  SELF.left_src_cnt := le.src_cnt;
  SELF.right_src_cnt := ri.src_cnt;
  INTEGER2 DID_score_unweighted := IF ( DID_score_temp >= Config.DID_Force * 100, DID_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.DID_skipped := DID_score_unweighted < -5000;// Enforce FORCE parameter
  SELF.DID_score := DID_score_unweighted*0.01; 
  SELF.prim_range_num_score := IF ( prim_range_num_score_temp >= Config.prim_range_num_Force * 100, prim_range_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_num_skipped := SELF.prim_range_num_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_num_score := IF ( prim_name_num_score_temp >= Config.prim_name_num_Force * 100, prim_name_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_num_skipped := SELF.prim_name_num_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_alpha_score := IF ( prim_range_alpha_score_temp >= Config.prim_range_alpha_Force * 100, prim_range_alpha_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_alpha_skipped := SELF.prim_range_alpha_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_alpha_score := IF ( prim_name_alpha_score_temp >= Config.prim_name_alpha_Force * 100, prim_name_alpha_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_alpha_skipped := SELF.prim_name_alpha_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_fract_score := IF ( prim_range_fract_score_temp >= Config.prim_range_fract_Force * 100, prim_range_fract_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_fract_skipped := SELF.prim_range_fract_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_alpha_score := IF ( sec_range_alpha_score_temp >= Config.sec_range_alpha_Force * 100, sec_range_alpha_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_alpha_skipped := SELF.sec_range_alpha_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_num_score := IF ( sec_range_num_score_temp >= Config.sec_range_num_Force * 100, sec_range_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_num_skipped := SELF.sec_range_num_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp >= Config.st_Force * 100, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept addr
  INTEGER2 addr_score_ext := SALT311.ClipScore(MAX(addr_score_pre,0) + self.prim_range_num_score + self.prim_range_alpha_score + self.prim_range_fract_score + self.prim_name_num_score + self.prim_name_alpha_score + self.sec_range_num_score + self.sec_range_alpha_score);// Score in surrounding context
  INTEGER2 addr_score_res := MAX(0,addr_score_pre); // At least nothing
  SELF.addr_score := IF ( addr_score_ext >= 0,addr_score_res,-9999);
  SELF.addr_skipped := SELF.addr_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept locale
  INTEGER2 locale_score_ext := SALT311.ClipScore(MAX(locale_score_pre,0) + self.city_score + self.st_score + self.zip_score);// Score in surrounding context
  INTEGER2 locale_score_res := MAX(0,locale_score_pre); // At least nothing
  SELF.locale_score := locale_score_res;
  // Get propagation scores for individual propagated fields
  SELF.addr_score_prop := IF(le.addr_prop+ri.addr_prop>0,SELF.addr_score*(0+IF(le.prim_range_num_prop+ri.prim_range_num_prop>0,s.prim_range_num_specificity,0)+IF(le.prim_range_alpha_prop+ri.prim_range_alpha_prop>0,s.prim_range_alpha_specificity,0)+IF(le.prim_range_fract_prop+ri.prim_range_fract_prop>0,s.prim_range_fract_specificity,0)+IF(le.sec_range_num_prop+ri.sec_range_num_prop>0,s.sec_range_num_specificity,0)+IF(le.sec_range_alpha_prop+ri.sec_range_alpha_prop>0,s.sec_range_alpha_specificity,0))/( s.prim_range_num_specificity+ s.prim_range_alpha_specificity+ s.prim_range_fract_specificity+ s.sec_range_num_specificity+ s.sec_range_alpha_specificity),0);
  SELF.prim_range_num_score_prop := MAX(le.prim_range_num_prop,ri.prim_range_num_prop)*SELF.prim_range_num_score; // Score if either field propogated
  SELF.prim_range_alpha_score_prop := MAX(le.prim_range_alpha_prop,ri.prim_range_alpha_prop)*SELF.prim_range_alpha_score; // Score if either field propogated
  SELF.prim_range_fract_score_prop := MAX(le.prim_range_fract_prop,ri.prim_range_fract_prop)*SELF.prim_range_fract_score; // Score if either field propogated
  SELF.sec_range_alpha_score_prop := MAX(le.sec_range_alpha_prop,ri.sec_range_alpha_prop)*SELF.sec_range_alpha_score; // Score if either field propogated
  SELF.sec_range_num_score_prop := (MAX(le.sec_range_num_prop,ri.sec_range_num_prop)/MAX(LENGTH(TRIM(le.sec_range_num)),LENGTH(TRIM(ri.sec_range_num))))*SELF.sec_range_num_score; // Proportion of longest string propogated
  SELF.Conf_Prop := (0 + SELF.addr_score_prop + SELF.prim_range_num_score_prop + SELF.prim_range_alpha_score_prop + SELF.prim_range_fract_score_prop + SELF.sec_range_alpha_score_prop + SELF.sec_range_num_score_prop) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.DID_score + IF(SELF.addr_score>0,MAX(SELF.addr_score,SELF.prim_range_num_score + SELF.prim_range_alpha_score + SELF.prim_range_fract_score + SELF.prim_name_num_score + SELF.prim_name_alpha_score + SELF.sec_range_num_score + SELF.sec_range_alpha_score),SELF.prim_range_num_score + SELF.prim_range_alpha_score + SELF.prim_range_fract_score + SELF.prim_name_num_score + SELF.prim_name_alpha_score + SELF.sec_range_num_score + SELF.sec_range_alpha_score) + IF(SELF.locale_score>0,MAX(SELF.locale_score,SELF.city_score + SELF.st_score + SELF.zip_score),SELF.city_score + SELF.st_score + SELF.zip_score)) / 100 + outside + bonus/*HACK01b*/;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.ADDRESS_GROUP_ID = RIGHT.ADDRESS_GROUP_ID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.ADDRESS_GROUP_ID2 = RIGHT.ADDRESS_GROUP_ID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(RID1 <> RID2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when RID known
  j1 := JOIN(in_data,im,LEFT.RID = RIGHT.RID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.RID2 = RIGHT.RID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT311.UIDType BaseRecord) := FUNCTION//Faster form when RID known
  j1 := in_data(RID = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(RID<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.RID1=RIGHT.RID1 AND LEFT.RID2=RIGHT.RID2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType ADDRESS_GROUP_ID;
  DATASET(SALT311.Layout_FieldValueList) DID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) addr_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) locale_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) src_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) prim_range_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) predir_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) prim_name_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) addr_suffix_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) addr_ind_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) postdir_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) sec_range_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) rec_cnt_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) src_cnt_Values := DATASET([],SALT311.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.ADDRESS_GROUP_ID := le.ADDRESS_GROUP_ID;
    SELF.DID_values := SALT311.fn_combine_fieldvaluelist(le.DID_values,ri.DID_values);
    SELF.addr_values := SALT311.fn_combine_fieldvaluelist(le.addr_values,ri.addr_values);
    SELF.locale_values := SALT311.fn_combine_fieldvaluelist(le.locale_values,ri.locale_values);
    SELF.src_values := SALT311.fn_combine_fieldvaluelist(le.src_values,ri.src_values);
    SELF.dt_first_seen_values := SALT311.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT311.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
    SELF.prim_range_values := SALT311.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.predir_values := SALT311.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
    SELF.prim_name_values := SALT311.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.addr_suffix_values := SALT311.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
    SELF.addr_ind_values := SALT311.fn_combine_fieldvaluelist(le.addr_ind_values,ri.addr_ind_values);
    SELF.postdir_values := SALT311.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
    SELF.unit_desig_values := SALT311.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
    SELF.sec_range_values := SALT311.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.rec_cnt_values := SALT311.fn_combine_fieldvaluelist(le.rec_cnt_values,ri.rec_cnt_values);
    SELF.src_cnt_values := SALT311.fn_combine_fieldvaluelist(le.src_cnt_values,ri.src_cnt_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(ADDRESS_GROUP_ID) ), ADDRESS_GROUP_ID, LOCAL ), LEFT.ADDRESS_GROUP_ID = RIGHT.ADDRESS_GROUP_ID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.ADDRESS_GROUP_ID := le.ADDRESS_GROUP_ID;
    SELF.DID_values := SORT(le.DID_values, -cnt, val, LOCAL);
    SELF.addr_values := SORT(le.addr_values, -cnt, val, LOCAL);
    SELF.locale_values := SORT(le.locale_values, -cnt, val, LOCAL);
    SELF.src_values := SORT(le.src_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.predir_values := SORT(le.predir_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.addr_suffix_values := SORT(le.addr_suffix_values, -cnt, val, LOCAL);
    SELF.addr_ind_values := SORT(le.addr_ind_values, -cnt, val, LOCAL);
    SELF.postdir_values := SORT(le.postdir_values, -cnt, val, LOCAL);
    SELF.unit_desig_values := SORT(le.unit_desig_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.rec_cnt_values := SORT(le.rec_cnt_values, -cnt, val, LOCAL);
    SELF.src_cnt_values := SORT(le.src_cnt_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.ADDRESS_GROUP_ID := le.ADDRESS_GROUP_ID;
  SELF.DID_Values := IF ( (le.DID  IN SET(s.nulls_DID,DID) OR le.DID = (TYPEOF(le.DID))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.DID)}],SALT311.Layout_FieldValueList));
  SELF.addr_Values := IF ( (le.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR le.prim_range_num = (TYPEOF(le.prim_range_num))'') AND (le.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR le.prim_range_alpha = (TYPEOF(le.prim_range_alpha))'') AND (le.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR le.prim_range_fract = (TYPEOF(le.prim_range_fract))'') AND (le.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR le.prim_name_num = (TYPEOF(le.prim_name_num))'') AND (le.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR le.prim_name_alpha = (TYPEOF(le.prim_name_alpha))'') AND (le.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR le.sec_range_num = (TYPEOF(le.sec_range_num))'') AND (le.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR le.sec_range_alpha = (TYPEOF(le.sec_range_alpha))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.prim_range_num) + ' ' + TRIM((SALT311.StrType)le.prim_range_alpha) + ' ' + TRIM((SALT311.StrType)le.prim_range_fract) + ' ' + TRIM((SALT311.StrType)le.prim_name_num) + ' ' + TRIM((SALT311.StrType)le.prim_name_alpha) + ' ' + TRIM((SALT311.StrType)le.sec_range_num) + ' ' + TRIM((SALT311.StrType)le.sec_range_alpha)}],SALT311.Layout_FieldValueList));
  SELF.locale_Values := IF ( (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.city) + ' ' + TRIM((SALT311.StrType)le.st) + ' ' + TRIM((SALT311.StrType)le.zip)}],SALT311.Layout_FieldValueList));
  SELF.src_Values := DATASET([{TRIM((SALT311.StrType)le.src)}],SALT311.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_first_seen)}],SALT311.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_last_seen)}],SALT311.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT311.StrType)le.prim_range)}],SALT311.Layout_FieldValueList);
  SELF.predir_Values := DATASET([{TRIM((SALT311.StrType)le.predir)}],SALT311.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT311.StrType)le.prim_name)}],SALT311.Layout_FieldValueList);
  SELF.addr_suffix_Values := DATASET([{TRIM((SALT311.StrType)le.addr_suffix)}],SALT311.Layout_FieldValueList);
  SELF.addr_ind_Values := DATASET([{TRIM((SALT311.StrType)le.addr_ind)}],SALT311.Layout_FieldValueList);
  SELF.postdir_Values := DATASET([{TRIM((SALT311.StrType)le.postdir)}],SALT311.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT311.StrType)le.unit_desig)}],SALT311.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT311.StrType)le.sec_range)}],SALT311.Layout_FieldValueList);
  SELF.rec_cnt_Values := DATASET([{TRIM((SALT311.StrType)le.rec_cnt)}],SALT311.Layout_FieldValueList);
  SELF.src_cnt_Values := DATASET([{TRIM((SALT311.StrType)le.src_cnt)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.ADDRESS_GROUP_ID := le.ADDRESS_GROUP_ID;
  SELF.DID_Values := IF ( (le.DID  IN SET(s.nulls_DID,DID) OR le.DID = (TYPEOF(le.DID))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.DID)}],SALT311.Layout_FieldValueList));
  SELF.addr_Values := IF ( (le.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR le.prim_range_num = (TYPEOF(le.prim_range_num))'') AND (le.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR le.prim_range_alpha = (TYPEOF(le.prim_range_alpha))'') AND (le.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR le.prim_range_fract = (TYPEOF(le.prim_range_fract))'') AND (le.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR le.prim_name_num = (TYPEOF(le.prim_name_num))'') AND (le.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR le.prim_name_alpha = (TYPEOF(le.prim_name_alpha))'') AND (le.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR le.sec_range_num = (TYPEOF(le.sec_range_num))'') AND (le.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR le.sec_range_alpha = (TYPEOF(le.sec_range_alpha))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.prim_range_num) + ' ' + TRIM((SALT311.StrType)le.prim_range_alpha) + ' ' + TRIM((SALT311.StrType)le.prim_range_fract) + ' ' + TRIM((SALT311.StrType)le.prim_name_num) + ' ' + TRIM((SALT311.StrType)le.prim_name_alpha) + ' ' + TRIM((SALT311.StrType)le.sec_range_num) + ' ' + TRIM((SALT311.StrType)le.sec_range_alpha)}],SALT311.Layout_FieldValueList));
  SELF.locale_Values := IF ( (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.city) + ' ' + TRIM((SALT311.StrType)le.st) + ' ' + TRIM((SALT311.StrType)le.zip)}],SALT311.Layout_FieldValueList));
  SELF.src_Values := DATASET([{TRIM((SALT311.StrType)le.src)}],SALT311.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_first_seen)}],SALT311.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT311.StrType)le.dt_last_seen)}],SALT311.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT311.StrType)le.prim_range)}],SALT311.Layout_FieldValueList);
  SELF.predir_Values := DATASET([{TRIM((SALT311.StrType)le.predir)}],SALT311.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT311.StrType)le.prim_name)}],SALT311.Layout_FieldValueList);
  SELF.addr_suffix_Values := DATASET([{TRIM((SALT311.StrType)le.addr_suffix)}],SALT311.Layout_FieldValueList);
  SELF.addr_ind_Values := DATASET([{TRIM((SALT311.StrType)le.addr_ind)}],SALT311.Layout_FieldValueList);
  SELF.postdir_Values := DATASET([{TRIM((SALT311.StrType)le.postdir)}],SALT311.Layout_FieldValueList);
  SELF.unit_desig_Values := DATASET([{TRIM((SALT311.StrType)le.unit_desig)}],SALT311.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT311.StrType)le.sec_range)}],SALT311.Layout_FieldValueList);
  SELF.rec_cnt_Values := DATASET([{TRIM((SALT311.StrType)le.rec_cnt)}],SALT311.Layout_FieldValueList);
  SELF.src_cnt_Values := DATASET([{TRIM((SALT311.StrType)le.src_cnt)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.addr := if ( le.addr_prop>0, 0, le.addr ); // Blank if propogated
    self.addr_isnull := true; // Flag as null to scoring
    self.addr_prop := 0; // Avoid reducing score later
    self.prim_range_num := if ( le.prim_range_num_prop>0, (TYPEOF(le.prim_range_num))'', le.prim_range_num ); // Blank if propogated
    self.prim_range_num_isnull := le.prim_range_num_prop>0 OR le.prim_range_num_isnull;
    self.prim_range_num_prop := 0; // Avoid reducing score later
    self.prim_range_alpha := if ( le.prim_range_alpha_prop>0, (TYPEOF(le.prim_range_alpha))'', le.prim_range_alpha ); // Blank if propogated
    self.prim_range_alpha_isnull := le.prim_range_alpha_prop>0 OR le.prim_range_alpha_isnull;
    self.prim_range_alpha_prop := 0; // Avoid reducing score later
    self.prim_range_fract := if ( le.prim_range_fract_prop>0, (TYPEOF(le.prim_range_fract))'', le.prim_range_fract ); // Blank if propogated
    self.prim_range_fract_isnull := le.prim_range_fract_prop>0 OR le.prim_range_fract_isnull;
    self.prim_range_fract_prop := 0; // Avoid reducing score later
    self.sec_range_alpha := if ( le.sec_range_alpha_prop>0, (TYPEOF(le.sec_range_alpha))'', le.sec_range_alpha ); // Blank if propogated
    self.sec_range_alpha_isnull := le.sec_range_alpha_prop>0 OR le.sec_range_alpha_isnull;
    self.sec_range_alpha_prop := 0; // Avoid reducing score later
    self.sec_range_num := le.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))-le.sec_range_num_prop]; // Clip propogated chars
    self.sec_range_num_isnull := self.sec_range_num='' OR le.sec_range_num_isnull;
    self.sec_range_num_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 DID_size := 0;
  UNSIGNED1 addr_size := 0;
  UNSIGNED1 locale_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.DID_size := SALT311.Fn_SwitchSpec(s.DID_switch,count(le.DID_values));
  SELF.addr_size := SALT311.Fn_SwitchSpec(s.addr_switch,count(le.addr_values));
  SELF.locale_size := SALT311.Fn_SwitchSpec(s.locale_switch,count(le.locale_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.DID_size+t.addr_size+t.locale_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
