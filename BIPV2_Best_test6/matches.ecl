// Begin code to perform the matching itself
IMPORT SALT27,ut;
EXPORT matches(DATASET(layout_Base) ih,UNSIGNED MatchThreshold = 41) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT27.WithinEditN(le.company_url,ri.company_url,1) => SALT27.fn_fuzzy_specificity(le.company_url_weight100,le.company_url_cnt, le.company_url_e1_cnt,ri.company_url_weight100,ri.company_url_cnt,ri.company_url_e1_cnt),
                        SALT27.Fn_Fail_Scale(le.company_url_weight100,s.company_url_switch));
  INTEGER2 company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT27.WithinEditN(le.company_name,ri.company_name,2) => SALT27.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e2_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e2_cnt),
                        SALT27.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT27.WithinEditN(le.company_fein,ri.company_fein,1) => SALT27.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        le.company_fein_Right4 = ri.company_fein_Right4 => SALT27.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_Right4_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_Right4_cnt),
                        SALT27.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        SALT27.WithinEditN(le.company_phone,ri.company_phone,1) => SALT27.fn_fuzzy_specificity(le.company_phone_weight100,le.company_phone_cnt, le.company_phone_e1_cnt,ri.company_phone_weight100,ri.company_phone_cnt,ri.company_phone_e1_cnt),
                        SALT27.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.predir_weight100 + ri.predir_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.addr_suffix_weight100 + ri.addr_suffix_weight100 + le.postdir_weight100 + ri.postdir_weight100 + le.unit_desig_weight100 + ri.unit_desig_weight100 + le.sec_range_weight100 + ri.sec_range_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.addr_suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.addr_suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* address_score_scale;
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT27.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* address_score_scale;
  INTEGER2 prim_range_score := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* address_score_scale;
  INTEGER2 zip4_score := MAP( le.zip4_isnull OR ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT27.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  INTEGER2 sec_range_score_temp := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT27.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))* address_score_scale;
  INTEGER2 p_city_name_score := MAP( le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
                        le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));
  INTEGER2 v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  INTEGER2 postdir_score := MAP( le.postdir_isnull OR ri.postdir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT27.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch))* address_score_scale;
  INTEGER2 fips_county_score := MAP( le.fips_county_isnull OR ri.fips_county_isnull => 0,
                        le.fips_county = ri.fips_county  => le.fips_county_weight100,
                        SALT27.Fn_Fail_Scale(le.fips_county_weight100,s.fips_county_switch));
  INTEGER2 predir_score := MAP( le.predir_isnull OR ri.predir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT27.Fn_Fail_Scale(le.predir_weight100,s.predir_switch))* address_score_scale;
  INTEGER2 unit_desig_score := MAP( le.unit_desig_isnull OR ri.unit_desig_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT27.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch))* address_score_scale;
  INTEGER2 st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT27.Fn_Fail_Scale(le.st_weight100,s.st_switch))* address_score_scale;
  INTEGER2 fips_state_score := MAP( le.fips_state_isnull OR ri.fips_state_isnull => 0,
                        le.fips_state = ri.fips_state  => le.fips_state_weight100,
                        SALT27.Fn_Fail_Scale(le.fips_state_weight100,s.fips_state_switch));
  INTEGER2 addr_suffix_score := MAP( le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT27.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch))* address_score_scale;
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= 0, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept address
  INTEGER2 address_score_ext := MAX(address_score_pre,0) + prim_range_score + predir_score + prim_name_score + addr_suffix_score + postdir_score + unit_desig_score + sec_range_score + st_score + zip_score;// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_url_prop,ri.company_url_prop)*company_url_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*company_name_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
    +if(le.address_prop+ri.address_prop>0,address_score*(0)/9,0)
  ) / 100; // Score based on propogated fields
  iComp := (company_url_score + company_name_score + company_fein_score + company_phone_score + address_score + prim_name_score + zip_score + prim_range_score + zip4_score + sec_range_score + p_city_name_score + v_city_name_score + postdir_score + fips_county_score + predir_score + unit_desig_score + st_score + fips_state_score + addr_suffix_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':company_url',
  n = 1 => ':company_name',
  n = 2 => ':company_fein',
  n = 3 => ':company_phone',
  n = 4 => ':prim_name:zip',
  n = 5 => ':prim_name:prim_range',
  n = 6 => ':prim_name:zip4',
  n = 7 => ':prim_name:sec_range',
  n = 8 => ':prim_name:p_city_name',
  n = 9 => ':prim_name:v_city_name',
  n = 10 => ':prim_name:postdir:*',
  n = 13 => ':prim_name:fips_county:*',
  n = 15 => ':zip:prim_range',
  n = 16 => ':zip:zip4',
  n = 17 => ':zip:sec_range',
  n = 18 => ':zip:p_city_name',
  n = 19 => ':zip:v_city_name',
  n = 20 => ':zip:postdir:*',
  n = 22 => ':zip:fips_county:predir',
  n = 23 => ':prim_range:zip4',
  n = 24 => ':prim_range:sec_range',
  n = 25 => ':prim_range:p_city_name',
  n = 26 => ':prim_range:v_city_name:*',
  n = 30 => ':prim_range:postdir:*',
  n = 32 => ':prim_range:fips_county:predir',
  n = 33 => ':zip4:sec_range',
  n = 34 => ':zip4:p_city_name',
  n = 35 => ':zip4:v_city_name:*',
  n = 39 => ':zip4:postdir:*',
  n = 41 => ':zip4:fips_county:predir',
  n = 42 => ':sec_range:p_city_name:*',
  n = 47 => ':sec_range:v_city_name:*',
  n = 51 => ':sec_range:postdir:fips_county',
  n = 52 => ':sec_range:postdir:predir:unit_desig',
  n = 53 => ':sec_range:fips_county:predir:unit_desig',
  n = 54 => ':p_city_name:v_city_name:*',
  n = 58 => ':p_city_name:postdir:fips_county',
  n = 59 => ':p_city_name:postdir:predir:unit_desig',
  n = 60 => ':p_city_name:fips_county:predir:unit_desig',
  n = 61 => ':v_city_name:postdir:fips_county',
  n = 62 => ':v_city_name:postdir:predir:unit_desig',
  n = 63 => ':v_city_name:fips_county:predir:unit_desig','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 64 join conditions of which 22 have been optimized into preceding conditions
//Fixed fields ->:company_url(27)
dn0 := h(~company_url_isnull);
dn0_deduped := dn0(company_url_weight100>=2500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_url = RIGHT.company_url AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.company_url = RIGHT.company_url,10000),SKEW(1));
//Fixed fields ->:company_name(26)
dn1 := h(~company_name_isnull);
dn1_deduped := dn1(company_name_weight100>=2500); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_name = RIGHT.company_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.company_name = RIGHT.company_name,10000),SKEW(1));
//Fixed fields ->:company_fein(26)
dn2 := h(~company_fein_isnull);
dn2_deduped := dn2(company_fein_weight100>=2500); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_fein = RIGHT.company_fein AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),SKEW(1));
//Fixed fields ->:company_phone(26)
dn3 := h(~company_phone_isnull);
dn3_deduped := dn3(company_phone_weight100>=2500); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.company_phone = RIGHT.company_phone AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.company_phone = RIGHT.company_phone,10000),SKEW(1));
//Fixed fields ->:prim_name(15):zip(14)
dn4 := h(~prim_name_isnull AND ~zip_isnull);
dn4_deduped := dn4(prim_name_weight100 + zip_weight100>=2500); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip,10000),SKEW(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT27.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj0');
//Fixed fields ->:prim_name(15):prim_range(13)
dn5 := h(~prim_name_isnull AND ~prim_range_isnull);
dn5_deduped := dn5(prim_name_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,5),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,10000),SKEW(1));
//Fixed fields ->:prim_name(15):zip4(13)
dn6 := h(~prim_name_isnull AND ~zip4_isnull);
dn6_deduped := dn6(prim_name_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,6),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip4 = RIGHT.zip4,10000),SKEW(1));
//Fixed fields ->:prim_name(15):sec_range(12)
dn7 := h(~prim_name_isnull AND ~sec_range_isnull);
dn7_deduped := dn7(prim_name_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,7),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,10000),SKEW(1));
//Fixed fields ->:prim_name(15):p_city_name(12)
dn8 := h(~prim_name_isnull AND ~p_city_name_isnull);
dn8_deduped := dn8(prim_name_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,8),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name,10000),SKEW(1));
//Fixed fields ->:prim_name(15):v_city_name(11)
dn9 := h(~prim_name_isnull AND ~v_city_name_isnull);
dn9_deduped := dn9(prim_name_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,9),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT27.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj1');
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_name(15):postdir(7):fips_county(7) also :prim_name(15):postdir(7):predir(5) also :prim_name(15):postdir(7):unit_desig(5)
dn10 := h(~prim_name_isnull AND ~postdir_isnull);
dn10_deduped := dn10(prim_name_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,10),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.postdir = RIGHT.postdir,10000),SKEW(1));
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name(15):fips_county(7):predir(5) also :prim_name(15):fips_county(7):unit_desig(5)
dn13 := h(~prim_name_isnull AND ~fips_county_isnull);
dn13_deduped := dn13(prim_name_weight100 + fips_county_weight100>=2100); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,13),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fips_county = RIGHT.fips_county,10000),SKEW(1));
mjs2_t := mj10+mj13;
SALT27.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj2');
//Fixed fields ->:zip(14):prim_range(13)
dn15 := h(~zip_isnull AND ~prim_range_isnull);
dn15_deduped := dn15(zip_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,15),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,10000),SKEW(1));
//Fixed fields ->:zip(14):zip4(13)
dn16 := h(~zip_isnull AND ~zip4_isnull);
dn16_deduped := dn16(zip_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj16 := JOIN( dn16_deduped, dn16_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,16),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4,10000),SKEW(1));
//Fixed fields ->:zip(14):sec_range(12)
dn17 := h(~zip_isnull AND ~sec_range_isnull);
dn17_deduped := dn17(zip_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,17),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range,10000),SKEW(1));
//Fixed fields ->:zip(14):p_city_name(12)
dn18 := h(~zip_isnull AND ~p_city_name_isnull);
dn18_deduped := dn18(zip_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj18 := JOIN( dn18_deduped, dn18_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,18),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name,10000),SKEW(1));
//Fixed fields ->:zip(14):v_city_name(11)
dn19 := h(~zip_isnull AND ~v_city_name_isnull);
dn19_deduped := dn19(zip_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj19 := JOIN( dn19_deduped, dn19_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,19),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT27.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj3');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):postdir(7):fips_county(7) also :zip(14):postdir(7):predir(5)
dn20 := h(~zip_isnull AND ~postdir_isnull);
dn20_deduped := dn20(zip_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
        ),match_join(LEFT,RIGHT,20),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.postdir = RIGHT.postdir,10000),SKEW(1));
//Fixed fields ->:zip(14):fips_county(7):predir(5)
dn22 := h(~zip_isnull AND ~fips_county_isnull AND ~predir_isnull);
dn22_deduped := dn22(zip_weight100 + fips_county_weight100 + predir_weight100>=2500); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip = RIGHT.zip AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,22),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir,10000),SKEW(1));
//Fixed fields ->:prim_range(13):zip4(13)
dn23 := h(~prim_range_isnull AND ~zip4_isnull);
dn23_deduped := dn23(prim_range_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj23 := JOIN( dn23_deduped, dn23_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,23),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.zip4 = RIGHT.zip4,10000),SKEW(1));
//Fixed fields ->:prim_range(13):sec_range(12)
dn24 := h(~prim_range_isnull AND ~sec_range_isnull);
dn24_deduped := dn24(prim_range_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj24 := JOIN( dn24_deduped, dn24_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,24),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,10000),SKEW(1));
mjs4_t := mj20+mj22+mj23+mj24;
SALT27.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj4');
//Fixed fields ->:prim_range(13):p_city_name(12)
dn25 := h(~prim_range_isnull AND ~p_city_name_isnull);
dn25_deduped := dn25(prim_range_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj25 := JOIN( dn25_deduped, dn25_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,25),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name,10000),SKEW(1));
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range(13):v_city_name(11):postdir(7) also :prim_range(13):v_city_name(11):fips_county(7) also :prim_range(13):v_city_name(11):predir(5) also :prim_range(13):v_city_name(11):unit_desig(5)
dn26 := h(~prim_range_isnull AND ~v_city_name_isnull);
dn26_deduped := dn26(prim_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj26 := JOIN( dn26_deduped, dn26_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,26),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
mjs5_t := mj25+mj26;
SALT27.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj5');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):postdir(7):fips_county(7) also :prim_range(13):postdir(7):predir(5)
dn30 := h(~prim_range_isnull AND ~postdir_isnull);
dn30_deduped := dn30(prim_range_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj30 := JOIN( dn30_deduped, dn30_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
        ),match_join(LEFT,RIGHT,30),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.postdir = RIGHT.postdir,10000),SKEW(1));
//Fixed fields ->:prim_range(13):fips_county(7):predir(5)
dn32 := h(~prim_range_isnull AND ~fips_county_isnull AND ~predir_isnull);
dn32_deduped := dn32(prim_range_weight100 + fips_county_weight100 + predir_weight100>=2500); // Use specificity to flag high-dup counts
mj32 := JOIN( dn32_deduped, dn32_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,32),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir,10000),SKEW(1));
//Fixed fields ->:zip4(13):sec_range(12)
dn33 := h(~zip4_isnull AND ~sec_range_isnull);
dn33_deduped := dn33(zip4_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj33 := JOIN( dn33_deduped, dn33_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,33),HINT(Parallel_Match),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.sec_range = RIGHT.sec_range,10000),SKEW(1));
//Fixed fields ->:zip4(13):p_city_name(12)
dn34 := h(~zip4_isnull AND ~p_city_name_isnull);
dn34_deduped := dn34(zip4_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj34 := JOIN( dn34_deduped, dn34_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,34),HINT(Parallel_Match),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.p_city_name = RIGHT.p_city_name,10000),SKEW(1));
mjs6_t := mj30+mj32+mj33+mj34;
SALT27.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj6');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip4(13):v_city_name(11):postdir(7) also :zip4(13):v_city_name(11):fips_county(7) also :zip4(13):v_city_name(11):predir(5) also :zip4(13):v_city_name(11):unit_desig(5)
dn35 := h(~zip4_isnull AND ~v_city_name_isnull);
dn35_deduped := dn35(zip4_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,35),HINT(Parallel_Match),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip4(13):postdir(7):fips_county(7) also :zip4(13):postdir(7):predir(5)
dn39 := h(~zip4_isnull AND ~postdir_isnull);
dn39_deduped := dn39(zip4_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj39 := JOIN( dn39_deduped, dn39_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
        ),match_join(LEFT,RIGHT,39),HINT(Parallel_Match),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.postdir = RIGHT.postdir,10000),SKEW(1));
mjs7_t := mj35+mj39;
SALT27.mac_select_best_matches(mjs7_t,rcid1,rcid2,o7);
mjs7 := o7 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj7');
//Fixed fields ->:zip4(13):fips_county(7):predir(5)
dn41 := h(~zip4_isnull AND ~fips_county_isnull AND ~predir_isnull);
dn41_deduped := dn41(zip4_weight100 + fips_county_weight100 + predir_weight100>=2500); // Use specificity to flag high-dup counts
mj41 := JOIN( dn41_deduped, dn41_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,41),HINT(Parallel_Match),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir,10000),SKEW(1));
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:sec_range(12):p_city_name(12):v_city_name(11) also :sec_range(12):p_city_name(12):postdir(7) also :sec_range(12):p_city_name(12):fips_county(7) also :sec_range(12):p_city_name(12):predir(5) also :sec_range(12):p_city_name(12):unit_desig(5)
dn42 := h(~sec_range_isnull AND ~p_city_name_isnull);
dn42_deduped := dn42(sec_range_weight100 + p_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj42 := JOIN( dn42_deduped, dn42_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,42),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name,10000),SKEW(1));
mjs8_t := mj41+mj42;
SALT27.mac_select_best_matches(mjs8_t,rcid1,rcid2,o8);
mjs8 := o8 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj8');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:sec_range(12):v_city_name(11):postdir(7) also :sec_range(12):v_city_name(11):fips_county(7) also :sec_range(12):v_city_name(11):predir(5) also :sec_range(12):v_city_name(11):unit_desig(5)
dn47 := h(~sec_range_isnull AND ~v_city_name_isnull);
dn47_deduped := dn47(sec_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj47 := JOIN( dn47_deduped, dn47_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,47),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
//Fixed fields ->:sec_range(12):postdir(7):fips_county(7)
dn51 := h(~sec_range_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn51_deduped := dn51(sec_range_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj51 := JOIN( dn51_deduped, dn51_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,51),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),SKEW(1));
mjs9_t := mj47+mj51;
SALT27.mac_select_best_matches(mjs9_t,rcid1,rcid2,o9);
mjs9 := o9 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj9');
//Fixed fields ->:sec_range(12):postdir(7):predir(5):unit_desig(5)
dn52 := h(~sec_range_isnull AND ~postdir_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn52_deduped := dn52(sec_range_weight100 + postdir_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj52 := JOIN( dn52_deduped, dn52_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,52),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
//Fixed fields ->:sec_range(12):fips_county(7):predir(5):unit_desig(5)
dn53 := h(~sec_range_isnull AND ~fips_county_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn53_deduped := dn53(sec_range_weight100 + fips_county_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj53 := JOIN( dn53_deduped, dn53_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,53),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:p_city_name(12):v_city_name(11):postdir(7) also :p_city_name(12):v_city_name(11):fips_county(7) also :p_city_name(12):v_city_name(11):predir(5) also :p_city_name(12):v_city_name(11):unit_desig(5)
dn54 := h(~p_city_name_isnull AND ~v_city_name_isnull);
dn54_deduped := dn54(p_city_name_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj54 := JOIN( dn54_deduped, dn54_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.predir = RIGHT.predir AND ~LEFT.predir_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),match_join(LEFT,RIGHT,54),HINT(Parallel_Match),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name,10000),SKEW(1));
mjs10_t := mj52+mj53+mj54;
SALT27.mac_select_best_matches(mjs10_t,rcid1,rcid2,o10);
mjs10 := o10 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj10');
//Fixed fields ->:p_city_name(12):postdir(7):fips_county(7)
dn58 := h(~p_city_name_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn58_deduped := dn58(p_city_name_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj58 := JOIN( dn58_deduped, dn58_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,58),HINT(Parallel_Match),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),SKEW(1));
//Fixed fields ->:p_city_name(12):postdir(7):predir(5):unit_desig(5)
dn59 := h(~p_city_name_isnull AND ~postdir_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn59_deduped := dn59(p_city_name_weight100 + postdir_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj59 := JOIN( dn59_deduped, dn59_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,59),HINT(Parallel_Match),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
//Fixed fields ->:p_city_name(12):fips_county(7):predir(5):unit_desig(5)
dn60 := h(~p_city_name_isnull AND ~fips_county_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn60_deduped := dn60(p_city_name_weight100 + fips_county_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj60 := JOIN( dn60_deduped, dn60_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,60),HINT(Parallel_Match),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
//Fixed fields ->:v_city_name(11):postdir(7):fips_county(7)
dn61 := h(~v_city_name_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn61_deduped := dn61(v_city_name_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj61 := JOIN( dn61_deduped, dn61_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,61),HINT(Parallel_Match),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),SKEW(1));
//Fixed fields ->:v_city_name(11):postdir(7):predir(5):unit_desig(5)
dn62 := h(~v_city_name_isnull AND ~postdir_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn62_deduped := dn62(v_city_name_weight100 + postdir_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj62 := JOIN( dn62_deduped, dn62_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,62),HINT(Parallel_Match),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
mjs11_t := mj58+mj59+mj60+mj61+mj62;
SALT27.mac_select_best_matches(mjs11_t,rcid1,rcid2,o11);
mjs11 := o11 : PERSIST('~temp::BIPV2_Best_test6::Proxid::mj11');
//Fixed fields ->:v_city_name(11):fips_county(7):predir(5):unit_desig(5)
dn63 := h(~v_city_name_isnull AND ~fips_county_isnull AND ~predir_isnull AND ~unit_desig_isnull);
dn63_deduped := dn63(v_city_name_weight100 + fips_county_weight100 + predir_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj63 := JOIN( dn63_deduped, dn63_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),match_join(LEFT,RIGHT,63),HINT(Parallel_Match),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.predir = RIGHT.predir AND LEFT.unit_desig = RIGHT.unit_desig,10000),SKEW(1));
last_mjs_t :=mj63;
SALT27.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11 +o;
export All_Matches := all_mjs : PERSIST('~temp::BIPV2_Best_test6_Proxid_Base_all_m'); // To by used by rcid and Proxid
SALT27.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : PERSIST('~temp::BIPV2_Best_test6_Proxid_Base_mt');
SALT27.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::BIPV2_Best_test6_Proxid_Base_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT27.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::BIPV2_Best_test6_Proxid_Base_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT27.UIDType rcid;  //Outcast
  SALT27.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT27.UIDType Pref_rcid; // Prefers this record
  SALT27.UIDType Pref_Proxid; // Prefers this cluster
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
SALT27.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
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
ut.MAC_Patch_Id(ih,Proxid,BasicMatch(ih).patch_file,Proxid1,Proxid2,ihbp); // Perform basic matches
SALT27.MAC_SliceOut_ByRID(ihbp,rcid,Proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
  bf := Best(ih).In_Flagged; // Input values flagged
  TYPEOF(o) AppendFlags(o le,bf ri) := TRANSFORM
    SELF.company_url_flag := ri.company_url_flag; // Either value - or null if no-match
    SELF.company_name_flag := ri.company_name_flag; // Either value - or null if no-match
    SELF.company_fein_flag := ri.company_fein_flag; // Either value - or null if no-match
    SELF.company_phone_flag := ri.company_phone_flag; // Either value - or null if no-match
    SELF.address_flag := ri.address_flag; // Either value - or null if no-match
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
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rcid,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(Proxid=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(Proxid>rcid)); // Should be zero
END;
