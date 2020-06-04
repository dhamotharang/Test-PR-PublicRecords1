// Begin code to perform the matching itself
 
IMPORT SALT32,ut,std;
EXPORT matches(DATASET(layout_DOT) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.DOTid1 := le.DOTid;
  SELF.DOTid2 := ri.DOTid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 isContact_score_temp := MAP(
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT32.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  INTEGER2 contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT32.WithinEditNew(le.contact_ssn,le.contact_ssn_len,ri.contact_ssn,ri.contact_ssn_len,1,0) => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_e1_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_e1_cnt),
                        le.contact_ssn_Right4 = ri.contact_ssn_Right4 => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_Right4_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_Right4_cnt),
                        SALT32.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 company_fein_score_temp := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT32.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT32.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP(
                        le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT32.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.WithinEditNew(le.cnp_name,le.cnp_name_len,ri.cnp_name,ri.cnp_name_len,1,0) => SALT32.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 corp_legal_name_score_temp := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT32.MatchBagOfWords(le.corp_legal_name,ri.corp_legal_name,31762,1));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.addr1_weight100 + ri.addr1_weight100 + le.csz_weight100 + ri.csz_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT32.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT32.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT32.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname OR SALT32.HyphenMatch(le.lname,ri.lname,3)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT32.WithinEditNew(le.lname,le.lname_len,ri.lname,ri.lname_len,1,0) => SALT32.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e1_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 mname_score_temp := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT32.WithinEditNew(le.mname,le.mname_len,ri.mname,ri.mname_len,1,0) => SALT32.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT32.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT32.WithinEditNew(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT32.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 name_suffix_score_temp := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT32.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT32.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  INTEGER2 cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_score_temp := MAP(
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT32.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 isContact_score := IF ( isContact_score_temp >= Config.isContact_Force * 100, isContact_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 company_fein_score := IF ( company_fein_score_temp >= Config.company_fein_Force * 100, company_fein_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 corp_legal_name_score := IF ( corp_legal_name_score_temp >= Config.corp_legal_name_Force * 100, corp_legal_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT32.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 lname_score := IF (le.lname = ri.lname or/*HACK*/  lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 mname_score := IF ( mname_score_temp >= Config.mname_Force * 100, mname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := IF (le.fname = ri.fname or/*HACK*/  fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 name_suffix_score := IF ( name_suffix_score_temp >= Config.name_suffix_Force * 100, name_suffix_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > Config.st_Force * 100 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := SALT32.ClipScore(MAX(addr1_score_pre,0) + prim_range_score + prim_name_score + sec_range_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  INTEGER2 addr1_score := addr1_score_res;
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := SALT32.ClipScore(MAX(csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  INTEGER2 csz_score := IF ( csz_score_ext > -200,csz_score_res,SKIP);
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT32.ClipScore(MAX(address_score_pre,0)+ addr1_score + prim_range_score + prim_name_score + sec_range_score+ csz_score + v_city_name_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := IF ( address_score_ext > 0,address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.prim_range_prop,ri.prim_range_prop)*prim_range_score // Score if either field propogated
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score // Score if either field propogated
    +MAX(le.active_domestic_corp_key_prop,ri.active_domestic_corp_key_prop)*active_domestic_corp_key_score // Score if either field propogated
    +MAX(le.corp_legal_name_prop,ri.corp_legal_name_prop)*corp_legal_name_score // Score if either field propogated
    +if(le.address_prop+ri.address_prop>0,address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,s.addr1_specificity,0))/( s.addr1_specificity),0)
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,addr1_score*(0+if(le.prim_range_prop+ri.prim_range_prop>0,s.prim_range_specificity,0)+if(le.prim_name_prop+ri.prim_name_prop>0,s.prim_name_specificity,0)+if(le.sec_range_prop+ri.sec_range_prop>0,s.sec_range_specificity,0))/( s.prim_range_specificity+ s.prim_name_specificity+ s.sec_range_specificity),0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +(MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*mname_score // Proportion of longest string propogated
    +MAX(le.name_suffix_prop,ri.name_suffix_prop)*name_suffix_score // Score if either field propogated
    +MAX(le.cnp_btype_prop,ri.cnp_btype_prop)*cnp_btype_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (cnp_number_score + isContact_score + contact_ssn_score + company_fein_score + active_enterprise_number_score + active_domestic_corp_key_score + cnp_name_score + corp_legal_name_score + IF(address_score>0,MAX(address_score,IF(addr1_score>0,MAX(addr1_score,prim_range_score + prim_name_score + sec_range_score),prim_range_score + prim_name_score + sec_range_score) + IF(csz_score>0,MAX(csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score)),IF(addr1_score>0,MAX(addr1_score,prim_range_score + prim_name_score + sec_range_score),prim_range_score + prim_name_score + sec_range_score) + IF(csz_score>0,MAX(csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score)) + active_duns_number_score + lname_score + mname_score + fname_score + name_suffix_score + cnp_btype_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':cnp_number:prim_range:prim_name:st:isContact','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:cnp_number(14):prim_range(13):prim_name(15):st(5):isContact(1)
 
dn0 := hfile(~prim_name_isnull AND ~st_isnull);
dn0_deduped := dn0(cnp_number_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100 + isContact_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.DOTid > RIGHT.DOTid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.company_fein = right.company_fein OR left.company_fein_isnull OR right.company_fein_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) /* AND ( ~left.lname_isnull AND ~right.lname_isnull ) *//*HACK*/ /* AND ( ~left.fname_isnull AND ~right.fname_isnull ) *//*HACK*/ AND ( left.name_suffix = right.name_suffix OR left.name_suffix_isnull OR right.name_suffix_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact,10000),HASH);
last_mjs_t :=_mj_extra(hfile,trans) + mj0;
SALT32.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::mj::0',EXPIRE(Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
 
//Now construct candidates based upon attribute & relationship files
 
AllAttrMatches := SORT(Mod_Attr_ForeignCorpkey(ih).Match,DOTid1,DOTid2,Rule,-(Conf+Conf_Prop),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.DOTid1=RIGHT.DOTid1 AND LEFT.DOTid2=RIGHT.DOTid2,CombineResults(LEFT,RIGHT),LOCAL);
hd := DISTRIBUTE(h,HASH(DOTid));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(DOTid2)),hd,LEFT.DOTid2=RIGHT.DOTid,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(DOTid1)),hd,LEFT.DOTid1 = RIGHT.DOTid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ),match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf),LOCAL); // Will be distributed by DID1
with_attr := attr_match + all_mjs;
all_matches0 := Mod_Attr_ForeignCorpkey(ih).ForceFilter(ih,with_attr,DOTid1,DOTid2); // Restrict to those matches obeying force upon ForeignCorpkey
EXPORT All_Matches := all_matches0 : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and DOTid
SALT32.mac_avoid_transitives(All_Matches,DOTid1,DOTid2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::mt',EXPIRE(Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Matches::Matches',EXPIRE(Config.PersistExpire));
 
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches,All_Attribute_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rcid,DOTid,proxid,lgid3,orgid,ultid});
  ut.MAC_Patch_Id(ih_thin,DOTid,BasicMatch(ih).patch_file,DOTid1,DOTid2,ihbp); // Perform basic matches
  SALT32.MAC_Reassign_UID(ihbp,Cleave(ih).patch_file,DOTid,rcid,ih1); // Perform cleaves
  ut.MAC_Patch_Id(ih1,DOTid,Matches,DOTid1,DOTid2,o); // Join Clusters
  Patchproxid := SALT32.MAC_ParentId_Patch(o,proxid,DOTid);  // Collapse any proxid now joined by DOTid
  Patchlgid3 := SALT32.MAC_ParentId_Patch(Patchproxid,lgid3,proxid);  // Collapse any lgid3 now joined by proxid
  Patchorgid := SALT32.MAC_ParentId_Patch(Patchlgid3,orgid,lgid3);  // Collapse any orgid now joined by lgid3
  Patchultid := SALT32.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
SHARED Patched_Infile_thin := Patchultid : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK*/);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,DOTid,Matches,DOTid1,DOTid2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT32.UIDType rcid;
    SALT32.UIDType DOTid_before;
    SALT32.UIDType DOTid_after;
    SALT32.UIDType proxid_before;
    SALT32.UIDType proxid_after;
    SALT32.UIDType lgid3_before;
    SALT32.UIDType lgid3_after;
    SALT32.UIDType orgid_before;
    SALT32.UIDType orgid_after;
    SALT32.UIDType ultid_before;
    SALT32.UIDType ultid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.DOTid_before := le.DOTid;
    SELF.DOTid_after := ri.DOTid;
    SELF.proxid_before := le.proxid;
    SELF.proxid_after := ri.proxid;
    SELF.lgid3_before := le.lgid3;
    SELF.lgid3_after := ri.lgid3;
    SELF.orgid_before := le.orgid;
    SELF.orgid_after := ri.orgid;
    SELF.ultid_before := le.ultid;
    SELF.ultid_after := ri.ultid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.DOTid<>RIGHT.DOTid OR LEFT.proxid<>RIGHT.proxid OR LEFT.lgid3<>RIGHT.lgid3 OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_DOTID_PLATFORM.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_DOTID_PLATFORM.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].DOTid_cnt - PostIDs.IdCounts[1].DOTid_cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + Cleave(ih).patch_count; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Cnt; // Should be zero
END;
