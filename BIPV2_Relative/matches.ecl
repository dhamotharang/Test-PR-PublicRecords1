// Begin code to perform the matching itself
IMPORT SALT25,ut;
EXPORT matches(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 32) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT25.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_hasnumber_score_temp := MAP( le.cnp_hasnumber_isnull OR ri.cnp_hasnumber_isnull OR le.cnp_hasnumber_weight100 = 0 => 0,
                        le.cnp_hasnumber = ri.cnp_hasnumber  => le.cnp_hasnumber_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_hasnumber_weight100,s.cnp_hasnumber_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT25.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 source_record_id_score := MAP( le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT25.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  INTEGER2 contact_ssn_score := MAP( le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT25.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 company_charter_number_score := MAP( le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state <> ri.company_inc_state => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT25.WithinEditN(le.company_charter_number,ri.company_charter_number,1) => SALT25.fn_fuzzy_specificity(le.company_charter_number_weight100,le.company_charter_number_cnt, le.company_charter_number_e1_cnt,ri.company_charter_number_weight100,ri.company_charter_number_cnt,ri.company_charter_number_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.company_charter_number_weight100,s.company_charter_number_switch));
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT25.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT25.WithinEditN(le.active_domestic_corp_key,ri.active_domestic_corp_key,1) => SALT25.fn_fuzzy_specificity(le.active_domestic_corp_key_weight100,le.active_domestic_corp_key_cnt, le.active_domestic_corp_key_e1_cnt,ri.active_domestic_corp_key_weight100,ri.active_domestic_corp_key_cnt,ri.active_domestic_corp_key_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 contact_phone_score := MAP( le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  INTEGER2 cnp_name_score := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT25.WithinEditN(le.cnp_name,ri.cnp_name,1) => SALT25.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 corp_legal_name_score_temp := MAP( le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT25.WithinEditN(le.corp_legal_name,ri.corp_legal_name,1) => SALT25.fn_fuzzy_specificity(le.corp_legal_name_weight100,le.corp_legal_name_cnt, le.corp_legal_name_e1_cnt,ri.corp_legal_name_weight100,ri.corp_legal_name_cnt,ri.corp_legal_name_e1_cnt),
                        SALT25.Fn_Fail_Scale(le.corp_legal_name_weight100,s.corp_legal_name_switch));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  INTEGER2 prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT25.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 lname_score := MAP( le.lname_isnull OR ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT25.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT25.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 prim_range_score_temp := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT25.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 zip4_score := MAP( le.zip4_isnull OR ri.zip4_isnull => 0,
                        le.zip <> ri.zip => 0, // Only valid if the context variable is equal
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT25.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  INTEGER2 sec_range_score_temp := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT25.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 cnp_number_score_temp := MAP( le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 p_city_name_score := MAP( le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
                        SALT25.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));
  INTEGER2 v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT25.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 fname_score := MAP( le.fname_isnull OR ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT25.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 company_inc_state_score := MAP( le.company_inc_state_isnull OR ri.company_inc_state_isnull => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT25.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
  INTEGER2 mname_score := MAP( le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT25.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 postdir_score := MAP( le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT25.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  INTEGER2 st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT25.Fn_Fail_Scale(le.st_weight100,s.st_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 predir_score := MAP( le.predir_isnull OR ri.predir_isnull => 0,
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT25.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  INTEGER2 addr_suffix_score := MAP( le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT25.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  INTEGER2 cnp_btype_score_temp := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT25.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 source_score := MAP( le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT25.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  INTEGER2 iscorp_score := MAP( le.iscorp_isnull OR ri.iscorp_isnull => 0,
                        le.iscorp = ri.iscorp  => le.iscorp_weight100,
                        SALT25.Fn_Fail_Scale(le.iscorp_weight100,s.iscorp_switch));
  INTEGER2 contact_email_username_score := MAP( le.contact_email_username_isnull OR ri.contact_email_username_isnull => 0,
                        le.contact_email_username = ri.contact_email_username  => le.contact_email_username_weight100,
                        SALT25.Fn_Fail_Scale(le.contact_email_username_weight100,s.contact_email_username_switch));
  INTEGER2 cnp_hasnumber_score := IF ( cnp_hasnumber_score_temp > 0, cnp_hasnumber_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 corp_legal_name_score := IF ( corp_legal_name_score_temp >= 0, corp_legal_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= 0, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_btype_score := IF ( cnp_btype_score_temp >= 0, cnp_btype_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + prim_range_score + prim_name_score + sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := company_addr1_score_res;
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := company_csz_score_res;
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ company_addr1_score + prim_range_score + prim_name_score + sec_range_score+ company_csz_score + v_city_name_score + st_score + zip_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  INTEGER2 company_address_score := company_address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.company_charter_number_prop,ri.company_charter_number_prop)*company_charter_number_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.corp_legal_name_prop,ri.corp_legal_name_prop)*corp_legal_name_score // Score if either field propogated
    +if(le.company_address_prop+ri.company_address_prop>0,company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +MAX(le.company_inc_state_prop,ri.company_inc_state_prop)*company_inc_state_score // Score if either field propogated
    +MAX(le.iscorp_prop,ri.iscorp_prop)*iscorp_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (cnp_hasnumber_score + active_enterprise_number_score + source_record_id_score + contact_ssn_score + company_fein_score + company_charter_number_score + active_duns_number_score + active_domestic_corp_key_score + contact_phone_score + cnp_name_score + corp_legal_name_score + company_address_score + company_addr1_score + company_csz_score + prim_name_score + lname_score + zip_score + prim_range_score + zip4_score + sec_range_score + cnp_number_score + p_city_name_score + v_city_name_score + fname_score + company_inc_state_score + mname_score + postdir_score + st_score + predir_score + addr_suffix_score + cnp_btype_score + source_score + iscorp_score + contact_email_username_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':cnp_hasnumber:active_enterprise_number',
  n = 1 => ':cnp_hasnumber:source_record_id',
  n = 2 => ':cnp_hasnumber:contact_ssn',
  n = 3 => ':cnp_hasnumber:company_fein',
  n = 4 => ':cnp_hasnumber:company_charter_number',
  n = 5 => ':cnp_hasnumber:active_duns_number',
  n = 6 => ':cnp_hasnumber:active_domestic_corp_key',
  n = 7 => ':cnp_hasnumber:contact_phone',
  n = 8 => ':cnp_hasnumber:cnp_name',
  n = 9 => ':cnp_hasnumber:corp_legal_name',
  n = 10 => ':cnp_hasnumber:prim_name',
  n = 11 => ':cnp_hasnumber:lname',
  n = 12 => ':cnp_hasnumber:zip',
  n = 13 => ':cnp_hasnumber:prim_range',
  n = 14 => ':cnp_hasnumber:zip4',
  n = 15 => ':cnp_hasnumber:sec_range:*',
  n = 22 => ':cnp_hasnumber:cnp_number:*',
  n = 28 => ':cnp_hasnumber:p_city_name:*',
  n = 33 => ':cnp_hasnumber:v_city_name:*',
  n = 37 => ':cnp_hasnumber:fname:*',
  n = 40 => ':cnp_hasnumber:company_inc_state:*',
  n = 42 => ':cnp_hasnumber:mname:postdir','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 43 join conditions of which 21 have been optimized into preceding conditions
//Fixed fields ->:cnp_hasnumber(0):active_enterprise_number(26)
dn0 := h(~cnp_hasnumber_isnull AND ~active_enterprise_number_isnull);
dn0_deduped := dn0(cnp_hasnumber_weight100 + active_enterprise_number_weight100>=1300); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,0),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):source_record_id(26)
dn1 := h(~cnp_hasnumber_isnull AND ~source_record_id_isnull);
dn1_deduped := dn1(cnp_hasnumber_weight100 + source_record_id_weight100>=1300); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.source_record_id = RIGHT.source_record_id AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,1),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.source_record_id = RIGHT.source_record_id,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):contact_ssn(26)
dn2 := h(~cnp_hasnumber_isnull AND ~contact_ssn_isnull);
dn2_deduped := dn2(cnp_hasnumber_weight100 + contact_ssn_weight100>=1300); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.contact_ssn = RIGHT.contact_ssn AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,2),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.contact_ssn = RIGHT.contact_ssn,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):company_fein(25)
dn3 := h(~cnp_hasnumber_isnull AND ~company_fein_isnull);
dn3_deduped := dn3(cnp_hasnumber_weight100 + company_fein_weight100>=1300); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_fein = RIGHT.company_fein AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,3),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_fein = RIGHT.company_fein,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):company_charter_number(25)
dn4 := h(~cnp_hasnumber_isnull AND ~company_charter_number_isnull);
dn4_deduped := dn4(cnp_hasnumber_weight100 + company_charter_number_weight100>=1300); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,4),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),SKEW(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT25.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : persist('temp::BIPV2_Relative::Proxid::mj0');
//Fixed fields ->:cnp_hasnumber(0):active_duns_number(25)
dn5 := h(~cnp_hasnumber_isnull AND ~active_duns_number_isnull);
dn5_deduped := dn5(cnp_hasnumber_weight100 + active_duns_number_weight100>=1300); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_duns_number = RIGHT.active_duns_number AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,5),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_duns_number = RIGHT.active_duns_number,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):active_domestic_corp_key(25)
dn6 := h(~cnp_hasnumber_isnull AND ~active_domestic_corp_key_isnull);
dn6_deduped := dn6(cnp_hasnumber_weight100 + active_domestic_corp_key_weight100>=1300); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,6),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):contact_phone(25)
dn7 := h(~cnp_hasnumber_isnull AND ~contact_phone_isnull);
dn7_deduped := dn7(cnp_hasnumber_weight100 + contact_phone_weight100>=1300); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.contact_phone = RIGHT.contact_phone AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,7),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.contact_phone = RIGHT.contact_phone,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):cnp_name(24)
dn8 := h(~cnp_hasnumber_isnull AND ~cnp_name_isnull);
dn8_deduped := dn8(cnp_hasnumber_weight100 + cnp_name_weight100>=1300); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.cnp_name = RIGHT.cnp_name AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,8),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.cnp_name = RIGHT.cnp_name,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):corp_legal_name(24)
dn9 := h(~cnp_hasnumber_isnull AND ~corp_legal_name_isnull);
dn9_deduped := dn9(cnp_hasnumber_weight100 + corp_legal_name_weight100>=1300); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.corp_legal_name = RIGHT.corp_legal_name AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,9),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.corp_legal_name = RIGHT.corp_legal_name,10000),SKEW(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT25.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : persist('temp::BIPV2_Relative::Proxid::mj1');
//Fixed fields ->:cnp_hasnumber(0):prim_name(15)
dn10 := h(~cnp_hasnumber_isnull AND ~prim_name_isnull);
dn10_deduped := dn10(cnp_hasnumber_weight100 + prim_name_weight100>=1300); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.prim_name = RIGHT.prim_name AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,10),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.prim_name = RIGHT.prim_name,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):lname(15)
dn11 := h(~cnp_hasnumber_isnull AND ~lname_isnull);
dn11_deduped := dn11(cnp_hasnumber_weight100 + lname_weight100>=1300); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.lname = RIGHT.lname AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,11),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.lname = RIGHT.lname,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):zip(14)
dn12 := h(~cnp_hasnumber_isnull AND ~zip_isnull);
dn12_deduped := dn12(cnp_hasnumber_weight100 + zip_weight100>=1300); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.zip = RIGHT.zip AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,12),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.zip = RIGHT.zip,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):prim_range(13)
dn13 := h(~cnp_hasnumber_isnull AND ~prim_range_isnull);
dn13_deduped := dn13(cnp_hasnumber_weight100 + prim_range_weight100>=1300); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.prim_range = RIGHT.prim_range AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,13),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.prim_range = RIGHT.prim_range,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):zip4(13)
dn14 := h(~cnp_hasnumber_isnull AND ~zip4_isnull);
dn14_deduped := dn14(cnp_hasnumber_weight100 + zip4_weight100>=1300); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.zip4 = RIGHT.zip4 AND LEFT.zip = RIGHT.zip AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,14),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.zip4 = RIGHT.zip4 AND LEFT.zip = RIGHT.zip,10000),SKEW(1));
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT25.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : persist('temp::BIPV2_Relative::Proxid::mj2');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):sec_range(12):cnp_number(11) also :cnp_hasnumber(0):sec_range(12):p_city_name(11) also :cnp_hasnumber(0):sec_range(12):v_city_name(11) also :cnp_hasnumber(0):sec_range(12):fname(10) also :cnp_hasnumber(0):sec_range(12):company_inc_state(8) also :cnp_hasnumber(0):sec_range(12):mname(8) also :cnp_hasnumber(0):sec_range(12):postdir(7)
dn15 := h(~cnp_hasnumber_isnull AND ~sec_range_isnull);
dn15_deduped := dn15(cnp_hasnumber_weight100 + sec_range_weight100>=900); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.sec_range = RIGHT.sec_range AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ~LEFT.p_city_name_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ~LEFT.v_city_name_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,15),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.sec_range = RIGHT.sec_range,10000),SKEW(1));
mjs3_t := mj15;
SALT25.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : persist('temp::BIPV2_Relative::Proxid::mj3');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):cnp_number(11):p_city_name(11) also :cnp_hasnumber(0):cnp_number(11):v_city_name(11) also :cnp_hasnumber(0):cnp_number(11):fname(10) also :cnp_hasnumber(0):cnp_number(11):company_inc_state(8) also :cnp_hasnumber(0):cnp_number(11):mname(8) also :cnp_hasnumber(0):cnp_number(11):postdir(7)
dn22 := h(~cnp_hasnumber_isnull AND ~cnp_number_isnull);
dn22_deduped := dn22(cnp_hasnumber_weight100 + cnp_number_weight100>=900); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.cnp_number = RIGHT.cnp_number AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ~LEFT.p_city_name_isnull
    OR    LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ~LEFT.v_city_name_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,22),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.cnp_number = RIGHT.cnp_number,10000),SKEW(1));
mjs4_t := mj22;
SALT25.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : persist('temp::BIPV2_Relative::Proxid::mj4');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):p_city_name(11):v_city_name(11) also :cnp_hasnumber(0):p_city_name(11):fname(10) also :cnp_hasnumber(0):p_city_name(11):company_inc_state(8) also :cnp_hasnumber(0):p_city_name(11):mname(8) also :cnp_hasnumber(0):p_city_name(11):postdir(7)
dn28 := h(~cnp_hasnumber_isnull AND ~p_city_name_isnull);
dn28_deduped := dn28(cnp_hasnumber_weight100 + p_city_name_weight100>=900); // Use specificity to flag high-dup counts
mj28 := JOIN( dn28_deduped, dn28_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ~LEFT.v_city_name_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,28),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,10000),SKEW(1));
mjs5_t := mj28;
SALT25.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : persist('temp::BIPV2_Relative::Proxid::mj5');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):v_city_name(11):fname(10) also :cnp_hasnumber(0):v_city_name(11):company_inc_state(8) also :cnp_hasnumber(0):v_city_name(11):mname(8) also :cnp_hasnumber(0):v_city_name(11):postdir(7)
dn33 := h(~cnp_hasnumber_isnull AND ~v_city_name_isnull);
dn33_deduped := dn33(cnp_hasnumber_weight100 + v_city_name_weight100>=900); // Use specificity to flag high-dup counts
mj33 := JOIN( dn33_deduped, dn33_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,33),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st,10000),SKEW(1));
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):fname(10):company_inc_state(8) also :cnp_hasnumber(0):fname(10):mname(8) also :cnp_hasnumber(0):fname(10):postdir(7)
dn37 := h(~cnp_hasnumber_isnull AND ~fname_isnull);
dn37_deduped := dn37(cnp_hasnumber_weight100 + fname_weight100>=900); // Use specificity to flag high-dup counts
mj37 := JOIN( dn37_deduped, dn37_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.fname = RIGHT.fname AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.company_inc_state = RIGHT.company_inc_state AND ~LEFT.company_inc_state_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,37),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.fname = RIGHT.fname,10000),SKEW(1));
mjs6_t := mj33+mj37;
SALT25.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : persist('temp::BIPV2_Relative::Proxid::mj6');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:cnp_hasnumber(0):company_inc_state(8):mname(8) also :cnp_hasnumber(0):company_inc_state(8):postdir(7)
dn40 := h(~cnp_hasnumber_isnull AND ~company_inc_state_isnull);
dn40_deduped := dn40(cnp_hasnumber_weight100 + company_inc_state_weight100>=900); // Use specificity to flag high-dup counts
mj40 := JOIN( dn40_deduped, dn40_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_inc_state = RIGHT.company_inc_state AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull )
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ~LEFT.postdir_isnull
        ),match_join(LEFT,RIGHT,40),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.company_inc_state = RIGHT.company_inc_state,10000),SKEW(1));
//Fixed fields ->:cnp_hasnumber(0):mname(8):postdir(7)
dn42 := h(~cnp_hasnumber_isnull AND ~mname_isnull AND ~postdir_isnull);
dn42_deduped := dn42(cnp_hasnumber_weight100 + mname_weight100 + postdir_weight100>=1300); // Use specificity to flag high-dup counts
mj42 := JOIN( dn42_deduped, dn42_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.mname = RIGHT.mname AND LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND ( ~left.cnp_hasnumber_isnull AND ~right.cnp_hasnumber_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.prim_range = right.prim_range OR left.prim_range_isnull OR right.prim_range_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ),match_join(LEFT,RIGHT,42),ATMOST(LEFT.cnp_hasnumber = RIGHT.cnp_hasnumber AND LEFT.mname = RIGHT.mname AND LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name,10000),SKEW(1));
last_mjs_t :=mj40+mj42;
SALT25.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6 +o;
export All_Matches := all_mjs : persist('temp::BIPV2_Relative_Proxid_DOT_Base_all_m'); // To by used by rcid and Proxid
SALT25.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::BIPV2_Relative_Proxid_DOT_Base_mt');
SALT25.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('temp::BIPV2_Relative_Proxid_DOT_Base_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT25.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('temp::BIPV2_Relative_Proxid_DOT_Base_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT25.UIDType rcid;  //Outcast
  SALT25.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT25.UIDType Pref_rcid; // Prefers this record
  SALT25.UIDType Pref_Proxid; // Prefers this cluster
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
SALT25.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
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
SALT25.MAC_SliceOut_ByRID(ih,rcid,Proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
EXPORT Patched_Infile := o;
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
