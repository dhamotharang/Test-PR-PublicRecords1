// Begin code to perform the matching itself
 
IMPORT SALT30,ut,std;
EXPORT matches(DATASET(layout_Base) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Seleid1 := le.Seleid;
  SELF.Seleid2 := ri.Seleid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT30.WithinEditN(le.company_fein,ri.company_fein,1,0) => SALT30.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        le.company_fein_Right4 = ri.company_fein_Right4 => SALT30.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_Right4_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_Right4_cnt),
                        SALT30.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 company_url_score := MAP(
                        le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT30.Fn_Fail_Scale(le.company_url_weight100,s.company_url_switch));
  INTEGER2 duns_number_score := MAP(
                        le.duns_number_isnull OR ri.duns_number_isnull => 0,
                        le.duns_number = ri.duns_number  => le.duns_number_weight100,
                        SALT30.WithinEditN(le.duns_number,ri.duns_number,1,0) => SALT30.fn_fuzzy_specificity(le.duns_number_weight100,le.duns_number_cnt, le.duns_number_e1_cnt,ri.duns_number_weight100,ri.duns_number_cnt,ri.duns_number_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.duns_number_weight100,s.duns_number_switch));
  INTEGER2 company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT30.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  INTEGER2 company_phone_score := MAP(
                        le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        SALT30.WithinEditN(le.company_phone,ri.company_phone,1,0) => SALT30.fn_fuzzy_specificity(le.company_phone_weight100,le.company_phone_cnt, le.company_phone_e1_cnt,ri.company_phone_weight100,ri.company_phone_cnt,ri.company_phone_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));
  INTEGER2 dba_name_score := MAP(
                        le.dba_name_isnull OR ri.dba_name_isnull => 0,
                        le.dba_name = ri.dba_name  => le.dba_name_weight100,
                        SALT30.Fn_Fail_Scale(le.dba_name_weight100,s.dba_name_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.predir_weight100 + ri.predir_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.addr_suffix_weight100 + ri.addr_suffix_weight100 + le.postdir_weight100 + ri.postdir_weight100 + le.unit_desig_weight100 + ri.unit_desig_weight100 + le.sec_range_weight100 + ri.sec_range_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.addr_suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.addr_suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT30.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT30.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip4_score := MAP(
                        le.zip4_isnull OR ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT30.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT30.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 p_city_name_score := MAP(
                        le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
                        le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
                        SALT30.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));
  INTEGER2 company_sic_code1_score := MAP(
                        le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
                        le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
                        SALT30.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));
  INTEGER2 company_naics_code1_score := MAP(
                        le.company_naics_code1_isnull OR ri.company_naics_code1_isnull => 0,
                        le.company_naics_code1 = ri.company_naics_code1  => le.company_naics_code1_weight100,
                        SALT30.Fn_Fail_Scale(le.company_naics_code1_weight100,s.company_naics_code1_switch));
  INTEGER2 v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT30.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  INTEGER2 postdir_score := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT30.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 fips_county_score := MAP(
                        le.fips_county_isnull OR ri.fips_county_isnull => 0,
                        le.fips_county = ri.fips_county  => le.fips_county_weight100,
                        SALT30.Fn_Fail_Scale(le.fips_county_weight100,s.fips_county_switch));
  INTEGER2 unit_desig_score := MAP(
                        le.unit_desig_isnull OR ri.unit_desig_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT30.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT30.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 fips_state_score := MAP(
                        le.fips_state_isnull OR ri.fips_state_isnull => 0,
                        le.fips_state = ri.fips_state  => le.fips_state_weight100,
                        SALT30.Fn_Fail_Scale(le.fips_state_weight100,s.fips_state_switch));
  INTEGER2 predir_score := MAP(
                        le.predir_isnull OR ri.predir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT30.Fn_Fail_Scale(le.predir_weight100,s.predir_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 addr_suffix_score := MAP(
                        le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT30.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch))*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT30.ClipScore(MAX(address_score_pre,0) + prim_range_score + predir_score + prim_name_score + addr_suffix_score + postdir_score + unit_desig_score + sec_range_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.company_url_prop,ri.company_url_prop)*company_url_score // Score if either field propogated
    +MAX(le.duns_number_prop,ri.duns_number_prop)*duns_number_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*company_name_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
    +MAX(le.dba_name_prop,ri.dba_name_prop)*dba_name_score // Score if either field propogated
    +if(le.address_prop+ri.address_prop>0,address_score*(0)/9,0)
    +MAX(le.company_sic_code1_prop,ri.company_sic_code1_prop)*company_sic_code1_score // Score if either field propogated
    +MAX(le.company_naics_code1_prop,ri.company_naics_code1_prop)*company_naics_code1_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (company_fein_score + company_url_score + duns_number_score + company_name_score + company_phone_score + dba_name_score + IF(address_score>0,MAX(address_score,prim_range_score + predir_score + prim_name_score + addr_suffix_score + postdir_score + unit_desig_score + sec_range_score + st_score + zip_score),prim_range_score + predir_score + prim_name_score + addr_suffix_score + postdir_score + unit_desig_score + sec_range_score + st_score + zip_score) + zip4_score + p_city_name_score + company_sic_code1_score + company_naics_code1_score + v_city_name_score + fips_county_score + fips_state_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':company_fein',
  n = 1 => ':company_url',
  n = 2 => ':duns_number',
  n = 3 => ':company_name',
  n = 4 => ':company_phone',
  n = 5 => ':dba_name',
  n = 6 => ':prim_name:zip',
  n = 7 => ':prim_name:prim_range',
  n = 8 => ':prim_name:zip4',
  n = 9 => ':prim_name:sec_range',
  n = 10 => ':prim_name:p_city_name',
  n = 11 => ':prim_name:company_sic_code1',
  n = 12 => ':prim_name:company_naics_code1',
  n = 13 => ':prim_name:v_city_name',
  n = 14 => ':prim_name:postdir:*',
  n = 16 => ':prim_name:fips_county:unit_desig',
  n = 17 => ':zip:prim_range',
  n = 18 => ':zip:zip4',
  n = 19 => ':zip:sec_range',
  n = 20 => ':zip:p_city_name',
  n = 21 => ':zip:company_sic_code1',
  n = 22 => ':zip:company_naics_code1',
  n = 23 => ':zip:v_city_name',
  n = 24 => ':zip:postdir:*',
  n = 26 => ':zip:fips_county:unit_desig',
  n = 27 => ':prim_range:zip4',
  n = 28 => ':prim_range:sec_range',
  n = 29 => ':prim_range:p_city_name',
  n = 30 => ':prim_range:company_sic_code1:*',
  n = 36 => ':prim_range:company_naics_code1:*',
  n = 41 => ':prim_range:v_city_name:*',
  n = 45 => ':prim_range:postdir:*',
  n = 47 => ':prim_range:fips_county:unit_desig',
  n = 48 => ':zip4:sec_range',
  n = 49 => ':zip4:p_city_name',
  n = 50 => ':zip4:company_sic_code1:*',
  n = 56 => ':zip4:company_naics_code1:*',
  n = 61 => ':zip4:v_city_name:*',
  n = 65 => ':zip4:postdir:*',
  n = 67 => ':zip4:fips_county:unit_desig',
  n = 68 => ':sec_range:p_city_name:*',
  n = 75 => ':sec_range:company_sic_code1:*',
  n = 80 => ':sec_range:company_naics_code1:*',
  n = 84 => ':sec_range:v_city_name:*',
  n = 87 => ':sec_range:postdir:fips_county',
  n = 88 => ':sec_range:postdir:unit_desig:st',
  n = 89 => ':sec_range:fips_county:unit_desig:st',
  n = 90 => ':p_city_name:company_sic_code1:*',
  n = 95 => ':p_city_name:company_naics_code1:*',
  n = 99 => ':p_city_name:v_city_name:*',
  n = 102 => ':p_city_name:postdir:fips_county',
  n = 103 => ':p_city_name:postdir:unit_desig:st',
  n = 104 => ':p_city_name:fips_county:unit_desig:st',
  n = 105 => ':company_sic_code1:company_naics_code1:*',
  n = 109 => ':company_sic_code1:v_city_name:*',
  n = 112 => ':company_sic_code1:postdir:fips_county',
  n = 113 => ':company_naics_code1:v_city_name:*',
  n = 116 => ':company_naics_code1:postdir:fips_county',
  n = 117 => ':v_city_name:postdir:fips_county','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 118 join conditions of which 59 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:company_fein(27)
 
dn0 := hfile(~company_fein_isnull);
dn0_deduped := dn0(company_fein_weight100>=2500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_fein = RIGHT.company_fein AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
 
//Fixed fields ->:company_url(27)
 
dn1 := hfile(~company_url_isnull);
dn1_deduped := dn1(company_url_weight100>=2500); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_url = RIGHT.company_url AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,1),HINT(unsorted_output),ATMOST(LEFT.company_url = RIGHT.company_url,10000),HASH);
 
//Fixed fields ->:duns_number(27)
 
dn2 := hfile(~duns_number_isnull);
dn2_deduped := dn2(duns_number_weight100>=2500); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.duns_number = RIGHT.duns_number AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,2),HINT(unsorted_output),ATMOST(LEFT.duns_number = RIGHT.duns_number,10000),HASH);
 
//Fixed fields ->:company_name(26)
 
dn3 := hfile(~company_name_isnull);
dn3_deduped := dn3(company_name_weight100>=2500); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_name = RIGHT.company_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,3),HINT(unsorted_output),ATMOST(LEFT.company_name = RIGHT.company_name,10000),HASH);
 
//Fixed fields ->:company_phone(26)
 
dn4 := hfile(~company_phone_isnull);
dn4_deduped := dn4(company_phone_weight100>=2500); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_phone = RIGHT.company_phone AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,4),HINT(unsorted_output),ATMOST(LEFT.company_phone = RIGHT.company_phone,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT30.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::0',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:dba_name(26)
 
dn5 := hfile(~dba_name_isnull);
dn5_deduped := dn5(dba_name_weight100>=2500); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.dba_name = RIGHT.dba_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,5),HINT(unsorted_output),ATMOST(LEFT.dba_name = RIGHT.dba_name,10000),HASH);
 
//Fixed fields ->:prim_name(15):zip(14)
 
dn6 := hfile(~prim_name_isnull AND ~zip_isnull);
dn6_deduped := dn6(prim_name_weight100 + zip_weight100>=2500); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,6),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip,10000),HASH);
 
//Fixed fields ->:prim_name(15):prim_range(13)
 
dn7 := hfile(~prim_name_isnull AND ~prim_range_isnull);
dn7_deduped := dn7(prim_name_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,7),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
 
//Fixed fields ->:prim_name(15):zip4(13)
 
dn8 := hfile(~prim_name_isnull AND ~zip4_isnull);
dn8_deduped := dn8(prim_name_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,8),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip4 = RIGHT.zip4,10000),HASH);
 
//Fixed fields ->:prim_name(15):sec_range(12)
 
dn9 := hfile(~prim_name_isnull AND ~sec_range_isnull);
dn9_deduped := dn9(prim_name_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,9),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT30.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::1',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:prim_name(15):p_city_name(12)
 
dn10 := hfile(~prim_name_isnull AND ~p_city_name_isnull);
dn10_deduped := dn10(prim_name_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,10),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name,10000),HASH);
 
//Fixed fields ->:prim_name(15):company_sic_code1(11)
 
dn11 := hfile(~prim_name_isnull AND ~company_sic_code1_isnull);
dn11_deduped := dn11(prim_name_weight100 + company_sic_code1_weight100>=2500); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,11),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
 
//Fixed fields ->:prim_name(15):company_naics_code1(11)
 
dn12 := hfile(~prim_name_isnull AND ~company_naics_code1_isnull);
dn12_deduped := dn12(prim_name_weight100 + company_naics_code1_weight100>=2500); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,12),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
 
//Fixed fields ->:prim_name(15):v_city_name(11)
 
dn13 := hfile(~prim_name_isnull AND ~v_city_name_isnull);
dn13_deduped := dn13(prim_name_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,13),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name(15):postdir(7):fips_county(7) also :prim_name(15):postdir(7):unit_desig(5)
 
dn14 := hfile(~prim_name_isnull AND ~postdir_isnull);
dn14_deduped := dn14(prim_name_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,14),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.postdir = RIGHT.postdir,10000),HASH);
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT30.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::2',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:prim_name(15):fips_county(7):unit_desig(5)
 
dn16 := hfile(~prim_name_isnull AND ~fips_county_isnull AND ~unit_desig_isnull);
dn16_deduped := dn16(prim_name_weight100 + fips_county_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj16 := JOIN( dn16_deduped, dn16_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,16),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig,10000),HASH);
 
//Fixed fields ->:zip(14):prim_range(13)
 
dn17 := hfile(~zip_isnull AND ~prim_range_isnull);
dn17_deduped := dn17(zip_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,17),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
 
//Fixed fields ->:zip(14):zip4(13)
 
dn18 := hfile(~zip_isnull AND ~zip4_isnull);
dn18_deduped := dn18(zip_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj18 := JOIN( dn18_deduped, dn18_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,18),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4,10000),HASH);
 
//Fixed fields ->:zip(14):sec_range(12)
 
dn19 := hfile(~zip_isnull AND ~sec_range_isnull);
dn19_deduped := dn19(zip_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj19 := JOIN( dn19_deduped, dn19_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,19),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
 
//Fixed fields ->:zip(14):p_city_name(12)
 
dn20 := hfile(~zip_isnull AND ~p_city_name_isnull);
dn20_deduped := dn20(zip_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,20),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name,10000),HASH);
mjs3_t := mj16+mj17+mj18+mj19+mj20;
SALT30.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::3',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:zip(14):company_sic_code1(11)
 
dn21 := hfile(~zip_isnull AND ~company_sic_code1_isnull);
dn21_deduped := dn21(zip_weight100 + company_sic_code1_weight100>=2500); // Use specificity to flag high-dup counts
mj21 := JOIN( dn21_deduped, dn21_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,21),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
 
//Fixed fields ->:zip(14):company_naics_code1(11)
 
dn22 := hfile(~zip_isnull AND ~company_naics_code1_isnull);
dn22_deduped := dn22(zip_weight100 + company_naics_code1_weight100>=2500); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,22),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
 
//Fixed fields ->:zip(14):v_city_name(11)
 
dn23 := hfile(~zip_isnull AND ~v_city_name_isnull);
dn23_deduped := dn23(zip_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj23 := JOIN( dn23_deduped, dn23_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,23),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):postdir(7):fips_county(7) also :zip(14):postdir(7):unit_desig(5)
 
dn24 := hfile(~zip_isnull AND ~postdir_isnull);
dn24_deduped := dn24(zip_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj24 := JOIN( dn24_deduped, dn24_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,24),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.postdir = RIGHT.postdir,10000),HASH);
mjs4_t := mj21+mj22+mj23+mj24;
SALT30.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::4',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:zip(14):fips_county(7):unit_desig(5)
 
dn26 := hfile(~zip_isnull AND ~fips_county_isnull AND ~unit_desig_isnull);
dn26_deduped := dn26(zip_weight100 + fips_county_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj26 := JOIN( dn26_deduped, dn26_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip = RIGHT.zip AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,26),HINT(unsorted_output),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig,10000),HASH);
 
//Fixed fields ->:prim_range(13):zip4(13)
 
dn27 := hfile(~prim_range_isnull AND ~zip4_isnull);
dn27_deduped := dn27(prim_range_weight100 + zip4_weight100>=2500); // Use specificity to flag high-dup counts
mj27 := JOIN( dn27_deduped, dn27_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.zip4 = RIGHT.zip4 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,27),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.zip4 = RIGHT.zip4,10000),HASH);
 
//Fixed fields ->:prim_range(13):sec_range(12)
 
dn28 := hfile(~prim_range_isnull AND ~sec_range_isnull);
dn28_deduped := dn28(prim_range_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj28 := JOIN( dn28_deduped, dn28_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,28),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
 
//Fixed fields ->:prim_range(13):p_city_name(12)
 
dn29 := hfile(~prim_range_isnull AND ~p_city_name_isnull);
dn29_deduped := dn29(prim_range_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj29 := JOIN( dn29_deduped, dn29_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,29),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name,10000),HASH);
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_range(13):company_sic_code1(11):company_naics_code1(11) also :prim_range(13):company_sic_code1(11):v_city_name(11) also :prim_range(13):company_sic_code1(11):postdir(7) also :prim_range(13):company_sic_code1(11):fips_county(7) also :prim_range(13):company_sic_code1(11):unit_desig(5) also :prim_range(13):company_sic_code1(11):st(5)
 
dn30 := hfile(~prim_range_isnull AND ~company_sic_code1_isnull);
dn30_deduped := dn30(prim_range_weight100 + company_sic_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj30 := JOIN( dn30_deduped, dn30_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ~LEFT.company_naics_code1_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,30),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs5_t := mj26+mj27+mj28+mj29+mj30;
SALT30.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::5',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_range(13):company_naics_code1(11):v_city_name(11) also :prim_range(13):company_naics_code1(11):postdir(7) also :prim_range(13):company_naics_code1(11):fips_county(7) also :prim_range(13):company_naics_code1(11):unit_desig(5) also :prim_range(13):company_naics_code1(11):st(5)
 
dn36 := hfile(~prim_range_isnull AND ~company_naics_code1_isnull);
dn36_deduped := dn36(prim_range_weight100 + company_naics_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj36 := JOIN( dn36_deduped, dn36_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,36),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
mjs6_t := mj36;
SALT30.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::6',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range(13):v_city_name(11):postdir(7) also :prim_range(13):v_city_name(11):fips_county(7) also :prim_range(13):v_city_name(11):unit_desig(5) also :prim_range(13):v_city_name(11):st(5)
 
dn41 := hfile(~prim_range_isnull AND ~v_city_name_isnull);
dn41_deduped := dn41(prim_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj41 := JOIN( dn41_deduped, dn41_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,41),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):postdir(7):fips_county(7) also :prim_range(13):postdir(7):unit_desig(5)
 
dn45 := hfile(~prim_range_isnull AND ~postdir_isnull);
dn45_deduped := dn45(prim_range_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj45 := JOIN( dn45_deduped, dn45_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,45),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.postdir = RIGHT.postdir,10000),HASH);
mjs7_t := mj41+mj45;
SALT30.mac_select_best_matches(mjs7_t,rcid1,rcid2,o7);
mjs7 := o7 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::7',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:prim_range(13):fips_county(7):unit_desig(5)
 
dn47 := hfile(~prim_range_isnull AND ~fips_county_isnull AND ~unit_desig_isnull);
dn47_deduped := dn47(prim_range_weight100 + fips_county_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj47 := JOIN( dn47_deduped, dn47_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,47),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig,10000),HASH);
 
//Fixed fields ->:zip4(13):sec_range(12)
 
dn48 := hfile(~zip4_isnull AND ~sec_range_isnull);
dn48_deduped := dn48(zip4_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj48 := JOIN( dn48_deduped, dn48_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.sec_range = RIGHT.sec_range AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,48),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
 
//Fixed fields ->:zip4(13):p_city_name(12)
 
dn49 := hfile(~zip4_isnull AND ~p_city_name_isnull);
dn49_deduped := dn49(zip4_weight100 + p_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj49 := JOIN( dn49_deduped, dn49_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,49),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.p_city_name = RIGHT.p_city_name,10000),HASH);
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:zip4(13):company_sic_code1(11):company_naics_code1(11) also :zip4(13):company_sic_code1(11):v_city_name(11) also :zip4(13):company_sic_code1(11):postdir(7) also :zip4(13):company_sic_code1(11):fips_county(7) also :zip4(13):company_sic_code1(11):unit_desig(5) also :zip4(13):company_sic_code1(11):st(5)
 
dn50 := hfile(~zip4_isnull AND ~company_sic_code1_isnull);
dn50_deduped := dn50(zip4_weight100 + company_sic_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj50 := JOIN( dn50_deduped, dn50_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ~LEFT.company_naics_code1_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,50),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs8_t := mj47+mj48+mj49+mj50;
SALT30.mac_select_best_matches(mjs8_t,rcid1,rcid2,o8);
mjs8 := o8 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::8',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:zip4(13):company_naics_code1(11):v_city_name(11) also :zip4(13):company_naics_code1(11):postdir(7) also :zip4(13):company_naics_code1(11):fips_county(7) also :zip4(13):company_naics_code1(11):unit_desig(5) also :zip4(13):company_naics_code1(11):st(5)
 
dn56 := hfile(~zip4_isnull AND ~company_naics_code1_isnull);
dn56_deduped := dn56(zip4_weight100 + company_naics_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj56 := JOIN( dn56_deduped, dn56_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,56),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
mjs9_t := mj56;
SALT30.mac_select_best_matches(mjs9_t,rcid1,rcid2,o9);
mjs9 := o9 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::9',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip4(13):v_city_name(11):postdir(7) also :zip4(13):v_city_name(11):fips_county(7) also :zip4(13):v_city_name(11):unit_desig(5) also :zip4(13):v_city_name(11):st(5)
 
dn61 := hfile(~zip4_isnull AND ~v_city_name_isnull);
dn61_deduped := dn61(zip4_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj61 := JOIN( dn61_deduped, dn61_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,61),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip4(13):postdir(7):fips_county(7) also :zip4(13):postdir(7):unit_desig(5)
 
dn65 := hfile(~zip4_isnull AND ~postdir_isnull);
dn65_deduped := dn65(zip4_weight100 + postdir_weight100>=2100); // Use specificity to flag high-dup counts
mj65 := JOIN( dn65_deduped, dn65_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.postdir = RIGHT.postdir AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,65),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.postdir = RIGHT.postdir,10000),HASH);
mjs10_t := mj61+mj65;
SALT30.mac_select_best_matches(mjs10_t,rcid1,rcid2,o10);
mjs10 := o10 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::10',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:zip4(13):fips_county(7):unit_desig(5)
 
dn67 := hfile(~zip4_isnull AND ~fips_county_isnull AND ~unit_desig_isnull);
dn67_deduped := dn67(zip4_weight100 + fips_county_weight100 + unit_desig_weight100>=2500); // Use specificity to flag high-dup counts
mj67 := JOIN( dn67_deduped, dn67_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.zip4 = RIGHT.zip4 AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,67),HINT(unsorted_output),ATMOST(LEFT.zip4 = RIGHT.zip4 AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig,10000),HASH);
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:sec_range(12):p_city_name(12):company_sic_code1(11) also :sec_range(12):p_city_name(12):company_naics_code1(11) also :sec_range(12):p_city_name(12):v_city_name(11) also :sec_range(12):p_city_name(12):postdir(7) also :sec_range(12):p_city_name(12):fips_county(7) also :sec_range(12):p_city_name(12):unit_desig(5) also :sec_range(12):p_city_name(12):st(5)
 
dn68 := hfile(~sec_range_isnull AND ~p_city_name_isnull);
dn68_deduped := dn68(sec_range_weight100 + p_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj68 := JOIN( dn68_deduped, dn68_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ~LEFT.company_naics_code1_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),trans(LEFT,RIGHT,68),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name,10000),HASH);
mjs11_t := mj67+mj68;
SALT30.mac_select_best_matches(mjs11_t,rcid1,rcid2,o11);
mjs11 := o11 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::11',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:sec_range(12):company_sic_code1(11):company_naics_code1(11) also :sec_range(12):company_sic_code1(11):v_city_name(11) also :sec_range(12):company_sic_code1(11):postdir(7) also :sec_range(12):company_sic_code1(11):fips_county(7) also :sec_range(12):company_sic_code1(11):unit_desig(5)
 
dn75 := hfile(~sec_range_isnull AND ~company_sic_code1_isnull);
dn75_deduped := dn75(sec_range_weight100 + company_sic_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj75 := JOIN( dn75_deduped, dn75_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ~LEFT.company_naics_code1_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,75),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs12_t := mj75;
SALT30.mac_select_best_matches(mjs12_t,rcid1,rcid2,o12);
mjs12 := o12 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::12',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:sec_range(12):company_naics_code1(11):v_city_name(11) also :sec_range(12):company_naics_code1(11):postdir(7) also :sec_range(12):company_naics_code1(11):fips_county(7) also :sec_range(12):company_naics_code1(11):unit_desig(5)
 
dn80 := hfile(~sec_range_isnull AND ~company_naics_code1_isnull);
dn80_deduped := dn80(sec_range_weight100 + company_naics_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj80 := JOIN( dn80_deduped, dn80_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,80),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:sec_range(12):v_city_name(11):postdir(7) also :sec_range(12):v_city_name(11):fips_county(7) also :sec_range(12):v_city_name(11):unit_desig(5)
 
dn84 := hfile(~sec_range_isnull AND ~v_city_name_isnull);
dn84_deduped := dn84(sec_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj84 := JOIN( dn84_deduped, dn84_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,84),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
mjs13_t := mj80+mj84;
SALT30.mac_select_best_matches(mjs13_t,rcid1,rcid2,o13);
mjs13 := o13 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::13',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:sec_range(12):postdir(7):fips_county(7)
 
dn87 := hfile(~sec_range_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn87_deduped := dn87(sec_range_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj87 := JOIN( dn87_deduped, dn87_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,87),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),HASH);
 
//Fixed fields ->:sec_range(12):postdir(7):unit_desig(5):st(5)
 
dn88 := hfile(~sec_range_isnull AND ~postdir_isnull AND ~unit_desig_isnull AND ~st_isnull);
dn88_deduped := dn88(sec_range_weight100 + postdir_weight100 + unit_desig_weight100 + st_weight100>=2500); // Use specificity to flag high-dup counts
mj88 := JOIN( dn88_deduped, dn88_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,88),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:sec_range(12):fips_county(7):unit_desig(5):st(5)
 
dn89 := hfile(~sec_range_isnull AND ~fips_county_isnull AND ~unit_desig_isnull AND ~st_isnull);
dn89_deduped := dn89(sec_range_weight100 + fips_county_weight100 + unit_desig_weight100 + st_weight100>=2500); // Use specificity to flag high-dup counts
mj89 := JOIN( dn89_deduped, dn89_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,89),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:p_city_name(12):company_sic_code1(11):company_naics_code1(11) also :p_city_name(12):company_sic_code1(11):v_city_name(11) also :p_city_name(12):company_sic_code1(11):postdir(7) also :p_city_name(12):company_sic_code1(11):fips_county(7) also :p_city_name(12):company_sic_code1(11):unit_desig(5)
 
dn90 := hfile(~p_city_name_isnull AND ~company_sic_code1_isnull);
dn90_deduped := dn90(p_city_name_weight100 + company_sic_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj90 := JOIN( dn90_deduped, dn90_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ~LEFT.company_naics_code1_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,90),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs14_t := mj87+mj88+mj89+mj90;
SALT30.mac_select_best_matches(mjs14_t,rcid1,rcid2,o14);
mjs14 := o14 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::14',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:p_city_name(12):company_naics_code1(11):v_city_name(11) also :p_city_name(12):company_naics_code1(11):postdir(7) also :p_city_name(12):company_naics_code1(11):fips_county(7) also :p_city_name(12):company_naics_code1(11):unit_desig(5)
 
dn95 := hfile(~p_city_name_isnull AND ~company_naics_code1_isnull);
dn95_deduped := dn95(p_city_name_weight100 + company_naics_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj95 := JOIN( dn95_deduped, dn95_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,95),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:p_city_name(12):v_city_name(11):postdir(7) also :p_city_name(12):v_city_name(11):fips_county(7) also :p_city_name(12):v_city_name(11):unit_desig(5)
 
dn99 := hfile(~p_city_name_isnull AND ~v_city_name_isnull);
dn99_deduped := dn99(p_city_name_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj99 := JOIN( dn99_deduped, dn99_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,99),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
mjs15_t := mj95+mj99;
SALT30.mac_select_best_matches(mjs15_t,rcid1,rcid2,o15);
mjs15 := o15 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::15',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:p_city_name(12):postdir(7):fips_county(7)
 
dn102 := hfile(~p_city_name_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn102_deduped := dn102(p_city_name_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj102 := JOIN( dn102_deduped, dn102_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,102),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),HASH);
 
//Fixed fields ->:p_city_name(12):postdir(7):unit_desig(5):st(5)
 
dn103 := hfile(~p_city_name_isnull AND ~postdir_isnull AND ~unit_desig_isnull AND ~st_isnull);
dn103_deduped := dn103(p_city_name_weight100 + postdir_weight100 + unit_desig_weight100 + st_weight100>=2500); // Use specificity to flag high-dup counts
mj103 := JOIN( dn103_deduped, dn103_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,103),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:p_city_name(12):fips_county(7):unit_desig(5):st(5)
 
dn104 := hfile(~p_city_name_isnull AND ~fips_county_isnull AND ~unit_desig_isnull AND ~st_isnull);
dn104_deduped := dn104(p_city_name_weight100 + fips_county_weight100 + unit_desig_weight100 + st_weight100>=2500); // Use specificity to flag high-dup counts
mj104 := JOIN( dn104_deduped, dn104_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,104),HINT(unsorted_output),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.fips_county = RIGHT.fips_county AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:company_sic_code1(11):company_naics_code1(11):v_city_name(11) also :company_sic_code1(11):company_naics_code1(11):postdir(7) also :company_sic_code1(11):company_naics_code1(11):fips_county(7) also :company_sic_code1(11):company_naics_code1(11):unit_desig(5)
 
dn105 := hfile(~company_sic_code1_isnull AND ~company_naics_code1_isnull);
dn105_deduped := dn105(company_sic_code1_weight100 + company_naics_code1_weight100>=2100); // Use specificity to flag high-dup counts
mj105 := JOIN( dn105_deduped, dn105_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND ~LEFT.v_city_name_isnull
    OR    LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,105),HINT(unsorted_output),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_naics_code1 = RIGHT.company_naics_code1,10000),HASH);
mjs16_t := mj102+mj103+mj104+mj105;
SALT30.mac_select_best_matches(mjs16_t,rcid1,rcid2,o16);
mjs16 := o16 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::16',EXPIRE(Config.PersistExpire));
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_sic_code1(11):v_city_name(11):postdir(7) also :company_sic_code1(11):v_city_name(11):fips_county(7) also :company_sic_code1(11):v_city_name(11):unit_desig(5)
 
dn109 := hfile(~company_sic_code1_isnull AND ~v_city_name_isnull);
dn109_deduped := dn109(company_sic_code1_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj109 := JOIN( dn109_deduped, dn109_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,109),HINT(unsorted_output),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
 
//Fixed fields ->:company_sic_code1(11):postdir(7):fips_county(7)
 
dn112 := hfile(~company_sic_code1_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn112_deduped := dn112(company_sic_code1_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj112 := JOIN( dn112_deduped, dn112_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,112),HINT(unsorted_output),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_naics_code1(11):v_city_name(11):postdir(7) also :company_naics_code1(11):v_city_name(11):fips_county(7) also :company_naics_code1(11):v_city_name(11):unit_desig(5)
 
dn113 := hfile(~company_naics_code1_isnull AND ~v_city_name_isnull);
dn113_deduped := dn113(company_naics_code1_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj113 := JOIN( dn113_deduped, dn113_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND LEFT.v_city_name = RIGHT.v_city_name AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.postdir = RIGHT.postdir AND ~LEFT.postdir_isnull
    OR    LEFT.fips_county = RIGHT.fips_county AND ~LEFT.fips_county_isnull
    OR    LEFT.unit_desig = RIGHT.unit_desig AND ~LEFT.unit_desig_isnull
        ),trans(LEFT,RIGHT,113),HINT(unsorted_output),ATMOST(LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND LEFT.v_city_name = RIGHT.v_city_name,10000),HASH);
mjs17_t := mj109+mj112+mj113;
SALT30.mac_select_best_matches(mjs17_t,rcid1,rcid2,o17);
mjs17 := o17 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mj::17',EXPIRE(Config.PersistExpire));
 
//Fixed fields ->:company_naics_code1(11):postdir(7):fips_county(7)
 
dn116 := hfile(~company_naics_code1_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn116_deduped := dn116(company_naics_code1_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj116 := JOIN( dn116_deduped, dn116_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,116),HINT(unsorted_output),ATMOST(LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),HASH);
 
//Fixed fields ->:v_city_name(11):postdir(7):fips_county(7)
 
dn117 := hfile(~v_city_name_isnull AND ~postdir_isnull AND ~fips_county_isnull);
dn117_deduped := dn117(v_city_name_weight100 + postdir_weight100 + fips_county_weight100>=2500); // Use specificity to flag high-dup counts
mj117 := JOIN( dn117_deduped, dn117_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,117),HINT(unsorted_output),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.postdir = RIGHT.postdir AND LEFT.fips_county = RIGHT.fips_county,10000),HASH);
last_mjs_t :=mj116+mj117;
SALT30.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11+ mjs12+ mjs13+ mjs14+ mjs15+ mjs16+ mjs17 +o;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and Seleid
SALT30.mac_avoid_transitives(All_Matches,Seleid1,Seleid2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mt',EXPIRE(Config.PersistExpire));
SALT30.mac_get_BestPerRecord( All_Matches,rcid1,Seleid1,rcid2,Seleid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{Seleid, InCluster := COUNT(GROUP)},Seleid,MERGE)(InCluster>1000); // Seleid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Seleid=RIGHT.Seleid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.Seleid=RIGHT.Seleid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT30.mac_cluster_breadth(in_matches,rcid1,rcid2,Seleid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Seleid1=RIGHT.Seleid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT30.UIDType rcid;  //Outcast
  SALT30.UIDType Seleid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT30.UIDType Pref_rcid; // Prefers this record
  SALT30.UIDType Pref_Seleid; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.Seleid := le.Seleid1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_Seleid := ri.Seleid2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.Seleid=RIGHT.Seleid1 AND LEFT.Pref_Seleid=RIGHT.Seleid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.Seleid=RIGHT.Seleid2 AND LEFT.Pref_Seleid=RIGHT.Seleid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Seleid)),Seleid,-Pref_Margin,LOCAL),Seleid,LOCAL)) : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT30.MAC_Avoid_SliceOuts(PossibleMatches,Seleid1,Seleid2,Seleid,Pref_Seleid,ToSlice,m); // If Seleid is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold);
 
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
ut.MAC_Patch_Id(ih,Seleid,BasicMatch(ih).patch_file,Seleid1,Seleid2,ihbp); // Perform basic matches
SALT30.MAC_SliceOut_ByRID(ihbp,rcid,Seleid,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,Seleid,Matches,Seleid1,Seleid2,o); // Join Clusters
  bf := Flags(ih).In_Flagged; // Input values flagged
  TYPEOF(o) AppendFlags(o le,bf ri) := TRANSFORM
    SELF.company_fein_flag := ri.company_fein_flag; // Either value - or null if no-match
    SELF.company_url_flag := ri.company_url_flag; // Either value - or null if no-match
    SELF.duns_number_flag := ri.duns_number_flag; // Either value - or null if no-match
    SELF.company_name_flag := ri.company_name_flag; // Either value - or null if no-match
    SELF.company_phone_flag := ri.company_phone_flag; // Either value - or null if no-match
    SELF.dba_name_flag := ri.dba_name_flag; // Either value - or null if no-match
    SELF.address_flag := ri.address_flag; // Either value - or null if no-match
    SELF.company_sic_code1_flag := ri.company_sic_code1_flag; // Either value - or null if no-match
    SELF.company_naics_code1_flag := ri.company_naics_code1_flag; // Either value - or null if no-match
    SELF := le;
  END;
  j := JOIN(o,bf,LEFT.Seleid = RIGHT.Seleid AND LEFT.rcid = RIGHT.rcid,AppendFlags(LEFT,RIGHT),LEFT OUTER); // Only take if cluster id unchanged for record
EXPORT Patched_Infile := j;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Seleid,Matches,Seleid1,Seleid2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT30.UIDType rcid;
    SALT30.UIDType Seleid_before;
    SALT30.UIDType Seleid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.Seleid_before := le.Seleid;
    SELF.Seleid_after := ri.Seleid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.Seleid<>RIGHT.Seleid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_Best_Seleid.Fields.UIDConsistency(ih); // Export whole consistency module
EXPORT PostIDs := BIPV2_Best_Seleid.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].Seleid_count - PostIDs.IdCounts[1].Seleid_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;
