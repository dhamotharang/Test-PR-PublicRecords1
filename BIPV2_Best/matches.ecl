// Begin code to perform the matching itself
IMPORT SALT24,ut;
EXPORT matches(DATASET(layout_Base) ih,UNSIGNED MatchThreshold = 32) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT24.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT24.WithinEditN(le.company_fein,ri.company_fein,1) => SALT24.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        le.company_fein_Right4 = ri.company_fein_Right4 => SALT24.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_Right4_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_Right4_cnt),
                        SALT24.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT24.WithinEditN(le.company_url,ri.company_url,1) => SALT24.fn_fuzzy_specificity(le.company_url_weight100,le.company_url_cnt, le.company_url_e1_cnt,ri.company_url_weight100,ri.company_url_cnt,ri.company_url_e1_cnt),
                        SALT24.Fn_Fail_Scale(le.company_url_weight100,s.company_url_switch));
  INTEGER2 company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT24.WithinEditN(le.company_name,ri.company_name,1) and metaphonelib.dmetaphone1(le.company_name) = metaphonelib.dmetaphone1(ri.company_name) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e1p_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e1p_cnt),
                        SALT24.WithinEditN(le.company_name,ri.company_name,1) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e1_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e1_cnt),
                        metaphonelib.dmetaphone1(le.company_name) = metaphonelib.dmetaphone1(ri.company_name) => SALT24.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_p_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_p_cnt),
                        SALT24.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  INTEGER2 company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        SALT24.WithinEditN(le.company_phone,ri.company_phone,1) => SALT24.fn_fuzzy_specificity(le.company_phone_weight100,le.company_phone_cnt, le.company_phone_e1_cnt,ri.company_phone_weight100,ri.company_phone_cnt,ri.company_phone_e1_cnt),
                        SALT24.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.company_prim_range_isnull AND le.company_predir_isnull AND le.company_prim_name_isnull AND le.company_addr_suffix_isnull AND le.company_postdir_isnull AND le.company_unit_desig_isnull AND le.company_sec_range_isnull) AND (le.company_csz_isnull OR le.company_v_city_name_isnull AND le.company_st_isnull AND le.company_zip5_isnull AND le.company_zip4_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.company_prim_range_isnull AND ri.company_predir_isnull AND ri.company_prim_name_isnull AND ri.company_addr_suffix_isnull AND ri.company_postdir_isnull AND ri.company_unit_desig_isnull AND ri.company_sec_range_isnull) AND (ri.company_csz_isnull OR ri.company_v_city_name_isnull AND ri.company_st_isnull AND ri.company_zip5_isnull AND ri.company_zip4_isnull)) => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  INTEGER2 company_p_city_name_score := MAP( le.company_p_city_name_isnull OR ri.company_p_city_name_isnull => 0,
                        le.company_p_city_name = ri.company_p_city_name  => le.company_p_city_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_p_city_name_weight100,s.company_p_city_name_switch));
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.company_v_city_name_weight100 + ri.company_v_city_name_weight100 + le.company_st_weight100 + ri.company_st_weight100 + le.company_zip5_weight100 + ri.company_zip5_weight100 + le.company_zip4_weight100 + ri.company_zip4_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.company_v_city_name_isnull AND le.company_st_isnull AND le.company_zip5_isnull AND le.company_zip4_isnull) OR (ri.company_csz_isnull OR ri.company_v_city_name_isnull AND ri.company_st_isnull AND ri.company_zip5_isnull AND ri.company_zip4_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.company_prim_range_weight100 + ri.company_prim_range_weight100 + le.company_predir_weight100 + ri.company_predir_weight100 + le.company_prim_name_weight100 + ri.company_prim_name_weight100 + le.company_addr_suffix_weight100 + ri.company_addr_suffix_weight100 + le.company_postdir_weight100 + ri.company_postdir_weight100 + le.company_unit_desig_weight100 + ri.company_unit_desig_weight100 + le.company_sec_range_weight100 + ri.company_sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.company_prim_range_isnull AND le.company_predir_isnull AND le.company_prim_name_isnull AND le.company_addr_suffix_isnull AND le.company_postdir_isnull AND le.company_unit_desig_isnull AND le.company_sec_range_isnull) OR (ri.company_addr1_isnull OR ri.company_prim_range_isnull AND ri.company_predir_isnull AND ri.company_prim_name_isnull AND ri.company_addr_suffix_isnull AND ri.company_postdir_isnull AND ri.company_unit_desig_isnull AND ri.company_sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  INTEGER2 company_prim_name_score := MAP( le.company_prim_name_isnull OR ri.company_prim_name_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_prim_name = ri.company_prim_name  => le.company_prim_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_prim_name_weight100,s.company_prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_zip4_score := MAP( le.company_zip4_isnull OR ri.company_zip4_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_zip4 = ri.company_zip4  => le.company_zip4_weight100,
                        SALT24.Fn_Fail_Scale(le.company_zip4_weight100,s.company_zip4_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 company_prim_range_score := MAP( le.company_prim_range_isnull OR ri.company_prim_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_prim_range = ri.company_prim_range  => le.company_prim_range_weight100,
                        SALT24.Fn_Fail_Scale(le.company_prim_range_weight100,s.company_prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_sec_range_score_temp := MAP( le.company_sec_range_isnull OR ri.company_sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_sec_range = ri.company_sec_range  => le.company_sec_range_weight100,
                        SALT24.Fn_Fail_Scale(le.company_sec_range_weight100,s.company_sec_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_sec_range_score := IF ( company_sec_range_score_temp >= 0, company_sec_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 company_postdir_score := MAP( le.company_postdir_isnull OR ri.company_postdir_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_postdir = ri.company_postdir  => le.company_postdir_weight100,
                        SALT24.Fn_Fail_Scale(le.company_postdir_weight100,s.company_postdir_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_zip5_score := MAP( le.company_zip5_isnull OR ri.company_zip5_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_zip5 = ri.company_zip5  => le.company_zip5_weight100,
                        SALT24.Fn_Fail_Scale(le.company_zip5_weight100,s.company_zip5_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 company_predir_score := MAP( le.company_predir_isnull OR ri.company_predir_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_predir = ri.company_predir  => le.company_predir_weight100,
                        SALT24.Fn_Fail_Scale(le.company_predir_weight100,s.company_predir_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_unit_desig_score := MAP( le.company_unit_desig_isnull OR ri.company_unit_desig_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_unit_desig = ri.company_unit_desig  => le.company_unit_desig_weight100,
                        SALT24.Fn_Fail_Scale(le.company_unit_desig_weight100,s.company_unit_desig_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_st_score := MAP( le.company_st_isnull OR ri.company_st_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_st = ri.company_st  => le.company_st_weight100,
                        SALT24.Fn_Fail_Scale(le.company_st_weight100,s.company_st_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 company_addr_suffix_score := MAP( le.company_addr_suffix_isnull OR ri.company_addr_suffix_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr_suffix = ri.company_addr_suffix  => le.company_addr_suffix_weight100,
                        SALT24.Fn_Fail_Scale(le.company_addr_suffix_weight100,s.company_addr_suffix_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 company_v_city_name_score := MAP( le.company_v_city_name_isnull OR ri.company_v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_v_city_name = ri.company_v_city_name  => le.company_v_city_name_weight100,
                        SALT24.Fn_Fail_Scale(le.company_v_city_name_weight100,s.company_v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + company_v_city_name_score + company_st_score + company_zip5_score + company_zip4_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := company_csz_score_res;
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + company_prim_range_score + company_predir_score + company_prim_name_score + company_addr_suffix_score + company_postdir_score + company_unit_desig_score + company_sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := company_addr1_score_res;
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ company_addr1_score + company_prim_range_score + company_predir_score + company_prim_name_score + company_addr_suffix_score + company_postdir_score + company_unit_desig_score + company_sec_range_score+ company_csz_score + company_v_city_name_score + company_st_score + company_zip5_score + company_zip4_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  INTEGER2 company_address_score := company_address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.company_url_prop,ri.company_url_prop)*company_url_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*company_name_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (company_fein_score + company_url_score + company_name_score + company_phone_score + company_csz_score + company_addr1_score + company_address_score + company_prim_name_score + company_zip4_score + company_prim_range_score + company_sec_range_score + company_p_city_name_score + company_postdir_score + company_zip5_score + company_predir_score + company_unit_desig_score + company_st_score + company_addr_suffix_score + company_v_city_name_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':company_fein',
  n = 1 => ':company_url',
  n = 2 => ':company_name',
  n = 3 => ':company_phone',
  n = 4 => ':company_prim_name:*',
  n = 10 => ':company_zip4:*',
  n = 15 => ':company_prim_range:*',
  n = 19 => ':company_sec_range:*',
  n = 22 => ':company_p_city_name:company_postdir','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 23 join conditions of which 14 have been optimized into preceding conditions
//Fixed fields ->:company_fein(27)
dn0 := h(~company_fein_isnull);
dn0_deduped := dn0(company_fein_weight100>=1600); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_fein = RIGHT.company_fein AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull ),match_join(LEFT,RIGHT,0),ATMOST(LEFT.company_fein = RIGHT.company_fein,1000),SKEW(1));
//Fixed fields ->:company_url(27)
dn1 := h(~company_url_isnull);
dn1_deduped := dn1(company_url_weight100>=1600); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_url = RIGHT.company_url AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull ),match_join(LEFT,RIGHT,1),ATMOST(LEFT.company_url = RIGHT.company_url,1000),SKEW(1));
//Fixed fields ->:company_name(19)
dn2 := h(~company_name_isnull);
dn2_deduped := dn2(company_name_weight100>=1600); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_name = RIGHT.company_name AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull ),match_join(LEFT,RIGHT,2),ATMOST(LEFT.company_name = RIGHT.company_name,1000),SKEW(1));
//Fixed fields ->:company_phone(19)
dn3 := h(~company_phone_isnull);
dn3_deduped := dn3(company_phone_weight100>=1600); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_phone = RIGHT.company_phone AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull ),match_join(LEFT,RIGHT,3),ATMOST(LEFT.company_phone = RIGHT.company_phone,1000),SKEW(1));
//First 1 fields shared with following 5 joins - optimization performed
//Fixed fields ->:company_prim_name(12):company_zip4(12) also :company_prim_name(12):company_prim_range(11) also :company_prim_name(12):company_sec_range(11) also :company_prim_name(12):company_p_city_name(10) also :company_prim_name(12):company_postdir(6) also :company_prim_name(12):company_zip5(5)
dn4 := h(~company_prim_name_isnull);
dn4_deduped := dn4(company_prim_name_weight100>=1200); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_prim_name = RIGHT.company_prim_name AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull )
    AND (
          LEFT.company_zip4 = RIGHT.company_zip4 AND ~LEFT.company_zip4_isnull
    OR    LEFT.company_prim_range = RIGHT.company_prim_range AND ~LEFT.company_prim_range_isnull
    OR    LEFT.company_sec_range = RIGHT.company_sec_range AND ~LEFT.company_sec_range_isnull
    OR    LEFT.company_p_city_name = RIGHT.company_p_city_name AND ~LEFT.company_p_city_name_isnull
    OR    LEFT.company_postdir = RIGHT.company_postdir AND ~LEFT.company_postdir_isnull
    OR    LEFT.company_zip5 = RIGHT.company_zip5 AND ~LEFT.company_zip5_isnull
        ),match_join(LEFT,RIGHT,4),ATMOST(LEFT.company_prim_name = RIGHT.company_prim_name,1000),SKEW(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT24.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : persist('temp::BIPV2_Best::Proxid::mj0');
//First 1 fields shared with following 4 joins - optimization performed
//Fixed fields ->:company_zip4(12):company_prim_range(11) also :company_zip4(12):company_sec_range(11) also :company_zip4(12):company_p_city_name(10) also :company_zip4(12):company_postdir(6) also :company_zip4(12):company_zip5(5)
dn10 := h(~company_zip4_isnull);
dn10_deduped := dn10(company_zip4_weight100>=1200); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_zip4 = RIGHT.company_zip4 AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull )
    AND (
          LEFT.company_prim_range = RIGHT.company_prim_range AND ~LEFT.company_prim_range_isnull
    OR    LEFT.company_sec_range = RIGHT.company_sec_range AND ~LEFT.company_sec_range_isnull
    OR    LEFT.company_p_city_name = RIGHT.company_p_city_name AND ~LEFT.company_p_city_name_isnull
    OR    LEFT.company_postdir = RIGHT.company_postdir AND ~LEFT.company_postdir_isnull
    OR    LEFT.company_zip5 = RIGHT.company_zip5 AND ~LEFT.company_zip5_isnull
        ),match_join(LEFT,RIGHT,10),ATMOST(LEFT.company_zip4 = RIGHT.company_zip4,1000),SKEW(1));
mjs1_t := mj10;
SALT24.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : persist('temp::BIPV2_Best::Proxid::mj1');
//First 1 fields shared with following 3 joins - optimization performed
//Fixed fields ->:company_prim_range(11):company_sec_range(11) also :company_prim_range(11):company_p_city_name(10) also :company_prim_range(11):company_postdir(6) also :company_prim_range(11):company_zip5(5)
dn15 := h(~company_prim_range_isnull);
dn15_deduped := dn15(company_prim_range_weight100>=1200); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_prim_range = RIGHT.company_prim_range AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull )
    AND (
          LEFT.company_sec_range = RIGHT.company_sec_range AND ~LEFT.company_sec_range_isnull
    OR    LEFT.company_p_city_name = RIGHT.company_p_city_name AND ~LEFT.company_p_city_name_isnull
    OR    LEFT.company_postdir = RIGHT.company_postdir AND ~LEFT.company_postdir_isnull
    OR    LEFT.company_zip5 = RIGHT.company_zip5 AND ~LEFT.company_zip5_isnull
        ),match_join(LEFT,RIGHT,15),ATMOST(LEFT.company_prim_range = RIGHT.company_prim_range,1000),SKEW(1));
//First 1 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_sec_range(11):company_p_city_name(10) also :company_sec_range(11):company_postdir(6) also :company_sec_range(11):company_zip5(5)
dn19 := h(~company_sec_range_isnull);
dn19_deduped := dn19(company_sec_range_weight100>=1200); // Use specificity to flag high-dup counts
mj19 := JOIN( dn19_deduped, dn19_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_sec_range = RIGHT.company_sec_range AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull )
    AND (
          LEFT.company_p_city_name = RIGHT.company_p_city_name AND ~LEFT.company_p_city_name_isnull
    OR    LEFT.company_postdir = RIGHT.company_postdir AND ~LEFT.company_postdir_isnull
    OR    LEFT.company_zip5 = RIGHT.company_zip5 AND ~LEFT.company_zip5_isnull
        ),match_join(LEFT,RIGHT,19),ATMOST(LEFT.company_sec_range = RIGHT.company_sec_range,1000),SKEW(1));
mjs2_t := mj15+mj19;
SALT24.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : persist('temp::BIPV2_Best::Proxid::mj2');
//Fixed fields ->:company_p_city_name(10):company_postdir(6)
dn22 := h(~company_p_city_name_isnull AND ~company_postdir_isnull);
dn22_deduped := dn22(company_p_city_name_weight100 + company_postdir_weight100>=1600); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_p_city_name = RIGHT.company_p_city_name AND LEFT.company_postdir = RIGHT.company_postdir AND ( left.company_sec_range = right.company_sec_range OR left.company_sec_range_isnull OR right.company_sec_range_isnull ),match_join(LEFT,RIGHT,22),ATMOST(LEFT.company_p_city_name = RIGHT.company_p_city_name AND LEFT.company_postdir = RIGHT.company_postdir,1000),SKEW(1));
last_mjs_t :=mj22;
SALT24.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2 +o;
export All_Matches := all_mjs : persist('temp::BIPV2_Best_Proxid_Base_all_m'); // To by used by rcid and Proxid
SALT24.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::BIPV2_Best_Proxid_Base_mt');
SALT24.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('temp::BIPV2_Best_Proxid_Base_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT24.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('temp::BIPV2_Best_Proxid_Base_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT24.UIDType rcid;  //Outcast
  SALT24.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT24.UIDType Pref_rcid; // Prefers this record
  SALT24.UIDType Pref_Proxid; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.Proxid := le.Proxid1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_Proxid := ri.Proxid2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid1 AND LEFT.Pref_Proxid=RIGHT.Proxid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid2 AND LEFT.Pref_Proxid=RIGHT.Proxid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Proxid)),Proxid,-Pref_Margin,LOCAL),Proxid,LOCAL); // 1024x better in new place
SALT24.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
EXPORT Matches := m(Conf>=MatchThreshold);
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
//Now actually produce the new file
SALT24.MAC_SliceOut_ByRID(ih,rcid,Proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
  bf := Best(ih).In_Flagged; // Input values flagged
  TYPEOF(o) AppendFlags(o le,bf ri) := TRANSFORM
    SELF.company_fein_flag := ri.company_fein_flag; // Either value - or null if no-match
    SELF.company_url_flag := ri.company_url_flag; // Either value - or null if no-match
    SELF.company_name_flag := ri.company_name_flag; // Either value - or null if no-match
    SELF.company_phone_flag := ri.company_phone_flag; // Either value - or null if no-match
    SELF.company_address_flag := ri.company_address_flag; // Either value - or null if no-match
    SELF := le;
  END;
  j := JOIN(o,bf,LEFT.Proxid = RIGHT.Proxid AND LEFT.rcid = RIGHT.rcid,AppendFlags(LEFT,RIGHT),LEFT OUTER); // Only take if cluster id unchanged for record
EXPORT Patched_Infile := j;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Proxid,Matches,Proxid1,Proxid2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreClusters := hygiene(ih).ClusterCounts;
EXPORT PostClusters := hygiene(Patched_Infile).ClusterCounts;
EXPORT PrePatchIdCount := SUM( PreClusters, NumberOfClusters );
EXPORT PostPatchIdCount := SUM( PostClusters, NumberOfClusters );
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rcid,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(Proxid=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(Proxid>rcid)); // Should be zero
END;
