// Begin code to perform the matching itself
IMPORT SALT31,ut,std;
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
  SELF.DateOverlap := SALT31.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen_contact),((UNSIGNED)le.dt_last_seen_contact),((UNSIGNED)ri.dt_first_seen_contact),((UNSIGNED)ri.dt_last_seen_contact));
  INTEGER2 active_duns_number_score_temp := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT31.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT31.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT31.WithinEditN(le.company_charter_number,ri.company_charter_number,1,0) => SALT31.fn_fuzzy_specificity(le.company_charter_number_weight100,le.company_charter_number_cnt, le.company_charter_number_e1_cnt,ri.company_charter_number_weight100,ri.company_charter_number_cnt,ri.company_charter_number_e1_cnt),
                        SALT31.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT31.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 source_record_id_score := MAP(
                        le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT31.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  INTEGER2 contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  INTEGER2 contact_email_username_score := MAP(
                        le.contact_email_username_isnull OR ri.contact_email_username_isnull => 0,
                        le.contact_email_username = ri.contact_email_username  => le.contact_email_username_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_email_username_weight100,s.contact_email_username_switch));
  INTEGER2 cnp_name_score := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT31.WithinEditN(le.cnp_name,ri.cnp_name,1,0) => SALT31.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT31.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT31.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT31.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT31.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT31.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  INTEGER2 v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT31.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  INTEGER2 fname_score := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT31.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT31.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 company_inc_state_score := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT31.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  INTEGER2 postdir_score := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT31.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  INTEGER2 st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT31.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  INTEGER2 source_score := MAP(
                        le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT31.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= Config.active_duns_number_Force * 100, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*company_charter_number_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*company_inc_state_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (active_duns_number_score + active_enterprise_number_score + company_charter_number_score + company_fein_score + source_record_id_score + contact_ssn_score + contact_phone_score + contact_email_username_score + cnp_name_score + lname_score + prim_name_score + prim_range_score + sec_range_score + v_city_name_score + fname_score + mname_score + company_inc_state_score + postdir_score + st_score + source_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':active_duns_number',
  n = 1 => ':active_enterprise_number',
  n = 2 => ':company_charter_number',
  n = 3 => ':company_fein',
  n = 4 => ':source_record_id',
  n = 5 => ':contact_ssn',
  n = 6 => ':contact_phone',
  n = 7 => ':contact_email_username',
  n = 8 => ':cnp_name',
  n = 9 => ':lname:prim_name',
  n = 10 => ':lname:prim_range',
  n = 11 => ':lname:sec_range',
  n = 12 => ':lname:v_city_name',
  n = 13 => ':lname:fname',
  n = 14 => ':lname:mname:company_inc_state',
  n = 15 => ':prim_name:prim_range',
  n = 16 => ':prim_name:sec_range',
  n = 17 => ':prim_name:v_city_name',
  n = 18 => ':prim_name:fname',
  n = 19 => ':prim_name:mname:company_inc_state',
  n = 20 => ':prim_range:sec_range',
  n = 21 => ':prim_range:v_city_name:*',
  n = 24 => ':prim_range:fname:*',
  n = 26 => ':prim_range:mname:company_inc_state',
  n = 27 => ':sec_range:v_city_name:*',
  n = 30 => ':sec_range:fname:*',
  n = 32 => ':sec_range:mname:company_inc_state',
  n = 33 => ':v_city_name:fname:*',
  n = 35 => ':v_city_name:mname:company_inc_state',
  n = 36 => ':fname:mname:company_inc_state','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 37 join conditions of which 7 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
//Fixed fields ->:active_duns_number(28)
dn0 := hfile(~active_duns_number_isnull);
dn0_deduped := dn0(active_duns_number_weight100>=2500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.active_duns_number = RIGHT.active_duns_number AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.active_duns_number = RIGHT.active_duns_number,10000),HASH);
//Fixed fields ->:active_enterprise_number(28)
dn1 := hfile(~active_enterprise_number_isnull);
dn1_deduped := dn1(active_enterprise_number_weight100>=2500); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,1),HINT(unsorted_output),ATMOST(LEFT.active_enterprise_number = RIGHT.active_enterprise_number,10000),HASH);
//Fixed fields ->:company_charter_number(27)
dn2 := hfile(~company_charter_number_isnull);
dn2_deduped := dn2(company_charter_number_weight100>=2500); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,2),HINT(unsorted_output),ATMOST(LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
//Fixed fields ->:company_fein(27)
dn3 := hfile(~company_fein_isnull);
dn3_deduped := dn3(company_fein_weight100>=2500); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.company_fein = RIGHT.company_fein AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,3),HINT(unsorted_output),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
//Fixed fields ->:source_record_id(27)
dn4 := hfile(~source_record_id_isnull);
dn4_deduped := dn4(source_record_id_weight100>=2500); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.source_record_id = RIGHT.source_record_id AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,4),HINT(unsorted_output),ATMOST(LEFT.source_record_id = RIGHT.source_record_id,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT31.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::0',EXPIRE(Config.PersistExpire));
//Fixed fields ->:contact_ssn(27)
dn5 := hfile(~contact_ssn_isnull);
dn5_deduped := dn5(contact_ssn_weight100>=2500); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.contact_ssn = RIGHT.contact_ssn AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,5),HINT(unsorted_output),ATMOST(LEFT.contact_ssn = RIGHT.contact_ssn,10000),HASH);
//Fixed fields ->:contact_phone(27)
dn6 := hfile(~contact_phone_isnull);
dn6_deduped := dn6(contact_phone_weight100>=2500); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.contact_phone = RIGHT.contact_phone AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,6),HINT(unsorted_output),ATMOST(LEFT.contact_phone = RIGHT.contact_phone,10000),HASH);
//Fixed fields ->:contact_email_username(27)
dn7 := hfile(~contact_email_username_isnull);
dn7_deduped := dn7(contact_email_username_weight100>=2500); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.contact_email_username = RIGHT.contact_email_username AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,7),HINT(unsorted_output),ATMOST(LEFT.contact_email_username = RIGHT.contact_email_username,10000),HASH);
//Fixed fields ->:cnp_name(25)
dn8 := hfile(~cnp_name_isnull);
dn8_deduped := dn8(cnp_name_weight100>=2500); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.cnp_name = RIGHT.cnp_name AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,8),HINT(unsorted_output),ATMOST(LEFT.cnp_name = RIGHT.cnp_name,10000),HASH);
//Fixed fields ->:lname(16):prim_name(15)
dn9 := hfile(~lname_isnull AND ~prim_name_isnull);
dn9_deduped := dn9(lname_weight100 + prim_name_weight100>=2500); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.prim_name = RIGHT.prim_name AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,9),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.prim_name = RIGHT.prim_name,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT31.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::1',EXPIRE(Config.PersistExpire));
//Fixed fields ->:lname(16):prim_range(13)
dn10 := hfile(~lname_isnull AND ~prim_range_isnull);
dn10_deduped := dn10(lname_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.prim_range = RIGHT.prim_range AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,10),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
//Fixed fields ->:lname(16):sec_range(12)
dn11 := hfile(~lname_isnull AND ~sec_range_isnull);
dn11_deduped := dn11(lname_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.sec_range = RIGHT.sec_range AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,11),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
//Fixed fields ->:lname(16):v_city_name(11)
dn12 := hfile(~lname_isnull AND ~v_city_name_isnull);
dn12_deduped := dn12(lname_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,12),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:lname(16):fname(11)
dn13 := hfile(~lname_isnull AND ~fname_isnull);
dn13_deduped := dn13(lname_weight100 + fname_weight100>=2500); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,13),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:lname(16):mname(8):company_inc_state(7)
dn14 := hfile(~lname_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn14_deduped := dn14(lname_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,14),HINT(unsorted_output),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT31.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::2',EXPIRE(Config.PersistExpire));
//Fixed fields ->:prim_name(15):prim_range(13)
dn15 := hfile(~prim_name_isnull AND ~prim_range_isnull);
dn15_deduped := dn15(prim_name_weight100 + prim_range_weight100>=2500); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,15),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
//Fixed fields ->:prim_name(15):sec_range(12)
dn16 := hfile(~prim_name_isnull AND ~sec_range_isnull);
dn16_deduped := dn16(prim_name_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj16 := JOIN( dn16_deduped, dn16_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,16),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
//Fixed fields ->:prim_name(15):v_city_name(11)
dn17 := hfile(~prim_name_isnull AND ~v_city_name_isnull);
dn17_deduped := dn17(prim_name_weight100 + v_city_name_weight100>=2500); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,17),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:prim_name(15):fname(11)
dn18 := hfile(~prim_name_isnull AND ~fname_isnull);
dn18_deduped := dn18(prim_name_weight100 + fname_weight100>=2500); // Use specificity to flag high-dup counts
mj18 := JOIN( dn18_deduped, dn18_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,18),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:prim_name(15):mname(8):company_inc_state(7)
dn19 := hfile(~prim_name_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn19_deduped := dn19(prim_name_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj19 := JOIN( dn19_deduped, dn19_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,19),HINT(unsorted_output),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT31.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::3',EXPIRE(Config.PersistExpire));
//Fixed fields ->:prim_range(13):sec_range(12)
dn20 := hfile(~prim_range_isnull AND ~sec_range_isnull);
dn20_deduped := dn20(prim_range_weight100 + sec_range_weight100>=2500); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,20),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_range(13):v_city_name(11):fname(11) also :prim_range(13):v_city_name(11):mname(8) also :prim_range(13):v_city_name(11):company_inc_state(7)
dn21 := hfile(~prim_range_isnull AND ~v_city_name_isnull);
dn21_deduped := dn21(prim_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj21 := JOIN( dn21_deduped, dn21_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
        ),trans(LEFT,RIGHT,21),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st,10000),HASH);
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):fname(11):mname(8) also :prim_range(13):fname(11):company_inc_state(7)
dn24 := hfile(~prim_range_isnull AND ~fname_isnull);
dn24_deduped := dn24(prim_range_weight100 + fname_weight100>=2100); // Use specificity to flag high-dup counts
mj24 := JOIN( dn24_deduped, dn24_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
        ),trans(LEFT,RIGHT,24),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs4_t := mj20+mj21+mj24;
SALT31.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::4',EXPIRE(Config.PersistExpire));
//Fixed fields ->:prim_range(13):mname(8):company_inc_state(7)
dn26 := hfile(~prim_range_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn26_deduped := dn26(prim_range_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj26 := JOIN( dn26_deduped, dn26_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,26),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:sec_range(12):v_city_name(11):fname(11) also :sec_range(12):v_city_name(11):mname(8) also :sec_range(12):v_city_name(11):company_inc_state(7)
dn27 := hfile(~sec_range_isnull AND ~v_city_name_isnull);
dn27_deduped := dn27(sec_range_weight100 + v_city_name_weight100>=2100); // Use specificity to flag high-dup counts
mj27 := JOIN( dn27_deduped, dn27_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
        ),trans(LEFT,RIGHT,27),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st,10000),HASH);
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:sec_range(12):fname(11):mname(8) also :sec_range(12):fname(11):company_inc_state(7)
dn30 := hfile(~sec_range_isnull AND ~fname_isnull);
dn30_deduped := dn30(sec_range_weight100 + fname_weight100>=2100); // Use specificity to flag high-dup counts
mj30 := JOIN( dn30_deduped, dn30_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
        ),trans(LEFT,RIGHT,30),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs5_t := mj26+mj27+mj30;
SALT31.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::5',EXPIRE(Config.PersistExpire));
//Fixed fields ->:sec_range(12):mname(8):company_inc_state(7)
dn32 := hfile(~sec_range_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn32_deduped := dn32(sec_range_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj32 := JOIN( dn32_deduped, dn32_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,32),HINT(unsorted_output),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:v_city_name(11):fname(11):mname(8) also :v_city_name(11):fname(11):company_inc_state(7)
dn33 := hfile(~v_city_name_isnull AND ~fname_isnull);
dn33_deduped := dn33(v_city_name_weight100 + fname_weight100>=2100); // Use specificity to flag high-dup counts
mj33 := JOIN( dn33_deduped, dn33_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull )
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
        ),trans(LEFT,RIGHT,33),HINT(unsorted_output),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:v_city_name(11):mname(8):company_inc_state(7)
dn35 := hfile(~v_city_name_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn35_deduped := dn35(v_city_name_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,35),HINT(unsorted_output),ATMOST(LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
//Fixed fields ->:fname(11):mname(8):company_inc_state(7)
dn36 := hfile(~fname_isnull AND ~mname_isnull AND ~company_inc_state_isnull);
dn36_deduped := dn36(fname_weight100 + mname_weight100 + company_inc_state_weight100>=2500); // Use specificity to flag high-dup counts
mj36 := JOIN( dn36_deduped, dn36_deduped, LEFT.Seleid > RIGHT.Seleid AND LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ),trans(LEFT,RIGHT,36),HINT(unsorted_output),ATMOST(LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),HASH);
last_mjs_t :=mj32+mj33+mj35+mj36;
SALT31.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs6 := o : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mj::6',EXPIRE(Config.PersistExpire));
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and Seleid
SALT31.mac_avoid_transitives(All_Matches,Seleid1,Seleid2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mt',EXPIRE(Config.PersistExpire));
SALT31.mac_get_BestPerRecord( All_Matches,rcid1,Seleid1,rcid2,Seleid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{Seleid, InCluster := COUNT(GROUP)},Seleid,LOCAL)(InCluster>1000); // Seleid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Seleid=RIGHT.Seleid,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.Seleid=RIGHT.Seleid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT31.mac_cluster_breadth(in_matches,rcid1,rcid2,Seleid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Seleid1=RIGHT.Seleid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT31.UIDType rcid;  //Outcast
  SALT31.UIDType Seleid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT31.UIDType Pref_rcid; // Prefers this record
  SALT31.UIDType Pref_Seleid; // Prefers this cluster
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
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Seleid)),Seleid,-Pref_Margin,LOCAL),Seleid,LOCAL)) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT31.MAC_Avoid_SliceOuts(PossibleMatches,Seleid1,Seleid2,Seleid,Pref_Seleid,ToSlice,m); // If Seleid is slice target - don't use in match
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
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rcid,Seleid});
  ut.MAC_Patch_Id(ih_thin,Seleid,BasicMatch(ih).patch_file,Seleid1,Seleid2,ihbp); // Perform basic matches
  SALT31.MAC_SliceOut_ByRID(ihbp,rcid,Seleid,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  ut.MAC_Patch_Id(sliced,Seleid,Matches,Seleid1,Seleid2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
EXPORT Patched_Infile := pi1;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Seleid,Matches,Seleid1,Seleid2,o1);
EXPORT Patched_Candidates := o1;
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT31.UIDType rcid;
    SALT31.UIDType Seleid_before;
    SALT31.UIDType Seleid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.Seleid_before := le.Seleid;
    SELF.Seleid_after := ri.Seleid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.Seleid<>RIGHT.Seleid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_Seleid_Relative.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_Seleid_Relative.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].Seleid_count - PostIDs.IdCounts[1].Seleid_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;