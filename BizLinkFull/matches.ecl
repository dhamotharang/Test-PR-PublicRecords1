// Begin code to perform the matching itself
 
IMPORT SALT33,ut,std;
EXPORT matches(DATASET(layout_BizHead) ih,UNSIGNED MatchThreshold = Config_BIP.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.proxid1 := le.proxid;
  SELF.proxid2 := ri.proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  INTEGER2 parent_proxid_score_temp := MAP(
                        le.parent_proxid_isnull OR ri.parent_proxid_isnull => 0,
                        le.parent_proxid = ri.parent_proxid  => le.parent_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.parent_proxid_weight100,s.parent_proxid_switch));
  INTEGER2 sele_proxid_score_temp := MAP(
                        le.sele_proxid_isnull OR ri.sele_proxid_isnull => 0,
                        le.sele_proxid = ri.sele_proxid  => le.sele_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.sele_proxid_weight100,s.sele_proxid_switch));
  INTEGER2 org_proxid_score_temp := MAP(
                        le.org_proxid_isnull OR ri.org_proxid_isnull => 0,
                        le.org_proxid = ri.org_proxid  => le.org_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.org_proxid_weight100,s.org_proxid_switch));
  INTEGER2 ultimate_proxid_score_temp := MAP(
                        le.ultimate_proxid_isnull OR ri.ultimate_proxid_isnull => 0,
                        le.ultimate_proxid = ri.ultimate_proxid  => le.ultimate_proxid_weight100,
                        SALT33.Fn_Fail_Scale(le.ultimate_proxid_weight100,s.ultimate_proxid_switch));
  INTEGER2 source_record_id_score := MAP(
                        le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT33.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  INTEGER2 company_url_score := MAP(
                        le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT33.MatchBagOfWords(le.company_url,ri.company_url,31744,0));
  INTEGER2 contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 contact_email_score := MAP(
                        le.contact_email_isnull OR ri.contact_email_isnull => 0,
                        le.contact_email = ri.contact_email  => le.contact_email_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_email_weight100,s.contact_email_switch));
  INTEGER2 company_name_score := MAP(
                        le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT33.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  INTEGER2 cnp_name_score := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT33.MatchBagOfWords(le.cnp_name,ri.cnp_name,3177747,1));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT33.WithinEditNew(le.company_fein,le.company_fein_len,ri.company_fein,ri.company_fein_len,1,0) => SALT33.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 contact_did_score := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT33.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  INTEGER2 company_phone_7_score := MAP(
                        le.company_phone_7_isnull OR ri.company_phone_7_isnull => 0,
                        le.company_phone_7 = ri.company_phone_7  => le.company_phone_7_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_7_weight100,s.company_phone_7_switch));
  INTEGER2 CONTACTNAME_score_pre := MAP( (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  INTEGER2 STREETADDRESS_score_pre := MAP( (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  INTEGER2 company_name_prefix_score_temp := MAP(
                        le.company_name_prefix_isnull OR ri.company_name_prefix_isnull => 0,
                        le.company_name_prefix = ri.company_name_prefix  => le.company_name_prefix_weight100,
                        SALT33.Fn_Fail_Scale(le.company_name_prefix_weight100,s.company_name_prefix_switch));
  INTEGER2 prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT33.WithinEditNew(le.prim_name,le.prim_name_len,ri.prim_name,ri.prim_name_len,1,0) => SALT33.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT33.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  INTEGER2 cnp_number_score := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT33.WithinEditNew(le.prim_range,le.prim_range_len,ri.prim_range,ri.prim_range_len,1,0) => SALT33.fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT33.WithinEditNew(le.sec_range,le.sec_range_len,ri.sec_range,ri.sec_range_len,1,0) => SALT33.fn_fuzzy_specificity(le.sec_range_weight100,le.sec_range_cnt, le.sec_range_e1_cnt,ri.sec_range_weight100,ri.sec_range_cnt,ri.sec_range_e1_cnt),
                        SALT33.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  INTEGER2 city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.city = ri.city  => le.city_weight100,
                        SALT33.WithinEditNew(le.city,le.city_len,ri.city,ri.city_len,2,0) and metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2p_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2p_cnt),
                        SALT33.WithinEditNew(le.city,le.city_len,ri.city,ri.city_len,2,0) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2_cnt),
                        metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT33.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_p_cnt,ri.city_weight100,ri.city_cnt,ri.city_p_cnt),
                        SALT33.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  INTEGER2 city_clean_score := MAP(
                        le.city_clean_isnull OR ri.city_clean_isnull => 0,
                        le.city_clean = ri.city_clean  => le.city_clean_weight100,
                        SALT33.Fn_Fail_Scale(le.city_clean_weight100,s.city_clean_switch));
  INTEGER2 company_sic_code1_score := MAP(
                        le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
                        le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
                        SALT33.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));
  INTEGER2 lname_score := MAP(
                        le.lname_isnull OR ri.lname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.lname = ri.lname OR SALT33.HyphenMatch(le.lname,ri.lname,1)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT33.WithinEditNew(le.lname,le.lname_len,ri.lname,ri.lname_len,2,0) => SALT33.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e2_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e2_cnt),
                        LENGTH(TRIM(le.lname))>0 and le.lname = ri.lname[1..LENGTH(TRIM(le.lname))] => le.lname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.lname))>0 and ri.lname = le.lname[1..LENGTH(TRIM(ri.lname))] => ri.lname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 company_phone_3_score := MAP(
                        le.company_phone_3_isnull OR ri.company_phone_3_isnull => 0,
                        le.company_phone_3 = ri.company_phone_3  => le.company_phone_3_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_3_weight100,s.company_phone_3_switch));
  INTEGER2 company_phone_3_ex_score := MAP(
                        le.company_phone_3_ex_isnull OR ri.company_phone_3_ex_isnull => 0,
                        le.company_phone_3_ex = ri.company_phone_3_ex  => le.company_phone_3_ex_weight100,
                        SALT33.Fn_Fail_Scale(le.company_phone_3_ex_weight100,s.company_phone_3_ex_switch));
  INTEGER2 fname_preferred_score := MAP(
                        le.fname_preferred_isnull OR ri.fname_preferred_isnull => 0,
                        le.fname_preferred = ri.fname_preferred  => le.fname_preferred_weight100,
                        SALT33.Fn_Fail_Scale(le.fname_preferred_weight100,s.fname_preferred_switch));
  INTEGER2 mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT33.WithinEditNew(le.mname,le.mname_len,ri.mname,ri.mname_len,2,0) => SALT33.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e2_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e2_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT33.WithinEditNew(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) => SALT33.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        SALT33.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 name_suffix_score := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT33.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT33.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  INTEGER2 cnp_lowv_score := MAP(
                        le.cnp_lowv_isnull OR ri.cnp_lowv_isnull => 0,
                        le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_lowv_weight100,s.cnp_lowv_switch));
  INTEGER2 st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT33.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  INTEGER2 source_score := MAP(
                        le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT33.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  INTEGER2 cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT33.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 isContact_score := MAP(
                        le.isContact_isnull OR ri.isContact_isnull => 0,
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT33.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  INTEGER2 title_score := MAP(
                        le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT33.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  INTEGER2 sele_flag_score_temp := MAP(
                        le.sele_flag_isnull OR ri.sele_flag_isnull => 0,
                        le.sele_flag = ri.sele_flag  => le.sele_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.sele_flag_weight100,s.sele_flag_switch));
  INTEGER2 org_flag_score_temp := MAP(
                        le.org_flag_isnull OR ri.org_flag_isnull => 0,
                        le.org_flag = ri.org_flag  => le.org_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.org_flag_weight100,s.org_flag_switch));
  INTEGER2 ult_flag_score_temp := MAP(
                        le.ult_flag_isnull OR ri.ult_flag_isnull => 0,
                        le.ult_flag = ri.ult_flag  => le.ult_flag_weight100,
                        SALT33.Fn_Fail_Scale(le.ult_flag_weight100,s.ult_flag_switch));
  INTEGER2 fallback_value_score := MAP(
                        le.fallback_value_isnull OR ri.fallback_value_isnull => 0,
                        le.fallback_value = ri.fallback_value  => le.fallback_value_weight100,
                        SALT33.Fn_Fail_Scale(le.fallback_value_weight100,s.fallback_value_switch));
  INTEGER2 parent_proxid_score := parent_proxid_score_temp*0.00; 
  INTEGER2 sele_proxid_score := sele_proxid_score_temp*0.00; 
  INTEGER2 org_proxid_score := org_proxid_score_temp*0.00; 
  INTEGER2 ultimate_proxid_score := ultimate_proxid_score_temp*0.00; 
  INTEGER2 company_name_prefix_score := company_name_prefix_score_temp*0.10; 
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config_BIP.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := fname_score_temp*0.20; 
  INTEGER2 sele_flag_score := sele_flag_score_temp*0.00; 
  INTEGER2 org_flag_score := org_flag_score_temp*0.00; 
  INTEGER2 ult_flag_score := ult_flag_score_temp*0.00; 
// Compute the score for the concept CONTACTNAME
  INTEGER2 CONTACTNAME_score_ext := SALT33.ClipScore(MAX(CONTACTNAME_score_pre,0) + fname_score + mname_score + lname_score);// Score in surrounding context
  INTEGER2 CONTACTNAME_score_res := MAX(0,CONTACTNAME_score_pre); // At least nothing
  INTEGER2 CONTACTNAME_score := CONTACTNAME_score_res;
// Compute the score for the concept STREETADDRESS
  INTEGER2 STREETADDRESS_score_ext := SALT33.ClipScore(MAX(STREETADDRESS_score_pre,0) + prim_range_score + prim_name_score + sec_range_score);// Score in surrounding context
  INTEGER2 STREETADDRESS_score_res := MAX(0,STREETADDRESS_score_pre); // At least nothing
  INTEGER2 STREETADDRESS_score := STREETADDRESS_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +MAX(le.company_sic_code1_prop,ri.company_sic_code1_prop)*company_sic_code1_score // Score if either field propogated
    +MAX(le.cnp_btype_prop,ri.cnp_btype_prop)*cnp_btype_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (parent_proxid_score + sele_proxid_score + org_proxid_score + ultimate_proxid_score + source_record_id_score + company_url_score + contact_ssn_score + contact_email_score + company_name_score + cnp_name_score + company_fein_score + contact_did_score + company_phone_7_score + IF(CONTACTNAME_score>0,MAX(CONTACTNAME_score,fname_score + mname_score + lname_score),fname_score + mname_score + lname_score) + IF(STREETADDRESS_score>0,MAX(STREETADDRESS_score,prim_range_score + prim_name_score + sec_range_score),prim_range_score + prim_name_score + sec_range_score) + company_name_prefix_score + zip_score + cnp_number_score + city_score + city_clean_score + company_sic_code1_score + company_phone_3_score + company_phone_3_ex_score + fname_preferred_score + name_suffix_score + cnp_lowv_score + st_score + source_score + cnp_btype_score + isContact_score + title_score + sele_flag_score + org_flag_score + ult_flag_score + fallback_value_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':parent_proxid',
  n = 1 => ':sele_proxid',
  n = 2 => ':org_proxid',
  n = 3 => ':ultimate_proxid',
  n = 4 => ':source_record_id',
  n = 5 => ':company_url',
  n = 6 => ':contact_ssn',
  n = 7 => ':contact_email',
  n = 8 => ':company_name:*',
  n = 31 => ':cnp_name:*',
  n = 53 => ':company_fein:*',
  n = 74 => ':contact_did:*',
  n = 94 => ':company_phone_7:*',
  n = 112 => ':company_name_prefix:prim_name',
  n = 113 => ':company_name_prefix:zip',
  n = 114 => ':company_name_prefix:cnp_number',
  n = 115 => ':company_name_prefix:prim_range',
  n = 116 => ':company_name_prefix:sec_range',
  n = 117 => ':company_name_prefix:city:*',
  n = 129 => ':company_name_prefix:city_clean:*',
  n = 140 => ':company_name_prefix:company_sic_code1:*',
  n = 149 => ':company_name_prefix:lname:*',
  n = 157 => ':company_name_prefix:company_phone_3:*',
  n = 164 => ':company_name_prefix:company_phone_3_ex:*',
  n = 170 => ':company_name_prefix:fname_preferred:*',
  n = 175 => ':company_name_prefix:mname:*',
  n = 179 => ':company_name_prefix:fname:*',
  n = 182 => ':company_name_prefix:name_suffix:*',
  n = 184 => ':prim_name:zip',
  n = 185 => ':prim_name:cnp_number',
  n = 186 => ':prim_name:prim_range',
  n = 187 => ':prim_name:sec_range',
  n = 188 => ':prim_name:city:*',
  n = 200 => ':prim_name:city_clean:*',
  n = 211 => ':prim_name:company_sic_code1:*',
  n = 220 => ':prim_name:lname:*',
  n = 228 => ':prim_name:company_phone_3:*',
  n = 235 => ':prim_name:company_phone_3_ex:*',
  n = 241 => ':prim_name:fname_preferred:*',
  n = 246 => ':prim_name:mname:*',
  n = 250 => ':prim_name:fname:*',
  n = 253 => ':prim_name:name_suffix:*',
  n = 255 => ':zip:cnp_number',
  n = 256 => ':zip:prim_range',
  n = 257 => ':zip:sec_range',
  n = 258 => ':zip:city:*',
  n = 270 => ':zip:city_clean:*',
  n = 281 => ':zip:company_sic_code1:*',
  n = 290 => ':zip:lname:*',
  n = 298 => ':zip:company_phone_3:*',
  n = 305 => ':zip:company_phone_3_ex:*',
  n = 311 => ':zip:fname_preferred:*',
  n = 316 => ':zip:mname:*',
  n = 320 => ':zip:fname:*',
  n = 323 => ':zip:name_suffix:*',
  n = 325 => ':cnp_number:prim_range',
  n = 326 => ':cnp_number:sec_range:*',
  n = 339 => ':cnp_number:city:*',
  n = 350 => ':cnp_number:city_clean:*',
  n = 360 => ':cnp_number:company_sic_code1:*',
  n = 369 => ':cnp_number:lname:*',
  n = 377 => ':cnp_number:company_phone_3:*',
  n = 384 => ':cnp_number:company_phone_3_ex:*',
  n = 390 => ':cnp_number:fname_preferred:*',
  n = 395 => ':cnp_number:mname:*',
  n = 399 => ':cnp_number:fname:*',
  n = 402 => ':cnp_number:name_suffix:*',
  n = 404 => ':prim_range:sec_range:*',
  n = 417 => ':prim_range:city:*',
  n = 428 => ':prim_range:city_clean:*',
  n = 438 => ':prim_range:company_sic_code1:*',
  n = 447 => ':prim_range:lname:*',
  n = 455 => ':prim_range:company_phone_3:*',
  n = 462 => ':prim_range:company_phone_3_ex:*',
  n = 468 => ':prim_range:fname_preferred:*',
  n = 473 => ':prim_range:mname:*',
  n = 477 => ':prim_range:fname:*',
  n = 480 => ':prim_range:name_suffix:*',
  n = 482 => ':sec_range:city:*',
  n = 493 => ':sec_range:city_clean:*',
  n = 503 => ':sec_range:company_sic_code1:*',
  n = 512 => ':sec_range:lname:*',
  n = 520 => ':sec_range:company_phone_3:*',
  n = 527 => ':sec_range:company_phone_3_ex:*',
  n = 533 => ':sec_range:fname_preferred:*',
  n = 538 => ':sec_range:mname:*',
  n = 542 => ':sec_range:fname:name_suffix',
  n = 543 => ':sec_range:fname:cnp_lowv:*',
  n = 545 => ':sec_range:fname:st:source',
  n = 546 => ':sec_range:name_suffix:cnp_lowv:*',
  n = 548 => ':sec_range:name_suffix:st:source',
  n = 549 => ':city:city_clean:*',
  n = 559 => ':city:company_sic_code1:*',
  n = 568 => ':city:lname:*',
  n = 576 => ':city:company_phone_3:company_phone_3_ex',
  n = 577 => ':city:company_phone_3:fname_preferred',
  n = 578 => ':city:company_phone_3:mname',
  n = 579 => ':city:company_phone_3:fname',
  n = 580 => ':city:company_phone_3:name_suffix',
  n = 581 => ':city:company_phone_3:cnp_lowv:*',
  n = 583 => ':city:company_phone_3:st:source',
  n = 584 => ':city:company_phone_3_ex:fname_preferred',
  n = 585 => ':city:company_phone_3_ex:mname',
  n = 586 => ':city:company_phone_3_ex:fname',
  n = 587 => ':city:company_phone_3_ex:name_suffix',
  n = 588 => ':city:company_phone_3_ex:cnp_lowv:*',
  n = 590 => ':city:company_phone_3_ex:st:source',
  n = 591 => ':city:fname_preferred:mname',
  n = 592 => ':city:fname_preferred:fname',
  n = 593 => ':city:fname_preferred:name_suffix',
  n = 594 => ':city:fname_preferred:cnp_lowv:*',
  n = 596 => ':city:fname_preferred:st:source',
  n = 597 => ':city:mname:fname',
  n = 598 => ':city:mname:name_suffix',
  n = 599 => ':city:mname:cnp_lowv:*',
  n = 601 => ':city:mname:st:source',
  n = 602 => ':city:fname:name_suffix',
  n = 603 => ':city:fname:cnp_lowv:st',
  n = 604 => ':city:name_suffix:cnp_lowv:st',
  n = 605 => ':city_clean:company_sic_code1:*',
  n = 614 => ':city_clean:lname:*',
  n = 622 => ':city_clean:company_phone_3:company_phone_3_ex',
  n = 623 => ':city_clean:company_phone_3:fname_preferred',
  n = 624 => ':city_clean:company_phone_3:mname',
  n = 625 => ':city_clean:company_phone_3:fname',
  n = 626 => ':city_clean:company_phone_3:name_suffix',
  n = 627 => ':city_clean:company_phone_3:cnp_lowv:*',
  n = 629 => ':city_clean:company_phone_3:st:source',
  n = 630 => ':city_clean:company_phone_3_ex:fname_preferred',
  n = 631 => ':city_clean:company_phone_3_ex:mname',
  n = 632 => ':city_clean:company_phone_3_ex:fname',
  n = 633 => ':city_clean:company_phone_3_ex:name_suffix',
  n = 634 => ':city_clean:company_phone_3_ex:cnp_lowv:*',
  n = 636 => ':city_clean:company_phone_3_ex:st:source',
  n = 637 => ':city_clean:fname_preferred:mname',
  n = 638 => ':city_clean:fname_preferred:fname',
  n = 639 => ':city_clean:fname_preferred:name_suffix',
  n = 640 => ':city_clean:fname_preferred:cnp_lowv:*',
  n = 642 => ':city_clean:fname_preferred:st:source',
  n = 643 => ':city_clean:mname:fname',
  n = 644 => ':city_clean:mname:name_suffix',
  n = 645 => ':city_clean:mname:cnp_lowv:*',
  n = 647 => ':city_clean:mname:st:source',
  n = 648 => ':city_clean:fname:name_suffix',
  n = 649 => ':city_clean:fname:cnp_lowv:st',
  n = 650 => ':city_clean:name_suffix:cnp_lowv:st',
  n = 651 => ':company_sic_code1:lname:company_phone_3',
  n = 652 => ':company_sic_code1:lname:company_phone_3_ex',
  n = 653 => ':company_sic_code1:lname:fname_preferred',
  n = 654 => ':company_sic_code1:lname:mname',
  n = 655 => ':company_sic_code1:lname:fname',
  n = 656 => ':company_sic_code1:lname:name_suffix',
  n = 657 => ':company_sic_code1:lname:cnp_lowv:*',
  n = 659 => ':company_sic_code1:lname:st:source',
  n = 660 => ':company_sic_code1:company_phone_3:company_phone_3_ex',
  n = 661 => ':company_sic_code1:company_phone_3:fname_preferred',
  n = 662 => ':company_sic_code1:company_phone_3:mname',
  n = 663 => ':company_sic_code1:company_phone_3:fname',
  n = 664 => ':company_sic_code1:company_phone_3:name_suffix',
  n = 665 => ':company_sic_code1:company_phone_3:cnp_lowv:st',
  n = 666 => ':company_sic_code1:company_phone_3_ex:fname_preferred',
  n = 667 => ':company_sic_code1:company_phone_3_ex:mname',
  n = 668 => ':company_sic_code1:company_phone_3_ex:fname',
  n = 669 => ':company_sic_code1:company_phone_3_ex:name_suffix',
  n = 670 => ':company_sic_code1:company_phone_3_ex:cnp_lowv:st',
  n = 671 => ':company_sic_code1:fname_preferred:mname',
  n = 672 => ':company_sic_code1:fname_preferred:fname',
  n = 673 => ':company_sic_code1:fname_preferred:name_suffix',
  n = 674 => ':company_sic_code1:fname_preferred:cnp_lowv:st',
  n = 675 => ':company_sic_code1:mname:fname',
  n = 676 => ':company_sic_code1:mname:name_suffix',
  n = 677 => ':company_sic_code1:mname:cnp_lowv:st',
  n = 678 => ':company_sic_code1:fname:name_suffix',
  n = 679 => ':company_sic_code1:fname:cnp_lowv:st',
  n = 680 => ':company_sic_code1:name_suffix:cnp_lowv:st',
  n = 681 => ':lname:company_phone_3:company_phone_3_ex',
  n = 682 => ':lname:company_phone_3:fname_preferred',
  n = 683 => ':lname:company_phone_3:mname',
  n = 684 => ':lname:company_phone_3:fname',
  n = 685 => ':lname:company_phone_3:name_suffix',
  n = 686 => ':lname:company_phone_3:cnp_lowv:st',
  n = 687 => ':lname:company_phone_3_ex:fname_preferred',
  n = 688 => ':lname:company_phone_3_ex:mname',
  n = 689 => ':lname:company_phone_3_ex:fname',
  n = 690 => ':lname:company_phone_3_ex:name_suffix',
  n = 691 => ':lname:company_phone_3_ex:cnp_lowv:st',
  n = 692 => ':lname:fname_preferred:mname',
  n = 693 => ':lname:fname_preferred:fname',
  n = 694 => ':lname:fname_preferred:name_suffix',
  n = 695 => ':lname:fname_preferred:cnp_lowv:st',
  n = 696 => ':lname:mname:fname',
  n = 697 => ':lname:mname:name_suffix',
  n = 698 => ':lname:mname:cnp_lowv:st',
  n = 699 => ':lname:fname:name_suffix',
  n = 700 => ':lname:fname:cnp_lowv:st',
  n = 701 => ':lname:name_suffix:cnp_lowv:st',
  n = 702 => ':company_phone_3:company_phone_3_ex:fname_preferred',
  n = 703 => ':company_phone_3:company_phone_3_ex:mname',
  n = 704 => ':company_phone_3:company_phone_3_ex:fname',
  n = 705 => ':company_phone_3:company_phone_3_ex:name_suffix',
  n = 706 => ':company_phone_3:company_phone_3_ex:cnp_lowv:st',
  n = 707 => ':company_phone_3:fname_preferred:mname',
  n = 708 => ':company_phone_3:fname_preferred:fname',
  n = 709 => ':company_phone_3:fname_preferred:name_suffix',
  n = 710 => ':company_phone_3:fname_preferred:cnp_lowv:st',
  n = 711 => ':company_phone_3:mname:fname',
  n = 712 => ':company_phone_3:mname:name_suffix',
  n = 713 => ':company_phone_3:mname:cnp_lowv:st',
  n = 714 => ':company_phone_3:fname:name_suffix:*',
  n = 717 => ':company_phone_3:fname:cnp_lowv:st',
  n = 718 => ':company_phone_3:name_suffix:cnp_lowv:st',
  n = 719 => ':company_phone_3_ex:fname_preferred:mname',
  n = 720 => ':company_phone_3_ex:fname_preferred:fname',
  n = 721 => ':company_phone_3_ex:fname_preferred:name_suffix',
  n = 722 => ':company_phone_3_ex:fname_preferred:cnp_lowv:st',
  n = 723 => ':company_phone_3_ex:mname:fname',
  n = 724 => ':company_phone_3_ex:mname:name_suffix',
  n = 725 => ':company_phone_3_ex:mname:cnp_lowv:st',
  n = 726 => ':company_phone_3_ex:fname:name_suffix:*',
  n = 729 => ':company_phone_3_ex:fname:cnp_lowv:st',
  n = 730 => ':company_phone_3_ex:name_suffix:cnp_lowv:st',
  n = 731 => ':fname_preferred:mname:fname',
  n = 732 => ':fname_preferred:mname:name_suffix',
  n = 733 => ':fname_preferred:mname:cnp_lowv:st',
  n = 734 => ':fname_preferred:fname:name_suffix:*',
  n = 737 => ':fname_preferred:fname:cnp_lowv:st',
  n = 738 => ':fname_preferred:name_suffix:cnp_lowv:st',
  n = 739 => ':mname:fname:name_suffix:*',
  n = 742 => ':mname:fname:cnp_lowv:st',
  n = 743 => ':mname:name_suffix:cnp_lowv:st',
  n = 744 => ':fname:name_suffix:cnp_lowv:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 745 join conditions of which 514 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:parent_proxid(28)
 
dn0 := hfile(~parent_proxid_isnull);
dn0_deduped := dn0(parent_proxid_weight100>=2600); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.parent_proxid = RIGHT.parent_proxid
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,0),HINT(unsorted_output),
    ATMOST(LEFT.parent_proxid = RIGHT.parent_proxid,10000),HASH);
 
//Fixed fields ->:sele_proxid(28)
 
dn1 := hfile(~sele_proxid_isnull);
dn1_deduped := dn1(sele_proxid_weight100>=2600); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sele_proxid = RIGHT.sele_proxid
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,1),HINT(unsorted_output),
    ATMOST(LEFT.sele_proxid = RIGHT.sele_proxid,10000),HASH);
 
//Fixed fields ->:org_proxid(28)
 
dn2 := hfile(~org_proxid_isnull);
dn2_deduped := dn2(org_proxid_weight100>=2600); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.org_proxid = RIGHT.org_proxid
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,2),HINT(unsorted_output),
    ATMOST(LEFT.org_proxid = RIGHT.org_proxid,10000),HASH);
 
//Fixed fields ->:ultimate_proxid(28)
 
dn3 := hfile(~ultimate_proxid_isnull);
dn3_deduped := dn3(ultimate_proxid_weight100>=2600); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.ultimate_proxid = RIGHT.ultimate_proxid
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,3),HINT(unsorted_output),
    ATMOST(LEFT.ultimate_proxid = RIGHT.ultimate_proxid,10000),HASH);
 
//Fixed fields ->:source_record_id(27)
 
dn4 := hfile(~source_record_id_isnull);
dn4_deduped := dn4(source_record_id_weight100>=2600); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.source_record_id = RIGHT.source_record_id
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,4),HINT(unsorted_output),
    ATMOST(LEFT.source_record_id = RIGHT.source_record_id,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT33.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::proxid::BizLinkFull::mj::0',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_url(27)
 
dn5 := hfile(~company_url_isnull);
dn5_deduped := dn5(company_url_weight100>=2600); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_url = RIGHT.company_url
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,5),HINT(unsorted_output),
    ATMOST(LEFT.company_url = RIGHT.company_url,10000),HASH);
 
//Fixed fields ->:contact_ssn(27)
 
dn6 := hfile(~contact_ssn_isnull);
dn6_deduped := dn6(contact_ssn_weight100>=2600); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.contact_ssn = RIGHT.contact_ssn
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,6),HINT(unsorted_output),
    ATMOST(LEFT.contact_ssn = RIGHT.contact_ssn,10000),HASH);
 
//Fixed fields ->:contact_email(27)
 
dn7 := hfile(~contact_email_isnull);
dn7_deduped := dn7(contact_email_weight100>=2600); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.contact_email = RIGHT.contact_email
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,7),HINT(unsorted_output),
    ATMOST(LEFT.contact_email = RIGHT.contact_email,10000),HASH);
 
//First 1 fields shared with following 22 joins - optimization performed
//Fixed fields ->:company_name(25):cnp_name(25) also :company_name(25):company_fein(25) also :company_name(25):contact_did(25) also :company_name(25):company_phone_7(23) also :company_name(25):company_name_prefix(14) also :company_name(25):prim_name(14) also :company_name(25):zip(14) also :company_name(25):cnp_number(13) also :company_name(25):prim_range(13) also :company_name(25):sec_range(12) also :company_name(25):city(11) also :company_name(25):city_clean(11) also :company_name(25):company_sic_code1(10) also :company_name(25):lname(10) also :company_name(25):company_phone_3(9) also :company_name(25):company_phone_3_ex(9) also :company_name(25):fname_preferred(9) also :company_name(25):mname(9) also :company_name(25):fname(8) also :company_name(25):name_suffix(8) also :company_name(25):cnp_lowv(5) also :company_name(25):st(5) also :company_name(25):source(4)
 
dn8 := hfile(~company_name_isnull);
dn8_deduped := dn8(company_name_weight100>=2200); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name = RIGHT.company_name
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_name = RIGHT.cnp_name AND ~LEFT.cnp_name_isnull
    OR    LEFT.company_fein = RIGHT.company_fein AND ~LEFT.company_fein_isnull
    OR    LEFT.contact_did = RIGHT.contact_did AND ~LEFT.contact_did_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
    OR    LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
    OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
    OR    LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
    OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
    OR    LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,8),HINT(unsorted_output),
    ATMOST(LEFT.company_name = RIGHT.company_name,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8;
SALT33.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : PERSIST('~temp::proxid::BizLinkFull::mj::1',EXPIRE(Config_BIP.PersistExpire));
 
//First 1 fields shared with following 21 joins - optimization performed
//Fixed fields ->:cnp_name(25):company_fein(25) also :cnp_name(25):contact_did(25) also :cnp_name(25):company_phone_7(23) also :cnp_name(25):company_name_prefix(14) also :cnp_name(25):prim_name(14) also :cnp_name(25):zip(14) also :cnp_name(25):cnp_number(13) also :cnp_name(25):prim_range(13) also :cnp_name(25):sec_range(12) also :cnp_name(25):city(11) also :cnp_name(25):city_clean(11) also :cnp_name(25):company_sic_code1(10) also :cnp_name(25):lname(10) also :cnp_name(25):company_phone_3(9) also :cnp_name(25):company_phone_3_ex(9) also :cnp_name(25):fname_preferred(9) also :cnp_name(25):mname(9) also :cnp_name(25):fname(8) also :cnp_name(25):name_suffix(8) also :cnp_name(25):cnp_lowv(5) also :cnp_name(25):st(5) also :cnp_name(25):source(4)
 
dn31 := hfile(~cnp_name_isnull);
dn31_deduped := dn31(cnp_name_weight100>=2200); // Use specificity to flag high-dup counts
mj31 := JOIN( dn31_deduped, dn31_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_name = RIGHT.cnp_name
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_fein = RIGHT.company_fein AND ~LEFT.company_fein_isnull
    OR    LEFT.contact_did = RIGHT.contact_did AND ~LEFT.contact_did_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
    OR    LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
    OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
    OR    LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
    OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
    OR    LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,31),HINT(unsorted_output),
    ATMOST(LEFT.cnp_name = RIGHT.cnp_name,10000),HASH);
mjs2_t := mj31;
SALT33.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : PERSIST('~temp::proxid::BizLinkFull::mj::2',EXPIRE(Config_BIP.PersistExpire));
 
//First 1 fields shared with following 20 joins - optimization performed
//Fixed fields ->:company_fein(25):contact_did(25) also :company_fein(25):company_phone_7(23) also :company_fein(25):company_name_prefix(14) also :company_fein(25):prim_name(14) also :company_fein(25):zip(14) also :company_fein(25):cnp_number(13) also :company_fein(25):prim_range(13) also :company_fein(25):sec_range(12) also :company_fein(25):city(11) also :company_fein(25):city_clean(11) also :company_fein(25):company_sic_code1(10) also :company_fein(25):lname(10) also :company_fein(25):company_phone_3(9) also :company_fein(25):company_phone_3_ex(9) also :company_fein(25):fname_preferred(9) also :company_fein(25):mname(9) also :company_fein(25):fname(8) also :company_fein(25):name_suffix(8) also :company_fein(25):cnp_lowv(5) also :company_fein(25):st(5) also :company_fein(25):source(4)
 
dn53 := hfile(~company_fein_isnull);
dn53_deduped := dn53(company_fein_weight100>=2200); // Use specificity to flag high-dup counts
mj53 := JOIN( dn53_deduped, dn53_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_fein = RIGHT.company_fein
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.contact_did = RIGHT.contact_did AND ~LEFT.contact_did_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
    OR    LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
    OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
    OR    LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
    OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
    OR    LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,53),HINT(unsorted_output),
    ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
mjs3_t := mj53;
SALT33.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : PERSIST('~temp::proxid::BizLinkFull::mj::3',EXPIRE(Config_BIP.PersistExpire));
 
//First 1 fields shared with following 19 joins - optimization performed
//Fixed fields ->:contact_did(25):company_phone_7(23) also :contact_did(25):company_name_prefix(14) also :contact_did(25):prim_name(14) also :contact_did(25):zip(14) also :contact_did(25):cnp_number(13) also :contact_did(25):prim_range(13) also :contact_did(25):sec_range(12) also :contact_did(25):city(11) also :contact_did(25):city_clean(11) also :contact_did(25):company_sic_code1(10) also :contact_did(25):lname(10) also :contact_did(25):company_phone_3(9) also :contact_did(25):company_phone_3_ex(9) also :contact_did(25):fname_preferred(9) also :contact_did(25):mname(9) also :contact_did(25):fname(8) also :contact_did(25):name_suffix(8) also :contact_did(25):cnp_lowv(5) also :contact_did(25):st(5) also :contact_did(25):source(4)
 
dn74 := hfile(~contact_did_isnull);
dn74_deduped := dn74(contact_did_weight100>=2200); // Use specificity to flag high-dup counts
mj74 := JOIN( dn74_deduped, dn74_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.contact_did = RIGHT.contact_did
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
    OR    LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
    OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
    OR    LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
    OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
    OR    LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,74),HINT(unsorted_output),
    ATMOST(LEFT.contact_did = RIGHT.contact_did,10000),HASH);
mjs4_t := mj74;
SALT33.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : PERSIST('~temp::proxid::BizLinkFull::mj::4',EXPIRE(Config_BIP.PersistExpire));
 
//First 1 fields shared with following 17 joins - optimization performed
//Fixed fields ->:company_phone_7(23):company_name_prefix(14) also :company_phone_7(23):prim_name(14) also :company_phone_7(23):zip(14) also :company_phone_7(23):cnp_number(13) also :company_phone_7(23):prim_range(13) also :company_phone_7(23):sec_range(12) also :company_phone_7(23):city(11) also :company_phone_7(23):city_clean(11) also :company_phone_7(23):company_sic_code1(10) also :company_phone_7(23):lname(10) also :company_phone_7(23):company_phone_3(9) also :company_phone_7(23):company_phone_3_ex(9) also :company_phone_7(23):fname_preferred(9) also :company_phone_7(23):mname(9) also :company_phone_7(23):fname(8) also :company_phone_7(23):name_suffix(8) also :company_phone_7(23):cnp_lowv(5) also :company_phone_7(23):st(5)
 
dn94 := hfile(~company_phone_7_isnull);
dn94_deduped := dn94(company_phone_7_weight100>=2200); // Use specificity to flag high-dup counts
mj94 := JOIN( dn94_deduped, dn94_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_7 = RIGHT.company_phone_7
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
    OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
    OR    LEFT.cnp_number = RIGHT.cnp_number AND ~LEFT.cnp_number_isnull
    OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
    OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
    OR    LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,94),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_7 = RIGHT.company_phone_7,10000),HASH);
mjs5_t := mj94;
SALT33.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : PERSIST('~temp::proxid::BizLinkFull::mj::5',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_name_prefix(14):prim_name(14)
 
dn112 := hfile(~company_name_prefix_isnull AND ~prim_name_isnull);
dn112_deduped := dn112(company_name_prefix_weight100 + prim_name_weight100>=2600); // Use specificity to flag high-dup counts
mj112 := JOIN( dn112_deduped, dn112_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.prim_name = RIGHT.prim_name
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,112),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.prim_name = RIGHT.prim_name,10000),HASH);
 
//Fixed fields ->:company_name_prefix(14):zip(14)
 
dn113 := hfile(~company_name_prefix_isnull AND ~zip_isnull);
dn113_deduped := dn113(company_name_prefix_weight100 + zip_weight100>=2600); // Use specificity to flag high-dup counts
mj113 := JOIN( dn113_deduped, dn113_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.zip = RIGHT.zip
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,113),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.zip = RIGHT.zip,10000),HASH);
 
//Fixed fields ->:company_name_prefix(14):cnp_number(13)
 
dn114 := hfile(~company_name_prefix_isnull AND ~cnp_number_isnull);
dn114_deduped := dn114(company_name_prefix_weight100 + cnp_number_weight100>=2600); // Use specificity to flag high-dup counts
mj114 := JOIN( dn114_deduped, dn114_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,114),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.cnp_number = RIGHT.cnp_number,10000),HASH);
 
//Fixed fields ->:company_name_prefix(14):prim_range(13)
 
dn115 := hfile(~company_name_prefix_isnull AND ~prim_range_isnull);
dn115_deduped := dn115(company_name_prefix_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj115 := JOIN( dn115_deduped, dn115_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.prim_range = RIGHT.prim_range
    ,trans(LEFT,RIGHT,115),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
 
//Fixed fields ->:company_name_prefix(14):sec_range(12)
 
dn116 := hfile(~company_name_prefix_isnull AND ~sec_range_isnull);
dn116_deduped := dn116(company_name_prefix_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj116 := JOIN( dn116_deduped, dn116_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.sec_range = RIGHT.sec_range
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,116),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs6_t := mj112+mj113+mj114+mj115+mj116;
SALT33.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : PERSIST('~temp::proxid::BizLinkFull::mj::6',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 11 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):city(11):city_clean(11) also :company_name_prefix(14):city(11):company_sic_code1(10) also :company_name_prefix(14):city(11):lname(10) also :company_name_prefix(14):city(11):company_phone_3(9) also :company_name_prefix(14):city(11):company_phone_3_ex(9) also :company_name_prefix(14):city(11):fname_preferred(9) also :company_name_prefix(14):city(11):mname(9) also :company_name_prefix(14):city(11):fname(8) also :company_name_prefix(14):city(11):name_suffix(8) also :company_name_prefix(14):city(11):cnp_lowv(5) also :company_name_prefix(14):city(11):st(5) also :company_name_prefix(14):city(11):source(4)
 
dn117 := hfile(~company_name_prefix_isnull AND ~city_isnull);
dn117_deduped := dn117(company_name_prefix_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj117 := JOIN( dn117_deduped, dn117_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,117),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs7_t := mj117;
SALT33.mac_select_best_matches(mjs7_t,rcid1,rcid2,o7);
mjs7 := o7 : PERSIST('~temp::proxid::BizLinkFull::mj::7',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):city_clean(11):company_sic_code1(10) also :company_name_prefix(14):city_clean(11):lname(10) also :company_name_prefix(14):city_clean(11):company_phone_3(9) also :company_name_prefix(14):city_clean(11):company_phone_3_ex(9) also :company_name_prefix(14):city_clean(11):fname_preferred(9) also :company_name_prefix(14):city_clean(11):mname(9) also :company_name_prefix(14):city_clean(11):fname(8) also :company_name_prefix(14):city_clean(11):name_suffix(8) also :company_name_prefix(14):city_clean(11):cnp_lowv(5) also :company_name_prefix(14):city_clean(11):st(5) also :company_name_prefix(14):city_clean(11):source(4)
 
dn129 := hfile(~company_name_prefix_isnull AND ~city_clean_isnull);
dn129_deduped := dn129(company_name_prefix_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj129 := JOIN( dn129_deduped, dn129_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,129),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs8_t := mj129;
SALT33.mac_select_best_matches(mjs8_t,rcid1,rcid2,o8);
mjs8 := o8 : PERSIST('~temp::proxid::BizLinkFull::mj::8',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):company_sic_code1(10):lname(10) also :company_name_prefix(14):company_sic_code1(10):company_phone_3(9) also :company_name_prefix(14):company_sic_code1(10):company_phone_3_ex(9) also :company_name_prefix(14):company_sic_code1(10):fname_preferred(9) also :company_name_prefix(14):company_sic_code1(10):mname(9) also :company_name_prefix(14):company_sic_code1(10):fname(8) also :company_name_prefix(14):company_sic_code1(10):name_suffix(8) also :company_name_prefix(14):company_sic_code1(10):cnp_lowv(5) also :company_name_prefix(14):company_sic_code1(10):st(5)
 
dn140 := hfile(~company_name_prefix_isnull AND ~company_sic_code1_isnull);
dn140_deduped := dn140(company_name_prefix_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj140 := JOIN( dn140_deduped, dn140_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,140),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs9_t := mj140;
SALT33.mac_select_best_matches(mjs9_t,rcid1,rcid2,o9);
mjs9 := o9 : PERSIST('~temp::proxid::BizLinkFull::mj::9',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):lname(10):company_phone_3(9) also :company_name_prefix(14):lname(10):company_phone_3_ex(9) also :company_name_prefix(14):lname(10):fname_preferred(9) also :company_name_prefix(14):lname(10):mname(9) also :company_name_prefix(14):lname(10):fname(8) also :company_name_prefix(14):lname(10):name_suffix(8) also :company_name_prefix(14):lname(10):cnp_lowv(5) also :company_name_prefix(14):lname(10):st(5)
 
dn149 := hfile(~company_name_prefix_isnull AND ~lname_isnull);
dn149_deduped := dn149(company_name_prefix_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj149 := JOIN( dn149_deduped, dn149_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,149),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs10_t := mj149;
SALT33.mac_select_best_matches(mjs10_t,rcid1,rcid2,o10);
mjs10 := o10 : PERSIST('~temp::proxid::BizLinkFull::mj::10',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):company_phone_3(9):company_phone_3_ex(9) also :company_name_prefix(14):company_phone_3(9):fname_preferred(9) also :company_name_prefix(14):company_phone_3(9):mname(9) also :company_name_prefix(14):company_phone_3(9):fname(8) also :company_name_prefix(14):company_phone_3(9):name_suffix(8) also :company_name_prefix(14):company_phone_3(9):cnp_lowv(5) also :company_name_prefix(14):company_phone_3(9):st(5)
 
dn157 := hfile(~company_name_prefix_isnull AND ~company_phone_3_isnull);
dn157_deduped := dn157(company_name_prefix_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj157 := JOIN( dn157_deduped, dn157_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,157),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs11_t := mj157;
SALT33.mac_select_best_matches(mjs11_t,rcid1,rcid2,o11);
mjs11 := o11 : PERSIST('~temp::proxid::BizLinkFull::mj::11',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):company_phone_3_ex(9):fname_preferred(9) also :company_name_prefix(14):company_phone_3_ex(9):mname(9) also :company_name_prefix(14):company_phone_3_ex(9):fname(8) also :company_name_prefix(14):company_phone_3_ex(9):name_suffix(8) also :company_name_prefix(14):company_phone_3_ex(9):cnp_lowv(5) also :company_name_prefix(14):company_phone_3_ex(9):st(5)
 
dn164 := hfile(~company_name_prefix_isnull AND ~company_phone_3_ex_isnull);
dn164_deduped := dn164(company_name_prefix_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj164 := JOIN( dn164_deduped, dn164_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,164),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs12_t := mj164;
SALT33.mac_select_best_matches(mjs12_t,rcid1,rcid2,o12);
mjs12 := o12 : PERSIST('~temp::proxid::BizLinkFull::mj::12',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):fname_preferred(9):mname(9) also :company_name_prefix(14):fname_preferred(9):fname(8) also :company_name_prefix(14):fname_preferred(9):name_suffix(8) also :company_name_prefix(14):fname_preferred(9):cnp_lowv(5) also :company_name_prefix(14):fname_preferred(9):st(5)
 
dn170 := hfile(~company_name_prefix_isnull AND ~fname_preferred_isnull);
dn170_deduped := dn170(company_name_prefix_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj170 := JOIN( dn170_deduped, dn170_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,170),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs13_t := mj170;
SALT33.mac_select_best_matches(mjs13_t,rcid1,rcid2,o13);
mjs13 := o13 : PERSIST('~temp::proxid::BizLinkFull::mj::13',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):mname(9):fname(8) also :company_name_prefix(14):mname(9):name_suffix(8) also :company_name_prefix(14):mname(9):cnp_lowv(5) also :company_name_prefix(14):mname(9):st(5)
 
dn175 := hfile(~company_name_prefix_isnull AND ~mname_isnull);
dn175_deduped := dn175(company_name_prefix_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj175 := JOIN( dn175_deduped, dn175_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,175),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):fname(8):name_suffix(8) also :company_name_prefix(14):fname(8):cnp_lowv(5) also :company_name_prefix(14):fname(8):st(5)
 
dn179 := hfile(~company_name_prefix_isnull AND ~fname_isnull);
dn179_deduped := dn179(company_name_prefix_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj179 := JOIN( dn179_deduped, dn179_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,179),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs14_t := mj175+mj179;
SALT33.mac_select_best_matches(mjs14_t,rcid1,rcid2,o14);
mjs14 := o14 : PERSIST('~temp::proxid::BizLinkFull::mj::14',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_name_prefix(14):name_suffix(8):cnp_lowv(5) also :company_name_prefix(14):name_suffix(8):st(5)
 
dn182 := hfile(~company_name_prefix_isnull AND ~name_suffix_isnull);
dn182_deduped := dn182(company_name_prefix_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj182 := JOIN( dn182_deduped, dn182_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_name_prefix = RIGHT.company_name_prefix
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,182),HINT(unsorted_output),
    ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:prim_name(14):zip(14)
 
dn184 := hfile(~prim_name_isnull AND ~zip_isnull);
dn184_deduped := dn184(prim_name_weight100 + zip_weight100>=2600); // Use specificity to flag high-dup counts
mj184 := JOIN( dn184_deduped, dn184_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.zip = RIGHT.zip
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,184),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.zip = RIGHT.zip,10000),HASH);
 
//Fixed fields ->:prim_name(14):cnp_number(13)
 
dn185 := hfile(~prim_name_isnull AND ~cnp_number_isnull);
dn185_deduped := dn185(prim_name_weight100 + cnp_number_weight100>=2600); // Use specificity to flag high-dup counts
mj185 := JOIN( dn185_deduped, dn185_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,185),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.cnp_number = RIGHT.cnp_number,10000),HASH);
 
//Fixed fields ->:prim_name(14):prim_range(13)
 
dn186 := hfile(~prim_name_isnull AND ~prim_range_isnull);
dn186_deduped := dn186(prim_name_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj186 := JOIN( dn186_deduped, dn186_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.prim_range = RIGHT.prim_range
    ,trans(LEFT,RIGHT,186),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
mjs15_t := mj182+mj184+mj185+mj186;
SALT33.mac_select_best_matches(mjs15_t,rcid1,rcid2,o15);
mjs15 := o15 : PERSIST('~temp::proxid::BizLinkFull::mj::15',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:prim_name(14):sec_range(12)
 
dn187 := hfile(~prim_name_isnull AND ~sec_range_isnull);
dn187_deduped := dn187(prim_name_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj187 := JOIN( dn187_deduped, dn187_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.sec_range = RIGHT.sec_range
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,187),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
 
//First 2 fields shared with following 11 joins - optimization performed
//Fixed fields ->:prim_name(14):city(11):city_clean(11) also :prim_name(14):city(11):company_sic_code1(10) also :prim_name(14):city(11):lname(10) also :prim_name(14):city(11):company_phone_3(9) also :prim_name(14):city(11):company_phone_3_ex(9) also :prim_name(14):city(11):fname_preferred(9) also :prim_name(14):city(11):mname(9) also :prim_name(14):city(11):fname(8) also :prim_name(14):city(11):name_suffix(8) also :prim_name(14):city(11):cnp_lowv(5) also :prim_name(14):city(11):st(5) also :prim_name(14):city(11):source(4)
 
dn188 := hfile(~prim_name_isnull AND ~city_isnull);
dn188_deduped := dn188(prim_name_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj188 := JOIN( dn188_deduped, dn188_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,188),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs16_t := mj187+mj188;
SALT33.mac_select_best_matches(mjs16_t,rcid1,rcid2,o16);
mjs16 := o16 : PERSIST('~temp::proxid::BizLinkFull::mj::16',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:prim_name(14):city_clean(11):company_sic_code1(10) also :prim_name(14):city_clean(11):lname(10) also :prim_name(14):city_clean(11):company_phone_3(9) also :prim_name(14):city_clean(11):company_phone_3_ex(9) also :prim_name(14):city_clean(11):fname_preferred(9) also :prim_name(14):city_clean(11):mname(9) also :prim_name(14):city_clean(11):fname(8) also :prim_name(14):city_clean(11):name_suffix(8) also :prim_name(14):city_clean(11):cnp_lowv(5) also :prim_name(14):city_clean(11):st(5) also :prim_name(14):city_clean(11):source(4)
 
dn200 := hfile(~prim_name_isnull AND ~city_clean_isnull);
dn200_deduped := dn200(prim_name_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj200 := JOIN( dn200_deduped, dn200_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,200),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs17_t := mj200;
SALT33.mac_select_best_matches(mjs17_t,rcid1,rcid2,o17);
mjs17 := o17 : PERSIST('~temp::proxid::BizLinkFull::mj::17',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:prim_name(14):company_sic_code1(10):lname(10) also :prim_name(14):company_sic_code1(10):company_phone_3(9) also :prim_name(14):company_sic_code1(10):company_phone_3_ex(9) also :prim_name(14):company_sic_code1(10):fname_preferred(9) also :prim_name(14):company_sic_code1(10):mname(9) also :prim_name(14):company_sic_code1(10):fname(8) also :prim_name(14):company_sic_code1(10):name_suffix(8) also :prim_name(14):company_sic_code1(10):cnp_lowv(5) also :prim_name(14):company_sic_code1(10):st(5)
 
dn211 := hfile(~prim_name_isnull AND ~company_sic_code1_isnull);
dn211_deduped := dn211(prim_name_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj211 := JOIN( dn211_deduped, dn211_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,211),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs18_t := mj211;
SALT33.mac_select_best_matches(mjs18_t,rcid1,rcid2,o18);
mjs18 := o18 : PERSIST('~temp::proxid::BizLinkFull::mj::18',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:prim_name(14):lname(10):company_phone_3(9) also :prim_name(14):lname(10):company_phone_3_ex(9) also :prim_name(14):lname(10):fname_preferred(9) also :prim_name(14):lname(10):mname(9) also :prim_name(14):lname(10):fname(8) also :prim_name(14):lname(10):name_suffix(8) also :prim_name(14):lname(10):cnp_lowv(5) also :prim_name(14):lname(10):st(5)
 
dn220 := hfile(~prim_name_isnull AND ~lname_isnull);
dn220_deduped := dn220(prim_name_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj220 := JOIN( dn220_deduped, dn220_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,220),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs19_t := mj220;
SALT33.mac_select_best_matches(mjs19_t,rcid1,rcid2,o19);
mjs19 := o19 : PERSIST('~temp::proxid::BizLinkFull::mj::19',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:prim_name(14):company_phone_3(9):company_phone_3_ex(9) also :prim_name(14):company_phone_3(9):fname_preferred(9) also :prim_name(14):company_phone_3(9):mname(9) also :prim_name(14):company_phone_3(9):fname(8) also :prim_name(14):company_phone_3(9):name_suffix(8) also :prim_name(14):company_phone_3(9):cnp_lowv(5) also :prim_name(14):company_phone_3(9):st(5)
 
dn228 := hfile(~prim_name_isnull AND ~company_phone_3_isnull);
dn228_deduped := dn228(prim_name_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj228 := JOIN( dn228_deduped, dn228_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,228),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs20_t := mj228;
SALT33.mac_select_best_matches(mjs20_t,rcid1,rcid2,o20);
mjs20 := o20 : PERSIST('~temp::proxid::BizLinkFull::mj::20',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_name(14):company_phone_3_ex(9):fname_preferred(9) also :prim_name(14):company_phone_3_ex(9):mname(9) also :prim_name(14):company_phone_3_ex(9):fname(8) also :prim_name(14):company_phone_3_ex(9):name_suffix(8) also :prim_name(14):company_phone_3_ex(9):cnp_lowv(5) also :prim_name(14):company_phone_3_ex(9):st(5)
 
dn235 := hfile(~prim_name_isnull AND ~company_phone_3_ex_isnull);
dn235_deduped := dn235(prim_name_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj235 := JOIN( dn235_deduped, dn235_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,235),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs21_t := mj235;
SALT33.mac_select_best_matches(mjs21_t,rcid1,rcid2,o21);
mjs21 := o21 : PERSIST('~temp::proxid::BizLinkFull::mj::21',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_name(14):fname_preferred(9):mname(9) also :prim_name(14):fname_preferred(9):fname(8) also :prim_name(14):fname_preferred(9):name_suffix(8) also :prim_name(14):fname_preferred(9):cnp_lowv(5) also :prim_name(14):fname_preferred(9):st(5)
 
dn241 := hfile(~prim_name_isnull AND ~fname_preferred_isnull);
dn241_deduped := dn241(prim_name_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj241 := JOIN( dn241_deduped, dn241_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,241),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs22_t := mj241;
SALT33.mac_select_best_matches(mjs22_t,rcid1,rcid2,o22);
mjs22 := o22 : PERSIST('~temp::proxid::BizLinkFull::mj::22',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_name(14):mname(9):fname(8) also :prim_name(14):mname(9):name_suffix(8) also :prim_name(14):mname(9):cnp_lowv(5) also :prim_name(14):mname(9):st(5)
 
dn246 := hfile(~prim_name_isnull AND ~mname_isnull);
dn246_deduped := dn246(prim_name_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj246 := JOIN( dn246_deduped, dn246_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,246),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_name(14):fname(8):name_suffix(8) also :prim_name(14):fname(8):cnp_lowv(5) also :prim_name(14):fname(8):st(5)
 
dn250 := hfile(~prim_name_isnull AND ~fname_isnull);
dn250_deduped := dn250(prim_name_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj250 := JOIN( dn250_deduped, dn250_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,250),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs23_t := mj246+mj250;
SALT33.mac_select_best_matches(mjs23_t,rcid1,rcid2,o23);
mjs23 := o23 : PERSIST('~temp::proxid::BizLinkFull::mj::23',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name(14):name_suffix(8):cnp_lowv(5) also :prim_name(14):name_suffix(8):st(5)
 
dn253 := hfile(~prim_name_isnull AND ~name_suffix_isnull);
dn253_deduped := dn253(prim_name_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj253 := JOIN( dn253_deduped, dn253_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,253),HINT(unsorted_output),
    ATMOST(LEFT.prim_name = RIGHT.prim_name
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:zip(14):cnp_number(13)
 
dn255 := hfile(~zip_isnull AND ~cnp_number_isnull);
dn255_deduped := dn255(zip_weight100 + cnp_number_weight100>=2600); // Use specificity to flag high-dup counts
mj255 := JOIN( dn255_deduped, dn255_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,255),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.cnp_number = RIGHT.cnp_number,10000),HASH);
 
//Fixed fields ->:zip(14):prim_range(13)
 
dn256 := hfile(~zip_isnull AND ~prim_range_isnull);
dn256_deduped := dn256(zip_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj256 := JOIN( dn256_deduped, dn256_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_range = RIGHT.prim_range
    ,trans(LEFT,RIGHT,256),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
 
//Fixed fields ->:zip(14):sec_range(12)
 
dn257 := hfile(~zip_isnull AND ~sec_range_isnull);
dn257_deduped := dn257(zip_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj257 := JOIN( dn257_deduped, dn257_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.sec_range = RIGHT.sec_range
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,257),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs24_t := mj253+mj255+mj256+mj257;
SALT33.mac_select_best_matches(mjs24_t,rcid1,rcid2,o24);
mjs24 := o24 : PERSIST('~temp::proxid::BizLinkFull::mj::24',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 11 joins - optimization performed
//Fixed fields ->:zip(14):city(11):city_clean(11) also :zip(14):city(11):company_sic_code1(10) also :zip(14):city(11):lname(10) also :zip(14):city(11):company_phone_3(9) also :zip(14):city(11):company_phone_3_ex(9) also :zip(14):city(11):fname_preferred(9) also :zip(14):city(11):mname(9) also :zip(14):city(11):fname(8) also :zip(14):city(11):name_suffix(8) also :zip(14):city(11):cnp_lowv(5) also :zip(14):city(11):st(5) also :zip(14):city(11):source(4)
 
dn258 := hfile(~zip_isnull AND ~city_isnull);
dn258_deduped := dn258(zip_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj258 := JOIN( dn258_deduped, dn258_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,258),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs25_t := mj258;
SALT33.mac_select_best_matches(mjs25_t,rcid1,rcid2,o25);
mjs25 := o25 : PERSIST('~temp::proxid::BizLinkFull::mj::25',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:zip(14):city_clean(11):company_sic_code1(10) also :zip(14):city_clean(11):lname(10) also :zip(14):city_clean(11):company_phone_3(9) also :zip(14):city_clean(11):company_phone_3_ex(9) also :zip(14):city_clean(11):fname_preferred(9) also :zip(14):city_clean(11):mname(9) also :zip(14):city_clean(11):fname(8) also :zip(14):city_clean(11):name_suffix(8) also :zip(14):city_clean(11):cnp_lowv(5) also :zip(14):city_clean(11):st(5) also :zip(14):city_clean(11):source(4)
 
dn270 := hfile(~zip_isnull AND ~city_clean_isnull);
dn270_deduped := dn270(zip_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj270 := JOIN( dn270_deduped, dn270_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,270),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs26_t := mj270;
SALT33.mac_select_best_matches(mjs26_t,rcid1,rcid2,o26);
mjs26 := o26 : PERSIST('~temp::proxid::BizLinkFull::mj::26',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:zip(14):company_sic_code1(10):lname(10) also :zip(14):company_sic_code1(10):company_phone_3(9) also :zip(14):company_sic_code1(10):company_phone_3_ex(9) also :zip(14):company_sic_code1(10):fname_preferred(9) also :zip(14):company_sic_code1(10):mname(9) also :zip(14):company_sic_code1(10):fname(8) also :zip(14):company_sic_code1(10):name_suffix(8) also :zip(14):company_sic_code1(10):cnp_lowv(5) also :zip(14):company_sic_code1(10):st(5)
 
dn281 := hfile(~zip_isnull AND ~company_sic_code1_isnull);
dn281_deduped := dn281(zip_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj281 := JOIN( dn281_deduped, dn281_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,281),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs27_t := mj281;
SALT33.mac_select_best_matches(mjs27_t,rcid1,rcid2,o27);
mjs27 := o27 : PERSIST('~temp::proxid::BizLinkFull::mj::27',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:zip(14):lname(10):company_phone_3(9) also :zip(14):lname(10):company_phone_3_ex(9) also :zip(14):lname(10):fname_preferred(9) also :zip(14):lname(10):mname(9) also :zip(14):lname(10):fname(8) also :zip(14):lname(10):name_suffix(8) also :zip(14):lname(10):cnp_lowv(5) also :zip(14):lname(10):st(5)
 
dn290 := hfile(~zip_isnull AND ~lname_isnull);
dn290_deduped := dn290(zip_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj290 := JOIN( dn290_deduped, dn290_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,290),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs28_t := mj290;
SALT33.mac_select_best_matches(mjs28_t,rcid1,rcid2,o28);
mjs28 := o28 : PERSIST('~temp::proxid::BizLinkFull::mj::28',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:zip(14):company_phone_3(9):company_phone_3_ex(9) also :zip(14):company_phone_3(9):fname_preferred(9) also :zip(14):company_phone_3(9):mname(9) also :zip(14):company_phone_3(9):fname(8) also :zip(14):company_phone_3(9):name_suffix(8) also :zip(14):company_phone_3(9):cnp_lowv(5) also :zip(14):company_phone_3(9):st(5)
 
dn298 := hfile(~zip_isnull AND ~company_phone_3_isnull);
dn298_deduped := dn298(zip_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj298 := JOIN( dn298_deduped, dn298_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,298),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs29_t := mj298;
SALT33.mac_select_best_matches(mjs29_t,rcid1,rcid2,o29);
mjs29 := o29 : PERSIST('~temp::proxid::BizLinkFull::mj::29',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:zip(14):company_phone_3_ex(9):fname_preferred(9) also :zip(14):company_phone_3_ex(9):mname(9) also :zip(14):company_phone_3_ex(9):fname(8) also :zip(14):company_phone_3_ex(9):name_suffix(8) also :zip(14):company_phone_3_ex(9):cnp_lowv(5) also :zip(14):company_phone_3_ex(9):st(5)
 
dn305 := hfile(~zip_isnull AND ~company_phone_3_ex_isnull);
dn305_deduped := dn305(zip_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj305 := JOIN( dn305_deduped, dn305_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,305),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs30_t := mj305;
SALT33.mac_select_best_matches(mjs30_t,rcid1,rcid2,o30);
mjs30 := o30 : PERSIST('~temp::proxid::BizLinkFull::mj::30',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:zip(14):fname_preferred(9):mname(9) also :zip(14):fname_preferred(9):fname(8) also :zip(14):fname_preferred(9):name_suffix(8) also :zip(14):fname_preferred(9):cnp_lowv(5) also :zip(14):fname_preferred(9):st(5)
 
dn311 := hfile(~zip_isnull AND ~fname_preferred_isnull);
dn311_deduped := dn311(zip_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj311 := JOIN( dn311_deduped, dn311_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,311),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs31_t := mj311;
SALT33.mac_select_best_matches(mjs31_t,rcid1,rcid2,o31);
mjs31 := o31 : PERSIST('~temp::proxid::BizLinkFull::mj::31',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip(14):mname(9):fname(8) also :zip(14):mname(9):name_suffix(8) also :zip(14):mname(9):cnp_lowv(5) also :zip(14):mname(9):st(5)
 
dn316 := hfile(~zip_isnull AND ~mname_isnull);
dn316_deduped := dn316(zip_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj316 := JOIN( dn316_deduped, dn316_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,316),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:zip(14):fname(8):name_suffix(8) also :zip(14):fname(8):cnp_lowv(5) also :zip(14):fname(8):st(5)
 
dn320 := hfile(~zip_isnull AND ~fname_isnull);
dn320_deduped := dn320(zip_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj320 := JOIN( dn320_deduped, dn320_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,320),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs32_t := mj316+mj320;
SALT33.mac_select_best_matches(mjs32_t,rcid1,rcid2,o32);
mjs32 := o32 : PERSIST('~temp::proxid::BizLinkFull::mj::32',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):name_suffix(8):cnp_lowv(5) also :zip(14):name_suffix(8):st(5)
 
dn323 := hfile(~zip_isnull AND ~name_suffix_isnull);
dn323_deduped := dn323(zip_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj323 := JOIN( dn323_deduped, dn323_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.zip = RIGHT.zip
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,323),HINT(unsorted_output),
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:cnp_number(13):prim_range(13)
 
dn325 := hfile(~cnp_number_isnull AND ~prim_range_isnull);
dn325_deduped := dn325(cnp_number_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj325 := JOIN( dn325_deduped, dn325_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.prim_range = RIGHT.prim_range
    ,trans(LEFT,RIGHT,325),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
 
//First 2 fields shared with following 12 joins - optimization performed
//Fixed fields ->:cnp_number(13):sec_range(12):city(11) also :cnp_number(13):sec_range(12):city_clean(11) also :cnp_number(13):sec_range(12):company_sic_code1(10) also :cnp_number(13):sec_range(12):lname(10) also :cnp_number(13):sec_range(12):company_phone_3(9) also :cnp_number(13):sec_range(12):company_phone_3_ex(9) also :cnp_number(13):sec_range(12):fname_preferred(9) also :cnp_number(13):sec_range(12):mname(9) also :cnp_number(13):sec_range(12):fname(8) also :cnp_number(13):sec_range(12):name_suffix(8) also :cnp_number(13):sec_range(12):cnp_lowv(5) also :cnp_number(13):sec_range(12):st(5) also :cnp_number(13):sec_range(12):source(4)
 
dn326 := hfile(~cnp_number_isnull AND ~sec_range_isnull);
dn326_deduped := dn326(cnp_number_weight100 + sec_range_weight100>=2200); // Use specificity to flag high-dup counts
mj326 := JOIN( dn326_deduped, dn326_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.sec_range = RIGHT.sec_range
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,326),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs33_t := mj323+mj325+mj326;
SALT33.mac_select_best_matches(mjs33_t,rcid1,rcid2,o33);
mjs33 := o33 : PERSIST('~temp::proxid::BizLinkFull::mj::33',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:cnp_number(13):city(11):city_clean(11) also :cnp_number(13):city(11):company_sic_code1(10) also :cnp_number(13):city(11):lname(10) also :cnp_number(13):city(11):company_phone_3(9) also :cnp_number(13):city(11):company_phone_3_ex(9) also :cnp_number(13):city(11):fname_preferred(9) also :cnp_number(13):city(11):mname(9) also :cnp_number(13):city(11):fname(8) also :cnp_number(13):city(11):name_suffix(8) also :cnp_number(13):city(11):cnp_lowv(5) also :cnp_number(13):city(11):st(5)
 
dn339 := hfile(~cnp_number_isnull AND ~city_isnull);
dn339_deduped := dn339(cnp_number_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj339 := JOIN( dn339_deduped, dn339_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,339),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs34_t := mj339;
SALT33.mac_select_best_matches(mjs34_t,rcid1,rcid2,o34);
mjs34 := o34 : PERSIST('~temp::proxid::BizLinkFull::mj::34',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:cnp_number(13):city_clean(11):company_sic_code1(10) also :cnp_number(13):city_clean(11):lname(10) also :cnp_number(13):city_clean(11):company_phone_3(9) also :cnp_number(13):city_clean(11):company_phone_3_ex(9) also :cnp_number(13):city_clean(11):fname_preferred(9) also :cnp_number(13):city_clean(11):mname(9) also :cnp_number(13):city_clean(11):fname(8) also :cnp_number(13):city_clean(11):name_suffix(8) also :cnp_number(13):city_clean(11):cnp_lowv(5) also :cnp_number(13):city_clean(11):st(5)
 
dn350 := hfile(~cnp_number_isnull AND ~city_clean_isnull);
dn350_deduped := dn350(cnp_number_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj350 := JOIN( dn350_deduped, dn350_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,350),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs35_t := mj350;
SALT33.mac_select_best_matches(mjs35_t,rcid1,rcid2,o35);
mjs35 := o35 : PERSIST('~temp::proxid::BizLinkFull::mj::35',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_sic_code1(10):lname(10) also :cnp_number(13):company_sic_code1(10):company_phone_3(9) also :cnp_number(13):company_sic_code1(10):company_phone_3_ex(9) also :cnp_number(13):company_sic_code1(10):fname_preferred(9) also :cnp_number(13):company_sic_code1(10):mname(9) also :cnp_number(13):company_sic_code1(10):fname(8) also :cnp_number(13):company_sic_code1(10):name_suffix(8) also :cnp_number(13):company_sic_code1(10):cnp_lowv(5) also :cnp_number(13):company_sic_code1(10):st(5)
 
dn360 := hfile(~cnp_number_isnull AND ~company_sic_code1_isnull);
dn360_deduped := dn360(cnp_number_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj360 := JOIN( dn360_deduped, dn360_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,360),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs36_t := mj360;
SALT33.mac_select_best_matches(mjs36_t,rcid1,rcid2,o36);
mjs36 := o36 : PERSIST('~temp::proxid::BizLinkFull::mj::36',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:cnp_number(13):lname(10):company_phone_3(9) also :cnp_number(13):lname(10):company_phone_3_ex(9) also :cnp_number(13):lname(10):fname_preferred(9) also :cnp_number(13):lname(10):mname(9) also :cnp_number(13):lname(10):fname(8) also :cnp_number(13):lname(10):name_suffix(8) also :cnp_number(13):lname(10):cnp_lowv(5) also :cnp_number(13):lname(10):st(5)
 
dn369 := hfile(~cnp_number_isnull AND ~lname_isnull);
dn369_deduped := dn369(cnp_number_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj369 := JOIN( dn369_deduped, dn369_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,369),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs37_t := mj369;
SALT33.mac_select_best_matches(mjs37_t,rcid1,rcid2,o37);
mjs37 := o37 : PERSIST('~temp::proxid::BizLinkFull::mj::37',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_phone_3(9):company_phone_3_ex(9) also :cnp_number(13):company_phone_3(9):fname_preferred(9) also :cnp_number(13):company_phone_3(9):mname(9) also :cnp_number(13):company_phone_3(9):fname(8) also :cnp_number(13):company_phone_3(9):name_suffix(8) also :cnp_number(13):company_phone_3(9):cnp_lowv(5) also :cnp_number(13):company_phone_3(9):st(5)
 
dn377 := hfile(~cnp_number_isnull AND ~company_phone_3_isnull);
dn377_deduped := dn377(cnp_number_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj377 := JOIN( dn377_deduped, dn377_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,377),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs38_t := mj377;
SALT33.mac_select_best_matches(mjs38_t,rcid1,rcid2,o38);
mjs38 := o38 : PERSIST('~temp::proxid::BizLinkFull::mj::38',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_phone_3_ex(9):fname_preferred(9) also :cnp_number(13):company_phone_3_ex(9):mname(9) also :cnp_number(13):company_phone_3_ex(9):fname(8) also :cnp_number(13):company_phone_3_ex(9):name_suffix(8) also :cnp_number(13):company_phone_3_ex(9):cnp_lowv(5) also :cnp_number(13):company_phone_3_ex(9):st(5)
 
dn384 := hfile(~cnp_number_isnull AND ~company_phone_3_ex_isnull);
dn384_deduped := dn384(cnp_number_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj384 := JOIN( dn384_deduped, dn384_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,384),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs39_t := mj384;
SALT33.mac_select_best_matches(mjs39_t,rcid1,rcid2,o39);
mjs39 := o39 : PERSIST('~temp::proxid::BizLinkFull::mj::39',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:cnp_number(13):fname_preferred(9):mname(9) also :cnp_number(13):fname_preferred(9):fname(8) also :cnp_number(13):fname_preferred(9):name_suffix(8) also :cnp_number(13):fname_preferred(9):cnp_lowv(5) also :cnp_number(13):fname_preferred(9):st(5)
 
dn390 := hfile(~cnp_number_isnull AND ~fname_preferred_isnull);
dn390_deduped := dn390(cnp_number_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj390 := JOIN( dn390_deduped, dn390_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,390),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs40_t := mj390;
SALT33.mac_select_best_matches(mjs40_t,rcid1,rcid2,o40);
mjs40 := o40 : PERSIST('~temp::proxid::BizLinkFull::mj::40',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:cnp_number(13):mname(9):fname(8) also :cnp_number(13):mname(9):name_suffix(8) also :cnp_number(13):mname(9):cnp_lowv(5) also :cnp_number(13):mname(9):st(5)
 
dn395 := hfile(~cnp_number_isnull AND ~mname_isnull);
dn395_deduped := dn395(cnp_number_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj395 := JOIN( dn395_deduped, dn395_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,395),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:cnp_number(13):fname(8):name_suffix(8) also :cnp_number(13):fname(8):cnp_lowv(5) also :cnp_number(13):fname(8):st(5)
 
dn399 := hfile(~cnp_number_isnull AND ~fname_isnull);
dn399_deduped := dn399(cnp_number_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj399 := JOIN( dn399_deduped, dn399_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,399),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs41_t := mj395+mj399;
SALT33.mac_select_best_matches(mjs41_t,rcid1,rcid2,o41);
mjs41 := o41 : PERSIST('~temp::proxid::BizLinkFull::mj::41',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:cnp_number(13):name_suffix(8):cnp_lowv(5) also :cnp_number(13):name_suffix(8):st(5)
 
dn402 := hfile(~cnp_number_isnull AND ~name_suffix_isnull);
dn402_deduped := dn402(cnp_number_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj402 := JOIN( dn402_deduped, dn402_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.cnp_number = RIGHT.cnp_number
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,402),HINT(unsorted_output),
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 2 fields shared with following 12 joins - optimization performed
//Fixed fields ->:prim_range(13):sec_range(12):city(11) also :prim_range(13):sec_range(12):city_clean(11) also :prim_range(13):sec_range(12):company_sic_code1(10) also :prim_range(13):sec_range(12):lname(10) also :prim_range(13):sec_range(12):company_phone_3(9) also :prim_range(13):sec_range(12):company_phone_3_ex(9) also :prim_range(13):sec_range(12):fname_preferred(9) also :prim_range(13):sec_range(12):mname(9) also :prim_range(13):sec_range(12):fname(8) also :prim_range(13):sec_range(12):name_suffix(8) also :prim_range(13):sec_range(12):cnp_lowv(5) also :prim_range(13):sec_range(12):st(5) also :prim_range(13):sec_range(12):source(4)
 
dn404 := hfile(~prim_range_isnull AND ~sec_range_isnull);
dn404_deduped := dn404(prim_range_weight100 + sec_range_weight100>=2200); // Use specificity to flag high-dup counts
mj404 := JOIN( dn404_deduped, dn404_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.sec_range = RIGHT.sec_range
    AND (
          LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,404),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs42_t := mj402+mj404;
SALT33.mac_select_best_matches(mjs42_t,rcid1,rcid2,o42);
mjs42 := o42 : PERSIST('~temp::proxid::BizLinkFull::mj::42',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:prim_range(13):city(11):city_clean(11) also :prim_range(13):city(11):company_sic_code1(10) also :prim_range(13):city(11):lname(10) also :prim_range(13):city(11):company_phone_3(9) also :prim_range(13):city(11):company_phone_3_ex(9) also :prim_range(13):city(11):fname_preferred(9) also :prim_range(13):city(11):mname(9) also :prim_range(13):city(11):fname(8) also :prim_range(13):city(11):name_suffix(8) also :prim_range(13):city(11):cnp_lowv(5) also :prim_range(13):city(11):st(5)
 
dn417 := hfile(~prim_range_isnull AND ~city_isnull);
dn417_deduped := dn417(prim_range_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj417 := JOIN( dn417_deduped, dn417_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,417),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs43_t := mj417;
SALT33.mac_select_best_matches(mjs43_t,rcid1,rcid2,o43);
mjs43 := o43 : PERSIST('~temp::proxid::BizLinkFull::mj::43',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:prim_range(13):city_clean(11):company_sic_code1(10) also :prim_range(13):city_clean(11):lname(10) also :prim_range(13):city_clean(11):company_phone_3(9) also :prim_range(13):city_clean(11):company_phone_3_ex(9) also :prim_range(13):city_clean(11):fname_preferred(9) also :prim_range(13):city_clean(11):mname(9) also :prim_range(13):city_clean(11):fname(8) also :prim_range(13):city_clean(11):name_suffix(8) also :prim_range(13):city_clean(11):cnp_lowv(5) also :prim_range(13):city_clean(11):st(5)
 
dn428 := hfile(~prim_range_isnull AND ~city_clean_isnull);
dn428_deduped := dn428(prim_range_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj428 := JOIN( dn428_deduped, dn428_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.city_clean = RIGHT.city_clean
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,428),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs44_t := mj428;
SALT33.mac_select_best_matches(mjs44_t,rcid1,rcid2,o44);
mjs44 := o44 : PERSIST('~temp::proxid::BizLinkFull::mj::44',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:prim_range(13):company_sic_code1(10):lname(10) also :prim_range(13):company_sic_code1(10):company_phone_3(9) also :prim_range(13):company_sic_code1(10):company_phone_3_ex(9) also :prim_range(13):company_sic_code1(10):fname_preferred(9) also :prim_range(13):company_sic_code1(10):mname(9) also :prim_range(13):company_sic_code1(10):fname(8) also :prim_range(13):company_sic_code1(10):name_suffix(8) also :prim_range(13):company_sic_code1(10):cnp_lowv(5) also :prim_range(13):company_sic_code1(10):st(5)
 
dn438 := hfile(~prim_range_isnull AND ~company_sic_code1_isnull);
dn438_deduped := dn438(prim_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj438 := JOIN( dn438_deduped, dn438_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,438),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs45_t := mj438;
SALT33.mac_select_best_matches(mjs45_t,rcid1,rcid2,o45);
mjs45 := o45 : PERSIST('~temp::proxid::BizLinkFull::mj::45',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:prim_range(13):lname(10):company_phone_3(9) also :prim_range(13):lname(10):company_phone_3_ex(9) also :prim_range(13):lname(10):fname_preferred(9) also :prim_range(13):lname(10):mname(9) also :prim_range(13):lname(10):fname(8) also :prim_range(13):lname(10):name_suffix(8) also :prim_range(13):lname(10):cnp_lowv(5) also :prim_range(13):lname(10):st(5)
 
dn447 := hfile(~prim_range_isnull AND ~lname_isnull);
dn447_deduped := dn447(prim_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj447 := JOIN( dn447_deduped, dn447_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.lname = RIGHT.lname
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,447),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs46_t := mj447;
SALT33.mac_select_best_matches(mjs46_t,rcid1,rcid2,o46);
mjs46 := o46 : PERSIST('~temp::proxid::BizLinkFull::mj::46',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:prim_range(13):company_phone_3(9):company_phone_3_ex(9) also :prim_range(13):company_phone_3(9):fname_preferred(9) also :prim_range(13):company_phone_3(9):mname(9) also :prim_range(13):company_phone_3(9):fname(8) also :prim_range(13):company_phone_3(9):name_suffix(8) also :prim_range(13):company_phone_3(9):cnp_lowv(5) also :prim_range(13):company_phone_3(9):st(5)
 
dn455 := hfile(~prim_range_isnull AND ~company_phone_3_isnull);
dn455_deduped := dn455(prim_range_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj455 := JOIN( dn455_deduped, dn455_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,455),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs47_t := mj455;
SALT33.mac_select_best_matches(mjs47_t,rcid1,rcid2,o47);
mjs47 := o47 : PERSIST('~temp::proxid::BizLinkFull::mj::47',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_range(13):company_phone_3_ex(9):fname_preferred(9) also :prim_range(13):company_phone_3_ex(9):mname(9) also :prim_range(13):company_phone_3_ex(9):fname(8) also :prim_range(13):company_phone_3_ex(9):name_suffix(8) also :prim_range(13):company_phone_3_ex(9):cnp_lowv(5) also :prim_range(13):company_phone_3_ex(9):st(5)
 
dn462 := hfile(~prim_range_isnull AND ~company_phone_3_ex_isnull);
dn462_deduped := dn462(prim_range_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj462 := JOIN( dn462_deduped, dn462_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,462),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs48_t := mj462;
SALT33.mac_select_best_matches(mjs48_t,rcid1,rcid2,o48);
mjs48 := o48 : PERSIST('~temp::proxid::BizLinkFull::mj::48',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_range(13):fname_preferred(9):mname(9) also :prim_range(13):fname_preferred(9):fname(8) also :prim_range(13):fname_preferred(9):name_suffix(8) also :prim_range(13):fname_preferred(9):cnp_lowv(5) also :prim_range(13):fname_preferred(9):st(5)
 
dn468 := hfile(~prim_range_isnull AND ~fname_preferred_isnull);
dn468_deduped := dn468(prim_range_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj468 := JOIN( dn468_deduped, dn468_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,468),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs49_t := mj468;
SALT33.mac_select_best_matches(mjs49_t,rcid1,rcid2,o49);
mjs49 := o49 : PERSIST('~temp::proxid::BizLinkFull::mj::49',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range(13):mname(9):fname(8) also :prim_range(13):mname(9):name_suffix(8) also :prim_range(13):mname(9):cnp_lowv(5) also :prim_range(13):mname(9):st(5)
 
dn473 := hfile(~prim_range_isnull AND ~mname_isnull);
dn473_deduped := dn473(prim_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj473 := JOIN( dn473_deduped, dn473_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.mname = RIGHT.mname
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,473),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_range(13):fname(8):name_suffix(8) also :prim_range(13):fname(8):cnp_lowv(5) also :prim_range(13):fname(8):st(5)
 
dn477 := hfile(~prim_range_isnull AND ~fname_isnull);
dn477_deduped := dn477(prim_range_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj477 := JOIN( dn477_deduped, dn477_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.fname = RIGHT.fname
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,477),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs50_t := mj473+mj477;
SALT33.mac_select_best_matches(mjs50_t,rcid1,rcid2,o50);
mjs50 := o50 : PERSIST('~temp::proxid::BizLinkFull::mj::50',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):name_suffix(8):cnp_lowv(5) also :prim_range(13):name_suffix(8):st(5)
 
dn480 := hfile(~prim_range_isnull AND ~name_suffix_isnull);
dn480_deduped := dn480(prim_range_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj480 := JOIN( dn480_deduped, dn480_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,480),HINT(unsorted_output),
    ATMOST(LEFT.prim_range = RIGHT.prim_range
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:sec_range(12):city(11):city_clean(11) also :sec_range(12):city(11):company_sic_code1(10) also :sec_range(12):city(11):lname(10) also :sec_range(12):city(11):company_phone_3(9) also :sec_range(12):city(11):company_phone_3_ex(9) also :sec_range(12):city(11):fname_preferred(9) also :sec_range(12):city(11):mname(9) also :sec_range(12):city(11):fname(8) also :sec_range(12):city(11):name_suffix(8) also :sec_range(12):city(11):cnp_lowv(5) also :sec_range(12):city(11):st(5)
 
dn482 := hfile(~sec_range_isnull AND ~city_isnull);
dn482_deduped := dn482(sec_range_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj482 := JOIN( dn482_deduped, dn482_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,482),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs51_t := mj480+mj482;
SALT33.mac_select_best_matches(mjs51_t,rcid1,rcid2,o51);
mjs51 := o51 : PERSIST('~temp::proxid::BizLinkFull::mj::51',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:sec_range(12):city_clean(11):company_sic_code1(10) also :sec_range(12):city_clean(11):lname(10) also :sec_range(12):city_clean(11):company_phone_3(9) also :sec_range(12):city_clean(11):company_phone_3_ex(9) also :sec_range(12):city_clean(11):fname_preferred(9) also :sec_range(12):city_clean(11):mname(9) also :sec_range(12):city_clean(11):fname(8) also :sec_range(12):city_clean(11):name_suffix(8) also :sec_range(12):city_clean(11):cnp_lowv(5) also :sec_range(12):city_clean(11):st(5)
 
dn493 := hfile(~sec_range_isnull AND ~city_clean_isnull);
dn493_deduped := dn493(sec_range_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj493 := JOIN( dn493_deduped, dn493_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,493),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs52_t := mj493;
SALT33.mac_select_best_matches(mjs52_t,rcid1,rcid2,o52);
mjs52 := o52 : PERSIST('~temp::proxid::BizLinkFull::mj::52',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:sec_range(12):company_sic_code1(10):lname(10) also :sec_range(12):company_sic_code1(10):company_phone_3(9) also :sec_range(12):company_sic_code1(10):company_phone_3_ex(9) also :sec_range(12):company_sic_code1(10):fname_preferred(9) also :sec_range(12):company_sic_code1(10):mname(9) also :sec_range(12):company_sic_code1(10):fname(8) also :sec_range(12):company_sic_code1(10):name_suffix(8) also :sec_range(12):company_sic_code1(10):cnp_lowv(5) also :sec_range(12):company_sic_code1(10):st(5)
 
dn503 := hfile(~sec_range_isnull AND ~company_sic_code1_isnull);
dn503_deduped := dn503(sec_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj503 := JOIN( dn503_deduped, dn503_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,503),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs53_t := mj503;
SALT33.mac_select_best_matches(mjs53_t,rcid1,rcid2,o53);
mjs53 := o53 : PERSIST('~temp::proxid::BizLinkFull::mj::53',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:sec_range(12):lname(10):company_phone_3(9) also :sec_range(12):lname(10):company_phone_3_ex(9) also :sec_range(12):lname(10):fname_preferred(9) also :sec_range(12):lname(10):mname(9) also :sec_range(12):lname(10):fname(8) also :sec_range(12):lname(10):name_suffix(8) also :sec_range(12):lname(10):cnp_lowv(5) also :sec_range(12):lname(10):st(5)
 
dn512 := hfile(~sec_range_isnull AND ~lname_isnull);
dn512_deduped := dn512(sec_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj512 := JOIN( dn512_deduped, dn512_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,512),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs54_t := mj512;
SALT33.mac_select_best_matches(mjs54_t,rcid1,rcid2,o54);
mjs54 := o54 : PERSIST('~temp::proxid::BizLinkFull::mj::54',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:sec_range(12):company_phone_3(9):company_phone_3_ex(9) also :sec_range(12):company_phone_3(9):fname_preferred(9) also :sec_range(12):company_phone_3(9):mname(9) also :sec_range(12):company_phone_3(9):fname(8) also :sec_range(12):company_phone_3(9):name_suffix(8) also :sec_range(12):company_phone_3(9):cnp_lowv(5) also :sec_range(12):company_phone_3(9):st(5)
 
dn520 := hfile(~sec_range_isnull AND ~company_phone_3_isnull);
dn520_deduped := dn520(sec_range_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj520 := JOIN( dn520_deduped, dn520_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,520),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs55_t := mj520;
SALT33.mac_select_best_matches(mjs55_t,rcid1,rcid2,o55);
mjs55 := o55 : PERSIST('~temp::proxid::BizLinkFull::mj::55',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:sec_range(12):company_phone_3_ex(9):fname_preferred(9) also :sec_range(12):company_phone_3_ex(9):mname(9) also :sec_range(12):company_phone_3_ex(9):fname(8) also :sec_range(12):company_phone_3_ex(9):name_suffix(8) also :sec_range(12):company_phone_3_ex(9):cnp_lowv(5) also :sec_range(12):company_phone_3_ex(9):st(5)
 
dn527 := hfile(~sec_range_isnull AND ~company_phone_3_ex_isnull);
dn527_deduped := dn527(sec_range_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj527 := JOIN( dn527_deduped, dn527_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,527),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs56_t := mj527;
SALT33.mac_select_best_matches(mjs56_t,rcid1,rcid2,o56);
mjs56 := o56 : PERSIST('~temp::proxid::BizLinkFull::mj::56',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:sec_range(12):fname_preferred(9):mname(9) also :sec_range(12):fname_preferred(9):fname(8) also :sec_range(12):fname_preferred(9):name_suffix(8) also :sec_range(12):fname_preferred(9):cnp_lowv(5) also :sec_range(12):fname_preferred(9):st(5)
 
dn533 := hfile(~sec_range_isnull AND ~fname_preferred_isnull);
dn533_deduped := dn533(sec_range_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj533 := JOIN( dn533_deduped, dn533_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,533),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs57_t := mj533;
SALT33.mac_select_best_matches(mjs57_t,rcid1,rcid2,o57);
mjs57 := o57 : PERSIST('~temp::proxid::BizLinkFull::mj::57',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:sec_range(12):mname(9):fname(8) also :sec_range(12):mname(9):name_suffix(8) also :sec_range(12):mname(9):cnp_lowv(5) also :sec_range(12):mname(9):st(5)
 
dn538 := hfile(~sec_range_isnull AND ~mname_isnull);
dn538_deduped := dn538(sec_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj538 := JOIN( dn538_deduped, dn538_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,538),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:sec_range(12):fname(8):name_suffix(8)
 
dn542 := hfile(~sec_range_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn542_deduped := dn542(sec_range_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj542 := JOIN( dn542_deduped, dn542_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,542),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs58_t := mj538+mj542;
SALT33.mac_select_best_matches(mjs58_t,rcid1,rcid2,o58);
mjs58 := o58 : PERSIST('~temp::proxid::BizLinkFull::mj::58',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:sec_range(12):fname(8):cnp_lowv(5):st(5) also :sec_range(12):fname(8):cnp_lowv(5):source(4)
 
dn543 := hfile(~sec_range_isnull AND ~fname_isnull AND ~cnp_lowv_isnull);
dn543_deduped := dn543(sec_range_weight100 + fname_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj543 := JOIN( dn543_deduped, dn543_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,543),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:sec_range(12):fname(8):st(5):source(4)
 
dn545 := hfile(~sec_range_isnull AND ~fname_isnull AND ~st_isnull AND ~source_isnull);
dn545_deduped := dn545(sec_range_weight100 + fname_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj545 := JOIN( dn545_deduped, dn545_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.fname = RIGHT.fname
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,545),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.fname = RIGHT.fname
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:sec_range(12):name_suffix(8):cnp_lowv(5):st(5) also :sec_range(12):name_suffix(8):cnp_lowv(5):source(4)
 
dn546 := hfile(~sec_range_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull);
dn546_deduped := dn546(sec_range_weight100 + name_suffix_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj546 := JOIN( dn546_deduped, dn546_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,546),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
mjs59_t := mj543+mj545+mj546;
SALT33.mac_select_best_matches(mjs59_t,rcid1,rcid2,o59);
mjs59 := o59 : PERSIST('~temp::proxid::BizLinkFull::mj::59',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:sec_range(12):name_suffix(8):st(5):source(4)
 
dn548 := hfile(~sec_range_isnull AND ~name_suffix_isnull AND ~st_isnull AND ~source_isnull);
dn548_deduped := dn548(sec_range_weight100 + name_suffix_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj548 := JOIN( dn548_deduped, dn548_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.sec_range = RIGHT.sec_range
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,548),HINT(unsorted_output),
    ATMOST(LEFT.sec_range = RIGHT.sec_range
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:city(11):city_clean(11):company_sic_code1(10) also :city(11):city_clean(11):lname(10) also :city(11):city_clean(11):company_phone_3(9) also :city(11):city_clean(11):company_phone_3_ex(9) also :city(11):city_clean(11):fname_preferred(9) also :city(11):city_clean(11):mname(9) also :city(11):city_clean(11):fname(8) also :city(11):city_clean(11):name_suffix(8) also :city(11):city_clean(11):cnp_lowv(5) also :city(11):city_clean(11):st(5)
 
dn549 := hfile(~city_isnull AND ~city_clean_isnull);
dn549_deduped := dn549(city_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj549 := JOIN( dn549_deduped, dn549_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.city_clean = RIGHT.city_clean
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,549),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs60_t := mj548+mj549;
SALT33.mac_select_best_matches(mjs60_t,rcid1,rcid2,o60);
mjs60 := o60 : PERSIST('~temp::proxid::BizLinkFull::mj::60',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:city(11):company_sic_code1(10):lname(10) also :city(11):company_sic_code1(10):company_phone_3(9) also :city(11):company_sic_code1(10):company_phone_3_ex(9) also :city(11):company_sic_code1(10):fname_preferred(9) also :city(11):company_sic_code1(10):mname(9) also :city(11):company_sic_code1(10):fname(8) also :city(11):company_sic_code1(10):name_suffix(8) also :city(11):company_sic_code1(10):cnp_lowv(5) also :city(11):company_sic_code1(10):st(5)
 
dn559 := hfile(~city_isnull AND ~company_sic_code1_isnull);
dn559_deduped := dn559(city_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj559 := JOIN( dn559_deduped, dn559_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,559),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs61_t := mj559;
SALT33.mac_select_best_matches(mjs61_t,rcid1,rcid2,o61);
mjs61 := o61 : PERSIST('~temp::proxid::BizLinkFull::mj::61',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:city(11):lname(10):company_phone_3(9) also :city(11):lname(10):company_phone_3_ex(9) also :city(11):lname(10):fname_preferred(9) also :city(11):lname(10):mname(9) also :city(11):lname(10):fname(8) also :city(11):lname(10):name_suffix(8) also :city(11):lname(10):cnp_lowv(5) also :city(11):lname(10):st(5)
 
dn568 := hfile(~city_isnull AND ~lname_isnull);
dn568_deduped := dn568(city_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj568 := JOIN( dn568_deduped, dn568_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,568),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs62_t := mj568;
SALT33.mac_select_best_matches(mjs62_t,rcid1,rcid2,o62);
mjs62 := o62 : PERSIST('~temp::proxid::BizLinkFull::mj::62',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city(11):company_phone_3(9):company_phone_3_ex(9)
 
dn576 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn576_deduped := dn576(city_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj576 := JOIN( dn576_deduped, dn576_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,576),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3(9):fname_preferred(9)
 
dn577 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn577_deduped := dn577(city_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj577 := JOIN( dn577_deduped, dn577_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,577),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3(9):mname(9)
 
dn578 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn578_deduped := dn578(city_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj578 := JOIN( dn578_deduped, dn578_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,578),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3(9):fname(8)
 
dn579 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn579_deduped := dn579(city_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj579 := JOIN( dn579_deduped, dn579_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,579),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3(9):name_suffix(8)
 
dn580 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn580_deduped := dn580(city_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj580 := JOIN( dn580_deduped, dn580_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,580),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs63_t := mj576+mj577+mj578+mj579+mj580;
SALT33.mac_select_best_matches(mjs63_t,rcid1,rcid2,o63);
mjs63 := o63 : PERSIST('~temp::proxid::BizLinkFull::mj::63',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city(11):company_phone_3(9):cnp_lowv(5):st(5) also :city(11):company_phone_3(9):cnp_lowv(5):source(4)
 
dn581 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull);
dn581_deduped := dn581(city_weight100 + company_phone_3_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj581 := JOIN( dn581_deduped, dn581_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,581),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3(9):st(5):source(4)
 
dn583 := hfile(~city_isnull AND ~company_phone_3_isnull AND ~st_isnull AND ~source_isnull);
dn583_deduped := dn583(city_weight100 + company_phone_3_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj583 := JOIN( dn583_deduped, dn583_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,583),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3_ex(9):fname_preferred(9)
 
dn584 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn584_deduped := dn584(city_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj584 := JOIN( dn584_deduped, dn584_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,584),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3_ex(9):mname(9)
 
dn585 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn585_deduped := dn585(city_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj585 := JOIN( dn585_deduped, dn585_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,585),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs64_t := mj581+mj583+mj584+mj585;
SALT33.mac_select_best_matches(mjs64_t,rcid1,rcid2,o64);
mjs64 := o64 : PERSIST('~temp::proxid::BizLinkFull::mj::64',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city(11):company_phone_3_ex(9):fname(8)
 
dn586 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn586_deduped := dn586(city_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj586 := JOIN( dn586_deduped, dn586_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,586),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3_ex(9):name_suffix(8)
 
dn587 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn587_deduped := dn587(city_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj587 := JOIN( dn587_deduped, dn587_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,587),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city(11):company_phone_3_ex(9):cnp_lowv(5):st(5) also :city(11):company_phone_3_ex(9):cnp_lowv(5):source(4)
 
dn588 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull);
dn588_deduped := dn588(city_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj588 := JOIN( dn588_deduped, dn588_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,588),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:city(11):company_phone_3_ex(9):st(5):source(4)
 
dn590 := hfile(~city_isnull AND ~company_phone_3_ex_isnull AND ~st_isnull AND ~source_isnull);
dn590_deduped := dn590(city_weight100 + company_phone_3_ex_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj590 := JOIN( dn590_deduped, dn590_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,590),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
mjs65_t := mj586+mj587+mj588+mj590;
SALT33.mac_select_best_matches(mjs65_t,rcid1,rcid2,o65);
mjs65 := o65 : PERSIST('~temp::proxid::BizLinkFull::mj::65',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city(11):fname_preferred(9):mname(9)
 
dn591 := hfile(~city_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn591_deduped := dn591(city_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj591 := JOIN( dn591_deduped, dn591_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,591),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:city(11):fname_preferred(9):fname(8)
 
dn592 := hfile(~city_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn592_deduped := dn592(city_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj592 := JOIN( dn592_deduped, dn592_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,592),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city(11):fname_preferred(9):name_suffix(8)
 
dn593 := hfile(~city_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn593_deduped := dn593(city_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj593 := JOIN( dn593_deduped, dn593_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,593),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city(11):fname_preferred(9):cnp_lowv(5):st(5) also :city(11):fname_preferred(9):cnp_lowv(5):source(4)
 
dn594 := hfile(~city_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull);
dn594_deduped := dn594(city_weight100 + fname_preferred_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj594 := JOIN( dn594_deduped, dn594_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,594),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
mjs66_t := mj591+mj592+mj593+mj594;
SALT33.mac_select_best_matches(mjs66_t,rcid1,rcid2,o66);
mjs66 := o66 : PERSIST('~temp::proxid::BizLinkFull::mj::66',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city(11):fname_preferred(9):st(5):source(4)
 
dn596 := hfile(~city_isnull AND ~fname_preferred_isnull AND ~st_isnull AND ~source_isnull);
dn596_deduped := dn596(city_weight100 + fname_preferred_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj596 := JOIN( dn596_deduped, dn596_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,596),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city(11):mname(9):fname(8)
 
dn597 := hfile(~city_isnull AND ~mname_isnull AND ~fname_isnull);
dn597_deduped := dn597(city_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj597 := JOIN( dn597_deduped, dn597_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,597),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city(11):mname(9):name_suffix(8)
 
dn598 := hfile(~city_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn598_deduped := dn598(city_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj598 := JOIN( dn598_deduped, dn598_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,598),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city(11):mname(9):cnp_lowv(5):st(5) also :city(11):mname(9):cnp_lowv(5):source(4)
 
dn599 := hfile(~city_isnull AND ~mname_isnull AND ~cnp_lowv_isnull);
dn599_deduped := dn599(city_weight100 + mname_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj599 := JOIN( dn599_deduped, dn599_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,599),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
mjs67_t := mj596+mj597+mj598+mj599;
SALT33.mac_select_best_matches(mjs67_t,rcid1,rcid2,o67);
mjs67 := o67 : PERSIST('~temp::proxid::BizLinkFull::mj::67',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city(11):mname(9):st(5):source(4)
 
dn601 := hfile(~city_isnull AND ~mname_isnull AND ~st_isnull AND ~source_isnull);
dn601_deduped := dn601(city_weight100 + mname_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj601 := JOIN( dn601_deduped, dn601_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.mname = RIGHT.mname
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,601),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.mname = RIGHT.mname
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city(11):fname(8):name_suffix(8)
 
dn602 := hfile(~city_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn602_deduped := dn602(city_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj602 := JOIN( dn602_deduped, dn602_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,602),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:city(11):fname(8):cnp_lowv(5):st(5)
 
dn603 := hfile(~city_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn603_deduped := dn603(city_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj603 := JOIN( dn603_deduped, dn603_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,603),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:city(11):name_suffix(8):cnp_lowv(5):st(5)
 
dn604 := hfile(~city_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn604_deduped := dn604(city_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj604 := JOIN( dn604_deduped, dn604_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,604),HINT(unsorted_output),
    ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:city_clean(11):company_sic_code1(10):lname(10) also :city_clean(11):company_sic_code1(10):company_phone_3(9) also :city_clean(11):company_sic_code1(10):company_phone_3_ex(9) also :city_clean(11):company_sic_code1(10):fname_preferred(9) also :city_clean(11):company_sic_code1(10):mname(9) also :city_clean(11):company_sic_code1(10):fname(8) also :city_clean(11):company_sic_code1(10):name_suffix(8) also :city_clean(11):company_sic_code1(10):cnp_lowv(5) also :city_clean(11):company_sic_code1(10):st(5)
 
dn605 := hfile(~city_clean_isnull AND ~company_sic_code1_isnull);
dn605_deduped := dn605(city_clean_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj605 := JOIN( dn605_deduped, dn605_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,605),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs68_t := mj601+mj602+mj603+mj604+mj605;
SALT33.mac_select_best_matches(mjs68_t,rcid1,rcid2,o68);
mjs68 := o68 : PERSIST('~temp::proxid::BizLinkFull::mj::68',EXPIRE(Config_BIP.PersistExpire));
 
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:city_clean(11):lname(10):company_phone_3(9) also :city_clean(11):lname(10):company_phone_3_ex(9) also :city_clean(11):lname(10):fname_preferred(9) also :city_clean(11):lname(10):mname(9) also :city_clean(11):lname(10):fname(8) also :city_clean(11):lname(10):name_suffix(8) also :city_clean(11):lname(10):cnp_lowv(5) also :city_clean(11):lname(10):st(5)
 
dn614 := hfile(~city_clean_isnull AND ~lname_isnull);
dn614_deduped := dn614(city_clean_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj614 := JOIN( dn614_deduped, dn614_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.lname = RIGHT.lname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,614),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs69_t := mj614;
SALT33.mac_select_best_matches(mjs69_t,rcid1,rcid2,o69);
mjs69 := o69 : PERSIST('~temp::proxid::BizLinkFull::mj::69',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city_clean(11):company_phone_3(9):company_phone_3_ex(9)
 
dn622 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn622_deduped := dn622(city_clean_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj622 := JOIN( dn622_deduped, dn622_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,622),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3(9):fname_preferred(9)
 
dn623 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn623_deduped := dn623(city_clean_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj623 := JOIN( dn623_deduped, dn623_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,623),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3(9):mname(9)
 
dn624 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn624_deduped := dn624(city_clean_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj624 := JOIN( dn624_deduped, dn624_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,624),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3(9):fname(8)
 
dn625 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn625_deduped := dn625(city_clean_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj625 := JOIN( dn625_deduped, dn625_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,625),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3(9):name_suffix(8)
 
dn626 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn626_deduped := dn626(city_clean_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj626 := JOIN( dn626_deduped, dn626_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,626),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs70_t := mj622+mj623+mj624+mj625+mj626;
SALT33.mac_select_best_matches(mjs70_t,rcid1,rcid2,o70);
mjs70 := o70 : PERSIST('~temp::proxid::BizLinkFull::mj::70',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city_clean(11):company_phone_3(9):cnp_lowv(5):st(5) also :city_clean(11):company_phone_3(9):cnp_lowv(5):source(4)
 
dn627 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull);
dn627_deduped := dn627(city_clean_weight100 + company_phone_3_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj627 := JOIN( dn627_deduped, dn627_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,627),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3(9):st(5):source(4)
 
dn629 := hfile(~city_clean_isnull AND ~company_phone_3_isnull AND ~st_isnull AND ~source_isnull);
dn629_deduped := dn629(city_clean_weight100 + company_phone_3_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj629 := JOIN( dn629_deduped, dn629_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,629),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):fname_preferred(9)
 
dn630 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn630_deduped := dn630(city_clean_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj630 := JOIN( dn630_deduped, dn630_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,630),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):mname(9)
 
dn631 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn631_deduped := dn631(city_clean_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj631 := JOIN( dn631_deduped, dn631_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,631),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs71_t := mj627+mj629+mj630+mj631;
SALT33.mac_select_best_matches(mjs71_t,rcid1,rcid2,o71);
mjs71 := o71 : PERSIST('~temp::proxid::BizLinkFull::mj::71',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):fname(8)
 
dn632 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn632_deduped := dn632(city_clean_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj632 := JOIN( dn632_deduped, dn632_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,632),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):name_suffix(8)
 
dn633 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn633_deduped := dn633(city_clean_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj633 := JOIN( dn633_deduped, dn633_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,633),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):cnp_lowv(5):st(5) also :city_clean(11):company_phone_3_ex(9):cnp_lowv(5):source(4)
 
dn634 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull);
dn634_deduped := dn634(city_clean_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj634 := JOIN( dn634_deduped, dn634_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,634),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):st(5):source(4)
 
dn636 := hfile(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~st_isnull AND ~source_isnull);
dn636_deduped := dn636(city_clean_weight100 + company_phone_3_ex_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj636 := JOIN( dn636_deduped, dn636_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,636),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
mjs72_t := mj632+mj633+mj634+mj636;
SALT33.mac_select_best_matches(mjs72_t,rcid1,rcid2,o72);
mjs72 := o72 : PERSIST('~temp::proxid::BizLinkFull::mj::72',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city_clean(11):fname_preferred(9):mname(9)
 
dn637 := hfile(~city_clean_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn637_deduped := dn637(city_clean_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj637 := JOIN( dn637_deduped, dn637_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,637),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:city_clean(11):fname_preferred(9):fname(8)
 
dn638 := hfile(~city_clean_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn638_deduped := dn638(city_clean_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj638 := JOIN( dn638_deduped, dn638_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,638),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city_clean(11):fname_preferred(9):name_suffix(8)
 
dn639 := hfile(~city_clean_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn639_deduped := dn639(city_clean_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj639 := JOIN( dn639_deduped, dn639_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,639),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city_clean(11):fname_preferred(9):cnp_lowv(5):st(5) also :city_clean(11):fname_preferred(9):cnp_lowv(5):source(4)
 
dn640 := hfile(~city_clean_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull);
dn640_deduped := dn640(city_clean_weight100 + fname_preferred_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj640 := JOIN( dn640_deduped, dn640_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,640),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
mjs73_t := mj637+mj638+mj639+mj640;
SALT33.mac_select_best_matches(mjs73_t,rcid1,rcid2,o73);
mjs73 := o73 : PERSIST('~temp::proxid::BizLinkFull::mj::73',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city_clean(11):fname_preferred(9):st(5):source(4)
 
dn642 := hfile(~city_clean_isnull AND ~fname_preferred_isnull AND ~st_isnull AND ~source_isnull);
dn642_deduped := dn642(city_clean_weight100 + fname_preferred_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj642 := JOIN( dn642_deduped, dn642_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,642),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city_clean(11):mname(9):fname(8)
 
dn643 := hfile(~city_clean_isnull AND ~mname_isnull AND ~fname_isnull);
dn643_deduped := dn643(city_clean_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj643 := JOIN( dn643_deduped, dn643_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,643),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:city_clean(11):mname(9):name_suffix(8)
 
dn644 := hfile(~city_clean_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn644_deduped := dn644(city_clean_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj644 := JOIN( dn644_deduped, dn644_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,644),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:city_clean(11):mname(9):cnp_lowv(5):st(5) also :city_clean(11):mname(9):cnp_lowv(5):source(4)
 
dn645 := hfile(~city_clean_isnull AND ~mname_isnull AND ~cnp_lowv_isnull);
dn645_deduped := dn645(city_clean_weight100 + mname_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj645 := JOIN( dn645_deduped, dn645_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,645),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
mjs74_t := mj642+mj643+mj644+mj645;
SALT33.mac_select_best_matches(mjs74_t,rcid1,rcid2,o74);
mjs74 := o74 : PERSIST('~temp::proxid::BizLinkFull::mj::74',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:city_clean(11):mname(9):st(5):source(4)
 
dn647 := hfile(~city_clean_isnull AND ~mname_isnull AND ~st_isnull AND ~source_isnull);
dn647_deduped := dn647(city_clean_weight100 + mname_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj647 := JOIN( dn647_deduped, dn647_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.mname = RIGHT.mname
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,647),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.mname = RIGHT.mname
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:city_clean(11):fname(8):name_suffix(8)
 
dn648 := hfile(~city_clean_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn648_deduped := dn648(city_clean_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj648 := JOIN( dn648_deduped, dn648_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,648),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:city_clean(11):fname(8):cnp_lowv(5):st(5)
 
dn649 := hfile(~city_clean_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn649_deduped := dn649(city_clean_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj649 := JOIN( dn649_deduped, dn649_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,649),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:city_clean(11):name_suffix(8):cnp_lowv(5):st(5)
 
dn650 := hfile(~city_clean_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn650_deduped := dn650(city_clean_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj650 := JOIN( dn650_deduped, dn650_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.city_clean = RIGHT.city_clean
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,650),HINT(unsorted_output),
    ATMOST(LEFT.city_clean = RIGHT.city_clean
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):company_phone_3(9)
 
dn651 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~company_phone_3_isnull);
dn651_deduped := dn651(company_sic_code1_weight100 + lname_weight100 + company_phone_3_weight100>=2600); // Use specificity to flag high-dup counts
mj651 := JOIN( dn651_deduped, dn651_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,651),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs75_t := mj647+mj648+mj649+mj650+mj651;
SALT33.mac_select_best_matches(mjs75_t,rcid1,rcid2,o75);
mjs75 := o75 : PERSIST('~temp::proxid::BizLinkFull::mj::75',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_sic_code1(10):lname(10):company_phone_3_ex(9)
 
dn652 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~company_phone_3_ex_isnull);
dn652_deduped := dn652(company_sic_code1_weight100 + lname_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj652 := JOIN( dn652_deduped, dn652_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,652),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):fname_preferred(9)
 
dn653 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~fname_preferred_isnull);
dn653_deduped := dn653(company_sic_code1_weight100 + lname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj653 := JOIN( dn653_deduped, dn653_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,653),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):mname(9)
 
dn654 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~mname_isnull);
dn654_deduped := dn654(company_sic_code1_weight100 + lname_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj654 := JOIN( dn654_deduped, dn654_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,654),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):fname(8)
 
dn655 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~fname_isnull);
dn655_deduped := dn655(company_sic_code1_weight100 + lname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj655 := JOIN( dn655_deduped, dn655_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,655),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):name_suffix(8)
 
dn656 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~name_suffix_isnull);
dn656_deduped := dn656(company_sic_code1_weight100 + lname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj656 := JOIN( dn656_deduped, dn656_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,656),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs76_t := mj652+mj653+mj654+mj655+mj656;
SALT33.mac_select_best_matches(mjs76_t,rcid1,rcid2,o76);
mjs76 := o76 : PERSIST('~temp::proxid::BizLinkFull::mj::76',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_sic_code1(10):lname(10):cnp_lowv(5):st(5) also :company_sic_code1(10):lname(10):cnp_lowv(5):source(4)
 
dn657 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~cnp_lowv_isnull);
dn657_deduped := dn657(company_sic_code1_weight100 + lname_weight100 + cnp_lowv_weight100>=2200); // Use specificity to flag high-dup counts
mj657 := JOIN( dn657_deduped, dn657_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,657),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):lname(10):st(5):source(4)
 
dn659 := hfile(~company_sic_code1_isnull AND ~lname_isnull AND ~st_isnull AND ~source_isnull);
dn659_deduped := dn659(company_sic_code1_weight100 + lname_weight100 + st_weight100 + source_weight100>=2600); // Use specificity to flag high-dup counts
mj659 := JOIN( dn659_deduped, dn659_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.lname = RIGHT.lname
    AND LEFT.st = RIGHT.st
    AND LEFT.source = RIGHT.source
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,659),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.lname = RIGHT.lname
      AND LEFT.st = RIGHT.st
      AND LEFT.source = RIGHT.source,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):company_phone_3_ex(9)
 
dn660 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn660_deduped := dn660(company_sic_code1_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj660 := JOIN( dn660_deduped, dn660_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,660),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):fname_preferred(9)
 
dn661 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn661_deduped := dn661(company_sic_code1_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj661 := JOIN( dn661_deduped, dn661_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,661),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs77_t := mj657+mj659+mj660+mj661;
SALT33.mac_select_best_matches(mjs77_t,rcid1,rcid2,o77);
mjs77 := o77 : PERSIST('~temp::proxid::BizLinkFull::mj::77',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):mname(9)
 
dn662 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn662_deduped := dn662(company_sic_code1_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj662 := JOIN( dn662_deduped, dn662_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,662),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):fname(8)
 
dn663 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn663_deduped := dn663(company_sic_code1_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj663 := JOIN( dn663_deduped, dn663_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,663),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):name_suffix(8)
 
dn664 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn664_deduped := dn664(company_sic_code1_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj664 := JOIN( dn664_deduped, dn664_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,664),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):cnp_lowv(5):st(5)
 
dn665 := hfile(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn665_deduped := dn665(company_sic_code1_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj665 := JOIN( dn665_deduped, dn665_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,665),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):fname_preferred(9)
 
dn666 := hfile(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn666_deduped := dn666(company_sic_code1_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj666 := JOIN( dn666_deduped, dn666_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,666),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs78_t := mj662+mj663+mj664+mj665+mj666;
SALT33.mac_select_best_matches(mjs78_t,rcid1,rcid2,o78);
mjs78 := o78 : PERSIST('~temp::proxid::BizLinkFull::mj::78',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):mname(9)
 
dn667 := hfile(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn667_deduped := dn667(company_sic_code1_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj667 := JOIN( dn667_deduped, dn667_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,667),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):fname(8)
 
dn668 := hfile(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn668_deduped := dn668(company_sic_code1_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj668 := JOIN( dn668_deduped, dn668_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,668),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):name_suffix(8)
 
dn669 := hfile(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn669_deduped := dn669(company_sic_code1_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj669 := JOIN( dn669_deduped, dn669_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,669),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):cnp_lowv(5):st(5)
 
dn670 := hfile(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn670_deduped := dn670(company_sic_code1_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj670 := JOIN( dn670_deduped, dn670_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,670),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):fname_preferred(9):mname(9)
 
dn671 := hfile(~company_sic_code1_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn671_deduped := dn671(company_sic_code1_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj671 := JOIN( dn671_deduped, dn671_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,671),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs79_t := mj667+mj668+mj669+mj670+mj671;
SALT33.mac_select_best_matches(mjs79_t,rcid1,rcid2,o79);
mjs79 := o79 : PERSIST('~temp::proxid::BizLinkFull::mj::79',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_sic_code1(10):fname_preferred(9):fname(8)
 
dn672 := hfile(~company_sic_code1_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn672_deduped := dn672(company_sic_code1_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj672 := JOIN( dn672_deduped, dn672_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,672),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):fname_preferred(9):name_suffix(8)
 
dn673 := hfile(~company_sic_code1_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn673_deduped := dn673(company_sic_code1_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj673 := JOIN( dn673_deduped, dn673_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,673),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):fname_preferred(9):cnp_lowv(5):st(5)
 
dn674 := hfile(~company_sic_code1_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn674_deduped := dn674(company_sic_code1_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj674 := JOIN( dn674_deduped, dn674_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,674),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):mname(9):fname(8)
 
dn675 := hfile(~company_sic_code1_isnull AND ~mname_isnull AND ~fname_isnull);
dn675_deduped := dn675(company_sic_code1_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj675 := JOIN( dn675_deduped, dn675_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,675),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):mname(9):name_suffix(8)
 
dn676 := hfile(~company_sic_code1_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn676_deduped := dn676(company_sic_code1_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj676 := JOIN( dn676_deduped, dn676_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,676),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs80_t := mj672+mj673+mj674+mj675+mj676;
SALT33.mac_select_best_matches(mjs80_t,rcid1,rcid2,o80);
mjs80 := o80 : PERSIST('~temp::proxid::BizLinkFull::mj::80',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_sic_code1(10):mname(9):cnp_lowv(5):st(5)
 
dn677 := hfile(~company_sic_code1_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn677_deduped := dn677(company_sic_code1_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj677 := JOIN( dn677_deduped, dn677_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,677),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):fname(8):name_suffix(8)
 
dn678 := hfile(~company_sic_code1_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn678_deduped := dn678(company_sic_code1_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj678 := JOIN( dn678_deduped, dn678_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,678),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):fname(8):cnp_lowv(5):st(5)
 
dn679 := hfile(~company_sic_code1_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn679_deduped := dn679(company_sic_code1_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj679 := JOIN( dn679_deduped, dn679_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,679),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_sic_code1(10):name_suffix(8):cnp_lowv(5):st(5)
 
dn680 := hfile(~company_sic_code1_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn680_deduped := dn680(company_sic_code1_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj680 := JOIN( dn680_deduped, dn680_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,680),HINT(unsorted_output),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3(9):company_phone_3_ex(9)
 
dn681 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn681_deduped := dn681(lname_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj681 := JOIN( dn681_deduped, dn681_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,681),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs81_t := mj677+mj678+mj679+mj680+mj681;
SALT33.mac_select_best_matches(mjs81_t,rcid1,rcid2,o81);
mjs81 := o81 : PERSIST('~temp::proxid::BizLinkFull::mj::81',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:lname(10):company_phone_3(9):fname_preferred(9)
 
dn682 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn682_deduped := dn682(lname_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj682 := JOIN( dn682_deduped, dn682_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,682),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3(9):mname(9)
 
dn683 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn683_deduped := dn683(lname_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj683 := JOIN( dn683_deduped, dn683_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,683),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3(9):fname(8)
 
dn684 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn684_deduped := dn684(lname_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj684 := JOIN( dn684_deduped, dn684_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,684),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3(9):name_suffix(8)
 
dn685 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn685_deduped := dn685(lname_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj685 := JOIN( dn685_deduped, dn685_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,685),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3(9):cnp_lowv(5):st(5)
 
dn686 := hfile(~lname_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn686_deduped := dn686(lname_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj686 := JOIN( dn686_deduped, dn686_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,686),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs82_t := mj682+mj683+mj684+mj685+mj686;
SALT33.mac_select_best_matches(mjs82_t,rcid1,rcid2,o82);
mjs82 := o82 : PERSIST('~temp::proxid::BizLinkFull::mj::82',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:lname(10):company_phone_3_ex(9):fname_preferred(9)
 
dn687 := hfile(~lname_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn687_deduped := dn687(lname_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj687 := JOIN( dn687_deduped, dn687_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,687),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3_ex(9):mname(9)
 
dn688 := hfile(~lname_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn688_deduped := dn688(lname_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj688 := JOIN( dn688_deduped, dn688_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,688),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3_ex(9):fname(8)
 
dn689 := hfile(~lname_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn689_deduped := dn689(lname_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj689 := JOIN( dn689_deduped, dn689_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,689),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3_ex(9):name_suffix(8)
 
dn690 := hfile(~lname_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn690_deduped := dn690(lname_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj690 := JOIN( dn690_deduped, dn690_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,690),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:lname(10):company_phone_3_ex(9):cnp_lowv(5):st(5)
 
dn691 := hfile(~lname_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn691_deduped := dn691(lname_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj691 := JOIN( dn691_deduped, dn691_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,691),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs83_t := mj687+mj688+mj689+mj690+mj691;
SALT33.mac_select_best_matches(mjs83_t,rcid1,rcid2,o83);
mjs83 := o83 : PERSIST('~temp::proxid::BizLinkFull::mj::83',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:lname(10):fname_preferred(9):mname(9)
 
dn692 := hfile(~lname_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn692_deduped := dn692(lname_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj692 := JOIN( dn692_deduped, dn692_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,692),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:lname(10):fname_preferred(9):fname(8)
 
dn693 := hfile(~lname_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn693_deduped := dn693(lname_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj693 := JOIN( dn693_deduped, dn693_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,693),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:lname(10):fname_preferred(9):name_suffix(8)
 
dn694 := hfile(~lname_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn694_deduped := dn694(lname_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj694 := JOIN( dn694_deduped, dn694_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,694),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:lname(10):fname_preferred(9):cnp_lowv(5):st(5)
 
dn695 := hfile(~lname_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn695_deduped := dn695(lname_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj695 := JOIN( dn695_deduped, dn695_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,695),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:lname(10):mname(9):fname(8)
 
dn696 := hfile(~lname_isnull AND ~mname_isnull AND ~fname_isnull);
dn696_deduped := dn696(lname_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj696 := JOIN( dn696_deduped, dn696_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,696),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs84_t := mj692+mj693+mj694+mj695+mj696;
SALT33.mac_select_best_matches(mjs84_t,rcid1,rcid2,o84);
mjs84 := o84 : PERSIST('~temp::proxid::BizLinkFull::mj::84',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:lname(10):mname(9):name_suffix(8)
 
dn697 := hfile(~lname_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn697_deduped := dn697(lname_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj697 := JOIN( dn697_deduped, dn697_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,697),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:lname(10):mname(9):cnp_lowv(5):st(5)
 
dn698 := hfile(~lname_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn698_deduped := dn698(lname_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj698 := JOIN( dn698_deduped, dn698_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,698),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:lname(10):fname(8):name_suffix(8)
 
dn699 := hfile(~lname_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn699_deduped := dn699(lname_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj699 := JOIN( dn699_deduped, dn699_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,699),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:lname(10):fname(8):cnp_lowv(5):st(5)
 
dn700 := hfile(~lname_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn700_deduped := dn700(lname_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj700 := JOIN( dn700_deduped, dn700_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,700),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:lname(10):name_suffix(8):cnp_lowv(5):st(5)
 
dn701 := hfile(~lname_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn701_deduped := dn701(lname_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj701 := JOIN( dn701_deduped, dn701_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.lname = RIGHT.lname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,701),HINT(unsorted_output),
    ATMOST(LEFT.lname = RIGHT.lname
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs85_t := mj697+mj698+mj699+mj700+mj701;
SALT33.mac_select_best_matches(mjs85_t,rcid1,rcid2,o85);
mjs85 := o85 : PERSIST('~temp::proxid::BizLinkFull::mj::85',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):fname_preferred(9)
 
dn702 := hfile(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn702_deduped := dn702(company_phone_3_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj702 := JOIN( dn702_deduped, dn702_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,702),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):mname(9)
 
dn703 := hfile(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn703_deduped := dn703(company_phone_3_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj703 := JOIN( dn703_deduped, dn703_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,703),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):fname(8)
 
dn704 := hfile(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn704_deduped := dn704(company_phone_3_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj704 := JOIN( dn704_deduped, dn704_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,704),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):name_suffix(8)
 
dn705 := hfile(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn705_deduped := dn705(company_phone_3_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj705 := JOIN( dn705_deduped, dn705_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,705),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):cnp_lowv(5):st(5)
 
dn706 := hfile(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn706_deduped := dn706(company_phone_3_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj706 := JOIN( dn706_deduped, dn706_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,706),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs86_t := mj702+mj703+mj704+mj705+mj706;
SALT33.mac_select_best_matches(mjs86_t,rcid1,rcid2,o86);
mjs86 := o86 : PERSIST('~temp::proxid::BizLinkFull::mj::86',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3(9):fname_preferred(9):mname(9)
 
dn707 := hfile(~company_phone_3_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn707_deduped := dn707(company_phone_3_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj707 := JOIN( dn707_deduped, dn707_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,707),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):fname_preferred(9):fname(8)
 
dn708 := hfile(~company_phone_3_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn708_deduped := dn708(company_phone_3_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj708 := JOIN( dn708_deduped, dn708_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,708),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):fname_preferred(9):name_suffix(8)
 
dn709 := hfile(~company_phone_3_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn709_deduped := dn709(company_phone_3_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj709 := JOIN( dn709_deduped, dn709_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,709),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):fname_preferred(9):cnp_lowv(5):st(5)
 
dn710 := hfile(~company_phone_3_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn710_deduped := dn710(company_phone_3_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj710 := JOIN( dn710_deduped, dn710_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,710),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):mname(9):fname(8)
 
dn711 := hfile(~company_phone_3_isnull AND ~mname_isnull AND ~fname_isnull);
dn711_deduped := dn711(company_phone_3_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj711 := JOIN( dn711_deduped, dn711_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,711),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs87_t := mj707+mj708+mj709+mj710+mj711;
SALT33.mac_select_best_matches(mjs87_t,rcid1,rcid2,o87);
mjs87 := o87 : PERSIST('~temp::proxid::BizLinkFull::mj::87',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3(9):mname(9):name_suffix(8)
 
dn712 := hfile(~company_phone_3_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn712_deduped := dn712(company_phone_3_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj712 := JOIN( dn712_deduped, dn712_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,712),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):mname(9):cnp_lowv(5):st(5)
 
dn713 := hfile(~company_phone_3_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn713_deduped := dn713(company_phone_3_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj713 := JOIN( dn713_deduped, dn713_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,713),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_phone_3(9):fname(8):name_suffix(8):cnp_lowv(5) also :company_phone_3(9):fname(8):name_suffix(8):st(5) also :company_phone_3(9):fname(8):name_suffix(8):source(4)
 
dn714 := hfile(~company_phone_3_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn714_deduped := dn714(company_phone_3_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj714 := JOIN( dn714_deduped, dn714_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,714),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs88_t := mj712+mj713+mj714;
SALT33.mac_select_best_matches(mjs88_t,rcid1,rcid2,o88);
mjs88 := o88 : PERSIST('~temp::proxid::BizLinkFull::mj::88',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3(9):fname(8):cnp_lowv(5):st(5)
 
dn717 := hfile(~company_phone_3_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn717_deduped := dn717(company_phone_3_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj717 := JOIN( dn717_deduped, dn717_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,717),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_phone_3(9):name_suffix(8):cnp_lowv(5):st(5)
 
dn718 := hfile(~company_phone_3_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn718_deduped := dn718(company_phone_3_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj718 := JOIN( dn718_deduped, dn718_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,718),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):fname_preferred(9):mname(9)
 
dn719 := hfile(~company_phone_3_ex_isnull AND ~fname_preferred_isnull AND ~mname_isnull);
dn719_deduped := dn719(company_phone_3_ex_weight100 + fname_preferred_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj719 := JOIN( dn719_deduped, dn719_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,719),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):fname_preferred(9):fname(8)
 
dn720 := hfile(~company_phone_3_ex_isnull AND ~fname_preferred_isnull AND ~fname_isnull);
dn720_deduped := dn720(company_phone_3_ex_weight100 + fname_preferred_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj720 := JOIN( dn720_deduped, dn720_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,720),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):fname_preferred(9):name_suffix(8)
 
dn721 := hfile(~company_phone_3_ex_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn721_deduped := dn721(company_phone_3_ex_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj721 := JOIN( dn721_deduped, dn721_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,721),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs89_t := mj717+mj718+mj719+mj720+mj721;
SALT33.mac_select_best_matches(mjs89_t,rcid1,rcid2,o89);
mjs89 := o89 : PERSIST('~temp::proxid::BizLinkFull::mj::89',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3_ex(9):fname_preferred(9):cnp_lowv(5):st(5)
 
dn722 := hfile(~company_phone_3_ex_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn722_deduped := dn722(company_phone_3_ex_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj722 := JOIN( dn722_deduped, dn722_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,722),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):mname(9):fname(8)
 
dn723 := hfile(~company_phone_3_ex_isnull AND ~mname_isnull AND ~fname_isnull);
dn723_deduped := dn723(company_phone_3_ex_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj723 := JOIN( dn723_deduped, dn723_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,723),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):mname(9):name_suffix(8)
 
dn724 := hfile(~company_phone_3_ex_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn724_deduped := dn724(company_phone_3_ex_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj724 := JOIN( dn724_deduped, dn724_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,724),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):mname(9):cnp_lowv(5):st(5)
 
dn725 := hfile(~company_phone_3_ex_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn725_deduped := dn725(company_phone_3_ex_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj725 := JOIN( dn725_deduped, dn725_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,725),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_phone_3_ex(9):fname(8):name_suffix(8):cnp_lowv(5) also :company_phone_3_ex(9):fname(8):name_suffix(8):st(5) also :company_phone_3_ex(9):fname(8):name_suffix(8):source(4)
 
dn726 := hfile(~company_phone_3_ex_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn726_deduped := dn726(company_phone_3_ex_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj726 := JOIN( dn726_deduped, dn726_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,726),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs90_t := mj722+mj723+mj724+mj725+mj726;
SALT33.mac_select_best_matches(mjs90_t,rcid1,rcid2,o90);
mjs90 := o90 : PERSIST('~temp::proxid::BizLinkFull::mj::90',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:company_phone_3_ex(9):fname(8):cnp_lowv(5):st(5)
 
dn729 := hfile(~company_phone_3_ex_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn729_deduped := dn729(company_phone_3_ex_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj729 := JOIN( dn729_deduped, dn729_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,729),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:company_phone_3_ex(9):name_suffix(8):cnp_lowv(5):st(5)
 
dn730 := hfile(~company_phone_3_ex_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn730_deduped := dn730(company_phone_3_ex_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj730 := JOIN( dn730_deduped, dn730_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,730),HINT(unsorted_output),
    ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:fname_preferred(9):mname(9):fname(8)
 
dn731 := hfile(~fname_preferred_isnull AND ~mname_isnull AND ~fname_isnull);
dn731_deduped := dn731(fname_preferred_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj731 := JOIN( dn731_deduped, dn731_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,731),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname,10000),HASH);
 
//Fixed fields ->:fname_preferred(9):mname(9):name_suffix(8)
 
dn732 := hfile(~fname_preferred_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn732_deduped := dn732(fname_preferred_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj732 := JOIN( dn732_deduped, dn732_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,732),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:fname_preferred(9):mname(9):cnp_lowv(5):st(5)
 
dn733 := hfile(~fname_preferred_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn733_deduped := dn733(fname_preferred_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj733 := JOIN( dn733_deduped, dn733_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.mname = RIGHT.mname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,733),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.mname = RIGHT.mname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs91_t := mj729+mj730+mj731+mj732+mj733;
SALT33.mac_select_best_matches(mjs91_t,rcid1,rcid2,o91);
mjs91 := o91 : PERSIST('~temp::proxid::BizLinkFull::mj::91',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:fname_preferred(9):fname(8):name_suffix(8):cnp_lowv(5) also :fname_preferred(9):fname(8):name_suffix(8):st(5) also :fname_preferred(9):fname(8):name_suffix(8):source(4)
 
dn734 := hfile(~fname_preferred_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn734_deduped := dn734(fname_preferred_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj734 := JOIN( dn734_deduped, dn734_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,734),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:fname_preferred(9):fname(8):cnp_lowv(5):st(5)
 
dn737 := hfile(~fname_preferred_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn737_deduped := dn737(fname_preferred_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj737 := JOIN( dn737_deduped, dn737_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,737),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:fname_preferred(9):name_suffix(8):cnp_lowv(5):st(5)
 
dn738 := hfile(~fname_preferred_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn738_deduped := dn738(fname_preferred_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj738 := JOIN( dn738_deduped, dn738_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,738),HINT(unsorted_output),
    ATMOST(LEFT.fname_preferred = RIGHT.fname_preferred
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs92_t := mj734+mj737+mj738;
SALT33.mac_select_best_matches(mjs92_t,rcid1,rcid2,o92);
mjs92 := o92 : PERSIST('~temp::proxid::BizLinkFull::mj::92',EXPIRE(Config_BIP.PersistExpire));
 
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:mname(9):fname(8):name_suffix(8):cnp_lowv(5) also :mname(9):fname(8):name_suffix(8):st(5) also :mname(9):fname(8):name_suffix(8):source(4)
 
dn739 := hfile(~mname_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn739_deduped := dn739(mname_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj739 := JOIN( dn739_deduped, dn739_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
    OR    LEFT.source = RIGHT.source AND ~LEFT.source_isnull
        )
    ,trans(LEFT,RIGHT,739),HINT(unsorted_output),
    ATMOST(LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
 
//Fixed fields ->:mname(9):fname(8):cnp_lowv(5):st(5)
 
dn742 := hfile(~mname_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn742_deduped := dn742(mname_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj742 := JOIN( dn742_deduped, dn742_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.mname = RIGHT.mname
    AND LEFT.fname = RIGHT.fname
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,742),HINT(unsorted_output),
    ATMOST(LEFT.mname = RIGHT.mname
      AND LEFT.fname = RIGHT.fname
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:mname(9):name_suffix(8):cnp_lowv(5):st(5)
 
dn743 := hfile(~mname_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn743_deduped := dn743(mname_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj743 := JOIN( dn743_deduped, dn743_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.mname = RIGHT.mname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,743),HINT(unsorted_output),
    ATMOST(LEFT.mname = RIGHT.mname
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
mjs93_t := mj739+mj742+mj743;
SALT33.mac_select_best_matches(mjs93_t,rcid1,rcid2,o93);
mjs93 := o93 : PERSIST('~temp::proxid::BizLinkFull::mj::93',EXPIRE(Config_BIP.PersistExpire));
 
//Fixed fields ->:fname(8):name_suffix(8):cnp_lowv(5):st(5)
 
dn744 := hfile(~fname_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn744_deduped := dn744(fname_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj744 := JOIN( dn744_deduped, dn744_deduped, LEFT.proxid > RIGHT.proxid
    AND LEFT.fname = RIGHT.fname
    AND LEFT.name_suffix = RIGHT.name_suffix
    AND LEFT.cnp_lowv = RIGHT.cnp_lowv
    AND LEFT.st = RIGHT.st
    AND SALT33.WithinEditNew(LEFT.prim_range,LEFT.prim_range_len,RIGHT.prim_range,RIGHT.prim_range_len,1, 0)
    ,trans(LEFT,RIGHT,744),HINT(unsorted_output),
    ATMOST(LEFT.fname = RIGHT.fname
      AND LEFT.name_suffix = RIGHT.name_suffix
      AND LEFT.cnp_lowv = RIGHT.cnp_lowv
      AND LEFT.st = RIGHT.st,10000),HASH);
last_mjs_t :=mj744;
SALT33.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs94 := o : PERSIST('~temp::proxid::BizLinkFull::mj::94',EXPIRE(Config_BIP.PersistExpire));
 
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11+ mjs12+ mjs13+ mjs14+ mjs15+ mjs16+ mjs17+ mjs18+ mjs19+ mjs20+ mjs21+ mjs22+ mjs23+ mjs24+ mjs25+ mjs26+ mjs27+ mjs28+ mjs29+ mjs30+ mjs31+ mjs32+ mjs33+ mjs34+ mjs35+ mjs36+ mjs37+ mjs38+ mjs39+ mjs40+ mjs41+ mjs42+ mjs43+ mjs44+ mjs45+ mjs46+ mjs47+ mjs48+ mjs49+ mjs50+ mjs51+ mjs52+ mjs53+ mjs54+ mjs55+ mjs56+ mjs57+ mjs58+ mjs59+ mjs60+ mjs61+ mjs62+ mjs63+ mjs64+ mjs65+ mjs66+ mjs67+ mjs68+ mjs69+ mjs70+ mjs71+ mjs72+ mjs73+ mjs74+ mjs75+ mjs76+ mjs77+ mjs78+ mjs79+ mjs80+ mjs81+ mjs82+ mjs83+ mjs84+ mjs85+ mjs86+ mjs87+ mjs88+ mjs89+ mjs90+ mjs91+ mjs92+ mjs93+ mjs94;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::proxid::BizLinkFull::all_m',EXPIRE(Config_BIP.PersistExpire)); // To by used by rcid and proxid
SALT33.mac_avoid_transitives(All_Matches,proxid1,proxid2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::proxid::BizLinkFull::mt',EXPIRE(Config_BIP.PersistExpire));
SALT33.mac_get_BestPerRecord( All_Matches,rcid1,proxid1,rcid2,proxid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::proxid::BizLinkFull::mr',EXPIRE(Config_BIP.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{proxid, InCluster := COUNT(GROUP)},proxid,LOCAL)(InCluster>1000); // proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.proxid=RIGHT.proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT33.mac_cluster_breadth(in_matches,rcid1,rcid2,proxid1,o);
SHARED in_matches1 := o;
missed_linkages := JOIN(in_matches1,Specificities(ih).ClusterSizes(InCluster>1),LEFT.proxid1=RIGHT.proxid,RIGHT ONLY);
missed_linkages1 := JOIN(h,missed_linkages,LEFT.proxid=RIGHT.proxid,TRANSFORM(RECORDOF(missed_linkages),SELF.proxid1:=RIGHT.proxid,SELF.rcid1:=LEFT.rcid,SELF:=RIGHT),SMART);
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.proxid1=RIGHT.proxid,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages1 : PERSIST('~temp::proxid::BizLinkFull::clu',EXPIRE(Config_BIP.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT33.UIDType rcid;  //Outcast
  SALT33.UIDType proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT33.UIDType Pref_rcid; // Prefers this record
  SALT33.UIDType Pref_proxid; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.proxid := le.proxid1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_proxid := ri.proxid2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.proxid=RIGHT.proxid1 AND LEFT.Pref_proxid=RIGHT.proxid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.proxid=RIGHT.proxid2 AND LEFT.Pref_proxid=RIGHT.proxid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.rcid=RIGHT.rcid,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config_BIP.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(proxid)),proxid,-Pref_Margin,LOCAL),proxid,LOCAL)) : PERSIST('~temp::proxid::BizLinkFull::Matches::ToSlice',EXPIRE(Config_BIP.PersistExpire));
// 1024x better in new place
  SALT33.MAC_Avoid_SliceOuts(PossibleMatches,proxid1,proxid2,proxid,Pref_proxid,ToSlice,m); // If proxid is slice target - don't use in match
  m1 := IF( Config_BIP.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::proxid::BizLinkFull::Matches::Matches',EXPIRE(Config_BIP.PersistExpire));
 
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
SHARED ih_thin := TABLE(ih_init,{rcid,proxid,seleid,orgid,ultid,powid});
  ut.MAC_Patch_Id(ih_thin,proxid,BasicMatch(ih).patch_file,proxid1,proxid2,ihbp); // Perform basic matches
  SALT33.MAC_SliceOut_ByRID(ihbp,rcid,proxid,ToSlice,rcid,sliced0); // Execute Sliceouts
  sliced := IF( Config_BIP.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  ut.MAC_Patch_Id(sliced,proxid,Matches,proxid1,proxid2,o); // Join Clusters
  Patchseleid := SALT33.MAC_ParentId_Patch(o,seleid,proxid);  // Collapse any seleid now joined by proxid
  Patchorgid := SALT33.MAC_ParentId_Patch(Patchseleid,orgid,seleid);  // Collapse any orgid now joined by seleid
  Patchultid := SALT33.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
SHARED Patched_Infile_thin := Patchultid : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,proxid,Matches,proxid1,proxid2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT33.UIDType rcid;
    SALT33.UIDType proxid_before;
    SALT33.UIDType proxid_after;
    SALT33.UIDType seleid_before;
    SALT33.UIDType seleid_after;
    SALT33.UIDType orgid_before;
    SALT33.UIDType orgid_after;
    SALT33.UIDType ultid_before;
    SALT33.UIDType ultid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.proxid_before := le.proxid;
    SELF.proxid_after := ri.proxid;
    SELF.seleid_before := le.seleid;
    SELF.seleid_after := ri.seleid;
    SELF.orgid_before := le.orgid;
    SELF.orgid_after := ri.orgid;
    SELF.ultid_before := le.ultid;
    SELF.ultid_after := ri.ultid;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.proxid<>RIGHT.proxid OR LEFT.seleid<>RIGHT.seleid OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BizLinkFull.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BizLinkFull.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;

