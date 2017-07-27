// Various routines to assist in debugging
IMPORT SALT24,ut;
EXPORT Debug(DATASET(layout_Base) ih, Layout_Specificities.R s, MatchThreshold = 32) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT24.UIDType Proxid1;
  SALT24.UIDType Proxid2;
  SALT24.UIDType rcid1;
  SALT24.UIDType rcid2;
  typeof(h.company_fein) left_company_fein;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.company_url) left_company_url;
  INTEGER2 company_url_score;
  typeof(h.company_url) right_company_url;
  typeof(h.company_name) left_company_name;
  INTEGER2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.company_phone) left_company_phone;
  INTEGER2 company_phone_score;
  typeof(h.company_phone) right_company_phone;
  typeof(h.company_csz) left_company_csz;
  INTEGER2 company_csz_score;
  typeof(h.company_csz) right_company_csz;
  typeof(h.company_addr1) left_company_addr1;
  INTEGER2 company_addr1_score;
  typeof(h.company_addr1) right_company_addr1;
  typeof(h.company_address) left_company_address;
  INTEGER2 company_address_score;
  typeof(h.company_address) right_company_address;
  typeof(h.company_prim_name) left_company_prim_name;
  INTEGER2 company_prim_name_score;
  typeof(h.company_prim_name) right_company_prim_name;
  typeof(h.company_zip4) left_company_zip4;
  INTEGER2 company_zip4_score;
  typeof(h.company_zip4) right_company_zip4;
  typeof(h.company_prim_range) left_company_prim_range;
  INTEGER2 company_prim_range_score;
  typeof(h.company_prim_range) right_company_prim_range;
  typeof(h.company_sec_range) left_company_sec_range;
  INTEGER2 company_sec_range_score;
  BOOLEAN company_sec_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_sec_range) right_company_sec_range;
  typeof(h.company_p_city_name) left_company_p_city_name;
  INTEGER2 company_p_city_name_score;
  typeof(h.company_p_city_name) right_company_p_city_name;
  typeof(h.company_postdir) left_company_postdir;
  INTEGER2 company_postdir_score;
  typeof(h.company_postdir) right_company_postdir;
  typeof(h.company_zip5) left_company_zip5;
  INTEGER2 company_zip5_score;
  typeof(h.company_zip5) right_company_zip5;
  typeof(h.company_predir) left_company_predir;
  INTEGER2 company_predir_score;
  typeof(h.company_predir) right_company_predir;
  typeof(h.company_unit_desig) left_company_unit_desig;
  INTEGER2 company_unit_desig_score;
  typeof(h.company_unit_desig) right_company_unit_desig;
  typeof(h.company_st) left_company_st;
  INTEGER2 company_st_score;
  typeof(h.company_st) right_company_st;
  typeof(h.company_addr_suffix) left_company_addr_suffix;
  INTEGER2 company_addr_suffix_score;
  typeof(h.company_addr_suffix) right_company_addr_suffix;
  typeof(h.company_v_city_name) left_company_v_city_name;
  INTEGER2 company_v_city_name_score;
  typeof(h.company_v_city_name) right_company_v_city_name;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.source) left_source;
  typeof(h.source) right_source;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT24.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT24.WithinEditN(le.company_fein,ri.company_fein,1) => SALT24.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        le.company_fein_Right4 = ri.company_fein_Right4 => SALT24.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_Right4_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_Right4_cnt),
                        SALT24.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT24.WithinEditN(le.company_url,ri.company_url,1) => SALT24.fn_fuzzy_specificity(le.company_url_weight100,le.company_url_cnt, le.company_url_e1_cnt,ri.company_url_weight100,ri.company_url_cnt,ri.company_url_e1_cnt),
                        SALT24.Fn_Fail_Scale(le.company_url_weight100,s.company_url_switch));
  SELF.left_company_url := le.company_url;
  SELF.right_company_url := ri.company_url;
  SELF.company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT24.WithinEditN(le.company_name,ri.company_name,1) and metaphonelib.dmetaphone1(le.company_name) = metaphonelib.dmetaphone1(ri.company_name) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e1p_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e1p_cnt),
                        SALT24.WithinEditN(le.company_name,ri.company_name,1) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e1_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e1_cnt),
                        metaphonelib.dmetaphone1(le.company_name) = metaphonelib.dmetaphone1(ri.company_name) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_p_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_p_cnt),
                        SALT24.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        SALT24.WithinEditN(le.company_phone,ri.company_phone,1) => SALT24.fn_fuzzy_specificity(le.company_phone_weight100,le.company_phone_cnt, le.company_phone_e1_cnt,ri.company_phone_weight100,ri.company_phone_cnt,ri.company_phone_e1_cnt),
                        SALT24.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.company_prim_range_isnull AND le.company_predir_isnull AND le.company_prim_name_isnull AND le.company_addr_suffix_isnull AND le.company_postdir_isnull AND le.company_unit_desig_isnull AND le.company_sec_range_isnull) AND (le.company_csz_isnull OR le.company_v_city_name_isnull AND le.company_st_isnull AND le.company_zip5_isnull AND le.company_zip4_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.company_prim_range_isnull AND ri.company_predir_isnull AND ri.company_prim_name_isnull AND ri.company_addr_suffix_isnull AND ri.company_postdir_isnull AND ri.company_unit_desig_isnull AND ri.company_sec_range_isnull) AND (ri.company_csz_isnull OR ri.company_v_city_name_isnull AND ri.company_st_isnull AND ri.company_zip5_isnull AND ri.company_zip4_isnull)) => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  SELF.left_company_address := le.company_address;
  SELF.right_company_address := ri.company_address;
  SELF.company_p_city_name_score := MAP( le.company_p_city_name_isnull OR ri.company_p_city_name_isnull => 0,
                        le.company_p_city_name = ri.company_p_city_name  => le.company_p_city_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_p_city_name_weight100,s.company_p_city_name_switch));
  SELF.left_company_p_city_name := le.company_p_city_name;
  SELF.right_company_p_city_name := ri.company_p_city_name;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_source := le.source;
  SELF.right_source := ri.source;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.company_v_city_name_weight100 + ri.company_v_city_name_weight100 + le.company_st_weight100 + ri.company_st_weight100 + le.company_zip5_weight100 + ri.company_zip5_weight100 + le.company_zip4_weight100 + ri.company_zip4_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.company_v_city_name_isnull AND le.company_st_isnull AND le.company_zip5_isnull AND le.company_zip4_isnull) OR (ri.company_csz_isnull OR ri.company_v_city_name_isnull AND ri.company_st_isnull AND ri.company_zip5_isnull AND ri.company_zip4_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_csz := le.company_csz;
  SELF.right_company_csz := ri.company_csz;
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.company_prim_range_weight100 + ri.company_prim_range_weight100 + le.company_predir_weight100 + ri.company_predir_weight100 + le.company_prim_name_weight100 + ri.company_prim_name_weight100 + le.company_addr_suffix_weight100 + ri.company_addr_suffix_weight100 + le.company_postdir_weight100 + ri.company_postdir_weight100 + le.company_unit_desig_weight100 + ri.company_unit_desig_weight100 + le.company_sec_range_weight100 + ri.company_sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.company_prim_range_isnull AND le.company_predir_isnull AND le.company_prim_name_isnull AND le.company_addr_suffix_isnull AND le.company_postdir_isnull AND le.company_unit_desig_isnull AND le.company_sec_range_isnull) OR (ri.company_addr1_isnull OR ri.company_prim_range_isnull AND ri.company_predir_isnull AND ri.company_prim_name_isnull AND ri.company_addr_suffix_isnull AND ri.company_postdir_isnull AND ri.company_unit_desig_isnull AND ri.company_sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_addr1 := le.company_addr1;
  SELF.right_company_addr1 := ri.company_addr1;
  SELF.company_prim_name_score := MAP( le.company_prim_name_isnull OR ri.company_prim_name_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_prim_name = ri.company_prim_name  => le.company_prim_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_prim_name_weight100,s.company_prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_prim_name := le.company_prim_name;
  SELF.right_company_prim_name := ri.company_prim_name;
  SELF.company_zip4_score := MAP( le.company_zip4_isnull OR ri.company_zip4_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_zip4 = ri.company_zip4  => le.company_zip4_weight100,
                        SALT24.Fn_Fail_Scale(le.company_zip4_weight100,s.company_zip4_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_company_zip4 := le.company_zip4;
  SELF.right_company_zip4 := ri.company_zip4;
  SELF.company_prim_range_score := MAP( le.company_prim_range_isnull OR ri.company_prim_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_prim_range = ri.company_prim_range  => le.company_prim_range_weight100,
                        SALT24.Fn_Fail_Scale(le.company_prim_range_weight100,s.company_prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_prim_range := le.company_prim_range;
  SELF.right_company_prim_range := ri.company_prim_range;
  INTEGER2 company_sec_range_score_temp := MAP( le.company_sec_range_isnull OR ri.company_sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_sec_range = ri.company_sec_range  => le.company_sec_range_weight100,
                        SALT24.Fn_Fail_Scale(le.company_sec_range_weight100,s.company_sec_range_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.company_sec_range_score := IF ( company_sec_range_score_temp >= 0, company_sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.company_sec_range_skipped := SELF.company_sec_range_score < -5000;// Enforce FORCE parameter
  SELF.left_company_sec_range := le.company_sec_range;
  SELF.right_company_sec_range := ri.company_sec_range;
  SELF.company_postdir_score := MAP( le.company_postdir_isnull OR ri.company_postdir_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_postdir = ri.company_postdir  => le.company_postdir_weight100,
                        SALT24.Fn_Fail_Scale(le.company_postdir_weight100,s.company_postdir_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_postdir := le.company_postdir;
  SELF.right_company_postdir := ri.company_postdir;
  SELF.company_zip5_score := MAP( le.company_zip5_isnull OR ri.company_zip5_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_zip5 = ri.company_zip5  => le.company_zip5_weight100,
                        SALT24.Fn_Fail_Scale(le.company_zip5_weight100,s.company_zip5_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_company_zip5 := le.company_zip5;
  SELF.right_company_zip5 := ri.company_zip5;
  SELF.company_predir_score := MAP( le.company_predir_isnull OR ri.company_predir_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_predir = ri.company_predir  => le.company_predir_weight100,
                        SALT24.Fn_Fail_Scale(le.company_predir_weight100,s.company_predir_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_predir := le.company_predir;
  SELF.right_company_predir := ri.company_predir;
  SELF.company_unit_desig_score := MAP( le.company_unit_desig_isnull OR ri.company_unit_desig_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_unit_desig = ri.company_unit_desig  => le.company_unit_desig_weight100,
                        SALT24.Fn_Fail_Scale(le.company_unit_desig_weight100,s.company_unit_desig_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_unit_desig := le.company_unit_desig;
  SELF.right_company_unit_desig := ri.company_unit_desig;
  SELF.company_st_score := MAP( le.company_st_isnull OR ri.company_st_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_st = ri.company_st  => le.company_st_weight100,
                        SALT24.Fn_Fail_Scale(le.company_st_weight100,s.company_st_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_company_st := le.company_st;
  SELF.right_company_st := ri.company_st;
  SELF.company_addr_suffix_score := MAP( le.company_addr_suffix_isnull OR ri.company_addr_suffix_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr_suffix = ri.company_addr_suffix  => le.company_addr_suffix_weight100,
                        SALT24.Fn_Fail_Scale(le.company_addr_suffix_weight100,s.company_addr_suffix_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_company_addr_suffix := le.company_addr_suffix;
  SELF.right_company_addr_suffix := ri.company_addr_suffix;
  SELF.company_v_city_name_score := MAP( le.company_v_city_name_isnull OR ri.company_v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_v_city_name = ri.company_v_city_name  => le.company_v_city_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_v_city_name_weight100,s.company_v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_company_v_city_name := le.company_v_city_name;
  SELF.right_company_v_city_name := ri.company_v_city_name;
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + self.company_v_city_name_score + self.company_st_score + self.company_zip5_score + self.company_zip4_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  SELF.company_csz_score := company_csz_score_res;
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + self.company_prim_range_score + self.company_predir_score + self.company_prim_name_score + self.company_addr_suffix_score + self.company_postdir_score + self.company_unit_desig_score + self.company_sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  SELF.company_addr1_score := company_addr1_score_res;
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ SELF.company_addr1_score + self.company_prim_range_score + self.company_predir_score + self.company_prim_name_score + self.company_addr_suffix_score + self.company_postdir_score + self.company_unit_desig_score + self.company_sec_range_score+ SELF.company_csz_score + self.company_v_city_name_score + self.company_st_score + self.company_zip5_score + self.company_zip4_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  SELF.company_address_score := company_address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.company_url_prop,ri.company_url_prop)*SELF.company_url_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*SELF.company_name_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*SELF.company_phone_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.company_fein_score + SELF.company_url_score + SELF.company_name_score + SELF.company_phone_score + SELF.company_csz_score + SELF.company_addr1_score + SELF.company_address_score + SELF.company_prim_name_score + SELF.company_zip4_score + SELF.company_prim_range_score + SELF.company_sec_range_score + SELF.company_p_city_name_score + SELF.company_postdir_score + SELF.company_zip5_score + SELF.company_predir_score + SELF.company_unit_desig_score + SELF.company_st_score + SELF.company_addr_suffix_score + SELF.company_v_city_name_score) / 100 + outside;
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
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT24.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
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
  SALT24.UIDType Proxid;
  DATASET(SALT24.Layout_FieldValueList) company_fein_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) company_url_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) company_name_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) company_phone_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) company_address_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) company_p_city_name_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT24.Layout_FieldValueList);
  DATASET(SALT24.Layout_FieldValueList) source_Values := DATASET([],SALT24.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.company_fein_values := SALT24.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_url_values := SALT24.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
  SELF.company_name_values := SALT24.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.company_phone_values := SALT24.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.company_address_values := SALT24.fn_combine_fieldvaluelist(le.company_address_values,ri.company_address_values);
  SELF.company_p_city_name_values := SALT24.fn_combine_fieldvaluelist(le.company_p_city_name_values,ri.company_p_city_name_values);
  SELF.dt_first_seen_values := SALT24.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT24.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  SELF.source_values := SALT24.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Proxid) ), Proxid, LOCAL ), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_fein)}],SALT24.Layout_FieldValueList));
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_url)}],SALT24.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_name)}],SALT24.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_phone)}],SALT24.Layout_FieldValueList));
  self.company_address_Values := IF ( le.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND le.company_predir  IN SET(s.nulls_company_predir,company_predir) AND le.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND le.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND le.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND le.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND le.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range) AND le.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND le.company_st  IN SET(s.nulls_company_st,company_st) AND le.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND le.company_zip4  IN SET(s.nulls_company_zip4,company_zip4),dataset([],SALT24.Layout_FieldValueList),dataset([{TRIM((SALT24.StrType)le.company_prim_range) + ' ' + TRIM((SALT24.StrType)le.company_predir) + ' ' + TRIM((SALT24.StrType)le.company_prim_name) + ' ' + TRIM((SALT24.StrType)le.company_addr_suffix) + ' ' + TRIM((SALT24.StrType)le.company_postdir) + ' ' + TRIM((SALT24.StrType)le.company_unit_desig) + ' ' + TRIM((SALT24.StrType)le.company_sec_range) + ' ' + TRIM((SALT24.StrType)le.company_v_city_name) + ' ' + TRIM((SALT24.StrType)le.company_st) + ' ' + TRIM((SALT24.StrType)le.company_zip5) + ' ' + TRIM((SALT24.StrType)le.company_zip4)}],SALT24.Layout_FieldValueList));
  SELF.company_p_city_name_Values := IF ( le.company_p_city_name  IN SET(s.nulls_company_p_city_name,company_p_city_name),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_p_city_name)}],SALT24.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT24.StrType)le.dt_first_seen)}],SALT24.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT24.StrType)le.dt_last_seen)}],SALT24.Layout_FieldValueList);
  SELF.source_Values := DATASET([{TRIM((SALT24.StrType)le.source)}],SALT24.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := transform
  self.Proxid := le.Proxid;
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_fein)}],SALT24.Layout_FieldValueList));
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_url)}],SALT24.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_name)}],SALT24.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_phone)}],SALT24.Layout_FieldValueList));
  self.company_address_Values := IF ( le.company_prim_range  IN SET(s.nulls_company_prim_range,company_prim_range) AND le.company_predir  IN SET(s.nulls_company_predir,company_predir) AND le.company_prim_name  IN SET(s.nulls_company_prim_name,company_prim_name) AND le.company_addr_suffix  IN SET(s.nulls_company_addr_suffix,company_addr_suffix) AND le.company_postdir  IN SET(s.nulls_company_postdir,company_postdir) AND le.company_unit_desig  IN SET(s.nulls_company_unit_desig,company_unit_desig) AND le.company_sec_range  IN SET(s.nulls_company_sec_range,company_sec_range) AND le.company_v_city_name  IN SET(s.nulls_company_v_city_name,company_v_city_name) AND le.company_st  IN SET(s.nulls_company_st,company_st) AND le.company_zip5  IN SET(s.nulls_company_zip5,company_zip5) AND le.company_zip4  IN SET(s.nulls_company_zip4,company_zip4),dataset([],SALT24.Layout_FieldValueList),dataset([{TRIM((SALT24.StrType)le.company_prim_range) + ' ' + TRIM((SALT24.StrType)le.company_predir) + ' ' + TRIM((SALT24.StrType)le.company_prim_name) + ' ' + TRIM((SALT24.StrType)le.company_addr_suffix) + ' ' + TRIM((SALT24.StrType)le.company_postdir) + ' ' + TRIM((SALT24.StrType)le.company_unit_desig) + ' ' + TRIM((SALT24.StrType)le.company_sec_range) + ' ' + TRIM((SALT24.StrType)le.company_v_city_name) + ' ' + TRIM((SALT24.StrType)le.company_st) + ' ' + TRIM((SALT24.StrType)le.company_zip5) + ' ' + TRIM((SALT24.StrType)le.company_zip4)}],SALT24.Layout_FieldValueList));
  SELF.company_p_city_name_Values := IF ( le.company_p_city_name  IN SET(s.nulls_company_p_city_name,company_p_city_name),DATASET([],SALT24.Layout_FieldValueList),DATASET([{TRIM((SALT24.StrType)le.company_p_city_name)}],SALT24.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT24.StrType)le.dt_first_seen)}],SALT24.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT24.StrType)le.dt_last_seen)}],SALT24.Layout_FieldValueList);
  SELF.source_Values := DATASET([{TRIM((SALT24.StrType)le.source)}],SALT24.Layout_FieldValueList);
end;
AsFieldValues := project(ih,into(left));
export InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_url := if ( le.company_url_prop>0, (TYPEOF(le.company_url))'', le.company_url ); // Blank if propogated
    self.company_url_isnull := le.company_url_prop>0 OR le.company_url_isnull;
    self.company_url_prop := 0; // Avoid reducing score later
    self.company_name := if ( le.company_name_prop>0, (TYPEOF(le.company_name))'', le.company_name ); // Blank if propogated
    self.company_name_isnull := le.company_name_prop>0 OR le.company_name_isnull;
    self.company_name_prop := 0; // Avoid reducing score later
    self.company_phone := if ( le.company_phone_prop>0, (TYPEOF(le.company_phone))'', le.company_phone ); // Blank if propogated
    self.company_phone_isnull := le.company_phone_prop>0 OR le.company_phone_isnull;
    self.company_phone_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_url_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 company_phone_size := 0;
  UNSIGNED1 company_address_size := 0;
  UNSIGNED1 company_p_city_name_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.company_fein_size := SALT24.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_url_size := SALT24.Fn_SwitchSpec(s.company_url_switch,count(le.company_url_values));
  SELF.company_name_size := SALT24.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.company_phone_size := SALT24.Fn_SwitchSpec(s.company_phone_switch,count(le.company_phone_values));
  SELF.company_address_size := SALT24.Fn_SwitchSpec(s.company_address_switch,count(le.company_address_values));
  SELF.company_p_city_name_size := SALT24.Fn_SwitchSpec(s.company_p_city_name_switch,count(le.company_p_city_name_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.company_fein_size+t.company_url_size+t.company_name_size+t.company_phone_size+t.company_address_size+t.company_p_city_name_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
